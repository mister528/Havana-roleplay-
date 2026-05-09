# تثبيت سيارة Daewoo Gentra Azelow (ID 8000) — HavanaRp

كل الخطوات بالترتيب. لو وقفت في خطوة، رجع لها قبل ما تكمل.

---

## 1) المتطلبات

- ✅ pawncc 3.10.10 64-بت (موجود داخل `HavanaRp_release_v15/06_pawncc/`)
- ✅ بايثون 3 (لتشغيل `apply_patch.py`)
- ✅ `lftp` (لرفع الملفات على FTP)
- ✅ ملفات السيارة: `azelow.dff` و `azelow.txd` (موجودة في `patch_8000_azelow/data/`)
- 🔧 لو حابب تبني الـAPK من جديد: `apktool 2.10.0` + `zipalign` + `apksigner` (موجودين في `HavanaRp_release_v15/04_tools/`)
- 🔧 لو حابب تبني الـlauncher (`libsamp.so`) من جديد: Android NDK r17c

---

## 2) ملخص ما يحتويه الباتش

| الملف | الوظيفة |
|------|---------|
| `patch_8000_azelow/data/azelow.dff` + `.txd` | موديل وتكستشر السيارة (يدخلوا `gta3.img` أو IMG مخصص) |
| `patch_8000_azelow/snippets/vehicles.ide.snippet` | السطر اللي يدخل في `data/vehicles.ide` (ID = 8000) |
| `patch_8000_azelow/snippets/handling.cfg.snippet` | إعدادات الـhandling لـ`AZELOW` |
| `patch_8000_azelow/snippets/carcols.dat.snippet` | الألوان |
| `patch_8000_azelow/snippets/carmods.dat.snippet` | قطع التعديل في الموداشوب |
| `patch_8000_azelow/snippets/VehicleAudioData.ini.snippet` | الصوت + رفع `ToID_1` لـ19000 |
| `patch_8000_azelow/snippets/american.gxt.note.txt` | اسم السيارة في القائمة |
| `patch_8000_azelow/apply_patch.py` | يدمج كل الـsnippets دفعة واحدة بشكل آمن (idempotent) |
| `filterscripts/car_azelow.pwn` + `.amx` | فلتر سكربت يسبون السيارة في إل-إس + أوامر `/azelow` و `/spawnazelow` |
| `deploy/deploy_to_ftp.sh` | يرفع الفلتر سكربت + يعدل `server.cfg` |

---

## 3) خطوات التثبيت — جانب السيرفر (سهلة)

```bash
# 1) كومبايل كل شي (الجيم مود + الفلتر سكربت)
cd havanarp-vehicle-8000-azelow
bash build_all.sh

# 2) رفع على السيرفر + تعديل server.cfg
bash deploy/deploy_to_ftp.sh

# 3) في اللعبة، بصلاحيات RCON:
/rcon login <password>
/rcon loadfs car_azelow
```

سيارة الـ Azelow حتسبون في 3 نقاط حول معرض الأغنياء في رودیو (LS).
الأوامر داخل اللعبة:
- `/azelow` — تنقلك لأقرب Azelow.
- `/spawnazelow [color1] [color2]` — أدمن فقط، يسبون واحدة قدامك.

---

## 4) خطوات التثبيت — جانب العميل (الـAPK)

السيرفر بنفسه يقدر يبعت `CreateVehicle(8000, ...)` لأن اللانشر الحالي يستقبل
أي ID > 611 (الفحص في `netrpc.cpp` معطل أصلاً).
لكن عشان الموديل يظهر فعلاً للاعب، لازم ملفات GTA SA Mobile الخاصة فيه يكون
فيها `azelow.dff/.txd` معرفين. فيه ثلاث طرق:

### الطريقة A — توزيع باتش جانبي للاعبين (موصى بها)

اللاعبين يضيفون الملفات يدوياً على نسخة GTA SA Mobile الموجودة على جهازهم:

1. خذ `patch_8000_azelow/data/azelow.dff` و `.txd` وضيفهم على `gta3.img` باستخدام
   تطبيق مثل **Crazy IMG Editor** (PC) أو **IMG Tool** (Android).
2. شغل `apply_patch.py` على مجلد `data` الخاص بالـGTA SA install:
   ```bash
   python3 patch_8000_azelow/apply_patch.py /path/to/GTASA/data
   ```
3. السكربت يضيف:
   - السطر في `vehicles.ide` (ID 8000)
   - السطر في `handling.cfg`
   - الألوان في `carcols.dat`
   - قطع الموداشوب في `carmods.dat`
   - بلوك الصوت في `VehicleAudioData.ini` ويرفع `ToID_1` لـ19000

### الطريقة B — حقن الباتش مباشرة في `HavanaRp.apk`

(لو حابب توزع APK جاهز فيه السيارة):

1. فك الـAPK:
   ```bash
   cd HavanaRp_release_v15/03_apktool_template
   # apk_full/ هو الـtemplate المفكوك أصلاً، استخدمه مباشرة
   ```
2. شغل `apply_patch.py` على المسار `apk_full/assets/data` لو الباتش الكامل
   موجود هناك (افتراضياً الـAPK ما يحتوي vehicles.ide — قاعدة بيانات GTA SA
   نفسها هي اللي تحتوي عليها). لو ما هي موجودة، خلي الخطوة لاحقاً للاعب.
3. اضف `azelow.dff/.txd` لـIMG داخل الـAPK أو استبدل `assets/data/script/scriptv1.img`.
4. اعد بناء وتوقيع الـAPK:
   ```bash
   bash HavanaRp_release_v15/04_tools/build_apk.sh
   ```
   الناتج: `HavanaRp_release_v15/03_apktool_template/HavanaRp.apk` (موقع بنفس
   الـkeystore اللي في `02_signing/havana.keystore`).

### الطريقة C — Mod-Loader على جهاز اللاعب

استخدم تطبيق **Mod-Loader** (مثل CLEO Android أو ML Mod Loader) — حط ملفات
الباتش في مجلد `Mod Loader/azelow/` وراح يقرأها GTA تلقائياً بدون لمس IMG.

---

## 5) إعدادات اللانشر (`libsamp.so` / `libluxury.so`)

لو حابب تتأكد إن اللانشر يقبل ID 8000، شوف ملف
[`docs/LAUNCHER_PATCH.md`](LAUNCHER_PATCH.md) — اللانشر الحالي **بالفعل** يقبل
أي vehicle ID فوق 611، لأن الفحص اللي كان في `netrpc.cpp` سطر 830 معطل.
لو غير حابب تعدل أكثر، بإمكانك تضيف هوك `entity.cpp` يخلي الموديل يرسم بدل
الـrange الأصلي 400–611 — التفاصيل في الملف.

---

## 6) المراجع

- شرح pawno-info.ru الأصلي (روسي):
  https://pawno-info.ru/threads/dobavlenie-novyx-mashin-v-gta-san-andreas.325870/
- README الأصلي للمشروع: `HavanaRp_release_v15/README.md`
- توقيع الـAPK: `HavanaRp_release_v15/02_signing/SIGNING_INFO.md`
