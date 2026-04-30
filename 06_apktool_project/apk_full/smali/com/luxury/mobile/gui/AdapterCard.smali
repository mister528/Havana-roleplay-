.class public Lcom/luxury/mobile/gui/AdapterCard;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;
.source "AdapterCard.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$Adapter<",
        "Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;",
        ">;"
    }
.end annotation


# instance fields
.field private mContext:Landroid/content/Context;

.field private mData:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/luxury/mobile/gui/CardModel;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;Ljava/util/List;)V
    .locals 0
    .param p1, "mContext2"    # Landroid/content/Context;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/List<",
            "Lcom/luxury/mobile/gui/CardModel;",
            ">;)V"
        }
    .end annotation

    .line 21
    .local p2, "mData2":Ljava/util/List;, "Ljava/util/List<Lcom/luxury/mobile/gui/CardModel;>;"
    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    .line 22
    iput-object p1, p0, Lcom/luxury/mobile/gui/AdapterCard;->mContext:Landroid/content/Context;

    .line 23
    iput-object p2, p0, Lcom/luxury/mobile/gui/AdapterCard;->mData:Ljava/util/List;

    .line 24
    return-void
.end method


# virtual methods
.method public getItemCount()I
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/luxury/mobile/gui/AdapterCard;->mData:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 0

    .line 17
    check-cast p1, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;

    invoke-virtual {p0, p1, p2}, Lcom/luxury/mobile/gui/AdapterCard;->onBindViewHolder(Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;I)V

    return-void
.end method

.method public onBindViewHolder(Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;I)V
    .locals 4
    .param p1, "holder"    # Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;
    .param p2, "position"    # I

    .line 31
    iget-object v0, p1, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;->f113id:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/luxury/mobile/gui/AdapterCard;->mData:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/luxury/mobile/gui/CardModel;

    invoke-virtual {v1}, Lcom/luxury/mobile/gui/CardModel;->getId()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 32
    iget-object v0, p1, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;->name:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/luxury/mobile/gui/AdapterCard;->mData:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/luxury/mobile/gui/CardModel;

    invoke-virtual {v1}, Lcom/luxury/mobile/gui/CardModel;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 33
    iget-object v0, p0, Lcom/luxury/mobile/gui/AdapterCard;->mContext:Landroid/content/Context;

    invoke-static {v0}, Lcom/bumptech/glide/Glide;->with(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    iget-object v1, p0, Lcom/luxury/mobile/gui/AdapterCard;->mData:Ljava/util/List;

    invoke-interface {v1, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/luxury/mobile/gui/CardModel;

    invoke-virtual {v1}, Lcom/luxury/mobile/gui/CardModel;->getImage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/bumptech/glide/RequestManager;->load(Ljava/lang/String;)Lcom/bumptech/glide/RequestBuilder;

    move-result-object v0

    iget-object v1, p1, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;->img:Landroid/widget/ImageView;

    invoke-virtual {v0, v1}, Lcom/bumptech/glide/RequestBuilder;->into(Landroid/widget/ImageView;)Lcom/bumptech/glide/request/target/ViewTarget;

    iget-object v0, p0, Lcom/luxury/mobile/gui/AdapterCard;->mData:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/luxury/mobile/gui/CardModel;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/CardModel;->getNewsId()I

    move-result v0

    new-instance v1, Lcom/luxury/mobile/util/NewsClickListener;

    iget-object v2, p0, Lcom/luxury/mobile/gui/AdapterCard;->mContext:Landroid/content/Context;

    invoke-direct {v1, v2, v0}, Lcom/luxury/mobile/util/NewsClickListener;-><init>(Landroid/content/Context;I)V

    iget-object v2, p1, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;->itemView:Landroid/view/View;

    invoke-virtual {v2, v1}, Landroid/view/View;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .locals 0

    .line 17
    invoke-virtual {p0, p1, p2}, Lcom/luxury/mobile/gui/AdapterCard;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;

    move-result-object p1

    return-object p1
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;
    .locals 4
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "viewType"    # I

    .line 27
    new-instance v0, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;

    iget-object v1, p0, Lcom/luxury/mobile/gui/AdapterCard;->mContext:Landroid/content/Context;

    invoke-static {v1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    const v2, 0x7f0c0022

    const/4 v3, 0x0

    invoke-virtual {v1, v2, p1, v3}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;-><init>(Landroid/view/View;)V

    return-object v0
.end method
