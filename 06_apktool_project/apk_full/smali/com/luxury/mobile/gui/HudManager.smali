.class public Lcom/luxury/mobile/gui/HudManager;
.super Ljava/lang/Object;
.source "HudManager.java"


# instance fields
.field public activity:Landroid/app/Activity;

.field public animation:Landroid/view/animation/Animation;

.field public hud_armour:Landroid/widget/ProgressBar;

.field public hud_armour_t:Landroid/widget/TextView;

.field public hud_date:Landroid/widget/TextView;

.field public hud_health:Landroid/widget/ProgressBar;

.field public hud_health_t:Landroid/widget/TextView;

.field public hud_hunger:Landroid/widget/ProgressBar;

.field public hud_hunger_t:Landroid/widget/TextView;

.field public hud_layout:Landroidx/constraintlayout/widget/ConstraintLayout;

.field public hud_money:Landroid/widget/TextView;

.field public hud_online:Landroidx/constraintlayout/widget/ConstraintLayout;

.field public hud_online_text:Landroid/widget/TextView;

.field public hud_time:Landroid/widget/TextView;

.field public hud_wanted:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/widget/ImageView;",
            ">;"
        }
    .end annotation
.end field

.field public hud_weapon:Landroid/widget/ImageView;


# direct methods
.method public constructor <init>(Landroid/app/Activity;)V
    .locals 4
    .param p1, "aactivity"    # Landroid/app/Activity;

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    iput-object p1, p0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    .line 55
    const v0, 0x7f010018

    invoke-static {p1, v0}, Landroid/view/animation/AnimationUtils;->loadAnimation(Landroid/content/Context;I)Landroid/view/animation/Animation;

    move-result-object v0

    .line 57
    .local v0, "animation":Landroid/view/animation/Animation;
    const v1, 0x7f09005f

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/constraintlayout/widget/ConstraintLayout;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 58
    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    .line 59
    const v1, 0x7f090069

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroidx/constraintlayout/widget/ConstraintLayout;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_online:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 61
    const v1, 0x7f090122

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ProgressBar;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_health:Landroid/widget/ProgressBar;

    .line 62
    const v1, 0x7f0900f3

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ProgressBar;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_hunger:Landroid/widget/ProgressBar;

    .line 63
    const v1, 0x7f0900ee

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ProgressBar;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_armour:Landroid/widget/ProgressBar;

    .line 65
    const v1, 0x7f090123

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_health_t:Landroid/widget/TextView;

    .line 66
    const v1, 0x7f0900f4

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_hunger_t:Landroid/widget/TextView;

    .line 67
    const v1, 0x7f0900ef

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_armour_t:Landroid/widget/TextView;

    .line 69
    const v1, 0x7f0900f0

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_money:Landroid/widget/TextView;

    .line 70
    const v1, 0x7f090121

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_weapon:Landroid/widget/ImageView;

    .line 72
    const v1, 0x7f09012b

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_time:Landroid/widget/TextView;

    .line 73
    const v1, 0x7f0900f2

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_date:Landroid/widget/TextView;

    .line 74
    const v1, 0x7f090125

    invoke-virtual {p1, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_online_text:Landroid/widget/TextView;

    .line 76
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    iput-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_wanted:Ljava/util/ArrayList;

    .line 77
    iget-object v2, p0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    const v3, 0x7f090126

    invoke-virtual {v2, v3}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 78
    iget-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_wanted:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    const v3, 0x7f090127

    invoke-virtual {v2, v3}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 79
    iget-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_wanted:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    const v3, 0x7f090128

    invoke-virtual {v2, v3}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 80
    iget-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_wanted:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    const v3, 0x7f090129

    invoke-virtual {v2, v3}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 81
    iget-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_wanted:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    const v3, 0x7f09012a

    invoke-virtual {v2, v3}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 83
    iget-object v1, p0, Lcom/luxury/mobile/gui/HudManager;->hud_online:Landroidx/constraintlayout/widget/ConstraintLayout;

    new-instance v2, Lcom/luxury/mobile/gui/HudManager$1;

    invoke-direct {v2, p0, v0}, Lcom/luxury/mobile/gui/HudManager$1;-><init>(Lcom/luxury/mobile/gui/HudManager;Landroid/view/animation/Animation;)V

    invoke-virtual {v1, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 90
    return-void
.end method

.method static synthetic access$000(Lcom/luxury/mobile/gui/HudManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/luxury/mobile/gui/HudManager;

    .line 26
    invoke-direct {p0}, Lcom/luxury/mobile/gui/HudManager;->openTab()V

    return-void
.end method

.method private openTab()V
    .locals 4

    .line 130
    new-instance v0, Ljava/util/Timer;

    invoke-direct {v0}, Ljava/util/Timer;-><init>()V

    .line 131
    .local v0, "t":Ljava/util/Timer;
    new-instance v1, Lcom/luxury/mobile/gui/HudManager$3;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/gui/HudManager$3;-><init>(Lcom/luxury/mobile/gui/HudManager;)V

    const-wide/16 v2, 0x12c

    invoke-virtual {v0, v1, v2, v3}, Ljava/util/Timer;->schedule(Ljava/util/TimerTask;J)V

    .line 137
    return-void
.end method


# virtual methods
.method public HideHud()V
    .locals 2

    .line 144
    iget-object v0, p0, Lcom/luxury/mobile/gui/HudManager;->hud_layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/luxury/mobile/gui/util/Utils;->HideLayout(Landroid/view/View;Z)V

    .line 145
    return-void
.end method

.method public ShowHud()V
    .locals 2

    iget-object v0, p0, Lcom/luxury/mobile/gui/HudManager;->hud_layout:Landroidx/constraintlayout/widget/ConstraintLayout;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->setVisibility(I)V

    return-void
.end method

.method public UpdateHudInfo(IIIIIIIII)V
    .locals 13
    .param p1, "health"    # I
    .param p2, "kaban"    # I
    .param p3, "armour"    # I
    .param p4, "hunger"    # I
    .param p5, "weaponid"    # I
    .param p6, "ammo"    # I
    .param p7, "playerid"    # I
    .param p8, "money"    # I
    .param p9, "wanted"    # I

    .line 94
    move-object v0, p0

    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_health:Landroid/widget/ProgressBar;

    move v2, p1

    invoke-virtual {v1, p1}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 95
    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_hunger:Landroid/widget/ProgressBar;

    move/from16 v3, p4

    invoke-virtual {v1, v3}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 96
    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_armour:Landroid/widget/ProgressBar;

    move/from16 v4, p3

    invoke-virtual {v1, v4}, Landroid/widget/ProgressBar;->setProgress(I)V

    .line 98
    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_health_t:Landroid/widget/TextView;

    invoke-static {p1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 99
    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_armour_t:Landroid/widget/TextView;

    invoke-static/range {p3 .. p3}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 100
    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_hunger_t:Landroid/widget/TextView;

    invoke-static/range {p4 .. p4}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 102
    iget-object v1, v0, Lcom/luxury/mobile/gui/HudManager;->hud_online_text:Landroid/widget/TextView;

    invoke-static/range {p7 .. p7}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v1, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 104
    new-instance v1, Ljava/text/DecimalFormat;

    invoke-direct {v1}, Ljava/text/DecimalFormat;-><init>()V

    .line 105
    .local v1, "formatter":Ljava/text/DecimalFormat;
    invoke-static {}, Ljava/text/DecimalFormatSymbols;->getInstance()Ljava/text/DecimalFormatSymbols;

    move-result-object v5

    .line 106
    .local v5, "symbols":Ljava/text/DecimalFormatSymbols;
    const/16 v6, 0x20

    invoke-virtual {v5, v6}, Ljava/text/DecimalFormatSymbols;->setGroupingSeparator(C)V

    .line 107
    invoke-virtual {v1, v5}, Ljava/text/DecimalFormat;->setDecimalFormatSymbols(Ljava/text/DecimalFormatSymbols;)V

    .line 108
    move/from16 v6, p8

    int-to-long v7, v6

    invoke-virtual {v1, v7, v8}, Ljava/text/DecimalFormat;->format(J)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v7

    .line 109
    .local v7, "s":Ljava/lang/String;
    iget-object v8, v0, Lcom/luxury/mobile/gui/HudManager;->hud_money:Landroid/widget/TextView;

    invoke-static {v7}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 111
    iget-object v8, v0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    invoke-virtual {v8}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v8

    new-instance v9, Ljava/util/Formatter;

    invoke-direct {v9}, Ljava/util/Formatter;-><init>()V

    const/4 v10, 0x1

    new-array v10, v10, [Ljava/lang/Object;

    invoke-static/range {p5 .. p5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v11

    const/4 v12, 0x0

    aput-object v11, v10, v12

    const-string v11, "weapon_%d"

    invoke-virtual {v9, v11, v10}, Ljava/util/Formatter;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/util/Formatter;

    move-result-object v9

    invoke-virtual {v9}, Ljava/util/Formatter;->toString()Ljava/lang/String;

    move-result-object v9

    iget-object v10, v0, Lcom/luxury/mobile/gui/HudManager;->activity:Landroid/app/Activity;

    invoke-virtual {v10}, Landroid/app/Activity;->getPackageName()Ljava/lang/String;

    move-result-object v10

    const-string v11, "drawable"

    invoke-virtual {v8, v9, v11, v10}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    .line 112
    .local v8, "id":I
    iget-object v9, v0, Lcom/luxury/mobile/gui/HudManager;->hud_weapon:Landroid/widget/ImageView;

    invoke-virtual {v9, v8}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 114
    iget-object v9, v0, Lcom/luxury/mobile/gui/HudManager;->hud_weapon:Landroid/widget/ImageView;

    new-instance v10, Lcom/luxury/mobile/gui/HudManager$2;

    invoke-direct {v10, p0}, Lcom/luxury/mobile/gui/HudManager$2;-><init>(Lcom/luxury/mobile/gui/HudManager;)V

    invoke-virtual {v9, v10}, Landroid/widget/ImageView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 120
    const/4 v9, 0x5

    move/from16 v10, p9

    if-le v10, v9, :cond_0

    const/4 v9, 0x5

    .end local p9    # "wanted":I
    .local v9, "wanted":I
    goto :goto_0

    .end local v9    # "wanted":I
    .restart local p9    # "wanted":I
    :cond_0
    move v9, v10

    .line 121
    .end local p9    # "wanted":I
    .restart local v9    # "wanted":I
    :goto_0
    const/4 v10, 0x0

    .local v10, "i2":I
    :goto_1
    if-ge v10, v9, :cond_1

    .line 122
    iget-object v11, v0, Lcom/luxury/mobile/gui/HudManager;->hud_wanted:Ljava/util/ArrayList;

    invoke-virtual {v11, v10}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/widget/ImageView;

    const v12, 0x7f0700d0

    invoke-virtual {v11, v12}, Landroid/widget/ImageView;->setBackgroundResource(I)V

    .line 121
    add-int/lit8 v10, v10, 0x1

    goto :goto_1

    .line 124
    .end local v10    # "i2":I
    :cond_1
    iget-object v10, v0, Lcom/luxury/mobile/gui/HudManager;->hud_time:Landroid/widget/TextView;

    new-instance v11, Ljava/text/SimpleDateFormat;

    const-string v12, "HH:mm"

    invoke-direct {v11, v12}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v12

    invoke-virtual {v12}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 125
    iget-object v10, v0, Lcom/luxury/mobile/gui/HudManager;->hud_date:Landroid/widget/TextView;

    new-instance v11, Ljava/text/SimpleDateFormat;

    const-string v12, "dd.MM.yyyy"

    invoke-direct {v11, v12}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v12

    invoke-virtual {v12}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 126
    return-void
.end method
