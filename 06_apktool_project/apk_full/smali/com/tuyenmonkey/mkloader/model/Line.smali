.class public Lcom/tuyenmonkey/mkloader/model/Line;
.super Lcom/tuyenmonkey/mkloader/model/GraphicObject;
.source "Line.java"


# instance fields
.field private point1:Landroid/graphics/PointF;

.field private point2:Landroid/graphics/PointF;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/model/GraphicObject;-><init>()V

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 7
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 31
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point1:Landroid/graphics/PointF;

    iget v2, v0, Landroid/graphics/PointF;->x:F

    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point1:Landroid/graphics/PointF;

    iget v3, v0, Landroid/graphics/PointF;->y:F

    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point2:Landroid/graphics/PointF;

    iget v4, v0, Landroid/graphics/PointF;->x:F

    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point2:Landroid/graphics/PointF;

    iget v5, v0, Landroid/graphics/PointF;->y:F

    iget-object v6, p0, Lcom/tuyenmonkey/mkloader/model/Line;->paint:Landroid/graphics/Paint;

    move-object v1, p1

    invoke-virtual/range {v1 .. v6}, Landroid/graphics/Canvas;->drawLine(FFFFLandroid/graphics/Paint;)V

    .line 32
    return-void
.end method

.method public getPoint1()Landroid/graphics/PointF;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point1:Landroid/graphics/PointF;

    return-object v0
.end method

.method public getPoint2()Landroid/graphics/PointF;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point2:Landroid/graphics/PointF;

    return-object v0
.end method

.method public setPoint1(Landroid/graphics/PointF;)V
    .locals 0
    .param p1, "point1"    # Landroid/graphics/PointF;

    .line 15
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point1:Landroid/graphics/PointF;

    .line 16
    return-void
.end method

.method public setPoint2(Landroid/graphics/PointF;)V
    .locals 0
    .param p1, "point2"    # Landroid/graphics/PointF;

    .line 19
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/model/Line;->point2:Landroid/graphics/PointF;

    .line 20
    return-void
.end method
