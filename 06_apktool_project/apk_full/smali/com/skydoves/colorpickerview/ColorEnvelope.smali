.class public Lcom/skydoves/colorpickerview/ColorEnvelope;
.super Ljava/lang/Object;
.source "ColorEnvelope.java"


# instance fields
.field private argb:[I

.field private color:I

.field private hexCode:Ljava/lang/String;


# direct methods
.method public constructor <init>(I)V
    .locals 1
    .param p1, "color"    # I

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 30
    iput p1, p0, Lcom/skydoves/colorpickerview/ColorEnvelope;->color:I

    .line 31
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorUtils;->getHexCode(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorEnvelope;->hexCode:Ljava/lang/String;

    .line 32
    invoke-static {p1}, Lcom/skydoves/colorpickerview/ColorUtils;->getColorARGB(I)[I

    move-result-object v0

    iput-object v0, p0, Lcom/skydoves/colorpickerview/ColorEnvelope;->argb:[I

    .line 33
    return-void
.end method


# virtual methods
.method public getArgb()[I
    .locals 1

    .line 59
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorEnvelope;->argb:[I

    return-object v0
.end method

.method public getColor()I
    .locals 1

    .line 41
    iget v0, p0, Lcom/skydoves/colorpickerview/ColorEnvelope;->color:I

    return v0
.end method

.method public getHexCode()Ljava/lang/String;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/skydoves/colorpickerview/ColorEnvelope;->hexCode:Ljava/lang/String;

    return-object v0
.end method
