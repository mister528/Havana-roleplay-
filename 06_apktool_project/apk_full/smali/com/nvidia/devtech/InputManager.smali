.class public Lcom/nvidia/devtech/InputManager;
.super Ljava/lang/Object;
.source "InputManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/nvidia/devtech/InputManager$InputListener;
    }
.end annotation


# instance fields
.field private mAnimTask:Ljava/lang/Runnable;

.field private mButtonHistoryNext:Landroid/widget/Button;

.field private mButtonHistoryPrev:Landroid/widget/Button;

.field private mButtonSlash:Landroid/widget/Button;

.field private mContext:Landroid/app/Activity;

.field private mCurrentHistoryMessage:I

.field private mHeightProvider:Lcom/nvidia/devtech/HeightProvider;

.field private mInputEt:Landroid/widget/EditText;

.field private mInputHistory:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mInputLayout:Landroid/widget/LinearLayout;

.field private mIsShowing:Z

.field private final mMaxHistory:I

.field private mSavedInput:Ljava/lang/String;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 3
    .param p1, "act"    # Landroid/app/Activity;

    .line 53
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    .line 28
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    .line 30
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonSlash:Landroid/widget/Button;

    .line 31
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonHistoryNext:Landroid/widget/Button;

    .line 32
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonHistoryPrev:Landroid/widget/Button;

    .line 34
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    .line 35
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/nvidia/devtech/InputManager;->mIsShowing:Z

    .line 37
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mSavedInput:Ljava/lang/String;

    .line 39
    const/16 v2, 0x14

    iput v2, p0, Lcom/nvidia/devtech/InputManager;->mMaxHistory:I

    .line 40
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputHistory:Ljava/util/ArrayList;

    .line 41
    iput v1, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    .line 43
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mHeightProvider:Lcom/nvidia/devtech/HeightProvider;

    .line 45
    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mAnimTask:Ljava/lang/Runnable;

    .line 54
    iput-object p1, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    .line 56
    const v0, 0x7f09016c

    invoke-virtual {p1, v0}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/LinearLayout;

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    .line 57
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    const v1, 0x7f09016a

    invoke-virtual {v0, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    .line 58
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    const v1, 0x7f090169

    invoke-virtual {v0, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonSlash:Landroid/widget/Button;

    .line 59
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    const v1, 0x7f090168

    invoke-virtual {v0, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonHistoryPrev:Landroid/widget/Button;

    .line 60
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    const v1, 0x7f090167

    invoke-virtual {v0, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonHistoryNext:Landroid/widget/Button;

    .line 62
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputHistory:Ljava/util/ArrayList;

    .line 64
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonSlash:Landroid/widget/Button;

    new-instance v1, Lcom/nvidia/devtech/InputManager$1;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/InputManager$1;-><init>(Lcom/nvidia/devtech/InputManager;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 71
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonHistoryPrev:Landroid/widget/Button;

    new-instance v1, Lcom/nvidia/devtech/InputManager$2;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/InputManager$2;-><init>(Lcom/nvidia/devtech/InputManager;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 90
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mButtonHistoryNext:Landroid/widget/Button;

    new-instance v1, Lcom/nvidia/devtech/InputManager$3;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/InputManager$3;-><init>(Lcom/nvidia/devtech/InputManager;)V

    invoke-virtual {v0, v1}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 108
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    new-instance v1, Lcom/nvidia/devtech/InputManager$4;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/InputManager$4;-><init>(Lcom/nvidia/devtech/InputManager;)V

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 129
    invoke-virtual {p0}, Lcom/nvidia/devtech/InputManager;->HideInputLayout()V

    .line 130
    return-void
.end method

.method private OnInputEnd(Ljava/lang/String;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    .line 202
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputHistory:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/16 v1, 0x14

    if-lt v0, v1, :cond_0

    .line 204
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputHistory:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 206
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputHistory:Ljava/util/ArrayList;

    const/4 v1, 0x0

    invoke-virtual {v0, v1, p1}, Ljava/util/ArrayList;->add(ILjava/lang/Object;)V

    .line 208
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    check-cast v0, Lcom/nvidia/devtech/InputManager$InputListener;

    .line 210
    .local v0, "listener":Lcom/nvidia/devtech/InputManager$InputListener;
    invoke-interface {v0, p1}, Lcom/nvidia/devtech/InputManager$InputListener;->OnInputEnd(Ljava/lang/String;)V

    .line 211
    return-void
.end method

.method static synthetic access$000(Lcom/nvidia/devtech/InputManager;)Landroid/widget/EditText;
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;

    .line 20
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    return-object v0
.end method

.method static synthetic access$100(Lcom/nvidia/devtech/InputManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;

    .line 20
    iget v0, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    return v0
.end method

.method static synthetic access$102(Lcom/nvidia/devtech/InputManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;
    .param p1, "x1"    # I

    .line 20
    iput p1, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    return p1
.end method

.method static synthetic access$108(Lcom/nvidia/devtech/InputManager;)I
    .locals 2
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;

    .line 20
    iget v0, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    add-int/lit8 v1, v0, 0x1

    iput v1, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    return v0
.end method

.method static synthetic access$110(Lcom/nvidia/devtech/InputManager;)I
    .locals 2
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;

    .line 20
    iget v0, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    add-int/lit8 v1, v0, -0x1

    iput v1, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    return v0
.end method

.method static synthetic access$200(Lcom/nvidia/devtech/InputManager;)Ljava/util/ArrayList;
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;

    .line 20
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputHistory:Ljava/util/ArrayList;

    return-object v0
.end method

.method static synthetic access$300(Lcom/nvidia/devtech/InputManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;
    .param p1, "x1"    # Ljava/lang/String;

    .line 20
    invoke-direct {p0, p1}, Lcom/nvidia/devtech/InputManager;->OnInputEnd(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$400(Lcom/nvidia/devtech/InputManager;)Landroid/widget/LinearLayout;
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/InputManager;

    .line 20
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    return-object v0
.end method


# virtual methods
.method public HideInputLayout()V
    .locals 3

    .line 177
    const/4 v0, 0x0

    iput v0, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    .line 179
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getEditableText()Landroid/text/Editable;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 181
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getEditableText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/nvidia/devtech/InputManager;->mSavedInput:Ljava/lang/String;

    .line 184
    :cond_0
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mAnimTask:Ljava/lang/Runnable;

    if-eqz v1, :cond_1

    .line 186
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 187
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/nvidia/devtech/InputManager;->mAnimTask:Ljava/lang/Runnable;

    .line 190
    :cond_1
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getCurrentFocus()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_2

    .line 192
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    const-string v2, "input_method"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    .line 193
    .local v1, "inputMethodManager":Landroid/view/inputmethod/InputMethodManager;
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getCurrentFocus()Landroid/view/View;

    move-result-object v2

    invoke-virtual {v2}, Landroid/view/View;->getWindowToken()Landroid/os/IBinder;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 195
    .end local v1    # "inputMethodManager":Landroid/view/inputmethod/InputMethodManager;
    :cond_2
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 197
    iput-boolean v0, p0, Lcom/nvidia/devtech/InputManager;->mIsShowing:Z

    .line 198
    invoke-static {}, Lcom/nvidia/devtech/CmdSuggest;->hide()V

    return-void
.end method

.method public IsShowing()Z
    .locals 1

    .line 49
    iget-boolean v0, p0, Lcom/nvidia/devtech/InputManager;->mIsShowing:Z

    return v0
.end method

.method public ShowInputLayout()V
    .locals 5

    .line 141
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/nvidia/devtech/InputManager;->mIsShowing:Z

    .line 143
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/widget/LinearLayout;->setVisibility(I)V

    .line 145
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->requestFocus()Z

    .line 146
    iget-object v1, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    const-string v2, "input_method"

    invoke-virtual {v1, v2}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/inputmethod/InputMethodManager;

    .line 147
    .local v1, "imm":Landroid/view/inputmethod/InputMethodManager;
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    invoke-virtual {v1, v2, v0}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z

    .line 149
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mAnimTask:Ljava/lang/Runnable;

    if-eqz v0, :cond_0

    .line 151
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 152
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mAnimTask:Ljava/lang/Runnable;

    .line 155
    :cond_0
    new-instance v0, Lcom/nvidia/devtech/InputManager$5;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/InputManager$5;-><init>(Lcom/nvidia/devtech/InputManager;)V

    iput-object v0, p0, Lcom/nvidia/devtech/InputManager;->mAnimTask:Ljava/lang/Runnable;

    .line 163
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    const-wide/16 v3, 0x3c

    invoke-virtual {v2, v0, v3, v4}, Landroid/widget/LinearLayout;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 165
    const/4 v0, 0x0

    iput v0, p0, Lcom/nvidia/devtech/InputManager;->mCurrentHistoryMessage:I

    .line 167
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mSavedInput:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 169
    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    invoke-virtual {v2, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 170
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    invoke-virtual {v0}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/EditText;->setSelection(I)V

    .line 172
    :cond_1
    iget-object v0, p0, Lcom/nvidia/devtech/InputManager;->mContext:Landroid/app/Activity;

    iget-object v2, p0, Lcom/nvidia/devtech/InputManager;->mInputEt:Landroid/widget/EditText;

    iget-object v3, p0, Lcom/nvidia/devtech/InputManager;->mInputLayout:Landroid/widget/LinearLayout;

    invoke-static {v0, v2, v3}, Lcom/nvidia/devtech/CmdSuggest;->attach(Landroid/app/Activity;Landroid/widget/EditText;Landroid/widget/LinearLayout;)V

    return-void
.end method

.method public onHeightChanged(I)V
    .locals 0
    .param p1, "height"    # I

    invoke-static {p1}, Lcom/nvidia/devtech/CmdSuggest;->onHeightChanged(I)V

    return-void
.end method
