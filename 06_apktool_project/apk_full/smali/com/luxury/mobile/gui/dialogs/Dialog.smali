.class public Lcom/luxury/mobile/gui/dialogs/Dialog;
.super Ljava/lang/Object;
.source "Dialog.java"


# static fields
.field private static final DIALOG_LEFT_BTN_ID:I = 0x1

.field private static final DIALOG_RIGHT_BTN_ID:I = 0x0

.field private static final DIALOG_STYLE_INPUT:I = 0x1

.field private static final DIALOG_STYLE_LIST:I = 0x2

.field private static final DIALOG_STYLE_MSGBOX:I = 0x0

.field private static final DIALOG_STYLE_PASSWORD:I = 0x3

.field private static final DIALOG_STYLE_TABLIST:I = 0x4

.field private static final DIALOG_STYLE_TABLIST_HEADER:I = 0x5


# instance fields
.field private final mCaption:Landroid/widget/TextView;

.field private final mContent:Landroid/widget/TextView;

.field private mCurrentDialogId:I

.field private mCurrentDialogTypeId:I

.field private mCurrentInputText:Ljava/lang/String;

.field private mCurrentListItem:I

.field private final mCustomRecyclerView:Lcom/luxury/mobile/gui/util/CustomRecyclerView;

.field private final mHeadersList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field private final mInput:Lcom/nvidia/devtech/CustomEditText;

.field private final mInputLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

.field private final mLeftBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

.field private final mListLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

.field private final mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

.field private final mMsgBoxLayout:Landroid/widget/ScrollView;

.field private final mRightBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

.field private mRowsList:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 6
    .param p1, "activity"    # Landroid/app/Activity;

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    const/4 v0, -0x1

    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogId:I

    .line 34
    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogTypeId:I

    .line 35
    const-string v1, ""

    iput-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentInputText:Ljava/lang/String;

    .line 36
    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentListItem:I

    .line 49
    const v0, 0x7f0901cb

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout;

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 50
    const v0, 0x7f0901c0

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCaption:Landroid/widget/TextView;

    .line 51
    const v0, 0x7f0901cd

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mContent:Landroid/widget/TextView;

    .line 52
    const v0, 0x7f0901bd

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 53
    .local v0, "findViewById1":Landroidx/constraintlayout/widget/ConstraintLayout;
    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mLeftBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 54
    const v1, 0x7f0901bb

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 55
    .local v1, "findViewById2":Landroidx/constraintlayout/widget/ConstraintLayout;
    iput-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRightBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 56
    const v2, 0x7f0901c2

    invoke-virtual {p1, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/constraintlayout/widget/ConstraintLayout;

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInputLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 57
    const v2, 0x7f0901c9

    invoke-virtual {p1, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/constraintlayout/widget/ConstraintLayout;

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mListLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 58
    const v2, 0x7f0901ce

    invoke-virtual {p1, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ScrollView;

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMsgBoxLayout:Landroid/widget/ScrollView;

    .line 59
    const v2, 0x7f0901c1

    invoke-virtual {p1, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lcom/nvidia/devtech/CustomEditText;

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    .line 60
    const v2, 0x7f0901ca

    invoke-virtual {p1, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Lcom/luxury/mobile/gui/util/CustomRecyclerView;

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCustomRecyclerView:Lcom/luxury/mobile/gui/util/CustomRecyclerView;

    .line 61
    new-instance v2, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$ZQhbK9trpAmr14VsQdcNGkYBDTk;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$ZQhbK9trpAmr14VsQdcNGkYBDTk;-><init>(Lcom/luxury/mobile/gui/dialogs/Dialog;)V

    invoke-virtual {v0, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 62
    new-instance v2, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$MVWKcV_6frA27GLsUHlQpd67Mqc;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$MVWKcV_6frA27GLsUHlQpd67Mqc;-><init>(Lcom/luxury/mobile/gui/dialogs/Dialog;)V

    invoke-virtual {v1, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 63
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRowsList:Ljava/util/ArrayList;

    .line 64
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    .line 65
    const v2, 0x7f0901cc

    invoke-virtual {p1, v2}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 66
    .local v2, "mHeadersLayout":Landroidx/constraintlayout/widget/ConstraintLayout;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildCount()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 67
    iget-object v4, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    invoke-virtual {v2, v3}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/TextView;

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 66
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 69
    .end local v3    # "i":I
    :cond_0
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    new-instance v4, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$CqNhanARmwLMn7CvSqL5VonfKIc;

    invoke-direct {v4, p0}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$CqNhanARmwLMn7CvSqL5VonfKIc;-><init>(Lcom/luxury/mobile/gui/dialogs/Dialog;)V

    invoke-virtual {v3, v4}, Lcom/nvidia/devtech/CustomEditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 77
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    new-instance v4, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$YZEOPOzAXDcTKs4ywAuYPw9UnTA;

    invoke-direct {v4, p0}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$YZEOPOzAXDcTKs4ywAuYPw9UnTA;-><init>(Lcom/luxury/mobile/gui/dialogs/Dialog;)V

    invoke-virtual {v3, v4}, Lcom/nvidia/devtech/CustomEditText;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 82
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v4, 0x0

    invoke-static {v3, v4}, Lcom/luxury/mobile/gui/util/Utils;->HideLayout(Landroid/view/View;Z)V

    .line 83
    return-void
.end method

.method private clearDialogData()V
    .locals 3

    .line 167
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    const-string v1, ""

    invoke-virtual {v0, v1}, Lcom/nvidia/devtech/CustomEditText;->setText(Ljava/lang/CharSequence;)V

    .line 168
    const/4 v0, -0x1

    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogId:I

    .line 169
    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogTypeId:I

    .line 170
    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentListItem:I

    .line 171
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRowsList:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 172
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    if-ge v0, v1, :cond_0

    .line 173
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 172
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 175
    .end local v0    # "i":I
    :cond_0
    return-void
.end method

.method static synthetic lambda$show$6(Lcom/luxury/mobile/gui/dialogs/DialogAdapter;)V
    .locals 0
    .param p0, "adapter"    # Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

    .line 117
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->updateSizes()V

    return-void
.end method

.method private loadTabList(Ljava/lang/String;)V
    .locals 6
    .param p1, "content"    # Ljava/lang/String;

    .line 152
    const-string v0, "\n"

    invoke-virtual {p1, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 153
    .local v0, "strings":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    array-length v2, v0

    if-ge v1, v2, :cond_2

    .line 154
    iget v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogTypeId:I

    const/4 v3, 0x5

    if-ne v2, v3, :cond_1

    if-nez v1, :cond_1

    .line 155
    aget-object v2, v0, v1

    const-string v3, "\t"

    invoke-virtual {v2, v3}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 156
    .local v2, "headers":[Ljava/lang/String;
    const/4 v3, 0x0

    .local v3, "j":I
    :goto_1
    array-length v4, v2

    if-ge v3, v4, :cond_0

    .line 157
    iget-object v4, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    aget-object v5, v2, v3

    invoke-static {v5}, Lcom/luxury/mobile/gui/util/Utils;->transfromColors(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v5

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 158
    iget-object v4, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    invoke-virtual {v4, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 156
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 160
    .end local v2    # "headers":[Ljava/lang/String;
    .end local v3    # "j":I
    :cond_0
    goto :goto_2

    .line 161
    :cond_1
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRowsList:Ljava/util/ArrayList;

    aget-object v3, v0, v1

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 153
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 164
    .end local v1    # "i":I
    :cond_2
    return-void
.end method


# virtual methods
.method public hideWithoutReset()V
    .locals 2

    .line 130
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->HideLayout(Landroid/view/View;Z)V

    .line 131
    return-void
.end method

.method public synthetic lambda$new$0$Dialog(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .line 61
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->sendDialogResponse(I)V

    return-void
.end method

.method public synthetic lambda$new$1$Dialog(Landroid/view/View;)V
    .locals 1
    .param p1, "view"    # Landroid/view/View;

    .line 62
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->sendDialogResponse(I)V

    return-void
.end method

.method public synthetic lambda$new$2$Dialog(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 3
    .param p1, "textView"    # Landroid/widget/TextView;
    .param p2, "i"    # I
    .param p3, "keyEvent"    # Landroid/view/KeyEvent;

    .line 71
    const/4 v0, 0x0

    const/4 v1, 0x6

    if-eq p2, v1, :cond_0

    const/4 v1, 0x5

    if-ne p2, v1, :cond_1

    :cond_0
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    invoke-virtual {v1}, Lcom/nvidia/devtech/CustomEditText;->getText()Landroid/text/Editable;

    move-result-object v1

    move-object v2, v1

    .local v2, "editableText":Landroid/text/Editable;
    if-nez v1, :cond_2

    .line 72
    .end local v2    # "editableText":Landroid/text/Editable;
    :cond_1
    return v0

    .line 74
    .restart local v2    # "editableText":Landroid/text/Editable;
    :cond_2
    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentInputText:Ljava/lang/String;

    .line 75
    return v0
.end method

.method public synthetic lambda$new$3$Dialog(Landroid/view/View;)V
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .line 79
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    invoke-virtual {v0}, Lcom/nvidia/devtech/CustomEditText;->requestFocus()Z

    .line 80
    invoke-static {}, Lcom/nvidia/devtech/NvEventQueueActivity;->getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    const-string v1, "input_method"

    invoke-virtual {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z

    .line 81
    return-void
.end method

.method public synthetic lambda$show$4$Dialog(ILjava/lang/String;)V
    .locals 0
    .param p1, "i"    # I
    .param p2, "str"    # Ljava/lang/String;

    .line 109
    iput p1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentListItem:I

    .line 110
    iput-object p2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentInputText:Ljava/lang/String;

    return-void
.end method

.method public synthetic lambda$show$5$Dialog()V
    .locals 1

    .line 111
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->sendDialogResponse(I)V

    return-void
.end method

.method public onHeightChanged(I)V
    .locals 2
    .param p1, "height"    # I

    .line 178
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v0}, Landroidx/constraintlayout/widget/ConstraintLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout$LayoutParams;

    .line 179
    .local v0, "params":Landroid/widget/FrameLayout$LayoutParams;
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1, v1, p1}, Landroid/widget/FrameLayout$LayoutParams;->setMargins(IIII)V

    .line 180
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v1, v0}, Landroidx/constraintlayout/widget/ConstraintLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 181
    return-void
.end method

.method public sendDialogResponse(I)V
    .locals 5
    .param p1, "btnId"    # I

    .line 138
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentInputText:Ljava/lang/String;

    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    invoke-virtual {v1}, Lcom/nvidia/devtech/CustomEditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 139
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    invoke-virtual {v0}, Lcom/nvidia/devtech/CustomEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentInputText:Ljava/lang/String;

    .line 141
    :cond_0
    invoke-static {}, Lcom/nvidia/devtech/NvEventQueueActivity;->getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    const-string v1, "input_method"

    invoke-virtual {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInput:Lcom/nvidia/devtech/CustomEditText;

    invoke-virtual {v1}, Lcom/nvidia/devtech/CustomEditText;->getWindowToken()Landroid/os/IBinder;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 143
    :try_start_0
    invoke-static {}, Lcom/nvidia/devtech/NvEventQueueActivity;->getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v0

    iget v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogId:I

    iget v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentListItem:I

    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentInputText:Ljava/lang/String;

    const-string v4, "windows-1251"

    invoke-virtual {v3, v4}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    invoke-virtual {v0, p1, v1, v2, v3}, Lcom/nvidia/devtech/NvEventQueueActivity;->sendDialogResponse(III[B)V

    .line 144
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->HideLayout(Landroid/view/View;Z)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 148
    goto :goto_0

    .line 146
    :catch_0
    move-exception v0

    .line 147
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {v0}, Ljava/io/UnsupportedEncodingException;->printStackTrace()V

    .line 149
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :goto_0
    return-void
.end method

.method public show(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 8
    .param p1, "dialogId"    # I
    .param p2, "dialogTypeId"    # I
    .param p3, "caption"    # Ljava/lang/String;
    .param p4, "content"    # Ljava/lang/String;
    .param p5, "leftBtnText"    # Ljava/lang/String;
    .param p6, "rightBtnText"    # Ljava/lang/String;

    .line 86
    invoke-direct {p0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->clearDialogData()V

    .line 87
    iput p1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogId:I

    .line 88
    iput p2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCurrentDialogTypeId:I

    .line 89
    const/4 v0, 0x1

    const/16 v1, 0x8

    const/4 v2, 0x0

    if-nez p2, :cond_0

    .line 90
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInputLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 91
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mListLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 92
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMsgBoxLayout:Landroid/widget/ScrollView;

    invoke-virtual {v3, v2}, Landroid/widget/ScrollView;->setVisibility(I)V

    goto :goto_1

    .line 94
    :cond_0
    if-eq p2, v0, :cond_2

    const/4 v3, 0x3

    if-ne p2, v3, :cond_1

    goto :goto_0

    .line 102
    :cond_1
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInputLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 103
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMsgBoxLayout:Landroid/widget/ScrollView;

    invoke-virtual {v3, v1}, Landroid/widget/ScrollView;->setVisibility(I)V

    .line 104
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mListLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 105
    invoke-direct {p0, p4}, Lcom/luxury/mobile/gui/dialogs/Dialog;->loadTabList(Ljava/lang/String;)V

    .line 106
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRowsList:Ljava/util/ArrayList;

    invoke-static {v3}, Lcom/luxury/mobile/gui/util/Utils;->fixFieldsForDialog(Ljava/util/ArrayList;)Ljava/util/ArrayList;

    move-result-object v3

    .line 107
    .local v3, "fixFieldsForDialog":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    iput-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRowsList:Ljava/util/ArrayList;

    .line 108
    new-instance v4, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

    iget-object v5, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mHeadersList:Ljava/util/ArrayList;

    invoke-direct {v4, v3, v5}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;-><init>(Ljava/util/ArrayList;Ljava/util/ArrayList;)V

    .line 109
    .local v4, "adapter":Lcom/luxury/mobile/gui/dialogs/DialogAdapter;
    new-instance v5, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$FzcZNOhSiHeA74EKleOsWlZRWnM;

    invoke-direct {v5, p0}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$FzcZNOhSiHeA74EKleOsWlZRWnM;-><init>(Lcom/luxury/mobile/gui/dialogs/Dialog;)V

    invoke-virtual {v4, v5}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->setOnClickListener(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;)V

    .line 111
    new-instance v5, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$7M8G9z2UPRnuJoV9TxkeYyJFyXs;

    invoke-direct {v5, p0}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$7M8G9z2UPRnuJoV9TxkeYyJFyXs;-><init>(Lcom/luxury/mobile/gui/dialogs/Dialog;)V

    invoke-virtual {v4, v5}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->setOnDoubleClickListener(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;)V

    .line 112
    iget-object v5, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCustomRecyclerView:Lcom/luxury/mobile/gui/util/CustomRecyclerView;

    new-instance v6, Landroidx/recyclerview/widget/LinearLayoutManager;

    invoke-static {}, Lcom/nvidia/devtech/NvEventQueueActivity;->getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v7

    invoke-direct {v6, v7}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    invoke-virtual {v5, v6}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    .line 113
    iget-object v5, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCustomRecyclerView:Lcom/luxury/mobile/gui/util/CustomRecyclerView;

    invoke-virtual {v5, v4}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    .line 114
    const/4 v5, 0x2

    if-eq p2, v5, :cond_3

    .line 115
    iget-object v5, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCustomRecyclerView:Lcom/luxury/mobile/gui/util/CustomRecyclerView;

    .line 116
    .local v5, "customRecyclerView":Lcom/luxury/mobile/gui/util/CustomRecyclerView;
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    .line 117
    new-instance v6, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$NoDmBZ66k09NPVdr4SIhP2r-oFs;

    invoke-direct {v6, v4}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$NoDmBZ66k09NPVdr4SIhP2r-oFs;-><init>(Lcom/luxury/mobile/gui/dialogs/DialogAdapter;)V

    invoke-virtual {v5, v6}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->post(Ljava/lang/Runnable;)Z

    goto :goto_1

    .line 96
    .end local v3    # "fixFieldsForDialog":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .end local v4    # "adapter":Lcom/luxury/mobile/gui/dialogs/DialogAdapter;
    .end local v5    # "customRecyclerView":Lcom/luxury/mobile/gui/util/CustomRecyclerView;
    :cond_2
    :goto_0
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mInputLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 97
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMsgBoxLayout:Landroid/widget/ScrollView;

    invoke-virtual {v3, v2}, Landroid/widget/ScrollView;->setVisibility(I)V

    .line 98
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mListLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 120
    :cond_3
    :goto_1
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mCaption:Landroid/widget/TextView;

    invoke-static {p3}, Lcom/luxury/mobile/gui/util/Utils;->transfromColors(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 121
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mContent:Landroid/widget/TextView;

    invoke-static {p4}, Lcom/luxury/mobile/gui/util/Utils;->transfromColors(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 122
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mLeftBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    invoke-static {p5}, Lcom/luxury/mobile/gui/util/Utils;->transfromColors(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 123
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRightBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v3, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    invoke-static {p6}, Lcom/luxury/mobile/gui/util/Utils;->transfromColors(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v4

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 124
    const-string v3, ""

    invoke-virtual {p6, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRightBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v2, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    goto :goto_2

    .line 125
    :cond_4
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mRightBtn:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-virtual {v1, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 126
    :goto_2
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    invoke-static {v1, v0}, Lcom/luxury/mobile/gui/util/Utils;->ShowLayout(Landroid/view/View;Z)V

    .line 127
    return-void
.end method

.method public showWithOldContent()V
    .locals 2

    .line 134
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/Dialog;->mMainLayout:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->ShowLayout(Landroid/view/View;Z)V

    .line 135
    return-void
.end method
