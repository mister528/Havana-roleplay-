.class public Lcom/skydoves/colorpickerview/ColorPickerDialog;
.super Landroidx/appcompat/app/AlertDialog;
.source "ColorPickerDialog.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/skydoves/colorpickerview/ColorPickerDialog$Builder;
    }
.end annotation


# instance fields
.field private colorPickerView:Lcom/skydoves/colorpickerview/ColorPickerView;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 47
    invoke-direct {p0, p1}, Landroidx/appcompat/app/AlertDialog;-><init>(Landroid/content/Context;)V

    .line 48
    return-void
.end method
