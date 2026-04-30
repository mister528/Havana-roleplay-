.class public Lcom/luxury/mobile/core/Config;
.super Ljava/lang/Object;
.source "Config.java"


# static fields
.field public static final APP_PATH:Ljava/lang/String; = "storage/emulated/0/Android/data/com.luxury.mobile/files//"

.field public static final GAME_PATH:Ljava/lang/String; = "/storage/emulated/0/LuxuryMobile/"

.field public static PATH_DOWNLOADS:Ljava/lang/String; = null

.field public static final URL_CLIENT:Ljava/lang/String; = ""

.field public static final URL_DONATE:Ljava/lang/String; = ""

.field public static final URL_FILES:Ljava/lang/String; = ""

.field public static final URL_FILES_UPDATE:Ljava/lang/String; = ""


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 6
    const-string v0, "/storage/emulated/0/Android/data/com.luxury.mobile/files/temp_downloads//"

    sput-object v0, Lcom/luxury/mobile/core/Config;->PATH_DOWNLOADS:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
