.class public Lcom/luxury/mobile/core/DialogClientSettings;
.super Landroidx/fragment/app/DialogFragment;
.source "DialogClientSettings.java"


# static fields
.field static final mSettingsComonEnd:I = 0xf

.field static final mSettingsComonStart:I = 0xe

.field static final mSettingsHudCount:I = 0xa

.field static final mSettingsHudFPSEnd:I = 0xc

.field static final mSettingsHudFPSStart:I = 0xa

.field static final mSettingsWeaponsEnd:I = 0xe

.field static final mSettingsWeaponsStart:I = 0xc


# instance fields
.field mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

.field tabLayout:Lcom/google/android/material/tabs/TabLayout;

.field viewPager:Landroidx/viewpager/widget/ViewPager;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Landroidx/fragment/app/DialogFragment;-><init>()V

    .line 31
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettings;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-void
.end method


# virtual methods
.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 6
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 38
    const v0, 0x7f0c0034

    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 39
    .local v0, "rootview":Landroid/view/View;
    const v1, 0x7f09021e

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/google/android/material/tabs/TabLayout;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettings;->tabLayout:Lcom/google/android/material/tabs/TabLayout;

    .line 40
    const v1, 0x7f09016f

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/viewpager/widget/ViewPager;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettings;->viewPager:Landroidx/viewpager/widget/ViewPager;

    .line 41
    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;

    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettings;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v3

    invoke-direct {v1, v3, v2}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;-><init>(Landroidx/fragment/app/FragmentManager;I)V

    .line 42
    .local v1, "adapter":Lcom/luxury/mobile/core/DialogClientSettingsAdapter;
    const-string v3, "common"

    invoke-static {v3}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    move-result-object v3

    const-string v4, "\u0631\u0626\u064a\u0633\u064a"

    invoke-virtual {v1, v4, v3}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->addFragment(Ljava/lang/String;Landroidx/fragment/app/Fragment;)V

    .line 43
    const-string v3, "colors"

    invoke-static {v3}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    move-result-object v3

    const-string v4, "\u0627\u0644\u0623\u0644\u0648\u0627\u0646"

    invoke-virtual {v1, v4, v3}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->addFragment(Ljava/lang/String;Landroidx/fragment/app/Fragment;)V

    .line 44
    const-string v3, "fps"

    invoke-static {v3}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    move-result-object v3

    const v4, 0x7f090166

    invoke-virtual {v0, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/view/ViewGroup;

    invoke-virtual {v3, v5}, Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;->setRoot(Landroid/view/ViewGroup;)Lcom/luxury/mobile/core/DialogClientSettingsFPSFragment;

    move-result-object v3

    const-string v5, "\u0627\u0644\u0634\u062e\u0635 \u0627\u0644\u0623\u0648\u0644"

    invoke-virtual {v1, v5, v3}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->addFragment(Ljava/lang/String;Landroidx/fragment/app/Fragment;)V

    .line 45
    const-string v3, "hud"

    invoke-static {v3}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    move-result-object v3

    invoke-virtual {v0, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/view/ViewGroup;

    invoke-virtual {v3, v5}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->setRoot(Landroid/view/ViewGroup;)Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    move-result-object v3

    const-string v5, "HUD"

    invoke-virtual {v1, v5, v3}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->addFragment(Ljava/lang/String;Landroidx/fragment/app/Fragment;)V

    .line 46
    const-string v3, "weapons"

    invoke-static {v3}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;

    move-result-object v3

    invoke-virtual {v0, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/view/ViewGroup;

    invoke-virtual {v3, v4}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->setRoot(Landroid/view/ViewGroup;)Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;

    move-result-object v3

    const-string v4, "\u0627\u0644\u0623\u0633\u0644\u062d\u0629"

    invoke-virtual {v1, v4, v3}, Lcom/luxury/mobile/core/DialogClientSettingsAdapter;->addFragment(Ljava/lang/String;Landroidx/fragment/app/Fragment;)V

    .line 47
    iget-object v3, p0, Lcom/luxury/mobile/core/DialogClientSettings;->viewPager:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {v3, v1}, Landroidx/viewpager/widget/ViewPager;->setAdapter(Landroidx/viewpager/widget/PagerAdapter;)V

    .line 48
    iget-object v3, p0, Lcom/luxury/mobile/core/DialogClientSettings;->tabLayout:Lcom/google/android/material/tabs/TabLayout;

    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettings;->viewPager:Landroidx/viewpager/widget/ViewPager;

    invoke-virtual {v3, v4}, Lcom/google/android/material/tabs/TabLayout;->setupWithViewPager(Landroidx/viewpager/widget/ViewPager;)V

    .line 50
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettings;->getDialog()Landroid/app/Dialog;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    new-instance v4, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v4, v2}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v3, v4}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 51
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettings;->getDialog()Landroid/app/Dialog;

    move-result-object v3

    invoke-virtual {v3}, Landroid/app/Dialog;->getWindow()Landroid/view/Window;

    move-result-object v3

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/view/Window;->setDimAmount(F)V

    .line 53
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettings;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v3

    check-cast v3, Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object v3, p0, Lcom/luxury/mobile/core/DialogClientSettings;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 55
    const v3, 0x7f0900b9

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroidx/appcompat/widget/AppCompatButton;

    new-instance v4, Lcom/luxury/mobile/core/DialogClientSettings$1;

    invoke-direct {v4, p0}, Lcom/luxury/mobile/core/DialogClientSettings$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettings;)V

    invoke-virtual {v3, v4}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 63
    const v3, 0x7f0900ba

    invoke-virtual {v0, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroidx/appcompat/widget/AppCompatButton;

    new-instance v4, Lcom/luxury/mobile/core/DialogClientSettings$2;

    invoke-direct {v4, p0, v1}, Lcom/luxury/mobile/core/DialogClientSettings$2;-><init>(Lcom/luxury/mobile/core/DialogClientSettings;Lcom/luxury/mobile/core/DialogClientSettingsAdapter;)V

    invoke-virtual {v3, v4}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 75
    invoke-virtual {p0, v2}, Lcom/luxury/mobile/core/DialogClientSettings;->setCancelable(Z)V

    .line 77
    return-object v0
.end method
