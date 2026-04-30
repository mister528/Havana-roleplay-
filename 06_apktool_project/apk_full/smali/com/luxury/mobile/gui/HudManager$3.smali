.class Lcom/luxury/mobile/gui/HudManager$3;
.super Ljava/util/TimerTask;
.source "HudManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/HudManager;->openTab()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/HudManager;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/HudManager;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/HudManager;

    .line 131
    iput-object p1, p0, Lcom/luxury/mobile/gui/HudManager$3;->this$0:Lcom/luxury/mobile/gui/HudManager;

    invoke-direct {p0}, Ljava/util/TimerTask;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    .line 134
    invoke-static {}, Lcom/nvidia/devtech/NvEventQueueActivity;->getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->showTab()V

    .line 135
    return-void
.end method
