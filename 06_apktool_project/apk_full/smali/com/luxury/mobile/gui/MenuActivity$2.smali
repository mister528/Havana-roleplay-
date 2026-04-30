.class Lcom/luxury/mobile/gui/MenuActivity$2;
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

.field final synthetic val$serverInfo:[Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/MenuActivity;[Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/MenuActivity;

    .line 109
    iput-object p1, p0, Lcom/luxury/mobile/gui/MenuActivity$2;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    iput-object p2, p0, Lcom/luxury/mobile/gui/MenuActivity$2;->val$serverInfo:[Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    .line 111
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity$2;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity$2;->val$serverInfo:[Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/gui/MenuActivity;->lambda$Online$0$MenuActivity([Ljava/lang/String;)V

    .line 112
    return-void
.end method
