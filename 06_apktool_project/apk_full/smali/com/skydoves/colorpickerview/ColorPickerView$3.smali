.class Lcom/skydoves/colorpickerview/ColorPickerView$3;
.super Ljava/lang/Object;
.source "ColorPickerView.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/skydoves/colorpickerview/ColorPickerView;->setInitialColor(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

.field final synthetic val$color:I


# direct methods
.method constructor <init>(Lcom/skydoves/colorpickerview/ColorPickerView;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/skydoves/colorpickerview/ColorPickerView;

    .line 646
    iput-object p1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$3;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    iput p2, p0, Lcom/skydoves/colorpickerview/ColorPickerView$3;->val$color:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 650
    :try_start_0
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorPickerView$3;->this$0:Lcom/skydoves/colorpickerview/ColorPickerView;

    iget v1, p0, Lcom/skydoves/colorpickerview/ColorPickerView$3;->val$color:I

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->selectByHsvColor(I)V
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0

    .line 653
    goto :goto_0

    .line 651
    :catch_0
    move-exception v0

    .line 652
    .local v0, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 654
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    :goto_0
    return-void
.end method
