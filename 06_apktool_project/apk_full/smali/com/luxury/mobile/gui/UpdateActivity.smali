.class public final Lcom/luxury/mobile/gui/UpdateActivity;
.super Landroid/app/Activity;
.source "UpdateActivity.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;
    }
.end annotation


# static fields
.field private static final COLOR_BG_BOTTOM:I = -0xede7d6

.field private static final COLOR_BG_TOP:I = -0xf5f1e9

.field private static final COLOR_GOLD:I = -0xc46b6

.field private static final COLOR_GOLD_DARK:I = -0x3871e1

.field private static final COLOR_MUTED:I = -0x4f493e

.field private static final COLOR_PANEL:I = -0xe5dcca

.field private static final COLOR_TEXT:I = -0x1

.field public static final EXTRA_APK_URL:Ljava/lang/String; = "apk_url"

.field public static final EXTRA_CHANGELOG:Ljava/lang/String; = "changelog"

.field public static final EXTRA_FORCE:Ljava/lang/String; = "force"

.field public static final EXTRA_VERSION_CODE:Ljava/lang/String; = "version_code"

.field public static final EXTRA_VERSION_NAME:Ljava/lang/String; = "version_name"


# instance fields
.field private apkUrl:Ljava/lang/String;

.field private changelog:Ljava/lang/String;

.field private changelogView:Landroid/widget/TextView;

.field private dismissBtn:Landroid/widget/TextView;

.field private downloading:Z

.field private force:Z

.field private percentView:Landroid/widget/TextView;

.field private progressBar:Landroid/widget/ProgressBar;

.field private statusView:Landroid/widget/TextView;

.field private subtitleView:Landroid/widget/TextView;

.field private titleView:Landroid/widget/TextView;

.field private updateBtn:Landroid/widget/Button;

.field private versionName:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 48
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/gui/UpdateActivity;)V
    .locals 0

    .line 48
    invoke-direct {p0}, Lcom/luxury/mobile/gui/UpdateActivity;->startDownload()V

    return-void
.end method

.method static synthetic access$100(Lcom/luxury/mobile/gui/UpdateActivity;)Z
    .locals 0

    .line 48
    iget-boolean p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->downloading:Z

    return p0
.end method

.method static synthetic access$1000(Lcom/luxury/mobile/gui/UpdateActivity;)Z
    .locals 0

    .line 48
    iget-boolean p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->force:Z

    return p0
.end method

.method static synthetic access$102(Lcom/luxury/mobile/gui/UpdateActivity;Z)Z
    .locals 0

    .line 48
    iput-boolean p1, p0, Lcom/luxury/mobile/gui/UpdateActivity;->downloading:Z

    return p1
.end method

.method static synthetic access$1100(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;
    .locals 0

    .line 48
    iget-object p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$1200(Lcom/luxury/mobile/gui/UpdateActivity;Ljava/io/File;)V
    .locals 0

    .line 48
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity;->installApk(Ljava/io/File;)V

    return-void
.end method

.method static synthetic access$300(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/ProgressBar;
    .locals 0

    .line 48
    iget-object p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    return-object p0
.end method

.method static synthetic access$500(Lcom/luxury/mobile/gui/UpdateActivity;I)V
    .locals 0

    .line 48
    invoke-direct {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity;->smoothProgress(I)V

    return-void
.end method

.method static synthetic access$600(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;
    .locals 0

    .line 48
    iget-object p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$700(J)Ljava/lang/String;
    .locals 0

    .line 48
    invoke-static {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity;->formatBytes(J)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method static synthetic access$800(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/TextView;
    .locals 0

    .line 48
    iget-object p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    return-object p0
.end method

.method static synthetic access$900(Lcom/luxury/mobile/gui/UpdateActivity;)Landroid/widget/Button;
    .locals 0

    .line 48
    iget-object p0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    return-object p0
.end method

.method private buildView(I)Landroid/view/View;
    .locals 17

    move-object/from16 v0, p0

    move/from16 v1, p1

    .line 102
    new-instance v2, Landroid/widget/LinearLayout;

    invoke-direct {v2, v0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    const/4 v3, 0x1

    .line 103
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 104
    new-instance v4, Landroid/graphics/drawable/GradientDrawable;

    sget-object v5, Landroid/graphics/drawable/GradientDrawable$Orientation;->TOP_BOTTOM:Landroid/graphics/drawable/GradientDrawable$Orientation;

    const v6, -0xede7d6

    const v7, -0xf5f1e9

    filled-new-array {v7, v6}, [I

    move-result-object v6

    invoke-direct {v4, v5, v6}, Landroid/graphics/drawable/GradientDrawable;-><init>(Landroid/graphics/drawable/GradientDrawable$Orientation;[I)V

    .line 107
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 108
    new-instance v4, Landroid/view/ViewGroup$LayoutParams;

    const/4 v5, -0x1

    invoke-direct {v4, v5, v5}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    const/16 v4, 0x18

    .line 110
    invoke-direct {v0, v4}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v6

    const/16 v8, 0x30

    invoke-direct {v0, v8}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v8

    invoke-direct {v0, v4}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v9

    invoke-direct {v0, v4}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    invoke-virtual {v2, v6, v8, v9, v4}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 111
    invoke-virtual {v2, v3}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 114
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v6, "HAVANA RP"

    .line 115
    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    const v6, -0xc46b6

    .line 116
    invoke-virtual {v4, v6}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v8, 0x41b00000    # 22.0f

    const/4 v9, 0x2

    .line 117
    invoke-virtual {v4, v9, v8}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 118
    sget-object v8, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    const v8, 0x3e19999a    # 0.15f

    .line 119
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setLetterSpacing(F)V

    .line 120
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v10, -0x2

    invoke-direct {v8, v10, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v11, 0x20

    .line 122
    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v11

    iput v11, v8, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 123
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 124
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 127
    new-instance v4, Landroid/widget/FrameLayout;

    invoke-direct {v4, v0}, Landroid/widget/FrameLayout;-><init>(Landroid/content/Context;)V

    .line 128
    new-instance v8, Landroid/widget/FrameLayout$LayoutParams;

    const/16 v11, 0x60

    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v12

    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v13

    invoke-direct {v8, v12, v13}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 129
    new-instance v8, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v8}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 130
    invoke-virtual {v8, v3}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    const v12, 0x33f3b94a

    .line 131
    invoke-virtual {v8, v12}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 132
    invoke-direct {v0, v9}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v12

    invoke-virtual {v8, v12, v6}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 133
    invoke-virtual {v4, v8}, Landroid/widget/FrameLayout;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 134
    new-instance v8, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v12

    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v11

    invoke-direct {v8, v12, v11}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v11, 0x14

    .line 135
    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v12

    iput v12, v8, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    .line 136
    invoke-virtual {v4, v8}, Landroid/widget/FrameLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 138
    new-instance v8, Landroid/widget/TextView;

    invoke-direct {v8, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    const-string v12, "\u27f3"

    .line 139
    invoke-virtual {v8, v12}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 140
    invoke-virtual {v8, v6}, Landroid/widget/TextView;->setTextColor(I)V

    const/high16 v12, 0x42400000    # 48.0f

    .line 141
    invoke-virtual {v8, v9, v12}, Landroid/widget/TextView;->setTextSize(IF)V

    const/16 v12, 0x11

    .line 142
    invoke-virtual {v8, v12}, Landroid/widget/TextView;->setGravity(I)V

    .line 143
    new-instance v13, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v13, v5, v5}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 145
    invoke-virtual {v4, v8, v13}, Landroid/widget/FrameLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 146
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 149
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    iget-boolean v8, v0, Lcom/luxury/mobile/gui/UpdateActivity;->force:Z

    if-eqz v8, :cond_0

    const-string v8, "\u062a\u062d\u062f\u064a\u062b \u0625\u0644\u0632\u0627\u0645\u064a"

    goto :goto_0

    :cond_0
    const-string v8, "\u062a\u062d\u062f\u064a\u062b \u0645\u062a\u0627\u062d"

    .line 150
    :goto_0
    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    .line 151
    invoke-virtual {v4, v5}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    const/high16 v8, 0x41e00000    # 28.0f

    .line 152
    invoke-virtual {v4, v9, v8}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    .line 153
    sget-object v8, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v4, v8}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    .line 154
    invoke-virtual {v4, v12}, Landroid/widget/TextView;->setGravity(I)V

    .line 155
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v4, v5, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v8, 0x8

    .line 157
    invoke-direct {v0, v8}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v13

    iput v13, v4, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v13, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    .line 158
    invoke-virtual {v13, v4}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->titleView:Landroid/widget/TextView;

    .line 159
    invoke-virtual {v2, v4}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 162
    new-instance v4, Landroid/widget/TextView;

    invoke-direct {v4, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    .line 163
    new-instance v4, Ljava/lang/StringBuilder;

    const-string v13, "\u0627\u0644\u0625\u0635\u062f\u0627\u0631 "

    invoke-direct {v4, v13}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v13, v0, Lcom/luxury/mobile/gui/UpdateActivity;->versionName:Ljava/lang/String;

    .line 164
    invoke-static {v13}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v13

    if-nez v13, :cond_1

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->versionName:Ljava/lang/String;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_1
    if-lez v1, :cond_2

    .line 165
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 166
    :cond_2
    :goto_1
    invoke-direct/range {p0 .. p0}, Lcom/luxury/mobile/gui/UpdateActivity;->currentVersionCode()J

    move-result-wide v13

    const-wide/16 v15, 0x0

    cmp-long v1, v13, v15

    if-lez v1, :cond_3

    const-string v1, "  \u2190  \u062d\u0627\u0644\u064a\u0627\u064b "

    .line 168
    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v13, v14}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    :cond_3
    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    .line 170
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    const v4, -0x4f493e

    .line 171
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    const/high16 v13, 0x41600000    # 14.0f

    .line 172
    invoke-virtual {v1, v9, v13}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    .line 173
    invoke-virtual {v1, v12}, Landroid/widget/TextView;->setGravity(I)V

    .line 174
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v5, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 176
    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v14

    iput v14, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v14, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    .line 177
    invoke-virtual {v14, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->subtitleView:Landroid/widget/TextView;

    .line 178
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelog:Ljava/lang/String;

    .line 181
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/16 v14, 0x1c

    const/16 v15, 0xc

    if-nez v1, :cond_4

    .line 182
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    iget-object v7, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelog:Ljava/lang/String;

    .line 183
    invoke-virtual {v1, v7}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    const v7, -0x28241d

    .line 184
    invoke-virtual {v1, v7}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    .line 185
    invoke-virtual {v1, v9, v13}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    .line 186
    invoke-direct {v0, v9}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v7

    int-to-float v7, v7

    const v11, 0x3f933333    # 1.15f

    invoke-virtual {v1, v7, v11}, Landroid/widget/TextView;->setLineSpacing(FF)V

    .line 187
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    const v7, -0xe5dcca

    .line 188
    invoke-virtual {v1, v7}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 189
    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v7

    int-to-float v7, v7

    invoke-virtual {v1, v7}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 190
    invoke-direct {v0, v3}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v3

    const v7, 0x33ffffff

    invoke-virtual {v1, v3, v7}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    iget-object v3, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    .line 191
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    const/16 v3, 0x10

    .line 192
    invoke-direct {v0, v3}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v7

    const/16 v11, 0xe

    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    invoke-direct {v0, v3}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v3

    invoke-direct {v0, v11}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v11

    invoke-virtual {v1, v7, v4, v3, v11}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 193
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v5, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 195
    invoke-direct {v0, v14}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v3

    iput v3, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v3, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    .line 196
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->changelogView:Landroid/widget/TextView;

    .line 197
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 201
    :cond_4
    new-instance v1, Landroid/widget/ProgressBar;

    const/4 v3, 0x0

    const v4, 0x1010078

    invoke-direct {v1, v0, v3, v4}, Landroid/widget/ProgressBar;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;I)V

    iput-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    const/16 v3, 0x3e8

    .line 202
    invoke-virtual {v1, v3}, Landroid/widget/ProgressBar;->setMax(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    const/4 v3, 0x0

    .line 203
    invoke-virtual {v1, v3}, Landroid/widget/ProgressBar;->setProgress(I)V

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v4, 0x15

    if-lt v1, v4, :cond_5

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 205
    invoke-static {v6}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v4

    invoke-virtual {v1, v4}, Landroid/widget/ProgressBar;->setProgressTintList(Landroid/content/res/ColorStateList;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    const v4, 0x22ffffff

    .line 207
    invoke-static {v4}, Landroid/content/res/ColorStateList;->valueOf(I)Landroid/content/res/ColorStateList;

    move-result-object v4

    .line 206
    invoke-virtual {v1, v4}, Landroid/widget/ProgressBar;->setProgressBackgroundTintList(Landroid/content/res/ColorStateList;)V

    goto :goto_2

    :cond_5
    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 209
    invoke-virtual {v1}, Landroid/widget/ProgressBar;->getProgressDrawable()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    sget-object v4, Landroid/graphics/PorterDuff$Mode;->SRC_IN:Landroid/graphics/PorterDuff$Mode;

    invoke-virtual {v1, v6, v4}, Landroid/graphics/drawable/Drawable;->setColorFilter(ILandroid/graphics/PorterDuff$Mode;)V

    .line 212
    :goto_2
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    .line 213
    invoke-direct {v0, v8}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    invoke-direct {v1, v5, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/4 v4, 0x6

    .line 214
    invoke-direct {v0, v4}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 215
    invoke-virtual {v4, v1}, Landroid/widget/ProgressBar;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 216
    invoke-virtual {v1, v8}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 217
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 219
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 220
    invoke-virtual {v1, v6}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 221
    invoke-virtual {v1, v9, v13}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 222
    invoke-virtual {v1, v12}, Landroid/widget/TextView;->setGravity(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    const-string v4, "0%"

    .line 223
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 224
    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setVisibility(I)V

    .line 225
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v5, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 227
    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 228
    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 229
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 231
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    const v4, -0x4f493e

    .line 232
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    const/high16 v4, 0x41500000    # 13.0f

    .line 233
    invoke-virtual {v1, v9, v4}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    .line 234
    invoke-virtual {v1, v12}, Landroid/widget/TextView;->setGravity(I)V

    .line 235
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v5, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    const/16 v4, 0x14

    .line 237
    invoke-direct {v0, v4}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    .line 238
    invoke-virtual {v4, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    .line 239
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 242
    new-instance v1, Landroid/view/View;

    invoke-direct {v1, v0}, Landroid/view/View;-><init>(Landroid/content/Context;)V

    .line 243
    new-instance v4, Landroid/widget/LinearLayout$LayoutParams;

    const/high16 v7, 0x3f800000    # 1.0f

    invoke-direct {v4, v5, v3, v7}, Landroid/widget/LinearLayout$LayoutParams;-><init>(IIF)V

    invoke-virtual {v1, v4}, Landroid/view/View;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 245
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 248
    new-instance v1, Landroid/widget/Button;

    invoke-direct {v1, v0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    const-string v4, "\u062a\u062d\u062f\u064a\u062b \u0627\u0644\u0622\u0646"

    .line 249
    invoke-virtual {v1, v4}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    const v4, -0xf5f1e9

    .line 250
    invoke-virtual {v1, v4}, Landroid/widget/Button;->setTextColor(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    const/high16 v4, 0x41900000    # 18.0f

    .line 251
    invoke-virtual {v1, v9, v4}, Landroid/widget/Button;->setTextSize(IF)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    .line 252
    sget-object v4, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v1, v4}, Landroid/widget/Button;->setTypeface(Landroid/graphics/Typeface;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    .line 253
    invoke-virtual {v1, v3}, Landroid/widget/Button;->setAllCaps(Z)V

    .line 254
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    sget-object v4, Landroid/graphics/drawable/GradientDrawable$Orientation;->LEFT_RIGHT:Landroid/graphics/drawable/GradientDrawable$Orientation;

    const v7, -0x3871e1

    filled-new-array {v6, v7}, [I

    move-result-object v6

    invoke-direct {v1, v4, v6}, Landroid/graphics/drawable/GradientDrawable;-><init>(Landroid/graphics/drawable/GradientDrawable$Orientation;[I)V

    .line 257
    invoke-direct {v0, v14}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    int-to-float v4, v4

    invoke-virtual {v1, v4}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    .line 258
    invoke-virtual {v4, v1}, Landroid/widget/Button;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 259
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/16 v4, 0x38

    .line 260
    invoke-direct {v0, v4}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    invoke-direct {v1, v5, v4}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 261
    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    iput v4, v1, Landroid/widget/LinearLayout$LayoutParams;->bottomMargin:I

    iget-object v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    .line 262
    invoke-virtual {v4, v1}, Landroid/widget/Button;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    .line 263
    new-instance v4, Lcom/luxury/mobile/gui/UpdateActivity$1;

    invoke-direct {v4, v0}, Lcom/luxury/mobile/gui/UpdateActivity$1;-><init>(Lcom/luxury/mobile/gui/UpdateActivity;)V

    invoke-virtual {v1, v4}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    .line 267
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 270
    new-instance v1, Landroid/widget/TextView;

    invoke-direct {v1, v0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    iget-boolean v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->force:Z

    if-eqz v4, :cond_6

    const-string v4, ""

    goto :goto_3

    :cond_6
    const-string v4, "\u0644\u0627\u062d\u0642\u0627\u064b"

    .line 271
    :goto_3
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    const v4, -0x4f493e

    .line 272
    invoke-virtual {v1, v4}, Landroid/widget/TextView;->setTextColor(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    .line 273
    invoke-virtual {v1, v9, v13}, Landroid/widget/TextView;->setTextSize(IF)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    .line 274
    invoke-virtual {v1, v12}, Landroid/widget/TextView;->setGravity(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    .line 275
    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v4

    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v6

    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v7

    invoke-direct {v0, v15}, Lcom/luxury/mobile/gui/UpdateActivity;->dp(I)I

    move-result v9

    invoke-virtual {v1, v4, v6, v7, v9}, Landroid/widget/TextView;->setPadding(IIII)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    iget-boolean v4, v0, Lcom/luxury/mobile/gui/UpdateActivity;->force:Z

    if-eqz v4, :cond_7

    goto :goto_4

    :cond_7
    const/4 v8, 0x0

    .line 276
    :goto_4
    invoke-virtual {v1, v8}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    .line 277
    new-instance v3, Lcom/luxury/mobile/gui/UpdateActivity$2;

    invoke-direct {v3, v0}, Lcom/luxury/mobile/gui/UpdateActivity$2;-><init>(Lcom/luxury/mobile/gui/UpdateActivity;)V

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 281
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {v1, v5, v10}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    iget-object v3, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    .line 283
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    iget-object v1, v0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    .line 284
    invoke-virtual {v2, v1}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    return-object v2
.end method

.method private currentVersionCode()J
    .locals 3

    .line 291
    :try_start_0
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/UpdateActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    invoke-virtual {p0}, Lcom/luxury/mobile/gui/UpdateActivity;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v0

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1c

    if-lt v1, v2, :cond_0

    .line 292
    invoke-virtual {v0}, Landroid/content/pm/PackageInfo;->getLongVersionCode()J

    move-result-wide v0

    goto :goto_0

    :cond_0
    iget v0, v0, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    int-to-long v0, v0

    :goto_0
    return-wide v0

    :catchall_0
    const-wide/16 v0, 0x0

    return-wide v0
.end method

.method private dp(I)I
    .locals 1

    int-to-float p1, p1

    .line 421
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/UpdateActivity;->getResources()Landroid/content/res/Resources;

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

.method private static formatBytes(J)Ljava/lang/String;
    .locals 5

    const-wide/16 v0, 0x400

    cmp-long v2, p0, v0

    if-gez v2, :cond_0

    .line 413
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    const-string p0, " B"

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_0
    long-to-double p0, p0

    const-wide/high16 v0, 0x4090000000000000L    # 1024.0

    .line 414
    invoke-static {p0, p1}, Ljava/lang/Double;->isNaN(D)Z

    div-double/2addr p0, v0

    const/4 v2, 0x0

    const/4 v3, 0x1

    cmpg-double v4, p0, v0

    if-gez v4, :cond_1

    .line 415
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, p1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p0

    aput-object p0, v1, v2

    const-string p0, "%.1f KB"

    invoke-static {v0, p0, v1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0

    :cond_1
    div-double/2addr p0, v0

    .line 417
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    new-array v1, v3, [Ljava/lang/Object;

    invoke-static {p0, p1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object p0

    aput-object p0, v1, v2

    const-string p0, "%.1f MB"

    invoke-static {v0, p0, v1}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private installApk(Ljava/io/File;)V
    .locals 3

    .line 391
    :try_start_0
    new-instance v0, Landroid/content/Intent;

    const-string v1, "android.intent.action.VIEW"

    invoke-direct {v0, v1}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    const/high16 v1, 0x10000000

    .line 392
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    const/4 v1, 0x1

    .line 393
    invoke-virtual {v0, v1}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x18

    if-lt v1, v2, :cond_0

    .line 396
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/luxury/mobile/gui/UpdateActivity;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, ".provider"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 398
    :try_start_1
    invoke-static {p0, v1, p1}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 400
    :catchall_0
    :try_start_2
    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    goto :goto_0

    .line 403
    :cond_0
    invoke-static {p1}, Landroid/net/Uri;->fromFile(Ljava/io/File;)Landroid/net/Uri;

    move-result-object p1

    :goto_0
    const-string v1, "application/vnd.android.package-archive"

    .line 405
    invoke-virtual {v0, p1, v1}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 406
    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/UpdateActivity;->startActivity(Landroid/content/Intent;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p1

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    .line 408
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "\u062a\u0639\u0630\u0651\u0631 \u0641\u062a\u062d \u0627\u0644\u0645\u062b\u0628\u0651\u062a: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    :goto_1
    return-void
.end method

.method private smoothProgress(I)V
    .locals 3

    const/4 v0, 0x2

    :try_start_0
    new-array v0, v0, [I

    iget-object v1, p0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 319
    invoke-virtual {v1}, Landroid/widget/ProgressBar;->getProgress()I

    move-result v1

    const/4 v2, 0x0

    aput v1, v0, v2

    const/4 v1, 0x1

    aput p1, v0, v1

    invoke-static {v0}, Landroid/animation/ValueAnimator;->ofInt([I)Landroid/animation/ValueAnimator;

    move-result-object v0

    const-wide/16 v1, 0x96

    .line 320
    invoke-virtual {v0, v1, v2}, Landroid/animation/ValueAnimator;->setDuration(J)Landroid/animation/ValueAnimator;

    .line 321
    new-instance v1, Landroid/view/animation/AccelerateDecelerateInterpolator;

    invoke-direct {v1}, Landroid/view/animation/AccelerateDecelerateInterpolator;-><init>()V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->setInterpolator(Landroid/animation/TimeInterpolator;)V

    .line 322
    new-instance v1, Lcom/luxury/mobile/gui/UpdateActivity$3;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/gui/UpdateActivity$3;-><init>(Lcom/luxury/mobile/gui/UpdateActivity;)V

    invoke-virtual {v0, v1}, Landroid/animation/ValueAnimator;->addUpdateListener(Landroid/animation/ValueAnimator$AnimatorUpdateListener;)V

    .line 328
    invoke-virtual {v0}, Landroid/animation/ValueAnimator;->start()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 330
    invoke-virtual {v0, p1}, Landroid/widget/ProgressBar;->setProgress(I)V

    :goto_0
    return-void
.end method

.method private startDownload()V
    .locals 3

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->downloading:Z

    if-eqz v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->apkUrl:Ljava/lang/String;

    .line 302
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    const-string v1, "\u0644\u0627 \u064a\u0648\u062c\u062f \u0631\u0627\u0628\u0637 \u0644\u0644\u062a\u062d\u062f\u064a\u062b."

    .line 303
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-void

    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->downloading:Z

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    const/4 v1, 0x0

    .line 307
    invoke-virtual {v0, v1}, Landroid/widget/Button;->setEnabled(Z)V

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->updateBtn:Landroid/widget/Button;

    const-string v2, "\u062c\u0627\u0631\u064a \u0627\u0644\u062a\u062d\u0645\u064a\u0644\u2026"

    .line 308
    invoke-virtual {v0, v2}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->progressBar:Landroid/widget/ProgressBar;

    .line 309
    invoke-virtual {v0, v1}, Landroid/widget/ProgressBar;->setVisibility(I)V

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->percentView:Landroid/widget/TextView;

    .line 310
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->dismissBtn:Landroid/widget/TextView;

    const/16 v1, 0x8

    .line 311
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    iget-object v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->statusView:Landroid/widget/TextView;

    const-string v1, "\u062c\u0627\u0631\u064a \u0627\u0644\u0627\u062a\u0635\u0627\u0644 \u0628\u0627\u0644\u062e\u0627\u062f\u0645\u2026"

    .line 312
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 314
    new-instance v0, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;-><init>(Lcom/luxury/mobile/gui/UpdateActivity;Lcom/luxury/mobile/gui/UpdateActivity$1;)V

    iget-object v1, p0, Lcom/luxury/mobile/gui/UpdateActivity;->apkUrl:Ljava/lang/String;

    filled-new-array {v1}, [Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/gui/UpdateActivity$DownloadTask;->execute([Ljava/lang/Object;)Landroid/os/AsyncTask;

    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 1

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->force:Z

    if-nez v0, :cond_1

    iget-boolean v0, p0, Lcom/luxury/mobile/gui/UpdateActivity;->downloading:Z

    if-eqz v0, :cond_0

    goto :goto_0

    .line 97
    :cond_0
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    :cond_1
    :goto_0
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 3

    .line 82
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 84
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/UpdateActivity;->getIntent()Landroid/content/Intent;

    move-result-object p1

    const/4 v0, 0x0

    if-eqz p1, :cond_0

    const-string v1, "force"

    .line 85
    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->getBooleanExtra(Ljava/lang/String;Z)Z

    move-result v1

    if-eqz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    iput-boolean v1, p0, Lcom/luxury/mobile/gui/UpdateActivity;->force:Z

    const/4 v1, 0x0

    if-eqz p1, :cond_1

    const-string v2, "apk_url"

    .line 86
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_1

    :cond_1
    move-object v2, v1

    :goto_1
    iput-object v2, p0, Lcom/luxury/mobile/gui/UpdateActivity;->apkUrl:Ljava/lang/String;

    if-eqz p1, :cond_2

    const-string v2, "version_name"

    .line 87
    invoke-virtual {p1, v2}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    goto :goto_2

    :cond_2
    move-object v2, v1

    :goto_2
    iput-object v2, p0, Lcom/luxury/mobile/gui/UpdateActivity;->versionName:Ljava/lang/String;

    if-eqz p1, :cond_3

    const-string v1, "changelog"

    .line 88
    invoke-virtual {p1, v1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :cond_3
    iput-object v1, p0, Lcom/luxury/mobile/gui/UpdateActivity;->changelog:Ljava/lang/String;

    if-eqz p1, :cond_4

    const-string v1, "version_code"

    .line 89
    invoke-virtual {p1, v1, v0}, Landroid/content/Intent;->getIntExtra(Ljava/lang/String;I)I

    move-result v0

    .line 91
    :cond_4
    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/UpdateActivity;->buildView(I)Landroid/view/View;

    move-result-object p1

    invoke-virtual {p0, p1}, Lcom/luxury/mobile/gui/UpdateActivity;->setContentView(Landroid/view/View;)V

    return-void
.end method
