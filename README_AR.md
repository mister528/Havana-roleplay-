# HavanaRp v20 — حزمة التطوير الكاملة (آخر تحديث)

ملف ZIP يحتوي على كل التعديلات + كل الأدوات المطلوبة لإجراء أي تحديث مستقبلي على السيرفر أو الـAPK، بدون الحاجة لـ`gta3.img` أو الـAPK المُجمّع (هذولاك أُنتجوا منفصلين ومرفوعون على FTP / Dropbox عند الحاجة).

---

## المحتوى — هيكل المجلدات

```
HavanaRp_v20_FINAL_pack/
├── README_AR.md                ← هذا الملف
├── 07_HOWTO_FUTURE_UPDATES.md  ← دليل خطوة بخطوة لأي تحديث جديد
│
├── 01_jni_sources/             ← المصدر الكامل للـJNI (.cpp/.h)
│   └── jni/
│       ├── gui/                ← الـoverlays (carshop, bank, helmet, …)
│       ├── jni/                ← الـcore (init, hooks, NvFOpen, IO redirect)
│       └── santrope-tea-gtasa/ ← الـSAMP/CLEO base (santrope-tea fork)
│
├── 02_signing/                 ← مفتاح التوقيع وكلمات السر
│   ├── havana.keystore         ← keystore الفعلي (احفظه!)
│   └── SIGNING_INFO.md         ← الباسوردات + الـalias + أوامر apksigner
│
├── 03_filterscripts_AND_assets/ ← كل ملفات السيرفر + موديلات السيارات
│   ├── server.cfg              ← أحدث نسخة (استلمت من FTP)
│   ├── handling.cfg            ← مع تعديلاتي على ALPHA/CHEETAH/ADMIRAL/NEBULA/SULTAN
│   ├── filterscripts/
│   │   ├── car_azelow.pwn / .amx  ← Daewoo Gentra Azelow (slot 439, 250 km/h)
│   │   ├── car_mercedes.pwn / .amx ← E63 AMG (slot 602, 280 km/h)
│   │   ├── car_cheetah.pwn / .amx  ← Mercedes (slot 415, 320 km/h)
│   │   ├── car_byd.pwn / .amx      ← BYD Destroyer 05 (slot 445, 210 km/h)
│   │   ├── car_camry.pwn / .amx    ← Toyota Camry (slot 516, 260 km/h, 0-200/7s)
│   │   └── car_gentra2.pwn / .amx  ← Gentra 511 Tuning (slot 560, 210 km/h, 0-150/5s)
│   └── new_vehicle_models/     ← .dff/.txd جاهزة للحقن في gta3.img
│       ├── admiral.dff/.txd    (BYD)
│       ├── alpha.dff/.txd      (Mercedes E63)
│       ├── cheetah.dff/.txd    (Mercedes الجديد بدل Ferrari)
│       ├── nebula.dff/.txd     (Camry XSE V6)
│       └── sultan.dff          (Gentra Tuning — لا يوجد .txd، اقرأ ملاحظة أدناه)
│
├── 04_tools/                   ← أدوات بناء/توقيع APK
│   ├── apktool_2.10.0.jar      ← فك/إعادة بناء APK
│   ├── build_apk.sh            ← يبني + يوقّع APK تلقائياً
│   └── extract_gta3img_from_apk.sh  ← يستخرج gta3.img من APK
│
├── 05_pawncc_compiler/         ← مترجم Pawn 64-bit جاهز (Linux ELF64)
│   ├── pawncc                  ← ELF64 binary
│   ├── libpawnc.so             ← shared library
│   └── include/                ← a_samp, a_sampdb, …
│
└── 06_img_inject/              ← أدوات حقن الموديلات في gta3.img
    ├── inject_dff_txd.py       ← Python script (يدعم relocate تلقائي)
    └── README_AR.md            ← شرح طريقة الاستخدام
```

---

## ملخّص أسطول السيارات الحالي

| Slot       | Model ID | الموديل المعروض            | Speed cap | تسارع/ميزة                     |
|------------|----------|-----------------------------|-----------|--------------------------------|
| stallion   | 439      | Daewoo Gentra Azelow        | 250 km/h  | Sedan متوازن                   |
| alpha      | 602      | Mercedes E63 AMG            | 280 km/h  | Smooth + قوي                   |
| cheetah    | 415      | Mercedes (الجديد بدل Ferrari) | 320 km/h | Cap عالي + lateral grip خفيف   |
| admiral    | 445      | BYD Destroyer 05             | 210 km/h  | Sedan قوي                      |
| nebula     | 516      | Toyota Camry XSE V6 3.5     | 260 km/h  | 0–200 في ~7s + lateral 0.50    |
| sultan     | 560      | Gentra 511 Tuning Uzbekistan | 210 km/h  | 0–150 في ~5s + lateral 0.70    |

---

## ⚠ ملاحظات مهمة

### 1) sultan.dff بدون .txd
الـmod الذي أرسلته لا يحتوي على ملف `sultan.txd` جاهز — فقط الموديل `sultan.dff` مع صورتي PNG (`txd/with aplha/511_txd.png` و `txd/without alpha/nomer511.png`). لو تريد التكستشر يظهر بشكل صحيح:
1. على Windows: حمّل **Magic.TXD** أو **TXD Workshop**.
2. على Android: حمّل **Mobile TXD Workshop**.
3. أنشئ ملف TXD يحوي تكستشر `511_txd` و `nomer511` (من PNGs المرفقة في الـzip الأصلي).
4. سمّ الملف `sultan.txd` وحقنه في `gta3.img` عبر `06_img_inject/inject_dff_txd.py`.

### 2) Keystore — لا تخسره
لو ضاع `havana.keystore`، Android سيرفض أي تحديث جديد للتطبيق ولازم اللاعبين يحذفون التطبيق ويعيدون التثبيت. **احفظ نسخة احتياطية في مكان آمن** (مثلاً Google Drive / iCloud / USB).

### 3) FTP credentials
- Host: `51.210.223.180`
- Port: 21
- User: `gs108396`
- Password: `Gs108396!Aa` (مخزّن في Devin secret `HAVANARP_FTP_PASSWORD`)

### 4) Server RCON password
- موجود في `server.cfg`: `o8q6bjxr`
- استخدمه في اللعبة: `/rcon login o8q6bjxr` ثم `/rcon reloadfs <name>`

---

## بدء سريع — تعديل سيارة موجودة

1. عدّل ملف الفلتر سكربت في `03_filterscripts_AND_assets/filterscripts/car_*.pwn`
2. اكومبايل:
   ```bash
   cd 05_pawncc_compiler
   LD_LIBRARY_PATH=. ./pawncc ../03_filterscripts_AND_assets/filterscripts/car_xxx.pwn -i./include -d3 -O1 "-;+" "-(+"
   ```
3. ارفع الـ`.amx` و `.pwn` على FTP في `/filterscripts/`.
4. على السيرفر (في اللعبة):
   ```
   /rcon login o8q6bjxr
   /rcon reloadfs car_xxx
   ```

## بدء سريع — إضافة سيارة جديدة كاملة

اقرأ `07_HOWTO_FUTURE_UPDATES.md` — فيه دليل خطوة بخطوة.

---

## ما تم تحديثه في هذا الـrelease

| المكوّن | التعديل |
|---|---|
| `car_cheetah.pwn` | فيزياء v3 — model-ID detection (يطبّق على أي CHEETAH) |
| `car_mercedes.pwn` | فيزياء v3 — model-ID detection |
| `car_byd.pwn` | جديد — Sedan 210 km/h |
| `car_camry.pwn` | جديد — Sedan 260 km/h, 0–200/7s |
| `car_gentra2.pwn` | جديد — Light tuning 210 km/h, 0–150/5s |
| `handling.cfg` | عدّلت ALPHA/CHEETAH/ADMIRAL/NEBULA/SULTAN |
| `server.cfg` | أضفت 4 filterscripts جديدة |
| `gta3.img` | حقنت 4 موديلات جديدة + Mercedes بدل Ferrari (في FTP، مش هنا) |

---

## للتواصل / المساعدة

أي مشكلة، استرجع المحادثة على [Devin session](https://app.devin.ai/) — كل خطوات التطوير مسجّلة هناك.
