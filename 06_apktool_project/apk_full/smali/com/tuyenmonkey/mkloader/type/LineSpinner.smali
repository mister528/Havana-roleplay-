.class public Lcom/tuyenmonkey/mkloader/type/LineSpinner;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "LineSpinner.java"


# instance fields
.field private lines:[Lcom/tuyenmonkey/mkloader/model/Line;

.field private numberOfLine:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 17
    const/16 v0, 0x8

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->numberOfLine:I

    .line 18
    return-void
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/LineSpinner;)[Lcom/tuyenmonkey/mkloader/model/Line;
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    .line 12
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 57
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->numberOfLine:I

    if-ge v0, v1, :cond_0

    .line 58
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 59
    mul-int/lit8 v1, v0, 0x2d

    int-to-float v1, v1

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v1, v2, v3}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 60
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Line;->draw(Landroid/graphics/Canvas;)V

    .line 61
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 57
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 63
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public initializeObjects()V
    .locals 9

    .line 21
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    .line 22
    .local v0, "size":I
    int-to-float v1, v0

    const/high16 v2, 0x41200000    # 10.0f

    div-float/2addr v1, v2

    .line 23
    .local v1, "lineWidth":F
    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->numberOfLine:I

    new-array v2, v2, [Lcom/tuyenmonkey/mkloader/model/Line;

    iput-object v2, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    .line 25
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->numberOfLine:I

    if-ge v2, v3, :cond_0

    .line 26
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    new-instance v4, Lcom/tuyenmonkey/mkloader/model/Line;

    invoke-direct {v4}, Lcom/tuyenmonkey/mkloader/model/Line;-><init>()V

    aput-object v4, v3, v2

    .line 27
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->color:I

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setColor(I)V

    .line 28
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    const/16 v4, 0x7e

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setAlpha(I)V

    .line 29
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    invoke-virtual {v3, v1}, Lcom/tuyenmonkey/mkloader/model/Line;->setWidth(F)V

    .line 30
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    new-instance v4, Landroid/graphics/PointF;

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->center:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->x:F

    iget-object v6, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->center:Landroid/graphics/PointF;

    iget v6, v6, Landroid/graphics/PointF;->y:F

    int-to-float v7, v0

    const/high16 v8, 0x40000000    # 2.0f

    div-float/2addr v7, v8

    sub-float/2addr v6, v7

    add-float/2addr v6, v1

    invoke-direct {v4, v5, v6}, Landroid/graphics/PointF;-><init>(FF)V

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setPoint1(Landroid/graphics/PointF;)V

    .line 31
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    new-instance v4, Landroid/graphics/PointF;

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->center:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->x:F

    iget-object v6, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v6, v6, v2

    invoke-virtual {v6}, Lcom/tuyenmonkey/mkloader/model/Line;->getPoint1()Landroid/graphics/PointF;

    move-result-object v6

    iget v6, v6, Landroid/graphics/PointF;->y:F

    mul-float v8, v8, v1

    add-float/2addr v6, v8

    invoke-direct {v4, v5, v6}, Landroid/graphics/PointF;-><init>(FF)V

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setPoint2(Landroid/graphics/PointF;)V

    .line 25
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 33
    .end local v2    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 5

    .line 36
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->numberOfLine:I

    if-ge v0, v1, :cond_0

    .line 37
    move v1, v0

    .line 39
    .local v1, "index":I
    const/4 v2, 0x3

    new-array v2, v2, [I

    fill-array-data v2, :array_0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 40
    .local v2, "fadeAnimator":Landroid/animation/ValueAnimator;
    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 41
    const-wide/16 v3, 0x3e8

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 42
    mul-int/lit8 v3, v1, 0x78

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 43
    new-instance v3, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;

    invoke-direct {v3, p0, v1}, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;-><init>(Lcom/tuyenmonkey/mkloader/type/LineSpinner;I)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 52
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 36
    .end local v1    # "index":I
    .end local v2    # "fadeAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 54
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
