.class public Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;
.super Landroidx/fragment/app/Fragment;
.source "DialogClientSettingsHUDFragment.java"

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

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 22
    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    .line 24
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->bChangeAllowed:Z

    .line 28
    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mParentView:Landroid/view/ViewGroup;

    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Z
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    .line 19
    iget-boolean v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->bChangeAllowed:Z

    return v0
.end method

.method static synthetic access$100(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Landroid/view/ViewGroup;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    .line 19
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mParentView:Landroid/view/ViewGroup;

    return-object v0
.end method

.method static synthetic access$200(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;
    .param p1, "x1"    # Landroid/view/ViewGroup;
    .param p2, "x2"    # Landroid/view/View;
    .param p3, "x3"    # Z

    .line 19
    invoke-direct {p0, p1, p2, p3}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic access$300(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;
    .param p1, "x1"    # Landroid/view/ViewGroup;
    .param p2, "x2"    # Landroid/view/View;
    .param p3, "x3"    # Z

    .line 19
    invoke-direct {p0, p1, p2, p3}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    return-void
.end method

.method static synthetic access$400(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    .line 19
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-object v0
.end method

.method public static createInstance(Ljava/lang/String;)Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;
    .locals 1
    .param p0, "txt"    # Ljava/lang/String;

    .line 32
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;

    invoke-direct {v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;-><init>()V

    .line 33
    .local v0, "fragment":Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;
    return-object v0
.end method

.method private makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 6
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "notVisible"    # Landroid/view/View;
    .param p3, "first"    # Z

    .line 57
    const/4 v0, 0x0

    if-eqz p3, :cond_0

    .line 59
    new-instance v1, Ljava/util/HashMap;

    invoke-direct {v1}, Ljava/util/HashMap;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mOldDrawables:Ljava/util/HashMap;

    .line 60
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v2

    invoke-virtual {v1, p1, v2}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 61
    new-instance v1, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v1, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 64
    :cond_0
    if-nez p1, :cond_1

    .line 65
    return-void

    .line 69
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_4

    .line 71
    invoke-virtual {p1, v1}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v2

    .line 73
    .local v2, "view":Landroid/view/View;
    instance-of v3, v2, Landroid/view/ViewGroup;

    if-eqz v3, :cond_2

    .line 75
    move-object v3, v2

    check-cast v3, Landroid/view/ViewGroup;

    invoke-direct {p0, v3, p2, v0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->makeAllElementsInvisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    .line 76
    iget-object v3, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mOldDrawables:Ljava/util/HashMap;

    move-object v4, v2

    check-cast v4, Landroid/view/ViewGroup;

    move-object v5, v2

    check-cast v5, Landroid/view/ViewGroup;

    invoke-virtual {v5}, Landroid/view/ViewGroup;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    invoke-virtual {v3, v4, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 77
    new-instance v3, Landroid/graphics/drawable/ColorDrawable;

    invoke-direct {v3, v0}, Landroid/graphics/drawable/ColorDrawable;-><init>(I)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    goto :goto_1

    .line 81
    :cond_2
    if-eq v2, p2, :cond_3

    .line 83
    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/view/View;->setAlpha(F)V

    .line 69
    .end local v2    # "view":Landroid/view/View;
    :cond_3
    :goto_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 87
    .end local v1    # "i":I
    :cond_4
    return-void
.end method

.method private makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V
    .locals 4
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "notVisible"    # Landroid/view/View;
    .param p3, "first"    # Z

    .line 91
    if-eqz p3, :cond_0

    .line 93
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mOldDrawables:Ljava/util/HashMap;

    invoke-virtual {v0}, Ljava/util/HashMap;->keySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 94
    .local v0, "myVeryOwnIterator":Ljava/util/Iterator;
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 96
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    .line 97
    .local v1, "key":Landroid/view/ViewGroup;
    iget-object v2, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mOldDrawables:Ljava/util/HashMap;

    invoke-virtual {v2, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/graphics/drawable/Drawable;

    .line 99
    .local v2, "value":Landroid/graphics/drawable/Drawable;
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 100
    .end local v1    # "key":Landroid/view/ViewGroup;
    .end local v2    # "value":Landroid/graphics/drawable/Drawable;
    goto :goto_0

    .line 103
    .end local v0    # "myVeryOwnIterator":Ljava/util/Iterator;
    :cond_0
    if-nez p1, :cond_1

    .line 105
    return-void

    .line 107
    :cond_1
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_1
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_4

    .line 109
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 111
    .local v1, "view":Landroid/view/View;
    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_2

    .line 113
    move-object v2, v1

    check-cast v2, Landroid/view/ViewGroup;

    const/4 v3, 0x0

    invoke-direct {p0, v2, p2, v3}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->makeAllElementsVisible(Landroid/view/ViewGroup;Landroid/view/View;Z)V

    goto :goto_2

    .line 117
    :cond_2
    if-eq v1, p2, :cond_3

    .line 119
    const/high16 v2, 0x3f800000    # 1.0f

    invoke-virtual {v1, v2}, Landroid/view/View;->setAlpha(F)V

    .line 107
    .end local v1    # "view":Landroid/view/View;
    :cond_3
    :goto_2
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 123
    .end local v0    # "i":I
    :cond_4
    return-void
.end method

.method private setSeekBarListeners()V
    .locals 12

    .line 127
    new-instance v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;

    invoke-direct {v0, p0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;)V

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    .line 149
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xa

    const-string v2, "id"

    if-ge v0, v1, :cond_2

    .line 151
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hud_element_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 152
    .local v1, "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 154
    .local v3, "widgetY":Ljava/lang/String;
    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v4}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 155
    .local v4, "resIDX":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 157
    .local v2, "resIDY":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v5, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/SeekBar;

    .line 158
    .local v5, "barX":Landroid/widget/SeekBar;
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/SeekBar;

    .line 160
    .local v6, "barY":Landroid/widget/SeekBar;
    if-eqz v5, :cond_0

    .line 162
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v5, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 164
    :cond_0
    if-eqz v6, :cond_1

    .line 166
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v6, v7}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 149
    .end local v1    # "widgetX":Ljava/lang/String;
    .end local v2    # "resIDY":I
    .end local v3    # "widgetY":Ljava/lang/String;
    .end local v4    # "resIDX":I
    .end local v5    # "barX":Landroid/widget/SeekBar;
    .end local v6    # "barY":Landroid/widget/SeekBar;
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 170
    .end local v0    # "i":I
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_1
    if-ge v0, v1, :cond_5

    .line 172
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_scale_x_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 173
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hud_element_scale_y_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 175
    .local v4, "widgetY":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 176
    .local v5, "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 178
    .local v6, "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v7, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/SeekBar;

    .line 179
    .local v7, "barX":Landroid/widget/SeekBar;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 181
    .local v8, "barY":Landroid/widget/SeekBar;
    if-eqz v7, :cond_3

    .line 183
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v7, v9}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 185
    :cond_3
    if-eqz v8, :cond_4

    .line 187
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v8, v9}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 170
    .end local v3    # "widgetX":Ljava/lang/String;
    .end local v4    # "widgetY":Ljava/lang/String;
    .end local v5    # "resIDX":I
    .end local v6    # "resIDY":I
    .end local v7    # "barX":Landroid/widget/SeekBar;
    .end local v8    # "barY":Landroid/widget/SeekBar;
    :cond_4
    add-int/lit8 v0, v0, 0x1

    goto :goto_1

    .line 191
    .end local v0    # "i":I
    :cond_5
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    const/4 v1, 0x3

    if-ge v0, v1, :cond_9

    .line 193
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "custom_widget_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 194
    .restart local v1    # "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "custom_widget_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 195
    .local v3, "widgetY":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "custom_widget_size_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 197
    .local v4, "widgetScale":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v1, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 198
    .restart local v5    # "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v3, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 199
    .restart local v6    # "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v4, v2, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    .line 201
    .local v7, "resIDScale":I
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 202
    .local v8, "barX":Landroid/widget/SeekBar;
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v9, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/SeekBar;

    .line 203
    .local v9, "barY":Landroid/widget/SeekBar;
    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v10, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/SeekBar;

    .line 205
    .local v10, "barScale":Landroid/widget/SeekBar;
    if-eqz v8, :cond_6

    .line 207
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v8, v11}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 209
    :cond_6
    if-eqz v9, :cond_7

    .line 211
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v9, v11}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 213
    :cond_7
    if-eqz v10, :cond_8

    .line 215
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mListenerSeekBars:Landroid/widget/SeekBar$OnSeekBarChangeListener;

    invoke-virtual {v10, v11}, Landroid/widget/SeekBar;->setOnSeekBarChangeListener(Landroid/widget/SeekBar$OnSeekBarChangeListener;)V

    .line 191
    .end local v1    # "widgetX":Ljava/lang/String;
    .end local v3    # "widgetY":Ljava/lang/String;
    .end local v4    # "widgetScale":Ljava/lang/String;
    .end local v5    # "resIDX":I
    .end local v6    # "resIDY":I
    .end local v7    # "resIDScale":I
    .end local v8    # "barX":Landroid/widget/SeekBar;
    .end local v9    # "barY":Landroid/widget/SeekBar;
    .end local v10    # "barScale":Landroid/widget/SeekBar;
    :cond_8
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_2

    .line 218
    .end local v0    # "i":I
    :cond_9
    return-void
.end method


# virtual methods
.method public getValues()V
    .locals 18

    .line 227
    move-object/from16 v0, p0

    const/4 v1, 0x0

    iput-boolean v1, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->bChangeAllowed:Z

    .line 228
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    const/16 v3, 0xa

    const-string v4, "id"

    const/4 v5, -0x1

    const/4 v6, 0x1

    if-ge v2, v3, :cond_4

    .line 230
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "hud_element_pos_x_"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 231
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "hud_element_pos_y_"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 233
    .local v7, "widgetY":Ljava/lang/String;
    iget-object v8, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    iget-object v9, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v3, v4, v9}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 234
    .local v8, "resIDX":I
    iget-object v9, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    iget-object v10, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v7, v4, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 236
    .local v4, "resIDY":I
    iget-object v9, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v9, v8}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/SeekBar;

    .line 237
    .local v9, "barX":Landroid/widget/SeekBar;
    iget-object v10, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v10, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/SeekBar;

    .line 239
    .local v10, "barY":Landroid/widget/SeekBar;
    iget-object v11, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementPosition(I)[I

    move-result-object v11

    .line 241
    .local v11, "pos":[I
    aget v12, v11, v1

    if-ne v12, v5, :cond_0

    .line 243
    aput v6, v11, v1

    .line 245
    :cond_0
    aget v12, v11, v6

    if-ne v12, v5, :cond_1

    .line 247
    aput v6, v11, v6

    .line 250
    :cond_1
    if-eqz v9, :cond_2

    .line 252
    aget v5, v11, v1

    invoke-virtual {v9, v5}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 254
    :cond_2
    if-eqz v10, :cond_3

    .line 256
    aget v5, v11, v6

    invoke-virtual {v10, v5}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 228
    .end local v3    # "widgetX":Ljava/lang/String;
    .end local v4    # "resIDY":I
    .end local v7    # "widgetY":Ljava/lang/String;
    .end local v8    # "resIDX":I
    .end local v9    # "barX":Landroid/widget/SeekBar;
    .end local v10    # "barY":Landroid/widget/SeekBar;
    .end local v11    # "pos":[I
    :cond_3
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 260
    .end local v2    # "i":I
    :cond_4
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_1
    if-ge v2, v3, :cond_9

    .line 262
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "hud_element_scale_x_"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 263
    .local v7, "widgetX":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "hud_element_scale_y_"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 265
    .local v8, "widgetY":Ljava/lang/String;
    iget-object v9, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    iget-object v10, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v7, v4, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v9

    .line 266
    .local v9, "resIDX":I
    iget-object v10, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v10

    iget-object v11, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v8, v4, v11}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v10

    .line 268
    .local v10, "resIDY":I
    iget-object v11, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v11, v9}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/SeekBar;

    .line 269
    .local v11, "barX":Landroid/widget/SeekBar;
    iget-object v12, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v12, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    check-cast v12, Landroid/widget/SeekBar;

    .line 271
    .local v12, "barY":Landroid/widget/SeekBar;
    iget-object v13, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v13, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementScale(I)[I

    move-result-object v13

    .line 273
    .local v13, "pos":[I
    aget v14, v13, v1

    if-ne v14, v5, :cond_5

    .line 275
    aput v6, v13, v1

    .line 277
    :cond_5
    aget v14, v13, v6

    if-ne v14, v5, :cond_6

    .line 279
    aput v6, v13, v6

    .line 282
    :cond_6
    if-eqz v11, :cond_7

    aget v14, v13, v1

    if-eq v14, v5, :cond_7

    .line 284
    aget v14, v13, v1

    invoke-virtual {v11, v14}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 286
    :cond_7
    if-eqz v12, :cond_8

    aget v14, v13, v6

    if-eq v14, v5, :cond_8

    .line 288
    aget v14, v13, v6

    invoke-virtual {v12, v14}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 260
    .end local v7    # "widgetX":Ljava/lang/String;
    .end local v8    # "widgetY":Ljava/lang/String;
    .end local v9    # "resIDX":I
    .end local v10    # "resIDY":I
    .end local v11    # "barX":Landroid/widget/SeekBar;
    .end local v12    # "barY":Landroid/widget/SeekBar;
    .end local v13    # "pos":[I
    :cond_8
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 292
    .end local v2    # "i":I
    :cond_9
    const/4 v2, 0x0

    .restart local v2    # "i":I
    :goto_2
    const/4 v3, 0x3

    if-ge v2, v3, :cond_c

    .line 294
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "custom_widget_pos_x_"

    invoke-virtual {v3, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 295
    .restart local v3    # "widgetX":Ljava/lang/String;
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "custom_widget_pos_y_"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    .line 296
    .local v7, "widgetY":Ljava/lang/String;
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "custom_widget_size_"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v8, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 298
    .local v8, "widgetScale":Ljava/lang/String;
    iget-object v9, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v9

    iget-object v10, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v9, v3, v4, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v9

    .line 299
    .restart local v9    # "resIDX":I
    iget-object v10, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v10

    iget-object v11, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v7, v4, v11}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v10

    .line 300
    .restart local v10    # "resIDY":I
    iget-object v11, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v11

    iget-object v12, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v12}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v8, v4, v12}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v11

    .line 302
    .local v11, "resIDScale":I
    iget-object v12, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v12, v9}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v12

    check-cast v12, Landroid/widget/SeekBar;

    .line 303
    .local v12, "barX":Landroid/widget/SeekBar;
    iget-object v13, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v13, v10}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v13

    check-cast v13, Landroid/widget/SeekBar;

    .line 304
    .local v13, "barY":Landroid/widget/SeekBar;
    iget-object v14, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v14, v11}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v14

    check-cast v14, Landroid/widget/SeekBar;

    .line 306
    .local v14, "barScale":Landroid/widget/SeekBar;
    iget-object v15, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v15, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeWidgetPositionAndScale(I)[I

    move-result-object v15

    .line 307
    .local v15, "pos":[I
    iget-object v5, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    move-object/from16 v16, v3

    .end local v3    # "widgetX":Ljava/lang/String;
    .local v16, "widgetX":Ljava/lang/String;
    aget v3, v15, v1

    aget v1, v15, v6

    const/16 v17, 0x2

    aget v6, v15, v17

    invoke-virtual {v5, v2, v3, v1, v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeWidgetPositionAndScale(IIII)V

    .line 309
    const/4 v1, 0x0

    aget v3, v15, v1

    const/4 v5, -0x1

    if-eq v3, v5, :cond_b

    const/4 v3, 0x1

    aget v6, v15, v3

    if-eq v6, v5, :cond_b

    aget v6, v15, v17

    if-ne v6, v5, :cond_a

    .line 311
    goto :goto_3

    .line 313
    :cond_a
    aget v6, v15, v1

    invoke-virtual {v12, v6}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 314
    aget v6, v15, v3

    invoke-virtual {v13, v6}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 315
    aget v3, v15, v17

    invoke-virtual {v14, v3}, Landroid/widget/SeekBar;->setProgress(I)V

    .line 292
    .end local v7    # "widgetY":Ljava/lang/String;
    .end local v8    # "widgetScale":Ljava/lang/String;
    .end local v9    # "resIDX":I
    .end local v10    # "resIDY":I
    .end local v11    # "resIDScale":I
    .end local v12    # "barX":Landroid/widget/SeekBar;
    .end local v13    # "barY":Landroid/widget/SeekBar;
    .end local v14    # "barScale":Landroid/widget/SeekBar;
    .end local v15    # "pos":[I
    .end local v16    # "widgetX":Ljava/lang/String;
    :cond_b
    :goto_3
    add-int/lit8 v2, v2, 0x1

    const/4 v6, 0x1

    goto/16 :goto_2

    .line 318
    .end local v2    # "i":I
    :cond_c
    const/4 v1, 0x1

    iput-boolean v1, v0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->bChangeAllowed:Z

    .line 319
    return-void
.end method

.method public onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
    .locals 2
    .param p1, "inflater"    # Landroid/view/LayoutInflater;
    .param p2, "container"    # Landroid/view/ViewGroup;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .line 45
    const v0, 0x7f0c0038

    const/4 v1, 0x0

    invoke-virtual {p1, v0, p2, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    .line 47
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    check-cast v0, Lcom/nvidia/devtech/NvEventQueueActivity;

    iput-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 49
    invoke-virtual {p0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->getValues()V

    .line 50
    invoke-direct {p0}, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->setSeekBarListeners()V

    .line 52
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    return-object v0
.end method

.method public passValuesToNative()V
    .locals 15

    .line 323
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    const/16 v1, 0xa

    const-string v2, "id"

    if-ge v0, v1, :cond_2

    .line 325
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "hud_element_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 326
    .local v1, "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 328
    .local v3, "widgetY":Ljava/lang/String;
    iget-object v4, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v4}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v4

    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v1, v2, v5}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v4

    .line 329
    .local v4, "resIDX":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 331
    .local v2, "resIDY":I
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v5, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v5

    check-cast v5, Landroid/widget/SeekBar;

    .line 332
    .local v5, "barX":Landroid/widget/SeekBar;
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v6, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v6

    check-cast v6, Landroid/widget/SeekBar;

    .line 333
    .local v6, "barY":Landroid/widget/SeekBar;
    const/4 v7, -0x1

    .line 334
    .local v7, "x":I
    const/4 v8, -0x1

    .line 335
    .local v8, "y":I
    if-eqz v5, :cond_0

    .line 337
    invoke-virtual {v5}, Landroid/widget/SeekBar;->getProgress()I

    move-result v7

    .line 339
    :cond_0
    if-eqz v6, :cond_1

    .line 341
    invoke-virtual {v6}, Landroid/widget/SeekBar;->getProgress()I

    move-result v8

    .line 344
    :cond_1
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v9, v0, v7, v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementPosition(III)V

    .line 323
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

    .line 347
    .end local v0    # "i":I
    :cond_2
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_1
    if-ge v0, v1, :cond_5

    .line 349
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "hud_element_scale_x_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 350
    .local v3, "widgetX":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "hud_element_scale_y_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 352
    .local v4, "widgetY":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v3, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 353
    .local v5, "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v4, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 355
    .local v6, "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v7, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v7

    check-cast v7, Landroid/widget/SeekBar;

    .line 356
    .local v7, "barX":Landroid/widget/SeekBar;
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 357
    .local v8, "barY":Landroid/widget/SeekBar;
    const/4 v9, -0x1

    .line 358
    .local v9, "x":I
    const/4 v10, -0x1

    .line 359
    .local v10, "y":I
    if-eqz v7, :cond_3

    .line 361
    invoke-virtual {v7}, Landroid/widget/SeekBar;->getProgress()I

    move-result v9

    .line 363
    :cond_3
    if-eqz v8, :cond_4

    .line 365
    invoke-virtual {v8}, Landroid/widget/SeekBar;->getProgress()I

    move-result v10

    .line 368
    :cond_4
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v11, v0, v9, v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeHudElementScale(III)V

    .line 347
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

    .line 371
    .end local v0    # "i":I
    :cond_5
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_2
    const/4 v1, 0x3

    if-ge v0, v1, :cond_6

    .line 373
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "custom_widget_pos_x_"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 374
    .restart local v1    # "widgetX":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "custom_widget_pos_y_"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 375
    .local v3, "widgetY":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "custom_widget_size_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 377
    .local v4, "widgetScale":Ljava/lang/String;
    iget-object v5, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v5}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v1, v2, v6}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 378
    .restart local v5    # "resIDX":I
    iget-object v6, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v3, v2, v7}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 379
    .restart local v6    # "resIDY":I
    iget-object v7, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v7

    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->getPackageName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v4, v2, v8}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    .line 381
    .local v7, "resIDScale":I
    iget-object v8, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v8, v5}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v8

    check-cast v8, Landroid/widget/SeekBar;

    .line 382
    .local v8, "barX":Landroid/widget/SeekBar;
    iget-object v9, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v9, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v9

    check-cast v9, Landroid/widget/SeekBar;

    .line 383
    .local v9, "barY":Landroid/widget/SeekBar;
    iget-object v10, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mRootView:Landroid/view/View;

    invoke-virtual {v10, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v10

    check-cast v10, Landroid/widget/SeekBar;

    .line 385
    .local v10, "barScale":Landroid/widget/SeekBar;
    iget-object v11, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mContext:Lcom/nvidia/devtech/NvEventQueueActivity;

    invoke-virtual {v8}, Landroid/widget/SeekBar;->getProgress()I

    move-result v12

    invoke-virtual {v9}, Landroid/widget/SeekBar;->getProgress()I

    move-result v13

    invoke-virtual {v10}, Landroid/widget/SeekBar;->getProgress()I

    move-result v14

    invoke-virtual {v11, v0, v12, v13, v14}, Lcom/nvidia/devtech/NvEventQueueActivity;->setNativeWidgetPositionAndScale(IIII)V

    .line 371
    .end local v1    # "widgetX":Ljava/lang/String;
    .end local v3    # "widgetY":Ljava/lang/String;
    .end local v4    # "widgetScale":Ljava/lang/String;
    .end local v5    # "resIDX":I
    .end local v6    # "resIDY":I
    .end local v7    # "resIDScale":I
    .end local v8    # "barX":Landroid/widget/SeekBar;
    .end local v9    # "barY":Landroid/widget/SeekBar;
    .end local v10    # "barScale":Landroid/widget/SeekBar;
    add-int/lit8 v0, v0, 0x1

    goto/16 :goto_2

    .line 387
    .end local v0    # "i":I
    :cond_6
    return-void
.end method

.method public save()V
    .locals 0

    .line 223
    return-void
.end method

.method public setRoot(Landroid/view/ViewGroup;)Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;
    .locals 0
    .param p1, "root"    # Landroid/view/ViewGroup;

    .line 37
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsHUDFragment;->mParentView:Landroid/view/ViewGroup;

    .line 38
    return-object p0
.end method
