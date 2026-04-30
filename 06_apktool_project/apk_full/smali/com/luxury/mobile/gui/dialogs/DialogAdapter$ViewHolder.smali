.class public Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;
.super Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
.source "DialogAdapter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/luxury/mobile/gui/dialogs/DialogAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ViewHolder"
.end annotation


# instance fields
.field public mFieldBg:Landroid/widget/ImageView;

.field public mFields:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field private final mView:Landroid/view/View;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 4
    .param p1, "itemView"    # Landroid/view/View;

    .line 136
    invoke-direct {p0, p1}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    .line 132
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFields:Ljava/util/ArrayList;

    .line 137
    iput-object p1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mView:Landroid/view/View;

    .line 138
    const v0, 0x7f0901c3

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFieldBg:Landroid/widget/ImageView;

    .line 139
    const v0, 0x7f0901c8

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 140
    .local v0, "field":Landroidx/constraintlayout/widget/ConstraintLayout;
    const/4 v1, 0x1

    .local v1, "i":I
    :goto_0
    invoke-virtual {v0}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildCount()I

    move-result v2

    if-ge v1, v2, :cond_0

    .line 141
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v0, v1}, Landroidx/constraintlayout/widget/ConstraintLayout;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 140
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 143
    .end local v1    # "i":I
    :cond_0
    return-void
.end method


# virtual methods
.method public getView()Landroid/view/View;
    .locals 1

    .line 146
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mView:Landroid/view/View;

    return-object v0
.end method
