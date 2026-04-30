.class public final Lcom/luxury/mobile/gui/NewsActivity;
.super Landroid/app/Activity;
.source "NewsActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/NewsActivity$FetchTask;,
        Lcom/luxury/mobile/gui/NewsActivity$ImageTask;
    }
.end annotation


# static fields
.field public static final EXTRA_NEWS_ID:Ljava/lang/String; = "news_id"


# instance fields
.field private body:Landroid/widget/TextView;

.field private errorView:Landroid/widget/TextView;

.field private image:Landroid/widget/ImageView;

.field private loader:Landroid/widget/ProgressBar;

.field private meta:Landroid/widget/TextView;

.field private title:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$100(Lcom/luxury/mobile/gui/NewsActivity;Lorg/json/JSONObject;)V
    .locals 0

    .line 40
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/NewsActivity;->showArticle(Lorg/json/JSONObject;)V

    return-void
.end method

.method static synthetic access$200(Lcom/luxury/mobile/gui/NewsActivity;Ljava/lang/String;)V
    .locals 0

    .line 40
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/NewsActivity;->showError(Ljava/lang/String;)V

    return-void
.end method

.method private buildContentView()Landroid/view/View;
    .locals 15

    .line 70
    new-instance v0, Landroid/widget/LinearLayout;

    invoke-direct {v0, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v1, 0x1

    .line 71
    invoke-virtual {v0, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const v2, -0xf5f1e9

    .line 72
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    .line 73
    new-instance v2, Landroid/view/ViewGroup$LayoutParams;

    const/4 v3, -0x1

    invoke-direct {v2, v3, v3}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 78
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v4, 0x0

    .line 79
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    const v5, -0xefe8db

    .line 80
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->setBackgroundColor(I)V

    const/16 v5, 0x10

    .line 81
    invoke-virtual {v2, v5}, Landroid/widget/LinearLayout;->setGravity(I)V

    const/16 v6, 0xc

    .line 82
    invoke-direct {p0, v6}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v7

    const/16 v8, 0xa

    invoke-direct {p0, v8}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v9

    invoke-direct {p0, v6}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v10

    invoke-direct {p0, v8}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v8

    invoke-virtual {v2, v7, v9, v10, v8}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 83
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v8, -0x2

    invoke-direct {v7, v3, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 87
    new-instance v7, Landroid/widget/Button;

    invoke-direct {v7, p0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    const-string v9, "\u2190"

    .line 88
    invoke-virtual {v7, v9}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    const/4 v9, 0x2

    const/high16 v10, 0x41900000    # 18.0f

    .line 89
    invoke-virtual {v7, v9, v10}, Landroid/widget/Button;->setTextSize(IF)V

    .line 90
    invoke-virtual {v7, v3}, Landroid/widget/Button;->setTextColor(I)V

    const v11, -0xe4dbcc

    .line 91
    invoke-virtual {v7, v11}, Landroid/widget/Button;->setBackgroundColor(I)V

    .line 92
    invoke-direct {p0, v5}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v11

    const/4 v12, 0x6

    invoke-direct {p0, v12}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v13

    invoke-direct {p0, v5}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v14

    invoke-direct {p0, v12}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v12

    invoke-virtual {v7, v11, v13, v14, v12}, Landroid/widget/Button;->setPadding(IIII)V

    .line 93
    new-instance v11, Lcom/luxury/mobile/gui/NewsActivity$1;

    invoke-direct {v11, p0}, Lcom/luxury/mobile/gui/NewsActivity$1;-><init>(Lcom/luxury/mobile/gui/NewsActivity;)V

    invoke-virtual {v7, v11}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 99
    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 101
    new-instance v7, Landroid/widget/TextView;

    invoke-direct {v7, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v11, "\u0627\u0644\u062e\u0628\u0631"

    .line 102
    invoke-virtual {v7, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 103
    invoke-virtual {v7, v9, v10}, Landroid/widget/TextView;->setTextSize(IF)V

    const v10, -0xc46b6

    .line 104
    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setTextColor(I)V

    .line 105
    new-instance v10, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v11, 0x3f800000    # 1.0f

    invoke-direct {v10, v4, v8, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    .line 107
    invoke-direct {p0, v6}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v12

    iput v12, v10, Landroid/widget/LinearLayout$LayoutParams;->leftMargin:I

    .line 108
    invoke-virtual {v7, v10}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 109
    invoke-virtual {v2, v7}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 111
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 114
    new-instance v2, Landroid/widget/FrameLayout;

    invoke-direct {v2, p0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 115
    new-instance v7, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v7, v3, v4, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v2, v7}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 119
    new-instance v4, Landroid/widget/ProgressBar;

    invoke-direct {v4, p0}, Landroid/widget/ProgressBar;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/luxury/mobile/gui/NewsActivity;->loader:Landroid/widget/ProgressBar;

    .line 120
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v7, 0x38

    .line 121
    invoke-direct {p0, v7}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v10

    invoke-direct {p0, v7}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v7

    const/16 v11, 0x11

    invoke-direct {v4, v10, v7, v11}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    iget-object v7, p0, Lcom/luxury/mobile/gui/NewsActivity;->loader:Landroid/widget/ProgressBar;

    .line 122
    invoke-virtual {v2, v7, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    const v7, -0x9495

    .line 125
    invoke-virtual {v4, v7}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v4, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    const/high16 v7, 0x41800000    # 16.0f

    .line 126
    invoke-virtual {v4, v9, v7}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v4, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    .line 127
    invoke-virtual {v4, v11}, Landroid/widget/TextView;->setGravity(I)V

    iget-object v4, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    const/16 v10, 0x8

    .line 128
    invoke-virtual {v4, v10}, Landroid/widget/TextView;->setVisibility(I)V

    .line 129
    new-instance v4, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v4, v3, v8, v11}, Landroid/widget/FrameLayout$LayoutParams;-><init>(III)V

    const/16 v11, 0x18

    .line 132
    invoke-direct {p0, v11}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v12

    iput v12, v4, Landroid/widget/FrameLayout$LayoutParams;->rightMargin:I

    iput v12, v4, Landroid/widget/FrameLayout$LayoutParams;->leftMargin:I

    iget-object v12, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    .line 133
    invoke-virtual {v2, v12, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 136
    new-instance v4, Landroid/widget/ScrollView;

    invoke-direct {v4, p0}, Landroid/widget/ScrollView;-><init>(Landroid/content/Context;)V

    .line 137
    invoke-virtual {v4, v10}, Landroid/widget/ScrollView;->setVisibility(I)V

    .line 138
    new-instance v12, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v12, v3, v3}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v4, v12}, Landroid/widget/ScrollView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 142
    new-instance v12, Landroid/widget/LinearLayout;

    invoke-direct {v12, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    .line 143
    invoke-virtual {v12, v1}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 144
    invoke-direct {p0, v5}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v13

    invoke-direct {p0, v5}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v14

    invoke-direct {p0, v5}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v5

    invoke-direct {p0, v11}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v11

    invoke-virtual {v12, v13, v14, v5, v11}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 145
    new-instance v5, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v5, v3, v8}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v12, v5}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 149
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->title:Landroid/widget/TextView;

    .line 150
    invoke-virtual {v5, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->title:Landroid/widget/TextView;

    const/high16 v11, 0x41b00000    # 22.0f

    .line 151
    invoke-virtual {v5, v9, v11}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->title:Landroid/widget/TextView;

    const/4 v11, 0x0

    .line 152
    invoke-virtual {v5, v11, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;I)V

    iget-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->title:Landroid/widget/TextView;

    .line 153
    invoke-virtual {v12, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 155
    new-instance v5, Landroid/widget/TextView;

    invoke-direct {v5, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->meta:Landroid/widget/TextView;

    const v11, -0x4f493e

    .line 156
    invoke-virtual {v5, v11}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->meta:Landroid/widget/TextView;

    const/high16 v11, 0x41400000    # 12.0f

    .line 157
    invoke-virtual {v5, v9, v11}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 158
    new-instance v5, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v5, v3, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/4 v11, 0x4

    .line 161
    invoke-direct {p0, v11}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v13

    iput v13, v5, Landroid/widget/LinearLayout$LayoutParams;->topMargin:I

    .line 162
    invoke-direct {p0, v6}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v13

    iput v13, v5, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v13, p0, Lcom/luxury/mobile/gui/NewsActivity;->meta:Landroid/widget/TextView;

    .line 163
    invoke-virtual {v13, v5}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->meta:Landroid/widget/TextView;

    .line 164
    invoke-virtual {v12, v5}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 166
    new-instance v5, Landroid/widget/ImageView;

    invoke-direct {v5, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    .line 167
    invoke-virtual {v5, v10}, Landroid/widget/ImageView;->setVisibility(I)V

    iget-object v5, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    .line 168
    invoke-virtual {v5, v1}, Landroid/widget/ImageView;->setAdjustViewBounds(Z)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    .line 169
    sget-object v5, Landroid/widget/ImageView$ScaleType;->FIT_CENTER:Landroid/widget/ImageView$ScaleType;

    invoke-virtual {v1, v5}, Landroid/widget/ImageView;->setScaleType(Landroid/widget/ImageView$ScaleType;)V

    .line 170
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v3, v8}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 173
    invoke-direct {p0, v6}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v3, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    .line 174
    invoke-virtual {v3, v1}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    .line 175
    invoke-virtual {v12, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 177
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->body:Landroid/widget/TextView;

    const v3, -0x191611

    .line 178
    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->body:Landroid/widget/TextView;

    .line 179
    invoke-virtual {v1, v9, v7}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->body:Landroid/widget/TextView;

    .line 180
    invoke-direct {p0, v11}, Lcom/luxury/mobile/gui/NewsActivity;->dp(I)I

    move-result v3

    int-to-float v3, v3

    const v5, 0x3f8ccccd    # 1.1f

    invoke-virtual {v1, v3, v5}, Landroid/widget/TextView;->setLineSpacing(FF)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->body:Landroid/widget/TextView;

    .line 181
    invoke-static {}, Landroid/text/method/LinkMovementMethod;->getInstance()Landroid/text/method/MovementMethod;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setMovementMethod(Landroid/text/method/MovementMethod;)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->body:Landroid/widget/TextView;

    .line 182
    invoke-virtual {v12, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 184
    invoke-virtual {v4, v12}, Landroid/widget/ScrollView;->addView(Landroid/view/View;)V

    .line 185
    invoke-virtual {v2, v4}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;)V

    .line 186
    invoke-virtual {v0, v2}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-object v0
.end method

.method private dp(I)I
    .locals 1

    int-to-float p1, p1

    .line 271
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/NewsActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v0

    iget v0, v0, Landroid/util/DisplayMetrics;->density:F

    mul-float p1, p1, v0

    const/high16 v0, 0x3f000000    # 0.5f

    add-float/2addr p1, v0

    float-to-int p1, p1

    return p1
.end method

.method private showArticle(Lorg/json/JSONObject;)V
    .locals 10

    const/4 v0, 0x0

    .line 202
    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/NewsActivity;->showLoading(Z)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    .line 203
    invoke-virtual {v1}, Landroid/widget/TextView;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->findViewWithTag(Ljava/lang/Object;)Landroid/view/View;

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->loader:Landroid/widget/ProgressBar;

    .line 206
    invoke-virtual {v1}, Landroid/widget/ProgressBar;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    check-cast v1, Landroid/view/ViewGroup;

    const/4 v2, 0x0

    .line 207
    :goto_0
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 208
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    .line 209
    instance-of v4, v3, Landroid/widget/ScrollView;

    if-eqz v4, :cond_0

    .line 210
    invoke-virtual {v3, v0}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->title:Landroid/widget/TextView;

    const-string v2, "title"

    const-string v3, ""

    .line 214
    invoke-virtual {p1, v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 216
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "author"

    .line 217
    invoke-virtual {p1, v2, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 218
    invoke-virtual {v2}, Ljava/lang/String;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    const-string v2, "created_at"

    const-wide/16 v4, 0x0

    .line 219
    invoke-virtual {p1, v2, v4, v5}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;J)J

    move-result-wide v6

    cmp-long v2, v6, v4

    if-lez v2, :cond_4

    .line 221
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->length()I

    move-result v2

    if-lez v2, :cond_3

    const-string v2, "  \u2022  "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 222
    :cond_3
    new-instance v2, Ljava/text/SimpleDateFormat;

    const-string v4, "dd MMM yyyy"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v5

    invoke-direct {v2, v4, v5}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    new-instance v4, Ljava/util/Date;

    const-wide/16 v8, 0x3e8

    mul-long v6, v6, v8

    invoke-direct {v4, v6, v7}, Ljava/util/Date;-><init>(J)V

    .line 223
    invoke-virtual {v2, v4}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    .line 222
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_4
    iget-object v2, p0, Lcom/luxury/mobile/gui/NewsActivity;->meta:Landroid/widget/TextView;

    .line 225
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const-string v1, "image"

    .line 227
    invoke-virtual {p1, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 228
    invoke-virtual {v1}, Ljava/lang/String;->isEmpty()Z

    move-result v2

    if-nez v2, :cond_5

    iget-object v2, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    .line 229
    invoke-virtual {v2, v0}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 230
    new-instance v0, Lcom/luxury/mobile/gui/NewsActivity$ImageTask;

    iget-object v2, p0, Lcom/luxury/mobile/gui/NewsActivity;->image:Landroid/widget/ImageView;

    invoke-direct {v0, v2}, Lcom/luxury/mobile/gui/NewsActivity$ImageTask;-><init>(Landroid/widget/ImageView;)V

    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/gui/NewsActivity$ImageTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    :cond_5
    iget-object v0, p0, Lcom/luxury/mobile/gui/NewsActivity;->body:Landroid/widget/TextView;

    const-string v1, "summary"

    .line 233
    invoke-virtual {p1, v1, v3}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "body"

    invoke-virtual {p1, v2, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void
.end method

.method private showError(Ljava/lang/String;)V
    .locals 2

    const/4 v0, 0x0

    .line 196
    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/NewsActivity;->showLoading(Z)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    .line 197
    invoke-virtual {v1, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object p1, p0, Lcom/luxury/mobile/gui/NewsActivity;->errorView:Landroid/widget/TextView;

    .line 198
    invoke-virtual {p1, v0}, Landroid/widget/TextView;->setVisibility(I)V

    return-void
.end method

.method private showLoading(Z)V
    .locals 1

    iget-object v0, p0, Lcom/luxury/mobile/gui/NewsActivity;->loader:Landroid/widget/ProgressBar;

    if-eqz p1, :cond_0

    const/4 p1, 0x0

    goto :goto_0

    :cond_0
    const/16 p1, 0x8

    .line 192
    :goto_0
    invoke-virtual {v0, p1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 4

    .line 53
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 55
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/NewsActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Lcom/luxury/mobile/gui/NewsActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const-string v1, "news_id"

    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result p1

    goto :goto_0

    :cond_0
    const/4 p1, 0x0

    .line 57
    :goto_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/NewsActivity;->buildContentView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/NewsActivity;->setContentView(Landroid/view/View;)V

    if-gtz p1, :cond_1

    const-string p1, "\u0645\u0639\u0631\u0641 \u0627\u0644\u062e\u0628\u0631 \u063a\u064a\u0631 \u0635\u0627\u0644\u062d"

    .line 59
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/NewsActivity;->showError(Ljava/lang/String;)V

    return-void

    :cond_1
    const/4 v1, 0x1

    .line 62
    invoke-direct {p0, v1}, Lcom/luxury/mobile/gui/NewsActivity;->showLoading(Z)V

    .line 63
    new-instance v2, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;

    const/4 v3, 0x0

    invoke-direct {v2, p0, v3}, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;-><init>(Lcom/luxury/mobile/gui/NewsActivity;Lcom/luxury/mobile/gui/NewsActivity$1;)V

    new-array v1, v1, [Ljava/lang/Integer;

    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    aput-object p1, v1, v0

    invoke-virtual {v2, v1}, Lcom/luxury/mobile/gui/NewsActivity$FetchTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method
