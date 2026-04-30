.class public Lcom/tuyenmonkey/mkloader/type/Radar;
.super Lcom/tuyenmonkey/mkloader/type/LoaderView;
.source "Radar.java"


# instance fields
.field private degree:F

.field private line:Lcom/tuyenmonkey/mkloader/model/Line;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/type/LoaderView;-><init>()V

    return-void
.end method

.method static synthetic access$002(Lcom/tuyenmonkey/mkloader/type/Radar;F)F
    .locals 0
    .param p0, "x0"    # Lcom/tuyenmonkey/mkloader/type/Radar;
    .param p1, "x1"    # F

    .line 12
    iput p1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->degree:F

    return p1
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 3
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 42
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 43
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->degree:F

    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->center:Landroid/graphics/PointF;

    iget v1, v1, Landroid/graphics/PointF;->x:F

    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->center:Landroid/graphics/PointF;

    iget v2, v2, Landroid/graphics/PointF;->y:F

    invoke-virtual {p1, v0, v1, v2}, Landroid/graphics/Canvas;->rotate(FFF)V

    .line 44
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->line:Lcom/tuyenmonkey/mkloader/model/Line;

    invoke-virtual {v0, p1}, Lcom/tuyenmonkey/mkloader/model/Line;->draw(Landroid/graphics/Canvas;)V

    .line 45
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 46
    return-void
.end method

.method public initializeObjects()V
    .locals 5

    .line 17
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->width:I

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->height:I

    invoke-static {v0, v1}, Ljava/lang/Math;->min(II)I

    move-result v0

    int-to-float v0, v0

    .line 18
    .local v0, "size":F
    new-instance v1, Lcom/tuyenmonkey/mkloader/model/Line;

    invoke-direct {v1}, Lcom/tuyenmonkey/mkloader/model/Line;-><init>()V

    iput-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->line:Lcom/tuyenmonkey/mkloader/model/Line;

    .line 19
    iget-object v2, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->center:Landroid/graphics/PointF;

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Line;->setPoint1(Landroid/graphics/PointF;)V

    .line 20
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->line:Lcom/tuyenmonkey/mkloader/model/Line;

    new-instance v2, Landroid/graphics/PointF;

    const/high16 v3, 0x40000000    # 2.0f

    div-float v3, v0, v3

    const/4 v4, 0x0

    invoke-direct {v2, v4, v3}, Landroid/graphics/PointF;-><init>(FF)V

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Line;->setPoint2(Landroid/graphics/PointF;)V

    .line 21
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->line:Lcom/tuyenmonkey/mkloader/model/Line;

    iget v2, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->color:I

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Line;->setColor(I)V

    .line 22
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Radar;->line:Lcom/tuyenmonkey/mkloader/model/Line;

    const/high16 v2, 0x40a00000    # 5.0f

    invoke-virtual {v1, v2}, Lcom/tuyenmonkey/mkloader/model/Line;->setWidth(F)V

    .line 23
    return-void
.end method

.method public setUpAnimation()V
    .locals 3

    .line 26
    const/4 v0, 0x2

    new-array v0, v0, [F

    fill-array-data v0, :array_0

    invoke-static {v0}, Landroid/animation/ValueAnimator;->ofFloat([F)Landroid/animation/ValueAnimator;

    move-result-object v0

    .line 27
    .local v0, "animator":Landroid/animation/ValueAnimator;
    const-wide/16 v1, 0x3e8

    invoke-virtual {v0, v1, v2}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 28
    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->setRepeatCount(I)V

    .line 29
    new-instance v1, Lcom/tuyenmonkey/mkloader/type/Radar$1;

    invoke-direct {v1, p0}, Lcom/tuyenmonkey/mkloader/type/Radar$1;-><init>(Lcom/tuyenmonkey/mkloader/type/Radar;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 38
    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V

    .line 39
    return-void

    nop

    :array_0
    .array-data 4
        0x0
        0x43b38000    # 359.0f
    .end array-data
.end method
