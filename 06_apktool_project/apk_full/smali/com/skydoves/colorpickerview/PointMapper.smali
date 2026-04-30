.class Lcom/skydoves/colorpickerview/PointMapper;
.super Ljava/lang/Object;
.source "PointMapper.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static approximatedPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;Landroid/graphics/Point;)Landroid/graphics/Point;
    .locals 3
    .param p0, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;
    .param p1, "start"    # Landroid/graphics/Point;
    .param p2, "end"    # Landroid/graphics/Point;

    .line 33
    invoke-static {p1, p2}, Lcom/skydoves/colorpickerview/PointMapper;->getDistance(Landroid/graphics/Point;Landroid/graphics/Point;)I

    move-result v0

    const/4 v1, 0x3

    if-gt v0, v1, :cond_0

    return-object p2

    .line 34
    :cond_0
    invoke-static {p1, p2}, Lcom/skydoves/colorpickerview/PointMapper;->getCenterPoint(Landroid/graphics/Point;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v0

    .line 35
    .local v0, "center":Landroid/graphics/Point;
    iget v1, v0, Landroid/graphics/Point;->x:I

    int-to-float v1, v1

    iget v2, v0, Landroid/graphics/Point;->y:I

    int-to-float v2, v2

    invoke-virtual {p0, v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorFromBitmap(FF)I

    move-result v1

    .line 36
    .local v1, "color":I
    if-nez v1, :cond_1

    .line 37
    invoke-static {p0, v0, p2}, Lcom/skydoves/colorpickerview/PointMapper;->approximatedPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v2

    return-object v2

    .line 39
    :cond_1
    invoke-static {p0, p1, v0}, Lcom/skydoves/colorpickerview/PointMapper;->approximatedPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v2

    return-object v2
.end method

.method private static getCenterPoint(Landroid/graphics/Point;Landroid/graphics/Point;)Landroid/graphics/Point;
    .locals 4
    .param p0, "start"    # Landroid/graphics/Point;
    .param p1, "end"    # Landroid/graphics/Point;

    .line 58
    new-instance v0, Landroid/graphics/Point;

    iget v1, p1, Landroid/graphics/Point;->x:I

    iget v2, p0, Landroid/graphics/Point;->x:I

    add-int/2addr v1, v2

    div-int/lit8 v1, v1, 0x2

    iget v2, p1, Landroid/graphics/Point;->y:I

    iget v3, p0, Landroid/graphics/Point;->y:I

    add-int/2addr v2, v3

    div-int/lit8 v2, v2, 0x2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    return-object v0
.end method

.method protected static getColorPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;
    .locals 3
    .param p0, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;
    .param p1, "point"    # Landroid/graphics/Point;

    .line 26
    new-instance v0, Landroid/graphics/Point;

    .line 27
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredHeight()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    .line 28
    .local v0, "center":Landroid/graphics/Point;
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->isHuePalette()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-static {p0, p1}, Lcom/skydoves/colorpickerview/PointMapper;->getHuePoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v1

    return-object v1

    .line 29
    :cond_0
    invoke-static {p0, p1, v0}, Lcom/skydoves/colorpickerview/PointMapper;->approximatedPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v1

    return-object v1
.end method

.method private static getDistance(Landroid/graphics/Point;Landroid/graphics/Point;)I
    .locals 4
    .param p0, "start"    # Landroid/graphics/Point;
    .param p1, "end"    # Landroid/graphics/Point;

    .line 62
    iget v0, p1, Landroid/graphics/Point;->x:I

    iget v1, p0, Landroid/graphics/Point;->x:I

    sub-int/2addr v0, v1

    .line 64
    invoke-static {v0}, Ljava/lang/Math;->abs(I)I

    move-result v0

    iget v1, p1, Landroid/graphics/Point;->x:I

    iget v2, p0, Landroid/graphics/Point;->x:I

    sub-int/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    mul-int v0, v0, v1

    iget v1, p1, Landroid/graphics/Point;->y:I

    iget v2, p0, Landroid/graphics/Point;->y:I

    sub-int/2addr v1, v2

    .line 65
    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    iget v2, p1, Landroid/graphics/Point;->y:I

    iget v3, p0, Landroid/graphics/Point;->y:I

    sub-int/2addr v2, v3

    invoke-static {v2}, Ljava/lang/Math;->abs(I)I

    move-result v2

    mul-int v1, v1, v2

    add-int/2addr v0, v1

    int-to-double v0, v0

    .line 63
    invoke-static {v0, v1}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v0

    double-to-int v0, v0

    .line 62
    return v0
.end method

.method private static getHuePoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;
    .locals 11
    .param p0, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;
    .param p1, "point"    # Landroid/graphics/Point;

    .line 44
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getWidth()I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x3f000000    # 0.5f

    mul-float v0, v0, v1

    .line 45
    .local v0, "centerX":F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getHeight()I

    move-result v2

    int-to-float v2, v2

    mul-float v2, v2, v1

    .line 46
    .local v2, "centerY":F
    iget v1, p1, Landroid/graphics/Point;->x:I

    int-to-float v1, v1

    sub-float/2addr v1, v0

    .line 47
    .local v1, "x":F
    iget v3, p1, Landroid/graphics/Point;->y:I

    int-to-float v3, v3

    sub-float/2addr v3, v2

    .line 48
    .local v3, "y":F
    invoke-static {v0, v2}, Ljava/lang/Math;->min(FF)F

    move-result v4

    .line 49
    .local v4, "radius":F
    mul-float v5, v1, v1

    mul-float v6, v3, v3

    add-float/2addr v5, v6

    float-to-double v5, v5

    invoke-static {v5, v6}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v5

    .line 50
    .local v5, "r":D
    float-to-double v7, v4

    cmpl-double v9, v5, v7

    if-lez v9, :cond_0

    .line 51
    float-to-double v7, v1

    float-to-double v9, v4

    invoke-static {v9, v10}, Ljava/lang/Double;->isNaN(D)Z

    div-double/2addr v9, v5

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    double-to-float v1, v7

    .line 52
    float-to-double v7, v3

    float-to-double v9, v4

    invoke-static {v9, v10}, Ljava/lang/Double;->isNaN(D)Z

    div-double/2addr v9, v5

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    double-to-float v3, v7

    .line 54
    :cond_0
    new-instance v7, Landroid/graphics/Point;

    add-float v8, v1, v0

    float-to-int v8, v8

    add-float v9, v3, v2

    float-to-int v9, v9

    invoke-direct {v7, v8, v9}, Landroid/graphics/Point;-><init>(II)V

    return-object v7
.end method
