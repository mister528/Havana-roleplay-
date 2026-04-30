.class Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;
.super Ljava/lang/Object;
.source "ColorPickerDialog.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getOnClickListener(Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Landroid/content/DialogInterface$OnClickListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

.field final synthetic val$colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;


# direct methods
.method constructor <init>(Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)V
    .locals 0
    .param p1, "this$0"    # Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    .line 190
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    iput-object p2, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->val$colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 3
    .param p1, "dialogInterface"    # Landroid/content/DialogInterface;
    .param p2, "i"    # I

    .line 193
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->val$colorListener:Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;

    instance-of v1, v0, Lcom/skydoves/colorpickerview/listeners/ColorListener;

    const/4 v2, 0x1

    if-eqz v1, :cond_0

    .line 194
    check-cast v0, Lcom/skydoves/colorpickerview/listeners/ColorListener;

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v1

    invoke-interface {v0, v1, v2}, Lcom/skydoves/colorpickerview/listeners/ColorListener;->onColorSelected(IZ)V

    goto :goto_0

    .line 195
    :cond_0
    instance-of v1, v0, Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;

    if-eqz v1, :cond_1

    .line 196
    check-cast v0, Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    .line 197
    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColorEnvelope()Lcom/skydoves/colorpickerview/ColorEnvelope;

    move-result-object v1

    invoke-interface {v0, v1, v2}, Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;->onColorSelected(Lcom/skydoves/colorpickerview/ColorEnvelope;Z)V

    .line 199
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 200
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->getInstance(Landroid/content/Context;)Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;

    move-result-object v0

    iget-object v1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    .line 201
    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/preference/ColorPickerPreferenceManager;->saveColorPickerData(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 203
    :cond_2
    return-void
.end method
