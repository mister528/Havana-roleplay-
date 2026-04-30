.class public Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;
.super Landroidx/fragment/app/Fragment;
.source "DialogClientSettingsWeaponsFragment.java"

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


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 19
    invoke-direct {p0}, Landroidx/fragment/app/Fragment;-><init>()V

    .line 21
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 22
    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    .line 24
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->bChangeAllowed:Z

    .line 29
    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mParentView:Landroid/view/ViewGroup;

    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;

    .line 19
    iget-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->bChangeAllowed:Z

    return v0
.end method

.method static synthetic access$100(Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;)Landroid/view/ViewGroup;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;

    .line 19
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mParentView:Landroid/view/ViewGroup;

    return-object v0
.end method

.method static synthetic access$200(Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;
    .param p1, "x1"    # Landroid/view/ViewGroup;
    .param p2, "x2"    # Landroid/view/View;
    .param p3, "x3"    # Z

    .line 19
    invoke-direct {p0, p1, p2, p3}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic access$300(Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;
    .param p1, "x1"    # Landroid/view/ViewGroup;
    .param p2, "x2"    # Landroid/view/View;
    .param p3, "x3"    # Z

    .line 19
    invoke-direct {p0, p1, p2, p3}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic access$400(Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;

    .line 19
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-object v0
.end method

.method public static createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;
    .locals 1
    .param p0, "txt"    # Ljava/lang/String;

    .line 33
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;

    invoke-direct {v0}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;-><init>()V

    .line 34
    .local v0, "fragment":Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;
    return-object v0
.end method

.method private makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 6
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "notVisible"    # Landroid/view/View;
    .param p3, "first"    # Z

    .line 60
    const/4 v0, 0x0

    if-eqz p3, :cond_0

    .line 62
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mOldDrawables:Ljava/util/HashMap;

    .line 63
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 64
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v1, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 67
    :cond_0
    if-nez p1, :cond_1

    .line 68
    return-void

    .line 72
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_4

    .line 74
    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 76
    .local v2, "view":Landroid/view/View;
    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :cond_2

    .line 78
    move-object v3, v2

    check-cast v3, Landroid/view/ViewGroup;

    invoke-direct {p0, v3, p2, v0}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 79
    iget-object v3, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mOldDrawables:Ljava/util/HashMap;

    move-object v4, v2

    check-cast v4, Landroid/view/ViewGroup;

    move-object v5, v2

    check-cast v5, Landroid/view/ViewGroup;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 80
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    .line 84
    :cond_2
    if-eq v2, p2, :cond_3

    .line 86
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setAlpha(F)V

    .line 72
    .end local v2    # "view":Landroid/view/View;
    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 90
    .end local v1    # "i":I
    :cond_4
    return-void
.end method

.method private makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 4
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "notVisible"    # Landroid/view/View;
    .param p3, "first"    # Z

    .line 94
    if-eqz p3, :cond_0

    .line 96
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mOldDrawables:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 97
    .local v0, "myVeryOwnIterator":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 99
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .line 100
    .local v1, "key":Landroid/view/ViewGroup;
    iget-object v2, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mOldDrawables:Ljava/util/HashMap;

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/graphics/drawable/Drawable;

    .line 102
    .local v2, "value":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 103
    .end local v1    # "key":Landroid/view/ViewGroup;
    .end local v2    # "value":Landroid/graphics/drawable/Drawable;
    goto :goto_0

    .line 106
    .end local v0    # "myVeryOwnIterator":Ljava/util/Iterator;
    :cond_0
    if-nez p1, :cond_1

    .line 108
    return-void

    .line 110
    :cond_1
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_4

    .line 112
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 114
    .local v1, "view":Landroid/view/View;
    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_2

    .line 116
    move-object v2, v1

    check-cast v2, Landroid/view/ViewGroup;

    const/4 v3, 0x0

    invoke-direct {p0, v2, p2, v3}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    goto :goto_2

    .line 120
    :cond_2
    if-eq v1, p2, :cond_3

    .line 122
    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v1, v2}, Landroid/view/View;->setAlpha(F)V

    .line 110
    .end local v1    # "view":Landroid/view/View;
    :cond_3
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 126
    .end local v0    # "i":I
    :cond_4
    return-void
.end method

.method private setSeekBarListeners()V
    .locals 10

    .line 130
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment$1;

    invoke-direct {v0, p0}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;)V

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    .line 152
    const/16 v0, 0xc

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xe

    const-string v2, "id"

    if-ge v0, v1, :cond_2

    .line 154
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hud_element_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 155
    .local v1, "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 157
    .local v3, "widgetY":Ljava/lang/String;
    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v4}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 158
    .local v4, "resIDX":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 160
    .local v2, "resIDY":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v5, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/SeekBar;

    .line 161
    .local v5, "barX":Landroid/widget/SeekBar;
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/SeekBar;

    .line 163
    .local v6, "barY":Landroid/widget/SeekBar;
    if-eqz v5, :cond_0

    .line 165
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v5, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 167
    :cond_0
    if-eqz v6, :cond_1

    .line 169
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v6, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 152
    .end local v1    # "widgetX":Ljava/lang/String;
    .end local v2    # "resIDY":I
    .end local v3    # "widgetY":Ljava/lang/String;
    .end local v4    # "resIDX":I
    .end local v5    # "barX":Landroid/widget/SeekBar;
    .end local v6    # "barY":Landroid/widget/SeekBar;
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 173
    .end local v0    # "i":I
    :cond_2
    const/16 v0, 0xc

    .restart local v0    # "i":I
    :goto_1
    if-ge v0, v1, :cond_5

    .line 175
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_scale_x_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 176
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hud_element_scale_y_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 178
    .local v4, "widgetY":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 179
    .local v5, "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 181
    .local v6, "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v7, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/SeekBar;

    .line 182
    .local v7, "barX":Landroid/widget/SeekBar;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 184
    .local v8, "barY":Landroid/widget/SeekBar;
    if-eqz v7, :cond_3

    .line 186
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v7, v9}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 188
    :cond_3
    if-eqz v8, :cond_4

    .line 190
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v8, v9}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 173
    .end local v3    # "widgetX":Ljava/lang/String;
    .end local v4    # "widgetY":Ljava/lang/String;
    .end local v5    # "resIDX":I
    .end local v6    # "resIDY":I
    .end local v7    # "barX":Landroid/widget/SeekBar;
    .end local v8    # "barY":Landroid/widget/SeekBar;
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 193
    .end local v0    # "i":I
    :cond_5
    return-void
.end method


# virtual methods
.method public getValues()V
    .locals 14

    .line 202
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->bChangeAllowed:Z

    .line 203
    const/16 v1, 0xc

    .local v1, "i":I
    :goto_0
    const/16 v2, 0xe

    const-string v3, "id"

    const/4 v4, -0x1

    const/4 v5, 0x1

    if-ge v1, v2, :cond_4

    .line 205
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "hud_element_pos_x_"

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 206
    .local v2, "widgetX":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "hud_element_pos_y_"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 208
    .local v6, "widgetY":Ljava/lang/String;
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v2, v3, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    .line 209
    .local v7, "resIDX":I
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v6, v3, v9}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 211
    .local v3, "resIDY":I
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 212
    .local v8, "barX":Landroid/widget/SeekBar;
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v9, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/SeekBar;

    .line 214
    .local v9, "barY":Landroid/widget/SeekBar;
    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementPosition(I)[I

    move-result-object v10

    .line 216
    .local v10, "pos":[I
    aget v11, v10, v0

    if-ne v11, v4, :cond_0

    .line 218
    aput v5, v10, v0

    .line 220
    :cond_0
    aget v11, v10, v5

    if-ne v11, v4, :cond_1

    .line 222
    aput v5, v10, v5

    .line 225
    :cond_1
    if-eqz v8, :cond_2

    .line 227
    aget v4, v10, v0

    invoke-virtual {v8, v4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 229
    :cond_2
    if-eqz v9, :cond_3

    .line 231
    aget v4, v10, v5

    invoke-virtual {v9, v4}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 203
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

    .line 235
    .end local v1    # "i":I
    :cond_4
    const/16 v1, 0xc

    .restart local v1    # "i":I
    :goto_1
    if-ge v1, v2, :cond_9

    .line 237
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "hud_element_scale_x_"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    .line 238
    .local v6, "widgetX":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "hud_element_scale_y_"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 240
    .local v7, "widgetY":Ljava/lang/String;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v6, v3, v9}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 241
    .local v8, "resIDX":I
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v7, v3, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v9

    .line 243
    .local v9, "resIDY":I
    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v10, v8}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/SeekBar;

    .line 244
    .local v10, "barX":Landroid/widget/SeekBar;
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v11, v9}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/SeekBar;

    .line 246
    .local v11, "barY":Landroid/widget/SeekBar;
    iget-object v12, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v12, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementScale(I)[I

    move-result-object v12

    .line 248
    .local v12, "pos":[I
    aget v13, v12, v0

    if-ne v13, v4, :cond_5

    .line 250
    aput v5, v12, v0

    .line 252
    :cond_5
    aget v13, v12, v5

    if-ne v13, v4, :cond_6

    .line 254
    aput v5, v12, v5

    .line 257
    :cond_6
    if-eqz v10, :cond_7

    aget v13, v12, v0

    if-eq v13, v4, :cond_7

    .line 259
    aget v13, v12, v0

    invoke-virtual {v10, v13}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 261
    :cond_7
    if-eqz v11, :cond_8

    aget v13, v12, v5

    if-eq v13, v4, :cond_8

    .line 263
    aget v13, v12, v5

    invoke-virtual {v11, v13}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 235
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

    .line 267
    .end local v1    # "i":I
    :cond_9
    iput-boolean v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->bChangeAllowed:Z

    .line 268
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 48
    const v0, 0x7f0c003a

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    .line 50
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 52
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->getValues()V

    .line 53
    invoke-direct {p0}, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->setSeekBarListeners()V

    .line 55
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    return-object v0
.end method

.method public passValuesToNative()V
    .locals 12

    .line 272
    const/16 v0, 0xc

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xe

    const-string v2, "id"

    if-ge v0, v1, :cond_2

    .line 274
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hud_element_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 275
    .local v1, "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 277
    .local v3, "widgetY":Ljava/lang/String;
    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v4}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 278
    .local v4, "resIDX":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 280
    .local v2, "resIDY":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v5, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/SeekBar;

    .line 281
    .local v5, "barX":Landroid/widget/SeekBar;
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/SeekBar;

    .line 282
    .local v6, "barY":Landroid/widget/SeekBar;
    const/4 v7, -0x1

    .line 283
    .local v7, "x":I
    const/4 v8, -0x1

    .line 284
    .local v8, "y":I
    if-eqz v5, :cond_0

    .line 286
    invoke-virtual {v5}, Landroid/widget/SeekBar;->getProgress()I

    move-result v7

    .line 288
    :cond_0
    if-eqz v6, :cond_1

    .line 290
    invoke-virtual {v6}, Landroid/widget/SeekBar;->getProgress()I

    move-result v8

    .line 293
    :cond_1
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9, v0, v7, v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementPosition(III)V

    .line 272
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

    .line 296
    .end local v0    # "i":I
    :cond_2
    const/16 v0, 0xc

    .restart local v0    # "i":I
    :goto_1
    if-ge v0, v1, :cond_5

    .line 298
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_scale_x_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 299
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hud_element_scale_y_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 301
    .local v4, "widgetY":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 302
    .local v5, "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 304
    .local v6, "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v7, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/SeekBar;

    .line 305
    .local v7, "barX":Landroid/widget/SeekBar;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 306
    .local v8, "barY":Landroid/widget/SeekBar;
    const/4 v9, -0x1

    .line 307
    .local v9, "x":I
    const/4 v10, -0x1

    .line 308
    .local v10, "y":I
    if-eqz v7, :cond_3

    .line 310
    invoke-virtual {v7}, Landroid/widget/SeekBar;->getProgress()I

    move-result v9

    .line 312
    :cond_3
    if-eqz v8, :cond_4

    .line 314
    invoke-virtual {v8}, Landroid/widget/SeekBar;->getProgress()I

    move-result v10

    .line 317
    :cond_4
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11, v0, v9, v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementScale(III)V

    .line 296
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

    .line 319
    .end local v0    # "i":I
    :cond_5
    return-void
.end method

.method public save()V
    .locals 0

    .line 198
    return-void
.end method

.method public setRoot(Landroid/view/ViewGroup;)Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;
    .locals 0
    .param p1, "root"    # Landroid/view/ViewGroup;

    .line 39
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsWeaponsFragment;->mParentView:Landroid/view/ViewGroup;

    .line 40
    return-object p0
.end method
