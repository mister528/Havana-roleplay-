.class Lcom/luxury/mobile/gui/NewsActivity$1;
.super Ljava/lang/Object;
.source "NewsActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/NewsActivity;->buildContentView()Landroid/view/View;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/NewsActivity;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/NewsActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/luxury/mobile/gui/NewsActivity$1;->this$0:Lcom/luxury/mobile/gui/NewsActivity;

    .line 93
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    iget-object p1, p0, Lcom/luxury/mobile/gui/NewsActivity$1;->this$0:Lcom/luxury/mobile/gui/NewsActivity;

    .line 96
    invoke-virtual {p1}, Lcom/luxury/mobile/gui/NewsActivity;->finish()V

    return-void
.end method
