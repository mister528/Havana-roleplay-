.class Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;
.super Ljava/lang/Object;
.source "MaskedEditText.java"

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lbr/com/sapereaude/maskedEditText/MaskedEditText;->cleanUp()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;


# direct methods
.method constructor <init>(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)V
    .locals 0
    .param p1, "this$0"    # Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    .line 143
    iput-object p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;
    .param p2, "hasFocus"    # Z

    .line 146
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    invoke-static {v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->access$000(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)Landroid/view/View$OnFocusChangeListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 147
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    invoke-static {v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->access$000(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)Landroid/view/View$OnFocusChangeListener;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/view/View$OnFocusChangeListener;->onFocusChange(Landroid/view/View;Z)V

    .line 150
    :cond_0
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 151
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->access$102(Lbr/com/sapereaude/maskedEditText/MaskedEditText;Z)Z

    .line 152
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    invoke-static {v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->access$200(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)I

    move-result v1

    invoke-virtual {v0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setSelection(I)V

    .line 154
    :cond_1
    return-void
.end method
