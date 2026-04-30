.class Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;
.super Ljava/lang/Object;
.source "DialogClientSettingsCommonFragment.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->setSeekBarListeners()V
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

    .line 171
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1
    .param p1, "seekBar"    # Landroid/widget/SeekBar;
    .param p2, "i"    # I
    .param p3, "b"    # Z

    .line 174
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->access$100(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 176
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->passValuesToNative()V

    .line 178
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 0
    .param p1, "seekBar"    # Landroid/widget/SeekBar;

    .line 182
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 1
    .param p1, "seekBar"    # Landroid/widget/SeekBar;

    .line 187
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowSave()V

    .line 188
    return-void
.end method
