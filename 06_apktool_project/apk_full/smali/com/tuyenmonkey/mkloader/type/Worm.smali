.class public Lcom/tuyenmonkey/mkloader/type/Worm;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "Worm.java"


# instance fields
.field private circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

.field private circlesSize:I

.field private radius:F

.field private transformations:[I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 17
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 18
    const/4 v0, 0x5

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circlesSize:I

    .line 19
    new-array v0, v0, [I

    fill-array-data v0, :array_0

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->transformations:[I

    .line 20
    return-void

    :array_0
    .array-data 4
        -0x2
        -0x1
        0x0
        0x1
        0x2
    .end array-data
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/Worm;)[Lcom/tuyenmonkey/mkloader/model/Circle;
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/Worm;

    .line 11
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 3
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 55
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circlesSize:I

    if-ge v0, v1, :cond_0

    .line 56
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 57
    const/high16 v1, 0x40000000    # 2.0f

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->radius:F

    mul-float v2, v2, v1

    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->transformations:[I

    aget v1, v1, v0

    int-to-float v1, v1

    mul-float v2, v2, v1

    const/4 v1, 0x0

    invoke-virtual {p1, v2, v1}, Landroid/graphics/Canvas;->translate(FF)V

    .line 58
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Circle;->draw(Landroid/graphics/Canvas;)V

    .line 59
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 55
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 61
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public initializeObjects()V
    .locals 4

    .line 23
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circlesSize:I

    new-array v0, v0, [Lcom/tuyenmonkey/mkloader/model/Circle;

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    .line 24
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->width:I

    int-to-float v0, v0

    const/high16 v1, 0x41200000    # 10.0f

    div-float/2addr v0, v1

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->width:I

    int-to-float v1, v1

    const/high16 v2, 0x42c80000    # 100.0f

    div-float/2addr v1, v2

    sub-float/2addr v0, v1

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->radius:F

    .line 26
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circlesSize:I

    if-ge v0, v1, :cond_0

    .line 27
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    new-instance v2, Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-direct {v2}, Lcom/tuyenmonkey/mkloader/model/Circle;-><init>()V

    aput-object v2, v1, v0

    .line 28
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v1, v1, v0

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->color:I

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setColor(I)V

    .line 29
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v1, v1, v0

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->radius:F

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setRadius(F)V

    .line 30
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v1, v1, v0

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {v1, v2, v3}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 26
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 32
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 7

    .line 35
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->circlesSize:I

    if-ge v0, v1, :cond_0

    .line 36
    move v1, v0

    .line 37
    .local v1, "index":I
    const/4 v2, 0x4

    new-array v2, v2, [F

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->center:Landroid/graphics/PointF;

    iget v4, v4, Landroid/graphics/PointF;->y:F

    aput v4, v2, v3

    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->height:I

    int-to-float v3, v3

    const/high16 v4, 0x40800000    # 4.0f

    div-float/2addr v3, v4

    const/4 v5, 0x1

    aput v3, v2, v5

    const/4 v3, 0x2

    iget v5, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->height:I

    const/4 v6, 0x3

    mul-int/lit8 v5, v5, 0x3

    int-to-float v5, v5

    div-float/2addr v5, v4

    aput v5, v2, v3

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Worm;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    aput v3, v2, v6

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 38
    .local v2, "translateAnimator":Landroid/animation/ValueAnimator;
    const-wide/16 v3, 0x3e8

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 39
    mul-int/lit8 v3, v1, 0x78

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 40
    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 41
    new-instance v3, Lcom/tuyenmonkey/mkloader/type/Worm$1;

    invoke-direct {v3, p0, v1}, Lcom/tuyenmonkey/mkloader/type/Worm$1;-><init>(Lcom/tuyenmonkey/mkloader/type/Worm;I)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 50
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 35
    .end local v1    # "index":I
    .end local v2    # "translateAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 52
    .end local v0    # "i":I
    :cond_0
    return-void
.end method
