.class final Lcom/luxury/mobile/gui/NewsActivity$FetchTask;
.super Landroid/os/AsyncTask;
.source "NewsActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/luxury/mobile/gui/NewsActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x12
    name = "FetchTask"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/Integer;",
        "Ljava/lang/Void;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/NewsActivity;


# direct methods
.method private constructor <init>(Lcom/luxury/mobile/gui/NewsActivity;)V
    .locals 0

    iput-object p1, p0, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;->this$0:Lcom/luxury/mobile/gui/NewsActivity;

    .line 276
    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/luxury/mobile/gui/NewsActivity;Lcom/luxury/mobile/gui/NewsActivity$1;)V
    .locals 0

    .line 276
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;-><init>(Lcom/luxury/mobile/gui/NewsActivity;)V

    return-void
.end method


# virtual methods
.method protected varargs doInBackground([Ljava/lang/Integer;)Ljava/lang/Object;
    .locals 2

    const-string v0, "https://havanarpapo.zya.me/api/news.php?id="

    .line 280
    :try_start_0
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x0

    aget-object p1, p1, v0

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 281
    invoke-static {p1}, Lcom/luxury/mobile/util/HavanaNet;->fetch(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 282
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p1, "ok"

    .line 283
    invoke-virtual {v1, p1, v0}, Lorg/json/JSONObject;->optBoolean(Ljava/lang/String;Z)Z

    move-result p1

    if-nez p1, :cond_0

    const-string p1, "error"

    const-string v0, "load_failed"

    .line 284
    invoke-virtual {v1, p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1

    :cond_0
    const-string p1, "news"

    .line 286
    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p1

    :catchall_0
    move-exception p1

    .line 288
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    goto :goto_0

    :cond_1
    const-string p1, "network_error"

    :goto_0
    return-object p1
.end method

.method protected bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 276
    check-cast p1, [Ljava/lang/Integer;

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;->doInBackground([Ljava/lang/Integer;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method protected onPostExecute(Ljava/lang/Object;)V
    .locals 1

    .line 294
    instance-of v0, p1, Lorg/json/JSONObject;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;->this$0:Lcom/luxury/mobile/gui/NewsActivity;

    .line 295
    check-cast p1, Lorg/json/JSONObject;

    invoke-static {v0, p1}, Lcom/luxury/mobile/gui/NewsActivity;->access$100(Lcom/luxury/mobile/gui/NewsActivity;Lorg/json/JSONObject;)V

    goto :goto_1

    .line 297
    :cond_0
    instance-of v0, p1, Ljava/lang/String;

    if-eqz v0, :cond_1

    check-cast p1, Ljava/lang/String;

    goto :goto_0

    :cond_1
    const-string p1, "\u062a\u0639\u0630\u0651\u0631 \u062a\u062d\u0645\u064a\u0644 \u0627\u0644\u062e\u0628\u0631"

    :goto_0
    const-string v0, "not_found"

    .line 298
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    const-string p1, "\u0647\u0630\u0627 \u0627\u0644\u062e\u0628\u0631 \u063a\u064a\u0631 \u0645\u0648\u062c\u0648\u062f."

    :cond_2
    const-string v0, "load_failed"

    .line 299
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string p1, "\u062a\u0639\u0630\u0651\u0631 \u062a\u062d\u0645\u064a\u0644 \u0627\u0644\u062e\u0628\u0631."

    :cond_3
    iget-object v0, p0, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;->this$0:Lcom/luxury/mobile/gui/NewsActivity;

    .line 300
    invoke-static {v0, p1}, Lcom/luxury/mobile/gui/NewsActivity;->access$200(Lcom/luxury/mobile/gui/NewsActivity;Ljava/lang/String;)V

    :goto_1
    return-void
.end method
