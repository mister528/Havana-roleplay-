.class Lcom/luxury/mobile/util/UpdateBanner$1;
.super Ljava/lang/Object;
.source "UpdateBanner.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/util/UpdateBanner;->show(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic val$activity:Landroid/app/Activity;


# direct methods
.method constructor <init>(Landroid/app/Activity;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    iput-object p1, p0, Lcom/luxury/mobile/util/UpdateBanner$1;->val$activity:Landroid/app/Activity;

    .line 35
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 1

    iget-object v0, p0, Lcom/luxury/mobile/util/UpdateBanner$1;->val$activity:Landroid/app/Activity;

    .line 38
    invoke-static {v0}, Lcom/luxury/mobile/util/UpdateBanner;->access$000(Landroid/app/Activity;)V

    return-void
.end method
