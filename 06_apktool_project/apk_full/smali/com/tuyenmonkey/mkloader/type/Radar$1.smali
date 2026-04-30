.class Lcom/tuyenmonkey/mkloader/type/Radar$1;
.super Ljava/lang/Object;
.source "Radar.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/Radar;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/Radar;


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/Radar;)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/Radar;

    .line 29
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/Radar$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Radar;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 2
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 31
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Radar$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Radar;

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v0, v1}, Lcom/tuyenmonkey/mkloader/type/Radar;->access$002(Lcom/tuyenmonkey/mkloader/type/Radar;F)F

    .line 32
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Radar$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Radar;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Radar;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 33
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Radar$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Radar;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Radar;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 35
    :cond_0
    return-void
.end method
