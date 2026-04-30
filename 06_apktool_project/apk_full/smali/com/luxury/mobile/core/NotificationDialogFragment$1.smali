.class Lcom/luxury/mobile/core/NotificationDialogFragment$1;
.super Ljava/lang/Object;
.source "NotificationDialogFragment.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/NotificationDialogFragment;->onCreateDialog(Landroid/os/Bundle;)Landroid/app/Dialog;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/NotificationDialogFragment;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/NotificationDialogFragment;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/NotificationDialogFragment;

    .line 15
    iput-object p1, p0, Lcom/luxury/mobile/core/NotificationDialogFragment$1;->this$0:Lcom/luxury/mobile/core/NotificationDialogFragment;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "id"    # I

    .line 18
    return-void
.end method
