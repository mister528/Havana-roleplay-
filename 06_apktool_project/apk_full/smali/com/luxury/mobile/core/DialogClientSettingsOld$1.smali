.class Lcom/luxury/mobile/core/DialogClientSettingsOld$1;
.super Ljava/lang/Object;
.source "DialogClientSettingsOld.java"

# interfaces
.implements Landroid/view/ViewTreeObserver$OnGlobalLayoutListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/core/DialogClientSettingsOld;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/core/DialogClientSettingsOld;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/core/DialogClientSettingsOld;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/core/DialogClientSettingsOld;

    .line 141
    iput-object p1, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsOld;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onGlobalLayout()V
    .locals 2

    .line 144
    iget-object v0, p0, Lcom/luxury/mobile/core/DialogClientSettingsOld$1;->this$0:Lcom/luxury/mobile/core/DialogClientSettingsOld;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/luxury/mobile/core/DialogClientSettingsOld;->access$002(Lcom/luxury/mobile/core/DialogClientSettingsOld;Z)Z

    .line 145
    return-void
.end method
