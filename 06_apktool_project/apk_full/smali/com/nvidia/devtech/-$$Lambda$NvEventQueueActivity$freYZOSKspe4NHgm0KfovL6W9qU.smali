.class public final synthetic Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$freYZOSKspe4NHgm0KfovL6W9qU;
.super Ljava/lang/Object;
.source "lambda"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/nvidia/devtech/NvEventQueueActivity;


# direct methods
.method public synthetic constructor <init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$freYZOSKspe4NHgm0KfovL6W9qU;->f$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$freYZOSKspe4NHgm0KfovL6W9qU;->f$0:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->lambda$showDialogWithOldContent$2$NvEventQueueActivity()V

    return-void
.end method
