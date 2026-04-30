.class public Lbr/com/sapereaude/maskedEditText/MaskedEditText;
.super Landroidx/appcompat/widget/AppCompatEditText;
.source "MaskedEditText.java"

# interfaces
.implements Landroid/text/TextWatcher;


# static fields
.field public static final SPACE:Ljava/lang/String; = " "


# instance fields
.field private allowedChars:Ljava/lang/String;

.field private charRepresentation:C

.field private deniedChars:Ljava/lang/String;

.field private editingAfter:Z

.field private editingBefore:Z

.field private editingOnChanged:Z

.field private focusChangeListener:Landroid/view/View$OnFocusChangeListener;

.field private ignore:Z

.field private initialized:Z

.field private keepHint:Z

.field private lastValidMaskPosition:I

.field private mask:Ljava/lang/String;

.field private maskToRaw:[I

.field protected maxRawLength:I

.field private rawText:Lbr/com/sapereaude/maskedEditText/RawText;

.field private rawToMask:[I

.field private selection:I

.field private selectionChanged:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 45
    invoke-direct {p0, p1}, Landroidx/appcompat/widget/AppCompatEditText;-><init>(Landroid/content/Context;)V

    .line 46
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->init()V

    .line 47
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 50
    invoke-direct {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 51
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->init()V

    .line 53
    sget-object v0, Lbr/com/sapereaude/maskedEditText/R$styleable;->MaskedEditText:[I

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 54
    .local v0, "attributes":Landroid/content/res/TypedArray;
    sget v1, Lbr/com/sapereaude/maskedEditText/R$styleable;->MaskedEditText_mask:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    .line 56
    sget v1, Lbr/com/sapereaude/maskedEditText/R$styleable;->MaskedEditText_allowed_chars:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->allowedChars:Ljava/lang/String;

    .line 57
    sget v1, Lbr/com/sapereaude/maskedEditText/R$styleable;->MaskedEditText_denied_chars:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->deniedChars:Ljava/lang/String;

    .line 59
    sget v1, Lbr/com/sapereaude/maskedEditText/R$styleable;->MaskedEditText_char_representation:I

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    .line 61
    .local v1, "representation":Ljava/lang/String;
    const/4 v2, 0x0

    if-nez v1, :cond_0

    .line 62
    const/16 v3, 0x23

    iput-char v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->charRepresentation:C

    goto :goto_0

    .line 64
    :cond_0
    invoke-virtual {v1, v2}, Ljava/lang/String;->charAt(I)C

    move-result v3

    iput-char v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->charRepresentation:C

    .line 67
    :goto_0
    sget v3, Lbr/com/sapereaude/maskedEditText/R$styleable;->MaskedEditText_keep_hint:I

    invoke-virtual {v0, v3, v2}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v2

    iput-boolean v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->keepHint:Z

    .line 69
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->cleanUp()V

    .line 72
    new-instance v2, Lbr/com/sapereaude/maskedEditText/MaskedEditText$1;

    invoke-direct {v2, p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText$1;-><init>(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)V

    invoke-virtual {p0, v2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 84
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 85
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 170
    invoke-direct {p0, p1, p2, p3}, Landroidx/appcompat/widget/AppCompatEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 171
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->init()V

    .line 172
    return-void
.end method

.method static synthetic access$000(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)Landroid/view/View$OnFocusChangeListener;
    .locals 1
    .param p0, "x0"    # Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    .line 21
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->focusChangeListener:Landroid/view/View$OnFocusChangeListener;

    return-object v0
.end method

.method static synthetic access$102(Lbr/com/sapereaude/maskedEditText/MaskedEditText;Z)Z
    .locals 0
    .param p0, "x0"    # Lbr/com/sapereaude/maskedEditText/MaskedEditText;
    .param p1, "x1"    # Z

    .line 21
    iput-boolean p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selectionChanged:Z

    return p1
.end method

.method static synthetic access$200(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)I
    .locals 1
    .param p0, "x0"    # Lbr/com/sapereaude/maskedEditText/MaskedEditText;

    .line 21
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidPosition()I

    move-result v0

    return v0
.end method

.method private calculateRange(II)Lbr/com/sapereaude/maskedEditText/Range;
    .locals 4
    .param p1, "start"    # I
    .param p2, "end"    # I

    .line 432
    new-instance v0, Lbr/com/sapereaude/maskedEditText/Range;

    invoke-direct {v0}, Lbr/com/sapereaude/maskedEditText/Range;-><init>()V

    .line 433
    .local v0, "range":Lbr/com/sapereaude/maskedEditText/Range;
    move v1, p1

    .local v1, "i":I
    :goto_0
    if-gt v1, p2, :cond_2

    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 434
    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v2, v2, v1

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    .line 435
    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v2

    if-ne v2, v3, :cond_0

    .line 436
    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v2, v2, v1

    invoke-virtual {v0, v2}, Lbr/com/sapereaude/maskedEditText/Range;->setStart(I)V

    .line 438
    :cond_0
    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v2, v2, v1

    invoke-virtual {v0, v2}, Lbr/com/sapereaude/maskedEditText/Range;->setEnd(I)V

    .line 433
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 441
    .end local v1    # "i":I
    :cond_2
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    if-ne p2, v1, :cond_3

    .line 442
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v1}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v1

    invoke-virtual {v0, v1}, Lbr/com/sapereaude/maskedEditText/Range;->setEnd(I)V

    .line 444
    :cond_3
    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v1

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/Range;->getEnd()I

    move-result v2

    if-ne v1, v2, :cond_4

    if-ge p1, p2, :cond_4

    .line 445
    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    invoke-direct {p0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->previousValidPosition(I)I

    move-result v1

    .line 446
    .local v1, "newStart":I
    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v2

    if-ge v1, v2, :cond_4

    .line 447
    invoke-virtual {v0, v1}, Lbr/com/sapereaude/maskedEditText/Range;->setStart(I)V

    .line 450
    .end local v1    # "newStart":I
    :cond_4
    return-object v0
.end method

.method private cleanUp()V
    .locals 3

    .line 120
    const/4 v0, 0x0

    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->initialized:Z

    .line 122
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->generatePositionArrays()V

    .line 124
    new-instance v1, Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-direct {v1}, Lbr/com/sapereaude/maskedEditText/RawText;-><init>()V

    iput-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    .line 125
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    aget v1, v1, v0

    iput v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selection:I

    .line 127
    const/4 v1, 0x1

    iput-boolean v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    .line 128
    iput-boolean v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingOnChanged:Z

    .line 129
    iput-boolean v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingAfter:Z

    .line 130
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->hasHint()Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v2}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v2

    if-nez v2, :cond_0

    .line 131
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->makeMaskedTextWithHint()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {p0, v2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 133
    :cond_0
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->makeMaskedText()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 135
    :goto_0
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    .line 136
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingOnChanged:Z

    .line 137
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingAfter:Z

    .line 139
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-direct {p0, v2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->previousValidPosition(I)I

    move-result v2

    aget v0, v0, v2

    add-int/2addr v0, v1

    iput v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maxRawLength:I

    .line 140
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->findLastValidMaskPosition()I

    move-result v0

    iput v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidMaskPosition:I

    .line 141
    iput-boolean v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->initialized:Z

    .line 143
    new-instance v0, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;

    invoke-direct {v0, p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText$2;-><init>(Lbr/com/sapereaude/maskedEditText/MaskedEditText;)V

    invoke-super {p0, v0}, Landroidx/appcompat/widget/AppCompatEditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    .line 156
    return-void
.end method

.method private clear(Ljava/lang/String;)Ljava/lang/String;
    .locals 7
    .param p1, "string"    # Ljava/lang/String;

    .line 454
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->deniedChars:Ljava/lang/String;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 455
    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v0

    array-length v2, v0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    aget-char v4, v0, v3

    .line 456
    .local v4, "c":C
    invoke-static {v4}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v5

    const-string v6, ""

    invoke-virtual {p1, v5, v6}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 455
    .end local v4    # "c":C
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 460
    :cond_0
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->allowedChars:Ljava/lang/String;

    if-eqz v0, :cond_3

    .line 461
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v2

    invoke-direct {v0, v2}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 463
    .local v0, "builder":Ljava/lang/StringBuilder;
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    array-length v3, v2

    :goto_1
    if-ge v1, v3, :cond_2

    aget-char v4, v2, v1

    .line 464
    .restart local v4    # "c":C
    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->allowedChars:Ljava/lang/String;

    invoke-static {v4}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 465
    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 463
    .end local v4    # "c":C
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 469
    :cond_2
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    .line 472
    .end local v0    # "builder":Ljava/lang/StringBuilder;
    :cond_3
    return-object p1
.end method

.method private erasingStart(I)I
    .locals 2
    .param p1, "start"    # I

    .line 263
    :goto_0
    if-lez p1, :cond_0

    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 264
    add-int/lit8 p1, p1, -0x1

    goto :goto_0

    .line 266
    :cond_0
    return p1
.end method

.method private findLastValidMaskPosition()I
    .locals 3

    .line 159
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_1

    .line 160
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v1, v1, v0

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    return v0

    .line 159
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 162
    .end local v0    # "i":I
    :cond_1
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Mask must contain at least one representation char"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method private fixSelection(I)I
    .locals 1
    .param p1, "selection"    # I

    .line 356
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidPosition()I

    move-result v0

    if-le p1, v0, :cond_0

    .line 357
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidPosition()I

    move-result v0

    return v0

    .line 359
    :cond_0
    invoke-direct {p0, p1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->nextValidPosition(I)I

    move-result v0

    return v0
.end method

.method private generatePositionArrays()V
    .locals 8

    .line 205
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v0, v0, [I

    .line 206
    .local v0, "aux":[I
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    new-array v1, v1, [I

    iput-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    .line 207
    const-string v1, ""

    .line 209
    .local v1, "charsInMaskAux":Ljava/lang/String;
    const/4 v2, 0x0

    .line 210
    .local v2, "charIndex":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v3, v4, :cond_2

    .line 211
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 212
    .local v4, "currentChar":C
    iget-char v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->charRepresentation:C

    if-ne v4, v5, :cond_0

    .line 213
    aput v3, v0, v2

    .line 214
    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    add-int/lit8 v6, v2, 0x1

    .end local v2    # "charIndex":I
    .local v6, "charIndex":I
    aput v2, v5, v3

    move v2, v6

    goto :goto_1

    .line 217
    .end local v6    # "charIndex":I
    .restart local v2    # "charIndex":I
    :cond_0
    invoke-static {v4}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v5

    .line 218
    .local v5, "charAsString":Ljava/lang/String;
    invoke-virtual {v1, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 219
    invoke-virtual {v1, v5}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 221
    :cond_1
    iget-object v6, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    const/4 v7, -0x1

    aput v7, v6, v3

    .line 210
    .end local v4    # "currentChar":C
    .end local v5    # "charAsString":Ljava/lang/String;
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 224
    .end local v3    # "i":I
    :cond_2
    const/16 v3, 0x20

    invoke-virtual {v1, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-gez v3, :cond_3

    .line 225
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 228
    :cond_3
    invoke-virtual {v1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v3

    .line 230
    .local v3, "charsInMask":[C
    new-array v4, v2, [I

    iput-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    .line 231
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_2
    if-ge v4, v2, :cond_4

    .line 232
    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    aget v6, v0, v4

    aput v6, v5, v4

    .line 231
    add-int/lit8 v4, v4, 0x1

    goto :goto_2

    .line 234
    .end local v4    # "i":I
    :cond_4
    return-void
.end method

.method private hasHint()Z
    .locals 1

    .line 166
    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getHint()Ljava/lang/CharSequence;

    move-result-object v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private init()V
    .locals 0

    .line 237
    invoke-virtual {p0, p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 238
    return-void
.end method

.method private lastValidPosition()I
    .locals 2

    .line 382
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v0

    iget v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maxRawLength:I

    if-ne v0, v1, :cond_0

    .line 383
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v1}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    add-int/lit8 v0, v0, 0x1

    return v0

    .line 385
    :cond_0
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v1}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v1

    aget v0, v0, v1

    invoke-direct {p0, v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->nextValidPosition(I)I

    move-result v0

    return v0
.end method

.method private makeMaskedText()Ljava/lang/String;
    .locals 5

    .line 391
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v0

    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    array-length v2, v1

    if-ge v0, v2, :cond_0

    .line 392
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v0

    aget v0, v1, v0

    .local v0, "maskedTextLength":I
    goto :goto_0

    .line 394
    .end local v0    # "maskedTextLength":I
    :cond_0
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    .line 396
    .restart local v0    # "maskedTextLength":I
    :goto_0
    new-array v1, v0, [C

    .line 397
    .local v1, "maskedText":[C
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_1
    array-length v3, v1

    if-ge v2, v3, :cond_2

    .line 398
    iget-object v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v3, v3, v2

    .line 399
    .local v3, "rawIndex":I
    const/4 v4, -0x1

    if-ne v3, v4, :cond_1

    .line 400
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4, v2}, Ljava/lang/String;->charAt(I)C

    move-result v4

    aput-char v4, v1, v2

    goto :goto_2

    .line 402
    :cond_1
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v4, v3}, Lbr/com/sapereaude/maskedEditText/RawText;->charAt(I)C

    move-result v4

    aput-char v4, v1, v2

    .line 397
    .end local v3    # "rawIndex":I
    :goto_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 405
    .end local v2    # "i":I
    :cond_2
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v1}, Ljava/lang/String;-><init>([C)V

    return-object v2
.end method

.method private makeMaskedTextWithHint()Ljava/lang/CharSequence;
    .locals 8

    .line 409
    new-instance v0, Landroid/text/SpannableStringBuilder;

    invoke-direct {v0}, Landroid/text/SpannableStringBuilder;-><init>()V

    .line 411
    .local v0, "ssb":Landroid/text/SpannableStringBuilder;
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    const/4 v2, 0x0

    aget v1, v1, v2

    .line 412
    .local v1, "maskFirstChunkEnd":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v3, v4, :cond_5

    .line 413
    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v4, v4, v3

    .line 414
    .local v4, "mtrv":I
    const/4 v5, -0x1

    if-eq v4, v5, :cond_1

    .line 415
    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v5}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v5

    if-ge v4, v5, :cond_0

    .line 416
    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v5, v4}, Lbr/com/sapereaude/maskedEditText/RawText;->charAt(I)C

    move-result v5

    invoke-virtual {v0, v5}, Landroid/text/SpannableStringBuilder;->append(C)Landroid/text/SpannableStringBuilder;

    goto :goto_1

    .line 418
    :cond_0
    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getHint()Ljava/lang/CharSequence;

    move-result-object v5

    iget-object v6, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v6, v6, v3

    invoke-interface {v5, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    invoke-virtual {v0, v5}, Landroid/text/SpannableStringBuilder;->append(C)Landroid/text/SpannableStringBuilder;

    goto :goto_1

    .line 421
    :cond_1
    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v5, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-virtual {v0, v5}, Landroid/text/SpannableStringBuilder;->append(C)Landroid/text/SpannableStringBuilder;

    .line 423
    :goto_1
    iget-boolean v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->keepHint:Z

    if-eqz v5, :cond_2

    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v5}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v5

    iget-object v6, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    array-length v7, v6

    if-ge v5, v7, :cond_2

    iget-object v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v5}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v5

    aget v5, v6, v5

    if-ge v3, v5, :cond_3

    :cond_2
    iget-boolean v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->keepHint:Z

    if-nez v5, :cond_4

    if-lt v3, v1, :cond_4

    .line 425
    :cond_3
    new-instance v5, Landroid/text/style/ForegroundColorSpan;

    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getCurrentHintTextColor()I

    move-result v6

    invoke-direct {v5, v6}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    add-int/lit8 v6, v3, 0x1

    invoke-virtual {v0, v5, v3, v6, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 412
    :cond_4
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 428
    .end local v3    # "i":I
    .end local v4    # "mtrv":I
    :cond_5
    return-object v0
.end method

.method private nextValidPosition(I)I
    .locals 2
    .param p1, "currentPosition"    # I

    .line 364
    :goto_0
    iget v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidMaskPosition:I

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 365
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 367
    :cond_0
    iget v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidMaskPosition:I

    if-le p1, v0, :cond_1

    add-int/lit8 v0, v0, 0x1

    return v0

    .line 368
    :cond_1
    return p1
.end method

.method private previousValidPosition(I)I
    .locals 2
    .param p1, "currentPosition"    # I

    .line 372
    :cond_0
    if-ltz p1, :cond_1

    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    .line 373
    add-int/lit8 p1, p1, -0x1

    .line 374
    if-gez p1, :cond_0

    .line 375
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->nextValidPosition(I)I

    move-result v0

    return v0

    .line 378
    :cond_1
    return p1
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2
    .param p1, "s"    # Landroid/text/Editable;

    .line 294
    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingAfter:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingOnChanged:Z

    if-eqz v0, :cond_2

    .line 295
    const/4 v0, 0x1

    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingAfter:Z

    .line 296
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->hasHint()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->keepHint:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v0

    if-nez v0, :cond_1

    .line 297
    :cond_0
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->makeMaskedTextWithHint()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_0

    .line 299
    :cond_1
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->makeMaskedText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 302
    :goto_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selectionChanged:Z

    .line 303
    iget v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selection:I

    invoke-virtual {p0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setSelection(I)V

    .line 305
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    .line 306
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingOnChanged:Z

    .line 307
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingAfter:Z

    .line 308
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->ignore:Z

    .line 310
    :cond_2
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 4
    .param p1, "s"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "count"    # I
    .param p4, "after"    # I

    .line 243
    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    if-nez v0, :cond_3

    .line 244
    const/4 v0, 0x1

    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    .line 245
    iget v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidMaskPosition:I

    if-le p2, v1, :cond_0

    .line 246
    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->ignore:Z

    .line 248
    :cond_0
    move v0, p2

    .line 249
    .local v0, "rangeStart":I
    if-nez p4, :cond_1

    .line 250
    invoke-direct {p0, p2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->erasingStart(I)I

    move-result v0

    .line 252
    :cond_1
    add-int v1, p2, p3

    invoke-direct {p0, v0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->calculateRange(II)Lbr/com/sapereaude/maskedEditText/Range;

    move-result-object v1

    .line 253
    .local v1, "range":Lbr/com/sapereaude/maskedEditText/Range;
    invoke-virtual {v1}, Lbr/com/sapereaude/maskedEditText/Range;->getStart()I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_2

    .line 254
    iget-object v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v2, v1}, Lbr/com/sapereaude/maskedEditText/RawText;->subtractFromString(Lbr/com/sapereaude/maskedEditText/Range;)V

    .line 256
    :cond_2
    if-lez p3, :cond_3

    .line 257
    invoke-direct {p0, p2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->previousValidPosition(I)I

    move-result v2

    iput v2, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selection:I

    .line 260
    .end local v0    # "rangeStart":I
    .end local v1    # "range":Lbr/com/sapereaude/maskedEditText/Range;
    :cond_3
    return-void
.end method

.method public getCharRepresentation()C
    .locals 1

    .line 193
    iget-char v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->charRepresentation:C

    return v0
.end method

.method public getMask()Ljava/lang/String;
    .locals 1

    .line 180
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    return-object v0
.end method

.method public getRawText()Ljava/lang/String;
    .locals 1

    .line 184
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/RawText;->getText()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public isKeepHint()Z
    .locals 1

    .line 313
    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->keepHint:Z

    return v0
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 4
    .param p1, "state"    # Landroid/os/Parcelable;

    .line 98
    move-object v0, p1

    check-cast v0, Landroid/os/Bundle;

    .line 99
    .local v0, "bundle":Landroid/os/Bundle;
    move-object v1, p1

    check-cast v1, Landroid/os/Bundle;

    const-string v2, "super"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v1

    invoke-super {p0, v1}, Landroidx/appcompat/widget/AppCompatEditText;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    .line 100
    const-string v1, "text"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 102
    .local v1, "text":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "onRestoreInstanceState: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "ContentValues"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 103
    invoke-virtual {p0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 104
    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 4

    .line 89
    invoke-super {p0}, Landroidx/appcompat/widget/AppCompatEditText;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    .line 90
    .local v0, "superParcellable":Landroid/os/Parcelable;
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 91
    .local v1, "state":Landroid/os/Bundle;
    const-string v2, "super"

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 92
    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getRawText()Ljava/lang/String;

    move-result-object v2

    const-string v3, "text"

    invoke-virtual {v1, v3, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 93
    return-object v1
.end method

.method protected onSelectionChanged(II)V
    .locals 3
    .param p1, "selStart"    # I
    .param p2, "selEnd"    # I

    .line 326
    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->initialized:Z

    if-eqz v0, :cond_5

    .line 327
    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selectionChanged:Z

    const/4 v1, 0x1

    if-nez v0, :cond_4

    .line 328
    invoke-direct {p0, p1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->fixSelection(I)I

    move-result p1

    .line 329
    invoke-direct {p0, p2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->fixSelection(I)I

    move-result p2

    .line 332
    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le p1, v0, :cond_0

    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result p1

    .line 333
    :cond_0
    if-gez p1, :cond_1

    const/4 p1, 0x0

    .line 336
    :cond_1
    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le p2, v0, :cond_2

    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result p2

    .line 337
    :cond_2
    if-gez p2, :cond_3

    const/4 p2, 0x0

    .line 339
    :cond_3
    invoke-virtual {p0, p1, p2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setSelection(II)V

    .line 340
    iput-boolean v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selectionChanged:Z

    goto :goto_0

    .line 343
    :cond_4
    iget-object v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-virtual {v0}, Lbr/com/sapereaude/maskedEditText/RawText;->length()I

    move-result v0

    sub-int/2addr v0, v1

    if-le p1, v0, :cond_5

    .line 344
    invoke-direct {p0, p1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->fixSelection(I)I

    move-result v0

    .line 345
    .local v0, "start":I
    invoke-direct {p0, p2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->fixSelection(I)I

    move-result v1

    .line 346
    .local v1, "end":I
    if-ltz v0, :cond_5

    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->length()I

    move-result v2

    if-ge v1, v2, :cond_5

    .line 347
    invoke-virtual {p0, v0, v1}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setSelection(II)V

    .line 352
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_5
    :goto_0
    invoke-super {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatEditText;->onSelectionChanged(II)V

    .line 353
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 6
    .param p1, "s"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "before"    # I
    .param p4, "count"    # I

    .line 271
    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingOnChanged:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingBefore:Z

    if-eqz v0, :cond_2

    .line 272
    const/4 v0, 0x1

    iput-boolean v0, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->editingOnChanged:Z

    .line 273
    iget-boolean v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->ignore:Z

    if-eqz v1, :cond_0

    .line 274
    return-void

    .line 276
    :cond_0
    if-lez p4, :cond_2

    .line 277
    iget-object v1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maskToRaw:[I

    invoke-direct {p0, p2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->nextValidPosition(I)I

    move-result v2

    aget v1, v1, v2

    .line 278
    .local v1, "startingPosition":I
    add-int v2, p2, p4

    invoke-interface {p1, p2, v2}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    .line 279
    .local v2, "addedString":Ljava/lang/String;
    iget-object v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawText:Lbr/com/sapereaude/maskedEditText/RawText;

    invoke-direct {p0, v2}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->clear(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    iget v5, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->maxRawLength:I

    invoke-virtual {v3, v4, v1, v5}, Lbr/com/sapereaude/maskedEditText/RawText;->addToString(Ljava/lang/String;II)I

    move-result p4

    .line 280
    iget-boolean v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->initialized:Z

    if-eqz v3, :cond_2

    .line 282
    add-int v3, v1, p4

    iget-object v4, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->rawToMask:[I

    array-length v5, v4

    if-ge v3, v5, :cond_1

    .line 283
    add-int v0, v1, p4

    aget v0, v4, v0

    .local v0, "currentPosition":I
    goto :goto_0

    .line 285
    .end local v0    # "currentPosition":I
    :cond_1
    iget v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->lastValidMaskPosition:I

    add-int/2addr v0, v3

    .line 286
    .restart local v0    # "currentPosition":I
    :goto_0
    invoke-direct {p0, v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->nextValidPosition(I)I

    move-result v3

    iput v3, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->selection:I

    .line 290
    .end local v0    # "currentPosition":I
    .end local v1    # "startingPosition":I
    .end local v2    # "addedString":Ljava/lang/String;
    :cond_2
    return-void
.end method

.method public setCharRepresentation(C)V
    .locals 0
    .param p1, "charRepresentation"    # C

    .line 188
    iput-char p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->charRepresentation:C

    .line 189
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->cleanUp()V

    .line 190
    return-void
.end method

.method public setKeepHint(Z)V
    .locals 1
    .param p1, "keepHint"    # Z

    .line 317
    iput-boolean p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->keepHint:Z

    .line 318
    invoke-virtual {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->getRawText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 319
    return-void
.end method

.method public setMask(Ljava/lang/String;)V
    .locals 0
    .param p1, "mask"    # Ljava/lang/String;

    .line 175
    iput-object p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->mask:Ljava/lang/String;

    .line 176
    invoke-direct {p0}, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->cleanUp()V

    .line 177
    return-void
.end method

.method public setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V
    .locals 0
    .param p1, "listener"    # Landroid/view/View$OnFocusChangeListener;

    .line 116
    iput-object p1, p0, Lbr/com/sapereaude/maskedEditText/MaskedEditText;->focusChangeListener:Landroid/view/View$OnFocusChangeListener;

    .line 117
    return-void
.end method

.method public setText(Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V
    .locals 0
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "type"    # Landroid/widget/TextView$BufferType;

    .line 109
    invoke-super {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatEditText;->setText(Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V

    .line 110
    return-void
.end method
