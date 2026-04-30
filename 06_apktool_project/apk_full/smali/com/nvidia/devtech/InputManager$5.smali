.class Lcom/nvidia/devtech/InputManager$5;
.super Ljava/lang/Object;
.source "InputManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/nvidia/devtech/InputManager;->ShowInputLayout()V
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

    .line 155
    iput-object p1, p0, Lcom/nvidia/devtech/InputManager$5;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 158
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$5;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$400(Lcom/nvidia/devtech/InputManager;)Landroid/widget/LinearLayout;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 159
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$5;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->requestFocus()Z

    .line 160
    return-void
.end method
