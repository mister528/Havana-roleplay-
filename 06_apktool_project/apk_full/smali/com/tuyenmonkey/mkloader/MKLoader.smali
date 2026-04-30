.class public Lcom/tuyenmonkey/mkloader/MKLoader;
.super Landroid/view/View;
.source "MKLoader.java"

# interfaces
.implements Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;


# instance fields
.field private loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 21
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 22
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-direct {p0, p1, v0, v1}, Lcom/tuyenmonkey/mkloader/MKLoader;->initialize(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 23
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 26
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 27
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0}, Lcom/tuyenmonkey/mkloader/MKLoader;->initialize(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 28
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 31
    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 32
    invoke-direct {p0, p1, p2, p3}, Lcom/tuyenmonkey/mkloader/MKLoader;->initialize(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 33
    return-void
.end method

.method private initialize(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 36
    sget-object v0, Lcom/tuyenmonkey/mkloader/R$styleable;->MKLoader:[I

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 37
    .local v0, "typedArray":Landroid/content/res/TypedArray;
    sget v1, Lcom/tuyenmonkey/mkloader/R$styleable;->MKLoader_mk_type:I

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v1

    .line 39
    .local v1, "loaderType":I
    invoke-static {v1}, Lcom/tuyenmonkey/mkloader/util/LoaderGenerator;->generateLoaderView(I)Lcom/tuyenmonkey/mkloader/type/LoaderView;

    move-result-object v2

    iput-object v2, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    .line 40
    sget v3, Lcom/tuyenmonkey/mkloader/R$styleable;->MKLoader_mk_color:I

    const-string v4, "#ffffff"

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v4

    invoke-virtual {v0, v3, v4}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v3

    invoke-virtual {v2, v3}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->setColor(I)V

    .line 42
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 43
    return-void
.end method


# virtual methods
.method protected onAttachedToWindow()V
    .locals 1

    .line 69
    invoke-super {p0}, Landroid/view/View;->onAttachedToWindow()V

    .line 70
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->isDetached()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 71
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {v0, p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->setInvalidateListener(Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;)V

    .line 73
    :cond_0
    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 1

    .line 76
    invoke-super {p0}, Landroid/view/View;->onDetachedFromWindow()V

    .line 77
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    if-eqz v0, :cond_0

    .line 78
    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->onDetach()V

    .line 80
    :cond_0
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 1
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 60
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 61
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {v0, p1}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->draw(Landroid/graphics/Canvas;)V

    .line 62
    return-void
.end method

.method protected onLayout(ZIIII)V
    .locals 3
    .param p1, "changed"    # Z
    .param p2, "left"    # I
    .param p3, "top"    # I
    .param p4, "right"    # I
    .param p5, "bottom"    # I

    .line 53
    invoke-super/range {p0 .. p5}, Landroid/view/View;->onLayout(ZIIII)V

    .line 54
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {p0}, Lcom/tuyenmonkey/mkloader/MKLoader;->getWidth()I

    move-result v1

    invoke-virtual {p0}, Lcom/tuyenmonkey/mkloader/MKLoader;->getHeight()I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->setSize(II)V

    .line 55
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->initializeObjects()V

    .line 56
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->setUpAnimation()V

    .line 57
    return-void
.end method

.method protected onMeasure(II)V
    .locals 2
    .param p1, "widthMeasureSpec"    # I
    .param p2, "heightMeasureSpec"    # I

    .line 46
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {v0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->getDesiredWidth()I

    move-result v0

    invoke-static {v0, p1}, Lcom/tuyenmonkey/mkloader/MKLoader;->resolveSize(II)I

    move-result v0

    .line 47
    .local v0, "measuredWidth":I
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/MKLoader;->loaderView:Lcom/tuyenmonkey/mkloader/type/LoaderView;

    invoke-virtual {v1}, Lcom/tuyenmonkey/mkloader/type/LoaderView;->getDesiredHeight()I

    move-result v1

    invoke-static {v1, p2}, Lcom/tuyenmonkey/mkloader/MKLoader;->resolveSize(II)I

    move-result v1

    .line 49
    .local v1, "measuredHeight":I
    invoke-virtual {p0, v0, v1}, Lcom/tuyenmonkey/mkloader/MKLoader;->setMeasuredDimension(II)V

    .line 50
    return-void
.end method

.method public reDraw()V
    .locals 0

    .line 65
    invoke-virtual {p0}, Lcom/tuyenmonkey/mkloader/MKLoader;->invalidate()V

    .line 66
    return-void
.end method
