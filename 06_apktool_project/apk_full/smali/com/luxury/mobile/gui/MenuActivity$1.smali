.class Lcom/luxury/mobile/gui/MenuActivity$1;
.super Ljava/lang/Object;
.source "MenuActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/MenuActivity;->Online()V
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

    .line 91
    iput-object p1, p0, Lcom/luxury/mobile/gui/MenuActivity$1;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    .line 93
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity$1;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/MenuActivity;->lambda$Online$2$MenuActivity()V

    .line 94
    return-void
.end method
