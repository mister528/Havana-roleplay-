.class public Lcom/luxury/mobile/gui/dialogs/DialogAdapter;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;
.source "DialogAdapter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;,
        Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;,
        Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;
    }
.end annotation


# instance fields
.field private mCurrentSelectedPosition:I

.field private mCurrentSelectedView:Landroid/view/View;

.field private final mFieldHeaders:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Landroid/widget/TextView;",
            ">;"
        }
    .end annotation
.end field

.field private final mFieldTexts:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private final mFields:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/util/ArrayList<",
            "Landroid/widget/TextView;",
            ">;>;"
        }
    .end annotation
.end field

.field private mOnClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;

.field private mOnDoubleClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;


# direct methods
.method public constructor <init>(Ljava/util/ArrayList;Ljava/util/ArrayList;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/util/ArrayList<",
            "Landroid/widget/TextView;",
            ">;)V"
        }
    .end annotation

    .line 35
    .local p1, "fields":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    .local p2, "fieldHeaders":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/widget/TextView;>;"
    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    .line 19
    const/4 v0, 0x0

    iput v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedPosition:I

    .line 36
    iput-object p1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldTexts:Ljava/util/ArrayList;

    .line 37
    iput-object p2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldHeaders:Ljava/util/ArrayList;

    .line 38
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    .line 39
    return-void
.end method


# virtual methods
.method public getFields()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Ljava/util/ArrayList<",
            "Landroid/widget/TextView;",
            ">;>;"
        }
    .end annotation

    .line 123
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    return-object v0
.end method

.method public getItemCount()I
    .locals 1

    .line 127
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldTexts:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    return v0
.end method

.method public synthetic lambda$onBindViewHolder$0$DialogAdapter(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;Landroid/view/View;)V
    .locals 5
    .param p1, "holder"    # Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;
    .param p2, "view"    # Landroid/view/View;

    .line 69
    iget v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedPosition:I

    invoke-virtual {p1}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->getAdapterPosition()I

    move-result v1

    if-eq v0, v1, :cond_1

    .line 70
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedView:Landroid/view/View;

    .line 71
    .local v0, "view2":Landroid/view/View;
    if-eqz v0, :cond_0

    .line 72
    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 74
    :cond_0
    invoke-virtual {p1}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->getAdapterPosition()I

    move-result v1

    iput v1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedPosition:I

    .line 75
    iget-object v1, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFieldBg:Landroid/widget/ImageView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedView:Landroid/view/View;

    .line 76
    iget-object v1, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFieldBg:Landroid/widget/ImageView;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 77
    iget-object v1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mOnClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;

    invoke-virtual {p1}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->getAdapterPosition()I

    move-result v3

    iget-object v4, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v4, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-interface {v1, v3, v2}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;->onClick(ILjava/lang/String;)V

    .line 78
    return-void

    .line 80
    .end local v0    # "view2":Landroid/view/View;
    :cond_1
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mOnDoubleClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;

    .line 81
    .local v0, "onDoubleClickListener":Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;
    if-eqz v0, :cond_2

    .line 82
    invoke-interface {v0}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;->onDoubleClick()V

    .line 84
    :cond_2
    return-void
.end method

.method public onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 1
    .param p1, "holder"    # Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .param p2, "position"    # I

    .line 46
    move-object v0, p1

    check-cast v0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;

    invoke-virtual {p0, v0, p2}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->onBindViewHolder(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;I)V

    .line 47
    return-void
.end method

.method public onBindViewHolder(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;I)V
    .locals 8
    .param p1, "holder"    # Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;
    .param p2, "position"    # I

    .line 50
    iget-object v0, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldTexts:Ljava/util/ArrayList;

    invoke-virtual {v0, p2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    const-string v1, "\t"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 51
    .local v0, "headers":[Ljava/lang/String;
    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    .line 52
    .local v1, "fields":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/widget/TextView;>;"
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, v0

    const/4 v4, 0x0

    if-ge v2, v3, :cond_0

    .line 53
    iget-object v3, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 54
    .local v3, "field":Landroid/widget/TextView;
    aget-object v5, v0, v2

    const-string v6, "\\t"

    const-string v7, ""

    invoke-virtual {v5, v6, v7}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/luxury/mobile/gui/util/Utils;->transfromColors(Ljava/lang/String;)Landroid/text/Spanned;

    move-result-object v5

    invoke-virtual {v3, v5}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 55
    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setVisibility(I)V

    .line 56
    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 52
    .end local v3    # "field":Landroid/widget/TextView;
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 58
    .end local v2    # "i":I
    :cond_0
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 59
    iget v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedPosition:I

    if-ne v2, p2, :cond_1

    .line 60
    iget-object v2, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFieldBg:Landroid/widget/ImageView;

    .line 61
    .local v2, "imageView":Landroid/widget/ImageView;
    iput-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mCurrentSelectedView:Landroid/view/View;

    .line 62
    invoke-virtual {v2, v4}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 63
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mOnClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;

    iget-object v5, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v4

    invoke-interface {v4}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-interface {v3, p2, v4}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;->onClick(ILjava/lang/String;)V

    .line 64
    .end local v2    # "imageView":Landroid/widget/ImageView;
    goto :goto_1

    .line 65
    :cond_1
    iget-object v2, p1, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->mFieldBg:Landroid/widget/ImageView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 68
    :goto_1
    invoke-virtual {p1}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;->getView()Landroid/view/View;

    move-result-object v2

    new-instance v3, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;

    invoke-direct {v3, p0, p1}, Lcom/luxury/mobile/gui/dialogs/-$$Lambda$DialogAdapter$9udRNlmygNe41Gh3nf7Ljf0Qmhc;-><init>(Lcom/luxury/mobile/gui/dialogs/DialogAdapter;Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;)V

    invoke-virtual {v2, v3}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 85
    return-void
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .locals 4
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "viewType"    # I

    .line 42
    new-instance v0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;

    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x7f0c005d

    const/4 v3, 0x0

    invoke-virtual {v1, v2, p1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/luxury/mobile/gui/dialogs/DialogAdapter$ViewHolder;-><init>(Landroid/view/View;)V

    return-object v0
.end method

.method public setOnClickListener(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;)V
    .locals 0
    .param p1, "onClickListener"    # Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;

    .line 115
    iput-object p1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mOnClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnClickListener;

    .line 116
    return-void
.end method

.method public setOnDoubleClickListener(Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;)V
    .locals 0
    .param p1, "onDoubleClickListener"    # Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;

    .line 119
    iput-object p1, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mOnDoubleClickListener:Lcom/luxury/mobile/gui/dialogs/DialogAdapter$OnDoubleClickListener;

    .line 120
    return-void
.end method

.method public updateSizes()V
    .locals 5

    .line 88
    const/4 v0, 0x4

    new-array v0, v0, [I

    .line 89
    .local v0, "max":[I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_2

    .line 90
    const/4 v2, 0x0

    .local v2, "j":I
    :goto_1
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 91
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    invoke-virtual {v3}, Landroid/widget/TextView;->getWidth()I

    move-result v3

    .line 92
    .local v3, "width":I
    aget v4, v0, v2

    if-ge v4, v3, :cond_0

    .line 93
    aput v3, v0, v2

    .line 90
    .end local v3    # "width":I
    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 89
    .end local v2    # "j":I
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 97
    .end local v1    # "i":I
    :cond_2
    const/4 v1, 0x0

    .local v1, "i2":I
    :goto_2
    array-length v2, v0

    if-ge v1, v2, :cond_4

    .line 98
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldHeaders:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    invoke-virtual {v2}, Landroid/widget/TextView;->getWidth()I

    move-result v2

    .line 99
    .local v2, "headerWidth":I
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    aget v4, v0, v1

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v4, "\t"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldHeaders:Ljava/util/ArrayList;

    invoke-virtual {v4, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    invoke-virtual {v4}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v4, " "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const-string v4, "DIALOG"

    invoke-static {v4, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 100
    aget v3, v0, v1

    if-ge v3, v2, :cond_3

    .line 101
    aput v2, v0, v1

    .line 97
    .end local v2    # "headerWidth":I
    :cond_3
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 104
    .end local v1    # "i2":I
    :cond_4
    const/4 v1, 0x0

    .local v1, "i3":I
    :goto_3
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_6

    .line 105
    const/4 v2, 0x0

    .local v2, "j2":I
    :goto_4
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/ArrayList;

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_5

    .line 106
    iget-object v3, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFields:Ljava/util/ArrayList;

    invoke-virtual {v3, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/ArrayList;

    invoke-virtual {v3, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    aget v4, v0, v2

    invoke-virtual {v3, v4}, Landroid/widget/TextView;->setWidth(I)V

    .line 105
    add-int/lit8 v2, v2, 0x1

    goto :goto_4

    .line 104
    .end local v2    # "j2":I
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_3

    .line 109
    .end local v1    # "i3":I
    :cond_6
    const/4 v1, 0x0

    .local v1, "i4":I
    :goto_5
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldHeaders:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_7

    .line 110
    iget-object v2, p0, Lcom/luxury/mobile/gui/dialogs/DialogAdapter;->mFieldHeaders:Ljava/util/ArrayList;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    aget v3, v0, v1

    invoke-virtual {v2, v3}, Landroid/widget/TextView;->setWidth(I)V

    .line 109
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 112
    .end local v1    # "i4":I
    :cond_7
    return-void
.end method
