.class public final Lcom/luxury/mobile/util/NewsClickListener;
.super Ljava/lang/Object;
.source "NewsClickListener.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field private final context:Landroid/content/Context;

.field private final newsId:I


# direct methods
.method public constructor <init>(Landroid/content/Context;I)V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/luxury/mobile/util/NewsClickListener;->context:Landroid/content/Context;

    iput p2, p0, Lcom/luxury/mobile/util/NewsClickListener;->newsId:I

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 2

    iget-object p1, p0, Lcom/luxury/mobile/util/NewsClickListener;->context:Landroid/content/Context;

    if-eqz p1, :cond_1

    iget p1, p0, Lcom/luxury/mobile/util/NewsClickListener;->newsId:I

    if-gtz p1, :cond_0

    goto :goto_0

    .line 24
    :cond_0
    :try_start_0
    new-instance p1, Landroid/content/Intent;

    iget-object v0, p0, Lcom/luxury/mobile/util/NewsClickListener;->context:Landroid/content/Context;

    const-class v1, Lcom/luxury/mobile/gui/NewsActivity;

    invoke-direct {p1, v0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    const-string v0, "news_id"

    iget v1, p0, Lcom/luxury/mobile/util/NewsClickListener;->newsId:I

    .line 25
    invoke-virtual {p1, v0, v1}, Landroid/content/Intent;->putExtra(Ljava/lang/String;I)Landroid/content/Intent;

    const/high16 v0, 0x10000000

    .line 26
    invoke-virtual {p1, v0}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    iget-object v0, p0, Lcom/luxury/mobile/util/NewsClickListener;->context:Landroid/content/Context;

    .line 27
    invoke-virtual {v0, p1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    :cond_1
    :goto_0
    return-void
.end method
