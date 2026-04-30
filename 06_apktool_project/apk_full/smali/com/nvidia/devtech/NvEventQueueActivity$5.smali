.class Lcom/nvidia/devtech/NvEventQueueActivity$5;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->callLauncherActivity()V
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

    .line 1419
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$5;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 1422
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$5;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    const-string v1, "com.legendaryrussia.launcher"

    invoke-virtual {v0, v1}, Landroid/content/pm/PackageManager;->getLaunchIntentForPackage(Ljava/lang/String;)Landroid/content/Intent;

    move-result-object v0

    .line 1423
    .local v0, "launchIntent":Landroid/content/Intent;
    const-string v1, "minimize"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/content/Intent;->putExtra(Ljava/lang/String;Z)Landroid/content/Intent;

    .line 1424
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$5;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-boolean v1, v1, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    if-eqz v1, :cond_0

    .line 1426
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$5;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->pauseEvent()V

    .line 1428
    :cond_0
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "Calling launcher activity"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1429
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$5;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->startActivity(Landroid/content/Intent;)V

    .line 1430
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "Called launcher activity"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1431
    return-void
.end method
