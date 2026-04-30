.class public Lcom/luxury/mobile/gui/util/MaskedEditText;
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

.field private rawText:Lcom/luxury/mobile/gui/util/RawText;

.field private rawToMask:[I

.field private selection:I

.field private selectionChanged:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 41
    invoke-direct {p0, p1}, Landroidx/appcompat/widget/AppCompatEditText;-><init>(Landroid/content/Context;)V

    .line 42
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->init()V

    .line 43
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 46
    invoke-direct {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 47
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->init()V

    .line 48
    sget-object v0, Lcom/luxury/mobile/R$styleable;->MaskedEditText:[I

    invoke-virtual {p1, p2, v0}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v0

    .line 49
    .local v0, "attributes":Landroid/content/res/TypedArray;
    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    .line 51
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->allowedChars:Ljava/lang/String;

    .line 52
    const/4 v2, 0x2

    invoke-virtual {v0, v2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->deniedChars:Ljava/lang/String;

    .line 54
    const/4 v2, 0x1

    invoke-virtual {v0, v2}, Landroid/content/res/TypedArray;->getString(I)Ljava/lang/String;

    move-result-object v2

    .line 56
    .local v2, "representation":Ljava/lang/String;
    if-nez v2, :cond_0

    .line 57
    const/16 v3, 0x23

    iput-char v3, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->charRepresentation:C

    goto :goto_0

    .line 59
    :cond_0
    invoke-virtual {v2, v1}, Ljava/lang/String;->charAt(I)C

    move-result v3

    iput-char v3, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->charRepresentation:C

    .line 61
    :goto_0
    const/4 v3, 0x3

    invoke-virtual {v0, v3, v1}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v1

    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->keepHint:Z

    .line 62
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->cleanUp()V

    .line 63
    sget-object v1, Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;->INSTANCE:Lcom/luxury/mobile/gui/util/$$Lambda$MaskedEditText$uX_YztYUHcbq6dV_J1fDsTb0DjM;

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 64
    invoke-virtual {v0}, Landroid/content/res/TypedArray;->recycle()V

    .line 65
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 143
    invoke-direct {p0, p1, p2, p3}, Landroidx/appcompat/widget/AppCompatEditText;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 144
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->init()V

    .line 145
    return-void
.end method

.method static synthetic access$001(Lcom/luxury/mobile/gui/util/MaskedEditText;)Landroid/os/Parcelable;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;

    .line 19
    invoke-super {p0}, Landroidx/appcompat/widget/AppCompatEditText;->onSaveInstanceState()Landroid/os/Parcelable;

    move-result-object v0

    return-object v0
.end method

.method static synthetic access$101(Lcom/luxury/mobile/gui/util/MaskedEditText;Landroid/os/Parcelable;)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;
    .param p1, "x1"    # Landroid/os/Parcelable;

    .line 19
    invoke-super {p0, p1}, Landroidx/appcompat/widget/AppCompatEditText;->onRestoreInstanceState(Landroid/os/Parcelable;)V

    return-void
.end method

.method static synthetic access$201(Lcom/luxury/mobile/gui/util/MaskedEditText;Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;
    .param p1, "x1"    # Ljava/lang/CharSequence;
    .param p2, "x2"    # Landroid/widget/TextView$BufferType;

    .line 19
    invoke-super {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatEditText;->setText(Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V

    return-void
.end method

.method static synthetic access$300(Lcom/luxury/mobile/gui/util/MaskedEditText;)Landroid/view/View$OnFocusChangeListener;
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;

    .line 19
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->focusChangeListener:Landroid/view/View$OnFocusChangeListener;

    return-object v0
.end method

.method static synthetic access$402(Lcom/luxury/mobile/gui/util/MaskedEditText;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;
    .param p1, "x1"    # Z

    .line 19
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selectionChanged:Z

    return p1
.end method

.method static synthetic access$500(Lcom/luxury/mobile/gui/util/MaskedEditText;)I
    .locals 1
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;

    .line 19
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidPosition()I

    move-result v0

    return v0
.end method

.method static synthetic access$601(Lcom/luxury/mobile/gui/util/MaskedEditText;Landroid/view/View$OnFocusChangeListener;)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;
    .param p1, "x1"    # Landroid/view/View$OnFocusChangeListener;

    .line 19
    invoke-super {p0, p1}, Landroidx/appcompat/widget/AppCompatEditText;->setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V

    return-void
.end method

.method static synthetic access$701(Lcom/luxury/mobile/gui/util/MaskedEditText;II)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/util/MaskedEditText;
    .param p1, "x1"    # I
    .param p2, "x2"    # I

    .line 19
    invoke-super {p0, p1, p2}, Landroidx/appcompat/widget/AppCompatEditText;->onSelectionChanged(II)V

    return-void
.end method

.method private calculateRange(II)Lcom/luxury/mobile/gui/util/Range;
    .locals 5
    .param p1, "start"    # I
    .param p2, "end"    # I

    .line 394
    new-instance v0, Lcom/luxury/mobile/gui/util/Range;

    invoke-direct {v0}, Lcom/luxury/mobile/gui/util/Range;-><init>()V

    .line 395
    .local v0, "range":Lcom/luxury/mobile/gui/util/Range;
    move v1, p1

    .line 396
    .local v1, "i":I
    :goto_0
    if-gt v1, p2, :cond_2

    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 397
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v2, v2, v1

    const/4 v3, -0x1

    if-eq v2, v3, :cond_1

    .line 398
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/Range;->getStart()I

    move-result v2

    if-ne v2, v3, :cond_0

    .line 399
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v2, v2, v1

    invoke-virtual {v0, v2}, Lcom/luxury/mobile/gui/util/Range;->setStart(I)V

    .line 401
    :cond_0
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v2, v2, v1

    invoke-virtual {v0, v2}, Lcom/luxury/mobile/gui/util/Range;->setEnd(I)V

    .line 403
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 405
    :cond_2
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    if-ne p2, v2, :cond_3

    .line 406
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v2}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v2

    invoke-virtual {v0, v2}, Lcom/luxury/mobile/gui/util/Range;->setEnd(I)V

    .line 408
    :cond_3
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/Range;->getStart()I

    move-result v2

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/Range;->getEnd()I

    move-result v3

    if-ne v2, v3, :cond_4

    if-ge p1, p2, :cond_4

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/Range;->getStart()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    invoke-direct {p0, v2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->previousValidPosition(I)I

    move-result v2

    move v3, v2

    .local v3, "newStart":I
    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/Range;->getStart()I

    move-result v4

    if-ge v2, v4, :cond_4

    .line 409
    invoke-virtual {v0, v3}, Lcom/luxury/mobile/gui/util/Range;->setStart(I)V

    .line 411
    .end local v3    # "newStart":I
    :cond_4
    return-object v0
.end method

.method private cleanUp()V
    .locals 3

    .line 95
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->initialized:Z

    .line 96
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->generatePositionArrays()V

    .line 97
    new-instance v1, Lcom/luxury/mobile/gui/util/RawText;

    invoke-direct {v1}, Lcom/luxury/mobile/gui/util/RawText;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    .line 98
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    aget v1, v1, v0

    iput v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selection:I

    .line 99
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    .line 100
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingOnChanged:Z

    .line 101
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingAfter:Z

    .line 102
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->hasHint()Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v2}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v2

    if-eqz v2, :cond_0

    goto :goto_0

    .line 105
    :cond_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->makeMaskedTextWithHint()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 103
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->makeMaskedText()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 107
    :goto_1
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    .line 108
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingOnChanged:Z

    .line 109
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingAfter:Z

    .line 110
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    sub-int/2addr v2, v1

    invoke-direct {p0, v2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->previousValidPosition(I)I

    move-result v2

    aget v0, v0, v2

    add-int/2addr v0, v1

    iput v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maxRawLength:I

    .line 111
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->findLastValidMaskPosition()I

    move-result v0

    iput v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidMaskPosition:I

    .line 112
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->initialized:Z

    .line 113
    new-instance v0, Lcom/luxury/mobile/gui/util/MaskedEditText$1;

    invoke-direct {v0, p0}, Lcom/luxury/mobile/gui/util/MaskedEditText$1;-><init>(Lcom/luxury/mobile/gui/util/MaskedEditText;)V

    invoke-static {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$601(Lcom/luxury/mobile/gui/util/MaskedEditText;Landroid/view/View$OnFocusChangeListener;)V

    .line 127
    return-void
.end method

.method private clear(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "string"    # Ljava/lang/String;

    .line 415
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->deniedChars:Ljava/lang/String;

    .line 416
    .local v0, "str":Ljava/lang/String;
    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 417
    invoke-virtual {v0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v2

    array-length v3, v2

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_0

    aget-char v5, v2, v4

    .line 418
    .local v5, "c":C
    invoke-static {v5}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v6

    const-string v7, ""

    invoke-virtual {p1, v6, v7}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 417
    .end local v5    # "c":C
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 421
    :cond_0
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->allowedChars:Ljava/lang/String;

    if-nez v2, :cond_1

    .line 422
    return-object p1

    .line 424
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 425
    .local v2, "builder":Ljava/lang/StringBuilder;
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object v3

    .line 426
    .local v3, "charArray":[C
    array-length v4, v3

    :goto_1
    if-ge v1, v4, :cond_3

    aget-char v5, v3, v1

    .line 427
    .local v5, "c2":C
    iget-object v6, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->allowedChars:Ljava/lang/String;

    invoke-static {v5}, Ljava/lang/String;->valueOf(C)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 428
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 426
    .end local v5    # "c2":C
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 431
    :cond_3
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method

.method private erasingStart(I)I
    .locals 2
    .param p1, "start"    # I

    .line 223
    :goto_0
    if-lez p1, :cond_0

    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 224
    add-int/lit8 p1, p1, -0x1

    goto :goto_0

    .line 226
    :cond_0
    return p1
.end method

.method private findLastValidMaskPosition()I
    .locals 3

    .line 130
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    array-length v0, v0

    add-int/lit8 v0, v0, -0x1

    .local v0, "i":I
    :goto_0
    if-ltz v0, :cond_1

    .line 131
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v1, v1, v0

    const/4 v2, -0x1

    if-eq v1, v2, :cond_0

    .line 132
    return v0

    .line 130
    :cond_0
    add-int/lit8 v0, v0, -0x1

    goto :goto_0

    .line 135
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
    .param p1, "selection2"    # I

    .line 308
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidPosition()I

    move-result v0

    if-le p1, v0, :cond_0

    .line 309
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidPosition()I

    move-result v0

    return v0

    .line 311
    :cond_0
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->nextValidPosition(I)I

    move-result v0

    return v0
.end method

.method private generatePositionArrays()V
    .locals 8

    .line 170
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    new-array v0, v0, [I

    .line 171
    .local v0, "aux":[I
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v1

    new-array v1, v1, [I

    iput-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    .line 172
    const-string v1, ""

    .line 173
    .local v1, "charsInMaskAux":Ljava/lang/String;
    const/4 v2, 0x0

    .line 174
    .local v2, "charIndex":I
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    iget-object v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v3, v4, :cond_2

    .line 175
    iget-object v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4, v3}, Ljava/lang/String;->charAt(I)C

    move-result v4

    .line 176
    .local v4, "currentChar":C
    iget-char v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->charRepresentation:C

    if-ne v4, v5, :cond_0

    .line 177
    aput v3, v0, v2

    .line 178
    iget-object v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aput v2, v5, v3

    .line 179
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 181
    :cond_0
    invoke-static {v4}, Ljava/lang/Character;->toString(C)Ljava/lang/String;

    move-result-object v5

    .line 182
    .local v5, "charAsString":Ljava/lang/String;
    invoke-virtual {v1, v5}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 183
    invoke-virtual {v1, v5}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 185
    :cond_1
    iget-object v6, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    const/4 v7, -0x1

    aput v7, v6, v3

    .line 174
    .end local v4    # "currentChar":C
    .end local v5    # "charAsString":Ljava/lang/String;
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 188
    .end local v3    # "i":I
    :cond_2
    const/16 v3, 0x20

    invoke-virtual {v1, v3}, Ljava/lang/String;->indexOf(I)I

    move-result v3

    if-gez v3, :cond_3

    .line 189
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 191
    :cond_3
    invoke-virtual {v1}, Ljava/lang/String;->toCharArray()[C

    .line 192
    new-array v3, v2, [I

    iput-object v3, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    .line 193
    const/4 v3, 0x0

    .local v3, "i2":I
    :goto_2
    if-ge v3, v2, :cond_4

    .line 194
    iget-object v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    aget v5, v0, v3

    aput v5, v4, v3

    .line 193
    add-int/lit8 v3, v3, 0x1

    goto :goto_2

    .line 196
    .end local v3    # "i2":I
    :cond_4
    return-void
.end method

.method private hasHint()Z
    .locals 1

    .line 139
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getHint()Ljava/lang/CharSequence;

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

    .line 199
    invoke-virtual {p0, p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 200
    return-void
.end method

.method static lambda$new$0(Landroid/widget/TextView;ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p0, "v"    # Landroid/widget/TextView;
    .param p1, "actionId"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .line 68
    const/4 v0, 0x1

    return v0
.end method

.method private lastValidPosition()I
    .locals 2

    .line 333
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v0

    iget v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maxRawLength:I

    if-ne v0, v1, :cond_0

    .line 334
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v1}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v1

    add-int/lit8 v1, v1, -0x1

    aget v0, v0, v1

    add-int/lit8 v0, v0, 0x1

    return v0

    .line 336
    :cond_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v1}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v1

    aget v0, v0, v1

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->nextValidPosition(I)I

    move-result v0

    return v0
.end method

.method private makeMaskedText()Ljava/lang/String;
    .locals 7

    .line 341
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v0

    .line 342
    .local v0, "length":I
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    .line 343
    .local v1, "iArr":[I
    array-length v2, v1

    if-ge v0, v2, :cond_0

    .line 344
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v2}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v2

    aget v2, v1, v2

    .local v2, "maskedTextLength":I
    goto :goto_0

    .line 346
    .end local v2    # "maskedTextLength":I
    :cond_0
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    .line 348
    .restart local v2    # "maskedTextLength":I
    :goto_0
    new-array v3, v2, [C

    .line 349
    .local v3, "maskedText":[C
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_1
    array-length v5, v3

    if-ge v4, v5, :cond_2

    .line 350
    iget-object v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v5, v5, v4

    .line 351
    .local v5, "rawIndex":I
    const/4 v6, -0x1

    if-ne v5, v6, :cond_1

    .line 352
    iget-object v6, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v6, v4}, Ljava/lang/String;->charAt(I)C

    move-result v6

    aput-char v6, v3, v4

    goto :goto_2

    .line 354
    :cond_1
    iget-object v6, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v6, v5}, Lcom/luxury/mobile/gui/util/RawText;->charAt(I)C

    move-result v6

    aput-char v6, v3, v4

    .line 349
    .end local v5    # "rawIndex":I
    :goto_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    .line 357
    .end local v4    # "i":I
    :cond_2
    new-instance v4, Ljava/lang/String;

    invoke-direct {v4, v3}, Ljava/lang/String;-><init>([C)V

    return-object v4
.end method

.method private makeMaskedTextWithHint()Ljava/lang/CharSequence;
    .locals 8

    .line 364
    new-instance v0, Landroid/text/SpannableStringBuilder;

    invoke-direct {v0}, Landroid/text/SpannableStringBuilder;-><init>()V

    .line 365
    .local v0, "ssb":Landroid/text/SpannableStringBuilder;
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    const/4 v2, 0x0

    aget v1, v1, v2

    .line 366
    .local v1, "maskFirstChunkEnd":I
    const/4 v3, 0x0

    .line 367
    .local v3, "i":I
    :goto_0
    iget-object v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v3, v4, :cond_4

    .line 368
    iget-object v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v4, v4, v3

    .line 369
    .local v4, "mtrv":I
    const/4 v5, -0x1

    if-ne v4, v5, :cond_0

    .line 370
    iget-object v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    invoke-virtual {v5, v3}, Ljava/lang/String;->charAt(I)C

    move-result v5

    invoke-virtual {v0, v5}, Landroid/text/SpannableStringBuilder;->append(C)Landroid/text/SpannableStringBuilder;

    goto :goto_1

    .line 371
    :cond_0
    iget-object v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v5}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v5

    if-ge v4, v5, :cond_1

    .line 372
    iget-object v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v5, v4}, Lcom/luxury/mobile/gui/util/RawText;->charAt(I)C

    move-result v5

    invoke-virtual {v0, v5}, Landroid/text/SpannableStringBuilder;->append(C)Landroid/text/SpannableStringBuilder;

    goto :goto_1

    .line 374
    :cond_1
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getHint()Ljava/lang/CharSequence;

    move-result-object v5

    iget-object v6, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v6, v6, v3

    invoke-interface {v5, v6}, Ljava/lang/CharSequence;->charAt(I)C

    move-result v5

    invoke-virtual {v0, v5}, Landroid/text/SpannableStringBuilder;->append(C)Landroid/text/SpannableStringBuilder;

    .line 376
    :goto_1
    iget-boolean v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->keepHint:Z

    if-eqz v5, :cond_2

    .line 377
    iget-object v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v5}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v5

    .line 378
    .local v5, "length":I
    iget-object v6, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    .line 379
    .local v6, "iArr":[I
    array-length v7, v6

    .line 382
    .end local v5    # "length":I
    .end local v6    # "iArr":[I
    :cond_2
    iget-boolean v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->keepHint:Z

    if-nez v5, :cond_3

    .line 383
    nop

    .line 385
    new-instance v5, Landroid/text/style/ForegroundColorSpan;

    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getCurrentHintTextColor()I

    move-result v6

    invoke-direct {v5, v6}, Landroid/text/style/ForegroundColorSpan;-><init>(I)V

    add-int/lit8 v6, v3, 0x1

    invoke-virtual {v0, v5, v3, v6, v2}, Landroid/text/SpannableStringBuilder;->setSpan(Ljava/lang/Object;III)V

    .line 387
    :cond_3
    nop

    .end local v4    # "mtrv":I
    add-int/lit8 v3, v3, 0x1

    .line 388
    goto :goto_0

    .line 389
    :cond_4
    return-object v0
.end method

.method private nextValidPosition(I)I
    .locals 2
    .param p1, "currentPosition"    # I

    .line 315
    :goto_0
    iget v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidMaskPosition:I

    if-ge p1, v0, :cond_0

    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 316
    add-int/lit8 p1, p1, 0x1

    goto :goto_0

    .line 318
    :cond_0
    iget v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidMaskPosition:I

    if-le p1, v0, :cond_1

    add-int/lit8 v0, v0, 0x1

    return v0

    .line 319
    :cond_1
    return p1
.end method

.method private previousValidPosition(I)I
    .locals 2
    .param p1, "currentPosition"    # I

    .line 323
    :cond_0
    if-ltz p1, :cond_1

    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    aget v0, v0, p1

    const/4 v1, -0x1

    if-ne v0, v1, :cond_1

    .line 324
    add-int/lit8 p1, p1, -0x1

    .line 325
    if-gez p1, :cond_0

    .line 326
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->nextValidPosition(I)I

    move-result v0

    return v0

    .line 329
    :cond_1
    return p1
.end method


# virtual methods
.method public afterTextChanged(Landroid/text/Editable;)V
    .locals 2
    .param p1, "s"    # Landroid/text/Editable;

    .line 251
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingAfter:Z

    if-nez v0, :cond_2

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingOnChanged:Z

    if-eqz v0, :cond_2

    .line 252
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingAfter:Z

    .line 253
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->hasHint()Z

    move-result v0

    if-eqz v0, :cond_1

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->keepHint:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 256
    :cond_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->makeMaskedTextWithHint()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    goto :goto_1

    .line 254
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->makeMaskedText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 258
    :goto_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selectionChanged:Z

    .line 259
    iget v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selection:I

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setSelection(I)V

    .line 260
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    .line 261
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingOnChanged:Z

    .line 262
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingAfter:Z

    .line 263
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->ignore:Z

    .line 265
    :cond_2
    return-void
.end method

.method public beforeTextChanged(Ljava/lang/CharSequence;III)V
    .locals 4
    .param p1, "s"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "count"    # I
    .param p4, "after"    # I

    .line 203
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    if-nez v0, :cond_3

    .line 204
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    .line 205
    iget v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidMaskPosition:I

    if-le p2, v1, :cond_0

    .line 206
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->ignore:Z

    .line 208
    :cond_0
    move v0, p2

    .line 209
    .local v0, "rangeStart":I
    if-nez p4, :cond_1

    .line 210
    invoke-direct {p0, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->erasingStart(I)I

    move-result v0

    .line 212
    :cond_1
    add-int v1, p2, p3

    invoke-direct {p0, v0, v1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->calculateRange(II)Lcom/luxury/mobile/gui/util/Range;

    move-result-object v1

    .line 213
    .local v1, "range":Lcom/luxury/mobile/gui/util/Range;
    invoke-virtual {v1}, Lcom/luxury/mobile/gui/util/Range;->getStart()I

    move-result v2

    const/4 v3, -0x1

    if-eq v2, v3, :cond_2

    .line 214
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v2, v1}, Lcom/luxury/mobile/gui/util/RawText;->subtractFromString(Lcom/luxury/mobile/gui/util/Range;)V

    .line 216
    :cond_2
    if-lez p3, :cond_3

    .line 217
    invoke-direct {p0, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->previousValidPosition(I)I

    move-result v2

    iput v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selection:I

    .line 220
    .end local v0    # "rangeStart":I
    .end local v1    # "range":Lcom/luxury/mobile/gui/util/Range;
    :cond_3
    return-void
.end method

.method public getCharRepresentation()C
    .locals 1

    .line 166
    iget-char v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->charRepresentation:C

    return v0
.end method

.method public getMask()Ljava/lang/String;
    .locals 1

    .line 153
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    return-object v0
.end method

.method public getRawText()Ljava/lang/String;
    .locals 1

    .line 157
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/RawText;->getText()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public isKeepHint()Z
    .locals 1

    .line 268
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->keepHint:Z

    return v0
.end method

.method public onRestoreInstanceState(Landroid/os/Parcelable;)V
    .locals 3
    .param p1, "state"    # Landroid/os/Parcelable;

    .line 80
    move-object v0, p1

    check-cast v0, Landroid/os/Bundle;

    const-string v1, "super"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getParcelable(Ljava/lang/String;)Landroid/os/Parcelable;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$101(Lcom/luxury/mobile/gui/util/MaskedEditText;Landroid/os/Parcelable;)V

    .line 81
    move-object v0, p1

    check-cast v0, Landroid/os/Bundle;

    const-string v1, "text"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 82
    .local v0, "text":Ljava/lang/String;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onRestoreInstanceState: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "ContentValues"

    invoke-static {v2, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 83
    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 84
    return-void
.end method

.method public onSaveInstanceState()Landroid/os/Parcelable;
    .locals 4

    .line 72
    invoke-static {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$001(Lcom/luxury/mobile/gui/util/MaskedEditText;)Landroid/os/Parcelable;

    move-result-object v0

    .line 73
    .local v0, "superParcellable":Landroid/os/Parcelable;
    new-instance v1, Landroid/os/Bundle;

    invoke-direct {v1}, Landroid/os/Bundle;-><init>()V

    .line 74
    .local v1, "state":Landroid/os/Bundle;
    const-string v2, "super"

    invoke-virtual {v1, v2, v0}, Landroid/os/Bundle;->putParcelable(Ljava/lang/String;Landroid/os/Parcelable;)V

    .line 75
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getRawText()Ljava/lang/String;

    move-result-object v2

    const-string v3, "text"

    invoke-virtual {v1, v3, v2}, Landroid/os/Bundle;->putString(Ljava/lang/String;Ljava/lang/String;)V

    .line 76
    return-object v1
.end method

.method public onSelectionChanged(II)V
    .locals 3
    .param p1, "selStart"    # I
    .param p2, "selEnd"    # I

    .line 278
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->initialized:Z

    if-eqz v0, :cond_5

    .line 279
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selectionChanged:Z

    const/4 v1, 0x1

    if-nez v0, :cond_4

    .line 280
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->fixSelection(I)I

    move-result p1

    .line 281
    invoke-direct {p0, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->fixSelection(I)I

    move-result p2

    .line 282
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le p1, v0, :cond_0

    .line 283
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result p1

    .line 285
    :cond_0
    if-gez p1, :cond_1

    .line 286
    const/4 p1, 0x0

    .line 288
    :cond_1
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result v0

    if-le p2, v0, :cond_2

    .line 289
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v0

    invoke-interface {v0}, Landroid/text/Editable;->length()I

    move-result p2

    .line 291
    :cond_2
    if-gez p2, :cond_3

    .line 292
    const/4 p2, 0x0

    .line 294
    :cond_3
    invoke-virtual {p0, p1, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setSelection(II)V

    .line 295
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selectionChanged:Z

    goto :goto_0

    .line 296
    :cond_4
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/util/RawText;->length()I

    move-result v0

    sub-int/2addr v0, v1

    if-le p1, v0, :cond_5

    .line 297
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->fixSelection(I)I

    move-result v0

    .line 298
    .local v0, "start":I
    invoke-direct {p0, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->fixSelection(I)I

    move-result v1

    .line 299
    .local v1, "end":I
    if-ltz v0, :cond_5

    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-interface {v2}, Landroid/text/Editable;->length()I

    move-result v2

    if-ge v1, v2, :cond_5

    .line 300
    invoke-virtual {p0, v0, v1}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setSelection(II)V

    .line 304
    .end local v0    # "start":I
    .end local v1    # "end":I
    :cond_5
    :goto_0
    invoke-static {p0, p1, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$701(Lcom/luxury/mobile/gui/util/MaskedEditText;II)V

    .line 305
    return-void
.end method

.method public onTextChanged(Ljava/lang/CharSequence;III)V
    .locals 6
    .param p1, "s"    # Ljava/lang/CharSequence;
    .param p2, "start"    # I
    .param p3, "before"    # I
    .param p4, "count"    # I

    .line 231
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingOnChanged:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingBefore:Z

    if-eqz v0, :cond_1

    .line 232
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->editingOnChanged:Z

    .line 233
    iget-boolean v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->ignore:Z

    if-nez v1, :cond_1

    if-lez p4, :cond_1

    .line 234
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maskToRaw:[I

    invoke-direct {p0, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->nextValidPosition(I)I

    move-result v2

    aget v1, v1, v2

    .line 235
    .local v1, "startingPosition":I
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawText:Lcom/luxury/mobile/gui/util/RawText;

    add-int v3, p2, p4

    invoke-interface {p1, p2, v3}, Ljava/lang/CharSequence;->subSequence(II)Ljava/lang/CharSequence;

    move-result-object v3

    invoke-interface {v3}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {p0, v3}, Lcom/luxury/mobile/gui/util/MaskedEditText;->clear(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    iget v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->maxRawLength:I

    invoke-virtual {v2, v3, v1, v4}, Lcom/luxury/mobile/gui/util/RawText;->addToString(Ljava/lang/String;II)I

    move-result v2

    .line 236
    .local v2, "count2":I
    iget-boolean v3, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->initialized:Z

    if-eqz v3, :cond_1

    .line 237
    add-int v3, v1, v2

    .line 238
    .local v3, "i":I
    iget-object v4, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->rawToMask:[I

    .line 239
    .local v4, "iArr":[I
    array-length v5, v4

    if-ge v3, v5, :cond_0

    .line 240
    add-int v0, v1, v2

    aget v0, v4, v0

    .local v0, "currentPosition":I
    goto :goto_0

    .line 242
    .end local v0    # "currentPosition":I
    :cond_0
    iget v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->lastValidMaskPosition:I

    add-int/2addr v0, v5

    .line 244
    .restart local v0    # "currentPosition":I
    :goto_0
    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->nextValidPosition(I)I

    move-result v5

    iput v5, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->selection:I

    .line 248
    .end local v0    # "currentPosition":I
    .end local v1    # "startingPosition":I
    .end local v2    # "count2":I
    .end local v3    # "i":I
    .end local v4    # "iArr":[I
    :cond_1
    return-void
.end method

.method public setCharRepresentation(C)V
    .locals 0
    .param p1, "charRepresentation2"    # C

    .line 161
    iput-char p1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->charRepresentation:C

    .line 162
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->cleanUp()V

    .line 163
    return-void
.end method

.method public setKeepHint(Z)V
    .locals 1
    .param p1, "keepHint2"    # Z

    .line 272
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->keepHint:Z

    .line 273
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->getRawText()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->setText(Ljava/lang/CharSequence;)V

    .line 274
    return-void
.end method

.method public setMask(Ljava/lang/String;)V
    .locals 0
    .param p1, "mask2"    # Ljava/lang/String;

    .line 148
    iput-object p1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->mask:Ljava/lang/String;

    .line 149
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/MaskedEditText;->cleanUp()V

    .line 150
    return-void
.end method

.method public setOnFocusChangeListener(Landroid/view/View$OnFocusChangeListener;)V
    .locals 0
    .param p1, "listener"    # Landroid/view/View$OnFocusChangeListener;

    .line 91
    iput-object p1, p0, Lcom/luxury/mobile/gui/util/MaskedEditText;->focusChangeListener:Landroid/view/View$OnFocusChangeListener;

    .line 92
    return-void
.end method

.method public setText(Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V
    .locals 0
    .param p1, "text"    # Ljava/lang/CharSequence;
    .param p2, "type"    # Landroid/widget/TextView$BufferType;

    .line 87
    invoke-static {p0, p1, p2}, Lcom/luxury/mobile/gui/util/MaskedEditText;->access$201(Lcom/luxury/mobile/gui/util/MaskedEditText;Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V

    .line 88
    return-void
.end method
