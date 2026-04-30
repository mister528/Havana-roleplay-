.class public Lcom/tuyenmonkey/mkloader/util/LoaderGenerator;
.super Ljava/lang/Object;
.source "LoaderGenerator.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static generateLoaderView(I)Lcom/tuyenmonkey/mkloader/type/LoaderView;
    .locals 2
    .param p0, "type"    # I

    .line 23
    packed-switch p0, :pswitch_data_0

    .line 61
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;-><init>()V

    return-object v0

    .line 59
    :pswitch_0
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Sharingan;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Sharingan;-><init>()V

    return-object v0

    .line 57
    :pswitch_1
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/PhoneWave;-><init>()V

    return-object v0

    .line 55
    :pswitch_2
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Whirlpool;-><init>()V

    return-object v0

    .line 53
    :pswitch_3
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Worm;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Worm;-><init>()V

    return-object v0

    .line 51
    :pswitch_4
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/TwinFishesSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/TwinFishesSpinner;-><init>()V

    return-object v0

    .line 32
    :pswitch_5
    :try_start_0
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Pulse;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Lcom/tuyenmonkey/mkloader/type/Pulse;-><init>(I)V
    :try_end_0
    .catch Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 33
    :catch_0
    move-exception v0

    .line 34
    .local v0, "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;->printStackTrace()V

    .line 38
    .end local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    :pswitch_6
    :try_start_1
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Pulse;

    const/4 v1, 0x4

    invoke-direct {v0, v1}, Lcom/tuyenmonkey/mkloader/type/Pulse;-><init>(I)V
    :try_end_1
    .catch Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v0

    .line 39
    :catch_1
    move-exception v0

    .line 40
    .restart local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;->printStackTrace()V

    .line 44
    .end local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    :pswitch_7
    :try_start_2
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Pulse;

    const/4 v1, 0x5

    invoke-direct {v0, v1}, Lcom/tuyenmonkey/mkloader/type/Pulse;-><init>(I)V
    :try_end_2
    .catch Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException; {:try_start_2 .. :try_end_2} :catch_2

    return-object v0

    .line 45
    :catch_2
    move-exception v0

    .line 46
    .restart local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;->printStackTrace()V

    .line 49
    .end local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    :pswitch_8
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Radar;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Radar;-><init>()V

    return-object v0

    .line 29
    :pswitch_9
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/LineSpinner;-><init>()V

    return-object v0

    .line 27
    :pswitch_a
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/FishSpinner;-><init>()V

    return-object v0

    .line 25
    :pswitch_b
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;-><init>()V

    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static generateLoaderView(Ljava/lang/String;)Lcom/tuyenmonkey/mkloader/type/LoaderView;
    .locals 4
    .param p0, "type"    # Ljava/lang/String;

    .line 66
    invoke-virtual {p0}, Ljava/lang/String;->hashCode()I

    move-result v0

    const/4 v1, 0x5

    const/4 v2, 0x3

    const/4 v3, 0x4

    sparse-switch v0, :sswitch_data_0

    :cond_0
    goto/16 :goto_0

    :sswitch_0
    const-string v0, "PhoneWave"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0xa

    goto/16 :goto_1

    :sswitch_1
    const-string v0, "FivePulse"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x5

    goto/16 :goto_1

    :sswitch_2
    const-string v0, "ThreePulse"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x3

    goto :goto_1

    :sswitch_3
    const-string v0, "ClassicSpinner"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_1

    :sswitch_4
    const-string v0, "Sharingan"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0xb

    goto :goto_1

    :sswitch_5
    const-string v0, "Whirlpool"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0x9

    goto :goto_1

    :sswitch_6
    const-string v0, "Radar"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x6

    goto :goto_1

    :sswitch_7
    const-string v0, "LineSpinner"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x2

    goto :goto_1

    :sswitch_8
    const-string v0, "Worm"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/16 v0, 0x8

    goto :goto_1

    :sswitch_9
    const-string v0, "TwinFishesSpinner"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x7

    goto :goto_1

    :sswitch_a
    const-string v0, "FishSpinner"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_1

    :sswitch_b
    const-string v0, "FourPulse"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x4

    goto :goto_1

    :goto_0
    const/4 v0, -0x1

    :goto_1
    packed-switch v0, :pswitch_data_0

    .line 104
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;-><init>()V

    return-object v0

    .line 102
    :pswitch_0
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Sharingan;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Sharingan;-><init>()V

    return-object v0

    .line 100
    :pswitch_1
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/PhoneWave;-><init>()V

    return-object v0

    .line 98
    :pswitch_2
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Whirlpool;-><init>()V

    return-object v0

    .line 96
    :pswitch_3
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Worm;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Worm;-><init>()V

    return-object v0

    .line 94
    :pswitch_4
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/TwinFishesSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/TwinFishesSpinner;-><init>()V

    return-object v0

    .line 75
    :pswitch_5
    :try_start_0
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Pulse;

    invoke-direct {v0, v2}, Lcom/tuyenmonkey/mkloader/type/Pulse;-><init>(I)V
    :try_end_0
    .catch Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 76
    :catch_0
    move-exception v0

    .line 77
    .local v0, "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;->printStackTrace()V

    .line 81
    .end local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    :pswitch_6
    :try_start_1
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Pulse;

    invoke-direct {v0, v3}, Lcom/tuyenmonkey/mkloader/type/Pulse;-><init>(I)V
    :try_end_1
    .catch Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v0

    .line 82
    :catch_1
    move-exception v0

    .line 83
    .restart local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;->printStackTrace()V

    .line 87
    .end local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    :pswitch_7
    :try_start_2
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Pulse;

    invoke-direct {v0, v1}, Lcom/tuyenmonkey/mkloader/type/Pulse;-><init>(I)V
    :try_end_2
    .catch Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException; {:try_start_2 .. :try_end_2} :catch_2

    return-object v0

    .line 88
    :catch_2
    move-exception v0

    .line 89
    .restart local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;->printStackTrace()V

    .line 92
    .end local v0    # "e":Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
    :pswitch_8
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/Radar;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/Radar;-><init>()V

    return-object v0

    .line 72
    :pswitch_9
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/LineSpinner;-><init>()V

    return-object v0

    .line 70
    :pswitch_a
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/FishSpinner;-><init>()V

    return-object v0

    .line 68
    :pswitch_b
    new-instance v0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;-><init>()V

    return-object v0

    :sswitch_data_0
    .sparse-switch
        -0x76477a0d -> :sswitch_b
        -0x5d60577f -> :sswitch_a
        -0x3000b3f5 -> :sswitch_9
        0x293b33 -> :sswitch_8
        0x3022765 -> :sswitch_7
        0x4b122e6 -> :sswitch_6
        0x11d93aee -> :sswitch_5
        0x196a55e9 -> :sswitch_4
        0x2e417547 -> :sswitch_3
        0x35f934bb -> :sswitch_2
        0x3928b3e7 -> :sswitch_1
        0x3a1dfd67 -> :sswitch_0
    .end sparse-switch

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_5
        :pswitch_6
        :pswitch_7
        :pswitch_8
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
