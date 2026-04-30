.class Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;
.super Ljava/lang/Object;
.source "ClassicSpinner.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    .line 41
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    iput p2, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 2
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 43
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    invoke-static {v0}, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->access$000(Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;)[Lcom/tuyenmonkey/mkloader/model/Circle;

    move-result-object v0

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;->val$index:I

    aget-object v0, v0, v1

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/tuyenmonkey/mkloader/model/Circle;->setAlpha(I)V

    .line 44
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 45
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/ClassicSpinner;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 47
    :cond_0
    return-void
.end method
