.class Lcom/nvidia/devtech/HeightProvider$1;
.super Ljava/lang/Object;
.source "HeightProvider.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/HeightProvider;->init(Landroid/view/View;)Lcom/nvidia/devtech/HeightProvider;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nvidia/devtech/HeightProvider;

.field final synthetic val$finalView:Landroid/view/View;


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/HeightProvider;Landroid/view/View;)V
    .locals 0
    .param p1, "this$0"    # Lcom/nvidia/devtech/HeightProvider;

    .line 52
    iput-object p1, p0, Lcom/nvidia/devtech/HeightProvider$1;->this$0:Lcom/nvidia/devtech/HeightProvider;

    iput-object p2, p0, Lcom/nvidia/devtech/HeightProvider$1;->val$finalView:Landroid/view/View;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 55
    iget-object v0, p0, Lcom/nvidia/devtech/HeightProvider$1;->this$0:Lcom/nvidia/devtech/HeightProvider;

    iget-object v1, p0, Lcom/nvidia/devtech/HeightProvider$1;->val$finalView:Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2, v2, v2}, Lcom/nvidia/devtech/HeightProvider;->showAtLocation(Landroid/view/View;III)V

    .line 56
    return-void
.end method
