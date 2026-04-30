.class Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$1;
.super Ljava/lang/Object;
.source "ColorPickerDialog.java"

# interfaces
.implements Lcom/skydoves/colorpickerview/listeners/ColorEnvelopeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->onCreate()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;


# direct methods
.method constructor <init>(Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;)V
    .locals 0
    .param p1, "this$0"    # Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    .line 75
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder$1;->this$0:Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onColorSelected(Lcom/skydoves/colorpickerview/ColorEnvelope;Z)V
    .locals 0
    .param p1, "envelope"    # Lcom/skydoves/colorpickerview/ColorEnvelope;
    .param p2, "fromUser"    # Z

    .line 79
    return-void
.end method
