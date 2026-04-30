.class Lcom/nvidia/devtech/NvEventQueueActivity$4;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->systemInit()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

.field final synthetic val$act:Lcom/nvidia/devtech/NvEventQueueActivity;


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/NvEventQueueActivity;Lcom/nvidia/devtech/NvEventQueueActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 982
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object p2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->val$act:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 3
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "width"    # I
    .param p4, "height"    # I

    .line 1040
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Surface changed: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v2, ", "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1041
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v0, p3}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$402(Lcom/nvidia/devtech/NvEventQueueActivity;I)I

    .line 1042
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v0, p4}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$502(Lcom/nvidia/devtech/NvEventQueueActivity;I)I

    .line 1043
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$400(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v1

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$500(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v2

    invoke-virtual {v0, v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->setWindowSize(II)V

    .line 1044
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 4
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .line 986
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "systemInit.surfaceCreated"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 988
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-object v0, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    const/4 v1, 0x1

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 989
    .local v0, "firstRun":Z
    :goto_0
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object p1, v2, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    .line 991
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$100(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$200(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v2

    if-eqz v2, :cond_1

    .line 993
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Setting fixed window size"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 994
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$100(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v2

    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v3}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$200(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v3

    invoke-interface {p1, v2, v3}, Landroid/view/SurfaceHolder;->setFixedSize(II)V

    .line 997
    :cond_1
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v2, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$302(Lcom/nvidia/devtech/NvEventQueueActivity;Z)Z

    .line 998
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-boolean v2, v2, Lcom/nvidia/devtech/NvEventQueueActivity;->supportPauseResume:Z

    if-nez v2, :cond_2

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v2, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->init(Z)Z

    move-result v1

    if-nez v1, :cond_2

    .line 1000
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-object v1, v1, Lcom/nvidia/devtech/NvEventQueueActivity;->handler:Landroid/os/Handler;

    new-instance v2, Lcom/nvidia/devtech/NvEventQueueActivity$4$1;

    invoke-direct {v2, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$4$1;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity$4;)V

    invoke-virtual {v1, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 1022
    :cond_2
    if-nez v0, :cond_3

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-boolean v1, v1, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    if-eqz v1, :cond_3

    .line 1024
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "entering resumeEvent"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1025
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->resumeEvent()V

    .line 1026
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "returned from resumeEvent"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1028
    :cond_3
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$400(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v2

    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-static {v3}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$500(Lcom/nvidia/devtech/NvEventQueueActivity;)I

    move-result v3

    invoke-virtual {v1, v2, v3}, Lcom/nvidia/devtech/NvEventQueueActivity;->setWindowSize(II)V

    .line 1029
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 2
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .line 1054
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "systemInit.surfaceDestroyed"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1055
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->access$602(Lcom/nvidia/devtech/NvEventQueueActivity;Z)Z

    .line 1056
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->pauseEvent()V

    .line 1057
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->destroyEGLSurface()V

    .line 1058
    return-void
.end method
