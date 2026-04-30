.class public Lcom/tuyenmonkey/mkloader/type/FishSpinner;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "FishSpinner.java"


# instance fields
.field private circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

.field private numberOfCircle:I

.field private rotates:[F


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 17
    const/4 v0, 0x5

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->numberOfCircle:I

    .line 18
    new-array v0, v0, [F

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->rotates:[F

    .line 19
    return-void
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/FishSpinner;)[F
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/FishSpinner;

    .line 11
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->rotates:[F

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 56
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->numberOfCircle:I

    if-ge v0, v1, :cond_0

    .line 57
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 58
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->rotates:[F

    aget v1, v1, v0

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v1, v2, v3}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 59
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Circle;->draw(Landroid/graphics/Canvas;)V

    .line 60
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 56
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 62
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public initializeObjects()V
    .locals 6

    .line 22
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    .line 23
    .local v0, "size":F
    const/high16 v1, 0x41200000    # 10.0f

    div-float v1, v0, v1

    .line 24
    .local v1, "circleRadius":F
    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->numberOfCircle:I

    new-array v2, v2, [Lcom/tuyenmonkey/mkloader/model/Circle;

    iput-object v2, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    .line 26
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->numberOfCircle:I

    if-ge v2, v3, :cond_0

    .line 27
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    new-instance v4, Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-direct {v4}, Lcom/tuyenmonkey/mkloader/model/Circle;-><init>()V

    aput-object v4, v3, v2

    .line 28
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    iget-object v4, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->center:Landroid/graphics/PointF;

    iget v4, v4, Landroid/graphics/PointF;->x:F

    invoke-virtual {v3, v4, v1}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 29
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->color:I

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Circle;->setColor(I)V

    .line 30
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    int-to-float v4, v2

    mul-float v4, v4, v1

    const/high16 v5, 0x40c00000    # 6.0f

    div-float/2addr v4, v5

    sub-float v4, v1, v4

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Circle;->setRadius(F)V

    .line 26
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 32
    .end local v2    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 5

    .line 35
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/FishSpinner;->numberOfCircle:I

    if-ge v0, v1, :cond_0

    .line 36
    move v1, v0

    .line 38
    .local v1, "index":I
    const/4 v2, 0x2

    new-array v2, v2, [F

    fill-array-data v2, :array_0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 39
    .local v2, "fadeAnimator":Landroid/animation/ValueAnimator;
    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 40
    const-wide/16 v3, 0x6a4

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 41
    mul-int/lit8 v3, v1, 0x64

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 42
    new-instance v3, Lcom/tuyenmonkey/mkloader/type/FishSpinner$1;

    invoke-direct {v3, p0, v1}, Lcom/tuyenmonkey/mkloader/type/FishSpinner$1;-><init>(Lcom/tuyenmonkey/mkloader/type/FishSpinner;I)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 51
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 35
    .end local v1    # "index":I
    .end local v2    # "fadeAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 53
    .end local v0    # "i":I
    :cond_0
    return-void

    :array_0
    .array-data 4
        0x0
        0x43b40000    # 360.0f
    .end array-data
.end method
