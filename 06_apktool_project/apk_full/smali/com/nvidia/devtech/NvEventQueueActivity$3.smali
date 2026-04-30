.class Lcom/nvidia/devtech/NvEventQueueActivity$3;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->DoResumeEvent()V
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

    .line 770
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$3;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 772
    :goto_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$3;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-object v0, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    if-nez v0, :cond_0

    .line 774
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$3;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    const-wide/16 v1, 0x3e8

    invoke-virtual {v0, v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->mSleep(J)V

    goto :goto_0

    .line 776
    :cond_0
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "Call from DoResumeEvent"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 777
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$3;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->resumeEvent()V

    .line 778
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$3;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    .line 779
    return-void
.end method
