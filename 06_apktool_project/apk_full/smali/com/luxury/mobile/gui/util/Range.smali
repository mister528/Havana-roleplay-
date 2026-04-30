.class public Lcom/luxury/mobile/gui/util/Range;
.super Ljava/lang/Object;
.source "Range.java"


# instance fields
.field private end:I

.field private start:I


# direct methods
.method constructor <init>()V
    .locals 1

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 4
    const/4 v0, -0x1

    iput v0, p0, Lcom/luxury/mobile/gui/util/Range;->end:I

    .line 5
    iput v0, p0, Lcom/luxury/mobile/gui/util/Range;->start:I

    .line 8
    return-void
.end method


# virtual methods
.method public getEnd()I
    .locals 1

    .line 19
    iget v0, p0, Lcom/luxury/mobile/gui/util/Range;->end:I

    return v0
.end method

.method public getStart()I
    .locals 1

    .line 11
    iget v0, p0, Lcom/luxury/mobile/gui/util/Range;->start:I

    return v0
.end method

.method public setEnd(I)V
    .locals 0
    .param p1, "end2"    # I

    .line 23
    iput p1, p0, Lcom/luxury/mobile/gui/util/Range;->end:I

    .line 24
    return-void
.end method

.method public setStart(I)V
    .locals 0
    .param p1, "start2"    # I

    .line 15
    iput p1, p0, Lcom/luxury/mobile/gui/util/Range;->start:I

    .line 16
    return-void
.end method
