.class Lcom/luxury/mobile/gui/InstallActivity$1$1;
.super Ljava/lang/Object;
.source "InstallActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/InstallActivity$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/luxury/mobile/gui/InstallActivity$1;

.field final synthetic val$finalChet:I

.field final synthetic val$length:I


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/InstallActivity$1;II)V
    .locals 0
    .param p1, "this$1"    # Lcom/luxury/mobile/gui/InstallActivity$1;

    .line 81
    iput-object p1, p0, Lcom/luxury/mobile/gui/InstallActivity$1$1;->this$1:Lcom/luxury/mobile/gui/InstallActivity$1;

    iput p2, p0, Lcom/luxury/mobile/gui/InstallActivity$1$1;->val$finalChet:I

    iput p3, p0, Lcom/luxury/mobile/gui/InstallActivity$1$1;->val$length:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 3

    .line 83
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity$1$1;->this$1:Lcom/luxury/mobile/gui/InstallActivity$1;

    iget-object v0, v0, Lcom/luxury/mobile/gui/InstallActivity$1;->this$0:Lcom/luxury/mobile/gui/InstallActivity;

    iget v1, p0, Lcom/luxury/mobile/gui/InstallActivity$1$1;->val$finalChet:I

    iget v2, p0, Lcom/luxury/mobile/gui/InstallActivity$1$1;->val$length:I

    invoke-static {v0, v1, v2}, Lcom/luxury/mobile/gui/InstallActivity;->access$000(Lcom/luxury/mobile/gui/InstallActivity;II)V

    .line 84
    return-void
.end method
