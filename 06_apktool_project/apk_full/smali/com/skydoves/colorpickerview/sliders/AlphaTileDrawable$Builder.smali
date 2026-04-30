.class public Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;
.super Ljava/lang/Object;
.source "AlphaTileDrawable.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private tileEvenColor:I

.field private tileOddColor:I

.field private tileSize:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 105
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 106
    const/16 v0, 0x19

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileSize:I

    .line 107
    const/4 v0, -0x1

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileOddColor:I

    .line 108
    const v0, -0x343435

    iput v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileEvenColor:I

    return-void
.end method

.method static synthetic access$000(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;

    .line 105
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileSize:I

    return v0
.end method

.method static synthetic access$100(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;

    .line 105
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileOddColor:I

    return v0
.end method

.method static synthetic access$200(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)I
    .locals 1
    .param p0, "x0"    # Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;

    .line 105
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileEvenColor:I

    return v0
.end method


# virtual methods
.method public build()Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;
    .locals 1

    .line 138
    new-instance v0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;

    invoke-direct {v0, p0}, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable;-><init>(Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;)V

    return-object v0
.end method

.method public getTileEvenColor()I
    .locals 1

    .line 129
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileEvenColor:I

    return v0
.end method

.method public getTileOddColor()I
    .locals 1

    .line 120
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileOddColor:I

    return v0
.end method

.method public getTileSize()I
    .locals 1

    .line 111
    iget v0, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileSize:I

    return v0
.end method

.method public setTileEvenColor(I)Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;
    .locals 0
    .param p1, "color"    # I

    .line 133
    iput p1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileEvenColor:I

    .line 134
    return-object p0
.end method

.method public setTileOddColor(I)Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;
    .locals 0
    .param p1, "color"    # I

    .line 124
    iput p1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileOddColor:I

    .line 125
    return-object p0
.end method

.method public setTileSize(I)Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;
    .locals 0
    .param p1, "tileSize"    # I

    .line 115
    iput p1, p0, Lcom/skydoves/colorpickerview/sliders/AlphaTileDrawable$Builder;->tileSize:I

    .line 116
    return-object p0
.end method
