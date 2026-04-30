.class Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;
.super Ljava/lang/Object;
.source "Whirlpool.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/Whirlpool;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/Whirlpool;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/Whirlpool;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    .line 47
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    iput p2, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 3
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 49
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    invoke-static {v0}, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->access$000(Lcom/tuyenmonkey/mkloader/type/Whirlpool;)[F

    move-result-object v0

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;->val$index:I

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    aput v2, v0, v1

    .line 50
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 51
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Whirlpool$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Whirlpool;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Whirlpool;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 53
    :cond_0
    return-void
.end method
