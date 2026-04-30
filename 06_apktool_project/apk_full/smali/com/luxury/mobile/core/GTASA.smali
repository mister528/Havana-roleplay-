.class public Lcom/luxury/mobile/core/GTASA;
.super Lcom/wardrumstudios/utils/WarMedia;
.source "GTASA.java"


# static fields
.field public static gtasaSelf:Lcom/luxury/mobile/core/GTASA;

.field static vmVersion:Ljava/lang/String;


# instance fields
.field private once:Z


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 10
    const/4 v0, 0x0

    sput-object v0, Lcom/luxury/mobile/core/GTASA;->gtasaSelf:Lcom/luxury/mobile/core/GTASA;

    .line 15
    sput-object v0, Lcom/luxury/mobile/core/GTASA;->vmVersion:Ljava/lang/String;

    .line 16
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** Loading SO\'s"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 19
    :try_start_0
    const-string v0, "java.vm.version"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/luxury/mobile/core/GTASA;->vmVersion:Ljava/lang/String;

    .line 20
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "vmVersion "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v2, Lcom/luxury/mobile/core/GTASA;->vmVersion:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 21
    const-string v0, "ImmEmulatorJ"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/ExceptionInInitializerError; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/UnsatisfiedLinkError; {:try_start_0 .. :try_end_0} :catch_0

    .line 23
    goto :goto_0

    .line 22
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 25
    :goto_0
    const-string v0, "GTASA"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 26
    const-string v0, "luxury"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 27
    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Lcom/wardrumstudios/utils/WarMedia;-><init>()V

    .line 12
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/core/GTASA;->once:Z

    return-void
.end method

.method public static staticEnterSocialClub()V
    .locals 1

    .line 31
    sget-object v0, Lcom/luxury/mobile/core/GTASA;->gtasaSelf:Lcom/luxury/mobile/core/GTASA;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/GTASA;->EnterSocialClub()V

    .line 32
    return-void
.end method

.method public static staticExitSocialClub()V
    .locals 1

    .line 35
    sget-object v0, Lcom/luxury/mobile/core/GTASA;->gtasaSelf:Lcom/luxury/mobile/core/GTASA;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/GTASA;->ExitSocialClub()V

    .line 36
    return-void
.end method


# virtual methods
.method public AfterDownloadFunction()V
    .locals 0

    .line 40
    return-void
.end method

.method public EnterSocialClub()V
    .locals 0

    .line 44
    return-void
.end method

.method public ExitSocialClub()V
    .locals 0

    .line 48
    return-void
.end method

.method public ServiceAppCommand(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 1
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "str2"    # Ljava/lang/String;

    .line 52
    const/4 v0, 0x0

    return v0
.end method

.method public ServiceAppCommandValue(Ljava/lang/String;Ljava/lang/String;)I
    .locals 1
    .param p1, "str"    # Ljava/lang/String;
    .param p2, "str2"    # Ljava/lang/String;

    .line 57
    const/4 v0, 0x0

    return v0
.end method

.method public native main()V
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0
    .param p1, "i"    # I
    .param p2, "i2"    # I
    .param p3, "intent"    # Landroid/content/Intent;

    .line 64
    invoke-super {p0, p1, p2, p3}, Lcom/wardrumstudios/utils/WarMedia;->onActivityResult(IILandroid/content/Intent;)V

    .line 65
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "configuration"    # Landroid/content/res/Configuration;

    .line 69
    invoke-super {p0, p1}, Lcom/wardrumstudios/utils/WarMedia;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 70
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "bundle"    # Landroid/os/Bundle;

    .line 74
    iget-boolean v0, p0, Lcom/luxury/mobile/core/GTASA;->once:Z

    const/4 v1, 0x1

    if-nez v0, :cond_0

    .line 76
    iput-boolean v1, p0, Lcom/luxury/mobile/core/GTASA;->once:Z

    .line 79
    :cond_0
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "GTASA onCreate"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 80
    sput-object p0, Lcom/luxury/mobile/core/GTASA;->gtasaSelf:Lcom/luxury/mobile/core/GTASA;

    .line 81
    iput-boolean v1, p0, Lcom/luxury/mobile/core/GTASA;->wantsMultitouch:Z

    .line 82
    iput-boolean v1, p0, Lcom/luxury/mobile/core/GTASA;->wantsAccelerometer:Z

    .line 83
    invoke-super {p0, p1}, Lcom/wardrumstudios/utils/WarMedia;->onCreate(Landroid/os/Bundle;)V

    .line 84
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 88
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "GTASA onDestroy"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 89
    invoke-super {p0}, Lcom/wardrumstudios/utils/WarMedia;->onDestroy()V

    .line 90
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "i"    # I
    .param p2, "keyEvent"    # Landroid/view/KeyEvent;

    .line 94
    invoke-super {p0, p1, p2}, Lcom/wardrumstudios/utils/WarMedia;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method

.method public onPause()V
    .locals 2

    .line 99
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "GTASA onPause"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 100
    invoke-super {p0}, Lcom/wardrumstudios/utils/WarMedia;->onPause()V

    .line 101
    return-void
.end method

.method public onRestart()V
    .locals 2

    .line 105
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "GTASA onRestart"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 106
    invoke-super {p0}, Lcom/wardrumstudios/utils/WarMedia;->onRestart()V

    .line 107
    return-void
.end method

.method public onResume()V
    .locals 2

    .line 111
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "GTASA onResume"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 112
    invoke-super {p0}, Lcom/wardrumstudios/utils/WarMedia;->onResume()V

    .line 113
    return-void
.end method

.method public onStart()V
    .locals 2

    .line 117
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "GTASA onStart"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 118
    invoke-super {p0}, Lcom/wardrumstudios/utils/WarMedia;->onStart()V

    .line 119
    return-void
.end method

.method public onStop()V
    .locals 2

    .line 123
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "GTASA onStop"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 124
    invoke-super {p0}, Lcom/wardrumstudios/utils/WarMedia;->onStop()V

    .line 125
    return-void
.end method

.method public native setCurrentScreenSize(II)V
.end method
