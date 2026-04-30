.class Lbr/com/sapereaude/maskedEditText/MaskedEditText$1;
.super Ljava/lang/Object;
.source "MaskedEditText.java"

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lbr/com/sapereaude/maskedEditText/MaskedEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
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

    .line 72
    iput-object p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$1;->this$0:Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "v"    # Landroid/widget/TextView;
    .param p2, "actionId"    # I
    .param p3, "event"    # Landroid/view/KeyEvent;

    .line 75
    nop

    .line 80
    const/4 v0, 0x1

    return v0
.end method
