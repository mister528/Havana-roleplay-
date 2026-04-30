.class Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask$1;
.super Ljava/lang/Object;
.source "UpdateActivity.java"

# interfaces
.implements Lcom/luxury/mobile/util/HavanaNet$ProgressCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->doInBackground([Ljava/lang/String;)Ljava/io/File;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;)V
    .locals 0

    iput-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask$1;->this$1:Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;

    .line 344
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onProgress(JJ)V
    .locals 3

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask$1;->this$1:Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;

    const/4 v1, 0x2

    new-array v1, v1, [Ljava/lang/Long;

    const/4 v2, 0x0

    .line 347
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    aput-object p1, v1, v2

    const/4 p1, 0x1

    invoke-static {p3, p4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p2

    aput-object p2, v1, p1

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->access$400(Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;[Ljava/lang/Object;)V

    return-void
.end method
