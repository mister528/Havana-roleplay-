.class Lcom/nvidia/devtech/InputManager$4;
.super Ljava/lang/Object;
.source "InputManager.java"

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


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

    .line 108
    iput-object p1, p0, Lcom/nvidia/devtech/InputManager$4;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 4
    .param p1, "textView"    # Landroid/widget/TextView;
    .param p2, "i"    # I
    .param p3, "keyEvent"    # Landroid/view/KeyEvent;

    .line 112
    const/4 v0, 0x6

    if-eq p2, v0, :cond_0

    const/4 v0, 0x5

    if-ne p2, v0, :cond_1

    .line 114
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager$4;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v0}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v0

    .line 115
    .local v0, "editableText":Landroid/text/Editable;
    if-eqz v0, :cond_1

    .line 117
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 119
    .local v1, "str":Ljava/lang/String;
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager$4;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v2}, Lcom/nvidia/devtech/InputManager;->access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;

    move-result-object v2

    const-string v3, ""

    invoke-virtual {v2, v3}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 121
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager$4;->this$0:Lcom/nvidia/devtech/InputManager;

    invoke-static {v2, v1}, Lcom/nvidia/devtech/InputManager;->access$300(Lcom/nvidia/devtech/InputManager;Ljava/lang/String;)V

    .line 125
    .end local v0    # "editableText":Landroid/text/Editable;
    .end local v1    # "str":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    return v0
.end method
