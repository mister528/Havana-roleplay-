.class public final synthetic Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$NoDmBZ66k09NPVdr4SIhP2r-oFs;
.super Ljava/lang/Object;
.source "lambda"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Lcom/luxury/mobile/gui/dialogs/DialogAdapter;


# direct methods
.method public synthetic constructor <init>(Lcom/luxury/mobile/gui/dialogs/DialogAdapter;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$NoDmBZ66k09NPVdr4SIhP2r-oFs;->f$0:Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$Dialog$NoDmBZ66k09NPVdr4SIhP2r-oFs;->f$0:Lcom/luxury/mobile/gui/dialogs/DialogAdapter;

    invoke-static {v0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->lambda$show$6(Lcom/luxury/mobile/gui/dialogs/DialogAdapter;)V

    return-void
.end method
