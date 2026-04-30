.class public Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;
.super Landroidx/fragment/app/Fragment;
.source "DialogClientSettingsColorFragment.java"

# interfaces
.implements Lcom/luxury/mobile/core/ISaveableFragment;


# instance fields
.field private mButtonAmmoColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonArmorColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonArmorTextColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonHPColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonHpTextColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonMoneyColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonRadarColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mButtonWantedColor:Landroidx/appcompat/widget/AppCompatButton;

.field private mContext:Lcom/nvidia/devtech/NvEventQueueActivity;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 20
    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    .line 31
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    .line 20
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-object v0
.end method

.method public static createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;
    .locals 1
    .param p0, "txt"    # Ljava/lang/String;

    .line 35
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-direct {v0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;-><init>()V

    .line 36
    .local v0, "fragment":Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;
    return-object v0
.end method


# virtual methods
.method public getValues()V
    .locals 3

    .line 380
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 381
    .local v0, "color":Ljava/lang/String;
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonHPColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 383
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v2, 0x1

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 384
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonArmorColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 386
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v2, 0x2

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 387
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonMoneyColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 389
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v2, 0x3

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 390
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonWantedColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 392
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 393
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonHpTextColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 395
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v2, 0x5

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 396
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonArmorTextColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 398
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/4 v2, 0x6

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 399
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonRadarColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 401
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    const/16 v2, 0x9

    invoke-virtual {v1, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getHudElementColor(I)Ljava/lang/String;

    move-result-object v0

    .line 402
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonAmmoColor:Landroidx/appcompat/widget/AppCompatButton;

    invoke-static {v0}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setBackgroundColor(I)V

    .line 404
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 3
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 43
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 45
    const v0, 0x7f0c0035

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 47
    .local v0, "view":Landroid/view/View;
    const v1, 0x7f090072

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonHPColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 48
    const v1, 0x7f090070

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonArmorColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 49
    const v1, 0x7f090074

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonMoneyColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 50
    const v1, 0x7f090076

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonWantedColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 51
    const v1, 0x7f090073

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonHpTextColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 52
    const v1, 0x7f090071

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonArmorTextColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 53
    const v1, 0x7f090075

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonRadarColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 54
    const v1, 0x7f09006f

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/appcompat/widget/AppCompatButton;

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonAmmoColor:Landroidx/appcompat/widget/AppCompatButton;

    .line 56
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->getValues()V

    .line 58
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonRadarColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$1;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 97
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonAmmoColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$2;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$2;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 136
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonHPColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 175
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonArmorColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 214
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonMoneyColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$5;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$5;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 252
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonWantedColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$6;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 291
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonHpTextColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$7;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$7;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 330
    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->mButtonArmorTextColor:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v2, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V

    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 370
    return-object v0
.end method

.method public save()V
    .locals 0

    .line 376
    return-void
.end method
