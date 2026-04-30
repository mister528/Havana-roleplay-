.class Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;
.super Ljava/lang/Object;
.source "DialogClientSettingsHUDFragment.java"

# interfaces
.implements Landroid/widget/SeekBar$OnSeekBarChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->setSeekBarListeners()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    .line 127
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgressChanged(Landroid/widget/SeekBar;IZ)V
    .locals 1
    .param p1, "seekBar"    # Landroid/widget/SeekBar;
    .param p2, "i"    # I
    .param p3, "b"    # Z

    .line 130
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 132
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->passValuesToNative()V

    .line 134
    :cond_0
    return-void
.end method

.method public onStartTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 3
    .param p1, "seekBar"    # Landroid/widget/SeekBar;

    .line 138
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->access$100(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Landroid/view/ViewGroup;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, p1, v2}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->access$200(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 139
    return-void
.end method

.method public onStopTrackingTouch(Landroid/widget/SeekBar;)V
    .locals 3
    .param p1, "seekBar"    # Landroid/widget/SeekBar;

    .line 144
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->access$100(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Landroid/view/ViewGroup;

    move-result-object v1

    const/4 v2, 0x1

    invoke-static {v0, v1, p1, v2}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->access$300(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 145
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-static {v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->access$400(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowSave()V

    .line 146
    return-void
.end method
