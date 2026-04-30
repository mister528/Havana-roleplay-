.class public Lcom/tuyenmonkey/mkloader/type/Whirlpool;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "Whirlpool.java"


# instance fields
.field private arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

.field private numberOfArc:I

.field private rotates:[F


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 19
    const/4 v0, 0x3

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->numberOfArc:I

    .line 20
    return-void
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/Whirlpool;)[F
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    .line 13
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->rotates:[F

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 61
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->numberOfArc:I

    if-ge v0, v1, :cond_0

    .line 62
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 63
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->rotates:[F

    aget v1, v1, v0

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v1, v2, v3}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 64
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Arc;->draw(Landroid/graphics/Canvas;)V

    .line 65
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 61
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 67
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public initializeObjects()V
    .locals 9

    .line 23
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    .line 24
    .local v0, "r":F
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->numberOfArc:I

    new-array v2, v1, [Lcom/tuyenmonkey/mkloader/model/Arc;

    iput-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    .line 25
    new-array v1, v1, [F

    iput-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->rotates:[F

    .line 27
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->numberOfArc:I

    if-ge v1, v2, :cond_0

    .line 28
    const/high16 v2, 0x40800000    # 4.0f

    div-float v3, v0, v2

    int-to-float v4, v1

    mul-float v4, v4, v0

    div-float/2addr v4, v2

    add-float/2addr v3, v4

    .line 29
    .local v3, "d":F
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    new-instance v4, Lcom/tuyenmonkey/mkloader/model/Arc;

    invoke-direct {v4}, Lcom/tuyenmonkey/mkloader/model/Arc;-><init>()V

    aput-object v4, v2, v1

    .line 30
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->color:I

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setColor(I)V

    .line 31
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    new-instance v4, Landroid/graphics/RectF;

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->center:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->x:F

    sub-float/2addr v5, v3

    iget-object v6, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->center:Landroid/graphics/PointF;

    iget v6, v6, Landroid/graphics/PointF;->y:F

    sub-float/2addr v6, v3

    iget-object v7, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->center:Landroid/graphics/PointF;

    iget v7, v7, Landroid/graphics/PointF;->x:F

    add-float/2addr v7, v3

    iget-object v8, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->center:Landroid/graphics/PointF;

    iget v8, v8, Landroid/graphics/PointF;->y:F

    add-float/2addr v8, v3

    invoke-direct {v4, v5, v6, v7, v8}, Landroid/graphics/RectF;-><init>(FFFF)V

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setOval(Landroid/graphics/RectF;)V

    .line 32
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    mul-int/lit8 v4, v1, 0x2d

    int-to-float v4, v4

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setStartAngle(F)V

    .line 33
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    mul-int/lit8 v4, v1, 0x2d

    add-int/lit8 v4, v4, 0x5a

    int-to-float v4, v4

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setSweepAngle(F)V

    .line 34
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    sget-object v4, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 35
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    const/high16 v4, 0x41200000    # 10.0f

    div-float v4, v0, v4

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setWidth(F)V

    .line 27
    .end local v3    # "d":F
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 37
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 7

    .line 40
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->numberOfArc:I

    const/4 v1, 0x1

    sub-int/2addr v0, v1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_1

    .line 41
    move v2, v0

    .line 43
    .local v2, "index":I
    const/4 v3, 0x2

    new-array v3, v3, [F

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v5, v5, v0

    invoke-virtual {v5}, Lcom/tuyenmonkey/mkloader/model/Arc;->getStartAngle()F

    move-result v5

    aput v5, v3, v4

    iget-object v4, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v4, v4, v0

    .line 44
    invoke-virtual {v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->getStartAngle()F

    move-result v4

    rem-int/lit8 v5, v0, 0x2

    const/4 v6, -0x1

    if-nez v5, :cond_0

    const/4 v5, -0x1

    goto :goto_1

    :cond_0
    const/4 v5, 0x1

    :goto_1
    mul-int/lit16 v5, v5, 0x168

    int-to-float v5, v5

    add-float/2addr v4, v5

    aput v4, v3, v1

    .line 43
    invoke-static {v3}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v3

    .line 45
    .local v3, "fadeAnimator":Landroid/animation/ValueAnimator;
    invoke-virtual {v3, v6}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 46
    add-int/lit8 v4, v0, 0x1

    mul-int/lit16 v4, v4, 0x1f4

    int-to-long v4, v4

    invoke-virtual {v3, v4, v5}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 47
    new-instance v4, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;

    invoke-direct {v4, p0, v2}, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;-><init>(Lcom/tuyenmonkey/mkloader/type/Whirlpool;I)V

    invoke-virtual {v3, v4}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 56
    invoke-virtual {v3}, Landroid/animation/ValueAnimator;->start()V

    .line 40
    .end local v2    # "index":I
    .end local v3    # "fadeAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 58
    .end local v0    # "i":I
    :cond_1
    return-void
.end method
