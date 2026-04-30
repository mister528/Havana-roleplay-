.class public final Lcom/luxury/mobile/util/UpdateChecker;
.super Ljava/lang/Object;
.source "UpdateChecker.java"


# static fields
.field private static volatile cachedApkUrl:Ljava/lang/String;

.field private static volatile cachedChangelog:Ljava/lang/String;

.field private static volatile cachedVersionCode:I

.field private static volatile cachedVersionName:Ljava/lang/String;

.field public static volatile updateAvailable:Z

.field public static volatile updateRequired:Z


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static check(Landroid/app/Activity;Lorg/json/JSONObject;)V
    .locals 14

    const-string v0, ""

    if-eqz p0, :cond_b

    if-nez p1, :cond_0

    goto/16 :goto_8

    .line 118
    :cond_0
    :try_start_0
    invoke-static {p0}, Lcom/luxury/mobile/util/UpdateChecker;->currentVersionCode(Landroid/content/Context;)J

    move-result-wide v1

    .line 119
    invoke-static {p0}, Lcom/luxury/mobile/util/UpdateChecker;->currentVersionName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v3

    const-string v4, "version_code"

    const/4 v5, 0x0

    .line 120
    invoke-virtual {p1, v4, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v4

    const-string v6, "min_supported"

    .line 121
    invoke-virtual {p1, v6, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v6

    const-string v7, "apk_url"

    .line 122
    invoke-virtual {p1, v7, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    const-string v8, "version_name"

    .line 123
    invoke-virtual {p1, v8, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    const-string v9, "min_supported_name"

    .line 124
    invoke-virtual {p1, v9, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    const-string v10, "changelog"

    .line 125
    invoke-virtual {p1, v10, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sput-object v7, Lcom/luxury/mobile/util/UpdateChecker;->cachedApkUrl:Ljava/lang/String;

    sput-object v8, Lcom/luxury/mobile/util/UpdateChecker;->cachedVersionName:Ljava/lang/String;

    sput v4, Lcom/luxury/mobile/util/UpdateChecker;->cachedVersionCode:I

    sput-object p1, Lcom/luxury/mobile/util/UpdateChecker;->cachedChangelog:Ljava/lang/String;

    .line 132
    invoke-static {v7}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-eqz p1, :cond_1

    sput-boolean v5, Lcom/luxury/mobile/util/UpdateChecker;->updateRequired:Z

    sput-boolean v5, Lcom/luxury/mobile/util/UpdateChecker;->updateAvailable:Z

    return-void

    .line 138
    :cond_1
    invoke-static {v8}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    const/4 v0, 0x1

    if-nez p1, :cond_2

    invoke-static {v3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_2

    const/4 p1, 0x1

    goto :goto_0

    :cond_2
    const/4 p1, 0x0

    :goto_0
    const-wide/16 v10, 0x0

    if-eqz p1, :cond_7

    .line 142
    invoke-static {v8, v3}, Lcom/luxury/mobile/util/UpdateChecker;->compareSemver(Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    if-lez v7, :cond_3

    const/4 v7, 0x1

    goto :goto_1

    :cond_3
    const/4 v7, 0x0

    :goto_1
    cmp-long v8, v1, v10

    if-lez v8, :cond_5

    if-lez v4, :cond_5

    int-to-long v12, v4

    cmp-long v4, v12, v1

    if-ltz v4, :cond_4

    goto :goto_2

    :cond_4
    const/4 v4, 0x0

    goto :goto_3

    :cond_5
    :goto_2
    const/4 v4, 0x1

    :goto_3
    if-eqz v7, :cond_6

    if-eqz v4, :cond_6

    :goto_4
    const/4 v4, 0x1

    goto :goto_5

    :cond_6
    const/4 v4, 0x0

    goto :goto_5

    :cond_7
    cmp-long v7, v1, v10

    if-lez v7, :cond_6

    if-lez v4, :cond_6

    int-to-long v7, v4

    cmp-long v4, v1, v7

    if-gez v4, :cond_6

    goto :goto_4

    :goto_5
    if-eqz p1, :cond_8

    .line 153
    invoke-static {v9}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p1

    if-nez p1, :cond_8

    .line 154
    invoke-static {v3, v9}, Lcom/luxury/mobile/util/UpdateChecker;->compareSemver(Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    if-gez p1, :cond_9

    goto :goto_6

    :cond_8
    cmp-long p1, v1, v10

    if-lez p1, :cond_9

    if-lez v6, :cond_9

    int-to-long v6, v6

    cmp-long p1, v1, v6

    if-gez p1, :cond_9

    goto :goto_6

    :cond_9
    const/4 v0, 0x0

    :goto_6
    if-nez v4, :cond_a

    goto :goto_7

    :cond_a
    move v5, v0

    :goto_7
    sput-boolean v5, Lcom/luxury/mobile/util/UpdateChecker;->updateRequired:Z

    sput-boolean v4, Lcom/luxury/mobile/util/UpdateChecker;->updateAvailable:Z

    if-eqz v4, :cond_b

    .line 169
    invoke-static {p0, v5}, Lcom/luxury/mobile/util/UpdateChecker;->launch(Landroid/app/Activity;Z)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :cond_b
    :goto_8
    return-void
.end method

.method public static compareSemver(Ljava/lang/String;Ljava/lang/String;)I
    .locals 7

    const-string v0, ""

    if-nez p0, :cond_0

    move-object p0, v0

    goto :goto_0

    .line 79
    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object p0

    :goto_0
    if-nez p1, :cond_1

    goto :goto_1

    .line 80
    :cond_1
    invoke-virtual {p1}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    .line 81
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    const/4 v1, 0x0

    if-eqz p1, :cond_2

    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_2

    return v1

    .line 82
    :cond_2
    invoke-virtual {p0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    const/4 v2, -0x1

    if-eqz p1, :cond_3

    return v2

    .line 83
    :cond_3
    invoke-virtual {v0}, Ljava/lang/String;->isEmpty()Z

    move-result p1

    const/4 v3, 0x1

    if-eqz p1, :cond_4

    return v3

    :cond_4
    const-string p1, "\\."

    .line 84
    invoke-virtual {p0, p1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p0

    .line 85
    invoke-virtual {v0, p1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p1

    .line 86
    array-length v0, p0

    array-length v4, p1

    invoke-static {v0, v4}, Ljava/lang/Math;->max(II)I

    move-result v0

    const/4 v4, 0x0

    :goto_2
    if-ge v4, v0, :cond_9

    .line 88
    array-length v5, p0

    if-ge v4, v5, :cond_5

    aget-object v5, p0, v4

    invoke-static {v5}, Lcom/luxury/mobile/util/UpdateChecker;->leadingInt(Ljava/lang/String;)I

    move-result v5

    goto :goto_3

    :cond_5
    const/4 v5, 0x0

    .line 89
    :goto_3
    array-length v6, p1

    if-ge v4, v6, :cond_6

    aget-object v6, p1, v4

    invoke-static {v6}, Lcom/luxury/mobile/util/UpdateChecker;->leadingInt(Ljava/lang/String;)I

    move-result v6

    goto :goto_4

    :cond_6
    const/4 v6, 0x0

    :goto_4
    if-eq v5, v6, :cond_8

    if-ge v5, v6, :cond_7

    goto :goto_5

    :cond_7
    const/4 v2, 0x1

    :goto_5
    return v2

    :cond_8
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    :cond_9
    return v1
.end method

.method public static currentVersionCode(Landroid/content/Context;)J
    .locals 2

    .line 54
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    const/4 v1, 0x0

    invoke-virtual {v0, p0, v1}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 55
    invoke-virtual {p0}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    iget p0, p0, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    int-to-long v0, p0

    :goto_0
    return-wide v0

    :catchall_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method public static currentVersionName(Landroid/content/Context;)Ljava/lang/String;
    .locals 3

    const-string v0, ""

    .line 63
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object p0

    const/4 v2, 0x0

    invoke-virtual {v1, p0, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object p0

    .line 64
    iget-object v1, p0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Landroid/content/pm/PackageInfo;->versionName:Ljava/lang/String;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :goto_0
    return-object v0
.end method

.method private static launch(Landroid/app/Activity;Z)V
    .locals 2

    .line 184
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/luxury/mobile/gui/UpdateActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v1, "force"

    .line 185
    invoke-virtual {v0, v1, p1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    const-string p1, "apk_url"

    sget-object v1, Lcom/luxury/mobile/util/UpdateChecker;->cachedApkUrl:Ljava/lang/String;

    .line 186
    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "version_name"

    sget-object v1, Lcom/luxury/mobile/util/UpdateChecker;->cachedVersionName:Ljava/lang/String;

    .line 187
    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    const-string p1, "version_code"

    sget v1, Lcom/luxury/mobile/util/UpdateChecker;->cachedVersionCode:I

    .line 188
    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const-string p1, "changelog"

    sget-object v1, Lcom/luxury/mobile/util/UpdateChecker;->cachedChangelog:Ljava/lang/String;

    .line 189
    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Ljava/lang/String;)Landroid/content/Intent;

    .line 190
    invoke-virtual {p0, v0}, Landroid/app/Activity;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method

.method private static leadingInt(Ljava/lang/String;)I
    .locals 4

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return v0

    :cond_0
    const/4 v1, 0x0

    .line 98
    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 99
    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x30

    if-lt v2, v3, :cond_2

    const/16 v3, 0x39

    if-le v2, v3, :cond_1

    goto :goto_1

    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    :goto_1
    if-nez v1, :cond_3

    return v0

    .line 105
    :cond_3
    :try_start_0
    invoke-virtual {p0, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-static {p0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result p0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return p0

    :catch_0
    return v0
.end method

.method public static openManually(Landroid/app/Activity;)V
    .locals 1

    if-nez p0, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/luxury/mobile/util/UpdateChecker;->cachedApkUrl:Ljava/lang/String;

    .line 178
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    return-void

    :cond_1
    sget-boolean v0, Lcom/luxury/mobile/util/UpdateChecker;->updateRequired:Z

    .line 179
    invoke-static {p0, v0}, Lcom/luxury/mobile/util/UpdateChecker;->launch(Landroid/app/Activity;Z)V

    return-void
.end method
