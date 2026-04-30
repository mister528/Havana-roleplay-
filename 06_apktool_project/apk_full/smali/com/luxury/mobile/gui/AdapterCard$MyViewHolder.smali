.class public Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;
.super Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
.source "AdapterCard.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/luxury/mobile/gui/AdapterCard;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "MyViewHolder"
.end annotation


# instance fields
.field f113id:Landroid/widget/TextView;

.field img:Landroid/widget/ImageView;

.field name:Landroid/widget/TextView;


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 2
    .param p1, "itemView"    # Landroid/view/View;

    .line 48
    invoke-direct {p0, p1}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    .line 49
    const v0, 0x7f090261

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    iput-object v1, p0, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;->f113id:Landroid/widget/TextView;

    .line 50
    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/TextView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;->name:Landroid/widget/TextView;

    .line 51
    const v0, 0x7f090159

    invoke-virtual {p1, v0}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    iput-object v0, p0, Lcom/luxury/mobile/gui/AdapterCard$MyViewHolder;->img:Landroid/widget/ImageView;

    .line 52
    return-void
.end method
