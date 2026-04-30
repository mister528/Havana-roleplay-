.class public Lcom/tuyenmonkey/mkloader/model/Circle;
.super Lcom/tuyenmonkey/mkloader/model/GraphicObject;
.source "Circle.java"


# instance fields
.field private center:Landroid/graphics/PointF;

.field private radius:F


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 14
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/model/GraphicObject;-><init>()V

    .line 15
    new-instance v0, Landroid/graphics/PointF;

    invoke-direct {v0}, Landroid/graphics/PointF;-><init>()V

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->center:Landroid/graphics/PointF;

    .line 16
    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 4
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 27
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->center:Landroid/graphics/PointF;

    iget v0, v0, Landroid/graphics/PointF;->x:F

    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->center:Landroid/graphics/PointF;

    iget v1, v1, Landroid/graphics/PointF;->y:F

    iget v2, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->radius:F

    iget-object v3, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->paint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 28
    return-void
.end method

.method public setCenter(FF)V
    .locals 1
    .param p1, "x"    # F
    .param p2, "y"    # F

    .line 23
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->center:Landroid/graphics/PointF;

    invoke-virtual {v0, p1, p2}, Landroid/graphics/PointF;->set(FF)V

    .line 24
    return-void
.end method

.method public setRadius(F)V
    .locals 0
    .param p1, "radius"    # F

    .line 19
    iput p1, p0, Lcom/tuyenmonkey/mkloader/model/Circle;->radius:F

    .line 20
    return-void
.end method
