.class public Lcom/luxury/mobile/gui/MenuActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MenuActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;,
        Lcom/luxury/mobile/gui/MenuActivity$GetData;
    }
.end annotation


# static fields
.field public static JSON_URL:Ljava/lang/String;


# instance fields
.field cardModelList:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/luxury/mobile/gui/CardModel;",
            ">;"
        }
    .end annotation
.end field

.field imageButton2:Landroid/widget/ImageButton;

.field imageView13:Landroid/widget/ImageView;

.field imageView9:Landroid/widget/ImageView;

.field play:Landroid/widget/ImageButton;

.field recyclerView:Landroidx/recyclerview/widget/RecyclerView;

.field textView12:Landroid/widget/TextView;

.field textView13:Landroid/widget/TextView;

.field textView14:Landroid/widget/TextView;

.field textView15:Landroid/widget/TextView;

.field textView17:Landroid/widget/TextView;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 39
    const-string v0, "https://havanarpapo.zya.me/pars.json"

    sput-object v0, Lcom/luxury/mobile/gui/MenuActivity;->JSON_URL:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 37
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method

.method private static havanaDelDir(Ljava/io/File;)V
    .locals 5
    .param p0, "root"    # Ljava/io/File;

    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_1

    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    if-eqz v0, :cond_1

    array-length v1, v0

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    aget-object v3, v0, v2

    invoke-static {v3}, Lcom/luxury/mobile/gui/MenuActivity;->havanaDelDir(Ljava/io/File;)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    invoke-virtual {p0}, Ljava/io/File;->delete()Z

    return-void
.end method


# virtual methods
.method public BGCoreNative_isInternetConnected(Landroid/content/Context;)Z
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 140
    const-string v0, "connectivity"

    invoke-virtual {p1, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    .line 141
    .local v0, "netInfo":Landroid/net/NetworkInfo;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnectedOrConnecting()Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    .line 144
    :cond_0
    const/4 v1, 0x1

    return v1

    .line 142
    :cond_1
    :goto_0
    const/4 v1, 0x0

    return v1
.end method

.method public Online()V
    .locals 2

    .line 90
    invoke-virtual {p0, p0}, Lcom/luxury/mobile/gui/MenuActivity;->BGCoreNative_isInternetConnected(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 91
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/luxury/mobile/gui/MenuActivity$1;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/gui/MenuActivity$1;-><init>(Lcom/luxury/mobile/gui/MenuActivity;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 95
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 96
    return-void

    .line 98
    :cond_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView15:Landroid/widget/TextView;

    const-string v1, "\u062a\u062d\u0642\u0642 \u0645\u0646 \u0627\u0644\u0627\u062a\u0635\u0627\u0644"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 99
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView9:Landroid/widget/ImageView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 100
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView13:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 101
    return-void
.end method

.method public PutDataInfo(Ljava/util/List;)V
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/luxury/mobile/gui/CardModel;",
            ">;)V"
        }
    .end annotation

    .line 205
    .local p1, "cardModelList2":Ljava/util/List;, "Ljava/util/List<Lcom/luxury/mobile/gui/CardModel;>;"
    new-instance v0, Lcom/luxury/mobile/gui/AdapterCard;

    invoke-direct {v0, p0, p1}, Lcom/luxury/mobile/gui/AdapterCard;-><init>(Landroid/content/Context;Ljava/util/List;)V

    .line 206
    .local v0, "adapter":Lcom/luxury/mobile/gui/AdapterCard;
    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v2, Landroidx/recyclerview/widget/LinearLayoutManager;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3, v3}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;IZ)V

    invoke-virtual {v1, v2}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    .line 207
    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v2, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;

    invoke-direct {v2}, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;-><init>()V

    invoke-virtual {v1, v2}, Landroidx/recyclerview/widget/RecyclerView;->addItemDecoration(Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;)V

    .line 208
    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    invoke-virtual {v1, v0}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    .line 209
    return-void
.end method

.method public lambda$Online$0$MenuActivity([Ljava/lang/String;)V
    .locals 3
    .param p1, "serverInfo"    # [Ljava/lang/String;

    .line 125
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView13:Landroid/widget/TextView;

    const/4 v1, 0x1

    aget-object v1, p1, v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 126
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView14:Landroid/widget/TextView;

    .line 127
    .local v0, "textView":Landroid/widget/TextView;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x2

    aget-object v2, p1, v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, " \u0644\u0627\u0639\u0628\u064a\u0646"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 128
    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView15:Landroid/widget/TextView;

    const-string v2, "\u0627\u0644\u062e\u0627\u062f\u0645 \u064a\u0639\u0645\u0644"

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 129
    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView9:Landroid/widget/ImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 130
    iget-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView13:Landroid/widget/ImageView;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 131
    return-void
.end method

.method public lambda$Online$1$MenuActivity()V
    .locals 2

    .line 134
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView15:Landroid/widget/TextView;

    const-string v1, "\u0627\u0644\u062e\u0627\u062f\u0645 \u063a\u064a\u0631 \u0645\u062a\u0627\u062d"

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 135
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView9:Landroid/widget/ImageView;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 136
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView13:Landroid/widget/ImageView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 137
    return-void
.end method

.method public lambda$Online$2$MenuActivity()V
    .locals 4

    .line 104
    new-instance v0, Lcom/luxury/mobile/gui/SampQuery;

    const-string v1, "94.23.168.153"

    const/16 v2, 0xb0a

    invoke-direct {v0, v1, v2}, Lcom/luxury/mobile/gui/SampQuery;-><init>(Ljava/lang/String;I)V

    .line 106
    .local v0, "query":Lcom/luxury/mobile/gui/SampQuery;
    :try_start_0
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/SampQuery;->connect()Z

    .line 107
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/SampQuery;->getInfo()[Ljava/lang/String;

    move-result-object v1

    .line 108
    .local v1, "serverInfo":[Ljava/lang/String;
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/SampQuery;->getPing()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;

    move-result-object v2

    .line 109
    .local v2, "valueOf":Ljava/lang/String;
    new-instance v3, Lcom/luxury/mobile/gui/MenuActivity$2;

    invoke-direct {v3, p0, v1}, Lcom/luxury/mobile/gui/MenuActivity$2;-><init>(Lcom/luxury/mobile/gui/MenuActivity;[Ljava/lang/String;)V

    invoke-virtual {p0, v3}, Lcom/luxury/mobile/gui/MenuActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 114
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/SampQuery;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 121
    .end local v1    # "serverInfo":[Ljava/lang/String;
    .end local v2    # "valueOf":Ljava/lang/String;
    goto :goto_0

    .line 115
    :catch_0
    move-exception v1

    .line 116
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Lcom/luxury/mobile/gui/MenuActivity$3;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/gui/MenuActivity$3;-><init>(Lcom/luxury/mobile/gui/MenuActivity;)V

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/MenuActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 122
    .end local v1    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 4
    .param p1, "v"    # Landroid/view/View;

    .line 76
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    .line 77
    .local v0, "id":I
    const v1, 0x7f090079

    if-ne v0, v1, :cond_1

    sget-boolean v1, Lcom/luxury/mobile/util/UpdateChecker;->updateRequired:Z

    if-eqz v1, :cond_0

    const-string v1, "\u064a\u062c\u0628 \u062a\u062d\u062f\u064a\u062b \u0627\u0644\u0644\u0627\u0646\u0634\u0631 \u0644\u0644\u062f\u062e\u0648\u0644 \u0625\u0644\u0649 \u0627\u0644\u0633\u064a\u0631\u0641\u0631"

    const/4 v2, 0x1

    invoke-static {p0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    return-void

    .line 78
    :cond_0
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/luxury/mobile/core/GTASA;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 79
    .local v1, "intent":Landroid/content/Intent;
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/MenuActivity;->getIntent()Landroid/content/Intent;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/content/Intent;->putExtras(Landroid/content/Intent;)Landroid/content/Intent;

    .line 80
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "StartActivity GTASA.class"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 81
    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/MenuActivity;->startActivity(Landroid/content/Intent;)V

    .line 82
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/MenuActivity;->finish()V

    .end local v1    # "intent":Landroid/content/Intent;
    goto :goto_0

    .line 83
    :cond_1
    const v1, 0x7f09013b

    if-ne v0, v1, :cond_2

    .line 84
    new-instance v1, Landroid/content/Intent;

    const-class v2, Lcom/luxury/mobile/gui/SettingsActivity;

    invoke-direct {v1, p0, v2}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/MenuActivity;->startActivity(Landroid/content/Intent;)V

    .line 85
    const/4 v1, 0x0

    invoke-virtual {p0, v1, v1}, Lcom/luxury/mobile/gui/MenuActivity;->overridePendingTransition(II)V

    goto :goto_1

    .line 83
    :cond_2
    :goto_0
    nop

    .line 87
    :goto_1
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 54
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    :try_start_0
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v0

    new-instance v1, Ljava/io/File;

    const-string v2, "LuxuryMobile/texdb/flin_gui"

    invoke-direct {v1, v0, v2}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    invoke-static {v1}, Lcom/luxury/mobile/gui/MenuActivity;->havanaDelDir(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 55
    :goto_0
    const v0, 0x7f0c001e

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->setContentView(I)V

    .line 56
    const v0, 0x7f0901a8

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/recyclerview/widget/RecyclerView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    .line 57
    const v0, 0x7f090233

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView12:Landroid/widget/TextView;

    .line 58
    const v0, 0x7f090237

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView17:Landroid/widget/TextView;

    .line 59
    const v0, 0x7f090234

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView13:Landroid/widget/TextView;

    .line 60
    const v0, 0x7f090235

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView14:Landroid/widget/TextView;

    .line 61
    const v0, 0x7f090236

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->textView15:Landroid/widget/TextView;

    .line 62
    const v0, 0x7f090154

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView9:Landroid/widget/ImageView;

    .line 63
    const v0, 0x7f090149

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageView13:Landroid/widget/ImageView;

    .line 64
    const v0, 0x7f09013b

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    .line 65
    .local v0, "imageButton":Landroid/widget/ImageButton;
    iput-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity;->imageButton2:Landroid/widget/ImageButton;

    .line 66
    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 67
    const v1, 0x7f090079

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/MenuActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    .line 68
    .local v1, "imageButton3":Landroid/widget/ImageButton;
    iput-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity;->play:Landroid/widget/ImageButton;

    .line 69
    invoke-virtual {v1, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 70
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity;->cardModelList:Ljava/util/List;

    .line 71
    new-instance v2, Lcom/luxury/mobile/gui/MenuActivity$GetData;

    invoke-direct {v2, p0}, Lcom/luxury/mobile/gui/MenuActivity$GetData;-><init>(Lcom/luxury/mobile/gui/MenuActivity;)V

    const/4 v3, 0x0

    new-array v3, v3, [Ljava/lang/String;

    invoke-virtual {v2, v3}, Lcom/luxury/mobile/gui/MenuActivity$GetData;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    .line 72
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/MenuActivity;->Online()V

    .line 73
    return-void
.end method
