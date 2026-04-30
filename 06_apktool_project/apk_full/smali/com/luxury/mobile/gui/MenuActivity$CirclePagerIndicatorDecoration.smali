.class public Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;
.super Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;
.source "MenuActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/luxury/mobile/gui/MenuActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "CirclePagerIndicatorDecoration"
.end annotation


# static fields
.field private static final f116DP:F


# instance fields
.field private colorActive:I

.field private colorInactive:I

.field private final mIndicatorHeight:I

.field private final mIndicatorItemLength:F

.field private final mIndicatorItemPadding:F

.field private final mIndicatorStrokeWidth:F

.field private final mInterpolator:Landroid/view/animation/AccelerateDecelerateInterpolator;

.field private final mPaint:Landroid/graphics/Paint;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 214
    invoke-static {}, Landroid/content/res/Resources;->getSystem()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    sput v0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->f116DP:F

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    .line 224
    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;-><init>()V

    .line 215
    const v0, -0xff05fd

    iput v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->colorActive:I

    .line 216
    const/high16 v0, 0x33000000

    iput v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->colorInactive:I

    .line 225
    sget v0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->f116DP:F

    .line 226
    .local v0, "f":F
    const/high16 v1, 0x42100000    # 36.0f

    mul-float v1, v1, v0

    float-to-int v1, v1

    iput v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorHeight:I

    .line 227
    const/high16 v1, 0x40800000    # 4.0f

    mul-float v2, v0, v1

    iput v2, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorStrokeWidth:F

    .line 228
    mul-float v1, v1, v0

    iput v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemLength:F

    .line 229
    const/high16 v1, 0x41000000    # 8.0f

    mul-float v1, v1, v0

    iput v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemPadding:F

    .line 230
    new-instance v1, Landroid/view/animation/AccelerateDecelerateInterpolator;

    invoke-direct {v1}, Landroid/view/animation/AccelerateDecelerateInterpolator;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mInterpolator:Landroid/view/animation/AccelerateDecelerateInterpolator;

    .line 231
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1}, Landroid/graphics/Paint;-><init>()V

    .line 232
    .local v1, "paint":Landroid/graphics/Paint;
    iput-object v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    .line 233
    iget v2, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorStrokeWidth:F

    invoke-virtual {v1, v2}, Landroid/graphics/Paint;->setStrokeWidth(F)V

    .line 234
    iget-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    sget-object v3, Landroid/graphics/Paint$Style;->STROKE:Landroid/graphics/Paint$Style;

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 235
    iget-object v2, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Landroid/graphics/Paint;->setAntiAlias(Z)V

    .line 236
    return-void
.end method

.method private drawHighlights(Landroid/graphics/Canvas;FFIF)V
    .locals 6
    .param p1, "c"    # Landroid/graphics/Canvas;
    .param p2, "indicatorStartX"    # F
    .param p3, "indicatorPosY"    # F
    .param p4, "highlightPosition"    # I
    .param p5, "progress"    # F

    .line 267
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->colorActive:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 268
    iget v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemLength:F

    .line 269
    .local v0, "f":F
    iget v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemPadding:F

    .line 270
    .local v1, "f2":F
    add-float v2, v0, v1

    .line 271
    .local v2, "itemWidth":F
    const/high16 v3, 0x40000000    # 2.0f

    const/4 v4, 0x0

    cmpl-float v4, p5, v4

    if-nez v4, :cond_0

    .line 272
    int-to-float v4, p4

    mul-float v4, v4, v2

    add-float/2addr v4, p2

    div-float v3, v0, v3

    iget-object v5, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v4, p3, v3, v5}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    goto :goto_0

    .line 274
    :cond_0
    int-to-float v4, p4

    mul-float v4, v4, v2

    add-float/2addr v4, p2

    mul-float v5, v0, p5

    add-float/2addr v4, v5

    mul-float v5, v1, p5

    add-float/2addr v4, v5

    div-float v3, v0, v3

    iget-object v5, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v4, p3, v3, v5}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 276
    :goto_0
    return-void
.end method

.method private drawInactiveIndicators(Landroid/graphics/Canvas;FFI)V
    .locals 5
    .param p1, "c"    # Landroid/graphics/Canvas;
    .param p2, "indicatorStartX"    # F
    .param p3, "indicatorPosY"    # F
    .param p4, "itemCount"    # I

    .line 257
    iget-object v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    iget v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->colorInactive:I

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 258
    iget v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemLength:F

    iget v1, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemPadding:F

    add-float/2addr v0, v1

    .line 259
    .local v0, "itemWidth":F
    move v1, p2

    .line 260
    .local v1, "start":F
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, p4, :cond_0

    .line 261
    iget v3, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemLength:F

    const/high16 v4, 0x40000000    # 2.0f

    div-float/2addr v3, v4

    iget-object v4, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, p3, v3, v4}, Landroid/graphics/Canvas;->drawCircle(FFFLandroid/graphics/Paint;)V

    .line 262
    add-float/2addr v1, v0

    .line 260
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 264
    .end local v2    # "i":I
    :cond_0
    return-void
.end method


# virtual methods
.method public getItemOffsets(Landroid/graphics/Rect;Landroid/view/View;Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$State;)V
    .locals 1
    .param p1, "outRect"    # Landroid/graphics/Rect;
    .param p2, "view"    # Landroid/view/View;
    .param p3, "parent"    # Landroidx/recyclerview/widget/RecyclerView;
    .param p4, "state"    # Landroidx/recyclerview/widget/RecyclerView$State;

    .line 279
    invoke-super {p0, p1, p2, p3, p4}, Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;->getItemOffsets(Landroid/graphics/Rect;Landroid/view/View;Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$State;)V

    .line 280
    iget v0, p0, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorHeight:I

    iput v0, p1, Landroid/graphics/Rect;->bottom:I

    .line 281
    return-void
.end method

.method public onDrawOver(Landroid/graphics/Canvas;Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$State;)V
    .locals 18
    .param p1, "c"    # Landroid/graphics/Canvas;
    .param p2, "parent"    # Landroidx/recyclerview/widget/RecyclerView;
    .param p3, "state"    # Landroidx/recyclerview/widget/RecyclerView$State;

    .line 239
    move-object/from16 v6, p0

    invoke-super/range {p0 .. p3}, Landroidx/recyclerview/widget/RecyclerView$ItemDecoration;->onDrawOver(Landroid/graphics/Canvas;Landroidx/recyclerview/widget/RecyclerView;Landroidx/recyclerview/widget/RecyclerView$State;)V

    .line 240
    invoke-virtual/range {p2 .. p2}, Landroidx/recyclerview/widget/RecyclerView;->getAdapter()Landroidx/recyclerview/widget/RecyclerView$Adapter;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;->getItemCount()I

    move-result v7

    .line 241
    .local v7, "itemCount":I
    invoke-virtual/range {p2 .. p2}, Landroidx/recyclerview/widget/RecyclerView;->getWidth()I

    move-result v0

    int-to-float v0, v0

    iget v1, v6, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemLength:F

    int-to-float v2, v7

    mul-float v1, v1, v2

    add-int/lit8 v2, v7, -0x1

    const/4 v3, 0x0

    invoke-static {v3, v2}, Ljava/lang/Math;->max(II)I

    move-result v2

    int-to-float v2, v2

    iget v3, v6, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorItemPadding:F

    mul-float v2, v2, v3

    add-float/2addr v1, v2

    sub-float/2addr v0, v1

    const/high16 v1, 0x40000000    # 2.0f

    div-float v8, v0, v1

    .line 242
    .local v8, "indicatorStartX":F
    invoke-virtual/range {p2 .. p2}, Landroidx/recyclerview/widget/RecyclerView;->getHeight()I

    move-result v0

    int-to-float v0, v0

    iget v2, v6, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mIndicatorHeight:I

    int-to-float v2, v2

    div-float/2addr v2, v1

    sub-float v9, v0, v2

    .line 243
    .local v9, "indicatorPosY":F
    move-object/from16 v10, p1

    invoke-direct {v6, v10, v8, v9, v7}, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->drawInactiveIndicators(Landroid/graphics/Canvas;FFI)V

    .line 244
    invoke-virtual/range {p2 .. p2}, Landroidx/recyclerview/widget/RecyclerView;->getLayoutManager()Landroidx/recyclerview/widget/RecyclerView$LayoutManager;

    move-result-object v0

    move-object v11, v0

    check-cast v11, Landroidx/recyclerview/widget/LinearLayoutManager;

    .line 245
    .local v11, "layoutManager":Landroidx/recyclerview/widget/LinearLayoutManager;
    invoke-virtual {v11}, Landroidx/recyclerview/widget/LinearLayoutManager;->findFirstVisibleItemPosition()I

    move-result v12

    .line 246
    .local v12, "activePosition":I
    const/4 v0, -0x1

    if-eq v12, v0, :cond_0

    .line 247
    invoke-virtual {v11, v12}, Landroidx/recyclerview/widget/LinearLayoutManager;->findViewByPosition(I)Landroid/view/View;

    move-result-object v13

    .line 248
    .local v13, "activeChild":Landroid/view/View;
    invoke-virtual {v13}, Landroid/view/View;->getLeft()I

    move-result v14

    .line 249
    .local v14, "left":I
    invoke-virtual {v13}, Landroid/view/View;->getWidth()I

    move-result v15

    .line 250
    .local v15, "width":I
    invoke-virtual {v13}, Landroid/view/View;->getRight()I

    move-result v16

    .line 251
    .local v16, "right":I
    move/from16 v17, v15

    .line 252
    .local v17, "i":I
    iget-object v0, v6, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->mInterpolator:Landroid/view/animation/AccelerateDecelerateInterpolator;

    mul-int/lit8 v1, v14, -0x1

    int-to-float v1, v1

    int-to-float v2, v15

    div-float/2addr v1, v2

    invoke-virtual {v0, v1}, Landroid/view/animation/AccelerateDecelerateInterpolator;->getInterpolation(F)F

    move-result v5

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move v2, v8

    move v3, v9

    move v4, v12

    invoke-direct/range {v0 .. v5}, Lcom/luxury/mobile/gui/MenuActivity$CirclePagerIndicatorDecoration;->drawHighlights(Landroid/graphics/Canvas;FFIF)V

    .line 254
    .end local v13    # "activeChild":Landroid/view/View;
    .end local v14    # "left":I
    .end local v15    # "width":I
    .end local v16    # "right":I
    .end local v17    # "i":I
    :cond_0
    return-void
.end method
