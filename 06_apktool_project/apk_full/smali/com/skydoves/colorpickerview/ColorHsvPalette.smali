.class public Lcom/skydoves/colorpickerview/ColorHsvPalette;
.super Landroid/graphics/drawable/BitmapDrawable;
.source "ColorHsvPalette.java"


# instance fields
.field private huePaint:Landroid/graphics/Paint;

.field private saturationPaint:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V
    .locals 2
    .param p1, "resources"    # Landroid/content/res/Resources;
    .param p2, "bitmap"    # Landroid/graphics/Bitmap;

    .line 43
    invoke-direct {p0, p1, p2}, Landroid/graphics/drawable/BitmapDrawable;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    .line 44
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->huePaint:Landroid/graphics/Paint;

    .line 45
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->saturationPaint:Landroid/graphics/Paint;

    .line 46
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 14
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 50
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorHsvPalette;->getBounds()Landroid/graphics/Rect;

    move-result-object v0

    invoke-virtual {v0}, Landroid/graphics/Rect;->width()I

    move-result v0

    .line 51
    .local v0, "width":I
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorHsvPalette;->getBounds()Landroid/graphics/Rect;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Rect;->height()I

    move-result v1

    .line 52
    .local v1, "height":I
    int-to-float v2, v0

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v2, v2, v3

    .line 53
    .local v2, "centerX":F
    int-to-float v4, v1

    mul-float v11, v4, v3

    .line 54
    .local v11, "centerY":F
    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v4

    int-to-float v4, v4

    mul-float v3, v3, v4

    .line 56
    .local v3, "radius":F
    new-instance v4, Landroid/graphics/SweepGradient;

    const/4 v5, 0x7

    new-array v6, v5, [I

    fill-array-data v6, :array_0

    new-array v5, v5, [F

    fill-array-data v5, :array_1

    invoke-direct {v4, v2, v11, v6, v5}, Landroid/graphics/SweepGradient;-><init>(FF[I[F)V

    move-object v12, v4

    .line 65
    .local v12, "sweepShader":Landroid/graphics/Shader;
    iget-object v4, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->huePaint:Landroid/graphics/Paint;

    invoke-virtual {v4, v12}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 67
    new-instance v13, Landroid/graphics/RadialGradient;

    sget-object v10, Landroid/graphics/Shader$TileMode;->CLAMP:Landroid/graphics/Shader$TileMode;

    const/4 v8, -0x1

    const v9, 0xffffff

    move-object v4, v13

    move v5, v2

    move v6, v11

    move v7, v3

    invoke-direct/range {v4 .. v10}, Landroid/graphics/RadialGradient;-><init>(FFFIILandroid/graphics/Shader$TileMode;)V

    .line 70
    .local v4, "saturationShader":Landroid/graphics/Shader;
    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->saturationPaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 72
    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->huePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, v11, v3, v5}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 73
    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->saturationPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v2, v11, v3, v5}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 74
    return-void

    :array_0
    .array-data 4
        -0x10000
        -0xff01
        -0xffff01
        -0xff0001
        -0xff0100
        -0x100
        -0x10000
    .end array-data

    :array_1
    .array-data 4
        0x0
        0x3e29fbe7    # 0.166f
        0x3eaa7efa    # 0.333f
        0x3eff7cee    # 0.499f
        0x3f2a7efa    # 0.666f
        0x3f553f7d    # 0.833f
        0x3f7fbe77    # 0.999f
    .end array-data
.end method

.method public getOpacity()I
    .locals 1

    .line 88
    const/4 v0, -0x1

    return v0
.end method

.method public setAlpha(I)V
    .locals 1
    .param p1, "alpha"    # I

    .line 78
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->huePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 79
    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 1
    .param p1, "colorFilter"    # Landroid/graphics/ColorFilter;

    .line 83
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorHsvPalette;->huePaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 84
    return-void
.end method
