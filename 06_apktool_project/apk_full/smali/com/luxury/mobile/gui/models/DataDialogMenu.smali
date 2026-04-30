.class public Lcom/luxury/mobile/gui/models/DataDialogMenu;
.super Ljava/lang/Object;
.source "DataDialogMenu.java"


# instance fields
.field private id:I

.field private imgDrawableButton:I

.field private nameButton:Ljava/lang/String;


# direct methods
.method public constructor <init>(IILjava/lang/String;)V
    .locals 0
    .param p1, "i"    # I
    .param p2, "i2"    # I
    .param p3, "str"    # Ljava/lang/String;

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput p1, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->id:I

    .line 10
    iput p2, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->imgDrawableButton:I

    .line 11
    iput-object p3, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->nameButton:Ljava/lang/String;

    .line 12
    return-void
.end method


# virtual methods
.method public getId()I
    .locals 1

    .line 31
    iget v0, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->id:I

    return v0
.end method

.method public getImgDrawableButton()I
    .locals 1

    .line 15
    iget v0, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->imgDrawableButton:I

    return v0
.end method

.method public getNameButton()Ljava/lang/String;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->nameButton:Ljava/lang/String;

    return-object v0
.end method

.method public setId(I)V
    .locals 0
    .param p1, "i"    # I

    .line 35
    iput p1, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->id:I

    .line 36
    return-void
.end method

.method public setImgDrawableButton(I)V
    .locals 0
    .param p1, "i"    # I

    .line 19
    iput p1, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->imgDrawableButton:I

    .line 20
    return-void
.end method

.method public setNameButton(Ljava/lang/String;)V
    .locals 0
    .param p1, "str"    # Ljava/lang/String;

    .line 27
    iput-object p1, p0, Lcom/luxury/mobile/gui/models/DataDialogMenu;->nameButton:Ljava/lang/String;

    .line 28
    return-void
.end method
