.class public Lcom/nvidia/devtech/HeightProvider;
.super Landroid/widget/PopupWindow;
.source "HeightProvider.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/nvidia/devtech/HeightProvider$HeightListener;
    }
.end annotation


# instance fields
.field private heightMaxHorizontal:I

.field private heightMaxVertical:I

.field private listener:Lcom/nvidia/devtech/HeightProvider$HeightListener;

.field private mActivity:Landroid/app/Activity;

.field private rootView:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;

    .line 28
    invoke-direct {p0, p1}, Landroid/widget/PopupWindow;-><init>(Landroid/content/Context;)V

    .line 29
    iput-object p1, p0, Lcom/nvidia/devtech/HeightProvider;->mActivity:Landroid/app/Activity;

    .line 32
    new-instance v0, Landroid/view/View;

    invoke-direct {v0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/nvidia/devtech/HeightProvider;->rootView:Landroid/view/View;

    .line 33
    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/HeightProvider;->setContentView(Landroid/view/View;)V

    .line 36
    iget-object v0, p0, Lcom/nvidia/devtech/HeightProvider;->rootView:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    .line 37
    new-instance v0, Landroid/graphics/drawable/ColorDrawable;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/HeightProvider;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 40
    invoke-virtual {p0, v1}, Lcom/nvidia/devtech/HeightProvider;->setWidth(I)V

    .line 41
    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/HeightProvider;->setHeight(I)V

    .line 44
    const/16 v0, 0x10

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/HeightProvider;->setSoftInputMode(I)V

    .line 45
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/HeightProvider;->setInputMethodMode(I)V

    .line 46
    return-void
.end method


# virtual methods
.method public init(Landroid/view/View;)Lcom/nvidia/devtech/HeightProvider;
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .line 49
    invoke-virtual {p0}, Lcom/nvidia/devtech/HeightProvider;->isShowing()Z

    move-result v0

    if-nez v0, :cond_0

    .line 51
    move-object v0, p1

    .line 52
    .local v0, "finalView":Landroid/view/View;
    new-instance v1, Lcom/nvidia/devtech/HeightProvider$1;

    invoke-direct {v1, p0, v0}, Lcom/nvidia/devtech/HeightProvider$1;-><init>(Lcom/nvidia/devtech/HeightProvider;Landroid/view/View;)V

    invoke-virtual {p1, v1}, Landroid/view/View;->post(Ljava/lang/Runnable;)Z

    .line 59
    .end local v0    # "finalView":Landroid/view/View;
    :cond_0
    return-object p0
.end method

.method public onGlobalLayout()V
    .locals 4

    .line 71
    new-instance v0, Landroid/graphics/Rect;

    invoke-direct {v0}, Landroid/graphics/Rect;-><init>()V

    .line 72
    .local v0, "rect":Landroid/graphics/Rect;
    iget-object v1, p0, Lcom/nvidia/devtech/HeightProvider;->rootView:Landroid/view/View;

    invoke-virtual {v1, v0}, Landroid/view/View;->getWindowVisibleDisplayFrame(Landroid/graphics/Rect;)V

    .line 73
    const/4 v1, 0x0

    .line 74
    .local v1, "keyboardHeight":I
    iget v2, v0, Landroid/graphics/Rect;->bottom:I

    iget v3, v0, Landroid/graphics/Rect;->right:I

    if-le v2, v3, :cond_1

    .line 76
    iget v2, v0, Landroid/graphics/Rect;->bottom:I

    iget v3, p0, Lcom/nvidia/devtech/HeightProvider;->heightMaxVertical:I

    if-le v2, v3, :cond_0

    .line 77
    iget v2, v0, Landroid/graphics/Rect;->bottom:I

    iput v2, p0, Lcom/nvidia/devtech/HeightProvider;->heightMaxVertical:I

    .line 80
    :cond_0
    iget v2, p0, Lcom/nvidia/devtech/HeightProvider;->heightMaxVertical:I

    iget v3, v0, Landroid/graphics/Rect;->bottom:I

    sub-int/2addr v2, v3

    .end local v1    # "keyboardHeight":I
    .local v2, "keyboardHeight":I
    goto :goto_0

    .line 84
    .end local v2    # "keyboardHeight":I
    .restart local v1    # "keyboardHeight":I
    :cond_1
    iget v2, v0, Landroid/graphics/Rect;->bottom:I

    iget v3, p0, Lcom/nvidia/devtech/HeightProvider;->heightMaxHorizontal:I

    if-le v2, v3, :cond_2

    .line 85
    iget v2, v0, Landroid/graphics/Rect;->bottom:I

    iput v2, p0, Lcom/nvidia/devtech/HeightProvider;->heightMaxHorizontal:I

    .line 88
    :cond_2
    iget v2, p0, Lcom/nvidia/devtech/HeightProvider;->heightMaxHorizontal:I

    iget v3, v0, Landroid/graphics/Rect;->bottom:I

    sub-int/2addr v2, v3

    .line 91
    .end local v1    # "keyboardHeight":I
    .restart local v2    # "keyboardHeight":I
    :goto_0
    iget-object v1, p0, Lcom/nvidia/devtech/HeightProvider;->listener:Lcom/nvidia/devtech/HeightProvider$HeightListener;

    if-eqz v1, :cond_3

    .line 92
    iget-object v3, p0, Lcom/nvidia/devtech/HeightProvider;->mActivity:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v3

    iget v3, v3, Landroid/content/res/Configuration;->orientation:I

    invoke-interface {v1, v3, v2}, Lcom/nvidia/devtech/HeightProvider$HeightListener;->onHeightChanged(II)V

    .line 94
    :cond_3
    return-void
.end method

.method public setHeightListener(Lcom/nvidia/devtech/HeightProvider$HeightListener;)Lcom/nvidia/devtech/HeightProvider;
    .locals 0
    .param p1, "listener"    # Lcom/nvidia/devtech/HeightProvider$HeightListener;

    .line 65
    iput-object p1, p0, Lcom/nvidia/devtech/HeightProvider;->listener:Lcom/nvidia/devtech/HeightProvider$HeightListener;

    .line 66
    return-object p0
.end method
