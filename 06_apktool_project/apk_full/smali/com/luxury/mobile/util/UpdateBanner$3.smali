.class Lcom/luxury/mobile/util/UpdateBanner$3;
.super Ljava/lang/Object;
.source "UpdateBanner.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/util/UpdateBanner;->attach(Landroid/app/Activity;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 118
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 0

    .line 127
    invoke-static {p1}, Lcom/luxury/mobile/util/UpdateBanner;->access$100(Landroid/view/View;)Landroid/app/Activity;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 129
    invoke-static {p1}, Lcom/luxury/mobile/util/UpdateChecker;->openManually(Landroid/app/Activity;)V

    :cond_0
    return-void
.end method
