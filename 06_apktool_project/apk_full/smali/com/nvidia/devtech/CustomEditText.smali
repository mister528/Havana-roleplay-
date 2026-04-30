.class public Lcom/nvidia/devtech/CustomEditText;
.super Landroid/widget/EditText;
.source "CustomEditText.java"


# instance fields
.field private mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 15
    invoke-direct {p0, p1, p2}, Landroid/widget/EditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 12
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/CustomEditText;->mContext:Landroid/content/Context;

    .line 16
    iput-object p1, p0, Lcom/nvidia/devtech/CustomEditText;->mContext:Landroid/content/Context;

    .line 17
    return-void
.end method


# virtual methods
.method public SetBackListener(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 20
    iput-object p1, p0, Lcom/nvidia/devtech/CustomEditText;->mContext:Landroid/content/Context;

    .line 21
    return-void
.end method

.method public onKeyPreIme(ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .line 25
    const/4 v0, 0x4

    if-ne p1, v0, :cond_0

    .line 26
    iget-object v0, p0, Lcom/nvidia/devtech/CustomEditText;->mContext:Landroid/content/Context;

    check-cast v0, Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onEventBackPressed()V

    .line 27
    const/4 v0, 0x1

    return v0

    .line 29
    :cond_0
    const/4 v0, 0x0

    return v0
.end method
