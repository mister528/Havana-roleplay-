.class public Lcom/nvidia/devtech/NvUtil;
.super Ljava/lang/Object;
.source "NvUtil.java"


# static fields
.field private static instance:Lcom/nvidia/devtech/NvUtil;


# instance fields
.field private activity:Landroid/app/Activity;

.field private appLocalValues:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 41
    new-instance v0, Lcom/nvidia/devtech/NvUtil;

    invoke-direct {v0}, Lcom/nvidia/devtech/NvUtil;-><init>()V

    sput-object v0, Lcom/nvidia/devtech/NvUtil;->instance:Lcom/nvidia/devtech/NvUtil;

    return-void
.end method

.method private constructor <init>()V
    .locals 3

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/NvUtil;->activity:Landroid/app/Activity;

    .line 46
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/nvidia/devtech/NvUtil;->appLocalValues:Ljava/util/HashMap;

    .line 47
    nop

    .line 48
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    .line 47
    const-string v2, "STORAGE_ROOT"

    invoke-virtual {v0, v2, v1}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 49
    return-void
.end method

.method public static getInstance()Lcom/nvidia/devtech/NvUtil;
    .locals 1

    .line 89
    sget-object v0, Lcom/nvidia/devtech/NvUtil;->instance:Lcom/nvidia/devtech/NvUtil;

    return-object v0
.end method


# virtual methods
.method public appendLog(Ljava/lang/String;)V
    .locals 5
    .param p1, "text"    # Ljava/lang/String;

    .line 53
    const-string v0, "STORAGE_ROOT"

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvUtil;->getAppLocalValue(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 54
    .local v0, "path":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "SAMP/javalog.txt"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 55
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 56
    .local v1, "logFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 60
    :try_start_0
    invoke-virtual {v1}, Ljava/io/File;->createNewFile()Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 66
    goto :goto_0

    .line 62
    :catch_0
    move-exception v2

    .line 65
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 71
    .end local v2    # "e":Ljava/io/IOException;
    :cond_0
    :goto_0
    :try_start_1
    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/FileWriter;

    const/4 v4, 0x1

    invoke-direct {v3, v1, v4}, Ljava/io/FileWriter;-><init>(Ljava/io/File;Z)V

    invoke-direct {v2, v3}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;)V

    .line 72
    .local v2, "buf":Ljava/io/BufferedWriter;
    invoke-virtual {v2, p1}, Ljava/io/BufferedWriter;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    .line 73
    invoke-virtual {v2}, Ljava/io/BufferedWriter;->newLine()V

    .line 74
    invoke-virtual {v2}, Ljava/io/BufferedWriter;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 80
    .end local v2    # "buf":Ljava/io/BufferedWriter;
    goto :goto_1

    .line 76
    :catch_1
    move-exception v2

    .line 79
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 81
    .end local v2    # "e":Ljava/io/IOException;
    :goto_1
    return-void
.end method

.method public getAppLocalValue(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .line 109
    iget-object v0, p0, Lcom/nvidia/devtech/NvUtil;->appLocalValues:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0
.end method

.method public getParameter(Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p1, "paramName"    # Ljava/lang/String;

    .line 134
    iget-object v0, p0, Lcom/nvidia/devtech/NvUtil;->activity:Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public hasAppLocalValue(Ljava/lang/String;)Z
    .locals 1
    .param p1, "key"    # Ljava/lang/String;

    .line 99
    iget-object v0, p0, Lcom/nvidia/devtech/NvUtil;->appLocalValues:Ljava/util/HashMap;

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public setActivity(Landroid/app/Activity;)V
    .locals 0
    .param p1, "activity"    # Landroid/app/Activity;

    .line 85
    iput-object p1, p0, Lcom/nvidia/devtech/NvUtil;->activity:Landroid/app/Activity;

    .line 86
    return-void
.end method

.method public setAppLocalValue(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1
    .param p1, "key"    # Ljava/lang/String;
    .param p2, "value"    # Ljava/lang/String;

    .line 119
    iget-object v0, p0, Lcom/nvidia/devtech/NvUtil;->appLocalValues:Ljava/util/HashMap;

    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 120
    return-void
.end method
