.class Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;
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

    .line 330
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 5
    .param p1, "view"    # Landroid/view/View;

    .line 334
    new-instance v0, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    iget-object v1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;

    invoke-static {v1}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;->access$000(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment;)Lcom/nvidia/devtech/NvEventQueueActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 335
    const-string v1, "color5"

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setPreferenceName(Ljava/lang/String;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8$2;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8$2;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;)V

    .line 336
    const-string v2, "\u062a\u0637\u0628\u064a\u0642"

    invoke-virtual {v0, v2, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Lcom/skydoves/colorpickerview/listeners/ColorPickerViewListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    new-instance v1, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8$1;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8$1;-><init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$8;)V

    .line 345
    const-string v2, "\u0625\u063a\u0644\u0627\u0642"

    invoke-virtual {v0, v2, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setNegativeButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 352
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->attachAlphaSlideBar(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 353
    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->attachBrightnessSlideBar(Z)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 354
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->setBottomSpace(I)Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;

    move-result-object v0

    .line 356
    .local v0, "dialog":Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v2

    invoke-virtual {v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    check-cast v2, Landroid/widget/FrameLayout$LayoutParams;

    .line 358
    .local v2, "params":Landroid/widget/FrameLayout$LayoutParams;
    iget v3, v2, Landroid/widget/FrameLayout$LayoutParams;->height:I

    int-to-float v3, v3

    const/high16 v4, 0x3e800000    # 0.25f

    mul-float v3, v3, v4

    float-to-int v3, v3

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->height:I

    .line 359
    iget v3, v2, Landroid/widget/FrameLayout$LayoutParams;->width:I

    int-to-float v3, v3

    mul-float v3, v3, v4

    float-to-int v3, v3

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->width:I

    .line 360
    const/16 v3, 0xa

    iput v3, v2, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    .line 361
    iput v1, v2, Landroid/widget/FrameLayout$LayoutParams;->bottomMargin:I

    .line 364
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->getColorPickerView()Lcom/skydoves/colorpickerview/ColorPickerView;

    move-result-object v1

    invoke-virtual {v1, v2}, Lcom/skydoves/colorpickerview/ColorPickerView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 365
    invoke-virtual {v0}, Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;->show()Landroidx/appcompat/app/AlertDialog;

    .line 367
    return-void
.end method
