.class final Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;
.super Ljava/lang/Object;
.source "ColorPickerPreference.kt"

# interfaces
.implements Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/skydoves/colorpickerpreference/ColorPickerPreference;->onInit()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    bv = {
        0x1,
        0x0,
        0x3
    }
    d1 = {
        "\u0000\u0018\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u000e\u0010\u0002\u001a\n \u0004*\u0004\u0018\u00010\u00030\u00032\u0006\u0010\u0005\u001a\u00020\u0006H\n\u00a2\u0006\u0002\u0008\u0007\u00a8\u0006\u0008"
    }
    d2 = {
        "<anonymous>",
        "",
        "envelope",
        "Lcom/skydoves/colorpickerview/ColorEnvelope;",
        "kotlin.jvm.PlatformType",
        "<anonymous parameter 1>",
        "",
        "onColorSelected",
        "com/skydoves/colorpickerpreference/ColorPickerPreference$onInit$1$1"
    }
    k = 0x3
    mv = {
        0x1,
        0x4,
        0x0
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;


# direct methods
.method constructor <init>(Lcom/skydoves/colorpickerpreference/ColorPickerPreference;)V
    .locals 0

    iput-object p1, p0, Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;->this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final onColorSelected(Lcom/skydoves/colorpickerview/ColorEnvelope;Z)V
    .locals 3
    .param p1, "envelope"    # Lcom/skydoves/colorpickerview/ColorEnvelope;
    .param p2, "$noName_1"    # Z

    .line 115
    iget-object v0, p0, Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;->this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;

    invoke-static {v0}, Lcom/skydoves/colorpickerpreference/ColorPickerPreference;->access$getColorBox$p(Lcom/skydoves/colorpickerpreference/ColorPickerPreference;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    instance-of v0, v0, Landroid/graphics/drawable/GradientDrawable;

    if-eqz v0, :cond_1

    .line 116
    iget-object v0, p0, Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;->this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;

    invoke-static {v0}, Lcom/skydoves/colorpickerpreference/ColorPickerPreference;->access$getColorBox$p(Lcom/skydoves/colorpickerpreference/ColorPickerPreference;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v0

    if-eqz v0, :cond_0

    check-cast v0, Landroid/graphics/drawable/GradientDrawable;

    const-string v1, "envelope"

    invoke-static {p1, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorEnvelope;->getColor()I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 117
    iget-object v0, p0, Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;->this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;

    invoke-static {v0, p1}, Lcom/skydoves/colorpickerpreference/ColorPickerPreference;->access$notifyColorChanged(Lcom/skydoves/colorpickerpreference/ColorPickerPreference;Lcom/skydoves/colorpickerview/ColorEnvelope;)V

    .line 118
    nop

    .line 122
    nop

    .line 118
    nop

    .line 121
    nop

    .line 118
    nop

    .line 120
    nop

    .line 118
    nop

    .line 119
    nop

    .line 118
    iget-object v0, p0, Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;->this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerpreference/ColorPickerPreference;->getPreferenceManager()Landroidx/preference/PreferenceManager;

    move-result-object v0

    const-string v1, "preferenceManager"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0}, Landroidx/preference/PreferenceManager;->getSharedPreferences()Landroid/content/SharedPreferences;

    move-result-object v0

    .line 120
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 121
    iget-object v1, p0, Lcom/skydoves/colorpickerpreference/ColorPickerPreference$onInit$$inlined$apply$lambda$1;->this$0:Lcom/skydoves/colorpickerpreference/ColorPickerPreference;

    invoke-virtual {v1}, Lcom/skydoves/colorpickerpreference/ColorPickerPreference;->getKey()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1}, Lcom/skydoves/colorpickerview/ColorEnvelope;->getColor()I

    move-result v2

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences$Editor;->putInt(Ljava/lang/String;I)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 122
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    goto :goto_0

    .line 116
    :cond_0
    new-instance v0, Ljava/lang/NullPointerException;

    const-string v1, "null cannot be cast to non-null type android.graphics.drawable.GradientDrawable"

    invoke-direct {v0, v1}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 124
    :cond_1
    :goto_0
    return-void
.end method
