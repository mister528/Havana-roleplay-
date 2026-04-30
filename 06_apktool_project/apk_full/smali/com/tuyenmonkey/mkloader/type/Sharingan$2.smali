.class Lcom/tuyenmonkey/mkloader/type/Sharingan$2;
.super Ljava/lang/Object;
.source "Sharingan.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/Sharingan;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/Sharingan;


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/Sharingan;)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/Sharingan;

    .line 68
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan$2;->this$0:Lcom/tuyenmonkey/mkloader/type/Sharingan;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 2
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 70
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan$2;->this$0:Lcom/tuyenmonkey/mkloader/type/Sharingan;

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Float;

    invoke-virtual {v1}, Ljava/lang/Float;->floatValue()F

    move-result v1

    invoke-static {v0, v1}, Lcom/tuyenmonkey/mkloader/type/Sharingan;->access$102(Lcom/tuyenmonkey/mkloader/type/Sharingan;F)F

    .line 71
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan$2;->this$0:Lcom/tuyenmonkey/mkloader/type/Sharingan;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 72
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Sharingan$2;->this$0:Lcom/tuyenmonkey/mkloader/type/Sharingan;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Sharingan;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 74
    :cond_0
    return-void
.end method
