.class public Lcom/tuyenmonkey/mkloader/type/PhoneWave;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "PhoneWave.java"


# instance fields
.field private arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

.field private numberOfArc:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 18
    const/4 v0, 0x3

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->numberOfArc:I

    .line 19
    return-void
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/PhoneWave;)[Lcom/tuyenmonkey/mkloader/model/Arc;
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/PhoneWave;

    .line 13
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 2
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 60
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->numberOfArc:I

    if-ge v0, v1, :cond_0

    .line 61
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Arc;->draw(Landroid/graphics/Canvas;)V

    .line 60
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 63
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public initializeObjects()V
    .locals 10

    .line 22
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    .line 23
    .local v0, "r":F
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->numberOfArc:I

    new-array v1, v1, [Lcom/tuyenmonkey/mkloader/model/Arc;

    iput-object v1, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    .line 25
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->numberOfArc:I

    if-ge v1, v2, :cond_0

    .line 26
    const/high16 v2, 0x40800000    # 4.0f

    div-float v3, v0, v2

    int-to-float v4, v1

    mul-float v4, v4, v0

    div-float/2addr v4, v2

    add-float/2addr v3, v4

    .line 27
    .local v3, "d":F
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    new-instance v4, Lcom/tuyenmonkey/mkloader/model/Arc;

    invoke-direct {v4}, Lcom/tuyenmonkey/mkloader/model/Arc;-><init>()V

    aput-object v4, v2, v1

    .line 28
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->color:I

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setColor(I)V

    .line 29
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    const/16 v4, 0x7e

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setAlpha(I)V

    .line 30
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    new-instance v4, Landroid/graphics/RectF;

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->center:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->x:F

    sub-float/2addr v5, v3

    iget-object v6, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->center:Landroid/graphics/PointF;

    iget v6, v6, Landroid/graphics/PointF;->y:F

    sub-float/2addr v6, v3

    const/high16 v7, 0x40400000    # 3.0f

    div-float v8, v0, v7

    add-float/2addr v6, v8

    iget-object v8, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->center:Landroid/graphics/PointF;

    iget v8, v8, Landroid/graphics/PointF;->x:F

    add-float/2addr v8, v3

    iget-object v9, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->center:Landroid/graphics/PointF;

    iget v9, v9, Landroid/graphics/PointF;->y:F

    add-float/2addr v9, v3

    div-float v7, v0, v7

    add-float/2addr v9, v7

    invoke-direct {v4, v5, v6, v8, v9}, Landroid/graphics/RectF;-><init>(FFFF)V

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setOval(Landroid/graphics/RectF;)V

    .line 31
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    const/high16 v4, 0x43610000    # 225.0f

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setStartAngle(F)V

    .line 32
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    const/high16 v4, 0x42b40000    # 90.0f

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setSweepAngle(F)V

    .line 33
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    sget-object v4, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 34
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->arcs:[Lcom/tuyenmonkey/mkloader/model/Arc;

    aget-object v2, v2, v1

    const/high16 v4, 0x41200000    # 10.0f

    div-float v4, v0, v4

    invoke-virtual {v2, v4}, Lcom/tuyenmonkey/mkloader/model/Arc;->setWidth(F)V

    .line 25
    .end local v3    # "d":F
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 36
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 5

    .line 39
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/PhoneWave;->numberOfArc:I

    if-ge v0, v1, :cond_0

    .line 40
    move v1, v0

    .line 42
    .local v1, "index":I
    const/4 v2, 0x3

    new-array v2, v2, [I

    fill-array-data v2, :array_0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 43
    .local v2, "fadeAnimator":Landroid/animation/ValueAnimator;
    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 44
    const-wide/16 v3, 0x3e8

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 45
    mul-int/lit8 v3, v0, 0x78

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 46
    new-instance v3, Lcom/tuyenmonkey/mkloader/type/PhoneWave$1;

    invoke-direct {v3, p0, v1}, Lcom/tuyenmonkey/mkloader/type/PhoneWave$1;-><init>(Lcom/tuyenmonkey/mkloader/type/PhoneWave;I)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 55
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 39
    .end local v1    # "index":I
    .end local v2    # "fadeAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 57
    .end local v0    # "i":I
    :cond_0
    return-void

    :array_0
    .array-data 4
        0x7e
        0xff
        0x7e
    .end array-data
.end method
