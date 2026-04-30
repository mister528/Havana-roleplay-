.class Lcom/tuyenmonkey/mkloader/type/Worm$1;
.super Ljava/lang/Object;
.source "Worm.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tuyenmonkey/mkloader/type/Worm;->setUpAnimation()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tuyenmonkey/mkloader/type/Worm;

.field final synthetic val$index:I


# direct methods
.method constructor <init>(Lcom/tuyenmonkey/mkloader/type/Worm;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/tuyenmonkey/mkloader/type/Worm;

    .line 41
    iput-object p1, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Worm;

    iput p2, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->val$index:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 3
    .param p1, "animation"    # Landroid/animation/ValueAnimator;

    .line 43
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Worm;

    invoke-static {v0}, Lcom/tuyenmonkey/mkloader/type/Worm;->access$000(Lcom/tuyenmonkey/mkloader/type/Worm;)[Lcom/tuyenmonkey/mkloader/model/Circle;

    move-result-object v0

    iget v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->val$index:I

    aget-object v0, v0, v1

    iget-object v1, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Worm;

    iget-object v1, v1, Lcom/tuyenmonkey/mkloader/type/Worm;->center:Landroid/graphics/PointF;

    iget v1, v1, Landroid/graphics/PointF;->x:F

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Float;

    invoke-virtual {v2}, Ljava/lang/Float;->floatValue()F

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/tuyenmonkey/mkloader/model/Circle;->setCenter(FF)V

    .line 44
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Worm;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Worm;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    if-eqz v0, :cond_0

    .line 45
    iget-object v0, p0, Lcom/tuyenmonkey/mkloader/type/Worm$1;->this$0:Lcom/tuyenmonkey/mkloader/type/Worm;

    iget-object v0, v0, Lcom/tuyenmonkey/mkloader/type/Worm;->invalidateListener:Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;

    invoke-interface {v0}, Lcom/tuyenmonkey/mkloader/callback/InvalidateListener;->reDraw()V

    .line 47
    :cond_0
    return-void
.end method
