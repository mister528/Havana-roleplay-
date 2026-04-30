.class Lcom/luxury/mobile/gui/util/MaskedEditText$1;
.super Ljava/lang/Object;
.source "MaskedEditText.java"

# interfaces
.implements Landroid/view/View$OnFocusChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/util/MaskedEditText;->cleanUp()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/util/MaskedEditText;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;

    .line 113
    iput-object p1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;->this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFocusChange(Landroid/view/View;Z)V
    .locals 2
    .param p1, "v"    # Landroid/view/View;
    .param p2, "hasFocus"    # Z

    .line 117
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;->this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;

    invoke-static {v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$300(Lcom/luxury/mobile/gui/util/MaskedEditText;)Landroid/view/View$OnFocusChangeListener;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 118
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;->this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;

    invoke-static {v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$300(Lcom/luxury/mobile/gui/util/MaskedEditText;)Landroid/view/View$OnFocusChangeListener;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Landroid/view/View$OnFocusChangeListener;->onFocusChange(Landroid/view/View;Z)V

    .line 120
    :cond_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;->this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 121
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;->this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$402(Lcom/luxury/mobile/gui/util/MaskedEditText;Z)Z

    .line 122
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;->this$0:Lcom/luxury/mobile/gui/util/MaskedEditText;

    .line 123
    .local v0, "maskedEditText":Lcom/luxury/mobile/gui/util/MaskedEditText;
    invoke-static {v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$500(Lcom/luxury/mobile/gui/util/MaskedEditText;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setSelection(I)V

    .line 125
    .end local v0    # "maskedEditText":Lcom/luxury/mobile/gui/util/MaskedEditText;
    :cond_1
    return-void
.end method
