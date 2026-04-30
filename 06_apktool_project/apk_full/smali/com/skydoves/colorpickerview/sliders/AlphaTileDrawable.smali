.class public Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;
.super Landroid/graphics/drawable/Drawable;
.source "AlphaTileDrawable.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;
    }
.end annotation


# instance fields
.field private paint:Landroid/graphics/Paint;

.field private tileEvenColor:I

.field private tileOddColor:I

.field private tileSize:I


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 42
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 36
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->paint:Landroid/graphics/Paint;

    .line 43
    new-instance v0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;

    invoke-direct {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;-><init>()V

    .line 44
    .local v0, "builder":Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;
    invoke-static {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->access$000(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    .line 45
    invoke-static {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->access$100(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileOddColor:I

    .line 46
    invoke-static {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->access$200(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileEvenColor:I

    .line 47
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->drawTiles()V

    .line 48
    return-void
.end method

.method public constructor <init>(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)V
    .locals 2
    .param p1, "builder"    # Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;

    .line 51
    invoke-direct {p0}, Landroid/graphics/drawable/Drawable;-><init>()V

    .line 36
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x1

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->paint:Landroid/graphics/Paint;

    .line 52
    invoke-static {p1}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->access$000(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    .line 53
    invoke-static {p1}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->access$100(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileOddColor:I

    .line 54
    invoke-static {p1}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->access$200(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileEvenColor:I

    .line 55
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->drawTiles()V

    .line 56
    return-void
.end method

.method private drawTile(Landroid/graphics/Canvas;Landroid/graphics/Rect;Landroid/graphics/Paint;II)V
    .locals 0
    .param p1, "canvas"    # Landroid/graphics/Canvas;
    .param p2, "rect"    # Landroid/graphics/Rect;
    .param p3, "bitmapPaint"    # Landroid/graphics/Paint;
    .param p4, "dx"    # I
    .param p5, "dy"    # I

    .line 79
    invoke-virtual {p2, p4, p5}, Landroid/graphics/Rect;->offset(II)V

    .line 80
    invoke-virtual {p1, p2, p3}, Landroid/graphics/Canvas;->drawRect(Landroid/graphics/Rect;Landroid/graphics/Paint;)V

    .line 81
    return-void
.end method

.method private drawTiles()V
    .locals 12

    .line 59
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    mul-int/lit8 v1, v0, 0x2

    mul-int/lit8 v0, v0, 0x2

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v1, v0, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 60
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    new-instance v2, Landroid/graphics/Canvas;

    invoke-direct {v2, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 61
    .local v2, "canvas":Landroid/graphics/Canvas;
    new-instance v3, Landroid/graphics/Rect;

    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    const/4 v4, 0x0

    invoke-direct {v3, v4, v4, v1, v1}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 63
    .local v3, "rect":Landroid/graphics/Rect;
    new-instance v1, Landroid/graphics/Paint;

    const/4 v4, 0x1

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    move-object v11, v1

    .line 64
    .local v11, "bitmapPaint":Landroid/graphics/Paint;
    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {v11, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 66
    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileOddColor:I

    invoke-virtual {v11, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 67
    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p0

    move-object v4, v11

    invoke-direct/range {v1 .. v6}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->drawTile(Landroid/graphics/Canvas;Landroid/graphics/Rect;Landroid/graphics/Paint;II)V

    .line 68
    iget v10, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    move-object v5, p0

    move-object v6, v2

    move-object v7, v3

    move-object v8, v11

    move v9, v10

    invoke-direct/range {v5 .. v10}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->drawTile(Landroid/graphics/Canvas;Landroid/graphics/Rect;Landroid/graphics/Paint;II)V

    .line 70
    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileEvenColor:I

    invoke-virtual {v11, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 71
    iget v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    neg-int v9, v1

    const/4 v10, 0x0

    invoke-direct/range {v5 .. v10}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->drawTile(Landroid/graphics/Canvas;Landroid/graphics/Rect;Landroid/graphics/Paint;II)V

    .line 72
    iget v9, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->tileSize:I

    neg-int v10, v9

    invoke-direct/range {v5 .. v10}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->drawTile(Landroid/graphics/Canvas;Landroid/graphics/Rect;Landroid/graphics/Paint;II)V

    .line 74
    iget-object v1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->paint:Landroid/graphics/Paint;

    new-instance v4, Landroid/graphics/BitmapShader;

    sget-object v5, Landroid/graphics/Shader$TileMode;->REPEAT:Landroid/graphics/Shader$TileMode;

    sget-object v6, Landroid/graphics/Shader$TileMode;->REPEAT:Landroid/graphics/Shader$TileMode;

    invoke-direct {v4, v0, v5, v6}, Landroid/graphics/BitmapShader;-><init>(Landroid/graphics/Bitmap;Landroid/graphics/Shader$TileMode;Landroid/graphics/Shader$TileMode;)V

    invoke-virtual {v1, v4}, Landroid/graphics/Paint;->setShader(Landroid/graphics/Shader;)Landroid/graphics/Shader;

    .line 76
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 1
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 85
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0}, Landroid/graphics/Canvas;->drawPaint(Landroid/graphics/Paint;)V

    .line 86
    return-void
.end method

.method public getOpacity()I
    .locals 1

    .line 100
    const/4 v0, -0x1

    return v0
.end method

.method public setAlpha(I)V
    .locals 1
    .param p1, "alpha"    # I

    .line 90
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 91
    return-void
.end method

.method public setColorFilter(Landroid/graphics/ColorFilter;)V
    .locals 1
    .param p1, "colorFilter"    # Landroid/graphics/ColorFilter;

    .line 95
    iget-object v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColorFilter(Landroid/graphics/ColorFilter;)Landroid/graphics/ColorFilter;

    .line 96
    return-void
.end method
