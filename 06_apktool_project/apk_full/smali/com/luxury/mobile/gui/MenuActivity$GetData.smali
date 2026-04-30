.class public Lcom/luxury/mobile/gui/MenuActivity$GetData;
.super Landroid/os/AsyncTask;
.source "MenuActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/luxury/mobile/gui/MenuActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "GetData"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/os/AsyncTask<",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/luxury/mobile/gui/MenuActivity;


# direct methods
.method public constructor <init>(Lcom/luxury/mobile/gui/MenuActivity;)V
    .locals 0
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/MenuActivity;

    .line 148
    iput-object p1, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-direct {p0}, Landroid/os/AsyncTask;-><init>()V

    .line 149
    return-void
.end method


# virtual methods
.method public bridge synthetic doInBackground([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 147
    check-cast p1, [Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/MenuActivity$GetData;->doInBackground([Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public varargs doInBackground([Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p1, "strings"    # [Ljava/lang/String;

    const-string v0, ""

    :try_start_0
    sget-object v1, Lcom/luxury/mobile/gui/MenuActivity;->JSON_URL:Ljava/lang/String;

    invoke-static {v1}, Lcom/luxury/mobile/util/HavanaNet;->fetch(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v1

    invoke-static {v1}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    const-string v1, "HavanaRP-Net"

    invoke-static {v1, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-object v0
.end method

.method public bridge synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    .line 147
    check-cast p1, Ljava/lang/String;

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/MenuActivity$GetData;->onPostExecute(Ljava/lang/String;)V

    return-void
.end method

.method public onPostExecute(Ljava/lang/String;)V
    .locals 7
    .param p1, "s"    # Ljava/lang/String;

    .line 183
    const-string v0, "name"

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-static {v2, v1}, Lcom/luxury/mobile/util/UpdateChecker;->check(Landroid/app/Activity;Lorg/json/JSONObject;)V

    iget-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    invoke-static {v2}, Lcom/luxury/mobile/util/UpdateBanner;->show(Landroid/app/Activity;)V

    .line 184
    .local v1, "jsonObject":Lorg/json/JSONObject;
    iget-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    iget-object v2, v2, Lcom/luxury/mobile/gui/MenuActivity;->textView12:Landroid/widget/TextView;

    invoke-virtual {v1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 185
    iget-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    iget-object v2, v2, Lcom/luxury/mobile/gui/MenuActivity;->textView17:Landroid/widget/TextView;

    const-string v3, "sale"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 186
    const-string v2, "news"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    .line 187
    .local v2, "jsonArray":Lorg/json/JSONArray;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    if-ge v3, v4, :cond_0

    .line 188
    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v4

    .line 189
    .local v4, "jsonObject1":Lorg/json/JSONObject;
    new-instance v5, Lcom/luxury/mobile/gui/CardModel;

    invoke-direct {v5}, Lcom/luxury/mobile/gui/CardModel;-><init>()V

    .line 190
    .local v5, "model":Lcom/luxury/mobile/gui/CardModel;
    const-string v6, "id"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/luxury/mobile/gui/CardModel;->setId(Ljava/lang/String;)V

    .line 191
    invoke-virtual {v4, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/luxury/mobile/gui/CardModel;->setName(Ljava/lang/String;)V

    .line 192
    const-string v6, "image"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Lcom/luxury/mobile/gui/CardModel;->setImage(Ljava/lang/String;)V

    const-string v6, "news_id"

    invoke-virtual {v4, v6}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;)I

    move-result v6

    invoke-virtual {v5, v6}, Lcom/luxury/mobile/gui/CardModel;->setNewsId(I)V

    .line 193
    iget-object v6, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    iget-object v6, v6, Lcom/luxury/mobile/gui/MenuActivity;->cardModelList:Ljava/util/List;

    invoke-interface {v6, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 187
    nop

    .end local v4    # "jsonObject1":Lorg/json/JSONObject;
    .end local v5    # "model":Lcom/luxury/mobile/gui/CardModel;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 197
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "jsonArray":Lorg/json/JSONArray;
    .end local v3    # "i":I
    :cond_0
    goto :goto_1

    .line 195
    :catch_0
    move-exception v0

    .line 196
    .local v0, "e":Ljava/lang/Exception;
    invoke-static {v0}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "Jsson"

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 198
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity$GetData;->this$0:Lcom/luxury/mobile/gui/MenuActivity;

    .line 199
    .local v0, "menuActivity":Lcom/luxury/mobile/gui/MenuActivity;
    iget-object v1, v0, Lcom/luxury/mobile/gui/MenuActivity;->cardModelList:Ljava/util/List;

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/gui/MenuActivity;->PutDataInfo(Ljava/util/List;)V

    .line 200
    return-void
.end method
