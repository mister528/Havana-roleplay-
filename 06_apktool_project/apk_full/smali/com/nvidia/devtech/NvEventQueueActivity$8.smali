.class Lcom/nvidia/devtech/NvEventQueueActivity$8;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->setPauseState(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

.field final synthetic val$z2:Z


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/NvEventQueueActivity;Z)V
    .locals 0
    .param p1, "this$0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 1509
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$8;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-boolean p2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$8;->val$z2:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 1512
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$8;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-object v0, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->mAndroidUI:Landroid/widget/FrameLayout;

    iget-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$8;->val$z2:Z

    if-eqz v1, :cond_0

    const/16 v1, 0x8

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->setVisibility(I)V

    .line 1513
    return-void
.end method
