.class public abstract Lcom/tuyenmonkey/mkloader/model/GraphicObject;
.super Ljava/lang/Object;
.source "GraphicObject.java"


# instance fields
.field protected paint:Landroid/graphics/Paint;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    new-instance v0, Landroid/graphics/Paint;

    invoke-direct {v0}, Landroid/graphics/Paint;-><init>()V

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/model/GraphicObject;->paint:Landroid/graphics/Paint;

    .line 15
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 16
    return-void
.end method


# virtual methods
.method public abstract draw(Landroid/graphics/Canvas;)V
.end method

.method public setAlpha(I)V
    .locals 1
    .param p1, "alpha"    # I

    .line 23
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/GraphicObject;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 24
    return-void
.end method

.method public setColor(I)V
    .locals 1
    .param p1, "color"    # I

    .line 19
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/GraphicObject;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 20
    return-void
.end method

.method public setStyle(Landroid/graphics/Paint$Style;)V
    .locals 1
    .param p1, "style"    # Landroid/graphics/Paint$Style;

    .line 31
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/GraphicObject;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 32
    return-void
.end method

.method public setWidth(F)V
    .locals 1
    .param p1, "width"    # F

    .line 27
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/model/GraphicObject;->paint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 28
    return-void
.end method
