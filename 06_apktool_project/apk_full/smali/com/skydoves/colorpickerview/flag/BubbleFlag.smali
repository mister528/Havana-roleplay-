.class public Lcom/skydoves/colorpickerview/flag/BubbleFlag;
.super Lcom/skydoves/colorpickerview/flag/FlagView;
.source "BubbleFlag.java"


# instance fields
.field private bubble:Landroidx/appcompat/widget/AppCompatImageView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 32
    sget v0, Lcom/skydoves/colorpickerview/R$layout;->flag_bubble:I

    invoke-direct {p0, p1, v0}, Lcom/skydoves/colorpickerview/flag/FlagView;-><init>(Landroid/content/Context;I)V

    .line 33
    sget v0, Lcom/skydoves/colorpickerview/R$id;->bubble:I

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/flag/BubbleFlag;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/AppCompatImageView;

    iput-object v0, p0, Lcom/skydoves/colorpickerview/flag/BubbleFlag;->bubble:Landroidx/appcompat/widget/AppCompatImageView;

    .line 34
    return-void
.end method


# virtual methods
.method public onRefresh(Lcom/skydoves/colorpickerview/ColorEnvelope;)V
    .locals 2
    .param p1, "colorEnvelope"    # Lcom/skydoves/colorpickerview/ColorEnvelope;

    .line 43
    iget-object v0, p0, Lcom/skydoves/colorpickerview/flag/BubbleFlag;->bubble:Landroidx/appcompat/widget/AppCompatImageView;

    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorEnvelope;->getColor()I

    move-result v1

    invoke-static {v1}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v1

    invoke-static {v0, v1}, Landroidx/core/widget/ImageViewCompat;->setImageTintList(Landroid/widget/ImageView;Landroid/content/res/ColorStateList;)V

    .line 44
    return-void
.end method
