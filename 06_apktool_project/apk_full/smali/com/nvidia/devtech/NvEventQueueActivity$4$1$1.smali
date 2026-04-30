.class Lcom/nvidia/devtech/NvEventQueueActivity$4$1$1;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity$4$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$2:Lcom/nvidia/devtech/NvEventQueueActivity$4$1;


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/NvEventQueueActivity$4$1;)V
    .locals 0
    .param p1, "this$2"    # Lcom/nvidia/devtech/NvEventQueueActivity$4$1;

    .line 1008
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4$1$1;->this$2:Lcom/nvidia/devtech/NvEventQueueActivity$4$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1
    .param p1, "i"    # Landroid/content/DialogInterface;
    .param p2, "a"    # I

    .line 1011
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$4$1$1;->this$2:Lcom/nvidia/devtech/NvEventQueueActivity$4$1;

    iget-object v0, v0, Lcom/nvidia/devtech/NvEventQueueActivity$4$1;->this$1:Lcom/nvidia/devtech/NvEventQueueActivity$4;

    iget-object v0, v0, Lcom/nvidia/devtech/NvEventQueueActivity$4;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->finish()V

    .line 1012
    return-void
.end method
