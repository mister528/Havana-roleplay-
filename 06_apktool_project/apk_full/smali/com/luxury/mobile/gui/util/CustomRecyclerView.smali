.class public Lcom/luxury/mobile/gui/util/CustomRecyclerView;
.super Landroidx/recyclerview/widget/RecyclerView;
.source "CustomRecyclerView.java"


# instance fields
.field private mEnableScrolling:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 11
    invoke-direct {p0, p1}, Landroidx/recyclerview/widget/RecyclerView;-><init>(Landroid/content/Context;)V

    .line 8
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->mEnableScrolling:Z

    .line 12
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 15
    invoke-direct {p0, p1, p2}, Landroidx/recyclerview/widget/RecyclerView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 8
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->mEnableScrolling:Z

    .line 16
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 19
    invoke-direct {p0, p1, p2, p3}, Landroidx/recyclerview/widget/RecyclerView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 8
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->mEnableScrolling:Z

    .line 20
    return-void
.end method

.method static synthetic access$001(Lcom/luxury/mobile/gui/util/CustomRecyclerView;Landroid/view/MotionEvent;)Z
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/CustomRecyclerView;
    .param p1, "x1"    # Landroid/view/MotionEvent;

    .line 7
    invoke-super {p0, p1}, Landroidx/recyclerview/widget/RecyclerView;->onInterceptTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method

.method static synthetic access$101(Lcom/luxury/mobile/gui/util/CustomRecyclerView;Landroid/view/MotionEvent;)Z
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/CustomRecyclerView;
    .param p1, "x1"    # Landroid/view/MotionEvent;

    .line 7
    invoke-super {p0, p1}, Landroidx/recyclerview/widget/RecyclerView;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method


# virtual methods
.method public getScrollForRecycler()I
    .locals 1

    .line 37
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->computeVerticalScrollOffset()I

    move-result v0

    return v0
.end method

.method public isEnableScrolling()Z
    .locals 1

    .line 41
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->mEnableScrolling:Z

    return v0
.end method

.method public onInterceptTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "motionEvent"    # Landroid/view/MotionEvent;

    .line 23
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->isEnableScrolling()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 24
    invoke-static {p0, p1}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->access$001(Lcom/luxury/mobile/gui/util/CustomRecyclerView;Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 26
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "motionEvent"    # Landroid/view/MotionEvent;

    .line 30
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->isEnableScrolling()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 31
    invoke-static {p0, p1}, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->access$101(Lcom/luxury/mobile/gui/util/CustomRecyclerView;Landroid/view/MotionEvent;)Z

    move-result v0

    return v0

    .line 33
    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public setEnableScrolling(Z)V
    .locals 0
    .param p1, "z"    # Z

    .line 45
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/CustomRecyclerView;->mEnableScrolling:Z

    .line 46
    return-void
.end method
