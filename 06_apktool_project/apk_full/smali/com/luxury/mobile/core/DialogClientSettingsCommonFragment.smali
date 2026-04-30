.class public Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;
.super Landroidx/fragment/app/Fragment;
.source "DialogClientSettingsCommonFragment.java"

# interfaces
.implements Lcom/luxury/mobile/core/ISaveableFragment;


# instance fields
.field private bChangeAllowed:Z

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

.field private mParentView:Landroid/view/ViewGroup;

.field private mRootView:Landroid/view/View;

.field private mSwitchCutout:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchDialog:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchFPSCounter:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchHpArmour:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchHud:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchKeyboard:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchOutfit:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchPCMoney:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchRadarrect:Landroidx/appcompat/widget/SwitchCompat;

.field private mSwitchSkyBox:Landroidx/appcompat/widget/SwitchCompat;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 21
    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    .line 33
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 35
    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    .line 37
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->bChangeAllowed:Z

    .line 42
    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mParentView:Landroid/view/ViewGroup;

    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    .line 21
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-object v0
.end method

.method static synthetic access$100(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    .line 21
    iget-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->bChangeAllowed:Z

    return v0
.end method

.method public static createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;
    .locals 1
    .param p0, "txt"    # Ljava/lang/String;

    .line 46
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;

    invoke-direct {v0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;-><init>()V

    .line 47
    .local v0, "fragment":Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;
    return-object v0
.end method

.method private setSeekBarListeners()V
    .locals 10

    .line 171
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;

    invoke-direct {v0, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$11;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    .line 191
    const/16 v0, 0xe

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xf

    const-string v2, "id"

    if-ge v0, v1, :cond_2

    .line 193
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hud_element_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 194
    .local v1, "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 196
    .local v3, "widgetY":Ljava/lang/String;
    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v4}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 197
    .local v4, "resIDX":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 199
    .local v2, "resIDY":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v5, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/SeekBar;

    .line 200
    .local v5, "barX":Landroid/widget/SeekBar;
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/SeekBar;

    .line 202
    .local v6, "barY":Landroid/widget/SeekBar;
    if-eqz v5, :cond_0

    .line 204
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v5, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 206
    :cond_0
    if-eqz v6, :cond_1

    .line 208
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v6, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 191
    .end local v1    # "widgetX":Ljava/lang/String;
    .end local v2    # "resIDY":I
    .end local v3    # "widgetY":Ljava/lang/String;
    .end local v4    # "resIDX":I
    .end local v5    # "barX":Landroid/widget/SeekBar;
    .end local v6    # "barY":Landroid/widget/SeekBar;
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 212
    .end local v0    # "i":I
    :cond_2
    const/16 v0, 0xe

    .restart local v0    # "i":I
    :goto_1
    if-ge v0, v1, :cond_5

    .line 214
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_scale_x_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 215
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hud_element_scale_y_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 217
    .local v4, "widgetY":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 218
    .local v5, "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 220
    .local v6, "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v7, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/SeekBar;

    .line 221
    .local v7, "barX":Landroid/widget/SeekBar;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 223
    .local v8, "barY":Landroid/widget/SeekBar;
    if-eqz v7, :cond_3

    .line 225
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v7, v9}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 227
    :cond_3
    if-eqz v8, :cond_4

    .line 229
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v8, v9}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 212
    .end local v3    # "widgetX":Ljava/lang/String;
    .end local v4    # "widgetY":Ljava/lang/String;
    .end local v5    # "resIDX":I
    .end local v6    # "resIDY":I
    .end local v7    # "barX":Landroid/widget/SeekBar;
    .end local v8    # "barY":Landroid/widget/SeekBar;
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 232
    .end local v0    # "i":I
    :cond_5
    return-void
.end method


# virtual methods
.method public getValues()V
    .locals 14

    .line 241
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchKeyboard:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeKeyboardSettings()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 242
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchCutout:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeCutoutSettings()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 243
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchFPSCounter:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeFpsCounterSettings()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 244
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchHpArmour:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHpArmourText()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 245
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchOutfit:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeOutfitGunsSettings()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 246
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchPCMoney:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativePcMoney()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 247
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchRadarrect:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeRadarrect()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 248
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchSkyBox:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeSkyBox()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 249
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchDialog:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeDialog()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 250
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchHud:Landroidx/appcompat/widget/SwitchCompat;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHud()Z

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setChecked(Z)V

    .line 252
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->bChangeAllowed:Z

    .line 253
    const/16 v1, 0xe

    .local v1, "i":I
    :goto_0
    const/16 v2, 0xf

    const-string v3, "id"

    const/4 v4, -0x1

    const/4 v5, 0x1

    if-ge v1, v2, :cond_4

    .line 255
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "hud_element_pos_x_"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 256
    .local v2, "widgetX":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "hud_element_pos_y_"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 258
    .local v6, "widgetY":Ljava/lang/String;
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v2, v3, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    .line 259
    .local v7, "resIDX":I
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v6, v3, v9}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 261
    .local v3, "resIDY":I
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 262
    .local v8, "barX":Landroid/widget/SeekBar;
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v9, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/SeekBar;

    .line 264
    .local v9, "barY":Landroid/widget/SeekBar;
    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementPosition(I)[I

    move-result-object v10

    .line 266
    .local v10, "pos":[I
    aget v11, v10, v0

    if-ne v11, v4, :cond_0

    .line 268
    aput v5, v10, v0

    .line 270
    :cond_0
    aget v11, v10, v5

    if-ne v11, v4, :cond_1

    .line 272
    aput v5, v10, v5

    .line 275
    :cond_1
    if-eqz v8, :cond_2

    .line 277
    aget v4, v10, v0

    invoke-virtual {v8, v4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 279
    :cond_2
    if-eqz v9, :cond_3

    .line 281
    aget v4, v10, v5

    invoke-virtual {v9, v4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 253
    .end local v2    # "widgetX":Ljava/lang/String;
    .end local v3    # "resIDY":I
    .end local v6    # "widgetY":Ljava/lang/String;
    .end local v7    # "resIDX":I
    .end local v8    # "barX":Landroid/widget/SeekBar;
    .end local v9    # "barY":Landroid/widget/SeekBar;
    .end local v10    # "pos":[I
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 285
    .end local v1    # "i":I
    :cond_4
    const/16 v1, 0xe

    .restart local v1    # "i":I
    :goto_1
    if-ge v1, v2, :cond_9

    .line 287
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "hud_element_scale_x_"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 288
    .local v6, "widgetX":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "hud_element_scale_y_"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 290
    .local v7, "widgetY":Ljava/lang/String;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v6, v3, v9}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 291
    .local v8, "resIDX":I
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v7, v3, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v9

    .line 293
    .local v9, "resIDY":I
    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v10, v8}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/SeekBar;

    .line 294
    .local v10, "barX":Landroid/widget/SeekBar;
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v11, v9}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/SeekBar;

    .line 296
    .local v11, "barY":Landroid/widget/SeekBar;
    iget-object v12, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v12, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementScale(I)[I

    move-result-object v12

    .line 298
    .local v12, "pos":[I
    aget v13, v12, v0

    if-ne v13, v4, :cond_5

    .line 300
    aput v5, v12, v0

    .line 302
    :cond_5
    aget v13, v12, v5

    if-ne v13, v4, :cond_6

    .line 304
    aput v5, v12, v5

    .line 307
    :cond_6
    if-eqz v10, :cond_7

    aget v13, v12, v0

    if-eq v13, v4, :cond_7

    .line 309
    aget v13, v12, v0

    invoke-virtual {v10, v13}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 311
    :cond_7
    if-eqz v11, :cond_8

    aget v13, v12, v5

    if-eq v13, v4, :cond_8

    .line 313
    aget v13, v12, v5

    invoke-virtual {v11, v13}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 285
    .end local v6    # "widgetX":Ljava/lang/String;
    .end local v7    # "widgetY":Ljava/lang/String;
    .end local v8    # "resIDX":I
    .end local v9    # "resIDY":I
    .end local v10    # "barX":Landroid/widget/SeekBar;
    .end local v11    # "barY":Landroid/widget/SeekBar;
    .end local v12    # "pos":[I
    :cond_8
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 317
    .end local v1    # "i":I
    :cond_9
    iput-boolean v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->bChangeAllowed:Z

    .line 318
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 52
    const/4 v0, 0x0

    invoke-super {p0, v0}, Landroidx/fragment/app/Fragment;->onCreate(Landroid/os/Bundle;)V

    .line 53
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 74
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 76
    const v0, 0x7f0c0036

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    .line 78
    const v1, 0x7f090214

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchKeyboard:Landroidx/appcompat/widget/SwitchCompat;

    .line 79
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f090215

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchCutout:Landroidx/appcompat/widget/SwitchCompat;

    .line 80
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f090217

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchFPSCounter:Landroidx/appcompat/widget/SwitchCompat;

    .line 81
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f090219

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchHpArmour:Landroidx/appcompat/widget/SwitchCompat;

    .line 82
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f09021a

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchOutfit:Landroidx/appcompat/widget/SwitchCompat;

    .line 83
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f09021c

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchRadarrect:Landroidx/appcompat/widget/SwitchCompat;

    .line 84
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f09021b

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchPCMoney:Landroidx/appcompat/widget/SwitchCompat;

    .line 85
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f09021d

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchSkyBox:Landroidx/appcompat/widget/SwitchCompat;

    .line 86
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f090216

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchDialog:Landroidx/appcompat/widget/SwitchCompat;

    .line 87
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    const v1, 0x7f090218

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/appcompat/widget/SwitchCompat;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchHud:Landroidx/appcompat/widget/SwitchCompat;

    .line 89
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->getValues()V

    .line 90
    invoke-direct {p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->setSeekBarListeners()V

    .line 92
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchCutout:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$1;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 103
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchSkyBox:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$2;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$2;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 110
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchDialog:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$3;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$3;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 117
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchHud:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$4;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$4;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 124
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchKeyboard:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$5;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$5;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 131
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchRadarrect:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$6;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$6;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 138
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchPCMoney:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$7;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$7;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 145
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchOutfit:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$8;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$8;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 152
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchHpArmour:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$9;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$9;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 159
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mSwitchFPSCounter:Landroidx/appcompat/widget/SwitchCompat;

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$10;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment$10;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/SwitchCompat;->setOnCheckedChangeListener(Landroid/widget/CompoundButton$OnCheckedChangeListener;)V

    .line 166
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    return-object v0
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "outState"    # Landroid/os/Bundle;

    .line 62
    const-string v0, "android:support:fragments"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    .line 63
    invoke-super {p0, p1}, Landroidx/fragment/app/Fragment;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 64
    invoke-virtual {p1, v0, v1}, Landroid/os/Bundle;->putSerializable(Ljava/lang/String;Ljava/io/Serializable;)V

    .line 65
    return-void
.end method

.method public onViewStateRestored(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 57
    const/4 v0, 0x0

    invoke-super {p0, v0}, Landroidx/fragment/app/Fragment;->onViewStateRestored(Landroid/os/Bundle;)V

    .line 58
    return-void
.end method

.method public passValuesToNative()V
    .locals 12

    .line 320
    const/16 v0, 0xe

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xf

    const-string v2, "id"

    if-ge v0, v1, :cond_2

    .line 321
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hud_element_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 322
    .local v1, "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 324
    .local v3, "widgetY":Ljava/lang/String;
    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v4}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 325
    .local v4, "resIDX":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 327
    .local v2, "resIDY":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v5, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/SeekBar;

    .line 328
    .local v5, "barX":Landroid/widget/SeekBar;
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/SeekBar;

    .line 329
    .local v6, "barY":Landroid/widget/SeekBar;
    const/4 v7, -0x1

    .line 330
    .local v7, "x":I
    const/4 v8, -0x1

    .line 331
    .local v8, "y":I
    if-eqz v5, :cond_0

    .line 332
    invoke-virtual {v5}, Landroid/widget/SeekBar;->getProgress()I

    move-result v7

    .line 334
    :cond_0
    if-eqz v6, :cond_1

    .line 335
    invoke-virtual {v6}, Landroid/widget/SeekBar;->getProgress()I

    move-result v8

    .line 338
    :cond_1
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9, v0, v7, v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementPosition(III)V

    .line 320
    .end local v1    # "widgetX":Ljava/lang/String;
    .end local v2    # "resIDY":I
    .end local v3    # "widgetY":Ljava/lang/String;
    .end local v4    # "resIDX":I
    .end local v5    # "barX":Landroid/widget/SeekBar;
    .end local v6    # "barY":Landroid/widget/SeekBar;
    .end local v7    # "x":I
    .end local v8    # "y":I
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 341
    .end local v0    # "i":I
    :cond_2
    const/16 v0, 0xe

    .restart local v0    # "i":I
    :goto_1
    if-ge v0, v1, :cond_5

    .line 342
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_scale_x_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 343
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hud_element_scale_y_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 345
    .local v4, "widgetY":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 346
    .local v5, "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 348
    .local v6, "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v7, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/SeekBar;

    .line 349
    .local v7, "barX":Landroid/widget/SeekBar;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 350
    .local v8, "barY":Landroid/widget/SeekBar;
    const/4 v9, -0x1

    .line 351
    .local v9, "x":I
    const/4 v10, -0x1

    .line 352
    .local v10, "y":I
    if-eqz v7, :cond_3

    .line 353
    invoke-virtual {v7}, Landroid/widget/SeekBar;->getProgress()I

    move-result v9

    .line 355
    :cond_3
    if-eqz v8, :cond_4

    .line 356
    invoke-virtual {v8}, Landroid/widget/SeekBar;->getProgress()I

    move-result v10

    .line 359
    :cond_4
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsCommonFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11, v0, v9, v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementScale(III)V

    .line 341
    .end local v3    # "widgetX":Ljava/lang/String;
    .end local v4    # "widgetY":Ljava/lang/String;
    .end local v5    # "resIDX":I
    .end local v6    # "resIDY":I
    .end local v7    # "barX":Landroid/widget/SeekBar;
    .end local v8    # "barY":Landroid/widget/SeekBar;
    .end local v9    # "x":I
    .end local v10    # "y":I
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 361
    .end local v0    # "i":I
    :cond_5
    return-void
.end method

.method public save()V
    .locals 0

    .line 237
    return-void
.end method
