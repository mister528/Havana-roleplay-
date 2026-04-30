.class public Landroidx/transition/Slide;
.super Landroidx/transition/Visibility;
.source "Slide.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/transition/Slide$CalculateSlideVertical;,
        Landroidx/transition/Slide$CalculateSlideHorizontal;,
        Landroidx/transition/Slide$CalculateSlide;,
        Landroidx/transition/Slide$GravityFlag;
    }
.end annotation


# static fields
.field private static final PROPNAME_SCREEN_POSITION:Ljava/lang/String; = "android:slide:screenPosition"

.field private static final sAccelerate:Landroid/animation/TimeInterpolator;

.field private static final sCalculateBottom:Landroidx/transition/Slide$CalculateSlide;

.field private static final sCalculateEnd:Landroidx/transition/Slide$CalculateSlide;

.field private static final sCalculateLeft:Landroidx/transition/Slide$CalculateSlide;

.field private static final sCalculateRight:Landroidx/transition/Slide$CalculateSlide;

.field private static final sCalculateStart:Landroidx/transition/Slide$CalculateSlide;

.field private static final sCalculateTop:Landroidx/transition/Slide$CalculateSlide;

.field private static final sDecelerate:Landroid/animation/TimeInterpolator;


# instance fields
.field private mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

.field private mSlideEdge:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 54
    new-instance v0, Landroid/view/animation/DecelerateInterpolator;

    invoke-direct {v0}, Landroid/view/animation/DecelerateInterpolator;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sDecelerate:Landroid/animation/TimeInterpolator;

    .line 55
    new-instance v0, Landroid/view/animation/AccelerateInterpolator;

    invoke-direct {v0}, Landroid/view/animation/AccelerateInterpolator;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sAccelerate:Landroid/animation/TimeInterpolator;

    .line 92
    new-instance v0, Landroidx/transition/Slide$1;

    invoke-direct {v0}, Landroidx/transition/Slide$1;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sCalculateLeft:Landroidx/transition/Slide$CalculateSlide;

    .line 99
    new-instance v0, Landroidx/transition/Slide$2;

    invoke-direct {v0}, Landroidx/transition/Slide$2;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sCalculateStart:Landroidx/transition/Slide$CalculateSlide;

    .line 114
    new-instance v0, Landroidx/transition/Slide$3;

    invoke-direct {v0}, Landroidx/transition/Slide$3;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sCalculateTop:Landroidx/transition/Slide$CalculateSlide;

    .line 121
    new-instance v0, Landroidx/transition/Slide$4;

    invoke-direct {v0}, Landroidx/transition/Slide$4;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sCalculateRight:Landroidx/transition/Slide$CalculateSlide;

    .line 128
    new-instance v0, Landroidx/transition/Slide$5;

    invoke-direct {v0}, Landroidx/transition/Slide$5;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sCalculateEnd:Landroidx/transition/Slide$CalculateSlide;

    .line 143
    new-instance v0, Landroidx/transition/Slide$6;

    invoke-direct {v0}, Landroidx/transition/Slide$6;-><init>()V

    sput-object v0, Landroidx/transition/Slide;->sCalculateBottom:Landroidx/transition/Slide$CalculateSlide;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 154
    invoke-direct {p0}, Landroidx/transition/Visibility;-><init>()V

    .line 57
    sget-object v0, Landroidx/transition/Slide;->sCalculateBottom:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 58
    const/16 v0, 0x50

    iput v0, p0, Landroidx/transition/Slide;->mSlideEdge:I

    .line 155
    invoke-virtual {p0, v0}, Landroidx/transition/Slide;->setSlideEdge(I)V

    .line 156
    return-void
.end method

.method public constructor <init>(I)V
    .locals 1
    .param p1, "slideEdge"    # I

    .line 161
    invoke-direct {p0}, Landroidx/transition/Visibility;-><init>()V

    .line 57
    sget-object v0, Landroidx/transition/Slide;->sCalculateBottom:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 58
    const/16 v0, 0x50

    iput v0, p0, Landroidx/transition/Slide;->mSlideEdge:I

    .line 162
    invoke-virtual {p0, p1}, Landroidx/transition/Slide;->setSlideEdge(I)V

    .line 163
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 5
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .line 166
    invoke-direct {p0, p1, p2}, Landroidx/transition/Visibility;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 57
    sget-object v0, Landroidx/transition/Slide;->sCalculateBottom:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 58
    const/16 v0, 0x50

    iput v0, p0, Landroidx/transition/Slide;->mSlideEdge:I

    .line 167
    sget-object v1, Landroidx/transition/Styleable;->SLIDE:[I

    invoke-virtual {p1, p2, v1}, Landroid/content/Context;->obtainStyledAttributes(Landroid/util/AttributeSet;[I)Landroid/content/res/TypedArray;

    move-result-object v1

    .line 168
    .local v1, "a":Landroid/content/res/TypedArray;
    move-object v2, p2

    check-cast v2, Lorg/xmlpull/v1/XmlPullParser;

    const-string v3, "slideEdge"

    const/4 v4, 0x0

    invoke-static {v1, v2, v3, v4, v0}, Landroidx/core/content/res/TypedArrayUtils;->getNamedInt(Landroid/content/res/TypedArray;Lorg/xmlpull/v1/XmlPullParser;Ljava/lang/String;II)I

    move-result v0

    .line 170
    .local v0, "edge":I
    invoke-virtual {v1}, Landroid/content/res/TypedArray;->recycle()V

    .line 172
    invoke-virtual {p0, v0}, Landroidx/transition/Slide;->setSlideEdge(I)V

    .line 173
    return-void
.end method

.method private captureValues(Landroidx/transition/TransitionValues;)V
    .locals 4
    .param p1, "transitionValues"    # Landroidx/transition/TransitionValues;

    .line 176
    iget-object v0, p1, Landroidx/transition/TransitionValues;->view:Landroid/view/View;

    .line 177
    .local v0, "view":Landroid/view/View;
    const/4 v1, 0x2

    new-array v1, v1, [I

    .line 178
    .local v1, "position":[I
    invoke-virtual {v0, v1}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 179
    iget-object v2, p1, Landroidx/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v3, "android:slide:screenPosition"

    invoke-interface {v2, v3, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 180
    return-void
.end method


# virtual methods
.method public captureEndValues(Landroidx/transition/TransitionValues;)V
    .locals 0
    .param p1, "transitionValues"    # Landroidx/transition/TransitionValues;

    .line 190
    invoke-super {p0, p1}, Landroidx/transition/Visibility;->captureEndValues(Landroidx/transition/TransitionValues;)V

    .line 191
    invoke-direct {p0, p1}, Landroidx/transition/Slide;->captureValues(Landroidx/transition/TransitionValues;)V

    .line 192
    return-void
.end method

.method public captureStartValues(Landroidx/transition/TransitionValues;)V
    .locals 0
    .param p1, "transitionValues"    # Landroidx/transition/TransitionValues;

    .line 184
    invoke-super {p0, p1}, Landroidx/transition/Visibility;->captureStartValues(Landroidx/transition/TransitionValues;)V

    .line 185
    invoke-direct {p0, p1}, Landroidx/transition/Slide;->captureValues(Landroidx/transition/TransitionValues;)V

    .line 186
    return-void
.end method

.method public getSlideEdge()I
    .locals 1

    .line 241
    iget v0, p0, Landroidx/transition/Slide;->mSlideEdge:I

    return v0
.end method

.method public onAppear(Landroid/view/ViewGroup;Landroid/view/View;Landroidx/transition/TransitionValues;Landroidx/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 18
    .param p1, "sceneRoot"    # Landroid/view/ViewGroup;
    .param p2, "view"    # Landroid/view/View;
    .param p3, "startValues"    # Landroidx/transition/TransitionValues;
    .param p4, "endValues"    # Landroidx/transition/TransitionValues;

    .line 247
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v11, p2

    move-object/from16 v12, p4

    if-nez v12, :cond_0

    .line 248
    const/4 v2, 0x0

    return-object v2

    .line 250
    :cond_0
    iget-object v2, v12, Landroidx/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v3, "android:slide:screenPosition"

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    move-object v13, v2

    check-cast v13, [I

    .line 251
    .local v13, "position":[I
    invoke-virtual/range {p2 .. p2}, Landroid/view/View;->getTranslationX()F

    move-result v14

    .line 252
    .local v14, "endX":F
    invoke-virtual/range {p2 .. p2}, Landroid/view/View;->getTranslationY()F

    move-result v15

    .line 253
    .local v15, "endY":F
    iget-object v2, v0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    invoke-interface {v2, v1, v11}, Landroidx/transition/Slide$CalculateSlide;->getGoneX(Landroid/view/ViewGroup;Landroid/view/View;)F

    move-result v16

    .line 254
    .local v16, "startX":F
    iget-object v2, v0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    invoke-interface {v2, v1, v11}, Landroidx/transition/Slide$CalculateSlide;->getGoneY(Landroid/view/ViewGroup;Landroid/view/View;)F

    move-result v17

    .line 255
    .local v17, "startY":F
    const/4 v2, 0x0

    aget v4, v13, v2

    const/4 v2, 0x1

    aget v5, v13, v2

    sget-object v10, Landroidx/transition/Slide;->sDecelerate:Landroid/animation/TimeInterpolator;

    .line 256
    move-object/from16 v2, p2

    move-object/from16 v3, p4

    move/from16 v6, v16

    move/from16 v7, v17

    move v8, v14

    move v9, v15

    invoke-static/range {v2 .. v10}, Landroidx/transition/TranslationAnimationCreator;->createAnimation(Landroid/view/View;Landroidx/transition/TransitionValues;IIFFFFLandroid/animation/TimeInterpolator;)Landroid/animation/Animator;

    move-result-object v2

    return-object v2
.end method

.method public onDisappear(Landroid/view/ViewGroup;Landroid/view/View;Landroidx/transition/TransitionValues;Landroidx/transition/TransitionValues;)Landroid/animation/Animator;
    .locals 18
    .param p1, "sceneRoot"    # Landroid/view/ViewGroup;
    .param p2, "view"    # Landroid/view/View;
    .param p3, "startValues"    # Landroidx/transition/TransitionValues;
    .param p4, "endValues"    # Landroidx/transition/TransitionValues;

    .line 263
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move-object/from16 v11, p2

    move-object/from16 v12, p3

    if-nez v12, :cond_0

    .line 264
    const/4 v2, 0x0

    return-object v2

    .line 266
    :cond_0
    iget-object v2, v12, Landroidx/transition/TransitionValues;->values:Ljava/util/Map;

    const-string v3, "android:slide:screenPosition"

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [I

    move-object v13, v2

    check-cast v13, [I

    .line 267
    .local v13, "position":[I
    invoke-virtual/range {p2 .. p2}, Landroid/view/View;->getTranslationX()F

    move-result v14

    .line 268
    .local v14, "startX":F
    invoke-virtual/range {p2 .. p2}, Landroid/view/View;->getTranslationY()F

    move-result v15

    .line 269
    .local v15, "startY":F
    iget-object v2, v0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    invoke-interface {v2, v1, v11}, Landroidx/transition/Slide$CalculateSlide;->getGoneX(Landroid/view/ViewGroup;Landroid/view/View;)F

    move-result v16

    .line 270
    .local v16, "endX":F
    iget-object v2, v0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    invoke-interface {v2, v1, v11}, Landroidx/transition/Slide$CalculateSlide;->getGoneY(Landroid/view/ViewGroup;Landroid/view/View;)F

    move-result v17

    .line 271
    .local v17, "endY":F
    const/4 v2, 0x0

    aget v4, v13, v2

    const/4 v2, 0x1

    aget v5, v13, v2

    sget-object v10, Landroidx/transition/Slide;->sAccelerate:Landroid/animation/TimeInterpolator;

    .line 272
    move-object/from16 v2, p2

    move-object/from16 v3, p3

    move v6, v14

    move v7, v15

    move/from16 v8, v16

    move/from16 v9, v17

    invoke-static/range {v2 .. v10}, Landroidx/transition/TranslationAnimationCreator;->createAnimation(Landroid/view/View;Landroidx/transition/TransitionValues;IIFFFFLandroid/animation/TimeInterpolator;)Landroid/animation/Animator;

    move-result-object v2

    return-object v2
.end method

.method public setSlideEdge(I)V
    .locals 2
    .param p1, "slideEdge"    # I

    .line 203
    const/4 v0, 0x3

    if-eq p1, v0, :cond_5

    const/4 v0, 0x5

    if-eq p1, v0, :cond_4

    const/16 v0, 0x30

    if-eq p1, v0, :cond_3

    const/16 v0, 0x50

    if-eq p1, v0, :cond_2

    const v0, 0x800003

    if-eq p1, v0, :cond_1

    const v0, 0x800005

    if-ne p1, v0, :cond_0

    .line 220
    sget-object v0, Landroidx/transition/Slide;->sCalculateEnd:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 221
    goto :goto_0

    .line 223
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Invalid slide direction"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 217
    :cond_1
    sget-object v0, Landroidx/transition/Slide;->sCalculateStart:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 218
    goto :goto_0

    .line 214
    :cond_2
    sget-object v0, Landroidx/transition/Slide;->sCalculateBottom:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 215
    goto :goto_0

    .line 208
    :cond_3
    sget-object v0, Landroidx/transition/Slide;->sCalculateTop:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 209
    goto :goto_0

    .line 211
    :cond_4
    sget-object v0, Landroidx/transition/Slide;->sCalculateRight:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 212
    goto :goto_0

    .line 205
    :cond_5
    sget-object v0, Landroidx/transition/Slide;->sCalculateLeft:Landroidx/transition/Slide$CalculateSlide;

    iput-object v0, p0, Landroidx/transition/Slide;->mSlideCalculator:Landroidx/transition/Slide$CalculateSlide;

    .line 206
    nop

    .line 225
    :goto_0
    iput p1, p0, Landroidx/transition/Slide;->mSlideEdge:I

    .line 226
    new-instance v0, Landroidx/transition/SidePropagation;

    invoke-direct {v0}, Landroidx/transition/SidePropagation;-><init>()V

    .line 227
    .local v0, "propagation":Landroidx/transition/SidePropagation;
    invoke-virtual {v0, p1}, Landroidx/transition/SidePropagation;->setSide(I)V

    .line 228
    invoke-virtual {p0, v0}, Landroidx/transition/Slide;->setPropagation(Landroidx/transition/TransitionPropagation;)V

    .line 229
    return-void
.end method
