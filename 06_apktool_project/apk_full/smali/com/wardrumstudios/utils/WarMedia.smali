.class public Lcom/wardrumstudios/utils/WarMedia;
.super Lcom/wardrumstudios/utils/WarGamepad;
.source "WarMedia.java"


# instance fields
.field private baseDirectory:Ljava/lang/String;

.field private baseDirectoryRoot:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Lcom/wardrumstudios/utils/WarGamepad;-><init>()V

    return-void
.end method


# virtual methods
.method public DeleteFile(Ljava/lang/String;)Z
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    .line 88
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** DeleteFile"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 89
    const/4 v0, 0x1

    return v0
.end method

.method public FileGetArchiveName(I)Ljava/lang/String;
    .locals 2
    .param p1, "i"    # I

    .line 165
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** FileGetArchiveName"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 166
    nop

    .line 174
    const-string v0, ""

    return-object v0
.end method

.method public FileRename(Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "str2"    # Ljava/lang/String;
    .param p3, "i"    # I

    .line 94
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** FileRename"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 95
    const/4 v0, 0x1

    return v0
.end method

.method public GetAndroidBuildinfo(I)Ljava/lang/String;
    .locals 2
    .param p1, "i"    # I

    .line 146
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetAndroidBuildinfo"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 147
    if-eqz p1, :cond_2

    const/4 v0, 0x1

    if-eq p1, v0, :cond_1

    const/4 v0, 0x2

    if-eq p1, v0, :cond_0

    .line 155
    const-string v0, "UNKNOWN"

    return-object v0

    .line 153
    :cond_0
    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    return-object v0

    .line 151
    :cond_1
    sget-object v0, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    return-object v0

    .line 149
    :cond_2
    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    return-object v0
.end method

.method public GetAppId()Ljava/lang/String;
    .locals 2

    .line 267
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetAppId"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 268
    const-string v0, ""

    return-object v0
.end method

.method public GetAvailableMemory()I
    .locals 2

    .line 256
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetAvailableMemory"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 257
    const/4 v0, 0x0

    return v0
.end method

.method public GetDeviceInfo(I)I
    .locals 3
    .param p1, "i"    # I

    .line 133
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetDeviceInfo"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 134
    const/4 v0, 0x1

    if-eqz p1, :cond_1

    if-eq p1, v0, :cond_0

    .line 141
    const/4 v0, -0x1

    return v0

    .line 138
    :cond_0
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "Return for touchsreen 1"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 139
    return v0

    .line 136
    :cond_1
    return v0
.end method

.method public GetDeviceLocale()I
    .locals 2

    .line 98
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetDeviceLocale"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 99
    const/4 v0, 0x0

    return v0
.end method

.method public GetDeviceType()I
    .locals 5

    .line 111
    const/4 v0, 0x0

    .line 112
    .local v0, "i":I
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build info version device  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->DEVICE:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 113
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build MANUFACTURER  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 114
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build BOARD  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->BOARD:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 115
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build DISPLAY  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->DISPLAY:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 116
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build CPU_ABI  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 117
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build CPU_ABI2  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->CPU_ABI2:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 118
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build HARDWARE  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 119
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build MODEL  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 120
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "Build PRODUCT  "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v3, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 121
    const/4 v1, 0x0

    .line 122
    .local v1, "i2":I
    const/4 v2, 0x4

    .line 123
    .local v2, "numberOfProcessors":I
    const/16 v3, 0x200

    .line 124
    .local v3, "i3":I
    invoke-virtual {p0}, Lcom/wardrumstudios/utils/WarMedia;->IsPhone()Z

    move-result v4

    if-eqz v4, :cond_0

    .line 126
    const/4 v0, 0x1

    .line 128
    :cond_0
    add-int v4, v0, v1

    add-int/2addr v4, v2

    add-int/2addr v4, v3

    return v4
.end method

.method public GetGameBaseDirectory()Ljava/lang/String;
    .locals 4

    .line 21
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    const-string v1, "mounted"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 25
    const/4 v0, 0x0

    :try_start_0
    invoke-virtual {p0, v0}, Lcom/wardrumstudios/utils/WarMedia;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    .line 26
    .local v0, "externalFilesDir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    .line 27
    .local v1, "absolutePath":Ljava/lang/String;
    const/4 v2, 0x0

    const-string v3, "/Android"

    invoke-virtual {v1, v3}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/wardrumstudios/utils/WarMedia;->baseDirectoryRoot:Ljava/lang/String;

    .line 28
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "/"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 29
    .end local v0    # "externalFilesDir":Ljava/io/File;
    .end local v1    # "absolutePath":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 33
    :cond_0
    const-string v0, ""

    return-object v0
.end method

.method public GetLowThreshhold()I
    .locals 2

    .line 251
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetLowThreshhold"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 252
    const/4 v0, 0x0

    return v0
.end method

.method public GetScreenWidthInches()F
    .locals 2

    .line 261
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetScreenWidthInches"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 262
    const/4 v0, 0x0

    return v0
.end method

.method public GetSpecialBuildType()I
    .locals 2

    .line 233
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetSpecialBuildType"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 234
    const/4 v0, 0x0

    return v0
.end method

.method public GetTotalMemory()I
    .locals 2

    .line 246
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetTotalMemory"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 247
    const/4 v0, 0x0

    return v0
.end method

.method public IsAppInstalled(Ljava/lang/String;)Z
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    .line 179
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** IsAppInstalled"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 180
    const/4 v0, 0x0

    return v0
.end method

.method public IsCloudAvailable()Z
    .locals 2

    .line 203
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** IsCloudAvailable"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 204
    const/4 v0, 0x0

    return v0
.end method

.method public IsKeyboardShown()Z
    .locals 2

    .line 53
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** IsKeyboardShown"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 54
    const/4 v0, 0x0

    return v0
.end method

.method public IsMoviePlaying()I
    .locals 2

    .line 82
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** IsMoviePlaying"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 83
    const/4 v0, 0x0

    return v0
.end method

.method public IsPhone()Z
    .locals 2

    .line 104
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** IsPhone"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 105
    const/4 v0, 0x1

    return v0
.end method

.method public LoadAllGamesFromCloud()V
    .locals 2

    .line 190
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** LoadAllGamesFromCloud"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 191
    return-void
.end method

.method public LoadGameFromCloud(I[B)Ljava/lang/String;
    .locals 2
    .param p1, "i"    # I
    .param p2, "bArr"    # [B

    .line 194
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** LoadGameFromCloud"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 195
    const-string v0, ""

    return-object v0
.end method

.method public MovieClearText(Z)V
    .locals 2
    .param p1, "z"    # Z

    .line 225
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** MovieClearText"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 226
    return-void
.end method

.method public MovieDisplayText(Z)V
    .locals 2
    .param p1, "z"    # Z

    .line 221
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** MovieDisplayText"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 222
    return-void
.end method

.method public MovieKeepAspectRatio(Z)V
    .locals 2
    .param p1, "z"    # Z

    .line 213
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** MovieKeepAspectRatio"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 214
    return-void
.end method

.method public MovieSetSkippable(Z)V
    .locals 2
    .param p1, "z"    # Z

    .line 77
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** MovieSetSkippable"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 78
    return-void
.end method

.method public MovieSetText(Ljava/lang/String;ZZ)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "z"    # Z
    .param p3, "z2"    # Z

    .line 217
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** MovieSetText"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 218
    return-void
.end method

.method public MovieSetTextScale(I)V
    .locals 2
    .param p1, "i"    # I

    .line 229
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** MovieSetTextScale"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 230
    return-void
.end method

.method public NewCloudSaveAvailable(I)Z
    .locals 2
    .param p1, "i"    # I

    .line 208
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** NewCloudSaveAvailable"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 209
    const/4 v0, 0x0

    return v0
.end method

.method public OBFU_GetDeviceID()Ljava/lang/String;
    .locals 2

    .line 160
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** OBFU_GetDeviceID"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 161
    const-string v0, "no id"

    return-object v0
.end method

.method public OpenLink(Ljava/lang/String;)V
    .locals 3
    .param p1, "str"    # Ljava/lang/String;

    .line 185
    new-instance v0, Landroid/content/Intent;

    invoke-static {p1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    const-string v2, "android.intent.action.VIEW"

    invoke-direct {v0, v2, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;Landroid/net/Uri;)V

    invoke-virtual {p0, v0}, Lcom/wardrumstudios/utils/WarMedia;->startActivity(Landroid/content/Intent;)V

    .line 186
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** OpenLink"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 187
    return-void
.end method

.method public PlayMovie(Ljava/lang/String;F)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "f"    # F

    .line 59
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** PlayMovie"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 60
    return-void
.end method

.method public PlayMovieInFile(Ljava/lang/String;FII)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "f"    # F
    .param p3, "i"    # I
    .param p4, "i2"    # I

    .line 64
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** PlayMovieInFile"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 65
    return-void
.end method

.method public PlayMovieInWindow(Ljava/lang/String;IIIIFIII)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "i"    # I
    .param p3, "i2"    # I
    .param p4, "i3"    # I
    .param p5, "i4"    # I
    .param p6, "f"    # F
    .param p7, "i5"    # I
    .param p8, "i6"    # I
    .param p9, "i7"    # I

    .line 68
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** PlayMovieInWindow"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 69
    return-void
.end method

.method public SaveGameToCloud(I[BI)V
    .locals 2
    .param p1, "i"    # I
    .param p2, "bArr"    # [B
    .param p3, "i2"    # I

    .line 199
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** SaveGameToCloud"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 200
    return-void
.end method

.method public ScreenSetWakeLock(Z)V
    .locals 2
    .param p1, "z"    # Z

    .line 272
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** ScreenSetWakeLock"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 273
    return-void
.end method

.method public SendStatEvent(Ljava/lang/String;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    .line 238
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** SendStatEvent"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 239
    return-void
.end method

.method public SendStatEvent(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "str2"    # Ljava/lang/String;
    .param p3, "str3"    # Ljava/lang/String;

    .line 242
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** SendStatEvent1"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 243
    return-void
.end method

.method public ServiceAppCommand(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 3
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "str2"    # Ljava/lang/String;

    .line 276
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "**** ServiceAppCommand "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 277
    const/4 v0, 0x0

    return v0
.end method

.method public ServiceAppCommandValue(Ljava/lang/String;Ljava/lang/String;)I
    .locals 3
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "str2"    # Ljava/lang/String;

    .line 281
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "**** ServiceAppCommandValue "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 282
    const/4 v0, 0x0

    return v0
.end method

.method public ShowKeyboard(I)V
    .locals 2
    .param p1, "i"    # I

    .line 48
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** ShowKeyboard"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 49
    return-void
.end method

.method public StopMovie()V
    .locals 2

    .line 72
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** StopMovie"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 73
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "bundle"    # Landroid/os/Bundle;

    .line 38
    invoke-virtual {p0}, Lcom/wardrumstudios/utils/WarMedia;->GetGameBaseDirectory()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/wardrumstudios/utils/WarMedia;->baseDirectory:Ljava/lang/String;

    .line 40
    invoke-static {}, Lcom/nvidia/devtech/NvUtil;->getInstance()Lcom/nvidia/devtech/NvUtil;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/nvidia/devtech/NvUtil;->setActivity(Landroid/app/Activity;)V

    .line 41
    invoke-static {}, Lcom/nvidia/devtech/NvUtil;->getInstance()Lcom/nvidia/devtech/NvUtil;

    move-result-object v0

    iget-object v1, p0, Lcom/wardrumstudios/utils/WarMedia;->baseDirectory:Ljava/lang/String;

    const-string v2, "STORAGE_ROOT"

    invoke-virtual {v0, v2, v1}, Lcom/nvidia/devtech/NvUtil;->setAppLocalValue(Ljava/lang/String;Ljava/lang/String;)V

    .line 42
    invoke-static {}, Lcom/nvidia/devtech/NvUtil;->getInstance()Lcom/nvidia/devtech/NvUtil;

    move-result-object v0

    iget-object v1, p0, Lcom/wardrumstudios/utils/WarMedia;->baseDirectoryRoot:Ljava/lang/String;

    const-string v2, "STORAGE_ROOT_BASE"

    invoke-virtual {v0, v2, v1}, Lcom/nvidia/devtech/NvUtil;->setAppLocalValue(Ljava/lang/String;Ljava/lang/String;)V

    .line 44
    invoke-super {p0, p1}, Lcom/wardrumstudios/utils/WarGamepad;->onCreate(Landroid/os/Bundle;)V

    .line 45
    return-void
.end method
