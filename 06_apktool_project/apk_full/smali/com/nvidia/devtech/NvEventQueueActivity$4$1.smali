.class Lcom/nvidia/devtech/NvEventQueueActivity$4$1;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity$4;->surfaceCreated(Landroid/view/SurfaceHolder;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/nvidia/devtech/NvEventQueueActivity$4;


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/NvEventQueueActivity$4;)V
    .locals 0
    .param p1, "this$1"    # Lcom/nvidia/devtech/NvEventQueueActivity$4;

    .line 1001
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4$1;->this$1:Lcom/nvidia/devtech/NvEventQueueActivity$4;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 1004
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4$1;->this$1:Lcom/nvidia/devtech/NvEventQueueActivity$4;

    iget-object v1, v1, Lcom/nvidia/devtech/NvEventQueueActivity$4;->val$act:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 1005
    const-string v1, "Application initialization failed. The application will exit."

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/nvidia/devtech/NvEventQueueActivity$4$1$1;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$4$1$1;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity$4$1;)V

    .line 1006
    const-string v2, "Ok"

    invoke-virtual {v0, v2, v1}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1015
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setCancelable(Z)Landroid/app/AlertDialog$Builder;

    move-result-object v0

    .line 1016
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->show()Landroid/app/AlertDialog;

    .line 1017
    return-void
.end method
