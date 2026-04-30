.class public Lcom/triggertrap/seekarc/SeekArc;
.super Landroid/view/View;
.source "SeekArc.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;
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

.field private mOnSeekArcChangeListener:Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;

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

    .line 50
    const-class v0, Lcom/triggertrap/seekarc/SeekArc;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/triggertrap/seekarc/SeekArc;->TAG:Ljava/lang/String;

    .line 51
    const/4 v0, -0x1

    sput v0, Lcom/triggertrap/seekarc/SeekArc;->INVALID_PROGRESS_VALUE:I

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 169
    invoke-direct {p0, p1}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 53
    const/16 v0, -0x5a

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mAngleOffset:I

    .line 63
    const/16 v0, 0x64

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    .line 68
    const/4 v0, 0x0

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 73
    const/4 v1, 0x4

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    .line 78
    const/4 v1, 0x2

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    .line 83
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 88
    const/16 v1, 0x168

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 93
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    .line 98
    iput-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    .line 103
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    .line 108
    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    .line 114
    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    .line 117
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    .line 118
    const/4 v1, 0x0

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    .line 119
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    .line 170
    const/4 v1, 0x0

    invoke-direct {p0, p1, v1, v0}, Lcom/triggertrap/seekarc/SeekArc;->init(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 171
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 174
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 53
    const/16 v0, -0x5a

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mAngleOffset:I

    .line 63
    const/16 v0, 0x64

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    .line 68
    const/4 v0, 0x0

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 73
    const/4 v1, 0x4

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    .line 78
    const/4 v1, 0x2

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    .line 83
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 88
    const/16 v1, 0x168

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 93
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    .line 98
    iput-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    .line 103
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    .line 108
    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    .line 114
    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    .line 117
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    .line 118
    const/4 v0, 0x0

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    .line 119
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    .line 175
    sget v0, Lcom/triggertrap/seekarc/R$attr;->seekArcStyle:I

    invoke-direct {p0, p1, p2, v0}, Lcom/triggertrap/seekarc/SeekArc;->init(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 176
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 2
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 179
    invoke-direct {p0, p1, p2, p3}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 53
    const/16 v0, -0x5a

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mAngleOffset:I

    .line 63
    const/16 v0, 0x64

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    .line 68
    const/4 v0, 0x0

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 73
    const/4 v1, 0x4

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    .line 78
    const/4 v1, 0x2

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    .line 83
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 88
    const/16 v1, 0x168

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 93
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    .line 98
    iput-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    .line 103
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    .line 108
    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    .line 114
    iput-boolean v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    .line 117
    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    .line 118
    const/4 v0, 0x0

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    .line 119
    new-instance v0, Landroid/graphics/RectF;

    invoke-direct {v0}, Landroid/graphics/RectF;-><init>()V

    iput-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    .line 180
    invoke-direct {p0, p1, p2, p3}, Lcom/triggertrap/seekarc/SeekArc;->init(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    .line 181
    return-void
.end method

.method private getProgressForAngle(D)I
    .locals 2
    .param p1, "angle"    # D

    .line 410
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->valuePerDegree()F

    move-result v0

    float-to-double v0, v0

    invoke-static {v0, v1}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v0, v0, p1

    invoke-static {v0, v1}, Ljava/lang/Math;->round(D)J

    move-result-wide v0

    long-to-int v1, v0

    .line 412
    .local v1, "touchProgress":I
    if-gez v1, :cond_0

    sget v0, Lcom/triggertrap/seekarc/SeekArc;->INVALID_PROGRESS_VALUE:I

    goto :goto_0

    :cond_0
    move v0, v1

    .line 414
    .end local v1    # "touchProgress":I
    .local v0, "touchProgress":I
    :goto_0
    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    if-le v0, v1, :cond_1

    sget v1, Lcom/triggertrap/seekarc/SeekArc;->INVALID_PROGRESS_VALUE:I

    goto :goto_1

    :cond_1
    move v1, v0

    :goto_1
    move v0, v1

    .line 416
    return v0
.end method

.method private getTouchDegrees(FF)D
    .locals 7
    .param p1, "xPos"    # F
    .param p2, "yPos"    # F

    .line 395
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateX:I

    int-to-float v0, v0

    sub-float v0, p1, v0

    .line 396
    .local v0, "x":F
    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateY:I

    int-to-float v1, v1

    sub-float v1, p2, v1

    .line 398
    .local v1, "y":F
    iget-boolean v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    if-eqz v2, :cond_0

    move v2, v0

    goto :goto_0

    :cond_0
    neg-float v2, v0

    :goto_0
    move v0, v2

    .line 400
    float-to-double v2, v1

    float-to-double v4, v0

    invoke-static {v2, v3, v4, v5}, Ljava/lang/Math;->atan2(DD)D

    move-result-wide v2

    const-wide v4, 0x3ff921fb54442d18L    # 1.5707963267948966

    add-double/2addr v2, v4

    iget v4, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    int-to-double v4, v4

    .line 401
    invoke-static {v4, v5}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v4

    sub-double/2addr v2, v4

    .line 400
    invoke-static {v2, v3}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v2

    .line 402
    .local v2, "angle":D
    const-wide/16 v4, 0x0

    cmpg-double v6, v2, v4

    if-gez v6, :cond_1

    .line 403
    const-wide v4, 0x4076800000000000L    # 360.0

    add-double/2addr v2, v4

    .line 405
    :cond_1
    iget v4, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    int-to-double v4, v4

    invoke-static {v4, v5}, Ljava/lang/Double;->isNaN(D)Z

    sub-double/2addr v2, v4

    .line 406
    return-wide v2
.end method

.method private ignoreTouch(FF)Z
    .locals 5
    .param p1, "xPos"    # F
    .param p2, "yPos"    # F

    .line 383
    const/4 v0, 0x0

    .line 384
    .local v0, "ignore":Z
    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateX:I

    int-to-float v1, v1

    sub-float v1, p1, v1

    .line 385
    .local v1, "x":F
    iget v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateY:I

    int-to-float v2, v2

    sub-float v2, p2, v2

    .line 387
    .local v2, "y":F
    mul-float v3, v1, v1

    mul-float v4, v2, v2

    add-float/2addr v3, v4

    float-to-double v3, v3

    invoke-static {v3, v4}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v3

    double-to-float v3, v3

    .line 388
    .local v3, "touchRadius":F
    iget v4, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchIgnoreRadius:F

    cmpg-float v4, v3, v4

    if-gez v4, :cond_0

    .line 389
    const/4 v0, 0x1

    .line 391
    :cond_0
    return v0
.end method

.method private init(Landroid/content/Context;Landroid/util/AttributeSet;I)V
    .locals 12
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;
    .param p3, "defStyle"    # I

    .line 185
    sget-object v0, Lcom/triggertrap/seekarc/SeekArc;->TAG:Ljava/lang/String;

    const-string v1, "Initialising SeekArc"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 186
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    .line 187
    .local v0, "res":Landroid/content/res/Resources;
    invoke-virtual {p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v1

    iget v1, v1, Landroid/util/DisplayMetrics;->density:F

    .line 190
    .local v1, "density":F
    sget v2, Lcom/triggertrap/seekarc/R$color;->progress_gray:I

    invoke-virtual {v0, v2}, Landroid/content/res/Resources;->getColor(I)I

    move-result v2

    .line 191
    .local v2, "arcColor":I
    sget v3, Lcom/triggertrap/seekarc/R$color;->default_blue_light:I

    invoke-virtual {v0, v3}, Landroid/content/res/Resources;->getColor(I)I

    move-result v3

    .line 192
    .local v3, "progressColor":I
    const/4 v4, 0x0

    .line 193
    .local v4, "thumbHalfheight":I
    const/4 v5, 0x0

    .line 194
    .local v5, "thumbHalfWidth":I
    sget v6, Lcom/triggertrap/seekarc/R$drawable;->seek_arc_control_selector:I

    invoke-virtual {v0, v6}, Landroid/content/res/Resources;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v6

    iput-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    .line 196
    iget v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    int-to-float v6, v6

    mul-float v6, v6, v1

    float-to-int v6, v6

    iput v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    .line 199
    const/4 v6, 0x0

    if-eqz p2, :cond_1

    .line 201
    sget-object v7, Lcom/triggertrap/seekarc/R$styleable;->SeekArc:[I

    invoke-virtual {p1, p2, v7, p3, v6}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[III)Landroid/content/res/TypedArray;

    move-result-object v7

    .line 204
    .local v7, "a":Landroid/content/res/TypedArray;
    sget v8, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_thumb:I

    invoke-virtual {v7, v8}, Landroid/content/res/TypedArray;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object v8

    .line 205
    .local v8, "thumb":Landroid/graphics/drawable/Drawable;
    if-eqz v8, :cond_0

    .line 206
    iput-object v8, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    .line 211
    :cond_0
    iget-object v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v9}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v9

    div-int/lit8 v4, v9, 0x2

    .line 212
    iget-object v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v9}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v9

    div-int/lit8 v5, v9, 0x2

    .line 213
    iget-object v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    neg-int v10, v5

    neg-int v11, v4

    invoke-virtual {v9, v10, v11, v5, v4}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 216
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_max:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    .line 217
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_progress:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getInteger(II)I

    move-result v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 218
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_progressWidth:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    int-to-float v10, v10

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v9

    float-to-int v9, v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    .line 220
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_arcWidth:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    int-to-float v10, v10

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getDimension(IF)F

    move-result v9

    float-to-int v9, v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    .line 222
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_startAngle:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 223
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_sweepAngle:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 224
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_rotation:I

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getInt(II)I

    move-result v9

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    .line 225
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_roundEdges:I

    iget-boolean v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    .line 227
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_touchInside:I

    iget-boolean v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    .line 229
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_clockwise:I

    iget-boolean v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    .line 231
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_enabled:I

    iget-boolean v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    invoke-virtual {v7, v9, v10}, Landroid/content/res/TypedArray;->getBoolean(IZ)Z

    move-result v9

    iput-boolean v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    .line 233
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_arcColor:I

    invoke-virtual {v7, v9, v2}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v2

    .line 234
    sget v9, Lcom/triggertrap/seekarc/R$styleable;->SeekArc_progressColor:I

    invoke-virtual {v7, v9, v3}, Landroid/content/res/TypedArray;->getColor(II)I

    move-result v3

    .line 237
    invoke-virtual {v7}, Landroid/content/res/TypedArray;->recycle()V

    .line 240
    .end local v7    # "a":Landroid/content/res/TypedArray;
    .end local v8    # "thumb":Landroid/graphics/drawable/Drawable;
    :cond_1
    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    iget v8, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    if-le v7, v8, :cond_2

    move v7, v8

    :cond_2
    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 241
    if-gez v7, :cond_3

    const/4 v7, 0x0

    :cond_3
    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 243
    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    const/16 v8, 0x168

    if-le v7, v8, :cond_4

    const/16 v7, 0x168

    :cond_4
    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 244
    if-gez v7, :cond_5

    const/4 v7, 0x0

    :cond_5
    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 246
    iget v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    int-to-float v9, v9

    iget v10, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    int-to-float v10, v10

    div-float/2addr v9, v10

    int-to-float v7, v7

    mul-float v9, v9, v7

    iput v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    .line 248
    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    if-le v7, v8, :cond_6

    const/4 v7, 0x0

    :cond_6
    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 249
    if-gez v7, :cond_7

    goto :goto_0

    :cond_7
    move v6, v7

    :goto_0
    iput v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 251
    new-instance v6, Landroid/graphics/Paint;

    invoke-direct {v6}, Landroid/graphics/Paint;-><init>()V

    iput-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    .line 252
    invoke-virtual {v6, v2}, Landroid/graphics/Paint;->setColor(I)V

    .line 253
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    const/4 v7, 0x1

    invoke-virtual {v6, v7}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 254
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v8, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v6, v8}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 255
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    iget v8, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    int-to-float v8, v8

    invoke-virtual {v6, v8}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 258
    new-instance v6, Landroid/graphics/Paint;

    invoke-direct {v6}, Landroid/graphics/Paint;-><init>()V

    iput-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    .line 259
    invoke-virtual {v6, v3}, Landroid/graphics/Paint;->setColor(I)V

    .line 260
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    invoke-virtual {v6, v7}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 261
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v7, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v6, v7}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 262
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    int-to-float v7, v7

    invoke-virtual {v6, v7}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 264
    iget-boolean v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    if-eqz v6, :cond_8

    .line 265
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v7, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v6, v7}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 266
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v7, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v6, v7}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 268
    :cond_8
    return-void
.end method

.method private onProgressRefresh(IZ)V
    .locals 0
    .param p1, "progress"    # I
    .param p2, "fromUser"    # Z

    .line 424
    invoke-direct {p0, p1, p2}, Lcom/triggertrap/seekarc/SeekArc;->updateProgress(IZ)V

    .line 425
    return-void
.end method

.method private onStartTrackingTouch()V
    .locals 1

    .line 360
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mOnSeekArcChangeListener:Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;

    if-eqz v0, :cond_0

    .line 361
    invoke-interface {v0, p0}, Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;->onStartTrackingTouch(Lcom/triggertrap/seekarc/SeekArc;)V

    .line 363
    :cond_0
    return-void
.end method

.method private onStopTrackingTouch()V
    .locals 1

    .line 366
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mOnSeekArcChangeListener:Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;

    if-eqz v0, :cond_0

    .line 367
    invoke-interface {v0, p0}, Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;->onStopTrackingTouch(Lcom/triggertrap/seekarc/SeekArc;)V

    .line 369
    :cond_0
    return-void
.end method

.method private updateOnTouch(Landroid/view/MotionEvent;)V
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 372
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v0

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/triggertrap/seekarc/SeekArc;->ignoreTouch(FF)Z

    move-result v0

    .line 373
    .local v0, "ignoreTouch":Z
    if-eqz v0, :cond_0

    .line 374
    return-void

    .line 376
    :cond_0
    const/4 v1, 0x1

    invoke-virtual {p0, v1}, Lcom/triggertrap/seekarc/SeekArc;->setPressed(Z)V

    .line 377
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v2

    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v3

    invoke-direct {p0, v2, v3}, Lcom/triggertrap/seekarc/SeekArc;->getTouchDegrees(FF)D

    move-result-wide v2

    iput-wide v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchAngle:D

    .line 378
    invoke-direct {p0, v2, v3}, Lcom/triggertrap/seekarc/SeekArc;->getProgressForAngle(D)I

    move-result v2

    .line 379
    .local v2, "progress":I
    invoke-direct {p0, v2, v1}, Lcom/triggertrap/seekarc/SeekArc;->onProgressRefresh(IZ)V

    .line 380
    return-void
.end method

.method private updateProgress(IZ)V
    .locals 2
    .param p1, "progress"    # I
    .param p2, "fromUser"    # Z

    .line 435
    sget v0, Lcom/triggertrap/seekarc/SeekArc;->INVALID_PROGRESS_VALUE:I

    if-ne p1, v0, :cond_0

    .line 436
    return-void

    .line 439
    :cond_0
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mOnSeekArcChangeListener:Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;

    if-eqz v0, :cond_1

    .line 440
    nop

    .line 441
    invoke-interface {v0, p0, p1, p2}, Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;->onProgressChanged(Lcom/triggertrap/seekarc/SeekArc;IZ)V

    .line 444
    :cond_1
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    if-le p1, v0, :cond_2

    goto :goto_0

    :cond_2
    move v0, p1

    :goto_0
    move p1, v0

    .line 445
    if-gez p1, :cond_3

    const/4 v0, 0x0

    goto :goto_1

    :cond_3
    move v0, p1

    :goto_1
    move p1, v0

    .line 447
    iput p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    .line 448
    int-to-float v0, p1

    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    int-to-float v1, v1

    div-float/2addr v0, v1

    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    int-to-float v1, v1

    mul-float v0, v0, v1

    iput v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    .line 450
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->updateThumbPosition()V

    .line 452
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->invalidate()V

    .line 453
    return-void
.end method

.method private updateThumbPosition()V
    .locals 5

    .line 428
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    int-to-float v0, v0

    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    add-float/2addr v0, v1

    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    int-to-float v1, v1

    add-float/2addr v0, v1

    const/high16 v1, 0x42b40000    # 90.0f

    add-float/2addr v0, v1

    float-to-int v0, v0

    .line 429
    .local v0, "thumbAngle":I
    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    int-to-double v1, v1

    int-to-double v3, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->cos(D)D

    move-result-wide v3

    invoke-static {v1, v2}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v1, v1, v3

    double-to-int v1, v1

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumbXPos:I

    .line 430
    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    int-to-double v1, v1

    int-to-double v3, v0

    invoke-static {v3, v4}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Math;->sin(D)D

    move-result-wide v3

    invoke-static {v1, v2}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v1, v1, v3

    double-to-int v1, v1

    iput v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumbYPos:I

    .line 431
    return-void
.end method

.method private valuePerDegree()F
    .locals 2

    .line 420
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mMax:I

    int-to-float v0, v0

    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    int-to-float v1, v1

    div-float/2addr v0, v1

    return v0
.end method


# virtual methods
.method protected drawableStateChanged()V
    .locals 2

    .line 351
    invoke-super {p0}, Landroid/view/View;->drawableStateChanged()V

    .line 352
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->isStateful()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 353
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getDrawableState()[I

    move-result-object v0

    .line 354
    .local v0, "state":[I
    iget-object v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1, v0}, Landroid/graphics/drawable/Drawable;->setState([I)Z

    .line 356
    .end local v0    # "state":[I
    :cond_0
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->invalidate()V

    .line 357
    return-void
.end method

.method public getArcColor()I
    .locals 1

    .line 571
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getArcRotation()I
    .locals 1

    .line 495
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    return v0
.end method

.method public getArcWidth()I
    .locals 1

    .line 487
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    return v0
.end method

.method public getProgress()I
    .locals 1

    .line 474
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgress:I

    return v0
.end method

.method public getProgressColor()I
    .locals 1

    .line 562
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    invoke-virtual {v0}, Landroid/graphics/Paint;->getColor()I

    move-result v0

    return v0
.end method

.method public getProgressWidth()I
    .locals 1

    .line 478
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    return v0
.end method

.method public getStartAngle()I
    .locals 1

    .line 504
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    return v0
.end method

.method public getSweepAngle()I
    .locals 1

    .line 513
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    return v0
.end method

.method public isClockwise()Z
    .locals 1

    .line 550
    iget-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    return v0
.end method

.method public isEnabled()Z
    .locals 1

    .line 554
    iget-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    return v0
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 14
    .param p1, "canvas"    # Landroid/graphics/Canvas;

    .line 272
    iget-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    if-nez v0, :cond_0

    .line 273
    const/high16 v0, -0x40800000    # -1.0f

    const/high16 v1, 0x3f800000    # 1.0f

    iget-object v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    invoke-virtual {v2}, Landroid/graphics/RectF;->centerX()F

    move-result v2

    iget-object v3, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    invoke-virtual {v3}, Landroid/graphics/RectF;->centerY()F

    move-result v3

    invoke-virtual {p1, v0, v1, v2, v3}, Landroid/graphics/Canvas;->scale(FFFF)V

    .line 277
    :cond_0
    iget v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    add-int/lit8 v0, v0, -0x5a

    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    add-int/2addr v0, v1

    .line 278
    .local v0, "arcStart":I
    iget v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 279
    .local v1, "arcSweep":I
    iget-object v3, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    int-to-float v4, v0

    int-to-float v5, v1

    const/4 v6, 0x0

    iget-object v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    move-object v2, p1

    invoke-virtual/range {v2 .. v7}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 280
    iget-object v9, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    int-to-float v10, v0

    iget v11, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    const/4 v12, 0x0

    iget-object v13, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    move-object v8, p1

    invoke-virtual/range {v8 .. v13}, Landroid/graphics/Canvas;->drawArc(Landroid/graphics/RectF;FFZLandroid/graphics/Paint;)V

    .line 283
    iget-boolean v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    if-eqz v2, :cond_1

    .line 285
    iget v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateX:I

    iget v3, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumbXPos:I

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iget v3, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateY:I

    iget v4, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumbYPos:I

    sub-int/2addr v3, v4

    int-to-float v3, v3

    invoke-virtual {p1, v2, v3}, Landroid/graphics/Canvas;->translate(FF)V

    .line 286
    iget-object v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v2, p1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 288
    :cond_1
    return-void
.end method

.method protected onMeasure(II)V
    .locals 11
    .param p1, "widthMeasureSpec"    # I
    .param p2, "heightMeasureSpec"    # I

    .line 294
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getSuggestedMinimumHeight()I

    move-result v0

    invoke-static {v0, p2}, Lcom/triggertrap/seekarc/SeekArc;->getDefaultSize(II)I

    move-result v0

    .line 296
    .local v0, "height":I
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getSuggestedMinimumWidth()I

    move-result v1

    invoke-static {v1, p1}, Lcom/triggertrap/seekarc/SeekArc;->getDefaultSize(II)I

    move-result v1

    .line 298
    .local v1, "width":I
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v2

    .line 299
    .local v2, "min":I
    const/4 v3, 0x0

    .line 300
    .local v3, "top":F
    const/4 v4, 0x0

    .line 301
    .local v4, "left":F
    const/4 v5, 0x0

    .line 303
    .local v5, "arcDiameter":I
    int-to-float v6, v1

    const/high16 v7, 0x3f000000    # 0.5f

    mul-float v6, v6, v7

    float-to-int v6, v6

    iput v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateX:I

    .line 304
    int-to-float v6, v0

    mul-float v6, v6, v7

    float-to-int v6, v6

    iput v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mTranslateY:I

    .line 306
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getPaddingLeft()I

    move-result v6

    sub-int v5, v2, v6

    .line 307
    div-int/lit8 v6, v5, 0x2

    iput v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    .line 308
    div-int/lit8 v6, v0, 0x2

    div-int/lit8 v7, v5, 0x2

    sub-int/2addr v6, v7

    int-to-float v3, v6

    .line 309
    div-int/lit8 v6, v1, 0x2

    div-int/lit8 v7, v5, 0x2

    sub-int/2addr v6, v7

    int-to-float v4, v6

    .line 310
    iget-object v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRect:Landroid/graphics/RectF;

    int-to-float v7, v5

    add-float/2addr v7, v4

    int-to-float v8, v5

    add-float/2addr v8, v3

    invoke-virtual {v6, v4, v3, v7, v8}, Landroid/graphics/RectF;->set(FFFF)V

    .line 312
    iget v6, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressSweep:F

    float-to-int v6, v6

    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    add-int/2addr v6, v7

    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    add-int/2addr v6, v7

    add-int/lit8 v6, v6, 0x5a

    .line 313
    .local v6, "arcStart":I
    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    int-to-double v7, v7

    int-to-double v9, v6

    invoke-static {v9, v10}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Math;->cos(D)D

    move-result-wide v9

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    double-to-int v7, v7

    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumbXPos:I

    .line 314
    iget v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    int-to-double v7, v7

    int-to-double v9, v6

    invoke-static {v9, v10}, Ljava/lang/Math;->toRadians(D)D

    move-result-wide v9

    invoke-static {v9, v10}, Ljava/lang/Math;->sin(D)D

    move-result-wide v9

    invoke-static {v7, v8}, Ljava/lang/Double;->isNaN(D)Z

    mul-double v7, v7, v9

    double-to-int v7, v7

    iput v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumbYPos:I

    .line 316
    iget-boolean v7, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    invoke-virtual {p0, v7}, Lcom/triggertrap/seekarc/SeekArc;->setTouchInSide(Z)V

    .line 317
    invoke-super {p0, p1, p2}, Landroid/view/View;->onMeasure(II)V

    .line 318
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 4
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 322
    iget-boolean v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    const/4 v1, 0x0

    if-eqz v0, :cond_4

    .line 323
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    const/4 v2, 0x1

    invoke-interface {v0, v2}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 325
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    if-eqz v0, :cond_3

    if-eq v0, v2, :cond_2

    const/4 v3, 0x2

    if-eq v0, v3, :cond_1

    const/4 v3, 0x3

    if-eq v0, v3, :cond_0

    goto :goto_0

    .line 339
    :cond_0
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->onStopTrackingTouch()V

    .line 340
    invoke-virtual {p0, v1}, Lcom/triggertrap/seekarc/SeekArc;->setPressed(Z)V

    .line 341
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    goto :goto_0

    .line 331
    :cond_1
    invoke-direct {p0, p1}, Lcom/triggertrap/seekarc/SeekArc;->updateOnTouch(Landroid/view/MotionEvent;)V

    .line 332
    goto :goto_0

    .line 334
    :cond_2
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->onStopTrackingTouch()V

    .line 335
    invoke-virtual {p0, v1}, Lcom/triggertrap/seekarc/SeekArc;->setPressed(Z)V

    .line 336
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    invoke-interface {v0, v1}, Landroid/view/ViewParent;->requestDisallowInterceptTouchEvent(Z)V

    .line 337
    goto :goto_0

    .line 327
    :cond_3
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->onStartTrackingTouch()V

    .line 328
    invoke-direct {p0, p1}, Lcom/triggertrap/seekarc/SeekArc;->updateOnTouch(Landroid/view/MotionEvent;)V

    .line 329
    nop

    .line 344
    :goto_0
    return v2

    .line 346
    :cond_4
    return v1
.end method

.method public setArcColor(I)V
    .locals 1
    .param p1, "color"    # I

    .line 575
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 576
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->invalidate()V

    .line 577
    return-void
.end method

.method public setArcRotation(I)V
    .locals 0
    .param p1, "mRotation"    # I

    .line 499
    iput p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mRotation:I

    .line 500
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->updateThumbPosition()V

    .line 501
    return-void
.end method

.method public setArcWidth(I)V
    .locals 2
    .param p1, "mArcWidth"    # I

    .line 491
    iput p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcWidth:I

    .line 492
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    int-to-float v1, p1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 493
    return-void
.end method

.method public setClockwise(Z)V
    .locals 0
    .param p1, "isClockwise"    # Z

    .line 546
    iput-boolean p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mClockwise:Z

    .line 547
    return-void
.end method

.method public setEnabled(Z)V
    .locals 0
    .param p1, "enabled"    # Z

    .line 558
    iput-boolean p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mEnabled:Z

    .line 559
    return-void
.end method

.method public setOnSeekArcChangeListener(Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;)V
    .locals 0
    .param p1, "l"    # Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;

    .line 466
    iput-object p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mOnSeekArcChangeListener:Lcom/triggertrap/seekarc/SeekArc$OnSeekArcChangeListener;

    .line 467
    return-void
.end method

.method public setProgress(I)V
    .locals 1
    .param p1, "progress"    # I

    .line 470
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/triggertrap/seekarc/SeekArc;->updateProgress(IZ)V

    .line 471
    return-void
.end method

.method public setProgressColor(I)V
    .locals 1
    .param p1, "color"    # I

    .line 566
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setColor(I)V

    .line 567
    invoke-virtual {p0}, Lcom/triggertrap/seekarc/SeekArc;->invalidate()V

    .line 568
    return-void
.end method

.method public setProgressWidth(I)V
    .locals 2
    .param p1, "mProgressWidth"    # I

    .line 482
    iput p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressWidth:I

    .line 483
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    int-to-float v1, p1

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 484
    return-void
.end method

.method public setRoundedEdges(Z)V
    .locals 2
    .param p1, "isEnabled"    # Z

    .line 522
    iput-boolean p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mRoundedEdges:Z

    .line 523
    if-eqz p1, :cond_0

    .line 524
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 525
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->ROUND:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    goto :goto_0

    .line 527
    :cond_0
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->SQUARE:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 528
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mProgressPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Cap;->SQUARE:Landroid/graphics/Paint$Cap;

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setStrokeCap(Landroid/graphics/Paint$Cap;)V

    .line 530
    :goto_0
    return-void
.end method

.method public setStartAngle(I)V
    .locals 0
    .param p1, "mStartAngle"    # I

    .line 508
    iput p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mStartAngle:I

    .line 509
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->updateThumbPosition()V

    .line 510
    return-void
.end method

.method public setSweepAngle(I)V
    .locals 0
    .param p1, "mSweepAngle"    # I

    .line 517
    iput p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mSweepAngle:I

    .line 518
    invoke-direct {p0}, Lcom/triggertrap/seekarc/SeekArc;->updateThumbPosition()V

    .line 519
    return-void
.end method

.method public setTouchInSide(Z)V
    .locals 4
    .param p1, "isEnabled"    # Z

    .line 533
    iget-object v0, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v0}, Landroid/graphics/drawable/Drawable;->getIntrinsicHeight()I

    move-result v0

    div-int/lit8 v0, v0, 0x2

    .line 534
    .local v0, "thumbHalfheight":I
    iget-object v1, p0, Lcom/triggertrap/seekarc/SeekArc;->mThumb:Landroid/graphics/drawable/Drawable;

    invoke-virtual {v1}, Landroid/graphics/drawable/Drawable;->getIntrinsicWidth()I

    move-result v1

    div-int/lit8 v1, v1, 0x2

    .line 535
    .local v1, "thumbHalfWidth":I
    iput-boolean p1, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchInside:Z

    .line 536
    if-eqz p1, :cond_0

    .line 537
    iget v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    int-to-float v2, v2

    const/high16 v3, 0x40800000    # 4.0f

    div-float/2addr v2, v3

    iput v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchIgnoreRadius:F

    goto :goto_0

    .line 540
    :cond_0
    iget v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mArcRadius:I

    .line 541
    invoke-static {v1, v0}, Ljava/lang/Math;->min(II)I

    move-result v3

    sub-int/2addr v2, v3

    int-to-float v2, v2

    iput v2, p0, Lcom/triggertrap/seekarc/SeekArc;->mTouchIgnoreRadius:F

    .line 543
    :goto_0
    return-void
.end method
