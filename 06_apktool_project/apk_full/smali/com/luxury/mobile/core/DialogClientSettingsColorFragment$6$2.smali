.class Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6$2;
.super Ljava/lang/Object;
.source "DialogClientSettingsColorFragment.java"

# interfaces
.implements Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;)V
    .locals 0
    .param p1, "this$1"    # Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;

    .line 259
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6$2;->this$1:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onColorSelected(Lcom/skydoves/colorpickerview/ColorEnvelope;Z)V
    .locals 8
    .param p1, "envelope"    # Lcom/skydoves/colorpickerview/ColorEnvelope;
    .param p2, "fromUser"    # Z

    .line 262
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorEnvelope;->getArgb()[I

    move-result-object v0

    .line 263
    .local v0, "argb":[I
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6$2;->this$1:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;

    iget-object v1, v1, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-static {v1}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v2

    const/4 v1, 0x0

    aget v4, v0, v1

    const/4 v1, 0x1

    aget v5, v0, v1

    const/4 v1, 0x2

    aget v6, v0, v1

    const/4 v1, 0x3

    aget v7, v0, v1

    const/4 v3, 0x3

    invoke-virtual/range {v2 .. v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementColor(IIIII)V

    .line 264
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6$2;->this$1:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;

    iget-object v1, v1, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-virtual {v1}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->getValues()V

    .line 265
    return-void
.end method
