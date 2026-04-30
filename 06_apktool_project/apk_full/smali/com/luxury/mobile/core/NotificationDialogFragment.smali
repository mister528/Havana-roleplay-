.class public Lcom/luxury/mobile/core/NotificationDialogFragment;
.super Landroidx/fragment/app/DialogFragment;
.source "NotificationDialogFragment.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Landroidx/fragment/app/DialogFragment;-><init>()V

    return-void
.end method


# virtual methods
.method public onCreateDialog(Landroid/os/Bundle;)Landroid/app/Dialog;
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 13
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-virtual {p0}, Lcom/luxury/mobile/core/NotificationDialogFragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 14
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    const-string v1, "\u0644\u062a\u0637\u0628\u064a\u0642 \u0648\u0636\u0639 \u0627\u0644\u0634\u0627\u0634\u0629 \u0627\u0644\u0643\u0627\u0645\u0644\u0629 \u064a\u062c\u0628 \u0625\u0639\u0627\u062f\u0629 \u0627\u0644\u062f\u062e\u0648\u0644 \u0625\u0644\u0649 \u0627\u0644\u0644\u0639\u0628\u0629"

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(Ljava/lang/CharSequence;)Landroid/app/AlertDialog$Builder;

    move-result-object v1

    new-instance v2, Lcom/luxury/mobile/core/NotificationDialogFragment$1;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/core/NotificationDialogFragment$1;-><init>(Lcom/luxury/mobile/core/NotificationDialogFragment;)V

    .line 15
    const-string v3, "\u0625\u063a\u0644\u0627\u0642"

    invoke-virtual {v1, v3, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(Ljava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 20
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    return-object v1
.end method
