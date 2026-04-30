.class public Lbr/com/sapereaude/maskedEditText/RawText;
.super Ljava/lang/Object;
.source "RawText.java"


# instance fields
.field private text:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 10
    const-string v0, ""

    iput-object v0, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    .line 11
    return-void
.end method


# virtual methods
.method public addToString(Ljava/lang/String;II)I
    .locals 6
    .param p1, "newString"    # Ljava/lang/String;
    .param p2, "start"    # I
    .param p3, "maxLength"    # I

    .line 38
    const-string v0, ""

    .line 39
    .local v0, "firstPart":Ljava/lang/String;
    const-string v1, ""

    .line 41
    .local v1, "lastPart":Ljava/lang/String;
    const/4 v2, 0x0

    if-eqz p1, :cond_6

    const-string v3, ""

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    .line 44
    :cond_0
    if-ltz p2, :cond_5

    .line 47
    iget-object v3, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-gt p2, v3, :cond_4

    .line 51
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    .line 53
    .local v3, "count":I
    if-lez p2, :cond_1

    .line 54
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v4, v2, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 56
    :cond_1
    if-ltz p2, :cond_2

    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-ge p2, v4, :cond_2

    .line 57
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v5

    invoke-virtual {v4, p2, v5}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 59
    :cond_2
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v5

    add-int/2addr v4, v5

    if-le v4, p3, :cond_3

    .line 60
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    sub-int v3, p3, v4

    .line 61
    invoke-virtual {p1, v2, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p1

    .line 63
    :cond_3
    invoke-virtual {v0, p1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    .line 64
    return v3

    .line 48
    .end local v3    # "count":I
    :cond_4
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Start position must be less than the actual text length"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 45
    :cond_5
    new-instance v2, Ljava/lang/IllegalArgumentException;

    const-string v3, "Start position must be non-negative"

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 42
    :cond_6
    :goto_0
    return v2
.end method

.method public charAt(I)C
    .locals 1
    .param p1, "position"    # I

    .line 76
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/lang/String;->charAt(I)C

    move-result v0

    return v0
.end method

.method public getText()Ljava/lang/String;
    .locals 1

    .line 68
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    return-object v0
.end method

.method public length()I
    .locals 1

    .line 72
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    return v0
.end method

.method public subtractFromString(Lbr/com/sapereaude/maskedEditText/Range;)V
    .locals 5
    .param p1, "range"    # Lbr/com/sapereaude/maskedEditText/Range;

    .line 18
    const-string v0, ""

    .line 19
    .local v0, "firstPart":Ljava/lang/String;
    const-string v1, ""

    .line 21
    .local v1, "lastPart":Ljava/lang/String;
    invoke-virtual {p1}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v2

    if-lez v2, :cond_0

    invoke-virtual {p1}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v2

    iget-object v3, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-gt v2, v3, :cond_0

    .line 22
    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {p1}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 24
    :cond_0
    invoke-virtual {p1}, Lbr/com/sapereaude/maskedEditText/Range;->getEnd()I

    move-result v2

    if-ltz v2, :cond_1

    invoke-virtual {p1}, Lbr/com/sapereaude/maskedEditText/Range;->getEnd()I

    move-result v2

    iget-object v3, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 25
    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {p1}, Lbr/com/sapereaude/maskedEditText/Range;->getEnd()I

    move-result v3

    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v1

    .line 27
    :cond_1
    invoke-virtual {v0, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lbr/com/sapereaude/maskedEditText/RawText;->text:Ljava/lang/String;

    .line 28
    return-void
.end method
