.class public abstract Lcom/skydoves/colorpickerview/flag/FlagView;
.super Landroid/widget/RelativeLayout;
.source "FlagView.java"


# instance fields
.field private flagMode:Lcom/skydoves/colorpickerview/flag/FlagMode;

.field private flipAble:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "layout"    # I

    .line 35
    invoke-direct {p0, p1}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 31
    sget-object v0, Lcom/skydoves/colorpickerview/flag/FlagMode;->ALWAYS:Lcom/skydoves/colorpickerview/flag/FlagMode;

    iput-object v0, p0, Lcom/skydoves/colorpickerview/flag/FlagView;->flagMode:Lcom/skydoves/colorpickerview/flag/FlagMode;

    .line 32
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/flag/FlagView;->flipAble:Z

    .line 36
    invoke-direct {p0, p2}, Lcom/skydoves/colorpickerview/flag/FlagView;->initializeLayout(I)V

    .line 37
    return-void
.end method

.method private initializeLayout(I)V
    .locals 4
    .param p1, "layout"    # I

    .line 60
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-virtual {v0, p1, p0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .line 61
    .local v0, "inflated":Landroid/view/View;
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v2, -0x2

    invoke-direct {v1, v2, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 63
    nop

    .line 64
    const/4 v1, 0x0

    invoke-static {v1, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v2

    .line 65
    invoke-static {v1, v1}, Landroid/view/View$MeasureSpec;->makeMeasureSpec(II)I

    move-result v3

    .line 63
    invoke-virtual {v0, v2, v3}, Landroid/view/View;->measure(II)V

    .line 66
    invoke-virtual {v0}, Landroid/view/View;->getMeasuredWidth()I

    move-result v2

    invoke-virtual {v0}, Landroid/view/View;->getMeasuredHeight()I

    move-result v3

    invoke-virtual {v0, v1, v1, v2, v3}, Landroid/view/View;->layout(IIII)V

    .line 67
    return-void
.end method


# virtual methods
.method public getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;
    .locals 1

    .line 85
    iget-object v0, p0, Lcom/skydoves/colorpickerview/flag/FlagView;->flagMode:Lcom/skydoves/colorpickerview/flag/FlagMode;

    return-object v0
.end method

.method public gone()V
    .locals 1

    .line 76
    const/16 v0, 0x8

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/flag/FlagView;->setVisibility(I)V

    .line 77
    return-void
.end method

.method public isFlipAble()Z
    .locals 1

    .line 103
    iget-boolean v0, p0, Lcom/skydoves/colorpickerview/flag/FlagView;->flipAble:Z

    return v0
.end method

.method public abstract onRefresh(Lcom/skydoves/colorpickerview/ColorEnvelope;)V
.end method

.method public receiveOnTouchEvent(Landroid/view/MotionEvent;)V
    .locals 2
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 43
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    if-eqz v0, :cond_4

    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    const/4 v1, 0x2

    if-eq v0, v1, :cond_0

    goto :goto_0

    .line 49
    :cond_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/flag/FlagMode;->LAST:Lcom/skydoves/colorpickerview/flag/FlagMode;

    if-ne v0, v1, :cond_6

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->gone()V

    goto :goto_1

    .line 52
    :cond_1
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/flag/FlagMode;->LAST:Lcom/skydoves/colorpickerview/flag/FlagMode;

    if-ne v0, v1, :cond_2

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->visible()V

    goto :goto_0

    .line 53
    :cond_2
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/flag/FlagMode;->FADE:Lcom/skydoves/colorpickerview/flag/FlagMode;

    if-ne v0, v1, :cond_3

    invoke-static {p0}, Lcom/skydoves/colorpickerview/FadeUtils;->fadeOut(Landroid/view/View;)V

    .line 55
    :cond_3
    :goto_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->visible()V

    goto :goto_1

    .line 45
    :cond_4
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/flag/FlagMode;->LAST:Lcom/skydoves/colorpickerview/flag/FlagMode;

    if-ne v0, v1, :cond_5

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->gone()V

    goto :goto_1

    .line 46
    :cond_5
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/flag/FlagMode;->FADE:Lcom/skydoves/colorpickerview/flag/FlagMode;

    if-ne v0, v1, :cond_6

    invoke-static {p0}, Lcom/skydoves/colorpickerview/FadeUtils;->fadeIn(Landroid/view/View;)V

    .line 57
    :cond_6
    :goto_1
    return-void
.end method

.method public setFlagMode(Lcom/skydoves/colorpickerview/flag/FlagMode;)V
    .locals 0
    .param p1, "flagMode"    # Lcom/skydoves/colorpickerview/flag/FlagMode;

    .line 94
    iput-object p1, p0, Lcom/skydoves/colorpickerview/flag/FlagView;->flagMode:Lcom/skydoves/colorpickerview/flag/FlagMode;

    .line 95
    return-void
.end method

.method public setFlipAble(Z)V
    .locals 0
    .param p1, "flipAble"    # Z

    .line 112
    iput-boolean p1, p0, Lcom/skydoves/colorpickerview/flag/FlagView;->flipAble:Z

    .line 113
    return-void
.end method

.method public visible()V
    .locals 1

    .line 71
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/flag/FlagView;->setVisibility(I)V

    .line 72
    return-void
.end method
