.class public Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "ClassicSpinner.java"


# instance fields
.field private circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

.field private circlesSize:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 15
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 16
    const/16 v0, 0x8

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circlesSize:I

    .line 17
    return-void
.end method

.method static synthetic access$000(Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;)[Lcom/tuyenmonkey/mkloader/model/Circle;
    .locals 1
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    .line 11
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    return-object v0
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 55
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circlesSize:I

    if-ge v0, v1, :cond_0

    .line 56
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 57
    mul-int/lit8 v1, v0, 0x2d

    int-to-float v1, v1

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v1, v2, v3}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 58
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

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
    .locals 5

    .line 20
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    .line 21
    .local v0, "size":F
    const/high16 v1, 0x41200000    # 10.0f

    div-float v1, v0, v1

    .line 22
    .local v1, "circleRadius":F
    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circlesSize:I

    new-array v2, v2, [Lcom/tuyenmonkey/mkloader/model/Circle;

    iput-object v2, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    .line 24
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circlesSize:I

    if-ge v2, v3, :cond_0

    .line 25
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    new-instance v4, Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-direct {v4}, Lcom/tuyenmonkey/mkloader/model/Circle;-><init>()V

    aput-object v4, v3, v2

    .line 26
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    iget-object v4, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->center:Landroid/graphics/PointF;

    iget v4, v4, Landroid/graphics/PointF;->x:F

    invoke-virtual {v3, v4, v1}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 27
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    iget v4, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->color:I

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Circle;->setColor(I)V

    .line 28
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    const/16 v4, 0x7e

    invoke-virtual {v3, v4}, Lcom/tuyenmonkey/mkloader/model/Circle;->setAlpha(I)V

    .line 29
    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circles:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v3, v3, v2

    invoke-virtual {v3, v1}, Lcom/tuyenmonkey/mkloader/model/Circle;->setRadius(F)V

    .line 24
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 31
    .end local v2    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 5

    .line 34
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->circlesSize:I

    if-ge v0, v1, :cond_0

    .line 35
    move v1, v0

    .line 37
    .local v1, "index":I
    const/4 v2, 0x3

    new-array v2, v2, [I

    fill-array-data v2, :array_0

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 38
    .local v2, "fadeAnimator":Landroid/animation/ValueAnimator;
    const/4 v3, -0x1

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 39
    const-wide/16 v3, 0x3e8

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 40
    mul-int/lit8 v3, v1, 0x78

    int-to-long v3, v3

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setStartDelay(J)V

    .line 41
    new-instance v3, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;

    invoke-direct {v3, p0, v1}, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;-><init>(Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;I)V

    invoke-virtual {v2, v3}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 50
    invoke-virtual {v2}, Landroid/animation/ValueAnimator;->start()V

    .line 34
    .end local v1    # "index":I
    .end local v2    # "fadeAnimator":Landroid/animation/ValueAnimator;
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 52
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
