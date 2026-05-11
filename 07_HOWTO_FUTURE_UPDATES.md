# دليل تحديثات المستقبل — خطوة بخطوة

دليل عملي لكل سيناريو تحديث ممكن: إضافة سيارة جديدة، تعديل فيزياء سيارة موجودة، إعادة بناء APK، توقيع APK، حقن موديلات.

---

## السيناريو 1: تعديل سرعة/فيزياء سيارة موجودة

**مثال**: تريد رفع سرعة `car_camry` من 260 إلى 280.

### الخطوات
1. افتح `03_filterscripts_AND_assets/filterscripts/car_camry.pwn`
2. غيّر `#define CAMRY_MAX_SPEED 260.0` إلى `280.0`
3. اكومبايل:
   ```bash
   cd 05_pawncc_compiler
   LD_LIBRARY_PATH=. ./pawncc ../03_filterscripts_AND_assets/filterscripts/car_camry.pwn -i./include -d3 -O1 "-;+" "-(+"
   ```
4. ارفع `car_camry.amx` و `car_camry.pwn` على FTP `/filterscripts/`:
   ```bash
   lftp -u 'gs108396','Gs108396!Aa' ftp://51.210.223.180:21 -e "cd filterscripts; put car_camry.amx; put car_camry.pwn; bye"
   ```
5. على السيرفر في اللعبة:
   ```
   /rcon login o8q6bjxr
   /rcon reloadfs car_camry
   ```

> **تبقى ضبطات `handling.cfg`**: لو رفعت السرعة لقيمة أكبر من `MaxVelocity` في handling.cfg، السيرفر يدفع عبر SetVehicleVelocity لكن تحس قسوة قرب السقف. عدّل handling.cfg في `03_filterscripts_AND_assets/handling.cfg` ثم أعد بناء APK (راجع السيناريو 4).

---

## السيناريو 2: إضافة سيارة جديدة كاملة

**أمثلة سابقة**: BYD/Camry/Gentra2 — كل وحدة هي تطبيق نفس النمط.

### الخطوات
1. **حصول على .dff/.txd**:
   - من mod موجود: حمّل zip ومنه `<name>.dff` و `<name>.txd` (مثلاً `sultan.dff`).
   - الاسم يحدد الـslot (model ID). جدول الأسماء الشائعة:
     | basename | model ID |
     |----------|----------|
     | sultan | 560 |
     | sentinel | 405 |
     | cheetah | 415 |
     | admiral | 445 |
     | nebula | 516 |
     | stratum | 561 |
     | elegant | 507 |
     | feltzer | 533 |
     | ... | (راجع GTA SA modding wiki) |

2. **اختيار slot غير مستعمل**: تجنّب الـslots المستعملة حالياً:
   - 439 (stallion - Azelow)
   - 602 (alpha - Mercedes)
   - 415 (cheetah - Mercedes)
   - 445 (admiral - BYD)
   - 516 (nebula - Camry)
   - 560 (sultan - Gentra Tuning)

3. **نسخ ملف فلتر سكربت قالب**: انسخ أقرب ملف موجود:
   ```bash
   cp 03_filterscripts_AND_assets/filterscripts/car_camry.pwn 03_filterscripts_AND_assets/filterscripts/car_NEWCAR.pwn
   ```

4. **عدّل الثوابت في الـpwn** (search/replace):
   - `CAMRY_MODEL` → `NEWCAR_MODEL` ; القيمة = model ID الجديد (مثلاً 533 لـfeltzer)
   - `CAMRY_*` → `NEWCAR_*` (replaceAll)
   - `gCamry*` → `gNewCar*` (replaceAll)
   - `Camry*` → `NewCar*` (replaceAll في أسماء functions)
   - `IsCamry` → `IsNewCar`
   - `/camry` و `/spawncamry` و `CMD:camry` و `CMD:spawncamry` → جديد
   - عدّل ثوابت السرعة:
     - `MAX_SPEED` (km/h)
     - `THRUST` (0.045 خفيف، 0.080 متوسط، 0.120 قوي جدا)
     - `LATERAL_GRIP` (0.30 سيارة سبور، 0.50 سيدان، 0.70 SUV ثقيل)
     - `TURN_SOFT/HARD` (deg/sec — soft 11-15، hard 22-32)

5. **اكومبايل**:
   ```bash
   cd 05_pawncc_compiler
   LD_LIBRARY_PATH=. ./pawncc ../03_filterscripts_AND_assets/filterscripts/car_NEWCAR.pwn -i./include -d3 -O1 "-;+" "-(+"
   ```

6. **حدّث `server.cfg`**: أضف `car_NEWCAR` في نهاية سطر `filterscripts`:
   ```
   filterscripts inv_ui helmet vice ipdata bank_ui car_azelow car_mercedes car_cheetah car_byd car_camry car_gentra2 car_NEWCAR
   ```

7. **حدّث `handling.cfg`** (في مجلد APK template أيضاً):
   - ابحث عن سطر الـslot (مثلاً `^FELTZER\s+`)
   - عدّل `MaxVelocity` (~10 km/h فوق ال`MAX_SPEED` الذي تستهدفه)
   - عدّل `EngineAccel` (40-60 لتسارع قوي)
   - عدّل `TractionMultiplier` (0.85+ لـno-skid)

8. **حقن الموديل في `gta3.img`** (لو موجود لديك):
   ```bash
   cd 06_img_inject
   python3 inject_dff_txd.py --img /path/to/gta3.img --dff ../03_filterscripts_AND_assets/new_vehicle_models/NEWCAR.dff --txd ../03_filterscripts_AND_assets/new_vehicle_models/NEWCAR.txd
   ```

9. **ارفع كل شي على FTP**:
   ```bash
   lftp -u 'gs108396','Gs108396!Aa' ftp://51.210.223.180:21 -e "
   cd filterscripts; put car_NEWCAR.amx; put car_NEWCAR.pwn;
   cd /; put server.cfg;
   bye"
   ```

10. **توزيع gta3.img المحدّث على اللاعبين** (راجع السيناريو 5).

11. **إعادة بناء APK** لو غيّرت handling.cfg في الـAPK template (راجع السيناريو 4).

---

## السيناريو 3: حقن موديلات في gta3.img

```bash
cd 06_img_inject
python3 inject_dff_txd.py --img /path/to/gta3.img --dff <NAME>.dff --txd <NAME>.txd
```

السكربت يحقن DFF + TXD، ويرحّل entries قديمة لو لزم الأمر لتوفير directory slack. الناتج هو نفس ملف gta3.img (in-place modification — احفظ نسخة احتياطية قبل!).

---

## السيناريو 4: إعادة بناء APK + توقيع

> **تنبيه**: الـAPK نفسه ليس في هذا الـzip. لازم تجيبه من المسار الأصلي (Dropbox `luxury.zip` أو APK base).

### الخطوات
1. ضع APK المراد تعديلها (مثلاً `havana_v20.apk`) في مكان قابل للوصول.
2. فك الـAPK:
   ```bash
   java -jar 04_tools/apktool_2.10.0.jar d havana_v20.apk -o apk_workdir
   ```
3. عدّل ما تريد:
   - `apk_workdir/assets/data/handling.cfg` — انسخ من `03_filterscripts_AND_assets/handling.cfg`
   - `apk_workdir/assets/data/<vehicle>.dff/.txd` — انسخ من `03_filterscripts_AND_assets/new_vehicle_models/`
   - `apk_workdir/lib/*/lib*.so` — لو غيّرت JNI، ابن الـ.so من `01_jni_sources/` بـndk-build (راجع تعليقات داخل المجلد)
4. أعد بناء APK:
   ```bash
   java -jar 04_tools/apktool_2.10.0.jar b apk_workdir -o havana_v21_unsigned.apk
   ```
5. صفّ الـAPK:
   ```bash
   zipalign -v 4 havana_v21_unsigned.apk havana_v21_aligned.apk
   ```
6. وقّع الـAPK باستخدام keystore الموجود:
   ```bash
   apksigner sign \
     --ks 02_signing/havana.keystore \
     --ks-key-alias havana \
     --ks-pass pass:havana123 \
     --key-pass pass:havana123 \
     --v1-signing-enabled true \
     --v2-signing-enabled true \
     --v3-signing-enabled true \
     --out havana_v21.apk \
     havana_v21_aligned.apk
   ```
7. أو ببساطة استخدم `04_tools/build_apk.sh` (يعمل كل شي تلقائياً).

> **مهم جداً**: لو غيّرت الـkeystore أو الباسوردات، اللاعبين الحاليين ما رح يقدرون يحدّثون التطبيق ولازم يعيدون التثبيت من الصفر.

---

## السيناريو 5: توزيع gta3.img المحدّث على اللاعبين

عندك خياران:

### خيار A: عبر AzelowAssetCopier (ضمن APK)
- ضع `gta3.img` داخل `apk_workdir/assets/`.
- ارفع `AZELOW_PATCH_VERSION` في `01_jni_sources/jni/.../AzelowAssetCopier.cpp` إلى رقم أعلى.
- أعد بناء وتوقيع APK (السيناريو 4).
- عند تشغيل اللاعب التطبيق، النسخة الجديدة من gta3.img تُنسخ تلقائياً لـ:
  ```
  /storage/emulated/0/Android/data/com.havanarp.luxury/files/SAMP/gta3.img
  ```

### خيار B: عبر Dropbox (luxury.zip)
- ضغط `gta3.img` في `luxury.zip` (أو نفس اسم الـzip الذي استخدمته سابقاً).
- ارفع على Dropbox واحصل على رابط مباشر.
- اللاعبين يحمّلون الـzip ويفكونه يدوياً في:
  ```
  /storage/emulated/0/Android/data/com.havanarp.luxury/files/SAMP/
  ```

---

## السيناريو 6: تثبيت بيئة المطوّر على جهاز جديد

لو بدأت من جهاز Linux نظيف:

```bash
# الأدوات الأساسية
sudo apt update
sudo apt install -y openjdk-17-jdk lftp python3 zip unzip wget

# تأكد من pawncc يعمل (ELF64 binary)
cd 05_pawncc_compiler
file pawncc       # لازم يطلع: ELF 64-bit LSB
LD_LIBRARY_PATH=. ./pawncc -h  # اختبار

# اختبار apktool
java -jar 04_tools/apktool_2.10.0.jar -version

# اختبار apksigner (يأتي مع Android build-tools)
apksigner -version
```

---

## مرجع سريع — أوامر RCON المفيدة

```
/rcon login o8q6bjxr            # تسجيل دخول
/rcon reloadfs car_<name>       # إعادة تحميل filterscript بدون restart
/rcon loadfs car_<name>         # تحميل filterscript جديد
/rcon unloadfs car_<name>       # إيقاف filterscript
/rcon kick <playerid>           # طرد لاعب
/rcon say <message>             # رسالة عامة
```

---

## مرجع — منع وقوع الأخطاء الشائعة

| الخطأ | السبب | الحل |
|---|---|---|
| `pawncc: cannot execute binary file` | بيناري 32-bit في بيئة 64-bit أو العكس | استخدم `pawncc` المرفق (ELF64). |
| `Error opening libpawnc.so` | LD_LIBRARY_PATH غير محدد | ضع `LD_LIBRARY_PATH=. ` قبل أمر pawncc. |
| `IMG inject: no slack in directory` | gta3.img directory ممتلئ | السكربت يرحّل entry قديم تلقائياً، اعد المحاولة. |
| `INSTALL_PARSE_FAILED_NO_CERTIFICATES` عند تثبيت APK | APK غير موقّع | استخدم `04_tools/build_apk.sh`. |
| `INSTALL_FAILED_UPDATE_INCOMPATIBLE` | APK موقّع بـkeystore مختلف عن المثبّت | استخدم نفس `havana.keystore` دائماً. |
| السيارة لا تتسارع بعد reloadfs | اللاعب راكب قبل reload | اخرج من السيارة وادخل تاني. |
| handling.cfg لا تنفع | تُحمّل من الـAPK، مش من السيرفر | عدّل في APK template + إعادة بناء + توقيع. |
