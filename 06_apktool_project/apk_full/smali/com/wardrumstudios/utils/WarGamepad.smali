.class public Lcom/wardrumstudios/utils/WarGamepad;
.super Lcom/wardrumstudios/utils/WarBilling;
.source "WarGamepad.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Lcom/wardrumstudios/utils/WarBilling;-><init>()V

    return-void
.end method


# virtual methods
.method public GetGamepadAxis(I)F
    .locals 2
    .param p1, "i"    # I

    .line 23
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetGamepadAxis()"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 24
    const/4 v0, 0x0

    return v0
.end method

.method public GetGamepadButtons()I
    .locals 2

    .line 12
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetGamepadButtons()"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 13
    const/4 v0, 0x0

    return v0
.end method

.method public GetGamepadTrack(II)I
    .locals 2
    .param p1, "i"    # I
    .param p2, "i2"    # I

    .line 18
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** GetGamepadTrack()"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 19
    const/4 v0, 0x0

    return v0
.end method

.method public GetGamepadType()I
    .locals 1

    .line 8
    const/4 v0, -0x1

    return v0
.end method

.method public native processTouchpadAsPointer(Landroid/view/ViewParent;Z)Z
.end method
