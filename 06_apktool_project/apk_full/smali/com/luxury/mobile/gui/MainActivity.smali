.class public Lcom/luxury/mobile/gui/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;
    }
.end annotation


# static fields
.field private static final PERMISSION_STORAGE:I = 0x65


# instance fields
.field button_install:Landroid/widget/ImageButton;

.field imageButton11:Landroid/widget/ImageButton;

.field imageView14:Landroid/widget/ImageView;

.field imageView15:Landroid/widget/ImageView;

.field textView:Landroid/widget/TextView;

.field textView15:Landroid/widget/TextView;

.field textView27:Landroid/widget/TextView;

.field textView28:Landroid/widget/TextView;

.field textView29:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 25
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method public static getAvailableGameInMB()J
    .locals 5

    .line 146
    new-instance v0, Landroid/os/StatFs;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v2, "/LuxuryMobile"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 147
    .local v0, "stat":Landroid/os/StatFs;
    invoke-virtual {v0}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v1

    int-to-long v1, v1

    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockSize()I

    move-result v3

    int-to-long v3, v3

    mul-long v1, v1, v3

    const-wide/32 v3, 0x100000

    div-long/2addr v1, v3

    return-wide v1
.end method

.method public static getAvailableSpaceInMB()J
    .locals 5

    .line 141
    new-instance v0, Landroid/os/StatFs;

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 142
    .local v0, "stat":Landroid/os/StatFs;
    invoke-virtual {v0}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v1

    int-to-long v1, v1

    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockSize()I

    move-result v3

    int-to-long v3, v3

    mul-long v1, v1, v3

    const-wide/32 v3, 0x100000

    div-long/2addr v1, v3

    return-wide v1
.end method


# virtual methods
.method public BGCoreNative_isInternetConnected(Landroid/content/Context;)Z
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 89
    const-string v0, "connectivity"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 90
    .local v0, "netInfo":Landroid/net/NetworkInfo;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnectedOrConnecting()Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 93
    :cond_0
    const/4 v1, 0x1

    return v1

    .line 91
    :cond_1
    :goto_0
    const/4 v1, 0x0

    return v1
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .line 127
    const/16 v0, 0x65

    if-ne p1, v0, :cond_0

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1e

    if-lt v0, v1, :cond_0

    invoke-static {p0}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->hasPermissions(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 128
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const/4 v1, 0x0

    const-string v2, "\u0623\u0639\u0637\u0650 \u0627\u0644\u0625\u0630\u0646!"

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 130
    :cond_0
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 131
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 7
    .param p1, "v"    # Landroid/view/View;

    .line 66
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    .line 67
    .local v0, "id":I
    const v1, 0x7f090077

    if-eq v0, v1, :cond_0

    .line 68
    const v1, 0x7f090138

    if-ne v0, v1, :cond_3

    .line 69
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/MainActivity;->finishAndRemoveTask()V

    goto :goto_0

    .line 71
    :cond_0
    invoke-static {p0}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->hasPermissions(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_2

    .line 72
    const-wide/16 v1, 0x1324

    invoke-static {}, Lcom/luxury/mobile/gui/MainActivity;->getAvailableSpaceInMB()J

    move-result-wide v3

    const/4 v5, 0x0

    cmp-long v6, v1, v3

    if-gez v6, :cond_1

    .line 73
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/luxury/mobile/gui/InstallActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 74
    invoke-virtual {p0, v5, v5}, Lcom/luxury/mobile/gui/MainActivity;->overridePendingTransition(II)V

    .line 75
    return-void

    .line 77
    :cond_1
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->imageView14:Landroid/widget/ImageView;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 78
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->imageView15:Landroid/widget/ImageView;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 79
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->textView27:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 80
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->textView28:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 81
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->textView29:Landroid/widget/TextView;

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setVisibility(I)V

    .line 82
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->imageButton11:Landroid/widget/ImageButton;

    invoke-virtual {v1, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    goto :goto_0

    .line 83
    :cond_2
    invoke-static {p0}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->hasPermissions(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_3

    .line 84
    const/16 v1, 0x65

    invoke-static {p0, v1}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->requestPermissions(Landroid/app/Activity;I)V

    .line 86
    :cond_3
    :goto_0
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 6
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 39
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 40
    const v0, 0x7f0c001d

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->setContentView(I)V

    .line 41
    const v0, 0x7f090077

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->button_install:Landroid/widget/ImageButton;

    .line 42
    const v0, 0x7f090230

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->textView:Landroid/widget/TextView;

    .line 43
    const v0, 0x7f09014a

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->imageView14:Landroid/widget/ImageView;

    .line 44
    const v0, 0x7f09014b

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->imageView15:Landroid/widget/ImageView;

    .line 45
    const v0, 0x7f090242

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->textView27:Landroid/widget/TextView;

    .line 46
    const v0, 0x7f090243

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->textView28:Landroid/widget/TextView;

    .line 47
    const v0, 0x7f090244

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->textView29:Landroid/widget/TextView;

    .line 48
    const v0, 0x7f090138

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    .line 49
    .local v0, "imageButton":Landroid/widget/ImageButton;
    iput-object v0, p0, Lcom/luxury/mobile/gui/MainActivity;->imageButton11:Landroid/widget/ImageButton;

    .line 50
    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 51
    iget-object v1, p0, Lcom/luxury/mobile/gui/MainActivity;->button_install:Landroid/widget/ImageButton;

    invoke-virtual {v1, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 52
    invoke-static {p0}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->hasPermissions(Landroid/content/Context;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 54
    const-wide/16 v1, 0x5dc

    :try_start_0
    invoke-static {}, Lcom/luxury/mobile/gui/MainActivity;->getAvailableGameInMB()J

    move-result-wide v3

    cmp-long v5, v1, v3

    if-gez v5, :cond_0

    .line 55
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/luxury/mobile/gui/MenuActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/MainActivity;->startActivity(Landroid/content/Intent;)V

    .line 56
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v1}, Lcom/luxury/mobile/gui/MainActivity;->overridePendingTransition(II)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 58
    :catch_0
    move-exception v1

    .line 59
    :cond_0
    :goto_0
    goto :goto_1

    .line 60
    :cond_1
    invoke-static {p0}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->hasPermissions(Landroid/content/Context;)Z

    move-result v1

    if-nez v1, :cond_2

    .line 61
    const/16 v1, 0x65

    invoke-static {p0, v1}, Lcom/luxury/mobile/gui/MainActivity$PermissionUtils;->requestPermissions(Landroid/app/Activity;I)V

    .line 63
    :cond_2
    :goto_1
    return-void
.end method

.method public onRequestPermissionsResult(I[Ljava/lang/String;[I)V
    .locals 3
    .param p1, "requestCode"    # I
    .param p2, "permissions"    # [Ljava/lang/String;
    .param p3, "grantResults"    # [I

    .line 134
    const/16 v0, 0x65

    if-ne p1, v0, :cond_1

    array-length v0, p3

    const/4 v1, 0x0

    if-lez v0, :cond_0

    aget v0, p3, v1

    if-eqz v0, :cond_1

    .line 135
    :cond_0
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v2, "\u0623\u0639\u0637\u0650 \u0627\u0644\u0625\u0630\u0646!"

    invoke-static {v0, v2, v1}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 137
    :cond_1
    invoke-super {p0, p1, p2, p3}, Landroidx/appcompat/app/AppCompatActivity;->onRequestPermissionsResult(I[Ljava/lang/String;[I)V

    .line 138
    return-void
.end method
