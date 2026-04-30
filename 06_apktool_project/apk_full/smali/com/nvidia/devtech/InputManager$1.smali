.class Lcom/nvidia/devtech/InputManager$1;
.super Ljava/lang/Object;
.source "InputManager.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/InputManager;-><init>(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/nvidia/devtech/InputManager;


# direct methods
.method constructor <init>(Lcom/nvidia/devtech/InputManager;)V
    .locals 0
    .param p1, "this$0"    # Lcom/nvidia/devtech/InputManager;

    .line 64
    iput-object p1, p0, Lcom/nvidia/devtech/InputManager$1;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .line 67
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$1;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    iget-object v1, p0, Lcom/nvidia/devtech/InputManager$1;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v1}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getSelectionStart()I

    move-result v1

    const-string v2, "/"

    invoke-interface {v0, v1, v2}, Landroid/text/Editable;->insert(ILjava/lang/CharSequence;)Landroid/text/Editable;

    .line 68
    return-void
.end method
