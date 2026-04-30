.class Lcom/luxury/mobile/gui/MenuActivity$3;
.super Ljava/lang/Object;
.source "MenuActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/MenuActivity;->lambda$Online$2$MenuActivity()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/MenuActivity;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/MenuActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/MenuActivity;

    .line 116
    iput-object p1, p0, Lcom/luxury/mobile/gui/MenuActivity$3;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 118
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity$3;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/MenuActivity;->lambda$Online$1$MenuActivity()V

    .line 119
    return-void
.end method
