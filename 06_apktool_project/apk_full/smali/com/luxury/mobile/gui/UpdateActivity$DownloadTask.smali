.class final Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;
.super Landroid/os/AsyncTask;
.source "UpdateActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/luxury/mobile/gui/UpdateActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "DownloadTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/Long;",
        "Ljava/io/File;",
        ">;"
    }
.end annotation


# instance fields
.field private volatile error:Ljava/lang/Throwable;

.field final synthetic this$0:Lcom/luxury/mobile/gui/UpdateActivity;


# direct methods
.method private constructor <init>(Lcom/luxury/mobile/gui/UpdateActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 334
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/luxury/mobile/gui/UpdateActivity;Lcom/luxury/mobile/gui/UpdateActivity$1;)V
    .locals 0

    .line 334
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;-><init>(Lcom/luxury/mobile/gui/UpdateActivity;)V

    return-void
.end method

.method static synthetic access$400(Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;[Ljava/lang/Object;)V
    .locals 0

    .line 334
    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->publishProgress([Ljava/lang/Object;)V

    return-void
.end method


# virtual methods
.method protected varargs doInBackground([Ljava/lang/String;)Ljava/io/File;
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 340
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/UpdateActivity;->getExternalCacheDir()Ljava/io/File;

    move-result-object v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 341
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/UpdateActivity;->getCacheDir()Ljava/io/File;

    move-result-object v0

    .line 342
    :cond_0
    new-instance v1, Ljava/io/File;

    const-string v2, "HavanaRp_update.apk"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 343
    aget-object p1, p1, v0

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    new-instance v2, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask$1;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask$1;-><init>(Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;)V

    invoke-static {p1, v0, v2}, Lcom/luxury/mobile/util/HavanaNet;->downloadTo(Ljava/lang/String;Ljava/lang/String;Lcom/luxury/mobile/util/HavanaNet$ProgressCallback;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v1

    :catchall_0
    move-exception p1

    iput-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->error:Ljava/lang/Throwable;

    const/4 p1, 0x0

    return-object p1
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 334
    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->doInBackground([Ljava/lang/String;)Ljava/io/File;

    move-result-object p1

    return-object p1
.end method

.method protected onPostExecute(Ljava/io/File;)V
    .locals 3

    if-nez p1, :cond_2

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    const/4 v0, 0x0

    .line 375
    invoke-static {p1, v0}, Lcom/luxury/mobile/gui/UpdateActivity;->access$102(Lcom/luxury/mobile/gui/UpdateActivity;Z)Z

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 376
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$900(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/Button;

    move-result-object p1

    const/4 v1, 0x1

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 377
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$900(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/Button;

    move-result-object p1

    const-string v1, "\u0625\u0639\u0627\u062f\u0629 \u0627\u0644\u0645\u062d\u0627\u0648\u0644\u0629"

    invoke-virtual {p1, v1}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 378
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$300(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/ProgressBar;

    move-result-object p1

    const/16 v1, 0x8

    invoke-virtual {p1, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 379
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$600(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 380
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$1000(Lcom/luxury/mobile/gui/UpdateActivity;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$1100(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object p1

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    :cond_0
    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 381
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$800(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "\u0641\u0634\u0644 \u0627\u0644\u062a\u062d\u0645\u064a\u0644"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->error:Ljava/lang/Throwable;

    if-eqz v1, :cond_1

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "  \u2022  "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->error:Ljava/lang/Throwable;

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_1
    const-string v1, ""

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_2
    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 384
    invoke-static {v0}, Lcom/luxury/mobile/gui/UpdateActivity;->access$800(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object v0

    const-string v1, "\u062a\u0645 \u0627\u0644\u062a\u062d\u0645\u064a\u0644\u060c \u062c\u0627\u0631\u064d \u0641\u062a\u062d \u0627\u0644\u0645\u062b\u0628\u0651\u062a\u2026"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 385
    invoke-static {v0, p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$1200(Lcom/luxury/mobile/gui/UpdateActivity;Ljava/io/File;)V

    return-void
.end method

.method protected bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .line 334
    check-cast p1, Ljava/io/File;

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->onPostExecute(Ljava/io/File;)V

    return-void
.end method

.method protected varargs onProgressUpdate([Ljava/lang/Long;)V
    .locals 6

    const/4 v0, 0x0

    .line 359
    aget-object v0, p1, v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const/4 v2, 0x1

    .line 360
    aget-object p1, p1, v2

    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long p1, v2, v4

    if-lez p1, :cond_0

    const-wide/16 v4, 0x3e8

    mul-long v4, v4, v0

    .line 362
    div-long/2addr v4, v2

    long-to-int p1, v4

    iget-object v4, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 363
    invoke-static {v4, p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$500(Lcom/luxury/mobile/gui/UpdateActivity;I)V

    .line 364
    div-int/lit8 p1, p1, 0xa

    iget-object v4, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 365
    invoke-static {v4}, Lcom/luxury/mobile/gui/UpdateActivity;->access$600(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string p1, "%"

    invoke-virtual {v5, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v4, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 366
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$800(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$700(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " / "

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {v2, v3}, Lcom/luxury/mobile/gui/UpdateActivity;->access$700(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    :cond_0
    iget-object p1, p0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->this$0:Lcom/luxury/mobile/gui/UpdateActivity;

    .line 368
    invoke-static {p1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$800(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;

    move-result-object p1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/UpdateActivity;->access$700(J)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "  \u2022  \u062c\u0627\u0631\u064d \u0627\u0644\u062a\u062d\u0645\u064a\u0644\u2026"

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_0
    return-void
.end method

.method protected bridge synthetic onProgressUpdate([Ljava/lang/Object;)V
    .locals 0

    .line 334
    check-cast p1, [Ljava/lang/Long;

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->onProgressUpdate([Ljava/lang/Long;)V

    return-void
.end method
