.class Lcom/nvidia/devtech/NvEventQueueActivity$1;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->showClientSettings()V
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

    .line 242
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$1;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 245
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$1;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$000(Lcom/nvidia/devtech/NvEventQueueActivity;)Lcom/luxury/mobile/core/DialogClientSettings;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 247
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$1;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$002(Lcom/nvidia/devtech/NvEventQueueActivity;Lcom/luxury/mobile/core/DialogClientSettings;)Lcom/luxury/mobile/core/DialogClientSettings;

    .line 249
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$1;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettings;

    invoke-direct {v1}, Lcom/luxury/mobile/core/DialogClientSettings;-><init>()V

    invoke-static {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$002(Lcom/nvidia/devtech/NvEventQueueActivity;Lcom/luxury/mobile/core/DialogClientSettings;)Lcom/luxury/mobile/core/DialogClientSettings;

    .line 250
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$1;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$000(Lcom/nvidia/devtech/NvEventQueueActivity;)Lcom/luxury/mobile/core/DialogClientSettings;

    move-result-object v0

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$1;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    const-string v2, "test"

    invoke-virtual {v0, v1, v2}, Lcom/luxury/mobile/core/DialogClientSettings;->show(Landroidx/fragment/app/FragmentManager;Ljava/lang/String;)V

    .line 251
    return-void
.end method
