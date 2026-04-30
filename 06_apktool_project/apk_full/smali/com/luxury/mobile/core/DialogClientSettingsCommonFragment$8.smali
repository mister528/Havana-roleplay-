.class Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$8;
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

    .line 145
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$8;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 1
    .param p1, "compoundButton"    # Landroid/widget/CompoundButton;
    .param p2, "b"    # Z

    .line 148
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$8;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0, p2}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeOutfitGunsSettings(Z)V

    .line 149
    return-void
.end method
