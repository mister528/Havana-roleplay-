.class public Lcom/luxury/mobile/core/DialogClientSettingsAdapter;
.super Landroidx/fragment/app/FragmentPagerAdapter;
.source "DialogClientSettingsAdapter.java"


# instance fields
.field mFragmentCollection:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Landroidx/fragment/app/Fragment;",
            ">;"
        }
    .end annotation
.end field

.field mTitleCollection:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroidx/fragment/app/FragmentManager;I)V
    .locals 1
    .param p1, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "behavior"    # I

    .line 16
    invoke-direct {p0, p1, p2}, Landroidx/fragment/app/FragmentPagerAdapter;-><init>(Landroidx/fragment/app/FragmentManager;I)V

    .line 12
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mFragmentCollection:Ljava/util/List;

    .line 13
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mTitleCollection:Ljava/util/List;

    .line 17
    return-void
.end method


# virtual methods
.method public addFragment(Ljava/lang/String;Landroidx/fragment/app/Fragment;)V
    .locals 1
    .param p1, "title"    # Ljava/lang/String;
    .param p2, "fragment"    # Landroidx/fragment/app/Fragment;

    .line 21
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mTitleCollection:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 22
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mFragmentCollection:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 23
    return-void
.end method

.method public getCount()I
    .locals 1

    .line 35
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mFragmentCollection:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getItem(I)Landroidx/fragment/app/Fragment;
    .locals 1
    .param p1, "position"    # I

    .line 31
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mFragmentCollection:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroidx/fragment/app/Fragment;

    return-object v0
.end method

.method public getPageTitle(I)Ljava/lang/CharSequence;
    .locals 1
    .param p1, "position"    # I

    .line 27
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->mTitleCollection:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    return-object v0
.end method
