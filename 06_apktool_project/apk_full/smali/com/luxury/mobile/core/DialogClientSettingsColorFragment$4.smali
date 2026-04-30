.class Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;
.super Ljava/lang/Object;
.source "DialogClientSettingsColorFragment.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->onCreateView(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Landroid/os/Bundle;)Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    .line 175
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4
    .param p1, "view"    # Landroid/view/View;

    .line 179
    new-instance v0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-static {v1}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 180
    const-string v1, "color1"

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setPreferenceName(Ljava/lang/String;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4$2;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4$2;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;)V

    .line 181
    const-string v2, "\u062a\u0637\u0628\u064a\u0642"

    invoke-virtual {v0, v2, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4$1;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$4;)V

    .line 190
    const-string v2, "\u0625\u063a\u0644\u0627\u0642"

    invoke-virtual {v0, v2, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 197
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->attachAlphaSlideBar(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 198
    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->attachBrightnessSlideBar(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 199
    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setBottomSpace(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 201
    .local v0, "dialog":Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v1

    check-cast v1, Landroid/widget/FrameLayout$LayoutParams;

    .line 203
    .local v1, "params":Landroid/widget/FrameLayout$LayoutParams;
    iget v2, v1, Landroid/widget/FrameLayout$LayoutParams;->height:I

    int-to-float v2, v2

    const/high16 v3, 0x3e800000    # 0.25f

    mul-float v2, v2, v3

    float-to-int v2, v2

    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->height:I

    .line 204
    iget v2, v1, Landroid/widget/FrameLayout$LayoutParams;->width:I

    int-to-float v2, v2

    mul-float v2, v2, v3

    float-to-int v2, v2

    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->width:I

    .line 205
    const/16 v2, 0xa

    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    .line 206
    const/4 v2, 0x0

    iput v2, v1, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    .line 208
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/skydoves/colorpickerview/ColorPickerView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 209
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->show()Landroidx/appcompat/app/AlertDialog;

    .line 211
    return-void
.end method
