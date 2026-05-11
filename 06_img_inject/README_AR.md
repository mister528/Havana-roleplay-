# دليل إضافة سيارة جديدة (Step-by-Step)

هذا الدليل يشرح كيف تضيف سيارة جديدة بالكامل (DFF/TXD + handling
+ سكربت سيرفر) للحزمة، حتى يحصل عليها كل لاعب يلعب نسخة الـAPK
الجديدة بدون أي إجراء يدوي.

> **مفهوم أساسي:**
> سامب 0.3.7-R2 لا يقبل أي vehicle ID خارج النطاق `400 .. 611`،
> فلازم نختار **موديل GTA SA موجود مسبقاً** ونستبدل DFF/TXD بتاعه
> داخل `gta3.img`. الأسماء الداخلية (`stallion.dff` مثلاً) تبقى
> نفسها — اللي يتغير فعلياً هو الهندسة والتكستشر.

---

## السيارة الحالية: Azelow على slot الـSTALLION (ID = 439)

في الإصدار الحالي:
- موديل GTA المُستبدَل: **STALLION (ID 439)**
- DFF/TXD البديلين: `azelow.dff` / `azelow.txd` (مُعاد تسميتهم
  لـ`stallion.dff`/`stallion.txd` داخل `gta3.img`).
- الفلتر سكربت يستخدم `CreateVehicle(439, ...)`.

---

## خطوات إضافة سيارة جديدة (مثلاً Audi RS6 على slot الـSULTAN)

### 1) اختر slot من سيارات GTA SA الأصلية

افتح `patch_8000_azelow/snippets/vehicles.ide.snippet` (أو الأصلي
في `apk_full/assets/data/script/...`) وحدد سيارة تستبدلها. مثال:

| اسم الموديل | ID  | حجمها التقريبي | ملاحظات                                |
|-------------|-----|------------------|------------------------------------------|
| STALLION    | 439 | كوبيه 2 باب     | محجوز للـAzelow                          |
| SULTAN      | 560 | سيدان 4 باب     | اختيار جيد لسيارات سيدان رياضية         |
| ELEGY       | 562 | سيدان 4 باب     | اختيار جيد للسيارات اليابانية الرياضية  |
| INFERNUS    | 411 | سوبر كار        | للسيارات السوبر فقط                      |
| TURISMO     | 451 | سوبر كار        | للسيارات السوبر فقط                      |

### 2) جهّز ملف DFF/TXD بأسماء slot الموديل

لو عندك `audi_rs6.dff` و `audi_rs6.txd` وتبي تستخدم slot الـSULTAN:

```bash
cp audi_rs6.dff sultan.dff
cp audi_rs6.txd sultan.txd
```

> الأسماء **لازم** تطابق slot الموديل اللي اخترته بالضبط
> (lowercase).

### 3) انسخ DFF/TXD لـAPK assets (لا حاجة لتعديل gta3.img محلياً)

```bash
cp sultan.dff 03_apktool_template/apk_full/assets/data/sultan.dff
cp sultan.txd 03_apktool_template/apk_full/assets/data/sultan.txd
```

اللانشر سيحقن هذي الـ2 ملفات تلقائياً داخل gta3.img الموجود
مسبقاً على جهاز اللاعب (الذي تم تحميله مع luxury.zip من Dropbox)
باستخدام آلية الحقن المُضمَّنة في
`01_jni_sources/jni/jni/AzelowAssetCopier.cpp`.

> **مهم:** لو ضفت سيارة على slot جديد (مش STALLION) لازم تعدّل
> دالة `AzelowEnsureAssetsInstalled` في
> `AzelowAssetCopier.cpp` لإضافة `PatchSlot()` للسلوت الجديد:
> ```cpp
> bool c = PatchSlot(img, mgr, "sultan.dff", "data/sultan.dff");
> bool d = PatchSlot(img, mgr, "sultan.txd", "data/sultan.txd");
> ```

> **بديل (للتطوير المحلي فقط):** لو تبي تعدّل gta3.img
> الموجود محلياً للاختبار قبل بناء APK، استخدم:
> ```bash
> python3 09_add_new_vehicle/scripts/inject_dff_txd.py \
>     --img path/to/local/gta3.img \
>     --dff sultan.dff --txd sultan.txd
> ```

### 4) (اختياري) عدّل handling للسيارة

افتح `03_apktool_template/apk_full/assets/data/handling.cfg` وعدّل
السطر اللي يبدأ بـ`SULTAN` (أو الـslot اللي اخترته) بنفس
طريقة سطر `STALLION` (الذي رفعنا له `MaxVelocity=240` و
`EngineAcceleration=50`).

> هذا الملف يُحمَّل تلقائياً عبر hook في `hooks.cpp` من
> `<storage>/SAMP/handling.cfg`، والـAzelowAssetCopier ينقله
> من APK إلى storage على أول تشغيل.

### 5) أعد بناء libsamp.so

```bash
cd 01_jni_sources/jni
/path/to/android-ndk-r17c/ndk-build -j4 NDK_DEBUG=0
cp libs/armeabi-v7a/libsamp.so \
   ../../03_apktool_template/apk_full/lib/armeabi-v7a/libluxury.so
```

> ⚠️ لو ضفت سيارات جديدة بدون تغيير كود `hooks.cpp` أو
> `AzelowAssetCopier.cpp`، **مش لازم** تعيد بناء الـ.so.
> يكفي تعديل gta3.img وhandling.cfg.

### 6) تأكد إن DFF/TXD/cfg في APK assets

```
03_apktool_template/apk_full/assets/data/<slot>.dff
03_apktool_template/apk_full/assets/data/<slot>.txd
03_apktool_template/apk_full/assets/data/handling.cfg
```

> هذي اللي تُحقَن/تُنسَخ تلقائياً للاعب على أول تشغيل.
> **لا تنسخ gta3.img كاملاً داخل APK** — نضمّن فقط DFF/TXD
> الجديدة (~10 MB لكل سيارة) ونعتمد على gta3.img الموجود في
> luxury.zip كأساس.

### 7) ارفع رقم الباتش لتفعيل النشر التلقائي

افتح `01_jni_sources/jni/jni/AzelowAssetCopier.cpp` وعدّل:

```cpp
#define AZELOW_PATCH_VERSION "v2"   // → غيّرها لـ"v3", "v4" ...
```

عند رفع رقم الإصدار، سيعيد اللانشر النسخ على أول تشغيل بعد
التحديث (لأن marker file يحمل الإصدار القديم لن يطابق الإصدار
الجديد).

### 8) أعد بناء ووقّع APK

```bash
bash 04_tools/build_apk.sh
```

الناتج في `03_apktool_template/HavanaRp.apk` (موقّع جاهز للنشر).

### 9) ضف السيارة لسكربت السيرفر

في `05_server/filterscripts/car_azelow.pwn` (أو أنشئ
`car_<اسم سيارتك>.pwn` جديد بنفس البنية):

```pawn
new vid = CreateVehicle(560, x, y, z, angle, color1, color2, 600); // 560 = SULTAN slot
```

ثم كومبايل:
```bash
06_pawncc/pawncc filterscripts/car_audirs6.pwn -;+ -(+ -d3
```

أو استخدم سكربت بناء الفلترات:
```bash
bash 07_build_amx.sh
```

### 10) ارفع الفلتر سكربت لـFTP

```bash
bash deploy/deploy_to_ftp.sh
```

---

## فحص سريع: هل التحديث وصل اللاعبين؟

اللاعب يفتح اللعبة → اللانشر يطلق `InitSAMP`:
1. يفحص `<storage>/SAMP/.azelow_v1.installed` (marker)
2. لو غير موجود → ينسخ `assets/data/gta3.img` و
   `assets/data/handling.cfg` من APK إلى
   `<storage>/SAMP/`
3. يضع marker
4. لما اللعبة تطلب `MODELS/GTA3.IMG` أو `DATA/HANDLING.CFG`،
   الـhook في `hooks.cpp` يحوّلها للنسخة المُعدلة

شوف logcat:
```bash
adb logcat -s AzelowAssetCopier
```

---

## استكشاف الأخطاء

| المشكلة                                    | السبب المحتمل                            | الحل                                                             |
|--------------------------------------------|------------------------------------------|------------------------------------------------------------------|
| `/spawnazelow` يطلع لكن السيارة عادية     | اللانشر ما نسخ gta3.img                  | امسح `<storage>/SAMP/.azelow_*.installed` ثم أعد فتح اللعبة     |
| السيارة بدون textures (بيضاء/شفافة)        | TXD مش متطابق مع DFF أو slot غلط         | تأكد إن DFF/TXD لنفس الموديل، وأسماؤهم تطابق slot الأصلي         |
| السيرفر يرفض `CreateVehicle`               | ID خارج 400-611                          | استخدم slot موجود فعلاً (راجع جدول السيارات أعلاه)                |
| اللعبة تتعطل عند سبون السيارة             | DFF كبير جداً أو ملف فاسد               | تأكد إن DFF أقل من 10MB وافحصه بـIMG Tool أولاً                  |
| handling.cfg مش يطبق                       | الـhook معطّل أو الملف ما اتنسخ         | تأكد إن `DATA/HANDLING.CFG` redirect مفعّل في `hooks.cpp:295`    |

---

## ملاحظات مهمة

- **داخل gta3.img، الأسماء case-insensitive** (سامب يتعامل معاهم
  بـuppercase داخلياً).
- **gta3.img كل ما يكبر، APK يكبر معه** — حالياً ~299MB، يخلي
  حجم APK ~353MB. لا تتجاوز 400MB لتفادي مشاكل تثبيت Android.
- **اللاعب يحتاج صلاحية Storage** للنسخ الأولي يشتغل. اللانشر
  أصلاً يطلبها.
- **خرافة شائعة:** ID 8000+ ما يشتغل على سيرفر سامب 0.3.7
  بأي طريقة. الـPlugins اللي تدّعي ذلك (مثل "SA-MP More Models")
  بس للـSingleplayer.

---

## ملخص في نقطة وحدة

> **لو تبي تضيف سيارة جديدة في المستقبل:**
>
> 1. حضّر `<اسم_slot>.dff` و `<اسم_slot>.txd`
> 2. شغّل `inject_dff_txd.py` على gta3.img داخل APK assets
> 3. عدّل سطر السيارة في handling.cfg
> 4. ارفع `AZELOW_PATCH_VERSION` لـ`"v2"` (أو غيره)
> 5. أعد بناء libsamp.so + APK
> 6. أضف الكود في filterscripts/ + كومبايل
> 7. ارفع للـFTP
>
> النتيجة: كل لاعب يحدّث APK يحصل على السيارة الجديدة تلقائياً.
