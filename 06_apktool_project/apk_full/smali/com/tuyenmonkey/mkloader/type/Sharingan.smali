.class public Lcom/tuyenmonkey/mkloader/type/Sharingan;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "Sharingan.java"


# instance fields
.field private eye:Lcom/tuyenmonkey/mkloader/model/Circle;

.field private eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

.field private eyeBoundRadius:F

.field private eyeBoundRadiusScale:F

.field private numberOfSharingan:I

.field private rotate:F

.field private scale:F

.field private sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 23
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    .line 24
    const/4 v0, 0x3

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->numberOfSharingan:I

    .line 25
    return-void
.end method

.method static synthetic access$002(Lcom/tuyenmonkey/mkloader/type/Sharingan;F)F
    .locals 0
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/Sharingan;
    .param p1, "x1"    # F

    .line 13
    iput p1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->rotate:F

    return p1
.end method

.method static synthetic access$102(Lcom/tuyenmonkey/mkloader/type/Sharingan;F)F
    .locals 0
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/Sharingan;
    .param p1, "x1"    # F

    .line 13
    iput p1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->scale:F

    return p1
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 83
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 84
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->scale:F

    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v1, v1, Landroid/graphics/PointF;->x:F

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v0, v0, v1, v2}, Landroid/graphics/Canvas;->scale(FFFF)V

    .line 85
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->rotate:F

    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v1, v1, Landroid/graphics/PointF;->x:F

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v0, v1, v2}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 86
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eye:Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-virtual {v0, p1}, Lcom/tuyenmonkey/mkloader/model/Circle;->draw(Landroid/graphics/Canvas;)V

    .line 87
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-virtual {v0, p1}, Lcom/tuyenmonkey/mkloader/model/Circle;->draw(Landroid/graphics/Canvas;)V

    .line 88
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->numberOfSharingan:I

    if-ge v0, v1, :cond_0

    .line 89
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 90
    mul-int/lit8 v1, v0, 0x78

    int-to-float v1, v1

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v1, v2, v3}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 91
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v1, v1, v0

    invoke-virtual {v1, p1}, Lcom/tuyenmonkey/mkloader/model/Circle;->draw(Landroid/graphics/Canvas;)V

    .line 92
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 88
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 94
    .end local v0    # "i":I
    :cond_0
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 95
    return-void
.end method

.method public initializeObjects()V
    .locals 6

    .line 28
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x40000000    # 2.0f

    div-float/2addr v0, v1

    .line 29
    .local v0, "r":F
    const/high16 v1, 0x3fc00000    # 1.5f

    div-float v1, v0, v1

    iput v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBoundRadius:F

    .line 31
    new-instance v1, Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-direct {v1}, Lcom/tuyenmonkey/mkloader/model/Circle;-><init>()V

    iput-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eye:Lcom/tuyenmonkey/mkloader/model/Circle;

    .line 32
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {v1, v2, v3}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 33
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eye:Lcom/tuyenmonkey/mkloader/model/Circle;

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->color:I

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setColor(I)V

    .line 34
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eye:Lcom/tuyenmonkey/mkloader/model/Circle;

    const/high16 v2, 0x40800000    # 4.0f

    div-float v2, v0, v2

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setRadius(F)V

    .line 36
    new-instance v1, Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-direct {v1}, Lcom/tuyenmonkey/mkloader/model/Circle;-><init>()V

    iput-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

    .line 37
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->x:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->y:F

    invoke-virtual {v1, v2, v3}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 38
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->color:I

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setColor(I)V

    .line 39
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBoundRadius:F

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setRadius(F)V

    .line 40
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

    sget-object v2, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 41
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBound:Lcom/tuyenmonkey/mkloader/model/Circle;

    const/high16 v2, 0x41a00000    # 20.0f

    div-float v2, v0, v2

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setWidth(F)V

    .line 43
    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->numberOfSharingan:I

    new-array v1, v1, [Lcom/tuyenmonkey/mkloader/model/Circle;

    iput-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;

    .line 44
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->numberOfSharingan:I

    if-ge v1, v2, :cond_0

    .line 45
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;

    new-instance v3, Lcom/tuyenmonkey/mkloader/model/Circle;

    invoke-direct {v3}, Lcom/tuyenmonkey/mkloader/model/Circle;-><init>()V

    aput-object v3, v2, v1

    .line 46
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v2, v2, v1

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v3, v3, Landroid/graphics/PointF;->x:F

    iget-object v4, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->center:Landroid/graphics/PointF;

    iget v4, v4, Landroid/graphics/PointF;->y:F

    iget v5, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->eyeBoundRadius:F

    sub-float/2addr v4, v5

    invoke-virtual {v2, v3, v4}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 47
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v2, v2, v1

    iget v3, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->color:I

    invoke-virtual {v2, v3}, Lcom/tuyenmonkey/mkloader/model/Circle;->setColor(I)V

    .line 48
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->sharingans:[Lcom/tuyenmonkey/mkloader/model/Circle;

    aget-object v2, v2, v1

    const/high16 v3, 0x40c00000    # 6.0f

    div-float v3, v0, v3

    invoke-virtual {v2, v3}, Lcom/tuyenmonkey/mkloader/model/Circle;->setRadius(F)V

    .line 44
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 50
    .end local v1    # "i":I
    :cond_0
    return-void
.end method

.method public setUpAnimation()V
    .locals 5

    .line 53
    const/4 v0, 0x2

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    invoke-static {v0}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v0

    .line 54
    .local v0, "rotateAnimator":Landroid/animation/ValueAnimator;
    const-wide/16 v1, 0x5dc

    invoke-virtual {v0, v1, v2}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 55
    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 56
    new-instance v2, Lcom/tuyenmonkey/mkloader/type/Sharingan$1;

    invoke-direct {v2, p0}, Lcom/tuyenmonkey/mkloader/type/Sharingan$1;-><init>(Lcom/tuyenmonkey/mkloader/type/Sharingan;)V

    invoke-virtual {v0, v2}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 65
    const/4 v2, 0x3

    new-array v2, v2, [F

    fill-array-data v2, :array_1

    invoke-static {v2}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v2

    .line 66
    .local v2, "scaleAnimator":Landroid/animation/ValueAnimator;
    const-wide/16 v3, 0x3e8

    invoke-virtual {v2, v3, v4}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 67
    invoke-virtual {v2, v1}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 68
    new-instance v1, Lcom/tuyenmonkey/mkloader/type/Sharingan$2;

    invoke-direct {v1, p0}, Lcom/tuyenmonkey/mkloader/type/Sharingan$2;-><init>(Lcom/tuyenmonkey/mkloader/type/Sharingan;)V

    invoke-virtual {v2, v1}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 77
    new-instance v1, Landroid/animation/AnimatorSet;

    invoke-direct {v1}, Landroid/animation/AnimatorSet;-><init>()V

    .line 78
    .local v1, "animatorSet":Landroid/animation/AnimatorSet;
    invoke-virtual {v1, v0}, Landroid/animation/AnimatorSet;->play(Landroid/animation/Animator;)Landroid/animation/AnimatorSet$Builder;

    move-result-object v3

    invoke-virtual {v3, v2}, Landroid/animation/AnimatorSet$Builder;->with(Landroid/animation/Animator;)Landroid/animation/AnimatorSet$Builder;

    .line 79
    invoke-virtual {v1}, Landroid/animation/AnimatorSet;->start()V

    .line 80
    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x43b40000    # 360.0f
    .end array-data

    :array_1
    .array-data 4
        0x3f800000    # 1.0f
        0x3f4ccccd    # 0.8f
        0x3f800000    # 1.0f
    .end array-data
.end method
