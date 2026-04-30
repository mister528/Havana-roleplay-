.class public final Lcom/luxury/mobile/util/UpdateBanner;
.super Ljava/lang/Object;
.source "UpdateBanner.java"


# static fields
.field private static final BANNER_ID:I = 0x7f77aabb


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Landroid/app/Activity;)V
    .locals 0

    .line 24
    invoke-static {p0}, Lcom/luxury/mobile/util/UpdateBanner;->attach(Landroid/app/Activity;)V

    return-void
.end method

.method static synthetic access$100(Landroid/view/View;)Landroid/app/Activity;
    .locals 0

    .line 24
    invoke-static {p0}, Lcom/luxury/mobile/util/UpdateBanner;->findActivity(Landroid/view/View;)Landroid/app/Activity;

    move-result-object p0

    return-object p0
.end method

.method private static attach(Landroid/app/Activity;)V
    .locals 10

    .line 61
    :try_start_0
    invoke-virtual {p0}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    const v1, 0x7f77aabb

    .line 62
    invoke-virtual {v0, v1}, Landroid/view/ViewGroup;->findViewById(I)Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_0

    return-void

    .line 64
    :cond_0
    invoke-virtual {p0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v2

    iget v2, v2, Landroid/util/DisplayMetrics;->density:F

    float-to-int v2, v2

    .line 66
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 67
    invoke-virtual {v3, v1}, Landroid/widget/LinearLayout;->setId(I)V

    const/4 v4, 0x0

    .line 68
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const/16 v4, 0x10

    .line 69
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    mul-int/lit8 v4, v2, 0x10

    mul-int/lit8 v5, v2, 0xa

    .line 70
    invoke-virtual {v3, v4, v5, v4, v5}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 72
    new-instance v4, Landroid/graphics/drawable/GradientDrawable;

    sget-object v5, Landroid/graphics/drawable/GradientDrawable$Orientation;->LEFT_RIGHT:Landroid/graphics/drawable/GradientDrawable$Orientation;

    const v6, -0xc46b6

    const v7, -0x3871e1

    filled-new-array {v6, v7}, [I

    move-result-object v6

    invoke-direct {v4, v5, v6}, Landroid/graphics/drawable/GradientDrawable;-><init>(Landroid/graphics/drawable/GradientDrawable$Orientation;[I)V

    mul-int/lit8 v5, v2, 0x1c

    int-to-float v6, v5

    .line 75
    invoke-virtual {v4, v6}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 76
    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 78
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v6, "\u27f3"

    .line 79
    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const v6, -0xf5f1e9

    .line 80
    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v7, 0x41900000    # 18.0f

    const/4 v8, 0x2

    .line 81
    invoke-virtual {v4, v8, v7}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 82
    sget-object v7, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 83
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v9, -0x2

    invoke-direct {v7, v9, v9}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    mul-int/lit8 v2, v2, 0x8

    .line 85
    iput v2, v7, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 86
    invoke-virtual {v3, v4, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 88
    new-instance v2, Landroid/widget/TextView;

    invoke-direct {v2, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 89
    sget-boolean v4, Lcom/luxury/mobile/util/UpdateChecker;->updateRequired:Z

    if-eqz v4, :cond_1

    const-string v4, "\u062a\u062d\u062f\u064a\u062b \u0625\u0644\u0632\u0627\u0645\u064a \u00b7 \u0627\u0636\u063a\u0637 \u0627\u0644\u0622\u0646"

    goto :goto_0

    :cond_1
    const-string v4, "\u062a\u062d\u062f\u064a\u062b \u0645\u062a\u0627\u062d \u00b7 \u0627\u0636\u063a\u0637 \u0644\u0644\u062a\u062d\u062f\u064a\u062b"

    :goto_0
    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 92
    invoke-virtual {v2, v6}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v4, 0x41600000    # 14.0f

    .line 93
    invoke-virtual {v2, v8, v4}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 94
    sget-object v4, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 95
    invoke-virtual {v3, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 97
    new-instance v2, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v2, v9, v9}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    const/16 v4, 0x31

    .line 100
    iput v4, v2, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    .line 101
    iput v5, v2, Landroid/widget/FrameLayout$LayoutParams;->topMargin:I

    .line 105
    instance-of v4, v0, Landroid/widget/FrameLayout;

    if-eqz v4, :cond_2

    .line 106
    invoke-virtual {v0, v3, v2}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto :goto_1

    .line 108
    :cond_2
    new-instance v4, Landroid/widget/FrameLayout;

    invoke-direct {v4, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 109
    invoke-virtual {v4, v1}, Landroid/widget/FrameLayout;->setId(I)V

    .line 110
    invoke-virtual {v4, v3, v2}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 111
    new-instance p0, Landroid/view/ViewGroup$LayoutParams;

    const/4 v1, -0x1

    invoke-direct {p0, v1, v1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v4, p0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    :goto_1
    const/4 p0, 0x1

    .line 117
    invoke-virtual {v3, p0}, Landroid/widget/LinearLayout;->setClickable(Z)V

    .line 118
    new-instance p0, Lcom/luxury/mobile/util/UpdateBanner$3;

    invoke-direct {p0}, Lcom/luxury/mobile/util/UpdateBanner$3;-><init>()V

    invoke-virtual {v3, p0}, Landroid/widget/LinearLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method

.method private static findActivity(Landroid/view/View;)Landroid/app/Activity;
    .locals 1

    .line 138
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object p0

    .line 139
    :goto_0
    instance-of v0, p0, Landroid/content/ContextWrapper;

    if-eqz v0, :cond_1

    .line 140
    instance-of v0, p0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    check-cast p0, Landroid/app/Activity;

    return-object p0

    .line 141
    :cond_0
    check-cast p0, Landroid/content/ContextWrapper;

    invoke-virtual {p0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object p0

    goto :goto_0

    :cond_1
    const/4 p0, 0x0

    return-object p0
.end method

.method public static hide(Landroid/app/Activity;)V
    .locals 2

    if-nez p0, :cond_0

    return-void

    .line 46
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/luxury/mobile/util/UpdateBanner$2;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/util/UpdateBanner$2;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method

.method public static show(Landroid/app/Activity;)V
    .locals 2

    if-nez p0, :cond_0

    return-void

    .line 34
    :cond_0
    sget-boolean v0, Lcom/luxury/mobile/util/UpdateChecker;->updateAvailable:Z

    if-nez v0, :cond_1

    return-void

    .line 35
    :cond_1
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/luxury/mobile/util/UpdateBanner$1;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/util/UpdateBanner$1;-><init>(Landroid/app/Activity;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    return-void
.end method
