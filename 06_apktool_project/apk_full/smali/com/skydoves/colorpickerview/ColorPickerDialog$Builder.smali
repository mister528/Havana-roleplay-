.class public Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
.super Landroidx/appcompat/app/AlertDialog$Builder;
.source "ColorPickerDialog.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/skydoves/colorpickerview/ColorPickerDialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private bottomSpace:I

.field private colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

.field private dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

.field private shouldAttachAlphaSlideBar:Z

.field private shouldAttachBrightnessSlideBar:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 59
    invoke-direct {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 54
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachAlphaSlideBar:Z

    .line 55
    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachBrightnessSlideBar:Z

    .line 56
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    const/16 v1, 0xa

    invoke-static {v0, v1}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->bottomSpace:I

    .line 60
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->onCreate()V

    .line 61
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "themeResId"    # I

    .line 64
    invoke-direct {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;-><init>(Landroid/content/Context;I)V

    .line 54
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachAlphaSlideBar:Z

    .line 55
    iput-boolean v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachBrightnessSlideBar:Z

    .line 56
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    const/16 v1, 0xa

    invoke-static {v0, v1}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->bottomSpace:I

    .line 65
    invoke-direct {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->onCreate()V

    .line 66
    return-void
.end method

.method private getOnClickListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Landroid/content/DialogInterface$OnClickListener;
    .locals 1
    .param p1, "colorListener"    # Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 190
    new-instance v0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;

    invoke-direct {v0, p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;-><init>(Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)V

    return-object v0
.end method

.method private onCreate()V
    .locals 3

    .line 69
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 70
    .local v0, "layoutInflater":Landroid/view/LayoutInflater;
    const/4 v1, 0x0

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    move-result-object v1

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    .line 71
    iget-object v1, v1, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    iput-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 72
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->alphaSlideBar:Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    invoke-virtual {v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->attachAlphaSlider(Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;)V

    .line 73
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->brightnessSlideBar:Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    invoke-virtual {v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->attachBrightnessSlider(Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;)V

    .line 74
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    new-instance v2, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$1;

    invoke-direct {v2, p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$1;-><init>(Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;)V

    invoke-virtual {v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->setColorListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)V

    .line 81
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->getRoot()Landroid/widget/ScrollView;

    move-result-object v1

    invoke-super {p0, v1}, Landroidx/appcompat/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 82
    return-void
.end method


# virtual methods
.method public attachAlphaSlideBar(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "value"    # Z

    .line 112
    iput-boolean p1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachAlphaSlideBar:Z

    .line 113
    return-object p0
.end method

.method public attachBrightnessSlideBar(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "value"    # Z

    .line 123
    iput-boolean p1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachBrightnessSlideBar:Z

    .line 124
    return-object p0
.end method

.method public create()Landroidx/appcompat/app/AlertDialog;
    .locals 4

    .line 215
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 216
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v0, v0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerViewFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 217
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v0, v0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerViewFrame:Landroid/widget/FrameLayout;

    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 219
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v0

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v0

    .line 220
    .local v0, "alphaSlideBar":Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    iget-boolean v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachAlphaSlideBar:Z

    if-eqz v1, :cond_0

    if-eqz v0, :cond_0

    .line 221
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v1, v1, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->alphaSlideBarFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v1}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 222
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v1, v1, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->alphaSlideBarFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v1, v0}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 223
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->attachAlphaSlider(Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;)V

    goto :goto_0

    .line 224
    :cond_0
    iget-boolean v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachAlphaSlideBar:Z

    if-nez v1, :cond_1

    .line 225
    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v1, v1, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->alphaSlideBarFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v1}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 228
    :cond_1
    :goto_0
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v1

    .line 229
    .local v1, "brightnessSlideBar":Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    iget-boolean v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachBrightnessSlideBar:Z

    if-eqz v2, :cond_2

    if-eqz v1, :cond_2

    .line 230
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->brightnessSlideBarFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v2}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 231
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->brightnessSlideBarFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v2, v1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 232
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->attachBrightnessSlider(Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;)V

    goto :goto_1

    .line 233
    :cond_2
    iget-boolean v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachBrightnessSlideBar:Z

    if-nez v2, :cond_3

    .line 234
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->brightnessSlideBarFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v2}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 237
    :cond_3
    :goto_1
    iget-boolean v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachAlphaSlideBar:Z

    if-nez v2, :cond_4

    iget-boolean v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->shouldAttachBrightnessSlideBar:Z

    if-nez v2, :cond_4

    .line 238
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->spaceBottom:Landroid/widget/Space;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/Space;->setVisibility(I)V

    goto :goto_2

    .line 240
    :cond_4
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->spaceBottom:Landroid/widget/Space;

    const/4 v3, 0x0

    invoke-virtual {v2, v3}, Landroid/widget/Space;->setVisibility(I)V

    .line 241
    iget-object v2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v2, v2, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->spaceBottom:Landroid/widget/Space;

    invoke-virtual {v2}, Landroid/widget/Space;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    iget v3, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->bottomSpace:I

    iput v3, v2, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 245
    .end local v0    # "alphaSlideBar":Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;
    .end local v1    # "brightnessSlideBar":Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;
    :cond_5
    :goto_2
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->getRoot()Landroid/widget/ScrollView;

    move-result-object v0

    invoke-super {p0, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 246
    invoke-super {p0}, Landroidx/appcompat/app/AlertDialog$Builder;->create()Landroidx/appcompat/app/AlertDialog;

    move-result-object v0

    return-object v0
.end method

.method public getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;
    .locals 1

    .line 90
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;

    return-object v0
.end method

.method public bridge synthetic setAdapter(Landroid/widget/ListAdapter;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setAdapter(Landroid/widget/ListAdapter;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setAdapter(Landroid/widget/ListAdapter;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "adapter"    # Landroid/widget/ListAdapter;
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 359
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setAdapter(Landroid/widget/ListAdapter;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 360
    return-object p0
.end method

.method public setBottomSpace(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 1
    .param p1, "bottomSpace"    # I

    .line 148
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0, p1}, Lcom/skydoves/colorpickerview/SizeUtils;->dp2Px(Landroid/content/Context;I)I

    move-result v0

    iput v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->bottomSpace:I

    .line 149
    return-object p0
.end method

.method public bridge synthetic setCancelable(Z)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setCancelable(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setCancelable(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "cancelable"    # Z

    .line 299
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setCancelable(Z)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 300
    return-object p0
.end method

.method public setColorPickerView(Lcom/skydoves/colorpickerview/ColorPickerView;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 1
    .param p1, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 100
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v0, v0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerViewFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v0}, Landroid/widget/FrameLayout;->removeAllViews()V

    .line 101
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->dialogBinding:Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;

    iget-object v0, v0, Lcom/skydoves/colorpickerview/databinding/DialogColorpickerBinding;->colorPickerViewFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v0, p1}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 102
    return-object p0
.end method

.method public bridge synthetic setCursor(Landroid/database/Cursor;Landroid/content/DialogInterface$OnClickListener;Ljava/lang/String;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setCursor(Landroid/database/Cursor;Landroid/content/DialogInterface$OnClickListener;Ljava/lang/String;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setCursor(Landroid/database/Cursor;Landroid/content/DialogInterface$OnClickListener;Ljava/lang/String;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "cursor"    # Landroid/database/Cursor;
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;
    .param p3, "labelColumn"    # Ljava/lang/String;

    .line 365
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AlertDialog$Builder;->setCursor(Landroid/database/Cursor;Landroid/content/DialogInterface$OnClickListener;Ljava/lang/String;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 366
    return-object p0
.end method

.method public bridge synthetic setCustomTitle(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setCustomTitle(Landroid/view/View;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setCustomTitle(Landroid/view/View;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "customTitleView"    # Landroid/view/View;

    .line 263
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setCustomTitle(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 264
    return-object p0
.end method

.method public bridge synthetic setIcon(I)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setIcon(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setIcon(Landroid/graphics/drawable/Drawable;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setIcon(Landroid/graphics/drawable/Drawable;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setIcon(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "iconId"    # I

    .line 281
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setIcon(I)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 282
    return-object p0
.end method

.method public setIcon(Landroid/graphics/drawable/Drawable;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "icon"    # Landroid/graphics/drawable/Drawable;

    .line 287
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setIcon(Landroid/graphics/drawable/Drawable;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 288
    return-object p0
.end method

.method public bridge synthetic setIconAttribute(I)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setIconAttribute(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setIconAttribute(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "attrId"    # I

    .line 293
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setIconAttribute(I)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 294
    return-object p0
.end method

.method public bridge synthetic setItems(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setItems(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setItems(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "itemsId"    # I
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 347
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setItems(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 348
    return-object p0
.end method

.method public setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "items"    # [Ljava/lang/CharSequence;
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 353
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setItems([Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 354
    return-object p0
.end method

.method public bridge synthetic setMessage(I)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setMessage(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setMessage(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setMessage(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 1
    .param p1, "messageId"    # I

    .line 269
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/content/Context;->getString(I)Ljava/lang/String;

    move-result-object v0

    invoke-super {p0, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 270
    return-object p0
.end method

.method public setMessage(Ljava/lang/CharSequence;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "message"    # Ljava/lang/CharSequence;

    .line 275
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 276
    return-object p0
.end method

.method public bridge synthetic setMultiChoiceItems(I[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setMultiChoiceItems(I[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setMultiChoiceItems(Landroid/database/Cursor;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setMultiChoiceItems(Landroid/database/Cursor;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnMultiChoiceClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setMultiChoiceItems([Ljava/lang/CharSequence;[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setMultiChoiceItems([Ljava/lang/CharSequence;[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setMultiChoiceItems(I[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "itemsId"    # I
    .param p2, "checkedItems"    # [Z
    .param p3, "listener"    # Landroid/content/DialogInterface$OnMultiChoiceClickListener;

    .line 372
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AlertDialog$Builder;->setMultiChoiceItems(I[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 373
    return-object p0
.end method

.method public setMultiChoiceItems(Landroid/database/Cursor;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnMultiChoiceClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "cursor"    # Landroid/database/Cursor;
    .param p2, "isCheckedColumn"    # Ljava/lang/String;
    .param p3, "labelColumn"    # Ljava/lang/String;
    .param p4, "listener"    # Landroid/content/DialogInterface$OnMultiChoiceClickListener;

    .line 389
    invoke-super {p0, p1, p2, p3, p4}, Landroidx/appcompat/app/AlertDialog$Builder;->setMultiChoiceItems(Landroid/database/Cursor;Ljava/lang/String;Ljava/lang/String;Landroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 390
    return-object p0
.end method

.method public setMultiChoiceItems([Ljava/lang/CharSequence;[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "items"    # [Ljava/lang/CharSequence;
    .param p2, "checkedItems"    # [Z
    .param p3, "listener"    # Landroid/content/DialogInterface$OnMultiChoiceClickListener;

    .line 379
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AlertDialog$Builder;->setMultiChoiceItems([Ljava/lang/CharSequence;[ZLandroid/content/DialogInterface$OnMultiChoiceClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 380
    return-object p0
.end method

.method public bridge synthetic setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "textId"    # I
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 179
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 180
    return-object p0
.end method

.method public setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 185
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 186
    return-object p0
.end method

.method public bridge synthetic setNeutralButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setNeutralButton(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setNeutralButton(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "textId"    # I
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 335
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setNeutralButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 336
    return-object p0
.end method

.method public setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 341
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setNeutralButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 342
    return-object p0
.end method

.method public bridge synthetic setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "onCancelListener"    # Landroid/content/DialogInterface$OnCancelListener;

    .line 305
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnCancelListener(Landroid/content/DialogInterface$OnCancelListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 306
    return-object p0
.end method

.method public bridge synthetic setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "onDismissListener"    # Landroid/content/DialogInterface$OnDismissListener;

    .line 311
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnDismissListener(Landroid/content/DialogInterface$OnDismissListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 312
    return-object p0
.end method

.method public bridge synthetic setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "listener"    # Landroid/widget/AdapterView$OnItemSelectedListener;

    .line 422
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnItemSelectedListener(Landroid/widget/AdapterView$OnItemSelectedListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 423
    return-object p0
.end method

.method public bridge synthetic setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "onKeyListener"    # Landroid/content/DialogInterface$OnKeyListener;

    .line 317
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 318
    return-object p0
.end method

.method public bridge synthetic setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "textId"    # I
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 323
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 324
    return-object p0
.end method

.method public setPositiveButton(ILcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 1
    .param p1, "textId"    # I
    .param p2, "colorListener"    # Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 160
    invoke-direct {p0, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getOnClickListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Landroid/content/DialogInterface$OnClickListener;

    move-result-object v0

    invoke-super {p0, p1, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 161
    return-object p0
.end method

.method public setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 329
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 330
    return-object p0
.end method

.method public setPositiveButton(Ljava/lang/CharSequence;Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 1
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "colorListener"    # Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    .line 173
    invoke-direct {p0, p2}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getOnClickListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Landroid/content/DialogInterface$OnClickListener;

    move-result-object v0

    invoke-super {p0, p1, v0}, Landroidx/appcompat/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 174
    return-object p0
.end method

.method public setPreferenceName(Ljava/lang/String;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 1
    .param p1, "preferenceName"    # Ljava/lang/String;

    .line 134
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 135
    invoke-virtual {p0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setPreferenceName(Ljava/lang/String;)V

    .line 137
    :cond_0
    return-object p0
.end method

.method public bridge synthetic setSingleChoiceItems(IILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setSingleChoiceItems(IILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setSingleChoiceItems(Landroid/database/Cursor;ILjava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setSingleChoiceItems(Landroid/database/Cursor;ILjava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setSingleChoiceItems(Landroid/widget/ListAdapter;ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setSingleChoiceItems(Landroid/widget/ListAdapter;ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1, p2, p3}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setSingleChoiceItems(IILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "itemsId"    # I
    .param p2, "checkedItem"    # I
    .param p3, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 395
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AlertDialog$Builder;->setSingleChoiceItems(IILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 396
    return-object p0
.end method

.method public setSingleChoiceItems(Landroid/database/Cursor;ILjava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "cursor"    # Landroid/database/Cursor;
    .param p2, "checkedItem"    # I
    .param p3, "labelColumn"    # Ljava/lang/String;
    .param p4, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 402
    invoke-super {p0, p1, p2, p3, p4}, Landroidx/appcompat/app/AlertDialog$Builder;->setSingleChoiceItems(Landroid/database/Cursor;ILjava/lang/String;Landroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 403
    return-object p0
.end method

.method public setSingleChoiceItems(Landroid/widget/ListAdapter;ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "adapter"    # Landroid/widget/ListAdapter;
    .param p2, "checkedItem"    # I
    .param p3, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 416
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AlertDialog$Builder;->setSingleChoiceItems(Landroid/widget/ListAdapter;ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 417
    return-object p0
.end method

.method public setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "items"    # [Ljava/lang/CharSequence;
    .param p2, "checkedItem"    # I
    .param p3, "listener"    # Landroid/content/DialogInterface$OnClickListener;

    .line 409
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AlertDialog$Builder;->setSingleChoiceItems([Ljava/lang/CharSequence;ILandroid/content/DialogInterface$OnClickListener;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 410
    return-object p0
.end method

.method public bridge synthetic setTitle(I)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setTitle(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setTitle(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setTitle(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "titleId"    # I

    .line 251
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setTitle(I)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 252
    return-object p0
.end method

.method public setTitle(Ljava/lang/CharSequence;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "title"    # Ljava/lang/CharSequence;

    .line 257
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setTitle(Ljava/lang/CharSequence;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 258
    return-object p0
.end method

.method public bridge synthetic setView(I)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setView(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic setView(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;
    .locals 0

    .line 51
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setView(Landroid/view/View;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object p1

    return-object p1
.end method

.method public setView(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "layoutResId"    # I

    .line 428
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setView(I)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 429
    return-object p0
.end method

.method public setView(Landroid/view/View;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    .locals 0
    .param p1, "view"    # Landroid/view/View;

    .line 434
    invoke-super {p0, p1}, Landroidx/appcompat/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroidx/appcompat/app/AlertDialog$Builder;

    .line 435
    return-object p0
.end method
