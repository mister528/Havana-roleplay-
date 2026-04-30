.class Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;
.super Ljava/lang/Object;
.source "DialogClientSettingsFPSFragment.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->setSeekBarListeners()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    .line 130
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1
    .param p1, "seekBar"    # Landroid/widget/SeekBar;
    .param p2, "i"    # I
    .param p3, "b"    # Z

    .line 133
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 135
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->passValuesToNative()V

    .line 137
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 3
    .param p1, "seekBar"    # Landroid/widget/SeekBar;

    .line 141
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->access$100(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;)Landroid/view/ViewGroup;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, p1, v2}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->access$200(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 142
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 3
    .param p1, "seekBar"    # Landroid/widget/SeekBar;

    .line 147
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->access$100(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;)Landroid/view/ViewGroup;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, p1, v2}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->access$300(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 148
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->access$400(Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowSave()V

    .line 149
    return-void
.end method
