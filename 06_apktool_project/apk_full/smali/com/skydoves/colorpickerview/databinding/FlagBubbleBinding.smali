.class public final Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;
.super Ljava/lang/Object;
.source "FlagBubbleBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final bubble:Landroidx/appcompat/widget/AppCompatImageView;

.field public final layout:Landroid/widget/FrameLayout;

.field private final rootView:Landroid/widget/FrameLayout;


# direct methods
.method private constructor <init>(Landroid/widget/FrameLayout;Landroidx/appcompat/widget/AppCompatImageView;Landroid/widget/FrameLayout;)V
    .locals 0
    .param p1, "rootView"    # Landroid/widget/FrameLayout;
    .param p2, "bubble"    # Landroidx/appcompat/widget/AppCompatImageView;
    .param p3, "layout"    # Landroid/widget/FrameLayout;

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    iput-object p1, p0, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->rootView:Landroid/widget/FrameLayout;

    .line 30
    iput-object p2, p0, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->bubble:Landroidx/appcompat/widget/AppCompatImageView;

    .line 31
    iput-object p3, p0, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->layout:Landroid/widget/FrameLayout;

    .line 32
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;
    .locals 4
    .param p0, "rootView"    # Landroid/view/View;

    .line 61
    sget v0, Lcom/skydoves/colorpickerview/R$id;->bubble:I

    invoke-virtual {p0, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/AppCompatImageView;

    .line 62
    .local v0, "bubble":Landroidx/appcompat/widget/AppCompatImageView;
    if-eqz v0, :cond_1

    .line 66
    sget v1, Lcom/skydoves/colorpickerview/R$id;->layout:I

    invoke-virtual {p0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout;

    .line 67
    .local v1, "layout":Landroid/widget/FrameLayout;
    if-eqz v1, :cond_0

    .line 71
    new-instance v2, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;

    move-object v3, p0

    check-cast v3, Landroid/widget/FrameLayout;

    invoke-direct {v2, v3, v0, v1}, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;-><init>(Landroid/widget/FrameLayout;Landroidx/appcompat/widget/AppCompatImageView;Landroid/widget/FrameLayout;)V

    return-object v2

    .line 68
    :cond_0
    const-string v2, "layout"

    .line 69
    .local v2, "missingId":Ljava/lang/String;
    goto :goto_0

    .line 63
    .end local v1    # "layout":Landroid/widget/FrameLayout;
    .end local v2    # "missingId":Ljava/lang/String;
    :cond_1
    const-string v2, "bubble"

    .line 64
    .restart local v2    # "missingId":Ljava/lang/String;
    nop

    .line 73
    .end local v0    # "bubble":Landroidx/appcompat/widget/AppCompatImageView;
    :goto_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "Missing required view with ID: "

    invoke-virtual {v1, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 42
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 48
    sget v0, Lcom/skydoves/colorpickerview/R$layout;->flag_bubble:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 49
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 50
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 52
    :cond_0
    invoke-static {v0}, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->bind(Landroid/view/View;)Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 17
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->getRoot()Landroid/widget/FrameLayout;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroid/widget/FrameLayout;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/skydoves/colorpickerview/databinding/FlagBubbleBinding;->rootView:Landroid/widget/FrameLayout;

    return-object v0
.end method
