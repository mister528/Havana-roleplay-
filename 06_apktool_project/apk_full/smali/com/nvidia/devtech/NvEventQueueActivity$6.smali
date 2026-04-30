.class Lcom/nvidia/devtech/NvEventQueueActivity$6;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->showInputLayout()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nvidia/devtech/NvEventQueueActivity;


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 1438
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$6;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 1441
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$6;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$700(Lcom/nvidia/devtech/NvEventQueueActivity;)Lcom/nvidia/devtech/InputManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/nvidia/devtech/InputManager;->ShowInputLayout()V

    .line 1442
    return-void
.end method
