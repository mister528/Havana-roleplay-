.class Lcom/luxury/mobile/gui/HudManager$1;
.super Ljava/lang/Object;
.source "HudManager.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/HudManager;-><init>(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/HudManager;

.field final synthetic val$animation:Landroid/view/animation/Animation;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/HudManager;Landroid/view/animation/Animation;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/HudManager;

    .line 83
    iput-object p1, p0, Lcom/luxury/mobile/gui/HudManager$1;->this$0:Lcom/luxury/mobile/gui/HudManager;

    iput-object p2, p0, Lcom/luxury/mobile/gui/HudManager$1;->val$animation:Landroid/view/animation/Animation;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .line 86
    iget-object v0, p0, Lcom/luxury/mobile/gui/HudManager$1;->val$animation:Landroid/view/animation/Animation;

    invoke-virtual {p1, v0}, Landroid/view/View;->startAnimation(Landroid/view/animation/Animation;)V

    .line 87
    iget-object v0, p0, Lcom/luxury/mobile/gui/HudManager$1;->this$0:Lcom/luxury/mobile/gui/HudManager;

    invoke-static {v0}, Lcom/luxury/mobile/gui/HudManager;->access$000(Lcom/luxury/mobile/gui/HudManager;)V

    .line 88
    return-void
.end method
