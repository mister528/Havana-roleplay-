.class Lcom/tuyenmonkey/mkloader/type/Pulse$1;
.super Ljava/lang/Object;
.source "Pulse.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/Pulse;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/Pulse;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/Pulse;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/Pulse;

    .line 50
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Pulse;

    iput p2, p0, Lcom/tuyenmonkey/mkloader/type/Pulse$1;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 3
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 52
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Pulse;

    invoke-static {v0}, Lcom/tuyenmonkey/mkloader/type/Pulse;->access$000(Lcom/tuyenmonkey/mkloader/type/Pulse;)[F

    move-result-object v0

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Pulse$1;->val$index:I

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    aput v2, v0, v1

    .line 53
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Pulse;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Pulse;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 54
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Pulse$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Pulse;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Pulse;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 56
    :cond_0
    return-void
.end method
