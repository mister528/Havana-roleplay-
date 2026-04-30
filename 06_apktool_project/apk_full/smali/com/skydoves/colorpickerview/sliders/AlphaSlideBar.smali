.class public Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
.super Lcom/skydoves/colorpickerview/sliders/AbstractSlider;
.source "AlphaSlideBar.java"


# instance fields
.field private backgroundBitmap:Landroid/graphics/Bitmap;

.field private drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 43
    invoke-direct {p0, p1}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;)V

    .line 40
    new-instance v0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-direct {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    .line 44
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 47
    invoke-direct {p0, p1, p2}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 40
    new-instance v0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-direct {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    .line 48
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 51
    invoke-direct {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 40
    new-instance v0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-direct {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    .line 52
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I
    .param p4, "defStyleRes"    # I

    .line 55
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    .line 40
    new-instance v0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-direct {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    .line 56
    return-void
.end method


# virtual methods
.method public assembleColor()I
    .locals 3

    .line 128
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 129
    .local v0, "hsv":[F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getColor()I

    move-result v1

    invoke-static {v1, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 130
    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->selectorPosition:F

    const/high16 v2, 0x437f0000    # 255.0f

    mul-float v1, v1, v2

    float-to-int v1, v1

    .line 131
    .local v1, "alpha":I
    invoke-static {v1, v0}, Landroid/graphics/Color;->HSVToColor(I[F)I

    move-result v2

    return v2
.end method

.method protected getAttrs(Landroid/util/AttributeSet;)V
    .locals 3
    .param p1, "attrs"    # Landroid/util/AttributeSet;

    .line 60
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar:[I

    invoke-virtual {v0, p1, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 62
    .local v0, "a":Landroid/content/res/TypedArray;
    :try_start_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar_selector_AlphaSlideBar:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 63
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar_selector_AlphaSlideBar:I

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v1

    .line 64
    .local v1, "resourceId":I
    if-eq v1, v2, :cond_0

    .line 65
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v1}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    .line 68
    .end local v1    # "resourceId":I
    :cond_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar_borderColor_AlphaSlideBar:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 69
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar_borderColor_AlphaSlideBar:I

    iget v2, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->borderColor:I

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->borderColor:I

    .line 71
    :cond_1
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar_borderSize_AlphaSlideBar:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 72
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->AlphaSlideBar_borderSize_AlphaSlideBar:I

    iget v2, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->borderSize:I

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->borderSize:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 75
    :cond_2
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 76
    nop

    .line 77
    return-void

    .line 75
    :catchall_0
    move-exception v1

    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    throw v1
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 3
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 122
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->backgroundBitmap:Landroid/graphics/Bitmap;

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v1, v1, v2}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    .line 123
    invoke-super {p0, p1}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onDraw(Landroid/graphics/Canvas;)V

    .line 124
    return-void
.end method

.method public onInflateFinished()V
    .locals 3

    .line 110
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getMeasuredWidth()I

    move-result v0

    .line 111
    .local v0, "defaultPosition":I
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getPreferenceName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 112
    nop

    .line 113
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v1

    .line 114
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getPreferenceName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getAlphaSliderPosition(Ljava/lang/String;I)I

    move-result v1

    .line 112
    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->updateSelectorX(I)V

    goto :goto_0

    .line 116
    :cond_0
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->selector:Landroid/widget/ImageView;

    int-to-float v2, v0

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setX(F)V

    .line 118
    :goto_0
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 5
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "oldWidth"    # I
    .param p4, "oldHeight"    # I

    .line 81
    invoke-super {p0, p1, p2, p3, p4}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onSizeChanged(IIII)V

    .line 82
    if-lez p1, :cond_0

    if-lez p2, :cond_0

    .line 83
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p1, p2, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->backgroundBitmap:Landroid/graphics/Bitmap;

    .line 84
    new-instance v0, Landroid/graphics/Canvas;

    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->backgroundBitmap:Landroid/graphics/Bitmap;

    invoke-direct {v0, v1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 85
    .local v0, "backgroundCanvas":Landroid/graphics/Canvas;
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-virtual {v0}, Landroid/graphics/Canvas;->getWidth()I

    move-result v2

    invoke-virtual {v0}, Landroid/graphics/Canvas;->getHeight()I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v1, v4, v4, v2, v3}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->setBounds(IIII)V

    .line 86
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->drawable:Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-virtual {v1, v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->draw(Landroid/graphics/Canvas;)V

    .line 88
    .end local v0    # "backgroundCanvas":Landroid/graphics/Canvas;
    :cond_0
    return-void
.end method

.method public updatePaint(Landroid/graphics/Paint;)V
    .locals 12
    .param p1, "colorPaint"    # Landroid/graphics/Paint;

    .line 92
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 93
    .local v0, "hsv":[F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getColor()I

    move-result v1

    invoke-static {v1, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 94
    const/4 v1, 0x0

    invoke-static {v1, v0}, Landroid/graphics/Color;->HSVToColor(I[F)I

    move-result v1

    .line 95
    .local v1, "startColor":I
    const/16 v2, 0xff

    invoke-static {v2, v0}, Landroid/graphics/Color;->HSVToColor(I[F)I

    move-result v10

    .line 96
    .local v10, "endColor":I
    new-instance v11, Landroid/graphics/LinearGradient;

    .line 100
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getMeasuredWidth()I

    move-result v2

    int-to-float v5, v2

    .line 101
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getMeasuredHeight()I

    move-result v2

    int-to-float v6, v2

    sget-object v9, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v2, v11

    move v7, v1

    move v8, v10

    invoke-direct/range {v2 .. v9}, Landroid/graphics/LinearGradient;-><init>(FFFFIILandroid/graphics/Shader$TileMode;)V

    .line 105
    .local v2, "shader":Landroid/graphics/Shader;
    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 106
    return-void
.end method
