# تعريب نظام صيد السمك - HavanaRp Fisherman Translation

تم تعريب كامل لنظام صيد السمك في سيرفر HavanaRp بالعربية السعودية المفهومة،
سواء في الـ Overlay الذي يعمل على الكلاينت (JNI/C++) أو في سكربت السيرفر (Pawn).

## الملفات المعدّلة

### 1. `jni-overlay/` — تعريب الـ Overlay (C++ / ImGui)

ملفات الـ overlay المخصصة لصيد السمك. هذه الملفات تتوضع في الـ APK داخل المسار:

```
03_jni_native_sources/jni/jni/gui/fishermanoverlay.cpp
03_jni_native_sources/jni/jni/gui/fishermanoverlay.h
```

#### التعديلات الأساسية:

- **عنوان النافذة:** `havanafish.app  -  المارينا` → `تطبيق صيد هافانا  -  المارينا`
- **عنوان المتجر:** بقي `متجر صيد هافانا` (كان معرّب من قبل)
- **أيقونات صفوف الحالة:** الأحرف الإنجليزية المختصرة (L / B / R / W) عُربت
  إلى أحرفها العربية المعادلة (ر / ط / س / ش) للتناسق مع باقي الواجهة.
- **حرف أيقونة الكلاينت (C):** بات حرف `ك`.

> ملاحظة: باقي نصوص الـ overlay كانت معرّبة سابقاً (الرئيسية، المتجر، الرحلات،
> رخصة، طعم، سنارة، فلوس، شغل، إلخ.). تم الإبقاء عليها كما هي.

### 2. `pawn-scripts/` — تعريب سكربت السيرفر (Pawn)

#### `fisherman.inc` (وحدة نظام الصيد المتقدم)

**أ. أنواع الأسماك:**

| القديم          | الجديد          |
|----------------|----------------|
| Sardine        | سردين          |
| Mackerel       | إسقمري         |
| Sea Bass       | قاروص          |
| Red Snapper    | نجيل أحمر      |
| Tuna           | تونة           |
| Salmon         | سلمون          |
| Grouper        | هامور          |
| Swordfish      | أبو سيف        |
| Marlin         | مارلين         |
| Golden Tuna    | تونة ذهبية     |

**ب. أزرار الحوارات (Dialog buttons):**

| القديم       | الجديد   |
|------------|---------|
| Select     | اختر    |
| Exit       | خروج    |
| Buy        | شراء    |
| Back       | رجوع    |
| Rent       | إيجار   |
| Reel       | اسحب    |
| Cast       | رمي     |
| End        | إنهاء   |
| OK         | تمام    |
| Continue   | متابعة  |

**ج. رسائل النظام والتنبيهات:** كل رسالة `SendClientMessage`،
`GameTextForPlayer`، و `Fisherman_ShowMsg_` المتعلقة بالصيد عُرّبت.
نماذج:

- `You need a fishing license first.` → `تحتاج رخصة صيد أول.`
- `Buy a fishing rod first.` → `اشتري سنارة صيد أول.`
- `Buy bait first.` → `اشتري طعم أول.`
- `Out of bait.` → `خلص الطعم.`
- `Not enough money.` → `فلوسك ما تكفي.`
- `Invalid quantity.` → `العدد غير صحيح.`
- `You already have a rod.` → `عندك سنارة بالفعل.`
- `Fishing rod purchased.` → `تم شراء سنارة الصيد.`
- `Fishing license purchased for %d days.` → `تم شراء رخصة الصيد لمدة %d يوم.`
- `Bought %d bait(s). You now have %d.` → `اشتريت %d طعم. صار عندك %d.`
- `You need to be inside the red fishing zone.` → `لازم تكون داخل منطقة الصيد الحمراء.`
- `You need to be on (or within 10m of) your rented boat.` → `لازم تكون على القارب اللي مأجّره (أو على بعد 10 أمتار منه).`
- `Out of bait. Return to the fisherman to finish.` → `خلص الطعم. ارجع للصيّاد عشان تخلّص.`
- `Your boat is already at the dock.` → `قاربك موجود بالمارينا بالفعل.`
- `You need to start the fishing job at the fisherman first.` → `لازم تبدأ شغل الصيد عند الصيّاد أول.`
- `[Fishing] You entered the fishing zone. Tap CAST to fish.` → `[صيد] دخلت منطقة الصيد. اضغط (رمي السنارة) عشان تصيد.`
- `[Fishing] You left the fishing zone.` → `[صيد] طلعت من منطقة الصيد.`
- `[Fishing] Rent a boat at the marina and head to the red zone.` → `[صيد] أجّر قارب من المارينا وروح للمنطقة الحمراء.`
- `[Fishing] Boat rented (full fuel). Head to the red fishing zone.` → `[صيد] تم استئجار القارب (الخزان كامل). توجه للمنطقة الحمراء.`
- `[Fishing] You ended the day with %d fish and earned $%d. Nice haul!` → `[صيد] خلصت اليوم بـ %d سمكة وحوّشت $%d. صيد ممتاز!`
- `[Fishing] Job ended. No fish caught this session.` → `[صيد] خلص الشغل. ما طلع شي بهالجلسة.`

**د. نص GameText الكبير (شاشة نهاية الجولة):**

- `~y~FISHING DAY ENDED~n~~w~~h~%d FISH~n~~g~+$%d`
- → `~y~خلصت رحلة الصيد~n~~w~~h~%d سمكة~n~~g~+$%d`

#### `arabonline.pwn` (نظام الصيد المبسّط داخل الـ gamemode)

**أ. قائمة الأسماك في النظام المبسّط:**

| القديم      | الجديد       |
|-----------|-------------|
| Tuna       | تونة         |
| Salmon     | سلمون        |
| Trout      | تروتة        |
| Golden Fish | سمكة ذهبية  |
| Shark      | قرش          |

**ب. الرسائل المعرّبة في النظام المبسّط:** كانت بعض الترجمات السابقة
مكسرة لغوياً (مثل: `أنت سبق و الصيد!`)، فأعيدت صياغتها لعربية سعودية
صحيحة ومفهومة:

- `أنت سبق و الصيد!` → `أنت تصطاد بالفعل!`
- `لازم عند السلاح الرخصة.` → `تحتاج رخصة صيد أول.`
- `[الصيد] أنت أمسك %s ...` → `[صيد] اصطدت %s (الوزن: %d كجم) وربحت $%d!`
- وما شابه.

## ترميز الملفات (Encoding)

| الملف                                | الترميز  |
|--------------------------------------|---------|
| `fishermanoverlay.cpp` / `.h`        | UTF-8   |
| `fisherman.inc`                      | UTF-8   |
| `arabonline.pwn`                     | مختلط: Windows-1256 للنصوص الموجودة سابقاً، و UTF-8 للنصوص المضافة |

كلاينت HavanaRp المعدّل يدعم اكتشاف الترميز تلقائياً (انظر
`util/util.cpp` → `looks_like_utf8` و `looks_like_cp1256_arabic`).

## التجميع (Compilation)

تم تجميع `arabonline.pwn` بنجاح باستخدام `pawncc 3.10.10` (نسخة 64-بت
مبنية من المصدر). 0 أخطاء (`0 Errors`). الـ AMX الناتج تجده في
`../compiled/arabonline.amx`.

أمر التجميع المستخدم:

```bash
LD_LIBRARY_PATH=/path/to/pawncc/build \
  /path/to/pawncc -v0 -d3 -ipawno/include \
    gamemodes/arabonline.pwn -ogamemodes/arabonline.amx
```

## ما لم نلمسه ولماذا

- **بادئات بروتوكول الحوارات** (`HAVANA_FISH_SHOP`، `HAVANA_FISH_LIC`، `HAVANA_FISH_BAIT`،
  `HAVANA_FISH_ROD`، `HAVANA_FISH_BOAT`، `HAVANA_FISH_CAST`، `HAVANA_FISH_HUD`،
  `HAVANA_FISH_MSG`، `HAVANA_FISH_STATS`، `HAVANA_FISH_RESULT`): هذه ليست
  نصوص واجهة بل علامات بروتوكول يستخدمها الـ overlay لاعتراض الحوار وعرض
  الواجهة المخصصة بدلاً منه. تغييرها يكسر نظام الصيد بالكامل.
- **علامات نتائج الصيد** (`MISS|...`، `CATCH|...`، `TOTALS|...`): علامات
  بروتوكول داخلية بين السيرفر والـ overlay.
- **تعليقات وثائق `.h`/`.cpp` الإنجليزية:** هذه تعليقات تقنية للمطوّر،
  ولا تظهر للاعب — تركها بالإنجليزية هو الممارسة المتعارف عليها لكود C++.
- **أوامر debug `print()` في الكونسول:** للأدمن/المطوّر فقط، ليست نصوص واجهة.

## التحقق

- ✓ تجميع Pawn ناجح: `0 Errors` (16,389 تحذير، كلها تحذيرات تابات/تنسيق preexisting).
- ✓ فحص الصياغة C++: `g++ -fsyntax-only -std=c++14` يمر بنجاح على
  `fishermanoverlay.cpp` (مع كل الإنكلودات).
- ✓ ترميز UTF-8 صالح في كل ملفات النصوص الجديدة.

## التعليمات الإضافية للبناء النهائي

لإعادة بناء الـ `.so` الخاص بالكلاينت (`libluxury.so` أو `libSCAnd.so`)
يحتاج المستخدم Android NDK. بعد التثبيت:

```bash
cd 03_jni_native_sources/jni
ndk-build -j$(nproc)
```

ثم نسخ `obj/local/armeabi-v7a/libsamp.so` إلى مكانه في الـ APK وإعادة
توقيع الـ APK بـ `05_build_tools/build_apk.sh`.
