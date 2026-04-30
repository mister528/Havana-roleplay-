.class Lcom/luxury/mobile/core/DialogClientSettings$1;
.super Ljava/lang/Object;
.source "DialogClientSettings.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettings;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/DialogClientSettings;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettings;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettings;

    .line 55
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettings$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .line 58
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettings$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    iget-object v0, v0, Lcom/luxury/mobile/core/DialogClientSettings;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowSave()V

    .line 59
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettings$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/DialogClientSettings;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Dialog;->dismiss()V

    .line 60
    return-void
.end method
