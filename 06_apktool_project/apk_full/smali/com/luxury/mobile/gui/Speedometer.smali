.class public Lcom/luxury/mobile/gui/Speedometer;
.super Ljava/lang/Object;
.source "Speedometer.java"


# instance fields
.field public activity:Landroid/app/Activity;

.field public mBelt:Landroid/widget/ImageView;

.field public mCarHP:Landroid/widget/TextView;

.field public mCarHPLine:Lcom/triggertrap/seekarc/SeekArc;

.field public mEngine:Landroid/widget/ImageView;

.field public mFuel:Landroid/widget/TextView;

.field public mFuelLine:Lcom/triggertrap/seekarc/SeekArc;

.field public mInputLayout:Landroid/widget/RelativeLayout;

.field public mLight:Landroid/widget/ImageView;

.field public mLock:Landroid/widget/ImageView;

.field public mMileage:Landroid/widget/TextView;

.field public mSpeed:Landroid/widget/TextView;

.field public mSpeedArrow:Landroid/widget/ImageView;

.field public mSpeedLine:Lcom/triggertrap/seekarc/SeekArc;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;

    .line 27
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    const v0, 0x7f0901fd

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/RelativeLayout;

    .line 29
    .local v0, "relativeLayout":Landroid/widget/RelativeLayout;
    iput-object v0, p0, Lcom/luxury/mobile/gui/Speedometer;->mInputLayout:Landroid/widget/RelativeLayout;

    .line 30
    const v1, 0x7f0901fc

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mSpeed:Landroid/widget/TextView;

    .line 31
    const v1, 0x7f0901f6

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mFuel:Landroid/widget/TextView;

    .line 32
    const v1, 0x7f0901f2

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mCarHP:Landroid/widget/TextView;

    .line 33
    const v1, 0x7f0901fa

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mMileage:Landroid/widget/TextView;

    .line 34
    const v1, 0x7f0901f8

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/triggertrap/seekarc/SeekArc;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mSpeedLine:Lcom/triggertrap/seekarc/SeekArc;

    .line 35
    const v1, 0x7f0901f5

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/triggertrap/seekarc/SeekArc;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mFuelLine:Lcom/triggertrap/seekarc/SeekArc;

    .line 36
    const v1, 0x7f0901f1

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/triggertrap/seekarc/SeekArc;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mCarHPLine:Lcom/triggertrap/seekarc/SeekArc;

    .line 37
    const v1, 0x7f0901f3

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mEngine:Landroid/widget/ImageView;

    .line 38
    const v1, 0x7f0901f7

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mLight:Landroid/widget/ImageView;

    .line 39
    const v1, 0x7f0901ee

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mBelt:Landroid/widget/ImageView;

    .line 40
    const v1, 0x7f0901f9

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mLock:Landroid/widget/ImageView;

    .line 41
    const v1, 0x7f0901ed

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mSpeedArrow:Landroid/widget/ImageView;

    .line 42
    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->HideLayout(Landroid/view/View;Z)V

    .line 43
    return-void
.end method


# virtual methods
.method public HideSpeed()V
    .locals 2

    .line 75
    iget-object v0, p0, Lcom/luxury/mobile/gui/Speedometer;->mInputLayout:Landroid/widget/RelativeLayout;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->HideLayout(Landroid/view/View;Z)V

    .line 76
    return-void
.end method

.method public ShowSpeed()V
    .locals 2

    .line 71
    iget-object v0, p0, Lcom/luxury/mobile/gui/Speedometer;->mInputLayout:Landroid/widget/RelativeLayout;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->ShowLayout(Landroid/view/View;Z)V

    .line 72
    return-void
.end method

.method public UpdateSpeedInfo(IIIIIIII)V
    .locals 7
    .param p1, "speed"    # I
    .param p2, "fuel"    # I
    .param p3, "hp"    # I
    .param p4, "mileage"    # I
    .param p5, "engine"    # I
    .param p6, "light"    # I
    .param p7, "belt"    # I
    .param p8, "lock"    # I

    .line 47
    int-to-double v0, p1

    const-wide v2, 0x3fee04189374bc6aL    # 0.938

    invoke-static {v0, v1}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v0, v0, v2

    const-wide v2, 0x3fa1800000000000L    # 0.0341796875

    sub-double/2addr v0, v2

    const-wide v2, 0x405e800000000000L    # 122.0

    sub-double/2addr v0, v2

    double-to-float v0, v0

    .line 48
    .local v0, "rot":F
    const v1, 0x42f3999a    # 121.8f

    cmpl-float v1, v0, v1

    if-lez v1, :cond_0

    .line 49
    const v0, 0x42f3999a    # 121.8f

    .line 51
    :cond_0
    const/16 v1, 0x64

    if-le p2, v1, :cond_1

    .line 52
    const/16 p2, 0x64

    .line 55
    :cond_1
    div-int/lit8 p3, p3, 0xa

    .line 56
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mSpeedArrow:Landroid/widget/ImageView;

    invoke-virtual {v1, v0}, Landroid/widget/ImageView;->setRotation(F)V

    .line 57
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mFuel:Landroid/widget/TextView;

    new-instance v2, Ljava/util/Formatter;

    invoke-direct {v2}, Ljava/util/Formatter;-><init>()V

    const/4 v3, 0x1

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    const/4 v6, 0x0

    aput-object v5, v4, v6

    const-string v5, "%d \u0644\u062a\u0631"

    invoke-virtual {v2, v5, v4}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Formatter;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 58
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mMileage:Landroid/widget/TextView;

    new-instance v2, Ljava/util/Formatter;

    invoke-direct {v2}, Ljava/util/Formatter;-><init>()V

    new-array v4, v3, [Ljava/lang/Object;

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    const-string v5, "%06d"

    invoke-virtual {v2, v5, v4}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Formatter;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 59
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mCarHP:Landroid/widget/TextView;

    new-instance v2, Ljava/util/Formatter;

    invoke-direct {v2}, Ljava/util/Formatter;-><init>()V

    const/4 v4, 0x2

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {p3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v4, v6

    const-string v5, "%"

    aput-object v5, v4, v3

    const-string v5, "%d %s"

    invoke-virtual {v2, v5, v4}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Formatter;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 60
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mSpeed:Landroid/widget/TextView;

    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 61
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mSpeedLine:Lcom/triggertrap/seekarc/SeekArc;

    invoke-virtual {v1, p1}, Lcom/triggertrap/seekarc/SeekArc;->setProgress(I)V

    .line 62
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mCarHPLine:Lcom/triggertrap/seekarc/SeekArc;

    invoke-virtual {v1, p3}, Lcom/triggertrap/seekarc/SeekArc;->setProgress(I)V

    .line 63
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mFuelLine:Lcom/triggertrap/seekarc/SeekArc;

    invoke-virtual {v1, p2}, Lcom/triggertrap/seekarc/SeekArc;->setProgress(I)V

    .line 64
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mEngine:Landroid/widget/ImageView;

    if-ne p5, v3, :cond_2

    const v2, 0x7f0700d2

    goto :goto_0

    :cond_2
    const v2, 0x7f0700d1

    :goto_0
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 65
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mLight:Landroid/widget/ImageView;

    if-ne p6, v3, :cond_3

    const v2, 0x7f0700d4

    goto :goto_1

    :cond_3
    const v2, 0x7f0700d3

    :goto_1
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 66
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mBelt:Landroid/widget/ImageView;

    if-ne p7, v3, :cond_4

    const v2, 0x7f0700d9

    goto :goto_2

    :cond_4
    const v2, 0x7f0700d8

    :goto_2
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 67
    iget-object v1, p0, Lcom/luxury/mobile/gui/Speedometer;->mLock:Landroid/widget/ImageView;

    if-ne p8, v3, :cond_5

    const v2, 0x7f0700d6

    goto :goto_3

    :cond_5
    const v2, 0x7f0700d5

    :goto_3
    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 68
    return-void
.end method
