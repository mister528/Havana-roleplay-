.class Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;
.super Ljava/lang/Object;
.source "LineSpinner.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/LineSpinner;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/LineSpinner;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/LineSpinner;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    .line 43
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    iput p2, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 2
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 45
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    invoke-static {v0}, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->access$000(Lcom/tuyenmonkey/mkloader/type/LineSpinner;)[Lcom/tuyenmonkey/mkloader/model/Line;

    move-result-object v0

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;->val$index:I

    aget-object v0, v0, v1

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/tuyenmonkey/mkloader/model/Line;->setAlpha(I)V

    .line 46
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 47
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/LineSpinner$1;->this$0:Lcom/tuyenmonkey/mkloader/type/LineSpinner;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/LineSpinner;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 49
    :cond_0
    return-void
.end method
