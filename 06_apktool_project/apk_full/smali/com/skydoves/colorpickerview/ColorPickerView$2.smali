.class Lcom/skydoves/colorpickerview/ColorPickerView$2;
.super Ljava/lang/Object;
.source "ColorPickerView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/skydoves/colorpickerview/ColorPickerView;->notifyColorChanged()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/skydoves/colorpickerview/ColorPickerView;


# direct methods
.method constructor <init>(Lcom/skydoves/colorpickerview/ColorPickerView;)V
    .locals 0
    .param p1, "this$0"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 319
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .line 322
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getColor()I

    move-result v1

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->fireColorListener(IZ)V

    .line 323
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$2;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-static {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->access$1700(Lcom/skydoves/colorpickerview/ColorPickerView;)Landroid/graphics/Point;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->access$1800(Lcom/skydoves/colorpickerview/ColorPickerView;Landroid/graphics/Point;)V

    .line 324
    return-void
.end method
