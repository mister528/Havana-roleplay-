.class public Lcom/skydoves/colorpickerview/ColorPickerView;
.super Landroid/widget/FrameLayout;
.source "ColorPickerView.java"

# interfaces
.implements Landroidx/lifecycle/LifecycleObserver;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    }
.end annotation


# instance fields
.field private VISIBLE_FLAG:Z

.field private actionMode:Lcom/skydoves/colorpickerview/ActionMode;

.field private alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

.field private alpha_flag:F

.field private alpha_selector:F

.field private brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

.field public colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

.field private debounceDuration:J

.field private debounceHandler:Landroid/os/Handler;

.field private flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

.field private palette:Landroid/widget/ImageView;

.field private paletteDrawable:Landroid/graphics/drawable/Drawable;

.field private preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

.field private preferenceName:Ljava/lang/String;

.field private selectedColor:I

.field private selectedPoint:Landroid/graphics/Point;

.field private selectedPureColor:I

.field private selector:Landroid/widget/ImageView;

.field private selectorDrawable:Landroid/graphics/drawable/Drawable;

.field private selectorSize:I


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 104
    invoke-direct {p0, p1}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 84
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 85
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceHandler:Landroid/os/Handler;

    .line 87
    sget-object v0, Lcom/skydoves/colorpickerview/ActionMode;->ALWAYS:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 89
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 92
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 95
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 97
    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    .line 100
    nop

    .line 101
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 105
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 108
    invoke-direct {p0, p1, p2}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 84
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 85
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceHandler:Landroid/os/Handler;

    .line 87
    sget-object v0, Lcom/skydoves/colorpickerview/ActionMode;->ALWAYS:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 89
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 92
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 95
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 97
    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    .line 100
    nop

    .line 101
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 109
    invoke-direct {p0, p2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAttrs(Landroid/util/AttributeSet;)V

    .line 110
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->onCreate()V

    .line 111
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I

    .line 114
    invoke-direct {p0, p1, p2, p3}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 84
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 85
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceHandler:Landroid/os/Handler;

    .line 87
    sget-object v0, Lcom/skydoves/colorpickerview/ActionMode;->ALWAYS:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 89
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 92
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 95
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 97
    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    .line 100
    nop

    .line 101
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 115
    invoke-direct {p0, p2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAttrs(Landroid/util/AttributeSet;)V

    .line 116
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->onCreate()V

    .line 117
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyleAttr"    # I
    .param p4, "defStyleRes"    # I

    .line 121
    invoke-direct {p0, p1, p2, p3, p4}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;II)V

    .line 84
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 85
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceHandler:Landroid/os/Handler;

    .line 87
    sget-object v0, Lcom/skydoves/colorpickerview/ActionMode;->ALWAYS:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 89
    const/high16 v0, 0x3f800000    # 1.0f

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 92
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 95
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 97
    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    .line 100
    nop

    .line 101
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 122
    invoke-direct {p0, p2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAttrs(Landroid/util/AttributeSet;)V

    .line 123
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->onCreate()V

    .line 124
    return-void
.end method

.method static synthetic access$000(Lcom/skydoves/colorpickerview/ColorPickerView;)V
    .locals 0
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 71
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->onFinishInflated()V

    return-void
.end method

.method static synthetic access$1700(Lcom/skydoves/colorpickerview/ColorPickerView;)Landroid/graphics/Point;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 71
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    return-object v0
.end method

.method static synthetic access$1800(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)V
    .locals 0
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView;
    .param p1, "x1"    # Landroid/graphics/Point;

    .line 71
    invoke-direct {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyToFlagView(Landroid/graphics/Point;)V

    return-void
.end method

.method private getAttrs(Landroid/util/AttributeSet;)V
    .locals 5
    .param p1, "attrs"    # Landroid/util/AttributeSet;

    .line 127
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    sget-object v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView:[I

    invoke-virtual {v0, p1, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 129
    .local v0, "a":Landroid/content/res/TypedArray;
    :try_start_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_palette:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 130
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_palette:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->paletteDrawable:Landroid/graphics/drawable/Drawable;

    .line 132
    :cond_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_selector:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    const/4 v2, -0x1

    if-eqz v1, :cond_1

    .line 133
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_selector:I

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getResourceId(II)I

    move-result v1

    .line 134
    .local v1, "resourceId":I
    if-eq v1, v2, :cond_1

    .line 135
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v1}, Landroidx/appcompat/content/res/AppCompatResources;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    iput-object v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    .line 138
    .end local v1    # "resourceId":I
    :cond_1
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_alpha_selector:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 139
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_alpha_selector:I

    iget v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 140
    invoke-virtual {v0, v1, v3}, Landroid/content/res/TypedArray;->getFloat(IF)F

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 142
    :cond_2
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_selector_size:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 143
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_selector_size:I

    iget v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 144
    invoke-virtual {v0, v1, v3}, Landroid/content/res/TypedArray;->getDimensionPixelSize(II)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 146
    :cond_3
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_alpha_flag:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_4

    .line 147
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_alpha_flag:I

    iget v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    invoke-virtual {v0, v1, v3}, Landroid/content/res/TypedArray;->getFloat(IF)F

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 149
    :cond_4
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_actionMode:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 150
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_actionMode:I

    const/4 v3, 0x0

    invoke-virtual {v0, v1, v3}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v1

    .line 151
    .local v1, "actionMode":I
    if-nez v1, :cond_5

    .line 152
    sget-object v3, Lcom/skydoves/colorpickerview/ActionMode;->ALWAYS:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    goto :goto_0

    .line 153
    :cond_5
    const/4 v3, 0x1

    if-ne v1, v3, :cond_6

    sget-object v3, Lcom/skydoves/colorpickerview/ActionMode;->LAST:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 155
    .end local v1    # "actionMode":I
    :cond_6
    :goto_0
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_debounceDuration:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_7

    .line 156
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_debounceDuration:I

    iget-wide v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    long-to-int v4, v3

    .line 157
    invoke-virtual {v0, v1, v4}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v1

    int-to-long v3, v1

    iput-wide v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 159
    :cond_7
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_preferenceName:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 160
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_preferenceName:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceName:Ljava/lang/String;

    .line 162
    :cond_8
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_initialColor:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->hasValue(I)Z

    move-result v1

    if-eqz v1, :cond_9

    .line 163
    sget v1, Lcom/skydoves/colorpickerview/R$styleable;->ColorPickerView_initialColor:I

    invoke-virtual {v0, v1, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setInitialColor(I)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 166
    :cond_9
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 167
    nop

    .line 168
    return-void

    .line 166
    :catchall_0
    move-exception v1

    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    throw v1
.end method

.method private getCenterPoint(II)Landroid/graphics/Point;
    .locals 3
    .param p1, "x"    # I
    .param p2, "y"    # I

    .line 562
    new-instance v0, Landroid/graphics/Point;

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    sub-int v1, p1, v1

    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v2}, Landroid/widget/ImageView;->getMeasuredHeight()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    sub-int v2, p2, v2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    return-object v0
.end method

.method private notifyColorChanged()V
    .locals 4

    .line 317
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceHandler:Landroid/os/Handler;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/os/Handler;->removeCallbacksAndMessages(Ljava/lang/Object;)V

    .line 318
    new-instance v0, Lcom/skydoves/colorpickerview/ColorPickerView$2;

    invoke-direct {v0, p0}, Lcom/skydoves/colorpickerview/ColorPickerView$2;-><init>(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 326
    .local v0, "debounceRunnable":Ljava/lang/Runnable;
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceHandler:Landroid/os/Handler;

    iget-wide v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    invoke-virtual {v1, v0, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 327
    return-void
.end method

.method private notifyToFlagView(Landroid/graphics/Point;)V
    .locals 7
    .param p1, "point"    # Landroid/graphics/Point;

    .line 442
    iget v0, p1, Landroid/graphics/Point;->x:I

    iget v1, p1, Landroid/graphics/Point;->y:I

    invoke-direct {p0, v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getCenterPoint(II)Landroid/graphics/Point;

    move-result-object v0

    .line 443
    .local v0, "centerPoint":Landroid/graphics/Point;
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    if-eqz v1, :cond_4

    .line 444
    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/flag/FlagView;->getFlagMode()Lcom/skydoves/colorpickerview/flag/FlagMode;

    move-result-object v1

    sget-object v2, Lcom/skydoves/colorpickerview/flag/FlagMode;->ALWAYS:Lcom/skydoves/colorpickerview/flag/FlagMode;

    if-ne v1, v2, :cond_0

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/flag/FlagView;->visible()V

    .line 445
    :cond_0
    iget v1, v0, Landroid/graphics/Point;->x:I

    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v2}, Lcom/skydoves/colorpickerview/flag/FlagView;->getWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    sub-int/2addr v1, v2

    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v2}, Landroid/widget/ImageView;->getWidth()I

    move-result v2

    div-int/lit8 v2, v2, 0x2

    add-int/2addr v1, v2

    .line 446
    .local v1, "posX":I
    iget v2, v0, Landroid/graphics/Point;->y:I

    iget-object v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v3}, Lcom/skydoves/colorpickerview/flag/FlagView;->getHeight()I

    move-result v3

    sub-int/2addr v2, v3

    const/4 v3, 0x0

    if-lez v2, :cond_1

    .line 447
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v2, v3}, Lcom/skydoves/colorpickerview/flag/FlagView;->setRotation(F)V

    .line 448
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    int-to-float v4, v1

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->setX(F)V

    .line 449
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    iget v4, v0, Landroid/graphics/Point;->y:I

    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v5}, Lcom/skydoves/colorpickerview/flag/FlagView;->getHeight()I

    move-result v5

    sub-int/2addr v4, v5

    int-to-float v4, v4

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->setY(F)V

    .line 450
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorEnvelope()Lcom/skydoves/colorpickerview/ColorEnvelope;

    move-result-object v4

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->onRefresh(Lcom/skydoves/colorpickerview/ColorEnvelope;)V

    goto :goto_0

    .line 451
    :cond_1
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v2}, Lcom/skydoves/colorpickerview/flag/FlagView;->isFlipAble()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 452
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    const/high16 v4, 0x43340000    # 180.0f

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->setRotation(F)V

    .line 453
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    int-to-float v4, v1

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->setX(F)V

    .line 454
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    iget v4, v0, Landroid/graphics/Point;->y:I

    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v5}, Lcom/skydoves/colorpickerview/flag/FlagView;->getHeight()I

    move-result v5

    add-int/2addr v4, v5

    int-to-float v4, v4

    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v5}, Landroid/widget/ImageView;->getHeight()I

    move-result v5

    int-to-float v5, v5

    const/high16 v6, 0x3f000000    # 0.5f

    mul-float v5, v5, v6

    sub-float/2addr v4, v5

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->setY(F)V

    .line 455
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorEnvelope()Lcom/skydoves/colorpickerview/ColorEnvelope;

    move-result-object v4

    invoke-virtual {v2, v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->onRefresh(Lcom/skydoves/colorpickerview/ColorEnvelope;)V

    .line 457
    :cond_2
    :goto_0
    if-gez v1, :cond_3

    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v2, v3}, Lcom/skydoves/colorpickerview/flag/FlagView;->setX(F)V

    .line 458
    :cond_3
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v2}, Lcom/skydoves/colorpickerview/flag/FlagView;->getMeasuredWidth()I

    move-result v2

    add-int/2addr v2, v1

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredWidth()I

    move-result v3

    if-le v2, v3, :cond_4

    .line 459
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredWidth()I

    move-result v3

    iget-object v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v4}, Lcom/skydoves/colorpickerview/flag/FlagView;->getMeasuredWidth()I

    move-result v4

    sub-int/2addr v3, v4

    int-to-float v3, v3

    invoke-virtual {v2, v3}, Lcom/skydoves/colorpickerview/flag/FlagView;->setX(F)V

    .line 462
    .end local v1    # "posX":I
    :cond_4
    return-void
.end method

.method private notifyToSlideBars()V
    .locals 2

    .line 426
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->notifyColor()V

    .line 427
    :cond_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    if-eqz v0, :cond_2

    .line 428
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->notifyColor()V

    .line 430
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->assembleColor()I

    move-result v0

    const/4 v1, -0x1

    if-eq v0, v1, :cond_1

    .line 431
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->assembleColor()I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    goto :goto_0

    .line 432
    :cond_1
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->assembleColor()I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 434
    :cond_2
    :goto_0
    return-void
.end method

.method private onCreate()V
    .locals 5

    .line 171
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0, v0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->setPadding(IIII)V

    .line 172
    new-instance v0, Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    .line 173
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->paletteDrawable:Landroid/graphics/drawable/Drawable;

    if-eqz v1, :cond_0

    .line 174
    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 177
    :cond_0
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {v0, v1, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 179
    .local v0, "paletteParam":Landroid/widget/FrameLayout$LayoutParams;
    const/16 v1, 0x11

    iput v1, v0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    .line 180
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {p0, v2, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 182
    new-instance v2, Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    .line 183
    iget-object v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    if-eqz v3, :cond_1

    .line 184
    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    goto :goto_0

    .line 186
    :cond_1
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v3

    sget v4, Lcom/skydoves/colorpickerview/R$drawable;->wheel:I

    invoke-static {v3, v4}, Landroidx/core/content/ContextCompat;->getDrawable(Landroid/content/Context;I)Landroid/graphics/drawable/Drawable;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 188
    :goto_0
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v3, -0x2

    invoke-direct {v2, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 190
    .local v2, "selectorParam":Landroid/widget/FrameLayout$LayoutParams;
    iget v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    if-eqz v3, :cond_2

    .line 191
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v3

    iget v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    invoke-static {v3, v4}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v3

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->width:I

    .line 192
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v3

    iget v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    invoke-static {v3, v4}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v3

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->height:I

    .line 194
    :cond_2
    iput v1, v2, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    .line 195
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {p0, v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 196
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    iget v3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    invoke-virtual {v1, v3}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 198
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v1

    new-instance v3, Lcom/skydoves/colorpickerview/ColorPickerView$1;

    invoke-direct {v3, p0}, Lcom/skydoves/colorpickerview/ColorPickerView$1;-><init>(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 199
    invoke-virtual {v1, v3}, Landroid/view/ViewTreeObserver;->addOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    .line 211
    return-void
.end method

.method private onFinishInflated()V
    .locals 2

    .line 224
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    instance-of v0, v0, Landroid/view/ViewGroup;

    if-eqz v0, :cond_0

    .line 225
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->setClipChildren(Z)V

    .line 228
    :cond_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 229
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    invoke-virtual {v0, p0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->restoreColorPickerData(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    goto :goto_0

    .line 231
    :cond_1
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->selectCenter()V

    .line 233
    :goto_0
    return-void
.end method

.method private onTouchReceived(Landroid/view/MotionEvent;)Z
    .locals 5
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 289
    new-instance v0, Landroid/graphics/Point;

    .line 290
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    float-to-int v1, v1

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    float-to-int v2, v2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    invoke-static {p0, v0}, Lcom/skydoves/colorpickerview/PointMapper;->getColorPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v0

    .line 291
    .local v0, "snapPoint":Landroid/graphics/Point;
    iget v1, v0, Landroid/graphics/Point;->x:I

    int-to-float v1, v1

    iget v2, v0, Landroid/graphics/Point;->y:I

    int-to-float v2, v2

    invoke-virtual {p0, v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorFromBitmap(FF)I

    move-result v1

    .line 293
    .local v1, "pixelColor":I
    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    .line 294
    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 295
    new-instance v2, Landroid/graphics/Point;

    iget v3, v0, Landroid/graphics/Point;->x:I

    iget v4, v0, Landroid/graphics/Point;->y:I

    invoke-direct {v2, v3, v4}, Landroid/graphics/Point;-><init>(II)V

    invoke-static {p0, v2}, Lcom/skydoves/colorpickerview/PointMapper;->getColorPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v2

    iput-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    .line 296
    iget v2, v0, Landroid/graphics/Point;->x:I

    iget v3, v0, Landroid/graphics/Point;->y:I

    invoke-virtual {p0, v2, v3}, Lcom/skydoves/colorpickerview/ColorPickerView;->setCoordinate(II)V

    .line 298
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    sget-object v3, Lcom/skydoves/colorpickerview/ActionMode;->LAST:Lcom/skydoves/colorpickerview/ActionMode;

    const/4 v4, 0x1

    if-ne v2, v3, :cond_0

    .line 299
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v2

    if-ne v2, v4, :cond_1

    .line 300
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyColorChanged()V

    goto :goto_0

    .line 303
    :cond_0
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyColorChanged()V

    .line 305
    :cond_1
    :goto_0
    return v4
.end method


# virtual methods
.method public attachAlphaSlider(Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;)V
    .locals 1
    .param p1, "alphaSlideBar"    # Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    .line 807
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    .line 808
    invoke-virtual {p1, p0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->attachColorPickerView(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 809
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->notifyColor()V

    .line 811
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 812
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->setPreferenceName(Ljava/lang/String;)V

    .line 814
    :cond_0
    return-void
.end method

.method public attachBrightnessSlider(Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;)V
    .locals 1
    .param p1, "brightnessSlider"    # Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    .line 831
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    .line 832
    invoke-virtual {p1, p0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->attachColorPickerView(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 833
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->notifyColor()V

    .line 835
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 836
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->setPreferenceName(Ljava/lang/String;)V

    .line 838
    :cond_0
    return-void
.end method

.method public fireColorListener(IZ)V
    .locals 2
    .param p1, "color"    # I
    .param p2, "fromUser"    # Z

    .line 389
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    if-eqz v0, :cond_6

    .line 390
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 391
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 392
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v0

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->notifyColor()V

    .line 393
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v0

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->assembleColor()I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 395
    :cond_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 396
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v0

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->notifyColor()V

    .line 397
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v0

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->assembleColor()I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 400
    :cond_1
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    instance-of v1, v0, Lcom/skydoves/colorpickerview/listeners/ColorListener;

    if-eqz v1, :cond_2

    .line 401
    check-cast v0, Lcom/skydoves/colorpickerview/listeners/ColorListener;

    iget v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    invoke-interface {v0, v1, p2}, Lcom/skydoves/colorpickerview/listeners/ColorListener;->onColorSelected(IZ)V

    goto :goto_0

    .line 402
    :cond_2
    instance-of v0, v0, Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;

    if-eqz v0, :cond_3

    .line 403
    new-instance v0, Lcom/skydoves/colorpickerview/ColorEnvelope;

    iget v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    invoke-direct {v0, v1}, Lcom/skydoves/colorpickerview/ColorEnvelope;-><init>(I)V

    .line 404
    .local v0, "envelope":Lcom/skydoves/colorpickerview/ColorEnvelope;
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    check-cast v1, Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;

    invoke-interface {v1, v0, p2}, Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;->onColorSelected(Lcom/skydoves/colorpickerview/ColorEnvelope;Z)V

    .line 407
    .end local v0    # "envelope":Lcom/skydoves/colorpickerview/ColorEnvelope;
    :cond_3
    :goto_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    if-eqz v0, :cond_4

    .line 408
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorEnvelope()Lcom/skydoves/colorpickerview/ColorEnvelope;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/flag/FlagView;->onRefresh(Lcom/skydoves/colorpickerview/ColorEnvelope;)V

    .line 409
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->invalidate()V

    .line 412
    :cond_4
    iget-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    if-eqz v0, :cond_6

    .line 413
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    .line 414
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    if-eqz v0, :cond_5

    .line 415
    iget v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 417
    :cond_5
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    if-eqz v0, :cond_6

    .line 418
    iget v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/flag/FlagView;->setAlpha(F)V

    .line 422
    :cond_6
    return-void
.end method

.method public getActionMode()Lcom/skydoves/colorpickerview/ActionMode;
    .locals 1

    .line 780
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    return-object v0
.end method

.method public getAlpha()F
    .locals 2

    .line 479
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v0

    invoke-static {v0}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    int-to-float v0, v0

    const/high16 v1, 0x437f0000    # 255.0f

    div-float/2addr v0, v1

    return v0
.end method

.method public getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    .locals 1

    .line 798
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    return-object v0
.end method

.method public getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    .locals 1

    .line 822
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    return-object v0
.end method

.method public getColor()I
    .locals 1

    .line 470
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    return v0
.end method

.method public getColorEnvelope()Lcom/skydoves/colorpickerview/ColorEnvelope;
    .locals 2

    .line 506
    new-instance v0, Lcom/skydoves/colorpickerview/ColorEnvelope;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v1

    invoke-direct {v0, v1}, Lcom/skydoves/colorpickerview/ColorEnvelope;-><init>(I)V

    return-object v0
.end method

.method protected getColorFromBitmap(FF)I
    .locals 13
    .param p1, "x"    # F
    .param p2, "y"    # F

    .line 337
    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    .line 338
    .local v0, "invertMatrix":Landroid/graphics/Matrix;
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getImageMatrix()Landroid/graphics/Matrix;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/graphics/Matrix;->invert(Landroid/graphics/Matrix;)Z

    .line 340
    const/4 v1, 0x2

    new-array v1, v1, [F

    const/4 v2, 0x0

    aput p1, v1, v2

    const/4 v3, 0x1

    aput p2, v1, v3

    .line 341
    .local v1, "mappedPoints":[F
    invoke-virtual {v0, v1}, Landroid/graphics/Matrix;->mapPoints([F)V

    .line 343
    iget-object v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v4}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    if-eqz v4, :cond_1

    iget-object v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    .line 344
    invoke-virtual {v4}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    instance-of v4, v4, Landroid/graphics/drawable/BitmapDrawable;

    if-eqz v4, :cond_1

    aget v4, v1, v2

    const/4 v5, 0x0

    cmpl-float v4, v4, v5

    if-ltz v4, :cond_1

    aget v4, v1, v3

    cmpl-float v4, v4, v5

    if-ltz v4, :cond_1

    aget v4, v1, v2

    iget-object v6, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    .line 347
    invoke-virtual {v6}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v6

    int-to-float v6, v6

    cmpg-float v4, v4, v6

    if-gez v4, :cond_1

    aget v4, v1, v3

    iget-object v6, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    .line 348
    invoke-virtual {v6}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v6

    invoke-virtual {v6}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v6

    int-to-float v6, v6

    cmpg-float v4, v4, v6

    if-gez v4, :cond_1

    .line 350
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->invalidate()V

    .line 352
    iget-object v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v4}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    instance-of v4, v4, Lcom/skydoves/colorpickerview/ColorHsvPalette;

    if-eqz v4, :cond_0

    .line 353
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getWidth()I

    move-result v4

    int-to-float v4, v4

    const/high16 v6, 0x3f000000    # 0.5f

    mul-float v4, v4, v6

    sub-float/2addr p1, v4

    .line 354
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getHeight()I

    move-result v4

    int-to-float v4, v4

    mul-float v4, v4, v6

    sub-float/2addr p2, v4

    .line 355
    mul-float v4, p1, p1

    mul-float v7, p2, p2

    add-float/2addr v4, v7

    float-to-double v7, v4

    invoke-static {v7, v8}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v7

    .line 356
    .local v7, "r":D
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getWidth()I

    move-result v4

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getHeight()I

    move-result v9

    invoke-static {v4, v9}, Ljava/lang/Math;->min(II)I

    move-result v4

    int-to-float v4, v4

    mul-float v4, v4, v6

    .line 357
    .local v4, "radius":F
    const/4 v6, 0x3

    new-array v6, v6, [F

    fill-array-data v6, :array_0

    .line 358
    .local v6, "hsv":[F
    float-to-double v9, p2

    neg-float v11, p1

    float-to-double v11, v11

    invoke-static {v9, v10, v11, v12}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v9

    const-wide v11, 0x400921fb54442d18L    # Math.PI

    div-double/2addr v9, v11

    const-wide v11, 0x4066800000000000L    # 180.0

    mul-double v9, v9, v11

    double-to-float v9, v9

    const/high16 v10, 0x43340000    # 180.0f

    add-float/2addr v9, v10

    aput v9, v6, v2

    .line 359
    const/high16 v2, 0x3f800000    # 1.0f

    float-to-double v9, v4

    invoke-static {v9, v10}, Ljava/lang/Double;->isNaN(D)Z

    div-double v9, v7, v9

    double-to-float v9, v9

    invoke-static {v2, v9}, Ljava/lang/Math;->min(FF)F

    move-result v2

    invoke-static {v5, v2}, Ljava/lang/Math;->max(FF)F

    move-result v2

    aput v2, v6, v3

    .line 360
    invoke-static {v6}, Landroid/graphics/Color;->HSVToColor([F)I

    move-result v2

    return v2

    .line 362
    .end local v4    # "radius":F
    .end local v6    # "hsv":[F
    .end local v7    # "r":D
    :cond_0
    iget-object v4, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v4}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v4

    invoke-virtual {v4}, Landroid/graphics/drawable/Drawable;->getBounds()Landroid/graphics/Rect;

    move-result-object v4

    .line 363
    .local v4, "rect":Landroid/graphics/Rect;
    aget v2, v1, v2

    invoke-virtual {v4}, Landroid/graphics/Rect;->width()I

    move-result v5

    int-to-float v5, v5

    div-float/2addr v2, v5

    .line 364
    .local v2, "scaleX":F
    iget-object v5, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v5}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v5

    check-cast v5, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v5}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v5

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v5

    int-to-float v5, v5

    mul-float v5, v5, v2

    float-to-int v5, v5

    .line 365
    .local v5, "x1":I
    aget v3, v1, v3

    invoke-virtual {v4}, Landroid/graphics/Rect;->height()I

    move-result v6

    int-to-float v6, v6

    div-float/2addr v3, v6

    .line 366
    .local v3, "scaleY":F
    iget-object v6, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v6}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v6

    check-cast v6, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v6}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v6

    invoke-virtual {v6}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v6

    int-to-float v6, v6

    mul-float v6, v6, v3

    float-to-int v6, v6

    .line 367
    .local v6, "y1":I
    iget-object v7, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v7}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v7

    check-cast v7, Landroid/graphics/drawable/BitmapDrawable;

    invoke-virtual {v7}, Landroid/graphics/drawable/BitmapDrawable;->getBitmap()Landroid/graphics/Bitmap;

    move-result-object v7

    invoke-virtual {v7, v5, v6}, Landroid/graphics/Bitmap;->getPixel(II)I

    move-result v7

    return v7

    .line 370
    .end local v2    # "scaleX":F
    .end local v3    # "scaleY":F
    .end local v4    # "rect":Landroid/graphics/Rect;
    .end local v5    # "x1":I
    .end local v6    # "y1":I
    :cond_1
    return v2

    nop

    :array_0
    .array-data 4
        0x0
        0x0
        0x3f800000    # 1.0f
    .end array-data
.end method

.method public getDebounceDuration()J
    .locals 2

    .line 539
    iget-wide v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    return-wide v0
.end method

.method public getFlagView()Lcom/skydoves/colorpickerview/flag/FlagView;
    .locals 1

    .line 515
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    return-object v0
.end method

.method public getPreferenceName()Ljava/lang/String;
    .locals 1

    .line 846
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceName:Ljava/lang/String;

    return-object v0
.end method

.method public getPureColor()I
    .locals 1

    .line 488
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    return v0
.end method

.method public getSelectedPoint()Landroid/graphics/Point;
    .locals 1

    .line 589
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    return-object v0
.end method

.method public getSelectorX()F
    .locals 3

    .line 571
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getX()F

    move-result v0

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float v1, v1, v2

    sub-float/2addr v0, v1

    return v0
.end method

.method public getSelectorY()F
    .locals 3

    .line 580
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getY()F

    move-result v0

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v1}, Landroid/widget/ImageView;->getMeasuredHeight()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float v1, v1, v2

    sub-float/2addr v0, v1

    return v0
.end method

.method public isHuePalette()Z
    .locals 1

    .line 309
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    instance-of v0, v0, Lcom/skydoves/colorpickerview/ColorHsvPalette;

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public moveSelectorPoint(III)V
    .locals 2
    .param p1, "x"    # I
    .param p2, "y"    # I
    .param p3, "color"    # I

    .line 616
    iput p3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    .line 617
    iput p3, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 618
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0, p1, p2}, Landroid/graphics/Point;-><init>(II)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    .line 619
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerView;->setCoordinate(II)V

    .line 620
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v0

    const/4 v1, 0x0

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    .line 621
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    invoke-direct {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyToFlagView(Landroid/graphics/Point;)V

    .line 622
    return-void
.end method

.method protected onCreateByBuilder(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)V
    .locals 4
    .param p1, "builder"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 241
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    .line 243
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$100(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I

    move-result v2

    invoke-static {v1, v2}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v1

    .line 244
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$200(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I

    move-result v3

    invoke-static {v2, v3}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 245
    .local v0, "params":Landroid/widget/FrameLayout$LayoutParams;
    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 247
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$300(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->paletteDrawable:Landroid/graphics/drawable/Drawable;

    .line 248
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$400(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroid/graphics/drawable/Drawable;

    move-result-object v1

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    .line 249
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$500(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)F

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 250
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$600(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)F

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 251
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$700(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I

    move-result v1

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectorSize:I

    .line 252
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$800(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I

    move-result v1

    int-to-long v1, v1

    iput-wide v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 253
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->onCreate()V

    .line 255
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$900(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$900(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setColorListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)V

    .line 256
    :cond_0
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1000(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v1

    if-eqz v1, :cond_1

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1000(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->attachAlphaSlider(Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;)V

    .line 257
    :cond_1
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1100(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1100(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->attachBrightnessSlider(Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;)V

    .line 258
    :cond_2
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1200(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/ActionMode;

    move-result-object v1

    if-eqz v1, :cond_3

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1200(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/ActionMode;

    move-result-object v1

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 259
    :cond_3
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1300(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/flag/FlagView;

    move-result-object v1

    if-eqz v1, :cond_4

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1300(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/flag/FlagView;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setFlagView(Lcom/skydoves/colorpickerview/flag/FlagView;)V

    .line 260
    :cond_4
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1400(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Ljava/lang/String;

    move-result-object v1

    if-eqz v1, :cond_5

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1400(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setPreferenceName(Ljava/lang/String;)V

    .line 261
    :cond_5
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1500(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I

    move-result v1

    if-eqz v1, :cond_6

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1500(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I

    move-result v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setInitialColor(I)V

    .line 262
    :cond_6
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1600(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroidx/lifecycle/LifecycleOwner;

    move-result-object v1

    if-eqz v1, :cond_7

    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->access$1600(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroidx/lifecycle/LifecycleOwner;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setLifecycleOwner(Landroidx/lifecycle/LifecycleOwner;)V

    .line 263
    :cond_7
    return-void
.end method

.method public onDestroy()V
    .locals 1
    .annotation runtime Landroidx/lifecycle/OnLifecycleEvent;
        value = .enum Landroidx/lifecycle/Lifecycle$Event;->ON_DESTROY:Landroidx/lifecycle/Lifecycle$Event;
    .end annotation

    .line 890
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    invoke-virtual {v0, p0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->saveColorPickerData(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 891
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 4
    .param p1, "width"    # I
    .param p2, "height"    # I
    .param p3, "oldWidth"    # I
    .param p4, "oldHeight"    # I

    .line 215
    invoke-super {p0, p1, p2, p3, p4}, Landroid/widget/FrameLayout;->onSizeChanged(IIII)V

    .line 217
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-nez v0, :cond_0

    .line 218
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p1, p2, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 219
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    new-instance v2, Lcom/skydoves/colorpickerview/ColorHsvPalette;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-direct {v2, v3, v0}, Lcom/skydoves/colorpickerview/ColorHsvPalette;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 221
    .end local v0    # "bitmap":Landroid/graphics/Bitmap;
    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 3
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 268
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    if-eq v0, v1, :cond_0

    const/4 v2, 0x2

    if-eq v0, v2, :cond_0

    .line 276
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setPressed(Z)V

    .line 277
    return v1

    .line 272
    :cond_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getFlagView()Lcom/skydoves/colorpickerview/flag/FlagView;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getFlagView()Lcom/skydoves/colorpickerview/flag/FlagView;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/skydoves/colorpickerview/flag/FlagView;->receiveOnTouchEvent(Landroid/view/MotionEvent;)V

    .line 273
    :cond_1
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setPressed(Z)V

    .line 274
    invoke-direct {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->onTouchReceived(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method

.method public removeLifecycleOwner(Landroidx/lifecycle/LifecycleOwner;)V
    .locals 1
    .param p1, "lifecycleOwner"    # Landroidx/lifecycle/LifecycleOwner;

    .line 879
    invoke-interface {p1}, Landroidx/lifecycle/LifecycleOwner;->getLifecycle()Landroidx/lifecycle/Lifecycle;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/lifecycle/Lifecycle;->removeObserver(Landroidx/lifecycle/LifecycleObserver;)V

    .line 880
    return-void
.end method

.method public selectByHsvColor(I)V
    .locals 11
    .param p1, "color"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 677
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {v0}, Landroid/widget/ImageView;->getDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    instance-of v0, v0, Lcom/skydoves/colorpickerview/ColorHsvPalette;

    if-eqz v0, :cond_2

    .line 678
    const/4 v0, 0x3

    new-array v0, v0, [F

    .line 679
    .local v0, "hsv":[F
    invoke-static {p1, v0}, Landroid/graphics/Color;->colorToHSV(I[F)V

    .line 681
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getWidth()I

    move-result v1

    int-to-float v1, v1

    const/high16 v2, 0x3f000000    # 0.5f

    mul-float v1, v1, v2

    .line 682
    .local v1, "centerX":F
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getHeight()I

    move-result v3

    int-to-float v3, v3

    mul-float v3, v3, v2

    .line 683
    .local v3, "centerY":F
    const/4 v2, 0x1

    aget v2, v0, v2

    invoke-static {v1, v3}, Ljava/lang/Math;->min(FF)F

    move-result v4

    mul-float v2, v2, v4

    .line 684
    .local v2, "radius":F
    float-to-double v4, v2

    const/4 v6, 0x0

    aget v7, v0, v6

    float-to-double v7, v7

    invoke-static {v7, v8}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v7

    invoke-static {v7, v8}, Ljava/lang/Math;->cos(D)D

    move-result-wide v7

    invoke-static {v4, v5}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v4, v4, v7

    float-to-double v7, v1

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    add-double/2addr v4, v7

    double-to-int v4, v4

    .line 685
    .local v4, "pointX":I
    neg-float v5, v2

    float-to-double v7, v5

    aget v5, v0, v6

    float-to-double v9, v5

    invoke-static {v9, v10}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Math;->sin(D)D

    move-result-wide v9

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    float-to-double v9, v3

    invoke-static {v9, v10}, Ljava/lang/Double;->isNaN(D)Z

    add-double/2addr v7, v9

    double-to-int v5, v7

    .line 687
    .local v5, "pointY":I
    new-instance v7, Landroid/graphics/Point;

    invoke-direct {v7, v4, v5}, Landroid/graphics/Point;-><init>(II)V

    invoke-static {p0, v7}, Lcom/skydoves/colorpickerview/PointMapper;->getColorPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v7

    .line 688
    .local v7, "mappedPoint":Landroid/graphics/Point;
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    .line 689
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 690
    new-instance v8, Landroid/graphics/Point;

    iget v9, v7, Landroid/graphics/Point;->x:I

    iget v10, v7, Landroid/graphics/Point;->y:I

    invoke-direct {v8, v9, v10}, Landroid/graphics/Point;-><init>(II)V

    iput-object v8, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    .line 691
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v8

    if-eqz v8, :cond_0

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v8

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlpha()F

    move-result v9

    invoke-virtual {v8, v9}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->setSelectorPosition(F)V

    .line 692
    :cond_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v8

    if-eqz v8, :cond_1

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v8

    const/4 v9, 0x2

    aget v9, v0, v9

    invoke-virtual {v8, v9}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->setSelectorPosition(F)V

    .line 693
    :cond_1
    iget v8, v7, Landroid/graphics/Point;->x:I

    iget v9, v7, Landroid/graphics/Point;->y:I

    invoke-virtual {p0, v8, v9}, Lcom/skydoves/colorpickerview/ColorPickerView;->setCoordinate(II)V

    .line 694
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v8

    invoke-virtual {p0, v8, v6}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    .line 695
    iget-object v6, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    invoke-direct {p0, v6}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyToFlagView(Landroid/graphics/Point;)V

    .line 696
    .end local v0    # "hsv":[F
    .end local v1    # "centerX":F
    .end local v2    # "radius":F
    .end local v3    # "centerY":F
    .end local v4    # "pointX":I
    .end local v5    # "pointY":I
    .end local v7    # "mappedPoint":Landroid/graphics/Point;
    nop

    .line 701
    return-void

    .line 697
    :cond_2
    new-instance v0, Ljava/lang/IllegalAccessException;

    const-string v1, "selectByHsvColor(@ColorInt int color) can be called only when the palette is an instance of ColorHsvPalette. Use setHsvPaletteDrawable();"

    invoke-direct {v0, v1}, Ljava/lang/IllegalAccessException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public selectByHsvColorRes(I)V
    .locals 1
    .param p1, "resource"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 711
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p1}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->selectByHsvColor(I)V

    .line 712
    return-void
.end method

.method public selectCenter()V
    .locals 2

    .line 771
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredWidth()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredHeight()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setSelectorPoint(II)V

    .line 772
    return-void
.end method

.method public setActionMode(Lcom/skydoves/colorpickerview/ActionMode;)V
    .locals 0
    .param p1, "actionMode"    # Lcom/skydoves/colorpickerview/ActionMode;

    .line 789
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 790
    return-void
.end method

.method public setColorListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)V
    .locals 0
    .param p1, "colorListener"    # Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 379
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 380
    return-void
.end method

.method public setCoordinate(II)V
    .locals 4
    .param p1, "x"    # I
    .param p2, "y"    # I

    .line 631
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    int-to-float v1, p1

    invoke-virtual {v0}, Landroid/widget/ImageView;->getMeasuredWidth()I

    move-result v2

    int-to-float v2, v2

    const/high16 v3, 0x3f000000    # 0.5f

    mul-float v2, v2, v3

    sub-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setX(F)V

    .line 632
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    int-to-float v1, p2

    invoke-virtual {v0}, Landroid/widget/ImageView;->getMeasuredHeight()I

    move-result v2

    int-to-float v2, v2

    mul-float v2, v2, v3

    sub-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setY(F)V

    .line 633
    return-void
.end method

.method public setDebounceDuration(J)V
    .locals 0
    .param p1, "debounceDuration"    # J

    .line 551
    iput-wide p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->debounceDuration:J

    .line 552
    return-void
.end method

.method public setFlagView(Lcom/skydoves/colorpickerview/flag/FlagView;)V
    .locals 1
    .param p1, "flagView"    # Lcom/skydoves/colorpickerview/flag/FlagView;

    .line 524
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/flag/FlagView;->gone()V

    .line 525
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->addView(Landroid/view/View;)V

    .line 526
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    .line 527
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    invoke-virtual {p1, v0}, Lcom/skydoves/colorpickerview/flag/FlagView;->setAlpha(F)V

    .line 528
    return-void
.end method

.method public setHsvPaletteDrawable()V
    .locals 3

    .line 720
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getWidth()I

    move-result v0

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getHeight()I

    move-result v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 721
    .local v0, "bitmap":Landroid/graphics/Bitmap;
    new-instance v1, Lcom/skydoves/colorpickerview/ColorHsvPalette;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Lcom/skydoves/colorpickerview/ColorHsvPalette;-><init>(Landroid/content/res/Resources;Landroid/graphics/Bitmap;)V

    invoke-virtual {p0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setPaletteDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 722
    return-void
.end method

.method public setInitialColor(I)V
    .locals 3
    .param p1, "color"    # I

    .line 642
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 643
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 644
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, -0x1

    invoke-virtual {v0, v1, v2}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getColor(Ljava/lang/String;I)I

    move-result v0

    if-ne v0, v2, :cond_1

    .line 645
    :cond_0
    new-instance v0, Lcom/skydoves/colorpickerview/ColorPickerView$3;

    invoke-direct {v0, p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerView$3;-><init>(Lcom/skydoves/colorpickerview/ColorPickerView;I)V

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->post(Ljava/lang/Runnable;)Z

    .line 657
    :cond_1
    return-void
.end method

.method public setInitialColorRes(I)V
    .locals 1
    .param p1, "colorRes"    # I

    .line 666
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p1}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v0

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->setInitialColor(I)V

    .line 667
    return-void
.end method

.method public setLifecycleOwner(Landroidx/lifecycle/LifecycleOwner;)V
    .locals 1
    .param p1, "lifecycleOwner"    # Landroidx/lifecycle/LifecycleOwner;

    .line 870
    invoke-interface {p1}, Landroidx/lifecycle/LifecycleOwner;->getLifecycle()Landroidx/lifecycle/Lifecycle;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroidx/lifecycle/Lifecycle;->addObserver(Landroidx/lifecycle/LifecycleObserver;)V

    .line 871
    return-void
.end method

.method public setPaletteDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 2
    .param p1, "drawable"    # Landroid/graphics/drawable/Drawable;

    .line 730
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->removeView(Landroid/view/View;)V

    .line 731
    new-instance v0, Landroid/widget/ImageView;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    .line 732
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->paletteDrawable:Landroid/graphics/drawable/Drawable;

    .line 733
    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 734
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->palette:Landroid/widget/ImageView;

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->addView(Landroid/view/View;)V

    .line 736
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->removeView(Landroid/view/View;)V

    .line 737
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->addView(Landroid/view/View;)V

    .line 739
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    .line 740
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyToSlideBars()V

    .line 742
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    if-eqz v0, :cond_0

    .line 743
    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->removeView(Landroid/view/View;)V

    .line 744
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {p0, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->addView(Landroid/view/View;)V

    .line 747
    :cond_0
    iget-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    if-nez v0, :cond_2

    .line 748
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->VISIBLE_FLAG:Z

    .line 749
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    const/4 v1, 0x0

    if-eqz v0, :cond_1

    .line 750
    invoke-virtual {v0}, Landroid/widget/ImageView;->getAlpha()F

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_selector:F

    .line 751
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setAlpha(F)V

    .line 753
    :cond_1
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    if-eqz v0, :cond_2

    .line 754
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/flag/FlagView;->getAlpha()F

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alpha_flag:F

    .line 755
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/flag/FlagView;->setAlpha(F)V

    .line 758
    :cond_2
    return-void
.end method

.method public setPreferenceName(Ljava/lang/String;)V
    .locals 1
    .param p1, "preferenceName"    # Ljava/lang/String;

    .line 855
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->preferenceName:Ljava/lang/String;

    .line 856
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    if-eqz v0, :cond_0

    .line 857
    invoke-virtual {v0, p1}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->setPreferenceName(Ljava/lang/String;)V

    .line 859
    :cond_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    if-eqz v0, :cond_1

    .line 860
    invoke-virtual {v0, p1}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->setPreferenceName(Ljava/lang/String;)V

    .line 862
    :cond_1
    return-void
.end method

.method public setPureColor(I)V
    .locals 0
    .param p1, "color"    # I

    .line 497
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    .line 498
    return-void
.end method

.method public setSelectorDrawable(Landroid/graphics/drawable/Drawable;)V
    .locals 1
    .param p1, "drawable"    # Landroid/graphics/drawable/Drawable;

    .line 766
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selector:Landroid/widget/ImageView;

    invoke-virtual {v0, p1}, Landroid/widget/ImageView;->setImageDrawable(Landroid/graphics/drawable/Drawable;)V

    .line 767
    return-void
.end method

.method public setSelectorPoint(II)V
    .locals 5
    .param p1, "x"    # I
    .param p2, "y"    # I

    .line 599
    new-instance v0, Landroid/graphics/Point;

    invoke-direct {v0, p1, p2}, Landroid/graphics/Point;-><init>(II)V

    invoke-static {p0, v0}, Lcom/skydoves/colorpickerview/PointMapper;->getColorPoint(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v0

    .line 600
    .local v0, "mappedPoint":Landroid/graphics/Point;
    iget v1, v0, Landroid/graphics/Point;->x:I

    int-to-float v1, v1

    iget v2, v0, Landroid/graphics/Point;->y:I

    int-to-float v2, v2

    invoke-virtual {p0, v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorFromBitmap(FF)I

    move-result v1

    .line 601
    .local v1, "color":I
    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPureColor:I

    .line 602
    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedColor:I

    .line 603
    new-instance v2, Landroid/graphics/Point;

    iget v3, v0, Landroid/graphics/Point;->x:I

    iget v4, v0, Landroid/graphics/Point;->y:I

    invoke-direct {v2, v3, v4}, Landroid/graphics/Point;-><init>(II)V

    iput-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    .line 604
    iget v2, v0, Landroid/graphics/Point;->x:I

    iget v3, v0, Landroid/graphics/Point;->y:I

    invoke-virtual {p0, v2, v3}, Lcom/skydoves/colorpickerview/ColorPickerView;->setCoordinate(II)V

    .line 605
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v2

    const/4 v3, 0x0

    invoke-virtual {p0, v2, v3}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    .line 606
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerView;->selectedPoint:Landroid/graphics/Point;

    invoke-direct {p0, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->notifyToFlagView(Landroid/graphics/Point;)V

    .line 607
    return-void
.end method
