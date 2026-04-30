.class public Lcom/nvidia/devtech/NvAPKFileHelper;
.super Ljava/lang/Object;
.source "NvAPKFileHelper.java"


# static fields
.field private static instance:Lcom/nvidia/devtech/NvAPKFileHelper;

.field private static final logAssetFiles:Z


# instance fields
.field private READ_MODE_ONLY:I

.field apkCount:I

.field apkFiles:[Ljava/lang/String;

.field private context:Landroid/content/Context;

.field hasAPKFiles:Z

.field myApkCount:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 10
    new-instance v0, Lcom/nvidia/devtech/NvAPKFileHelper;

    invoke-direct {v0}, Lcom/nvidia/devtech/NvAPKFileHelper;-><init>()V

    sput-object v0, Lcom/nvidia/devtech/NvAPKFileHelper;->instance:Lcom/nvidia/devtech/NvAPKFileHelper;

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const/4 v0, 0x0

    iput v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I

    .line 14
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->context:Landroid/content/Context;

    .line 15
    iput-boolean v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->hasAPKFiles:Z

    .line 16
    iput v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    .line 17
    const/high16 v0, 0x10000000

    iput v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->READ_MODE_ONLY:I

    return-void
.end method

.method private findInAPKFiles(Ljava/lang/String;)I
    .locals 5
    .param p1, "str"    # Ljava/lang/String;

    .line 20
    iget v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    const/4 v1, -0x1

    if-nez v0, :cond_0

    .line 21
    return v1

    .line 23
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ".mp3"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 24
    .local v0, "str2":Ljava/lang/String;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget-object v3, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    array-length v4, v3

    if-ge v2, v4, :cond_3

    .line 25
    aget-object v3, v3, v2

    invoke-virtual {p1, v3}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v3

    if-eqz v3, :cond_2

    iget-object v3, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    aget-object v3, v3, v2

    invoke-virtual {v0, v3}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v3

    if-nez v3, :cond_1

    goto :goto_1

    .line 24
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 26
    :cond_2
    :goto_1
    iget-object v1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    aget-object v1, v1, v2

    invoke-virtual {p1, v1}, Ljava/lang/String;->compareTo(Ljava/lang/String;)I

    .line 28
    return v2

    .line 31
    .end local v2    # "i":I
    :cond_3
    return v1
.end method

.method public static getInstance()Lcom/nvidia/devtech/NvAPKFileHelper;
    .locals 1

    .line 35
    sget-object v0, Lcom/nvidia/devtech/NvAPKFileHelper;->instance:Lcom/nvidia/devtech/NvAPKFileHelper;

    return-object v0
.end method


# virtual methods
.method public AddAssetFile(Ljava/lang/String;)V
    .locals 3
    .param p1, "str"    # Ljava/lang/String;

    .line 40
    iget-object v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    .line 41
    .local v0, "strArr":[Ljava/lang/String;
    iget v1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    .line 42
    .local v1, "i":I
    add-int/lit8 v2, v1, 0x1

    iput v2, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    .line 43
    aput-object p1, v0, v1

    .line 44
    return-void
.end method

.method public GetAssetList()V
    .locals 7

    .line 49
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/InputStreamReader;

    iget-object v3, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->context:Landroid/content/Context;

    invoke-virtual {v3}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    const-string v4, "assetfile.txt"

    invoke-virtual {v3, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 50
    .local v1, "bufferedReader":Ljava/io/BufferedReader;
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v2

    .line 51
    .local v2, "parseInt":I
    iput v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    .line 52
    if-lez v2, :cond_1

    .line 53
    new-array v3, v2, [Ljava/lang/String;

    iput-object v3, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    .line 55
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v3

    .line 56
    .local v3, "readLine":Ljava/lang/String;
    if-eqz v3, :cond_0

    .line 57
    iget-object v4, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    .line 58
    .local v4, "strArr":[Ljava/lang/String;
    iget v5, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    .line 59
    .local v5, "i":I
    add-int/lit8 v6, v5, 0x1

    iput v6, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->myApkCount:I

    .line 60
    aput-object v3, v4, v5
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 61
    .end local v4    # "strArr":[Ljava/lang/String;
    .end local v5    # "i":I
    nop

    .line 64
    .end local v3    # "readLine":Ljava/lang/String;
    goto :goto_0

    .line 62
    .restart local v3    # "readLine":Ljava/lang/String;
    :cond_0
    return-void

    .line 70
    .end local v1    # "bufferedReader":Ljava/io/BufferedReader;
    .end local v2    # "parseInt":I
    .end local v3    # "readLine":Ljava/lang/String;
    :cond_1
    goto :goto_1

    .line 66
    :catch_0
    move-exception v1

    .line 67
    .local v1, "e":Ljava/lang/Exception;
    iget-object v2, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    .line 68
    .local v2, "assets":Landroid/content/res/AssetManager;
    const-string v3, ""

    invoke-virtual {p0, v2, v3, v0}, Lcom/nvidia/devtech/NvAPKFileHelper;->getDirectoryListing(Landroid/content/res/AssetManager;Ljava/lang/String;I)I

    .line 69
    iget v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I

    invoke-virtual {p0, v2, v3, v0}, Lcom/nvidia/devtech/NvAPKFileHelper;->getDirectoryListing(Landroid/content/res/AssetManager;Ljava/lang/String;I)I

    .line 71
    .end local v1    # "e":Ljava/lang/Exception;
    .end local v2    # "assets":Landroid/content/res/AssetManager;
    :goto_1
    return-void
.end method

.method public closeFileAndroid(Lcom/nvidia/devtech/NvAPKFile;)V
    .locals 1
    .param p1, "nvAPKFile"    # Lcom/nvidia/devtech/NvAPKFile;

    .line 75
    :try_start_0
    iget-object v0, p1, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 77
    goto :goto_0

    .line 76
    :catch_0
    move-exception v0

    .line 78
    :goto_0
    const/4 v0, 0x0

    new-array v0, v0, [B

    iput-object v0, p1, Lcom/nvidia/devtech/NvAPKFile;->data:[B

    .line 79
    const/4 v0, 0x0

    iput-object v0, p1, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    .line 80
    return-void
.end method

.method public getDirectoryListing(Landroid/content/res/AssetManager;Ljava/lang/String;I)I
    .locals 5
    .param p1, "assetManager"    # Landroid/content/res/AssetManager;
    .param p2, "str"    # Ljava/lang/String;
    .param p3, "i"    # I

    .line 85
    :try_start_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    if-nez v0, :cond_0

    if-lez p3, :cond_0

    .line 86
    new-array v0, p3, [Ljava/lang/String;

    iput-object v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    .line 88
    :cond_0
    invoke-virtual {p1, p2}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 89
    .local v0, "list":[Ljava/lang/String;
    array-length v1, v0

    if-nez v1, :cond_2

    .line 90
    if-lez p3, :cond_1

    .line 91
    invoke-virtual {p0, p2}, Lcom/nvidia/devtech/NvAPKFileHelper;->AddAssetFile(Ljava/lang/String;)V

    goto :goto_0

    .line 93
    :cond_1
    iget v1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I

    add-int/lit8 v1, v1, 0x1

    iput v1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I

    goto :goto_0

    .line 95
    :cond_2
    nop

    .line 97
    :goto_0
    const/4 v1, 0x0

    .line 98
    .local v1, "i2":I
    :goto_1
    array-length v2, v0

    if-ge v1, v2, :cond_7

    .line 99
    aget-object v2, v0, v1

    const/16 v3, 0x2e

    invoke-virtual {v2, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    const/4 v3, -0x1

    const-string v4, "/"

    if-ne v2, v3, :cond_4

    .line 100
    :try_start_1
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_3

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v3, v0, v1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    :cond_3
    aget-object v2, v0, v1

    :goto_2
    invoke-virtual {p0, p1, v2, p3}, Lcom/nvidia/devtech/NvAPKFileHelper;->getDirectoryListing(Landroid/content/res/AssetManager;Ljava/lang/String;I)I

    goto :goto_4

    .line 101
    :cond_4
    if-lez p3, :cond_6

    .line 102
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    if-lez v2, :cond_5

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v3, v0, v1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    goto :goto_3

    :cond_5
    aget-object v2, v0, v1

    :goto_3
    invoke-virtual {p0, v2}, Lcom/nvidia/devtech/NvAPKFileHelper;->AddAssetFile(Ljava/lang/String;)V

    goto :goto_4

    .line 104
    :cond_6
    iget v2, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I

    add-int/lit8 v2, v2, 0x1

    iput v2, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 106
    :goto_4
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 110
    .end local v0    # "list":[Ljava/lang/String;
    .end local v1    # "i2":I
    :cond_7
    goto :goto_5

    .line 108
    :catch_0
    move-exception v0

    .line 109
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "ERROR: getDirectoryListing "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 111
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_5
    const/4 v0, 0x0

    return v0
.end method

.method public openFileAndroid(Ljava/lang/String;)Lcom/nvidia/devtech/NvAPKFile;
    .locals 5
    .param p1, "str"    # Ljava/lang/String;

    .line 115
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->hasAPKFiles:Z

    const/4 v1, 0x0

    const/4 v2, 0x0

    if-nez v0, :cond_0

    .line 116
    iput v2, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkCount:I

    .line 117
    iput-object v1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    .line 118
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvAPKFileHelper;->GetAssetList()V

    .line 119
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->hasAPKFiles:Z

    .line 121
    :cond_0
    invoke-direct {p0, p1}, Lcom/nvidia/devtech/NvAPKFileHelper;->findInAPKFiles(Ljava/lang/String;)I

    move-result v0

    .line 122
    .local v0, "findInAPKFiles":I
    const/4 v3, -0x1

    if-ne v0, v3, :cond_1

    .line 123
    return-object v1

    .line 125
    :cond_1
    new-instance v3, Lcom/nvidia/devtech/NvAPKFile;

    invoke-direct {v3}, Lcom/nvidia/devtech/NvAPKFile;-><init>()V

    .line 126
    .local v3, "nvAPKFile":Lcom/nvidia/devtech/NvAPKFile;
    iput-object v1, v3, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    .line 127
    iput v2, v3, Lcom/nvidia/devtech/NvAPKFile;->length:I

    .line 128
    iput v2, v3, Lcom/nvidia/devtech/NvAPKFile;->position:I

    .line 129
    iput v2, v3, Lcom/nvidia/devtech/NvAPKFile;->bufferSize:I

    .line 131
    :try_start_0
    iget-object v2, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v2

    iget-object v4, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->apkFiles:[Ljava/lang/String;

    aget-object v4, v4, v0

    invoke-virtual {v2, v4}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    iput-object v2, v3, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    .line 132
    iget-object v2, v3, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    invoke-virtual {v2}, Ljava/io/InputStream;->available()I

    move-result v2

    iput v2, v3, Lcom/nvidia/devtech/NvAPKFile;->length:I

    .line 133
    iget-object v2, v3, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    iget v4, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->READ_MODE_ONLY:I

    invoke-virtual {v2, v4}, Ljava/io/InputStream;->mark(I)V

    .line 134
    const/16 v2, 0x400

    iput v2, v3, Lcom/nvidia/devtech/NvAPKFile;->bufferSize:I

    .line 135
    iget v2, v3, Lcom/nvidia/devtech/NvAPKFile;->bufferSize:I

    new-array v2, v2, [B

    iput-object v2, v3, Lcom/nvidia/devtech/NvAPKFile;->data:[B
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 136
    return-object v3

    .line 137
    :catch_0
    move-exception v2

    .line 138
    .local v2, "e":Ljava/lang/Exception;
    return-object v1
.end method

.method public readFileAndroid(Lcom/nvidia/devtech/NvAPKFile;I)V
    .locals 3
    .param p1, "nvAPKFile"    # Lcom/nvidia/devtech/NvAPKFile;
    .param p2, "i"    # I

    .line 143
    iget v0, p1, Lcom/nvidia/devtech/NvAPKFile;->bufferSize:I

    if-le p2, v0, :cond_0

    .line 144
    new-array v0, p2, [B

    iput-object v0, p1, Lcom/nvidia/devtech/NvAPKFile;->data:[B

    .line 145
    iput p2, p1, Lcom/nvidia/devtech/NvAPKFile;->bufferSize:I

    .line 148
    :cond_0
    :try_start_0
    iget-object v0, p1, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    iget-object v1, p1, Lcom/nvidia/devtech/NvAPKFile;->data:[B

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, p2}, Ljava/io/InputStream;->read([BII)I

    .line 149
    iget v0, p1, Lcom/nvidia/devtech/NvAPKFile;->position:I

    add-int/2addr v0, p2

    iput v0, p1, Lcom/nvidia/devtech/NvAPKFile;->position:I
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 151
    goto :goto_0

    .line 150
    :catch_0
    move-exception v0

    .line 152
    :goto_0
    return-void
.end method

.method public seekFileAndroid(Lcom/nvidia/devtech/NvAPKFile;I)J
    .locals 8
    .param p1, "nvAPKFile"    # Lcom/nvidia/devtech/NvAPKFile;
    .param p2, "i"    # I

    .line 155
    const-wide/16 v0, 0x0

    .line 156
    .local v0, "j":J
    const/16 v2, 0x80

    .line 157
    .local v2, "i2":I
    const-wide/16 v3, 0x0

    .line 159
    .local v3, "j2":J
    :try_start_0
    iget-object v5, p1, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    invoke-virtual {v5}, Ljava/io/InputStream;->reset()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .line 160
    :goto_0
    if-lez p2, :cond_0

    if-lez v2, :cond_0

    .line 162
    :try_start_1
    iget-object v5, p1, Lcom/nvidia/devtech/NvAPKFile;->is:Ljava/io/InputStream;

    int-to-long v6, p2

    invoke-virtual {v5, v6, v7}, Ljava/io/InputStream;->skip(J)J

    move-result-wide v5
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    move-wide v3, v5

    .line 165
    goto :goto_1

    .line 163
    :catch_0
    move-exception v5

    .line 164
    .local v5, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 166
    .end local v5    # "e":Ljava/io/IOException;
    :goto_1
    add-long/2addr v0, v3

    .line 167
    int-to-long v5, p2

    sub-long/2addr v5, v3

    long-to-int p2, v5

    .line 168
    add-int/lit8 v2, v2, -0x1

    goto :goto_0

    .line 171
    :cond_0
    goto :goto_2

    .line 170
    :catch_1
    move-exception v5

    .line 172
    :goto_2
    long-to-int v5, v0

    iput v5, p1, Lcom/nvidia/devtech/NvAPKFile;->position:I

    .line 173
    return-wide v0
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "context2"    # Landroid/content/Context;

    .line 177
    iput-object p1, p0, Lcom/nvidia/devtech/NvAPKFileHelper;->context:Landroid/content/Context;

    .line 178
    return-void
.end method
