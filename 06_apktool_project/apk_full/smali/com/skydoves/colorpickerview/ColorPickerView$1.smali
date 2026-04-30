.class Lcom/skydoves/colorpickerview/ColorPickerView$1;
.super Ljava/lang/Object;
.source "ColorPickerView.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/skydoves/colorpickerview/ColorPickerView;->onCreate()V
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

    .line 200
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$1;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onGlobalLayout()V
    .locals 2

    .line 203
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x10

    if-ge v0, v1, :cond_0

    .line 204
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$1;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeGlobalOnLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    goto :goto_0

    .line 206
    :cond_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$1;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->getViewTreeObserver()Landroid/view/ViewTreeObserver;

    move-result-object v0

    invoke-virtual {v0, p0}, Landroid/view/ViewTreeObserver;->removeOnGlobalLayoutListener(Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;)V

    .line 208
    :goto_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$1;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    invoke-static {v0}, Lcom/skydoves/colorpickerview/ColorPickerView;->access$000(Lcom/skydoves/colorpickerview/ColorPickerView;)V

    .line 209
    return-void
.end method
