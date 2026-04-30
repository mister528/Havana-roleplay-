.class public final synthetic Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;
.super Ljava/lang/Object;
.source "lambda"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field public final synthetic f$0:Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

.field public final synthetic f$1:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;


# direct methods
.method public synthetic constructor <init>(Lcom/luxury/mobile/gui/dialogs/DialogAdapter;Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;->f$0:Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

    iput-object p2, p0, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;->f$1:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;

    return-void
.end method


# virtual methods
.method public final onClick(Landroid/view/View;)V
    .locals 2

    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;->f$0:Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;->f$1:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;

    invoke-virtual {v0, v1, p1}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->lambda$onBindViewHolder$0$DialogAdapter(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;Landroid/view/View;)V

    return-void
.end method
