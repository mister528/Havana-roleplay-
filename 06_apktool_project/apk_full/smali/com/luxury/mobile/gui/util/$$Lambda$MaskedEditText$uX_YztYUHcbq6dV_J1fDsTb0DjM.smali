.class public final Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;
.super Ljava/lang/Object;
.source "$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM.java"

# interfaces
.implements Landroid/widget/TextView$OnEditorActionListener;


# static fields
.field public static final INSTANCE:Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 9
    new-instance v0, Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;

    invoke-direct {v0}, Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;-><init>()V

    sput-object v0, Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;->INSTANCE:Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    return-void
.end method


# virtual methods
.method public final onEditorAction(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "textView"    # Landroid/widget/TextView;
    .param p2, "i"    # I
    .param p3, "keyEvent"    # Landroid/view/KeyEvent;

    .line 15
    invoke-static {p1, p2, p3}, Lcom/luxury/mobile/gui/util/MaskedEditText;->lambda$new$0(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z

    move-result v0

    return v0
.end method
