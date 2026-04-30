.class public Lcom/luxury/mobile/gui/util/SeekArc;
.super Landroid/view/View;
.source "SeekArc.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;
    }
.end annotation


# static fields
.field private static INVALID_PROGRESS_VALUE:I

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private final mAngleOffset:I

.field private mArcPaint:Landroid/graphics/Paint;

.field private mArcRadius:I

.field private mArcRect:Landroid/graphics/RectF;

.field private mArcWidth:I

.field private mClockwise:Z

.field private mEnabled:Z

.field private mMax:I

.field private mOnSeekArcChangeListener:Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;

.field private mProgress:I

.field private mProgressPaint:Landroid/graphics/Paint;

.field private mProgressSweep:F

.field private mProgressWidth:I

.field private mRotation:I

.field private mRoundedEdges:Z

.field private mStartAngle:I

.field private mSweepAngle:I

.field private mThumb:Landroid/graphics/drawable/Drawable;

.field private mThumbXPos:I

.field private mThumbYPos:I

.field private mTouchAngle:D

.field private mTouchIgnoreRadius:F

.field private mTouchInside:Z

.field private mTranslateX:I

.field private mTranslateY:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 52
    const-class v0, Lcom/luxury/mobile/gui/util/SeekArc;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/luxury/mobile/gui/util/SeekArc;->TAG:Ljava/lang/String;

    .line 53
    const/4 v0, -0x1

    sput v0, Lcom/luxury/mobile/gui/util/SeekArc;->INVALID_PROGRESS_VALUE:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 156
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 55
    const/16 v0, -0x5a

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mAngleOffset:I

    .line 65
    const/16 v0, 0x64

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    .line 70
    const/4 v0, 0x0

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 75
    const/4 v1, 0x4

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    .line 80
    const/4 v1, 0x2

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    .line 85
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 90
    const/16 v1, 0x168

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 95
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    .line 100
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    .line 105
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    .line 110
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    .line 116
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    .line 119
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    .line 120
    const/4 v1, 0x0

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    .line 121
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    .line 157
    const/4 v1, 0x0

    invoke-direct {p0, p1, v1, v0}, Lcom/luxury/mobile/gui/util/SeekArc;->init(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 158
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 161
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 55
    const/16 v0, -0x5a

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mAngleOffset:I

    .line 65
    const/16 v0, 0x64

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    .line 70
    const/4 v0, 0x0

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 75
    const/4 v1, 0x4

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    .line 80
    const/4 v1, 0x2

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    .line 85
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 90
    const/16 v1, 0x168

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 95
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    .line 100
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    .line 105
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    .line 110
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    .line 116
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    .line 119
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    .line 120
    const/4 v0, 0x0

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    .line 121
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    .line 162
    const v0, 0x7f030266

    invoke-direct {p0, p1, p2, v0}, Lcom/luxury/mobile/gui/util/SeekArc;->init(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 163
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 166
    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 55
    const/16 v0, -0x5a

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mAngleOffset:I

    .line 65
    const/16 v0, 0x64

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    .line 70
    const/4 v0, 0x0

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 75
    const/4 v1, 0x4

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    .line 80
    const/4 v1, 0x2

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    .line 85
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 90
    const/16 v1, 0x168

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 95
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    .line 100
    iput-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    .line 105
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    .line 110
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    .line 116
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    .line 119
    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    .line 120
    const/4 v0, 0x0

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    .line 121
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    .line 167
    invoke-direct {p0, p1, p2, p3}, Lcom/luxury/mobile/gui/util/SeekArc;->init(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 168
    return-void
.end method

.method private getProgressForAngle(D)I
    .locals 2
    .param p1, "angle"    # D

    .line 397
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->valuePerDegree()F

    move-result v0

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v0, v0, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v1, v0

    .line 399
    .local v1, "touchProgress":I
    if-gez v1, :cond_0

    sget v0, Lcom/luxury/mobile/gui/util/SeekArc;->INVALID_PROGRESS_VALUE:I

    goto :goto_0

    .line 400
    :cond_0
    move v0, v1

    :goto_0
    nop

    .line 401
    .end local v1    # "touchProgress":I
    .local v0, "touchProgress":I
    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    if-le v0, v1, :cond_1

    sget v1, Lcom/luxury/mobile/gui/util/SeekArc;->INVALID_PROGRESS_VALUE:I

    goto :goto_1

    .line 402
    :cond_1
    move v1, v0

    :goto_1
    move v0, v1

    .line 403
    return v0
.end method

.method private getTouchDegrees(FF)D
    .locals 7
    .param p1, "xPos"    # F
    .param p2, "yPos"    # F

    .line 382
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateX:I

    int-to-float v0, v0

    sub-float v0, p1, v0

    .line 383
    .local v0, "x":F
    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateY:I

    int-to-float v1, v1

    sub-float v1, p2, v1

    .line 385
    .local v1, "y":F
    iget-boolean v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    if-eqz v2, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    neg-float v2, v0

    :goto_0
    move v0, v2

    .line 387
    float-to-double v2, v1

    float-to-double v4, v0

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v2

    const-wide v4, 0x3ff921fb54442d18L    # 1.5707963267948966

    add-double/2addr v2, v4

    iget v4, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    int-to-double v4, v4

    .line 388
    invoke-static {v4, v5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    sub-double/2addr v2, v4

    .line 387
    invoke-static {v2, v3}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v2

    .line 389
    .local v2, "angle":D
    const-wide/16 v4, 0x0

    cmpg-double v6, v2, v4

    if-gez v6, :cond_1

    .line 390
    const-wide v4, 0x4076800000000000L    # 360.0

    add-double/2addr v2, v4

    .line 392
    :cond_1
    iget v4, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    int-to-double v4, v4

    invoke-static {v4, v5}, Ljava/lang/Double;->isNaN(D)Z

    sub-double/2addr v2, v4

    .line 393
    return-wide v2
.end method

.method private ignoreTouch(FF)Z
    .locals 5
    .param p1, "xPos"    # F
    .param p2, "yPos"    # F

    .line 370
    const/4 v0, 0x0

    .line 371
    .local v0, "ignore":Z
    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateX:I

    int-to-float v1, v1

    sub-float v1, p1, v1

    .line 372
    .local v1, "x":F
    iget v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateY:I

    int-to-float v2, v2

    sub-float v2, p2, v2

    .line 374
    .local v2, "y":F
    mul-float v3, v1, v1

    mul-float v4, v2, v2

    add-float/2addr v3, v4

    float-to-double v3, v3

    invoke-static {v3, v4}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v3

    double-to-float v3, v3

    .line 375
    .local v3, "touchRadius":F
    iget v4, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchIgnoreRadius:F

    cmpg-float v4, v3, v4

    if-gez v4, :cond_0

    .line 376
    const/4 v0, 0x1

    .line 378
    :cond_0
    return v0
.end method

.method private init(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 16
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 172
    move-object/from16 v0, p0

    move-object/from16 v1, p2

    sget-object v2, Lcom/luxury/mobile/gui/util/SeekArc;->TAG:Ljava/lang/String;

    const-string v3, "Initialising SeekArc"

    invoke-static {v2, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 173
    invoke-virtual/range {p0 .. p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    .line 174
    .local v2, "res":Landroid/content/res/Resources;
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v3

    invoke-virtual {v3}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v3

    iget v3, v3, Landroid/util/DisplayMetrics;->density:F

    .line 177
    .local v3, "density":F
    const v4, 0x7f050096

    invoke-virtual {v2, v4}, Landroid/content/res/Resources;->getColor(I)I

    move-result v4

    .line 178
    .local v4, "arcColor":I
    const v5, 0x7f05003d

    invoke-virtual {v2, v5}, Landroid/content/res/Resources;->getColor(I)I

    move-result v5

    .line 179
    .local v5, "progressColor":I
    const/4 v6, 0x0

    .line 180
    .local v6, "thumbHalfheight":I
    const/4 v7, 0x0

    .line 181
    .local v7, "thumbHalfWidth":I
    const v8, 0x7f070111

    invoke-virtual {v2, v8}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v8

    iput-object v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    .line 183
    iget v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    int-to-float v8, v8

    mul-float v8, v8, v3

    float-to-int v8, v8

    iput v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    .line 186
    const/4 v8, 0x1

    const/4 v9, 0x0

    if-eqz v1, :cond_1

    .line 188
    sget-object v10, Lcom/luxury/mobile/R$styleable;->SeekArc:[I

    move-object/from16 v11, p1

    move/from16 v12, p3

    invoke-virtual {v11, v1, v10, v12, v9}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object v10

    .line 191
    .local v10, "a":Landroid/content/res/TypedArray;
    const/16 v13, 0xc

    invoke-virtual {v10, v13}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v13

    .line 192
    .local v13, "thumb":Landroid/graphics/drawable/Drawable;
    if-eqz v13, :cond_0

    .line 193
    iput-object v13, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    .line 198
    :cond_0
    iget-object v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v14}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v14

    const/4 v15, 0x2

    div-int/lit8 v6, v14, 0x2

    .line 199
    iget-object v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v14}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v14

    div-int/lit8 v7, v14, 0x2

    .line 200
    iget-object v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    neg-int v9, v7

    neg-int v15, v6

    invoke-virtual {v14, v9, v15, v7, v6}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 203
    const/4 v9, 0x4

    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    .line 204
    const/4 v9, 0x5

    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 205
    const/4 v9, 0x7

    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    int-to-float v14, v14

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v9

    float-to-int v9, v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    .line 207
    iget v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    int-to-float v9, v9

    invoke-virtual {v10, v8, v9}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v9

    float-to-int v9, v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    .line 209
    const/16 v9, 0xa

    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 210
    const/16 v9, 0xb

    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 211
    const/16 v9, 0x8

    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v9

    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    .line 212
    const/16 v9, 0x9

    iget-boolean v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    .line 214
    const/16 v9, 0xe

    iget-boolean v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    .line 216
    iget-boolean v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    const/4 v14, 0x2

    invoke-virtual {v10, v14, v9}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    .line 218
    const/4 v9, 0x3

    iget-boolean v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    invoke-virtual {v10, v9, v14}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    .line 220
    const/4 v9, 0x0

    invoke-virtual {v10, v9, v4}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v4

    .line 221
    const/4 v14, 0x6

    invoke-virtual {v10, v14, v5}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v5

    .line 224
    invoke-virtual {v10}, Landroid/content/res/TypedArray;->recycle()V

    goto :goto_0

    .line 186
    .end local v10    # "a":Landroid/content/res/TypedArray;
    .end local v13    # "thumb":Landroid/graphics/drawable/Drawable;
    :cond_1
    move-object/from16 v11, p1

    move/from16 v12, p3

    .line 227
    :goto_0
    iget v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    iget v13, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    if-le v10, v13, :cond_2

    move v10, v13

    :cond_2
    iput v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 228
    if-gez v10, :cond_3

    const/4 v10, 0x0

    :cond_3
    iput v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 230
    iget v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    const/16 v13, 0x168

    if-le v10, v13, :cond_4

    const/16 v10, 0x168

    :cond_4
    iput v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 231
    if-gez v10, :cond_5

    const/4 v10, 0x0

    :cond_5
    iput v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 233
    iget v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    int-to-float v14, v14

    iget v15, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    int-to-float v15, v15

    div-float/2addr v14, v15

    int-to-float v10, v10

    mul-float v14, v14, v10

    iput v14, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    .line 235
    iget v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    if-le v10, v13, :cond_6

    const/4 v10, 0x0

    :cond_6
    iput v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 236
    if-gez v10, :cond_7

    goto :goto_1

    :cond_7
    move v9, v10

    :goto_1
    iput v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 238
    new-instance v9, Landroid/graphics/Paint;

    invoke-direct {v9}, Landroid/graphics/Paint;-><init>()V

    iput-object v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    .line 239
    invoke-virtual {v9, v4}, Landroid/graphics/Paint;->setColor(I)V

    .line 240
    iget-object v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    invoke-virtual {v9, v8}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 241
    iget-object v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v10, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v9, v10}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 242
    iget-object v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    iget v10, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    int-to-float v10, v10

    invoke-virtual {v9, v10}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 245
    new-instance v9, Landroid/graphics/Paint;

    invoke-direct {v9}, Landroid/graphics/Paint;-><init>()V

    iput-object v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    .line 246
    invoke-virtual {v9, v5}, Landroid/graphics/Paint;->setColor(I)V

    .line 247
    iget-object v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    invoke-virtual {v9, v8}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 248
    iget-object v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v9, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v8, v9}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 249
    iget-object v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    iget v9, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    int-to-float v9, v9

    invoke-virtual {v8, v9}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 251
    iget-boolean v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    if-eqz v8, :cond_8

    .line 252
    iget-object v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v9, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v8, v9}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 253
    iget-object v8, v0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v9, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v8, v9}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 255
    :cond_8
    return-void
.end method

.method private onProgressRefresh(IZ)V
    .locals 0
    .param p1, "progress"    # I
    .param p2, "fromUser"    # Z

    .line 411
    invoke-direct {p0, p1, p2}, Lcom/luxury/mobile/gui/util/SeekArc;->updateProgress(IZ)V

    .line 412
    return-void
.end method

.method private onStartTrackingTouch()V
    .locals 1

    .line 347
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mOnSeekArcChangeListener:Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;

    if-eqz v0, :cond_0

    .line 348
    invoke-interface {v0, p0}, Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;->onStartTrackingTouch(Lcom/luxury/mobile/gui/util/SeekArc;)V

    .line 350
    :cond_0
    return-void
.end method

.method private onStopTrackingTouch()V
    .locals 1

    .line 353
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mOnSeekArcChangeListener:Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;

    if-eqz v0, :cond_0

    .line 354
    invoke-interface {v0, p0}, Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;->onStopTrackingTouch(Lcom/luxury/mobile/gui/util/SeekArc;)V

    .line 356
    :cond_0
    return-void
.end method

.method private updateOnTouch(Landroid/view/MotionEvent;)V
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 359
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/luxury/mobile/gui/util/SeekArc;->ignoreTouch(FF)Z

    move-result v0

    .line 360
    .local v0, "ignoreTouch":Z
    if-eqz v0, :cond_0

    .line 361
    return-void

    .line 363
    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/util/SeekArc;->setPressed(Z)V

    .line 364
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    invoke-direct {p0, v2, v3}, Lcom/luxury/mobile/gui/util/SeekArc;->getTouchDegrees(FF)D

    move-result-wide v2

    iput-wide v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchAngle:D

    .line 365
    invoke-direct {p0, v2, v3}, Lcom/luxury/mobile/gui/util/SeekArc;->getProgressForAngle(D)I

    move-result v2

    .line 366
    .local v2, "progress":I
    invoke-direct {p0, v2, v1}, Lcom/luxury/mobile/gui/util/SeekArc;->onProgressRefresh(IZ)V

    .line 367
    return-void
.end method

.method private updateProgress(IZ)V
    .locals 2
    .param p1, "progress"    # I
    .param p2, "fromUser"    # Z

    .line 422
    sget v0, Lcom/luxury/mobile/gui/util/SeekArc;->INVALID_PROGRESS_VALUE:I

    if-ne p1, v0, :cond_0

    .line 423
    return-void

    .line 426
    :cond_0
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    if-le p1, v0, :cond_1

    goto :goto_0

    :cond_1
    move v0, p1

    :goto_0
    move p1, v0

    .line 427
    if-gez p1, :cond_2

    const/4 v0, 0x0

    goto :goto_1

    :cond_2
    move v0, p1

    :goto_1
    move p1, v0

    .line 428
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    .line 430
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mOnSeekArcChangeListener:Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;

    if-eqz v0, :cond_3

    .line 431
    nop

    .line 432
    invoke-interface {v0, p0, p1, p2}, Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;->onProgressChanged(Lcom/luxury/mobile/gui/util/SeekArc;IZ)V

    .line 435
    :cond_3
    int-to-float v0, p1

    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    int-to-float v1, v1

    div-float/2addr v0, v1

    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    int-to-float v1, v1

    mul-float v0, v0, v1

    iput v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    .line 437
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->updateThumbPosition()V

    .line 439
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->invalidate()V

    .line 440
    return-void
.end method

.method private updateThumbPosition()V
    .locals 5

    .line 415
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    int-to-float v0, v0

    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    add-float/2addr v0, v1

    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    int-to-float v1, v1

    add-float/2addr v0, v1

    const/high16 v1, 0x42b40000    # 90.0f

    add-float/2addr v0, v1

    float-to-int v0, v0

    .line 416
    .local v0, "thumbAngle":I
    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    int-to-double v1, v1

    int-to-double v3, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->cos(D)D

    move-result-wide v3

    invoke-static {v1, v2}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v1, v1, v3

    double-to-int v1, v1

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumbXPos:I

    .line 417
    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    int-to-double v1, v1

    int-to-double v3, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->sin(D)D

    move-result-wide v3

    invoke-static {v1, v2}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v1, v1, v3

    double-to-int v1, v1

    iput v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumbYPos:I

    .line 418
    return-void
.end method

.method private valuePerDegree()F
    .locals 2

    .line 407
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    int-to-float v0, v0

    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    int-to-float v1, v1

    div-float/2addr v0, v1

    return v0
.end method


# virtual methods
.method protected drawableStateChanged()V
    .locals 2

    .line 338
    invoke-super {p0}, Landroid/view/View;->drawableStateChanged()V

    .line 339
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 340
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getDrawableState()[I

    move-result-object v0

    .line 341
    .local v0, "state":[I
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v0}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 343
    .end local v0    # "state":[I
    :cond_0
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->invalidate()V

    .line 344
    return-void
.end method

.method public getArcColor()I
    .locals 1

    .line 549
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getArcRotation()I
    .locals 1

    .line 473
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    return v0
.end method

.method public getArcWidth()I
    .locals 1

    .line 465
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    return v0
.end method

.method public getMax()I
    .locals 1

    .line 558
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    return v0
.end method

.method public getProgress()I
    .locals 1

    .line 452
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgress:I

    return v0
.end method

.method public getProgressColor()I
    .locals 1

    .line 540
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getProgressWidth()I
    .locals 1

    .line 456
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    return v0
.end method

.method public getStartAngle()I
    .locals 1

    .line 482
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    return v0
.end method

.method public getSweepAngle()I
    .locals 1

    .line 491
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    return v0
.end method

.method public isClockwise()Z
    .locals 1

    .line 528
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    return v0
.end method

.method public isEnabled()Z
    .locals 1

    .line 532
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 14
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 259
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    if-nez v0, :cond_0

    .line 260
    const/high16 v0, -0x40800000    # -1.0f

    const/high16 v1, 0x3f800000    # 1.0f

    iget-object v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->centerX()F

    move-result v2

    iget-object v3, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    invoke-virtual {v3}, Landroid/graphics/RectF;->centerY()F

    move-result v3

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->scale(FFFF)V

    .line 264
    :cond_0
    iget v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    add-int/lit8 v0, v0, -0x5a

    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    add-int/2addr v0, v1

    .line 265
    .local v0, "arcStart":I
    iget v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 266
    .local v1, "arcSweep":I
    iget-object v3, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    int-to-float v4, v0

    int-to-float v5, v1

    const/4 v6, 0x0

    iget-object v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    move-object v2, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 267
    iget-object v9, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    int-to-float v10, v0

    iget v11, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    const/4 v12, 0x0

    iget-object v13, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    move-object v8, p1

    invoke-virtual/range {v8 .. v13}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 270
    iget-boolean v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    if-eqz v2, :cond_1

    .line 272
    iget v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateX:I

    iget v3, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumbXPos:I

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iget v3, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateY:I

    iget v4, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumbYPos:I

    sub-int/2addr v3, v4

    int-to-float v3, v3

    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->translate(FF)V

    .line 273
    iget-object v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 275
    :cond_1
    return-void
.end method

.method protected onMeasure(II)V
    .locals 11
    .param p1, "widthMeasureSpec"    # I
    .param p2, "heightMeasureSpec"    # I

    .line 281
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getSuggestedMinimumHeight()I

    move-result v0

    invoke-static {v0, p2}, Lcom/luxury/mobile/gui/util/SeekArc;->getDefaultSize(II)I

    move-result v0

    .line 283
    .local v0, "height":I
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getSuggestedMinimumWidth()I

    move-result v1

    invoke-static {v1, p1}, Lcom/luxury/mobile/gui/util/SeekArc;->getDefaultSize(II)I

    move-result v1

    .line 285
    .local v1, "width":I
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 286
    .local v2, "min":I
    const/4 v3, 0x0

    .line 287
    .local v3, "top":F
    const/4 v4, 0x0

    .line 288
    .local v4, "left":F
    const/4 v5, 0x0

    .line 290
    .local v5, "arcDiameter":I
    int-to-float v6, v1

    const/high16 v7, 0x3f000000    # 0.5f

    mul-float v6, v6, v7

    float-to-int v6, v6

    iput v6, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateX:I

    .line 291
    int-to-float v6, v0

    mul-float v6, v6, v7

    float-to-int v6, v6

    iput v6, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTranslateY:I

    .line 293
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getPaddingLeft()I

    move-result v6

    sub-int v5, v2, v6

    .line 294
    div-int/lit8 v6, v5, 0x2

    iput v6, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    .line 295
    div-int/lit8 v6, v0, 0x2

    div-int/lit8 v7, v5, 0x2

    sub-int/2addr v6, v7

    int-to-float v3, v6

    .line 296
    div-int/lit8 v6, v1, 0x2

    div-int/lit8 v7, v5, 0x2

    sub-int/2addr v6, v7

    int-to-float v4, v6

    .line 297
    iget-object v6, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRect:Landroid/graphics/RectF;

    int-to-float v7, v5

    add-float/2addr v7, v4

    int-to-float v8, v5

    add-float/2addr v8, v3

    invoke-virtual {v6, v4, v3, v7, v8}, Landroid/graphics/RectF;->set(FFFF)V

    .line 299
    iget v6, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressSweep:F

    float-to-int v6, v6

    iget v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    add-int/2addr v6, v7

    iget v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    add-int/2addr v6, v7

    add-int/lit8 v6, v6, 0x5a

    .line 300
    .local v6, "arcStart":I
    iget v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    int-to-double v7, v7

    int-to-double v9, v6

    invoke-static {v9, v10}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Math;->cos(D)D

    move-result-wide v9

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    double-to-int v7, v7

    iput v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumbXPos:I

    .line 301
    iget v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    int-to-double v7, v7

    int-to-double v9, v6

    invoke-static {v9, v10}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Math;->sin(D)D

    move-result-wide v9

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    double-to-int v7, v7

    iput v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumbYPos:I

    .line 303
    iget-boolean v7, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    invoke-virtual {p0, v7}, Lcom/luxury/mobile/gui/util/SeekArc;->setTouchInSide(Z)V

    .line 304
    invoke-super {p0, p1, p2}, Landroid/view/View;->onMeasure(II)V

    .line 305
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 309
    iget-boolean v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    .line 310
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    const/4 v2, 0x1

    invoke-interface {v0, v2}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 312
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-eqz v0, :cond_3

    if-eq v0, v2, :cond_2

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    const/4 v3, 0x3

    if-eq v0, v3, :cond_0

    goto :goto_0

    .line 326
    :cond_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->onStopTrackingTouch()V

    .line 327
    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/util/SeekArc;->setPressed(Z)V

    .line 328
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    goto :goto_0

    .line 318
    :cond_1
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/util/SeekArc;->updateOnTouch(Landroid/view/MotionEvent;)V

    .line 319
    goto :goto_0

    .line 321
    :cond_2
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->onStopTrackingTouch()V

    .line 322
    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/util/SeekArc;->setPressed(Z)V

    .line 323
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 324
    goto :goto_0

    .line 314
    :cond_3
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->onStartTrackingTouch()V

    .line 315
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/util/SeekArc;->updateOnTouch(Landroid/view/MotionEvent;)V

    .line 316
    nop

    .line 331
    :goto_0
    return v2

    .line 333
    :cond_4
    return v1
.end method

.method public setArcColor(I)V
    .locals 1
    .param p1, "color"    # I

    .line 553
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 554
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->invalidate()V

    .line 555
    return-void
.end method

.method public setArcRotation(I)V
    .locals 0
    .param p1, "mRotation"    # I

    .line 477
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRotation:I

    .line 478
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->updateThumbPosition()V

    .line 479
    return-void
.end method

.method public setArcWidth(I)V
    .locals 2
    .param p1, "mArcWidth"    # I

    .line 469
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcWidth:I

    .line 470
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    int-to-float v1, p1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 471
    return-void
.end method

.method public setClockwise(Z)V
    .locals 0
    .param p1, "isClockwise"    # Z

    .line 524
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mClockwise:Z

    .line 525
    return-void
.end method

.method public setEnabled(Z)V
    .locals 0
    .param p1, "enabled"    # Z

    .line 536
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mEnabled:Z

    .line 537
    return-void
.end method

.method public setMax(I)V
    .locals 0
    .param p1, "mMax"    # I

    .line 562
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mMax:I

    .line 563
    return-void
.end method

.method public setOnSeekArcChangeListener(Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;)V
    .locals 0
    .param p1, "l"    # Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;

    .line 444
    iput-object p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mOnSeekArcChangeListener:Lcom/luxury/mobile/gui/util/SeekArc$OnSeekArcChangeListener;

    .line 445
    return-void
.end method

.method public setProgress(I)V
    .locals 1
    .param p1, "progress"    # I

    .line 448
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/luxury/mobile/gui/util/SeekArc;->updateProgress(IZ)V

    .line 449
    return-void
.end method

.method public setProgressColor(I)V
    .locals 1
    .param p1, "color"    # I

    .line 544
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 545
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->invalidate()V

    .line 546
    return-void
.end method

.method public setProgressWidth(I)V
    .locals 2
    .param p1, "mProgressWidth"    # I

    .line 460
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressWidth:I

    .line 461
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    int-to-float v1, p1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 462
    return-void
.end method

.method public setRoundedEdges(Z)V
    .locals 2
    .param p1, "isEnabled"    # Z

    .line 500
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mRoundedEdges:Z

    .line 501
    if-eqz p1, :cond_0

    .line 502
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 503
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    goto :goto_0

    .line 505
    :cond_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->SQUARE:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 506
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->SQUARE:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 508
    :goto_0
    return-void
.end method

.method public setStartAngle(I)V
    .locals 0
    .param p1, "mStartAngle"    # I

    .line 486
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mStartAngle:I

    .line 487
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->updateThumbPosition()V

    .line 488
    return-void
.end method

.method public setSweepAngle(I)V
    .locals 0
    .param p1, "mSweepAngle"    # I

    .line 495
    iput p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mSweepAngle:I

    .line 496
    invoke-direct {p0}, Lcom/luxury/mobile/gui/util/SeekArc;->updateThumbPosition()V

    .line 497
    return-void
.end method

.method public setTouchInSide(Z)V
    .locals 4
    .param p1, "isEnabled"    # Z

    .line 511
    iget-object v0, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    .line 512
    .local v0, "thumbHalfheight":I
    iget-object v1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    .line 513
    .local v1, "thumbHalfWidth":I
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchInside:Z

    .line 514
    if-eqz p1, :cond_0

    .line 515
    iget v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    int-to-float v2, v2

    const/high16 v3, 0x40800000    # 4.0f

    div-float/2addr v2, v3

    iput v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchIgnoreRadius:F

    goto :goto_0

    .line 518
    :cond_0
    iget v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mArcRadius:I

    .line 519
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v3

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iput v2, p0, Lcom/luxury/mobile/gui/util/SeekArc;->mTouchIgnoreRadius:F

    .line 521
    :goto_0
    return-void
.end method
