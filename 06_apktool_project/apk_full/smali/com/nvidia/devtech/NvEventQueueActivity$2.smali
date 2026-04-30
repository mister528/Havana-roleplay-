.class Lcom/nvidia/devtech/NvEventQueueActivity$2;
.super Ljava/lang/Object;
.source "NvEventQueueActivity.java"

# interfaces
.implements Landroid/view/View$OnSystemUiVisibilityChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/NvEventQueueActivity;->onCreate(Landroid/os/Bundle;)V
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

    .line 591
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity$2;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSystemUiVisibilityChange(I)V
    .locals 1
    .param p1, "i"    # I

    .line 594
    and-int/lit8 v0, p1, 0x4

    if-nez v0, :cond_0

    .line 595
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity$2;->this$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->hideSystemUI()V

    .line 602
    :cond_0
    return-void
.end method
