#!/usr/bin/env python3
"""
inject_dff_txd.py — Replace one DFF and/or TXD entry inside a GTA SA gta3.img
file in-place (Version 2 IMG format only — i.e. mobile / SA Multiplayer).

Usage:
    python3 inject_dff_txd.py --img path/to/gta3.img \
        --dff path/to/sultan.dff \
        --txd path/to/sultan.txd

The DFF/TXD basenames MUST match the slot you want to override (e.g. for the
SULTAN slot use sultan.dff / sultan.txd). The script appends the new bytes to
the end of gta3.img and rewrites the directory entry so the engine reads the
new payload.

Notes:
  * gta3.img Version 2 ("VER2" header) is required. SA mobile uses this format.
  * All entries are 2048-byte aligned. The script handles padding automatically.
  * Use --backup to keep the original as gta3.img.bak.
  * Multiple replacements (more than one --dff/--txd) can be done by running
    the script repeatedly.
"""
import argparse
import os
import shutil
import struct
import sys

SECTOR = 2048
HEADER_FMT = "<4sI"   # "VER2" + entry count
# IMG v2 entry: offset(uint32 sectors), streaming_size(uint16 sectors),
#               archive_size(uint16 sectors), name(24 bytes)
ENTRY_FMT  = "<IHH24s"


def round_up(n: int, m: int) -> int:
    return ((n + m - 1) // m) * m


def read_directory(path: str):
    """Return (entry_count, [{'offset_s', 'size_s', 'name', 'index'}])."""
    with open(path, "rb") as f:
        magic, count = struct.unpack(HEADER_FMT, f.read(8))
        if magic != b"VER2":
            sys.exit(f"ERROR: not a Version-2 IMG (magic={magic!r}). "
                     "Use IMG Tool to convert first.")
        entries = []
        for i in range(count):
            f.seek(8 + i * 32)
            blob = f.read(32)
            offset_s, ssz, asz, raw = struct.unpack(ENTRY_FMT, blob)
            name = raw.split(b"\x00", 1)[0].decode("ascii", errors="replace")
            entries.append({"offset_s": offset_s, "size_s": ssz,
                            "archive_s": asz, "name": name, "index": i})
    return count, entries


def find_entry(entries, base_name: str):
    needle = base_name.lower()
    for e in entries:
        if e["name"].lower() == needle:
            return e
    return None


def append_payload(img_path: str, payload: bytes) -> int:
    """Append payload sector-aligned. Returns starting sector."""
    sz = os.path.getsize(img_path)
    aligned = round_up(sz, SECTOR)
    pad = aligned - sz
    with open(img_path, "ab") as f:
        if pad:
            f.write(b"\x00" * pad)
        start = f.tell() // SECTOR
        f.write(payload)
        # tail-pad to sector boundary
        rem = len(payload) % SECTOR
        if rem:
            f.write(b"\x00" * (SECTOR - rem))
    return start


def update_entry(img_path: str, idx: int, offset_s: int, size_s: int):
    """Patch only offset(uint32) + streaming_size(uint16) + archive_size(uint16).
    Leave the 24-byte name untouched."""
    with open(img_path, "r+b") as f:
        f.seek(8 + idx * 32)
        f.write(struct.pack("<IHH", offset_s, size_s, size_s))


def append_directory_entry(img_path: str, name: str, offset_s: int,
                           size_s: int) -> int:
    """Append a brand-new 32-byte directory entry (used when the slot's
    .txd is absent from the image, common on SA mobile)."""
    name_bytes = name.encode("ascii")
    if len(name_bytes) >= 24:
        sys.exit(f"ERROR: name '{name}' too long (max 23 chars)")
    name_padded = name_bytes + b"\x00" * (24 - len(name_bytes))

    with open(img_path, "r+b") as f:
        magic, count = struct.unpack(HEADER_FMT, f.read(8))
        # Refuse to expand if it would push past the first data sector.
        f.seek(0, 2)
        eof = f.tell()
        # Find min data offset
        min_offs = 10 ** 9
        for i in range(count):
            f.seek(8 + i * 32)
            blob = f.read(32)
            offs, ssz, asz, raw = struct.unpack(ENTRY_FMT, blob)
            if offs < min_offs:
                min_offs = offs
        new_dir_end = 8 + (count + 1) * 32
        if new_dir_end > min_offs * SECTOR:
            sys.exit("ERROR: no slack in directory — would need to shift "
                     "all data sectors. Use a real IMG editor instead.")

        new_index = count
        f.seek(8 + new_index * 32)
        f.write(struct.pack(ENTRY_FMT, offset_s, size_s, size_s, name_padded))
        f.seek(0)
        f.write(struct.pack(HEADER_FMT, magic, count + 1))
        return new_index


def replace_one(img_path: str, src_path: str, allow_create: bool = True):
    base = os.path.basename(src_path).lower()
    with open(src_path, "rb") as f:
        payload = f.read()
    size_s = round_up(len(payload), SECTOR) // SECTOR

    _, entries = read_directory(img_path)
    e = find_entry(entries, base)

    new_offset_s = append_payload(img_path, payload)
    if e:
        update_entry(img_path, e["index"], new_offset_s, size_s)
        print(f"  ✓ replace {base:18s} -> sector {new_offset_s} "
              f"({len(payload):,} bytes)")
    elif allow_create:
        idx = append_directory_entry(img_path, base, new_offset_s, size_s)
        print(f"  ✓ create  {base:18s} -> sector {new_offset_s} "
              f"({len(payload):,} bytes, new idx {idx})")
    else:
        sys.exit(f"ERROR: entry '{base}' not found in {img_path}.")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--img", required=True, help="path to gta3.img")
    ap.add_argument("--dff", help="path to <slot>.dff (basename must match slot)")
    ap.add_argument("--txd", help="path to <slot>.txd (basename must match slot)")
    ap.add_argument("--backup", action="store_true",
                    help="copy gta3.img -> gta3.img.bak before editing")
    args = ap.parse_args()

    if not args.dff and not args.txd:
        ap.error("must give at least one of --dff / --txd")
    if not os.path.isfile(args.img):
        sys.exit(f"ERROR: {args.img} not found")

    if args.backup:
        bak = args.img + ".bak"
        if os.path.exists(bak):
            print(f"  (backup {bak} already exists, skipping)")
        else:
            shutil.copy2(args.img, bak)
            print(f"  ✓ backup saved to {bak}")

    print(f"injecting into {args.img} ...")
    if args.dff:
        replace_one(args.img, args.dff)
    if args.txd:
        replace_one(args.img, args.txd)

    final = os.path.getsize(args.img)
    print(f"done. final gta3.img size: {final:,} bytes")


if __name__ == "__main__":
    main()
