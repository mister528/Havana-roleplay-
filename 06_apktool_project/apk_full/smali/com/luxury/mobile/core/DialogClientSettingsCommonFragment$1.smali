.class Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$1;
.super Ljava/lang/Object;
.source "DialogClientSettingsCommonFragment.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    .line 92
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 3
    .param p1, "compoundButton"    # Landroid/widget/CompoundButton;
    .param p2, "b"    # Z

    .line 95
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeCutoutSettings(Z)V

    .line 97
    new-instance v0, Lcom/luxury/mobile/core/NotificationDialogFragment;

    invoke-direct {v0}, Lcom/luxury/mobile/core/NotificationDialogFragment;-><init>()V

    .line 98
    .local v0, "newFragment":Landroidx/fragment/app/DialogFragment;
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-static {v1}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v1

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v1

    const-string v2, "missiles"

    invoke-virtual {v0, v1, v2}, Landroidx/fragment/app/DialogFragment;->show(Landroidx/fragment/app/FragmentManager;Ljava/lang/String;)V

    .line 100
    return-void
.end method
