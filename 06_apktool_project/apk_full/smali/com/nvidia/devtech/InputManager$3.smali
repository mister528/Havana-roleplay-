.class Lcom/nvidia/devtech/InputManager$3;
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

    .line 90
    iput-object p1, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .line 93
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$108(Lcom/nvidia/devtech/InputManager;)I

    .line 94
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$100(Lcom/nvidia/devtech/InputManager;)I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    iget-object v1, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v1}, Lcom/nvidia/devtech/InputManager;->access$200(Lcom/nvidia/devtech/InputManager;)Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-lt v0, v1, :cond_0

    .line 96
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$110(Lcom/nvidia/devtech/InputManager;)I

    .line 98
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$100(Lcom/nvidia/devtech/InputManager;)I

    move-result v0

    if-gtz v0, :cond_1

    .line 100
    return-void

    .line 103
    :cond_1
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v1}, Lcom/nvidia/devtech/InputManager;->access$200(Lcom/nvidia/devtech/InputManager;)Ljava/util/ArrayList;

    move-result-object v1

    iget-object v2, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v2}, Lcom/nvidia/devtech/InputManager;->access$100(Lcom/nvidia/devtech/InputManager;)I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 104
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v0

    iget-object v1, p0, Lcom/nvidia/devtech/InputManager$3;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v1}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-interface {v1}, Landroid/text/Editable;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setSelection(I)V

    .line 105
    return-void
.end method
