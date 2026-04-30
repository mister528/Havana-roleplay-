.class public Lcom/luxury/mobile/core/DialogClientSettingsOld;
.super Landroid/app/Dialog;
.source "DialogClientSettingsOld.java"


# static fields
.field static final mSettingsHudCount:I = 0xc


# instance fields
.field private mButtonAmmoColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonArmorColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonArmorTextColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonHPColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonHpTextColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonMoneyColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonRadarColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonWantedColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mChangingAllowed:Z

.field private mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

.field private mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

.field private mOldDrawables:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Landroid/view/ViewGroup;",
            "Landroid/graphics/drawable/Drawable;",
            ">;"
        }
    .end annotation
.end field

.field private mSwitchCutout:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchFPSCounter:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchHpArmour:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchKeyboard:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchOutfit:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchPCMoney:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchRadarrect:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchSkyBox:Landroidx/appcompat/widget/SwitchCompat;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .line 57
    invoke-direct {p0, p1}, Landroid/app/Dialog;-><init>(Landroid/content/Context;)V

    .line 52
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mChangingAllowed:Z

    .line 59
    move-object v0, p1

    check-cast v0, Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 60
    return-void
.end method

.method static synthetic access$002(Lcom/luxury/mobile/core/DialogClientSettingsOld;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsOld;
    .param p1, "x1"    # Z

    .line 26
    iput-boolean p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mChangingAllowed:Z

    return p1
.end method

.method private getColors()V
    .locals 0

    .line 195
    return-void
.end method

.method private getValues()V
    .locals 1

    .line 183
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mChangingAllowed:Z

    .line 187
    invoke-direct {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->getColors()V

    .line 189
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mChangingAllowed:Z

    .line 190
    return-void
.end method

.method private makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 6
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "notVisible"    # Landroid/view/View;
    .param p3, "first"    # Z

    .line 64
    const/4 v0, 0x0

    if-eqz p3, :cond_0

    .line 66
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mOldDrawables:Ljava/util/HashMap;

    .line 67
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 68
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v1, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 71
    :cond_0
    if-nez p1, :cond_1

    .line 72
    return-void

    .line 76
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_4

    .line 78
    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 80
    .local v2, "view":Landroid/view/View;
    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :cond_2

    .line 82
    move-object v3, v2

    check-cast v3, Landroid/view/ViewGroup;

    invoke-direct {p0, v3, p2, v0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 83
    iget-object v3, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mOldDrawables:Ljava/util/HashMap;

    move-object v4, v2

    check-cast v4, Landroid/view/ViewGroup;

    move-object v5, v2

    check-cast v5, Landroid/view/ViewGroup;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 84
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    .line 88
    :cond_2
    if-eq v2, p2, :cond_3

    .line 90
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setAlpha(F)V

    .line 76
    .end local v2    # "view":Landroid/view/View;
    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 94
    .end local v1    # "i":I
    :cond_4
    return-void
.end method

.method private makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 4
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "notVisible"    # Landroid/view/View;
    .param p3, "first"    # Z

    .line 98
    if-eqz p3, :cond_0

    .line 100
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mOldDrawables:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 101
    .local v0, "myVeryOwnIterator":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 103
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .line 104
    .local v1, "key":Landroid/view/ViewGroup;
    iget-object v2, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mOldDrawables:Ljava/util/HashMap;

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/graphics/drawable/Drawable;

    .line 106
    .local v2, "value":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 107
    .end local v1    # "key":Landroid/view/ViewGroup;
    .end local v2    # "value":Landroid/graphics/drawable/Drawable;
    goto :goto_0

    .line 110
    .end local v0    # "myVeryOwnIterator":Ljava/util/Iterator;
    :cond_0
    if-nez p1, :cond_1

    .line 112
    return-void

    .line 114
    :cond_1
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_4

    .line 116
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 118
    .local v1, "view":Landroid/view/View;
    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_2

    .line 120
    move-object v2, v1

    check-cast v2, Landroid/view/ViewGroup;

    const/4 v3, 0x0

    invoke-direct {p0, v2, p2, v3}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    goto :goto_2

    .line 124
    :cond_2
    if-eq v1, p2, :cond_3

    .line 126
    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v1, v2}, Landroid/view/View;->setAlpha(F)V

    .line 114
    .end local v1    # "view":Landroid/view/View;
    :cond_3
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 130
    .end local v0    # "i":I
    :cond_4
    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 1

    .line 169
    invoke-super {p0}, Landroid/app/Dialog;->onBackPressed()V

    .line 171
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->passValuesToNative()V

    .line 172
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onSettingsWindowSave()V

    .line 173
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->dismiss()V

    .line 174
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 136
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld;->mChangingAllowed:Z

    .line 137
    invoke-super {p0, p1}, Landroid/app/Dialog;->onCreate(Landroid/os/Bundle;)V

    .line 139
    const v1, 0x7f0c0039

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->setContentView(I)V

    .line 141
    const v1, 0x7f0901df

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->findViewById(I)Landroid/view/View;

    move-result-object v1

    invoke-virtual {v1}, Landroid/view/View;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v1

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsOld$1;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsOld;)V

    invoke-virtual {v1, v2}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    .line 148
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/Window;->setDimAmount(F)V

    .line 149
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/16 v2, 0x11

    invoke-virtual {v1, v2}, Landroid/view/Window;->setGravity(I)V

    .line 150
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->getWindow()Landroid/view/Window;

    move-result-object v1

    const/4 v2, -0x1

    invoke-virtual {v1, v2, v2}, Landroid/view/Window;->setLayout(II)V

    .line 151
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->getWindow()Landroid/view/Window;

    move-result-object v1

    new-instance v2, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v2, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v1, v2}, Landroid/view/Window;->setBackgroundDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 153
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-ge v1, v2, :cond_0

    .line 155
    const v1, 0x7f090215

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->findViewById(I)Landroid/view/View;

    move-result-object v1

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 163
    :cond_0
    invoke-virtual {p0, v0}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->setCancelable(Z)V

    .line 165
    return-void
.end method

.method public passValuesToNative()V
    .locals 0

    .line 179
    return-void
.end method
