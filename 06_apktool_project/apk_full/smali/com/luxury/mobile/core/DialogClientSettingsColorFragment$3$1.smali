.class Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3$1;
.super Ljava/lang/Object;
.source "DialogClientSettingsColorFragment.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;->onClick(Landroid/view/View;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;)V
    .locals 0
    .param p1, "this$1"    # Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;

    .line 152
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3$1;->this$1:Lcom/luxury/mobile/core/DialogClientSettingsColorFragment$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0
    .param p1, "dialogInterface"    # Landroid/content/DialogInterface;
    .param p2, "i"    # I

    .line 155
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 156
    return-void
.end method
