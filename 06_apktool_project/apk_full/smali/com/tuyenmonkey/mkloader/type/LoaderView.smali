.class public abstract Lcom/tuyenmonkey/mkloader/type/LoaderView;
.super Ljava/lang/Object;
.source "LoaderView.java"


# instance fields
.field protected center:Landroid/graphics/PointF;

.field protected color:I

.field protected desiredHeight:I

.field protected desiredWidth:I

.field protected height:I

.field protected invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

.field protected width:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const/16 v0, 0x96

    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->desiredWidth:I

    .line 20
    iput v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->desiredHeight:I

    .line 21
    return-void
.end method


# virtual methods
.method public abstract draw(Landroid/graphics/Canvas;)V
.end method

.method public getDesiredHeight()I
    .locals 1

    .line 42
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->desiredHeight:I

    return v0
.end method

.method public getDesiredWidth()I
    .locals 1

    .line 38
    iget v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->desiredWidth:I

    return v0
.end method

.method public abstract initializeObjects()V
.end method

.method public isDetached()Z
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public onDetach()V
    .locals 1

    .line 56
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 57
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    .line 59
    :cond_0
    return-void
.end method

.method public setColor(I)V
    .locals 0
    .param p1, "color"    # I

    .line 24
    iput p1, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->color:I

    .line 25
    return-void
.end method

.method public setInvalidateListener(Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;)V
    .locals 0
    .param p1, "invalidateListener"    # Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    .line 34
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    .line 35
    return-void
.end method

.method public setSize(II)V
    .locals 4
    .param p1, "width"    # I
    .param p2, "height"    # I

    .line 28
    iput p1, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->width:I

    .line 29
    iput p2, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->height:I

    .line 30
    new-instance v0, Landroid/graphics/PointF;

    int-to-float v1, p1

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    int-to-float v3, p2

    div-float/2addr v3, v2

    invoke-direct {v0, v1, v3}, Landroid/graphics/PointF;-><init>(FF)V

    iput-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LoaderView;->center:Landroid/graphics/PointF;

    .line 31
    return-void
.end method

.method public abstract setUpAnimation()V
.end method
