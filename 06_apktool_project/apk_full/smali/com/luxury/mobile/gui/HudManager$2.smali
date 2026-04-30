.class Lcom/luxury/mobile/gui/HudManager$2;
.super Ljava/lang/Object;
.source "HudManager.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/HudManager;->UpdateHudInfo(IIIIIIIII)V
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

    .line 114
    iput-object p1, p0, Lcom/luxury/mobile/gui/HudManager$2;->this$0:Lcom/luxury/mobile/gui/HudManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .line 117
    invoke-static {}, Lcom/nvidia/devtech/NvEventQueueActivity;->getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onWeaponChanged()V

    .line 118
    return-void
.end method
