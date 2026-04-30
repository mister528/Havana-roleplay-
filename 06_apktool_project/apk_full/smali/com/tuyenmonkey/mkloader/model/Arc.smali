.class public Lcom/tuyenmonkey/mkloader/model/Arc;
.super Lcom/tuyenmonkey/mkloader/model/GraphicObject;
.source "Arc.java"


# instance fields
.field private oval:Landroid/graphics/RectF;

.field private startAngle:F

.field private sweepAngle:F

.field private useCenter:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Lcom/tuyenmonkey/mkloader/model/GraphicObject;-><init>()V

    return-void
.end method


# virtual methods
.method public draw(Landroid/graphics/Canvas;)V
    .locals 6
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 37
    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->oval:Landroid/graphics/RectF;

    iget v2, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->startAngle:F

    iget v3, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->sweepAngle:F

    iget-boolean v4, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->useCenter:Z

    iget-object v5, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->paint:Landroid/graphics/Paint;

    move-object v0, p1

    invoke-virtual/range {v0 .. v5}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 38
    return-void
.end method

.method public getStartAngle()F
    .locals 1

    .line 33
    iget v0, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->startAngle:F

    return v0
.end method

.method public setOval(Landroid/graphics/RectF;)V
    .locals 0
    .param p1, "oval"    # Landroid/graphics/RectF;

    .line 17
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->oval:Landroid/graphics/RectF;

    .line 18
    return-void
.end method

.method public setStartAngle(F)V
    .locals 0
    .param p1, "startAngle"    # F

    .line 21
    iput p1, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->startAngle:F

    .line 22
    return-void
.end method

.method public setSweepAngle(F)V
    .locals 0
    .param p1, "sweepAngle"    # F

    .line 25
    iput p1, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->sweepAngle:F

    .line 26
    return-void
.end method

.method public setUseCenter(Z)V
    .locals 0
    .param p1, "useCenter"    # Z

    .line 29
    iput-boolean p1, p0, Lcom/tuyenmonkey/mkloader/model/Arc;->useCenter:Z

    .line 30
    return-void
.end method
