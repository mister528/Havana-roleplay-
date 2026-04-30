.class public Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
.super Ljava/lang/Object;
.source "ColorPickerPreferenceManager.java"


# static fields
.field protected static final AlphaSlider:Ljava/lang/String; = "_SLIDER_ALPHA"

.field protected static final BrightnessSlider:Ljava/lang/String; = "_SLIDER_BRIGHTNESS"

.field protected static final COLOR:Ljava/lang/String; = "_COLOR"

.field protected static final SelectorX:Ljava/lang/String; = "_SELECTOR_X"

.field protected static final SelectorY:Ljava/lang/String; = "_SELECTOR_Y"

.field private static colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;


# instance fields
.field private sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 41
    nop

    .line 42
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 43
    return-void
.end method

.method public static getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 52
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    if-nez v0, :cond_0

    .line 53
    new-instance v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    invoke-direct {v0, p0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 54
    :cond_0
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method


# virtual methods
.method public clearSavedAllData()Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 1

    .line 243
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->clear()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 244
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public clearSavedAlphaSliderPosition(Ljava/lang/String;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 159
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getAlphaSliderName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 160
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public clearSavedBrightnessSlider(Ljava/lang/String;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 194
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getBrightnessSliderName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 195
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public clearSavedColor(Ljava/lang/String;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 87
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getColorName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 88
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public clearSavedSelectorPosition(Ljava/lang/String;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 124
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorXName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 125
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorYName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 126
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method protected getAlphaSliderName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 260
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_SLIDER_ALPHA"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getAlphaSliderPosition(Ljava/lang/String;I)I
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "defaultPosition"    # I

    .line 149
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getAlphaSliderName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method protected getBrightnessSliderName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 264
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_SLIDER_BRIGHTNESS"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getBrightnessSliderPosition(Ljava/lang/String;I)I
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "defaultPosition"    # I

    .line 184
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getBrightnessSliderName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public getColor(Ljava/lang/String;I)I
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "defaultColor"    # I

    .line 77
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getColorName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method protected getColorName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 248
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_COLOR"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getSelectorPosition(Ljava/lang/String;Landroid/graphics/Point;)Landroid/graphics/Point;
    .locals 5
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "defaultPoint"    # Landroid/graphics/Point;

    .line 112
    new-instance v0, Landroid/graphics/Point;

    iget-object v1, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 113
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorXName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iget v3, p2, Landroid/graphics/Point;->x:I

    invoke-interface {v1, v2, v3}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v1

    iget-object v2, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    .line 114
    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorYName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget v4, p2, Landroid/graphics/Point;->y:I

    invoke-interface {v2, v3, v4}, Landroid/content/SharedPreferences;->getInt(Ljava/lang/String;I)I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/graphics/Point;-><init>(II)V

    .line 112
    return-object v0
.end method

.method protected getSelectorXName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 252
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_SELECTOR_X"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method protected getSelectorYName(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;

    .line 256
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "_SELECTOR_Y"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public restoreColorPickerData(Lcom/skydoves/colorpickerview/ColorPickerView;)V
    .locals 5
    .param p1, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 224
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 225
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    .line 226
    .local v0, "name":Ljava/lang/String;
    const/4 v1, -0x1

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getColor(Ljava/lang/String;I)I

    move-result v2

    invoke-virtual {p1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->setPureColor(I)V

    .line 227
    new-instance v2, Landroid/graphics/Point;

    .line 229
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredWidth()I

    move-result v3

    div-int/lit8 v3, v3, 0x2

    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getMeasuredHeight()I

    move-result v4

    div-int/lit8 v4, v4, 0x2

    invoke-direct {v2, v3, v4}, Landroid/graphics/Point;-><init>(II)V

    .line 230
    .local v2, "defaultPoint":Landroid/graphics/Point;
    nop

    .line 231
    invoke-virtual {p0, v0, v2}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorPosition(Ljava/lang/String;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v3

    iget v3, v3, Landroid/graphics/Point;->x:I

    .line 232
    invoke-virtual {p0, v0, v2}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorPosition(Ljava/lang/String;Landroid/graphics/Point;)Landroid/graphics/Point;

    move-result-object v4

    iget v4, v4, Landroid/graphics/Point;->y:I

    .line 233
    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getColor(Ljava/lang/String;I)I

    move-result v1

    .line 230
    invoke-virtual {p1, v3, v4, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->moveSelectorPoint(III)V

    .line 235
    .end local v0    # "name":Ljava/lang/String;
    .end local v2    # "defaultPoint":Landroid/graphics/Point;
    :cond_0
    return-void
.end method

.method public saveColorPickerData(Lcom/skydoves/colorpickerview/ColorPickerView;)V
    .locals 2
    .param p1, "colorPickerView"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 204
    if-eqz p1, :cond_1

    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 205
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getPreferenceName()Ljava/lang/String;

    move-result-object v0

    .line 206
    .local v0, "name":Ljava/lang/String;
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->setColor(Ljava/lang/String;I)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 207
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getSelectedPoint()Landroid/graphics/Point;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->setSelectorPosition(Ljava/lang/String;Landroid/graphics/Point;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 209
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 210
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getAlphaSlideBar()Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/sliders/AlphaSlideBar;->getSelectedX()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->setAlphaSliderPosition(Ljava/lang/String;I)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 212
    :cond_0
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 213
    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getBrightnessSlider()Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/sliders/BrightnessSlideBar;->getSelectedX()I

    move-result v1

    invoke-virtual {p0, v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->setBrightnessSliderPosition(Ljava/lang/String;I)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    .line 216
    .end local v0    # "name":Ljava/lang/String;
    :cond_1
    return-void
.end method

.method public setAlphaSliderPosition(Ljava/lang/String;I)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "position"    # I

    .line 137
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getAlphaSliderName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 138
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public setBrightnessSliderPosition(Ljava/lang/String;I)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "position"    # I

    .line 172
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getBrightnessSliderName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 173
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public setColor(Ljava/lang/String;I)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "color"    # I

    .line 65
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getColorName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1, p2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 66
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method

.method public setSelectorPosition(Ljava/lang/String;Landroid/graphics/Point;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .param p2, "position"    # Landroid/graphics/Point;

    .line 99
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorXName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget v2, p2, Landroid/graphics/Point;->x:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 100
    iget-object v0, p0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-virtual {p0, p1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getSelectorYName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iget v2, p2, Landroid/graphics/Point;->y:I

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    .line 101
    sget-object v0, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->colorPickerPreferenceManager:Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    return-object v0
.end method
