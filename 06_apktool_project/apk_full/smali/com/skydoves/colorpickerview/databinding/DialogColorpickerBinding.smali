.class public final Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;
.super Ljava/lang/Object;
.source "DialogColorpickerBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

.field public final alphaSlideBarFrame:Landroid/widget/FrameLayout;

.field public final brightnessSlideBar:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

.field public final brightnessSlideBarFrame:Landroid/widget/FrameLayout;

.field public final colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

.field public final colorPickerViewFrame:Landroid/widget/FrameLayout;

.field private final rootView:Landroid/widget/ScrollView;

.field public final spaceBottom:Landroid/widget/Space;


# direct methods
.method private constructor <init>(Landroid/widget/ScrollView;Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;Landroid/widget/FrameLayout;Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;Landroid/widget/FrameLayout;Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/widget/FrameLayout;Landroid/widget/Space;)V
    .locals 0
    .param p1, "rootView"    # Landroid/widget/ScrollView;
    .param p2, "alphaSlideBar"    # Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    .param p3, "alphaSlideBarFrame"    # Landroid/widget/FrameLayout;
    .param p4, "brightnessSlideBar"    # Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    .param p5, "brightnessSlideBarFrame"    # Landroid/widget/FrameLayout;
    .param p6, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;
    .param p7, "colorPickerViewFrame"    # Landroid/widget/FrameLayout;
    .param p8, "spaceBottom"    # Landroid/widget/Space;

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    iput-object p1, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->rootView:Landroid/widget/ScrollView;

    .line 52
    iput-object p2, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    .line 53
    iput-object p3, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->alphaSlideBarFrame:Landroid/widget/FrameLayout;

    .line 54
    iput-object p4, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->brightnessSlideBar:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    .line 55
    iput-object p5, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->brightnessSlideBarFrame:Landroid/widget/FrameLayout;

    .line 56
    iput-object p6, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 57
    iput-object p7, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerViewFrame:Landroid/widget/FrameLayout;

    .line 58
    iput-object p8, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->spaceBottom:Landroid/widget/Space;

    .line 59
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;
    .locals 18
    .param p0, "rootView"    # Landroid/view/View;

    .line 88
    move-object/from16 v0, p0

    sget v1, Lcom/skydoves/colorpickerview/R$id;->alphaSlideBar:I

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    .line 89
    .local v1, "alphaSlideBar":Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    if-eqz v1, :cond_6

    .line 93
    sget v2, Lcom/skydoves/colorpickerview/R$id;->alphaSlideBarFrame:I

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v11, v2

    check-cast v11, Landroid/widget/FrameLayout;

    .line 94
    .local v11, "alphaSlideBarFrame":Landroid/widget/FrameLayout;
    if-eqz v11, :cond_5

    .line 98
    sget v2, Lcom/skydoves/colorpickerview/R$id;->brightnessSlideBar:I

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v12, v2

    check-cast v12, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    .line 99
    .local v12, "brightnessSlideBar":Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    if-eqz v12, :cond_4

    .line 103
    sget v2, Lcom/skydoves/colorpickerview/R$id;->brightnessSlideBarFrame:I

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v13, v2

    check-cast v13, Landroid/widget/FrameLayout;

    .line 104
    .local v13, "brightnessSlideBarFrame":Landroid/widget/FrameLayout;
    if-eqz v13, :cond_3

    .line 108
    sget v2, Lcom/skydoves/colorpickerview/R$id;->colorPickerView:I

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v14, v2

    check-cast v14, Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 109
    .local v14, "colorPickerView":Lcom/skydoves/colorpickerview/ColorPickerView;
    if-eqz v14, :cond_2

    .line 113
    sget v2, Lcom/skydoves/colorpickerview/R$id;->colorPickerViewFrame:I

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object v15, v2

    check-cast v15, Landroid/widget/FrameLayout;

    .line 114
    .local v15, "colorPickerViewFrame":Landroid/widget/FrameLayout;
    if-eqz v15, :cond_1

    .line 118
    sget v2, Lcom/skydoves/colorpickerview/R$id;->space_bottom:I

    invoke-virtual {v0, v2}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    move-object/from16 v16, v2

    check-cast v16, Landroid/widget/Space;

    .line 119
    .local v16, "spaceBottom":Landroid/widget/Space;
    if-eqz v16, :cond_0

    .line 123
    new-instance v17, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    move-object v3, v0

    check-cast v3, Landroid/widget/ScrollView;

    move-object/from16 v2, v17

    move-object v4, v1

    move-object v5, v11

    move-object v6, v12

    move-object v7, v13

    move-object v8, v14

    move-object v9, v15

    move-object/from16 v10, v16

    invoke-direct/range {v2 .. v10}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;-><init>(Landroid/widget/ScrollView;Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;Landroid/widget/FrameLayout;Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;Landroid/widget/FrameLayout;Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/widget/FrameLayout;Landroid/widget/Space;)V

    return-object v17

    .line 120
    :cond_0
    const-string v2, "spaceBottom"

    .line 121
    .local v2, "missingId":Ljava/lang/String;
    goto :goto_0

    .line 115
    .end local v2    # "missingId":Ljava/lang/String;
    .end local v16    # "spaceBottom":Landroid/widget/Space;
    :cond_1
    const-string v2, "colorPickerViewFrame"

    .line 116
    .restart local v2    # "missingId":Ljava/lang/String;
    goto :goto_0

    .line 110
    .end local v2    # "missingId":Ljava/lang/String;
    .end local v15    # "colorPickerViewFrame":Landroid/widget/FrameLayout;
    :cond_2
    const-string v2, "colorPickerView"

    .line 111
    .restart local v2    # "missingId":Ljava/lang/String;
    goto :goto_0

    .line 105
    .end local v2    # "missingId":Ljava/lang/String;
    .end local v14    # "colorPickerView":Lcom/skydoves/colorpickerview/ColorPickerView;
    :cond_3
    const-string v2, "brightnessSlideBarFrame"

    .line 106
    .restart local v2    # "missingId":Ljava/lang/String;
    goto :goto_0

    .line 100
    .end local v2    # "missingId":Ljava/lang/String;
    .end local v13    # "brightnessSlideBarFrame":Landroid/widget/FrameLayout;
    :cond_4
    const-string v2, "brightnessSlideBar"

    .line 101
    .restart local v2    # "missingId":Ljava/lang/String;
    goto :goto_0

    .line 95
    .end local v2    # "missingId":Ljava/lang/String;
    .end local v12    # "brightnessSlideBar":Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    :cond_5
    const-string v2, "alphaSlideBarFrame"

    .line 96
    .restart local v2    # "missingId":Ljava/lang/String;
    goto :goto_0

    .line 90
    .end local v2    # "missingId":Ljava/lang/String;
    .end local v11    # "alphaSlideBarFrame":Landroid/widget/FrameLayout;
    :cond_6
    const-string v2, "alphaSlideBar"

    .line 91
    .restart local v2    # "missingId":Ljava/lang/String;
    nop

    .line 127
    .end local v1    # "alphaSlideBar":Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    :goto_0
    new-instance v1, Ljava/lang/NullPointerException;

    const-string v3, "Missing required view with ID: "

    invoke-virtual {v3, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 69
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 75
    sget v0, Lcom/skydoves/colorpickerview/R$layout;->dialog_colorpicker:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 76
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 77
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 79
    :cond_0
    invoke-static {v0}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->bind(Landroid/view/View;)Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 21
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->getRoot()Landroid/widget/ScrollView;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroid/widget/ScrollView;
    .locals 1

    .line 64
    iget-object v0, p0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->rootView:Landroid/widget/ScrollView;

    return-object v0
.end method
