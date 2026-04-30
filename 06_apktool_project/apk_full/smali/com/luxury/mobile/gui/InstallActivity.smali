.class public Lcom/luxury/mobile/gui/InstallActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "InstallActivity.java"


# instance fields
.field private final link:Ljava/lang/String;

.field public final path_zip:Ljava/lang/String;

.field progressBar:Landroid/widget/ProgressBar;

.field progressBarInstall:Landroid/widget/ProgressBar;

.field textView6:Landroid/widget/TextView;

.field textView7:Landroid/widget/TextView;

.field textview5:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 2

    .line 25
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    .line 26
    const-string v0, ""

    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->link:Ljava/lang/String;

    .line 28
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Landroid/os/Environment;->DIRECTORY_DOWNLOADS:Ljava/lang/String;

    invoke-static {v1}, Landroid/os/Environment;->getExternalStoragePublicDirectory(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v1, "/luxury.zip"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->path_zip:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/gui/InstallActivity;II)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/InstallActivity;
    .param p1, "x1"    # I
    .param p2, "x2"    # I

    .line 25
    invoke-direct {p0, p1, p2}, Lcom/luxury/mobile/gui/InstallActivity;->lambda$run$0$InstallActivity$1(II)V

    return-void
.end method

.method static synthetic access$100(Lcom/luxury/mobile/gui/InstallActivity;)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/InstallActivity;

    .line 25
    invoke-direct {p0}, Lcom/luxury/mobile/gui/InstallActivity;->lambda$run$1$InstallActivity$1()V

    return-void
.end method

.method private lambda$run$0$InstallActivity$1(II)V
    .locals 6
    .param p1, "finalChet"    # I
    .param p2, "length"    # I

    .line 159
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textView7:Landroid/widget/TextView;

    .line 160
    .local v0, "textView":Landroid/widget/TextView;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/high16 v2, 0x100000

    div-int v3, p1, v2

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, " MB \u0645\u0646 "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    div-int v3, p2, v2

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v3, " MB"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 161
    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity;->textView6:Landroid/widget/TextView;

    .line 162
    .local v1, "textView2":Landroid/widget/TextView;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 163
    .local v3, "sb":Ljava/lang/StringBuilder;
    div-int v4, p1, v2

    mul-int/lit8 v4, v4, 0x64

    div-int v5, p2, v2

    div-int/2addr v4, v5

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 164
    const-string v4, "%"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 165
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 166
    iget-object v4, p0, Lcom/luxury/mobile/gui/InstallActivity;->progressBarInstall:Landroid/widget/ProgressBar;

    div-int v5, p1, v2

    mul-int/lit8 v5, v5, 0x64

    div-int v2, p2, v2

    div-int/2addr v5, v2

    invoke-virtual {v4, v5}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 167
    return-void
.end method

.method private lambda$run$1$InstallActivity$1()V
    .locals 2

    .line 151
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textview5:Landroid/widget/TextView;

    const-string v1, "\u062c\u0627\u0631\u064d \u0641\u0643 \u0636\u063a\u0637 \u0645\u0644\u0641\u0627\u062a \u0627\u0644\u0644\u0639\u0628\u0629..."

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 152
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textView6:Landroid/widget/TextView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 153
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textView7:Landroid/widget/TextView;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 154
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->progressBarInstall:Landroid/widget/ProgressBar;

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 155
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->progressBar:Landroid/widget/ProgressBar;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    .line 156
    return-void
.end method


# virtual methods
.method public UnZip()V
    .locals 2

    .line 171
    :try_start_0
    new-instance v0, Lnet/lingala/zip4j/core/ZipFile;

    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity;->path_zip:Ljava/lang/String;

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/core/ZipFile;-><init>(Ljava/lang/String;)V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/core/ZipFile;->extractAll(Ljava/lang/String;)V

    .line 172
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity;->path_zip:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_0

    .line 175
    goto :goto_0

    .line 173
    :catch_0
    move-exception v0

    .line 174
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    invoke-virtual {v0}, Lnet/lingala/zip4j/exception/ZipException;->printStackTrace()V

    .line 176
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    :goto_0
    :try_start_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/luxury/mobile/service/DownloadNotifyService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->stopService(Landroid/content/Intent;)Z
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v0

    :goto_1
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/luxury/mobile/gui/MenuActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->startActivity(Landroid/content/Intent;)V

    .line 177
    const/4 v0, 0x0

    invoke-virtual {p0, v0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->overridePendingTransition(II)V

    .line 178
    return-void
.end method

.method public getFileSize(Ljava/lang/String;)V
    .locals 2
    .param p1, "string"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 56
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/luxury/mobile/gui/InstallActivity$1;

    invoke-direct {v1, p0, p1}, Lcom/luxury/mobile/gui/InstallActivity$1;-><init>(Lcom/luxury/mobile/gui/InstallActivity;Ljava/lang/String;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 147
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 148
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 37
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    invoke-virtual {p0}, Lcom/luxury/mobile/gui/InstallActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x80

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/luxury/mobile/service/DownloadNotifyService;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    :try_start_0
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1a

    if-lt v1, v2, :cond_0

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->startForegroundService(Landroid/content/Intent;)Landroid/content/ComponentName;

    goto :goto_0

    :cond_0
    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->startService(Landroid/content/Intent;)Landroid/content/ComponentName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :goto_0
    goto :goto_1

    :catch_0
    move-exception v0

    .line 38
    :goto_1
    const v0, 0x7f0c001c

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->setContentView(I)V

    .line 39
    const v0, 0x7f090248

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textview5:Landroid/widget/TextView;

    .line 40
    const v0, 0x7f09024a

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textView7:Landroid/widget/TextView;

    .line 41
    const v0, 0x7f090249

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->textView6:Landroid/widget/TextView;

    .line 42
    const v0, 0x7f09019f

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/InstallActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ProgressBar;

    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 43
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v2, "/LuxuryMobile"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 44
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 45
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 47
    :cond_1
    const v1, 0x7f0901a1

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/InstallActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ProgressBar;

    iput-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity;->progressBarInstall:Landroid/widget/ProgressBar;

    .line 49
    :try_start_1
    const-string v1, "https://www.dropbox.com/scl/fi/o0pfmhdjb9cire57l6ign/luxury.zip?rlkey=39w2xrir3833jhhbgtnxfd40v&st=r129oxug&dl=1"

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/InstallActivity;->getFileSize(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 52
    goto :goto_2

    .line 50
    :catch_1
    move-exception v1

    .line 51
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 53
    .end local v1    # "e":Ljava/io/IOException;
    :goto_2
    return-void
.end method
