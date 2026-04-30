.class public Lcom/bumptech/glide/manager/RequestManagerRetriever;
.super Ljava/lang/Object;
.source "RequestManagerRetriever.java"

# interfaces
.implements Landroid/os/Handler$Callback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;
    }
.end annotation


# static fields
.field private static final DEFAULT_FACTORY:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

.field private static final FRAGMENT_INDEX_KEY:Ljava/lang/String; = "key"

.field static final FRAGMENT_TAG:Ljava/lang/String; = "com.bumptech.glide.manager"

.field private static final HAS_ATTEMPTED_TO_ADD_FRAGMENT_TWICE:I = 0x1

.field private static final ID_REMOVE_FRAGMENT_MANAGER:I = 0x1

.field private static final ID_REMOVE_SUPPORT_FRAGMENT_MANAGER:I = 0x2

.field private static final TAG:Ljava/lang/String; = "RMRetriever"


# instance fields
.field private volatile applicationManager:Lcom/bumptech/glide/RequestManager;

.field private final factory:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

.field private final frameWaiter:Lcom/bumptech/glide/manager/FrameWaiter;

.field private final handler:Landroid/os/Handler;

.field final pendingRequestManagerFragments:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroid/app/FragmentManager;",
            "Lcom/bumptech/glide/manager/RequestManagerFragment;",
            ">;"
        }
    .end annotation
.end field

.field final pendingSupportRequestManagerFragments:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Landroidx/fragment/app/FragmentManager;",
            "Lcom/bumptech/glide/manager/SupportRequestManagerFragment;",
            ">;"
        }
    .end annotation
.end field

.field private final tempBundle:Landroid/os/Bundle;

.field private final tempViewToFragment:Landroidx/collection/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/collection/ArrayMap<",
            "Landroid/view/View;",
            "Landroid/app/Fragment;",
            ">;"
        }
    .end annotation
.end field

.field private final tempViewToSupportFragment:Landroidx/collection/ArrayMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/collection/ArrayMap<",
            "Landroid/view/View;",
            "Landroidx/fragment/app/Fragment;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 693
    new-instance v0, Lcom/bumptech/glide/manager/RequestManagerRetriever$1;

    invoke-direct {v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever$1;-><init>()V

    sput-object v0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->DEFAULT_FACTORY:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    return-void
.end method

.method public constructor <init>(Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;Lcom/bumptech/glide/GlideExperiments;)V
    .locals 2
    .param p1, "factory"    # Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;
    .param p2, "experiments"    # Lcom/bumptech/glide/GlideExperiments;

    .line 84
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 59
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingRequestManagerFragments:Ljava/util/Map;

    .line 65
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingSupportRequestManagerFragments:Ljava/util/Map;

    .line 75
    new-instance v0, Landroidx/collection/ArrayMap;

    invoke-direct {v0}, Landroidx/collection/ArrayMap;-><init>()V

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToSupportFragment:Landroidx/collection/ArrayMap;

    .line 76
    new-instance v0, Landroidx/collection/ArrayMap;

    invoke-direct {v0}, Landroidx/collection/ArrayMap;-><init>()V

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToFragment:Landroidx/collection/ArrayMap;

    .line 77
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempBundle:Landroid/os/Bundle;

    .line 85
    if-eqz p1, :cond_0

    move-object v0, p1

    goto :goto_0

    :cond_0
    sget-object v0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->DEFAULT_FACTORY:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    :goto_0
    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->factory:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    .line 86
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1, p0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;Landroid/os/Handler$Callback;)V

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->handler:Landroid/os/Handler;

    .line 88
    invoke-static {p2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->buildFrameWaiter(Lcom/bumptech/glide/GlideExperiments;)Lcom/bumptech/glide/manager/FrameWaiter;

    move-result-object v0

    iput-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->frameWaiter:Lcom/bumptech/glide/manager/FrameWaiter;

    .line 89
    return-void
.end method

.method private static assertNotDestroyed(Landroid/app/Activity;)V
    .locals 2
    .param p0, "activity"    # Landroid/app/Activity;

    .line 352
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x11

    if-lt v0, v1, :cond_1

    invoke-virtual {p0}, Landroid/app/Activity;->isDestroyed()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 353
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "You cannot start a load for a destroyed activity"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 355
    :cond_1
    :goto_0
    return-void
.end method

.method private static buildFrameWaiter(Lcom/bumptech/glide/GlideExperiments;)Lcom/bumptech/glide/manager/FrameWaiter;
    .locals 1
    .param p0, "experiments"    # Lcom/bumptech/glide/GlideExperiments;

    .line 92
    sget-boolean v0, Lcom/bumptech/glide/load/resource/bitmap/HardwareConfigState;->HARDWARE_BITMAPS_SUPPORTED:Z

    if-eqz v0, :cond_2

    sget-boolean v0, Lcom/bumptech/glide/load/resource/bitmap/HardwareConfigState;->BLOCK_HARDWARE_BITMAPS_WHEN_GL_CONTEXT_MIGHT_NOT_BE_INITIALIZED:Z

    if-nez v0, :cond_0

    goto :goto_1

    .line 96
    :cond_0
    const-class v0, Lcom/bumptech/glide/GlideBuilder$WaitForFramesAfterTrimMemory;

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/GlideExperiments;->isEnabled(Ljava/lang/Class;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 97
    new-instance v0, Lcom/bumptech/glide/manager/FirstFrameAndAfterTrimMemoryWaiter;

    invoke-direct {v0}, Lcom/bumptech/glide/manager/FirstFrameAndAfterTrimMemoryWaiter;-><init>()V

    goto :goto_0

    .line 98
    :cond_1
    new-instance v0, Lcom/bumptech/glide/manager/FirstFrameWaiter;

    invoke-direct {v0}, Lcom/bumptech/glide/manager/FirstFrameWaiter;-><init>()V

    .line 96
    :goto_0
    return-object v0

    .line 94
    :cond_2
    :goto_1
    new-instance v0, Lcom/bumptech/glide/manager/DoNothingFirstFrameWaiter;

    invoke-direct {v0}, Lcom/bumptech/glide/manager/DoNothingFirstFrameWaiter;-><init>()V

    return-object v0
.end method

.method private static findActivity(Landroid/content/Context;)Landroid/app/Activity;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 341
    instance-of v0, p0, Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 342
    move-object v0, p0

    check-cast v0, Landroid/app/Activity;

    return-object v0

    .line 343
    :cond_0
    instance-of v0, p0, Landroid/content/ContextWrapper;

    if-eqz v0, :cond_1

    .line 344
    move-object v0, p0

    check-cast v0, Landroid/content/ContextWrapper;

    invoke-virtual {v0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findActivity(Landroid/content/Context;)Landroid/app/Activity;

    move-result-object v0

    return-object v0

    .line 346
    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method private findAllFragmentsWithViews(Landroid/app/FragmentManager;Landroidx/collection/ArrayMap;)V
    .locals 3
    .param p1, "fragmentManager"    # Landroid/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/FragmentManager;",
            "Landroidx/collection/ArrayMap<",
            "Landroid/view/View;",
            "Landroid/app/Fragment;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 301
    .local p2, "result":Landroidx/collection/ArrayMap;, "Landroidx/collection/ArrayMap<Landroid/view/View;Landroid/app/Fragment;>;"
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1a

    if-lt v0, v1, :cond_2

    .line 302
    invoke-virtual {p1}, Landroid/app/FragmentManager;->getFragments()Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Fragment;

    .line 303
    .local v1, "fragment":Landroid/app/Fragment;
    invoke-virtual {v1}, Landroid/app/Fragment;->getView()Landroid/view/View;

    move-result-object v2

    if-eqz v2, :cond_0

    .line 304
    invoke-virtual {v1}, Landroid/app/Fragment;->getView()Landroid/view/View;

    move-result-object v2

    invoke-virtual {p2, v2, v1}, Landroidx/collection/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 305
    invoke-virtual {v1}, Landroid/app/Fragment;->getChildFragmentManager()Landroid/app/FragmentManager;

    move-result-object v2

    invoke-direct {p0, v2, p2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findAllFragmentsWithViews(Landroid/app/FragmentManager;Landroidx/collection/ArrayMap;)V

    .line 307
    .end local v1    # "fragment":Landroid/app/Fragment;
    :cond_0
    goto :goto_0

    :cond_1
    goto :goto_1

    .line 309
    :cond_2
    invoke-direct {p0, p1, p2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findAllFragmentsWithViewsPreO(Landroid/app/FragmentManager;Landroidx/collection/ArrayMap;)V

    .line 311
    :goto_1
    return-void
.end method

.method private findAllFragmentsWithViewsPreO(Landroid/app/FragmentManager;Landroidx/collection/ArrayMap;)V
    .locals 4
    .param p1, "fragmentManager"    # Landroid/app/FragmentManager;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/app/FragmentManager;",
            "Landroidx/collection/ArrayMap<",
            "Landroid/view/View;",
            "Landroid/app/Fragment;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 318
    .local p2, "result":Landroidx/collection/ArrayMap;, "Landroidx/collection/ArrayMap<Landroid/view/View;Landroid/app/Fragment;>;"
    const/4 v0, 0x0

    .line 320
    .local v0, "index":I
    :goto_0
    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempBundle:Landroid/os/Bundle;

    add-int/lit8 v2, v0, 0x1

    .end local v0    # "index":I
    .local v2, "index":I
    const-string v3, "key"

    invoke-virtual {v1, v3, v0}, Landroid/os/Bundle;->putInt(Ljava/lang/String;I)V

    .line 321
    const/4 v0, 0x0

    .line 323
    .local v0, "fragment":Landroid/app/Fragment;
    :try_start_0
    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempBundle:Landroid/os/Bundle;

    invoke-virtual {p1, v1, v3}, Landroid/app/FragmentManager;->getFragment(Landroid/os/Bundle;Ljava/lang/String;)Landroid/app/Fragment;

    move-result-object v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 326
    goto :goto_1

    .line 324
    :catch_0
    move-exception v1

    .line 327
    :goto_1
    if-nez v0, :cond_0

    .line 328
    nop

    .line 337
    .end local v0    # "fragment":Landroid/app/Fragment;
    return-void

    .line 330
    .restart local v0    # "fragment":Landroid/app/Fragment;
    :cond_0
    invoke-virtual {v0}, Landroid/app/Fragment;->getView()Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 331
    invoke-virtual {v0}, Landroid/app/Fragment;->getView()Landroid/view/View;

    move-result-object v1

    invoke-virtual {p2, v1, v0}, Landroidx/collection/ArrayMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 332
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x11

    if-lt v1, v3, :cond_1

    .line 333
    invoke-virtual {v0}, Landroid/app/Fragment;->getChildFragmentManager()Landroid/app/FragmentManager;

    move-result-object v1

    invoke-direct {p0, v1, p2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findAllFragmentsWithViews(Landroid/app/FragmentManager;Landroidx/collection/ArrayMap;)V

    .line 336
    .end local v0    # "fragment":Landroid/app/Fragment;
    :cond_1
    move v0, v2

    goto :goto_0
.end method

.method private static findAllSupportFragmentsWithViews(Ljava/util/Collection;Ljava/util/Map;)V
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Collection<",
            "Landroidx/fragment/app/Fragment;",
            ">;",
            "Ljava/util/Map<",
            "Landroid/view/View;",
            "Landroidx/fragment/app/Fragment;",
            ">;)V"
        }
    .end annotation

    .line 230
    .local p0, "topLevelFragments":Ljava/util/Collection;, "Ljava/util/Collection<Landroidx/fragment/app/Fragment;>;"
    .local p1, "result":Ljava/util/Map;, "Ljava/util/Map<Landroid/view/View;Landroidx/fragment/app/Fragment;>;"
    if-nez p0, :cond_0

    .line 231
    return-void

    .line 233
    :cond_0
    invoke-interface {p0}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_3

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroidx/fragment/app/Fragment;

    .line 235
    .local v1, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v1, :cond_1

    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v2

    if-nez v2, :cond_2

    .line 236
    goto :goto_0

    .line 238
    :cond_2
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getView()Landroid/view/View;

    move-result-object v2

    invoke-interface {p1, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 239
    invoke-virtual {v1}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v2

    invoke-virtual {v2}, Landroidx/fragment/app/FragmentManager;->getFragments()Ljava/util/List;

    move-result-object v2

    invoke-static {v2, p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findAllSupportFragmentsWithViews(Ljava/util/Collection;Ljava/util/Map;)V

    .line 240
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    goto :goto_0

    .line 241
    :cond_3
    return-void
.end method

.method private findFragment(Landroid/view/View;Landroid/app/Activity;)Landroid/app/Fragment;
    .locals 4
    .param p1, "target"    # Landroid/view/View;
    .param p2, "activity"    # Landroid/app/Activity;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 271
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToFragment:Landroidx/collection/ArrayMap;

    invoke-virtual {v0}, Landroidx/collection/ArrayMap;->clear()V

    .line 272
    invoke-virtual {p2}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToFragment:Landroidx/collection/ArrayMap;

    invoke-direct {p0, v0, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findAllFragmentsWithViews(Landroid/app/FragmentManager;Landroidx/collection/ArrayMap;)V

    .line 274
    const/4 v0, 0x0

    .line 276
    .local v0, "result":Landroid/app/Fragment;
    const v1, 0x1020002

    invoke-virtual {p2, v1}, Landroid/app/Activity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    .line 277
    .local v1, "activityRoot":Landroid/view/View;
    move-object v2, p1

    .line 278
    .local v2, "current":Landroid/view/View;
    :goto_0
    invoke-virtual {v2, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 279
    iget-object v3, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToFragment:Landroidx/collection/ArrayMap;

    invoke-virtual {v3, v2}, Landroidx/collection/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    move-object v0, v3

    check-cast v0, Landroid/app/Fragment;

    .line 280
    if-eqz v0, :cond_0

    .line 281
    goto :goto_1

    .line 283
    :cond_0
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    instance-of v3, v3, Landroid/view/View;

    if-eqz v3, :cond_1

    .line 284
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    move-object v2, v3

    check-cast v2, Landroid/view/View;

    goto :goto_0

    .line 289
    :cond_1
    :goto_1
    iget-object v3, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToFragment:Landroidx/collection/ArrayMap;

    invoke-virtual {v3}, Landroidx/collection/ArrayMap;->clear()V

    .line 290
    return-object v0
.end method

.method private findSupportFragment(Landroid/view/View;Landroidx/fragment/app/FragmentActivity;)Landroidx/fragment/app/Fragment;
    .locals 4
    .param p1, "target"    # Landroid/view/View;
    .param p2, "activity"    # Landroidx/fragment/app/FragmentActivity;

    .line 245
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToSupportFragment:Landroidx/collection/ArrayMap;

    invoke-virtual {v0}, Landroidx/collection/ArrayMap;->clear()V

    .line 246
    nop

    .line 247
    invoke-virtual {p2}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/fragment/app/FragmentManager;->getFragments()Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToSupportFragment:Landroidx/collection/ArrayMap;

    .line 246
    invoke-static {v0, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findAllSupportFragmentsWithViews(Ljava/util/Collection;Ljava/util/Map;)V

    .line 248
    const/4 v0, 0x0

    .line 249
    .local v0, "result":Landroidx/fragment/app/Fragment;
    const v1, 0x1020002

    invoke-virtual {p2, v1}, Landroidx/fragment/app/FragmentActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    .line 250
    .local v1, "activityRoot":Landroid/view/View;
    move-object v2, p1

    .line 251
    .local v2, "current":Landroid/view/View;
    :goto_0
    invoke-virtual {v2, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 252
    iget-object v3, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToSupportFragment:Landroidx/collection/ArrayMap;

    invoke-virtual {v3, v2}, Landroidx/collection/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    move-object v0, v3

    check-cast v0, Landroidx/fragment/app/Fragment;

    .line 253
    if-eqz v0, :cond_0

    .line 254
    goto :goto_1

    .line 256
    :cond_0
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    instance-of v3, v3, Landroid/view/View;

    if-eqz v3, :cond_1

    .line 257
    invoke-virtual {v2}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    move-object v2, v3

    check-cast v2, Landroid/view/View;

    goto :goto_0

    .line 263
    :cond_1
    :goto_1
    iget-object v3, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->tempViewToSupportFragment:Landroidx/collection/ArrayMap;

    invoke-virtual {v3}, Landroidx/collection/ArrayMap;->clear()V

    .line 264
    return-object v0
.end method

.method private fragmentGet(Landroid/content/Context;Landroid/app/FragmentManager;Landroid/app/Fragment;Z)Lcom/bumptech/glide/RequestManager;
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "fm"    # Landroid/app/FragmentManager;
    .param p3, "parentHint"    # Landroid/app/Fragment;
    .param p4, "isParentVisible"    # Z
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 418
    invoke-direct {p0, p2, p3}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->getRequestManagerFragment(Landroid/app/FragmentManager;Landroid/app/Fragment;)Lcom/bumptech/glide/manager/RequestManagerFragment;

    move-result-object v0

    .line 419
    .local v0, "current":Lcom/bumptech/glide/manager/RequestManagerFragment;
    invoke-virtual {v0}, Lcom/bumptech/glide/manager/RequestManagerFragment;->getRequestManager()Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    .line 420
    .local v1, "requestManager":Lcom/bumptech/glide/RequestManager;
    if-nez v1, :cond_1

    .line 422
    invoke-static {p1}, Lcom/bumptech/glide/Glide;->get(Landroid/content/Context;)Lcom/bumptech/glide/Glide;

    move-result-object v2

    .line 423
    .local v2, "glide":Lcom/bumptech/glide/Glide;
    iget-object v3, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->factory:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    .line 425
    invoke-virtual {v0}, Lcom/bumptech/glide/manager/RequestManagerFragment;->getGlideLifecycle()Lcom/bumptech/glide/manager/ActivityFragmentLifecycle;

    move-result-object v4

    invoke-virtual {v0}, Lcom/bumptech/glide/manager/RequestManagerFragment;->getRequestManagerTreeNode()Lcom/bumptech/glide/manager/RequestManagerTreeNode;

    move-result-object v5

    .line 424
    invoke-interface {v3, v2, v4, v5, p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;->build(Lcom/bumptech/glide/Glide;Lcom/bumptech/glide/manager/Lifecycle;Lcom/bumptech/glide/manager/RequestManagerTreeNode;Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    .line 429
    if-eqz p4, :cond_0

    .line 430
    invoke-virtual {v1}, Lcom/bumptech/glide/RequestManager;->onStart()V

    .line 432
    :cond_0
    invoke-virtual {v0, v1}, Lcom/bumptech/glide/manager/RequestManagerFragment;->setRequestManager(Lcom/bumptech/glide/RequestManager;)V

    .line 434
    .end local v2    # "glide":Lcom/bumptech/glide/Glide;
    :cond_1
    return-object v1
.end method

.method private getApplicationManager(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .line 104
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->applicationManager:Lcom/bumptech/glide/RequestManager;

    if-nez v0, :cond_1

    .line 105
    monitor-enter p0

    .line 106
    :try_start_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->applicationManager:Lcom/bumptech/glide/RequestManager;

    if-nez v0, :cond_0

    .line 113
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/Glide;->get(Landroid/content/Context;)Lcom/bumptech/glide/Glide;

    move-result-object v0

    .line 114
    .local v0, "glide":Lcom/bumptech/glide/Glide;
    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->factory:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    new-instance v2, Lcom/bumptech/glide/manager/ApplicationLifecycle;

    invoke-direct {v2}, Lcom/bumptech/glide/manager/ApplicationLifecycle;-><init>()V

    new-instance v3, Lcom/bumptech/glide/manager/EmptyRequestManagerTreeNode;

    invoke-direct {v3}, Lcom/bumptech/glide/manager/EmptyRequestManagerTreeNode;-><init>()V

    .line 119
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    .line 115
    invoke-interface {v1, v0, v2, v3, v4}, Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;->build(Lcom/bumptech/glide/Glide;Lcom/bumptech/glide/manager/Lifecycle;Lcom/bumptech/glide/manager/RequestManagerTreeNode;Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    iput-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->applicationManager:Lcom/bumptech/glide/RequestManager;

    .line 121
    .end local v0    # "glide":Lcom/bumptech/glide/Glide;
    :cond_0
    monitor-exit p0

    goto :goto_0

    :catchall_0
    move-exception v0

    monitor-exit p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0

    .line 124
    :cond_1
    :goto_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->applicationManager:Lcom/bumptech/glide/RequestManager;

    return-object v0
.end method

.method private getRequestManagerFragment(Landroid/app/FragmentManager;Landroid/app/Fragment;)Lcom/bumptech/glide/manager/RequestManagerFragment;
    .locals 3
    .param p1, "fm"    # Landroid/app/FragmentManager;
    .param p2, "parentHint"    # Landroid/app/Fragment;

    .line 396
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingRequestManagerFragments:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/bumptech/glide/manager/RequestManagerFragment;

    .line 397
    .local v0, "current":Lcom/bumptech/glide/manager/RequestManagerFragment;
    if-nez v0, :cond_0

    .line 398
    const-string v1, "com.bumptech.glide.manager"

    invoke-virtual {p1, v1}, Landroid/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/app/Fragment;

    move-result-object v2

    move-object v0, v2

    check-cast v0, Lcom/bumptech/glide/manager/RequestManagerFragment;

    .line 399
    if-nez v0, :cond_0

    .line 400
    new-instance v2, Lcom/bumptech/glide/manager/RequestManagerFragment;

    invoke-direct {v2}, Lcom/bumptech/glide/manager/RequestManagerFragment;-><init>()V

    move-object v0, v2

    .line 401
    invoke-virtual {v0, p2}, Lcom/bumptech/glide/manager/RequestManagerFragment;->setParentFragmentHint(Landroid/app/Fragment;)V

    .line 402
    iget-object v2, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingRequestManagerFragments:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 403
    invoke-virtual {p1}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Landroid/app/FragmentTransaction;->add(Landroid/app/Fragment;Ljava/lang/String;)Landroid/app/FragmentTransaction;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/FragmentTransaction;->commitAllowingStateLoss()I

    .line 404
    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->handler:Landroid/os/Handler;

    const/4 v2, 0x1

    invoke-virtual {v1, v2, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .line 407
    :cond_0
    return-object v0
.end method

.method private getSupportRequestManagerFragment(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/manager/SupportRequestManagerFragment;
    .locals 3
    .param p1, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "parentHint"    # Landroidx/fragment/app/Fragment;

    .line 456
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingSupportRequestManagerFragments:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    .line 457
    .local v0, "current":Lcom/bumptech/glide/manager/SupportRequestManagerFragment;
    if-nez v0, :cond_0

    .line 458
    const-string v1, "com.bumptech.glide.manager"

    invoke-virtual {p1, v1}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v2

    move-object v0, v2

    check-cast v0, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    .line 459
    if-nez v0, :cond_0

    .line 460
    new-instance v2, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    invoke-direct {v2}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;-><init>()V

    move-object v0, v2

    .line 461
    invoke-virtual {v0, p2}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->setParentFragmentHint(Landroidx/fragment/app/Fragment;)V

    .line 462
    iget-object v2, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingSupportRequestManagerFragments:Ljava/util/Map;

    invoke-interface {v2, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 463
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v2

    invoke-virtual {v2, v0, v1}, Landroidx/fragment/app/FragmentTransaction;->add(Landroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    invoke-virtual {v1}, Landroidx/fragment/app/FragmentTransaction;->commitAllowingStateLoss()I

    .line 464
    iget-object v1, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->handler:Landroid/os/Handler;

    const/4 v2, 0x2

    invoke-virtual {v1, v2, p1}, Landroid/os/Handler;->obtainMessage(ILjava/lang/Object;)Landroid/os/Message;

    move-result-object v1

    invoke-virtual {v1}, Landroid/os/Message;->sendToTarget()V

    .line 467
    :cond_0
    return-object v0
.end method

.method private static isActivityVisible(Landroid/content/Context;)Z
    .locals 2
    .param p0, "context"    # Landroid/content/Context;

    .line 445
    invoke-static {p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findActivity(Landroid/content/Context;)Landroid/app/Activity;

    move-result-object v0

    .line 446
    .local v0, "activity":Landroid/app/Activity;
    if-eqz v0, :cond_1

    invoke-virtual {v0}, Landroid/app/Activity;->isFinishing()Z

    move-result v1

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 v1, 0x1

    :goto_1
    return v1
.end method

.method private supportFragmentGet(Landroid/content/Context;Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Lcom/bumptech/glide/RequestManager;
    .locals 6
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "fm"    # Landroidx/fragment/app/FragmentManager;
    .param p3, "parentHint"    # Landroidx/fragment/app/Fragment;
    .param p4, "isParentVisible"    # Z

    .line 476
    invoke-direct {p0, p2, p3}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->getSupportRequestManagerFragment(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    move-result-object v0

    .line 477
    .local v0, "current":Lcom/bumptech/glide/manager/SupportRequestManagerFragment;
    invoke-virtual {v0}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->getRequestManager()Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    .line 478
    .local v1, "requestManager":Lcom/bumptech/glide/RequestManager;
    if-nez v1, :cond_1

    .line 480
    invoke-static {p1}, Lcom/bumptech/glide/Glide;->get(Landroid/content/Context;)Lcom/bumptech/glide/Glide;

    move-result-object v2

    .line 481
    .local v2, "glide":Lcom/bumptech/glide/Glide;
    iget-object v3, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->factory:Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    .line 483
    invoke-virtual {v0}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->getGlideLifecycle()Lcom/bumptech/glide/manager/ActivityFragmentLifecycle;

    move-result-object v4

    invoke-virtual {v0}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->getRequestManagerTreeNode()Lcom/bumptech/glide/manager/RequestManagerTreeNode;

    move-result-object v5

    .line 482
    invoke-interface {v3, v2, v4, v5, p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;->build(Lcom/bumptech/glide/Glide;Lcom/bumptech/glide/manager/Lifecycle;Lcom/bumptech/glide/manager/RequestManagerTreeNode;Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    .line 487
    if-eqz p4, :cond_0

    .line 488
    invoke-virtual {v1}, Lcom/bumptech/glide/RequestManager;->onStart()V

    .line 490
    :cond_0
    invoke-virtual {v0, v1}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->setRequestManager(Lcom/bumptech/glide/RequestManager;)V

    .line 492
    .end local v2    # "glide":Lcom/bumptech/glide/Glide;
    :cond_1
    return-object v1
.end method

.method private verifyOurFragmentWasAddedOrCantBeAdded(Landroid/app/FragmentManager;Z)Z
    .locals 7
    .param p1, "fm"    # Landroid/app/FragmentManager;
    .param p2, "hasAttemptedToAddFragmentTwice"    # Z

    .line 499
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingRequestManagerFragments:Ljava/util/Map;

    .line 500
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/bumptech/glide/manager/RequestManagerFragment;

    .line 502
    .local v0, "newlyAddedRequestManagerFragment":Lcom/bumptech/glide/manager/RequestManagerFragment;
    nop

    .line 503
    const-string v1, "com.bumptech.glide.manager"

    invoke-virtual {p1, v1}, Landroid/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroid/app/Fragment;

    move-result-object v2

    check-cast v2, Lcom/bumptech/glide/manager/RequestManagerFragment;

    .line 504
    .local v2, "actualFragment":Lcom/bumptech/glide/manager/RequestManagerFragment;
    const/4 v3, 0x1

    if-ne v2, v0, :cond_0

    .line 505
    return v3

    .line 508
    :cond_0
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/bumptech/glide/manager/RequestManagerFragment;->getRequestManager()Lcom/bumptech/glide/RequestManager;

    move-result-object v4

    if-nez v4, :cond_1

    goto :goto_0

    .line 509
    :cond_1
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "We\'ve added two fragments with requests! Old: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v4, " New: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 524
    :cond_2
    :goto_0
    const-string v4, "RMRetriever"

    if-nez p2, :cond_6

    invoke-virtual {p1}, Landroid/app/FragmentManager;->isDestroyed()Z

    move-result v5

    if-eqz v5, :cond_3

    goto :goto_1

    .line 538
    :cond_3
    nop

    .line 539
    invoke-virtual {p1}, Landroid/app/FragmentManager;->beginTransaction()Landroid/app/FragmentTransaction;

    move-result-object v5

    invoke-virtual {v5, v0, v1}, Landroid/app/FragmentTransaction;->add(Landroid/app/Fragment;Ljava/lang/String;)Landroid/app/FragmentTransaction;

    move-result-object v1

    .line 549
    .local v1, "transaction":Landroid/app/FragmentTransaction;
    if-eqz v2, :cond_4

    .line 550
    invoke-virtual {v1, v2}, Landroid/app/FragmentTransaction;->remove(Landroid/app/Fragment;)Landroid/app/FragmentTransaction;

    .line 552
    :cond_4
    invoke-virtual {v1}, Landroid/app/FragmentTransaction;->commitAllowingStateLoss()I

    .line 554
    iget-object v5, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->handler:Landroid/os/Handler;

    .line 555
    const/4 v6, 0x0

    invoke-virtual {v5, v3, v3, v6, p1}, Landroid/os/Handler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v3

    .line 557
    invoke-virtual {v3}, Landroid/os/Message;->sendToTarget()V

    .line 558
    const/4 v3, 0x3

    invoke-static {v4, v3}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 559
    const-string v3, "We failed to add our Fragment the first time around, trying again..."

    invoke-static {v4, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 561
    :cond_5
    return v6

    .line 525
    .end local v1    # "transaction":Landroid/app/FragmentTransaction;
    :cond_6
    :goto_1
    const/4 v1, 0x5

    invoke-static {v4, v1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 526
    invoke-virtual {p1}, Landroid/app/FragmentManager;->isDestroyed()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 527
    const-string v1, "Parent was destroyed before our Fragment could be added"

    invoke-static {v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 529
    :cond_7
    const-string v1, "Tried adding Fragment twice and failed twice, giving up!"

    invoke-static {v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 532
    :cond_8
    :goto_2
    invoke-virtual {v0}, Lcom/bumptech/glide/manager/RequestManagerFragment;->getGlideLifecycle()Lcom/bumptech/glide/manager/ActivityFragmentLifecycle;

    move-result-object v1

    invoke-virtual {v1}, Lcom/bumptech/glide/manager/ActivityFragmentLifecycle;->onDestroy()V

    .line 533
    return v3
.end method

.method private verifyOurSupportFragmentWasAddedOrCantBeAdded(Landroidx/fragment/app/FragmentManager;Z)Z
    .locals 8
    .param p1, "supportFm"    # Landroidx/fragment/app/FragmentManager;
    .param p2, "hasAttemptedToAddFragmentTwice"    # Z

    .line 568
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingSupportRequestManagerFragments:Ljava/util/Map;

    .line 569
    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    .line 571
    .local v0, "newlyAddedSupportRequestManagerFragment":Lcom/bumptech/glide/manager/SupportRequestManagerFragment;
    nop

    .line 572
    const-string v1, "com.bumptech.glide.manager"

    invoke-virtual {p1, v1}, Landroidx/fragment/app/FragmentManager;->findFragmentByTag(Ljava/lang/String;)Landroidx/fragment/app/Fragment;

    move-result-object v2

    check-cast v2, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    .line 573
    .local v2, "actualFragment":Lcom/bumptech/glide/manager/SupportRequestManagerFragment;
    const/4 v3, 0x1

    if-ne v2, v0, :cond_0

    .line 574
    return v3

    .line 577
    :cond_0
    if-eqz v2, :cond_2

    invoke-virtual {v2}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->getRequestManager()Lcom/bumptech/glide/RequestManager;

    move-result-object v4

    if-nez v4, :cond_1

    goto :goto_0

    .line 578
    :cond_1
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "We\'ve added two fragments with requests! Old: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v4, " New: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 592
    :cond_2
    :goto_0
    const-string v4, "RMRetriever"

    if-nez p2, :cond_6

    invoke-virtual {p1}, Landroidx/fragment/app/FragmentManager;->isDestroyed()Z

    move-result v5

    if-eqz v5, :cond_3

    goto :goto_1

    .line 616
    :cond_3
    nop

    .line 617
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentManager;->beginTransaction()Landroidx/fragment/app/FragmentTransaction;

    move-result-object v5

    invoke-virtual {v5, v0, v1}, Landroidx/fragment/app/FragmentTransaction;->add(Landroidx/fragment/app/Fragment;Ljava/lang/String;)Landroidx/fragment/app/FragmentTransaction;

    move-result-object v1

    .line 628
    .local v1, "transaction":Landroidx/fragment/app/FragmentTransaction;
    if-eqz v2, :cond_4

    .line 629
    invoke-virtual {v1, v2}, Landroidx/fragment/app/FragmentTransaction;->remove(Landroidx/fragment/app/Fragment;)Landroidx/fragment/app/FragmentTransaction;

    .line 631
    :cond_4
    invoke-virtual {v1}, Landroidx/fragment/app/FragmentTransaction;->commitNowAllowingStateLoss()V

    .line 633
    iget-object v5, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->handler:Landroid/os/Handler;

    const/4 v6, 0x2

    .line 634
    const/4 v7, 0x0

    invoke-virtual {v5, v6, v3, v7, p1}, Landroid/os/Handler;->obtainMessage(IIILjava/lang/Object;)Landroid/os/Message;

    move-result-object v3

    .line 639
    invoke-virtual {v3}, Landroid/os/Message;->sendToTarget()V

    .line 640
    const/4 v3, 0x3

    invoke-static {v4, v3}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v3

    if-eqz v3, :cond_5

    .line 641
    const-string v3, "We failed to add our Fragment the first time around, trying again..."

    invoke-static {v4, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 643
    :cond_5
    return v7

    .line 593
    .end local v1    # "transaction":Landroidx/fragment/app/FragmentTransaction;
    :cond_6
    :goto_1
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentManager;->isDestroyed()Z

    move-result v1

    if-eqz v1, :cond_7

    .line 594
    const/4 v1, 0x5

    invoke-static {v4, v1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 595
    const-string v1, "Parent was destroyed before our Fragment could be added, all requests for the destroyed parent are cancelled"

    invoke-static {v4, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_2

    .line 601
    :cond_7
    const/4 v1, 0x6

    invoke-static {v4, v1}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v1

    if-eqz v1, :cond_8

    .line 602
    const-string v1, "ERROR: Tried adding Fragment twice and failed twice, giving up and cancelling all associated requests! This probably means you\'re starting loads in a unit test with an Activity that you haven\'t created and never create. If you\'re using Robolectric, create the Activity as part of your test setup"

    invoke-static {v4, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 610
    :cond_8
    :goto_2
    invoke-virtual {v0}, Lcom/bumptech/glide/manager/SupportRequestManagerFragment;->getGlideLifecycle()Lcom/bumptech/glide/manager/ActivityFragmentLifecycle;

    move-result-object v1

    invoke-virtual {v1}, Lcom/bumptech/glide/manager/ActivityFragmentLifecycle;->onDestroy()V

    .line 611
    return v3
.end method


# virtual methods
.method public get(Landroid/app/Activity;)Lcom/bumptech/glide/RequestManager;
    .locals 3
    .param p1, "activity"    # Landroid/app/Activity;

    .line 183
    invoke-static {}, Lcom/bumptech/glide/util/Util;->isOnBackgroundThread()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 184
    invoke-virtual {p1}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 185
    :cond_0
    instance-of v0, p1, Landroidx/fragment/app/FragmentActivity;

    if-eqz v0, :cond_1

    .line 186
    move-object v0, p1

    check-cast v0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroidx/fragment/app/FragmentActivity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 188
    :cond_1
    invoke-static {p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->assertNotDestroyed(Landroid/app/Activity;)V

    .line 189
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->frameWaiter:Lcom/bumptech/glide/manager/FrameWaiter;

    invoke-interface {v0, p1}, Lcom/bumptech/glide/manager/FrameWaiter;->registerSelf(Landroid/app/Activity;)V

    .line 190
    invoke-virtual {p1}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    .line 191
    .local v0, "fm":Landroid/app/FragmentManager;
    const/4 v1, 0x0

    invoke-static {p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->isActivityVisible(Landroid/content/Context;)Z

    move-result v2

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->fragmentGet(Landroid/content/Context;Landroid/app/FragmentManager;Landroid/app/Fragment;Z)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    return-object v1
.end method

.method public get(Landroid/app/Fragment;)Lcom/bumptech/glide/RequestManager;
    .locals 3
    .param p1, "fragment"    # Landroid/app/Fragment;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 362
    invoke-virtual {p1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 366
    invoke-static {}, Lcom/bumptech/glide/util/Util;->isOnBackgroundThread()Z

    move-result v0

    if-nez v0, :cond_2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x11

    if-ge v0, v1, :cond_0

    goto :goto_0

    .line 373
    :cond_0
    invoke-virtual {p1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 374
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->frameWaiter:Lcom/bumptech/glide/manager/FrameWaiter;

    invoke-virtual {p1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/bumptech/glide/manager/FrameWaiter;->registerSelf(Landroid/app/Activity;)V

    .line 376
    :cond_1
    invoke-virtual {p1}, Landroid/app/Fragment;->getChildFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    .line 377
    .local v0, "fm":Landroid/app/FragmentManager;
    invoke-virtual {p1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v1

    invoke-virtual {p1}, Landroid/app/Fragment;->isVisible()Z

    move-result v2

    invoke-direct {p0, v1, v0, p1, v2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->fragmentGet(Landroid/content/Context;Landroid/app/FragmentManager;Landroid/app/Fragment;Z)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    return-object v1

    .line 367
    .end local v0    # "fm":Landroid/app/FragmentManager;
    :cond_2
    :goto_0
    invoke-virtual {p1}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 363
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "You cannot start a load on a fragment before it is attached"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;
    .locals 2
    .param p1, "context"    # Landroid/content/Context;

    .line 129
    if-eqz p1, :cond_3

    .line 131
    invoke-static {}, Lcom/bumptech/glide/util/Util;->isOnMainThread()Z

    move-result v0

    if-eqz v0, :cond_2

    instance-of v0, p1, Landroid/app/Application;

    if-nez v0, :cond_2

    .line 132
    instance-of v0, p1, Landroidx/fragment/app/FragmentActivity;

    if-eqz v0, :cond_0

    .line 133
    move-object v0, p1

    check-cast v0, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroidx/fragment/app/FragmentActivity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 134
    :cond_0
    instance-of v0, p1, Landroid/app/Activity;

    if-eqz v0, :cond_1

    .line 135
    move-object v0, p1

    check-cast v0, Landroid/app/Activity;

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/app/Activity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 136
    :cond_1
    instance-of v0, p1, Landroid/content/ContextWrapper;

    if-eqz v0, :cond_2

    move-object v0, p1

    check-cast v0, Landroid/content/ContextWrapper;

    .line 140
    invoke-virtual {v0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 141
    move-object v0, p1

    check-cast v0, Landroid/content/ContextWrapper;

    invoke-virtual {v0}, Landroid/content/ContextWrapper;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 145
    :cond_2
    invoke-direct {p0, p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->getApplicationManager(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 130
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "You cannot start a load on a null Context"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public get(Landroid/view/View;)Lcom/bumptech/glide/RequestManager;
    .locals 3
    .param p1, "view"    # Landroid/view/View;

    .line 198
    invoke-static {}, Lcom/bumptech/glide/util/Util;->isOnBackgroundThread()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 199
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 202
    :cond_0
    invoke-static {p1}, Lcom/bumptech/glide/util/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    .line 203
    nop

    .line 204
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 203
    const-string v1, "Unable to obtain a request manager for a view without a Context"

    invoke-static {v0, v1}, Lcom/bumptech/glide/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 205
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findActivity(Landroid/content/Context;)Landroid/app/Activity;

    move-result-object v0

    .line 207
    .local v0, "activity":Landroid/app/Activity;
    if-nez v0, :cond_1

    .line 208
    invoke-virtual {p1}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p0, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    return-object v1

    .line 215
    :cond_1
    instance-of v1, v0, Landroidx/fragment/app/FragmentActivity;

    if-eqz v1, :cond_3

    .line 216
    move-object v1, v0

    check-cast v1, Landroidx/fragment/app/FragmentActivity;

    invoke-direct {p0, p1, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findSupportFragment(Landroid/view/View;Landroidx/fragment/app/FragmentActivity;)Landroidx/fragment/app/Fragment;

    move-result-object v1

    .line 217
    .local v1, "fragment":Landroidx/fragment/app/Fragment;
    if-eqz v1, :cond_2

    invoke-virtual {p0, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/RequestManager;

    move-result-object v2

    goto :goto_0

    :cond_2
    move-object v2, v0

    check-cast v2, Landroidx/fragment/app/FragmentActivity;

    invoke-virtual {p0, v2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroidx/fragment/app/FragmentActivity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v2

    :goto_0
    return-object v2

    .line 221
    .end local v1    # "fragment":Landroidx/fragment/app/Fragment;
    :cond_3
    invoke-direct {p0, p1, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->findFragment(Landroid/view/View;Landroid/app/Activity;)Landroid/app/Fragment;

    move-result-object v1

    .line 222
    .local v1, "fragment":Landroid/app/Fragment;
    if-nez v1, :cond_4

    .line 223
    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/app/Activity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v2

    return-object v2

    .line 225
    :cond_4
    invoke-virtual {p0, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/app/Fragment;)Lcom/bumptech/glide/RequestManager;

    move-result-object v2

    return-object v2
.end method

.method public get(Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/RequestManager;
    .locals 3
    .param p1, "fragment"    # Landroidx/fragment/app/Fragment;

    .line 162
    nop

    .line 163
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 162
    const-string v1, "You cannot start a load on a fragment before it is attached or after it is destroyed"

    invoke-static {v0, v1}, Lcom/bumptech/glide/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 165
    invoke-static {}, Lcom/bumptech/glide/util/Util;->isOnBackgroundThread()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 166
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 172
    :cond_0
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 173
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->frameWaiter:Lcom/bumptech/glide/manager/FrameWaiter;

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getActivity()Landroidx/fragment/app/FragmentActivity;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/bumptech/glide/manager/FrameWaiter;->registerSelf(Landroid/app/Activity;)V

    .line 175
    :cond_1
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getChildFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    .line 176
    .local v0, "fm":Landroidx/fragment/app/FragmentManager;
    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {p1}, Landroidx/fragment/app/Fragment;->isVisible()Z

    move-result v2

    invoke-direct {p0, v1, v0, p1, v2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->supportFragmentGet(Landroid/content/Context;Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    return-object v1
.end method

.method public get(Landroidx/fragment/app/FragmentActivity;)Lcom/bumptech/glide/RequestManager;
    .locals 3
    .param p1, "activity"    # Landroidx/fragment/app/FragmentActivity;

    .line 150
    invoke-static {}, Lcom/bumptech/glide/util/Util;->isOnBackgroundThread()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 151
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0

    .line 153
    :cond_0
    invoke-static {p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->assertNotDestroyed(Landroid/app/Activity;)V

    .line 154
    iget-object v0, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->frameWaiter:Lcom/bumptech/glide/manager/FrameWaiter;

    invoke-interface {v0, p1}, Lcom/bumptech/glide/manager/FrameWaiter;->registerSelf(Landroid/app/Activity;)V

    .line 155
    invoke-virtual {p1}, Landroidx/fragment/app/FragmentActivity;->getSupportFragmentManager()Landroidx/fragment/app/FragmentManager;

    move-result-object v0

    .line 156
    .local v0, "fm":Landroidx/fragment/app/FragmentManager;
    const/4 v1, 0x0

    invoke-static {p1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->isActivityVisible(Landroid/content/Context;)Z

    move-result v2

    invoke-direct {p0, p1, v0, v1, v2}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->supportFragmentGet(Landroid/content/Context;Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;Z)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    return-object v1
.end method

.method getRequestManagerFragment(Landroid/app/Activity;)Lcom/bumptech/glide/manager/RequestManagerFragment;
    .locals 2
    .param p1, "activity"    # Landroid/app/Activity;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 385
    invoke-virtual {p1}, Landroid/app/Activity;->getFragmentManager()Landroid/app/FragmentManager;

    move-result-object v0

    const/4 v1, 0x0

    invoke-direct {p0, v0, v1}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->getRequestManagerFragment(Landroid/app/FragmentManager;Landroid/app/Fragment;)Lcom/bumptech/glide/manager/RequestManagerFragment;

    move-result-object v0

    return-object v0
.end method

.method getSupportRequestManagerFragment(Landroidx/fragment/app/FragmentManager;)Lcom/bumptech/glide/manager/SupportRequestManagerFragment;
    .locals 1
    .param p1, "fragmentManager"    # Landroidx/fragment/app/FragmentManager;

    .line 439
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->getSupportRequestManagerFragment(Landroidx/fragment/app/FragmentManager;Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/manager/SupportRequestManagerFragment;

    move-result-object v0

    return-object v0
.end method

.method public handleMessage(Landroid/os/Message;)Z
    .locals 8
    .param p1, "message"    # Landroid/os/Message;

    .line 649
    const/4 v0, 0x1

    .line 650
    .local v0, "handled":Z
    const/4 v1, 0x0

    .line 651
    .local v1, "attemptedRemoval":Z
    const/4 v2, 0x0

    .line 652
    .local v2, "removed":Ljava/lang/Object;
    const/4 v3, 0x0

    .line 653
    .local v3, "key":Ljava/lang/Object;
    iget v4, p1, Landroid/os/Message;->arg1:I

    const/4 v5, 0x1

    if-ne v4, v5, :cond_0

    const/4 v4, 0x1

    goto :goto_0

    :cond_0
    const/4 v4, 0x0

    .line 654
    .local v4, "hasAttemptedBefore":Z
    :goto_0
    iget v6, p1, Landroid/os/Message;->what:I

    if-eq v6, v5, :cond_2

    const/4 v5, 0x2

    if-eq v6, v5, :cond_1

    .line 672
    const/4 v0, 0x0

    goto :goto_1

    .line 664
    :cond_1
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v5, Landroidx/fragment/app/FragmentManager;

    .line 665
    .local v5, "supportFm":Landroidx/fragment/app/FragmentManager;
    invoke-direct {p0, v5, v4}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->verifyOurSupportFragmentWasAddedOrCantBeAdded(Landroidx/fragment/app/FragmentManager;Z)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 666
    const/4 v1, 0x1

    .line 667
    move-object v3, v5

    .line 668
    iget-object v6, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingSupportRequestManagerFragments:Ljava/util/Map;

    invoke-interface {v6, v5}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    goto :goto_1

    .line 656
    .end local v5    # "supportFm":Landroidx/fragment/app/FragmentManager;
    :cond_2
    iget-object v5, p1, Landroid/os/Message;->obj:Ljava/lang/Object;

    check-cast v5, Landroid/app/FragmentManager;

    .line 657
    .local v5, "fm":Landroid/app/FragmentManager;
    invoke-direct {p0, v5, v4}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->verifyOurFragmentWasAddedOrCantBeAdded(Landroid/app/FragmentManager;Z)Z

    move-result v6

    if-eqz v6, :cond_3

    .line 658
    const/4 v1, 0x1

    .line 659
    move-object v3, v5

    .line 660
    iget-object v6, p0, Lcom/bumptech/glide/manager/RequestManagerRetriever;->pendingRequestManagerFragments:Ljava/util/Map;

    invoke-interface {v6, v5}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 675
    .end local v5    # "fm":Landroid/app/FragmentManager;
    :cond_3
    :goto_1
    const/4 v5, 0x5

    const-string v6, "RMRetriever"

    invoke-static {v6, v5}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v5

    if-eqz v5, :cond_4

    .line 676
    if-eqz v1, :cond_4

    if-nez v2, :cond_4

    .line 677
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Failed to remove expected request manager fragment, manager: "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v6, v5}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    .line 680
    :cond_4
    return v0
.end method
