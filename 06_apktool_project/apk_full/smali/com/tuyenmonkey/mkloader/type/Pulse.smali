.class public Lcom/tuyenmonkey/mkloader/type/Pulse;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "Pulse.java"


# instance fields
.field private lineDistance:F

.field private lineWidth:F

.field private lines:[Lcom/tuyenmonkey/mkloader/model/Line;

.field private numberOfLines:I

.field private scaleY:[F


# direct methods
.method public constructor <init>(I)V
    .locals 1
    .param p1, "numberOfLines"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
        }
    .end annotation

    .line 20
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 21
    const/4 v0, 0x3

    if-lt p1, v0, :cond_0

    const/4 v0, 0x5

    if-gt p1, v0, :cond_0

    .line 25
    iput p1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->numberOfLines:I

    .line 26
    new-array v0, p1, [Lcom/tuyenmonkey/mkloader/model/Line;

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    .line 27
    new-array v0, p1, [F

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->scaleY:[F

    .line 28
    return-void

    .line 22
    :cond_0
    new-instance v0, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;

    invoke-direct {v0}, Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;-><init>()V

    throw v0
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/Pulse;)[F
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/Pulse;

    .line 13
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->scaleY:[F

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 5
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 64
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->numberOfLines:I

    if-ge v0, v1, :cond_0

    .line 65
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 66
    int-to-float v1, v0

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineWidth:F

    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineDistance:F

    add-float/2addr v2, v3

    mul-float v1, v1, v2

    const/4 v2, 0x0

    invoke-virtual {p1, v1, v2}, Landroid/graphics/Canvas;->translate(FF)V

    .line 67
    const/high16 v1, 0x3f800000    # 1.0f

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->scaleY:[F

    aget v2, v2, v0

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v0

    invoke-virtual {v3}, Lcom/tuyenmonkey/mkloader/model/Line;->getPoint1()Landroid/graphics/PointF;

    move-result-object v3

    iget v3, v3, Landroid/graphics/PointF;->x:F

    iget-object v4, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->center:Landroid/graphics/PointF;

    iget v4, v4, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v1, v2, v3, v4}, Landroid/graphics/Canvas;->scale(FFFF)V

    .line 68
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Line;->draw(Landroid/graphics/Canvas;)V

    .line 69
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 64
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 71
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public initializeObjects()V
    .locals 7

    .line 31
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->numberOfLines:I

    mul-int/lit8 v1, v1, 0x2

    div-int/2addr v0, v1

    int-to-float v0, v0

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineWidth:F

    .line 32
    const/high16 v1, 0x40800000    # 4.0f

    div-float/2addr v0, v1

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineDistance:F

    .line 33
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->width:I

    int-to-float v0, v0

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineWidth:F

    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->numberOfLines:I

    int-to-float v4, v3

    mul-float v4, v4, v2

    iget v5, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineDistance:F

    add-int/lit8 v3, v3, -0x1

    int-to-float v3, v3

    mul-float v5, v5, v3

    add-float/2addr v4, v5

    sub-float/2addr v0, v4

    const/high16 v3, 0x40000000    # 2.0f

    div-float/2addr v0, v3

    div-float/2addr v2, v3

    add-float/2addr v0, v2

    .line 34
    .local v0, "firstX":F
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->numberOfLines:I

    if-ge v2, v3, :cond_0

    .line 35
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    new-instance v4, Lcom/tuyenmonkey/mkloader/model/Line;

    invoke-direct {v4}, Lcom/tuyenmonkey/mkloader/model/Line;-><init>()V

    aput-object v4, v3, v2

    .line 36
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->color:I

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setColor(I)V

    .line 37
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lineWidth:F

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setWidth(F)V

    .line 38
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    new-instance v4, Landroid/graphics/PointF;

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->center:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->y:F

    iget v6, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->height:I

    int-to-float v6, v6

    div-float/2addr v6, v1

    sub-float/2addr v5, v6

    invoke-direct {v4, v0, v5}, Landroid/graphics/PointF;-><init>(FF)V

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setPoint1(Landroid/graphics/PointF;)V

    .line 39
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->lines:[Lcom/tuyenmonkey/mkloader/model/Line;

    aget-object v3, v3, v2

    new-instance v4, Landroid/graphics/PointF;

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->center:Landroid/graphics/PointF;

    iget v5, v5, Landroid/graphics/PointF;->y:F

    iget v6, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->height:I

    int-to-float v6, v6

    div-float/2addr v6, v1

    add-float/2addr v5, v6

    invoke-direct {v4, v0, v5}, Landroid/graphics/PointF;-><init>(FF)V

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Line;->setPoint2(Landroid/graphics/PointF;)V

    .line 34
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 41
    .end local v2    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 5

    .line 44
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse;->numberOfLines:I

    if-ge v0, v1, :cond_0

    .line 45
    move v1, v0

    .line 46
    .local v1, "index":I
    const/4 v2, 0x3

    new-array v2, v2, [F

    fill-array-data v2, :array_0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 47
    .local v2, "scaleAnimator":Landroid/animation/ValueAnimator;
    const-wide/16 v3, 0x3e8

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 48
    mul-int/lit8 v3, v0, 0x78

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 49
    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 50
    new-instance v3, Lcom/tuyenmonkey/mkloader/type/Pulse$1;

    invoke-direct {v3, p0, v1}, Lcom/tuyenmonkey/mkloader/type/Pulse$1;-><init>(Lcom/tuyenmonkey/mkloader/type/Pulse;I)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 59
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 44
    .end local v1    # "index":I
    .end local v2    # "scaleAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 61
    .end local v0    # "i":I
    :cond_0
    return-void

    :array_0
    .array-data 4
        0x3f800000    # 1.0f
        0x3fc00000    # 1.5f
        0x3f800000    # 1.0f
    .end array-data
.end method
