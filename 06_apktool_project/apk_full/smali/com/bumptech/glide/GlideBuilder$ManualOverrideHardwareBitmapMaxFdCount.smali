.class final Lcom/bumptech/glide/GlideBuilder$ManualOverrideHardwareBitmapMaxFdCount;
.super Ljava/lang/Object;
.source "GlideBuilder.java"

# interfaces
.implements Lcom/bumptech/glide/GlideExperiments$Experiment;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/bumptech/glide/GlideBuilder;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "ManualOverrideHardwareBitmapMaxFdCount"
.end annotation


# instance fields
.field final fdCount:I


# direct methods
.method constructor <init>(I)V
    .locals 0
    .param p1, "fdCount"    # I

    .line 590
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 591
    iput p1, p0, Lcom/bumptech/glide/GlideBuilder$ManualOverrideHardwareBitmapMaxFdCount;->fdCount:I

    .line 592
    return-void
.end method
