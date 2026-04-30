.class public Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
.super Lcom/skydoves/colorpickerview/sliders/AbstractSlider;
.source "BrightnessSlideBar.java"


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 39
    invoke-direct {p0, p1}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;)V

    .line 40
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 43
    invoke-direct {p0, p1, p2}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 44
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 47
    invoke-direct {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 48
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I
    .param p4, "defStyleRes"    # I

    .line 52
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    .line 53
    return-void
.end method


# virtual methods
.method public assembleColor()I
    .locals 3

    .line 107
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 108
    .local v0, "hsv":[F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getColor()I

    move-result v1

    invoke-static {v1, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 109
    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->selectorPosition:F

    const/4 v2, 0x2

    aput v1, v0, v2

    .line 110
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 111
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getSelectorPosition()F

    move-result v1

    const/high16 v2, 0x437f0000    # 255.0f

    mul-float v1, v1, v2

    float-to-int v1, v1

    .line 112
    .local v1, "alpha":I
    invoke-static {v1, v0}, Landroid/graphics/Color;->HSVToColor(I[F)I

    move-result v2

    return v2

    .line 114
    .end local v1    # "alpha":I
    :cond_0
    invoke-static {v0}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v1

    return v1
.end method

.method protected getAttrs(Landroid/util/AttributeSet;)V
    .locals 3
    .param p1, "attrs"    # Landroid/util/AttributeSet;

    .line 57
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar:[I

    invoke-virtual {v0, p1, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 59
    .local v0, "a":Landroid/content/res/TypedArray;
    :try_start_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar_selector_BrightnessSlider:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 60
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar_selector_BrightnessSlider:I

    .line 61
    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v1

    .line 62
    .local v1, "resourceId":I
    if-eq v1, v2, :cond_0

    .line 63
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2, v1}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v2

    iput-object v2, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    .line 66
    .end local v1    # "resourceId":I
    :cond_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar_borderColor_BrightnessSlider:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 67
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar_borderColor_BrightnessSlider:I

    iget v2, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->borderColor:I

    .line 68
    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->borderColor:I

    .line 70
    :cond_1
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar_borderSize_BrightnessSlider:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 71
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->BrightnessSlideBar_borderSize_BrightnessSlider:I

    iget v2, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->borderSize:I

    .line 72
    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->borderSize:I
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

.method public onInflateFinished()V
    .locals 3

    .line 95
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getMeasuredWidth()I

    move-result v0

    .line 96
    .local v0, "defaultPosition":I
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getPreferenceName()Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 97
    nop

    .line 98
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v1

    .line 99
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getPreferenceName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getBrightnessSliderPosition(Ljava/lang/String;I)I

    move-result v1

    .line 97
    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->updateSelectorX(I)V

    goto :goto_0

    .line 101
    :cond_0
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->selector:Landroid/widget/ImageView;

    int-to-float v2, v0

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setX(F)V

    .line 103
    :goto_0
    return-void
.end method

.method protected updatePaint(Landroid/graphics/Paint;)V
    .locals 12
    .param p1, "colorPaint"    # Landroid/graphics/Paint;

    .line 81
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 82
    .local v0, "hsv":[F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getColor()I

    move-result v1

    invoke-static {v1, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 83
    const/4 v1, 0x0

    const/4 v2, 0x2

    aput v1, v0, v2

    .line 84
    invoke-static {v0}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v1

    .line 85
    .local v1, "startColor":I
    const/high16 v3, 0x3f800000    # 1.0f

    aput v3, v0, v2

    .line 86
    invoke-static {v0}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v2

    .line 87
    .local v2, "endColor":I
    new-instance v11, Landroid/graphics/LinearGradient;

    .line 89
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getWidth()I

    move-result v3

    int-to-float v6, v3

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getHeight()I

    move-result v3

    int-to-float v7, v3

    sget-object v10, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v3, v11

    move v8, v1

    move v9, v2

    invoke-direct/range {v3 .. v10}, Landroid/graphics/LinearGradient;-><init>(FFFFIILandroid/graphics/Shader$TileMode;)V

    .line 90
    .local v3, "shader":Landroid/graphics/Shader;
    invoke-virtual {p1, v3}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 91
    return-void
.end method
