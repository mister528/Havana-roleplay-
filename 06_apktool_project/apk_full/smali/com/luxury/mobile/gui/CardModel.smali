.class public Lcom/luxury/mobile/gui/CardModel;
.super Ljava/lang/Object;
.source "CardModel.java"


# instance fields
.field f114id:Ljava/lang/String;

.field image:Ljava/lang/String;

.field name:Ljava/lang/String;

.field newsId:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 6
    iget-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->f114id:Ljava/lang/String;

    iput-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->f114id:Ljava/lang/String;

    .line 7
    iget-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->image:Ljava/lang/String;

    iput-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->image:Ljava/lang/String;

    .line 8
    iget-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->name:Ljava/lang/String;

    iput-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->name:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public getId()Ljava/lang/String;
    .locals 1

    .line 11
    iget-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->f114id:Ljava/lang/String;

    return-object v0
.end method

.method public getImage()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->image:Ljava/lang/String;

    return-object v0
.end method

.method public getName()Ljava/lang/String;
    .locals 1

    .line 19
    iget-object v0, p0, Lcom/luxury/mobile/gui/CardModel;->name:Ljava/lang/String;

    return-object v0
.end method

.method public getNewsId()I
    .locals 1

    iget v0, p0, Lcom/luxury/mobile/gui/CardModel;->newsId:I

    return v0
.end method

.method public setId(Ljava/lang/String;)V
    .locals 0
    .param p1, "id"    # Ljava/lang/String;

    .line 15
    iput-object p1, p0, Lcom/luxury/mobile/gui/CardModel;->f114id:Ljava/lang/String;

    .line 16
    return-void
.end method

.method public setImage(Ljava/lang/String;)V
    .locals 0
    .param p1, "image2"    # Ljava/lang/String;

    .line 31
    iput-object p1, p0, Lcom/luxury/mobile/gui/CardModel;->image:Ljava/lang/String;

    .line 32
    return-void
.end method

.method public setName(Ljava/lang/String;)V
    .locals 0
    .param p1, "name2"    # Ljava/lang/String;

    .line 23
    iput-object p1, p0, Lcom/luxury/mobile/gui/CardModel;->name:Ljava/lang/String;

    .line 24
    return-void
.end method

.method public setNewsId(I)V
    .locals 0
    .param p1, "newsId2"    # I

    iput p1, p0, Lcom/luxury/mobile/gui/CardModel;->newsId:I

    return-void
.end method
