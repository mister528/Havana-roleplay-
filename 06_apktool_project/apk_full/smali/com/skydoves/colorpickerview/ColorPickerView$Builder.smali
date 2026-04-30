.class public Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
.super Ljava/lang/Object;
.source "ColorPickerView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/skydoves/colorpickerview/ColorPickerView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private actionMode:Lcom/skydoves/colorpickerview/ActionMode;

.field private alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

.field private alpha_flag:F

.field private alpha_selector:F

.field private brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

.field private colorPickerViewListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

.field private context:Landroid/content/Context;

.field private debounceDuration:I

.field private flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

.field private height:I
    .annotation runtime Lcom/skydoves/colorpickerview/Dp;
    .end annotation
.end field

.field private initialColor:I

.field private lifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

.field private paletteDrawable:Landroid/graphics/drawable/Drawable;

.field private preferenceName:Ljava/lang/String;

.field private selectorDrawable:Landroid/graphics/drawable/Drawable;

.field private selectorSize:I
    .annotation runtime Lcom/skydoves/colorpickerview/Dp;
    .end annotation
.end field

.field private width:I
    .annotation runtime Lcom/skydoves/colorpickerview/Dp;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 918
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 897
    const/4 v0, 0x0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->debounceDuration:I

    .line 903
    sget-object v1, Lcom/skydoves/colorpickerview/ActionMode;->ALWAYS:Lcom/skydoves/colorpickerview/ActionMode;

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 904
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->initialColor:I

    .line 906
    const/high16 v1, 0x3f800000    # 1.0f

    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alpha_selector:F

    .line 909
    iput v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alpha_flag:F

    .line 912
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->selectorSize:I

    .line 913
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->width:I

    .line 914
    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->height:I

    .line 919
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->context:Landroid/content/Context;

    .line 920
    return-void
.end method

.method static synthetic access$100(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->width:I

    return v0
.end method

.method static synthetic access$1000(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    return-object v0
.end method

.method static synthetic access$1200(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/ActionMode;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    return-object v0
.end method

.method static synthetic access$1300(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/flag/FlagView;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    return-object v0
.end method

.method static synthetic access$1400(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->preferenceName:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->initialColor:I

    return v0
.end method

.method static synthetic access$1600(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroidx/lifecycle/LifecycleOwner;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->lifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

    return-object v0
.end method

.method static synthetic access$200(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->height:I

    return v0
.end method

.method static synthetic access$300(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->paletteDrawable:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method static synthetic access$400(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Landroid/graphics/drawable/Drawable;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    return-object v0
.end method

.method static synthetic access$500(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alpha_selector:F

    return v0
.end method

.method static synthetic access$600(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)F
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alpha_flag:F

    return v0
.end method

.method static synthetic access$700(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->selectorSize:I

    return v0
.end method

.method static synthetic access$800(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->debounceDuration:I

    return v0
.end method

.method static synthetic access$900(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/ColorPickerView$Builder;

    .line 894
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->colorPickerViewListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    return-object v0
.end method


# virtual methods
.method public build()Lcom/skydoves/colorpickerview/ColorPickerView;
    .locals 2

    .line 1008
    new-instance v0, Lcom/skydoves/colorpickerview/ColorPickerView;

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->context:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;-><init>(Landroid/content/Context;)V

    .line 1009
    .local v0, "colorPickerView":Lcom/skydoves/colorpickerview/ColorPickerView;
    invoke-virtual {v0, p0}, Lcom/skydoves/colorpickerview/ColorPickerView;->onCreateByBuilder(Lcom/skydoves/colorpickerview/ColorPickerView$Builder;)V

    .line 1010
    return-object v0
.end method

.method public setActionMode(Lcom/skydoves/colorpickerview/ActionMode;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "actionMode"    # Lcom/skydoves/colorpickerview/ActionMode;

    .line 958
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->actionMode:Lcom/skydoves/colorpickerview/ActionMode;

    .line 959
    return-object p0
.end method

.method public setAlphaSlideBar(Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "alphaSlideBar"    # Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    .line 948
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    .line 949
    return-object p0
.end method

.method public setBrightnessSlideBar(Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "brightnessSlideBar"    # Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    .line 953
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->brightnessSlider:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    .line 954
    return-object p0
.end method

.method public setColorListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "colorPickerViewListener"    # Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 923
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->colorPickerViewListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 924
    return-object p0
.end method

.method public setDebounceDuration(I)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "debounceDuration"    # I

    .line 928
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->debounceDuration:I

    .line 929
    return-object p0
.end method

.method public setFlagAlpha(F)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "alpha"    # F

    .line 968
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alpha_flag:F

    .line 969
    return-object p0
.end method

.method public setFlagView(Lcom/skydoves/colorpickerview/flag/FlagView;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "flagView"    # Lcom/skydoves/colorpickerview/flag/FlagView;

    .line 943
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->flagView:Lcom/skydoves/colorpickerview/flag/FlagView;

    .line 944
    return-object p0
.end method

.method public setHeight(I)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "height"    # I
        .annotation runtime Lcom/skydoves/colorpickerview/Dp;
        .end annotation
    .end param

    .line 983
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->height:I

    .line 984
    return-object p0
.end method

.method public setInitialColor(I)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "initialColor"    # I

    .line 988
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->initialColor:I

    .line 989
    return-object p0
.end method

.method public setInitialColorRes(I)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 1
    .param p1, "initialColorRes"    # I

    .line 993
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->context:Landroid/content/Context;

    invoke-static {v0, p1}, Landroidx/core/content/ContextCompat;->getColor(Landroid/content/Context;I)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->initialColor:I

    .line 994
    return-object p0
.end method

.method public setLifecycleOwner(Landroidx/lifecycle/LifecycleOwner;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "lifecycleOwner"    # Landroidx/lifecycle/LifecycleOwner;

    .line 1003
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->lifecycleOwner:Landroidx/lifecycle/LifecycleOwner;

    .line 1004
    return-object p0
.end method

.method public setPaletteDrawable(Landroid/graphics/drawable/Drawable;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "palette"    # Landroid/graphics/drawable/Drawable;

    .line 933
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->paletteDrawable:Landroid/graphics/drawable/Drawable;

    .line 934
    return-object p0
.end method

.method public setPreferenceName(Ljava/lang/String;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "preferenceName"    # Ljava/lang/String;

    .line 998
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->preferenceName:Ljava/lang/String;

    .line 999
    return-object p0
.end method

.method public setSelectorAlpha(F)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "alpha"    # F

    .line 963
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->alpha_selector:F

    .line 964
    return-object p0
.end method

.method public setSelectorDrawable(Landroid/graphics/drawable/Drawable;)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "selector"    # Landroid/graphics/drawable/Drawable;

    .line 938
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->selectorDrawable:Landroid/graphics/drawable/Drawable;

    .line 939
    return-object p0
.end method

.method public setSelectorSize(I)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "size"    # I
        .annotation runtime Lcom/skydoves/colorpickerview/Dp;
        .end annotation
    .end param

    .line 973
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->selectorSize:I

    .line 974
    return-object p0
.end method

.method public setWidth(I)Lcom/skydoves/colorpickerview/ColorPickerView$Builder;
    .locals 0
    .param p1, "width"    # I
        .annotation runtime Lcom/skydoves/colorpickerview/Dp;
        .end annotation
    .end param

    .line 978
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$Builder;->width:I

    .line 979
    return-object p0
.end method
