.class Lcom/luxury/mobile/gui/UpdateActivity$3;
.super Ljava/lang/Object;
.source "UpdateActivity.java"

# interfaces
.implements Landroid/animation/ValueAnimator$AnimatorUpdateListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/UpdateActivity;->smoothProgress(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/UpdateActivity;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/UpdateActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$3;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 322
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onAnimationUpdate(Landroid/animation/ValueAnimator;)V
    .locals 1

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity$3;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 325
    invoke-static {v0}, Lcom/luxury/mobile/gui/UpdateActivity;->access$300(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/ProgressBar;

    move-result-object v0

    invoke-virtual {p1}, Landroid/animation/ValueAnimator;->getAnimatedValue()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    invoke-virtual {v0, p1}, Landroid/widget/ProgressBar;->setProgress(I)V

    return-void
.end method
