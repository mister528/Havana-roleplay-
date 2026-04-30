.class public abstract Lcom/skydoves/colorpickerview/sliders/AbstractSlider;
.super Landroid/widget/FrameLayout;
.source "AbstractSlider.java"


# instance fields
.field protected borderColor:I

.field protected borderPaint:Landroid/graphics/Paint;

.field protected borderSize:I

.field protected color:I

.field protected colorPaint:Landroid/graphics/Paint;

.field public colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

.field protected preferenceName:Ljava/lang/String;

.field protected selectedX:I

.field protected selector:Landroid/widget/ImageView;

.field protected selectorDrawable:Landroid/graphics/drawable/Drawable;

.field protected selectorPosition:F


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 56
    invoke-direct {p0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 46
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 47
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 49
    const/4 v0, 0x2

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderSize:I

    .line 50
    const/high16 v0, -0x1000000

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderColor:I

    .line 51
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->color:I

    .line 57
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onCreate()V

    .line 58
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 61
    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 46
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 47
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 49
    const/4 v0, 0x2

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderSize:I

    .line 50
    const/high16 v0, -0x1000000

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderColor:I

    .line 51
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->color:I

    .line 62
    invoke-virtual {p0, p2}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getAttrs(Landroid/util/AttributeSet;)V

    .line 63
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onCreate()V

    .line 64
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 67
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 46
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 47
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 49
    const/4 v0, 0x2

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderSize:I

    .line 50
    const/high16 v0, -0x1000000

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderColor:I

    .line 51
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->color:I

    .line 68
    invoke-virtual {p0, p2}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getAttrs(Landroid/util/AttributeSet;)V

    .line 69
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onCreate()V

    .line 70
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I
    .param p4, "defStyleRes"    # I

    .line 74
    invoke-direct {p0, p1, p2, p3, p4}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    .line 46
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 47
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 49
    const/4 v0, 0x2

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderSize:I

    .line 50
    const/high16 v0, -0x1000000

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderColor:I

    .line 51
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->color:I

    .line 75
    invoke-virtual {p0, p2}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getAttrs(Landroid/util/AttributeSet;)V

    .line 76
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onCreate()V

    .line 77
    return-void
.end method

.method private getBoundaryX(F)F
    .locals 3
    .param p1, "x"    # F

    .line 200
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredWidth()I

    move-result v0

    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v1

    sub-int/2addr v0, v1

    .line 201
    .local v0, "maxPos":I
    int-to-float v1, v0

    cmpl-float v1, p1, v1

    if-ltz v1, :cond_0

    int-to-float v1, v0

    return v1

    .line 202
    :cond_0
    const/4 v1, 0x0

    cmpg-float v2, p1, v1

    if-gtz v2, :cond_1

    return v1

    .line 203
    :cond_1
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float v1, v1, v2

    sub-float v1, p1, v1

    return v1
.end method

.method private initializeSelector()V
    .locals 2

    .line 207
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    new-instance v1, Lcom/skydoves/colorpickerview/sliders/AbstractSlider$1;

    invoke-direct {v1, p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider$1;-><init>(Lcom/skydoves/colorpickerview/sliders/AbstractSlider;)V

    .line 208
    invoke-virtual {v0, v1}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    .line 220
    return-void
.end method

.method private onCreate()V
    .locals 2

    .line 93
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPaint:Landroid/graphics/Paint;

    .line 94
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderPaint:Landroid/graphics/Paint;

    .line 95
    sget-object v1, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 96
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderSize:I

    int-to-float v1, v1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 97
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderColor:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 98
    const/4 v0, -0x1

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->setBackgroundColor(I)V

    .line 100
    new-instance v0, Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    .line 101
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_0

    .line 102
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 104
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v1, -0x2

    invoke-direct {v0, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 107
    .local v0, "thumbParams":Landroid/widget/FrameLayout$LayoutParams;
    const/16 v1, 0x10

    iput v1, v0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    .line 108
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {p0, v1, v0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 111
    .end local v0    # "thumbParams":Landroid/widget/FrameLayout$LayoutParams;
    :cond_0
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->initializeSelector()V

    .line 112
    return-void
.end method

.method private onTouchReceived(Landroid/view/MotionEvent;)V
    .locals 8
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 151
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    .line 152
    .local v0, "eventX":F
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v1

    int-to-float v1, v1

    .line 153
    .local v1, "left":F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredWidth()I

    move-result v2

    iget-object v3, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v3}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v3

    sub-int/2addr v2, v3

    int-to-float v2, v2

    .line 154
    .local v2, "right":F
    cmpg-float v3, v0, v1

    if-gez v3, :cond_0

    move v0, v1

    .line 155
    :cond_0
    cmpl-float v3, v0, v2

    if-lez v3, :cond_1

    move v0, v2

    .line 156
    :cond_1
    sub-float v3, v0, v1

    sub-float v4, v2, v1

    div-float/2addr v3, v4

    iput v3, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 157
    const/high16 v4, 0x3f800000    # 1.0f

    cmpl-float v3, v3, v4

    if-lez v3, :cond_2

    iput v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 159
    :cond_2
    new-instance v3, Landroid/graphics/Point;

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v4

    float-to-int v4, v4

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v5

    float-to-int v5, v5

    invoke-direct {v3, v4, v5}, Landroid/graphics/Point;-><init>(II)V

    .line 160
    .local v3, "snapPoint":Landroid/graphics/Point;
    iget v4, v3, Landroid/graphics/Point;->x:I

    iput v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 161
    iget-object v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    iget v5, v3, Landroid/graphics/Point;->x:I

    int-to-float v5, v5

    iget-object v6, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v6}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v6

    int-to-float v6, v6

    const/high16 v7, 0x3f000000    # 0.5f

    mul-float v6, v6, v7

    sub-float/2addr v5, v6

    invoke-virtual {v4, v5}, Landroid/widget/ImageView;->setX(F)V

    .line 162
    iget-object v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v4}, Lcom/skydoves/colorpickerview/ColorPickerView;->getActionMode()Lcom/skydoves/colorpickerview/ActionMode;

    move-result-object v4

    sget-object v5, Lcom/skydoves/colorpickerview/ActionMode;->LAST:Lcom/skydoves/colorpickerview/ActionMode;

    const/4 v6, 0x1

    if-ne v4, v5, :cond_3

    .line 163
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v4

    if-ne v4, v6, :cond_4

    .line 164
    iget-object v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->assembleColor()I

    move-result v5

    invoke-virtual {v4, v5, v6}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    goto :goto_0

    .line 167
    :cond_3
    iget-object v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->assembleColor()I

    move-result v5

    invoke-virtual {v4, v5, v6}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    .line 170
    :cond_4
    :goto_0
    iget-object v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v4}, Lcom/skydoves/colorpickerview/ColorPickerView;->getFlagView()Lcom/skydoves/colorpickerview/flag/FlagView;

    move-result-object v4

    if-eqz v4, :cond_5

    .line 171
    iget-object v4, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v4}, Lcom/skydoves/colorpickerview/ColorPickerView;->getFlagView()Lcom/skydoves/colorpickerview/flag/FlagView;

    move-result-object v4

    invoke-virtual {v4, p1}, Lcom/skydoves/colorpickerview/flag/FlagView;->receiveOnTouchEvent(Landroid/view/MotionEvent;)V

    .line 174
    :cond_5
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredWidth()I

    move-result v4

    iget-object v5, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v5}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v5

    sub-int/2addr v4, v5

    .line 175
    .local v4, "maxPos":I
    iget-object v5, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v5}, Landroid/widget/ImageView;->getX()F

    move-result v5

    int-to-float v6, v4

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_6

    iget-object v5, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    int-to-float v6, v4

    invoke-virtual {v5, v6}, Landroid/widget/ImageView;->setX(F)V

    .line 176
    :cond_6
    iget-object v5, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v5}, Landroid/widget/ImageView;->getX()F

    move-result v5

    const/4 v6, 0x0

    cmpg-float v5, v5, v6

    if-gtz v5, :cond_7

    iget-object v5, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v5, v6}, Landroid/widget/ImageView;->setX(F)V

    .line 177
    :cond_7
    return-void
.end method


# virtual methods
.method public abstract assembleColor()I
.end method

.method public attachColorPickerView(Lcom/skydoves/colorpickerview/ColorPickerView;)V
    .locals 0
    .param p1, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 240
    iput-object p1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 241
    return-void
.end method

.method protected abstract getAttrs(Landroid/util/AttributeSet;)V
.end method

.method public getColor()I
    .locals 1

    .line 231
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->color:I

    return v0
.end method

.method public getPreferenceName()Ljava/lang/String;
    .locals 1

    .line 267
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->preferenceName:Ljava/lang/String;

    return-object v0
.end method

.method public getSelectedX()I
    .locals 1

    .line 258
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    return v0
.end method

.method protected getSelectorPosition()F
    .locals 1

    .line 249
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    return v0
.end method

.method public notifyColor()V
    .locals 1

    .line 125
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPureColor()I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->color:I

    .line 126
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPaint:Landroid/graphics/Paint;

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->updatePaint(Landroid/graphics/Paint;)V

    .line 127
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->invalidate()V

    .line 128
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 8
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 116
    invoke-super {p0, p1}, Landroid/widget/FrameLayout;->onDraw(Landroid/graphics/Canvas;)V

    .line 117
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredWidth()I

    move-result v0

    int-to-float v0, v0

    .line 118
    .local v0, "width":F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredHeight()I

    move-result v1

    int-to-float v7, v1

    .line 119
    .local v7, "height":F
    iget-object v6, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPaint:Landroid/graphics/Paint;

    const/4 v2, 0x0

    const/4 v3, 0x0

    move-object v1, p1

    move v4, v0

    move v5, v7

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 120
    iget-object v6, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderPaint:Landroid/graphics/Paint;

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawRect(FFFFLandroid/graphics/Paint;)V

    .line 121
    return-void
.end method

.method public abstract onInflateFinished()V
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 133
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 134
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/4 v2, 0x1

    if-eqz v0, :cond_0

    if-eq v0, v2, :cond_0

    const/4 v3, 0x2

    if-eq v0, v3, :cond_0

    .line 142
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setPressed(Z)V

    .line 143
    return v1

    .line 138
    :cond_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0, v2}, Landroid/widget/ImageView;->setPressed(Z)V

    .line 139
    invoke-direct {p0, p1}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->onTouchReceived(Landroid/view/MotionEvent;)V

    .line 140
    return v2

    .line 146
    :cond_1
    return v1
.end method

.method public setPreferenceName(Ljava/lang/String;)V
    .locals 0
    .param p1, "preferenceName"    # Ljava/lang/String;

    .line 276
    iput-object p1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->preferenceName:Ljava/lang/String;

    .line 277
    return-void
.end method

.method public setSelectorPosition(F)V
    .locals 3
    .param p1, "selectorPosition"    # F

    .line 190
    const/high16 v0, 0x3f800000    # 1.0f

    invoke-static {p1, v0}, Ljava/lang/Math;->min(FF)F

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 191
    nop

    .line 192
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredWidth()I

    move-result v0

    int-to-float v0, v0

    mul-float v0, v0, p1

    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    .line 193
    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float v1, v1, v2

    sub-float/2addr v0, v1

    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->borderSize:I

    int-to-float v1, v1

    mul-float v1, v1, v2

    sub-float/2addr v0, v1

    .line 195
    .local v0, "x":F
    invoke-direct {p0, v0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getBoundaryX(F)F

    move-result v1

    float-to-int v1, v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 196
    iget-object v2, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    int-to-float v1, v1

    invoke-virtual {v2, v1}, Landroid/widget/ImageView;->setX(F)V

    .line 197
    return-void
.end method

.method protected abstract updatePaint(Landroid/graphics/Paint;)V
.end method

.method public updateSelectorX(I)V
    .locals 5
    .param p1, "x"    # I

    .line 180
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v0

    int-to-float v0, v0

    .line 181
    .local v0, "left":F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getMeasuredWidth()I

    move-result v1

    iget-object v2, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    invoke-virtual {v2}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v2

    sub-int/2addr v1, v2

    int-to-float v1, v1

    .line 182
    .local v1, "right":F
    int-to-float v2, p1

    sub-float/2addr v2, v0

    sub-float v3, v1, v0

    div-float/2addr v2, v3

    iput v2, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 183
    const/high16 v3, 0x3f800000    # 1.0f

    cmpl-float v2, v2, v3

    if-lez v2, :cond_0

    iput v3, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectorPosition:F

    .line 184
    :cond_0
    int-to-float v2, p1

    invoke-direct {p0, v2}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->getBoundaryX(F)F

    move-result v2

    float-to-int v2, v2

    iput v2, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selectedX:I

    .line 185
    iget-object v3, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->selector:Landroid/widget/ImageView;

    int-to-float v2, v2

    invoke-virtual {v3, v2}, Landroid/widget/ImageView;->setX(F)V

    .line 186
    iget-object v2, p0, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/sliders/AbstractSlider;->assembleColor()I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    .line 187
    return-void
.end method
