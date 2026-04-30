.class Lcom/luxury/mobile/core/DialogClientSettings$2;
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

.field final synthetic val$adapter:Lcom/luxury/mobile/core/DialogClientSettingsAdapter;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettings;Lcom/luxury/mobile/core/DialogClientSettingsAdapter;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettings;

    .line 63
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    iput-object p2, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->val$adapter:Lcom/luxury/mobile/core/DialogClientSettingsAdapter;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .line 66
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    iget-object v0, v0, Lcom/luxury/mobile/core/DialogClientSettings;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    iget-object v1, v1, Lcom/luxury/mobile/core/DialogClientSettings;->tabLayout:Lcom/google/android/material/tabs/TabLayout;

    invoke-virtual {v1}, Lcom/google/android/material/tabs/TabLayout;->getSelectedTabPosition()I

    move-result v1

    add-int/lit8 v1, v1, 0x1

    invoke-virtual {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowDefaults(I)V

    .line 68
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->val$adapter:Lcom/luxury/mobile/core/DialogClientSettingsAdapter;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    iget-object v1, v1, Lcom/luxury/mobile/core/DialogClientSettings;->tabLayout:Lcom/google/android/material/tabs/TabLayout;

    invoke-virtual {v1}, Lcom/google/android/material/tabs/TabLayout;->getSelectedTabPosition()I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->getItem(I)Landroidx/fragment/app/Fragment;

    move-result-object v0

    check-cast v0, Lcom/luxury/mobile/core/ISaveableFragment;

    .line 69
    .local v0, "fragment":Lcom/luxury/mobile/core/ISaveableFragment;
    invoke-interface {v0}, Lcom/luxury/mobile/core/ISaveableFragment;->getValues()V

    .line 71
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettings$2;->this$0:Lcom/luxury/mobile/core/DialogClientSettings;

    iget-object v1, v1, Lcom/luxury/mobile/core/DialogClientSettings;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowSave()V

    .line 72
    return-void
.end method
