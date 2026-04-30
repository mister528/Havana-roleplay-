.class public Lcom/bumptech/glide/Glide;
.super Ljava/lang/Object;
.source "Glide.java"

# interfaces
.implements Landroid/content/ComponentCallbacks2;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/bumptech/glide/Glide$RequestOptionsFactory;
    }
.end annotation


# static fields
.field private static final DEFAULT_DISK_CACHE_DIR:Ljava/lang/String; = "image_manager_disk_cache"

.field private static final TAG:Ljava/lang/String; = "Glide"

.field private static volatile glide:Lcom/bumptech/glide/Glide;

.field private static volatile isInitializing:Z


# instance fields
.field private final arrayPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;

.field private final bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

.field private bitmapPreFiller:Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;

.field private final connectivityMonitorFactory:Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;

.field private final defaultRequestOptionsFactory:Lcom/bumptech/glide/Glide$RequestOptionsFactory;

.field private final engine:Lcom/bumptech/glide/load/engine/Engine;

.field private final glideContext:Lcom/bumptech/glide/GlideContext;

.field private final managers:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/bumptech/glide/RequestManager;",
            ">;"
        }
    .end annotation
.end field

.field private final memoryCache:Lcom/bumptech/glide/load/engine/cache/MemoryCache;

.field private memoryCategory:Lcom/bumptech/glide/MemoryCategory;

.field private final registry:Lcom/bumptech/glide/Registry;

.field private final requestManagerRetriever:Lcom/bumptech/glide/manager/RequestManagerRetriever;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/bumptech/glide/load/engine/Engine;Lcom/bumptech/glide/load/engine/cache/MemoryCache;Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;Lcom/bumptech/glide/manager/RequestManagerRetriever;Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;ILcom/bumptech/glide/Glide$RequestOptionsFactory;Ljava/util/Map;Ljava/util/List;Lcom/bumptech/glide/GlideExperiments;)V
    .locals 32
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "engine"    # Lcom/bumptech/glide/load/engine/Engine;
    .param p3, "memoryCache"    # Lcom/bumptech/glide/load/engine/cache/MemoryCache;
    .param p4, "bitmapPool"    # Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;
    .param p5, "arrayPool"    # Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;
    .param p6, "requestManagerRetriever"    # Lcom/bumptech/glide/manager/RequestManagerRetriever;
    .param p7, "connectivityMonitorFactory"    # Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;
    .param p8, "logLevel"    # I
    .param p9, "defaultRequestOptionsFactory"    # Lcom/bumptech/glide/Glide$RequestOptionsFactory;
    .param p12, "experiments"    # Lcom/bumptech/glide/GlideExperiments;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Lcom/bumptech/glide/load/engine/Engine;",
            "Lcom/bumptech/glide/load/engine/cache/MemoryCache;",
            "Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;",
            "Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;",
            "Lcom/bumptech/glide/manager/RequestManagerRetriever;",
            "Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;",
            "I",
            "Lcom/bumptech/glide/Glide$RequestOptionsFactory;",
            "Ljava/util/Map<",
            "Ljava/lang/Class<",
            "*>;",
            "Lcom/bumptech/glide/TransitionOptions<",
            "**>;>;",
            "Ljava/util/List<",
            "Lcom/bumptech/glide/request/RequestListener<",
            "Ljava/lang/Object;",
            ">;>;",
            "Lcom/bumptech/glide/GlideExperiments;",
            ")V"
        }
    .end annotation

    .line 390
    .local p10, "defaultTransitionOptions":Ljava/util/Map;, "Ljava/util/Map<Ljava/lang/Class<*>;Lcom/bumptech/glide/TransitionOptions<**>;>;"
    .local p11, "defaultRequestListeners":Ljava/util/List;, "Ljava/util/List<Lcom/bumptech/glide/request/RequestListener<Ljava/lang/Object;>;>;"
    move-object/from16 v0, p0

    move-object/from16 v12, p1

    move-object/from16 v13, p4

    move-object/from16 v14, p5

    move-object/from16 v15, p12

    const-class v1, [B

    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 132
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, v0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    .line 136
    sget-object v2, Lcom/bumptech/glide/MemoryCategory;->NORMAL:Lcom/bumptech/glide/MemoryCategory;

    iput-object v2, v0, Lcom/bumptech/glide/Glide;->memoryCategory:Lcom/bumptech/glide/MemoryCategory;

    .line 391
    move-object/from16 v11, p2

    iput-object v11, v0, Lcom/bumptech/glide/Glide;->engine:Lcom/bumptech/glide/load/engine/Engine;

    .line 392
    iput-object v13, v0, Lcom/bumptech/glide/Glide;->bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

    .line 393
    iput-object v14, v0, Lcom/bumptech/glide/Glide;->arrayPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;

    .line 394
    move-object/from16 v10, p3

    iput-object v10, v0, Lcom/bumptech/glide/Glide;->memoryCache:Lcom/bumptech/glide/load/engine/cache/MemoryCache;

    .line 395
    move-object/from16 v9, p6

    iput-object v9, v0, Lcom/bumptech/glide/Glide;->requestManagerRetriever:Lcom/bumptech/glide/manager/RequestManagerRetriever;

    .line 396
    move-object/from16 v8, p7

    iput-object v8, v0, Lcom/bumptech/glide/Glide;->connectivityMonitorFactory:Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;

    .line 397
    move-object/from16 v7, p9

    iput-object v7, v0, Lcom/bumptech/glide/Glide;->defaultRequestOptionsFactory:Lcom/bumptech/glide/Glide$RequestOptionsFactory;

    .line 399
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v6

    .line 401
    .local v6, "resources":Landroid/content/res/Resources;
    new-instance v2, Lcom/bumptech/glide/Registry;

    invoke-direct {v2}, Lcom/bumptech/glide/Registry;-><init>()V

    iput-object v2, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    .line 402
    new-instance v3, Lcom/bumptech/glide/load/resource/bitmap/DefaultImageHeaderParser;

    invoke-direct {v3}, Lcom/bumptech/glide/load/resource/bitmap/DefaultImageHeaderParser;-><init>()V

    invoke-virtual {v2, v3}, Lcom/bumptech/glide/Registry;->register(Lcom/bumptech/glide/load/ImageHeaderParser;)Lcom/bumptech/glide/Registry;

    .line 405
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x1b

    if-lt v2, v3, :cond_0

    .line 406
    iget-object v2, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    new-instance v3, Lcom/bumptech/glide/load/resource/bitmap/ExifInterfaceImageHeaderParser;

    invoke-direct {v3}, Lcom/bumptech/glide/load/resource/bitmap/ExifInterfaceImageHeaderParser;-><init>()V

    invoke-virtual {v2, v3}, Lcom/bumptech/glide/Registry;->register(Lcom/bumptech/glide/load/ImageHeaderParser;)Lcom/bumptech/glide/Registry;

    .line 409
    :cond_0
    iget-object v2, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    invoke-virtual {v2}, Lcom/bumptech/glide/Registry;->getImageHeaderParsers()Ljava/util/List;

    move-result-object v4

    .line 411
    .local v4, "imageHeaderParsers":Ljava/util/List;, "Ljava/util/List<Lcom/bumptech/glide/load/ImageHeaderParser;>;"
    new-instance v2, Lcom/bumptech/glide/load/resource/gif/ByteBufferGifDecoder;

    invoke-direct {v2, v12, v4, v13, v14}, Lcom/bumptech/glide/load/resource/gif/ByteBufferGifDecoder;-><init>(Landroid/content/Context;Ljava/util/List;Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    move-object v3, v2

    .line 413
    .local v3, "byteBufferGifDecoder":Lcom/bumptech/glide/load/resource/gif/ByteBufferGifDecoder;
    nop

    .line 414
    invoke-static/range {p4 .. p4}, Lcom/bumptech/glide/load/resource/bitmap/VideoDecoder;->parcel(Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;)Lcom/bumptech/glide/load/ResourceDecoder;

    move-result-object v2

    .line 417
    .local v2, "parcelFileDescriptorVideoDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Landroid/os/ParcelFileDescriptor;Landroid/graphics/Bitmap;>;"
    new-instance v5, Lcom/bumptech/glide/load/resource/bitmap/Downsampler;

    iget-object v7, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    .line 419
    invoke-virtual {v7}, Lcom/bumptech/glide/Registry;->getImageHeaderParsers()Ljava/util/List;

    move-result-object v7

    invoke-virtual {v6}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v8

    invoke-direct {v5, v7, v8, v13, v14}, Lcom/bumptech/glide/load/resource/bitmap/Downsampler;-><init>(Ljava/util/List;Landroid/util/DisplayMetrics;Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    move-object v8, v5

    .line 423
    .local v8, "downsampler":Lcom/bumptech/glide/load/resource/bitmap/Downsampler;
    sget v5, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v7, 0x1c

    if-lt v5, v7, :cond_1

    const-class v5, Lcom/bumptech/glide/GlideBuilder$EnableImageDecoderForBitmaps;

    .line 424
    invoke-virtual {v15, v5}, Lcom/bumptech/glide/GlideExperiments;->isEnabled(Ljava/lang/Class;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 425
    new-instance v5, Lcom/bumptech/glide/load/resource/bitmap/InputStreamBitmapImageDecoderResourceDecoder;

    invoke-direct {v5}, Lcom/bumptech/glide/load/resource/bitmap/InputStreamBitmapImageDecoderResourceDecoder;-><init>()V

    .line 426
    .local v5, "streamBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/io/InputStream;Landroid/graphics/Bitmap;>;"
    new-instance v16, Lcom/bumptech/glide/load/resource/bitmap/ByteBufferBitmapImageDecoderResourceDecoder;

    invoke-direct/range {v16 .. v16}, Lcom/bumptech/glide/load/resource/bitmap/ByteBufferBitmapImageDecoderResourceDecoder;-><init>()V

    move-object/from16 v17, v16

    .local v16, "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    goto :goto_0

    .line 428
    .end local v5    # "streamBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/io/InputStream;Landroid/graphics/Bitmap;>;"
    .end local v16    # "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    :cond_1
    new-instance v5, Lcom/bumptech/glide/load/resource/bitmap/ByteBufferBitmapDecoder;

    invoke-direct {v5, v8}, Lcom/bumptech/glide/load/resource/bitmap/ByteBufferBitmapDecoder;-><init>(Lcom/bumptech/glide/load/resource/bitmap/Downsampler;)V

    move-object/from16 v16, v5

    .line 429
    .restart local v16    # "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    new-instance v5, Lcom/bumptech/glide/load/resource/bitmap/StreamBitmapDecoder;

    invoke-direct {v5, v8, v14}, Lcom/bumptech/glide/load/resource/bitmap/StreamBitmapDecoder;-><init>(Lcom/bumptech/glide/load/resource/bitmap/Downsampler;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    move-object/from16 v17, v16

    .line 432
    .end local v16    # "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    .restart local v5    # "streamBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/io/InputStream;Landroid/graphics/Bitmap;>;"
    .local v17, "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    :goto_0
    sget v9, Landroid/os/Build$VERSION;->SDK_INT:I

    const-string v10, "Animation"

    if-lt v9, v7, :cond_2

    const-class v7, Lcom/bumptech/glide/GlideBuilder$EnableImageDecoderForAnimatedWebp;

    .line 433
    invoke-virtual {v15, v7}, Lcom/bumptech/glide/GlideExperiments;->isEnabled(Ljava/lang/Class;)Z

    move-result v7

    if-eqz v7, :cond_2

    .line 434
    iget-object v7, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v9, Ljava/io/InputStream;

    const-class v11, Landroid/graphics/drawable/Drawable;

    .line 438
    invoke-static {v4, v14}, Lcom/bumptech/glide/load/resource/drawable/AnimatedWebpDecoder;->streamDecoder(Ljava/util/List;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)Lcom/bumptech/glide/load/ResourceDecoder;

    move-result-object v15

    .line 434
    invoke-virtual {v7, v10, v9, v11, v15}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    .line 439
    iget-object v7, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v9, Ljava/nio/ByteBuffer;

    const-class v11, Landroid/graphics/drawable/Drawable;

    .line 443
    invoke-static {v4, v14}, Lcom/bumptech/glide/load/resource/drawable/AnimatedWebpDecoder;->byteBufferDecoder(Ljava/util/List;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)Lcom/bumptech/glide/load/ResourceDecoder;

    move-result-object v15

    .line 439
    invoke-virtual {v7, v10, v9, v11, v15}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    .line 446
    :cond_2
    new-instance v7, Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;

    invoke-direct {v7, v12}, Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;-><init>(Landroid/content/Context;)V

    move-object v15, v7

    .line 447
    .local v15, "resourceDrawableDecoder":Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;
    new-instance v7, Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;

    invoke-direct {v7, v6}, Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;-><init>(Landroid/content/res/Resources;)V

    move-object v11, v7

    .line 449
    .local v11, "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    new-instance v7, Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;

    invoke-direct {v7, v6}, Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;-><init>(Landroid/content/res/Resources;)V

    move-object v9, v7

    .line 450
    .local v9, "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    new-instance v7, Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;

    invoke-direct {v7, v6}, Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;-><init>(Landroid/content/res/Resources;)V

    .line 452
    .local v7, "resourceLoaderFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;
    move-object/from16 v16, v1

    new-instance v1, Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;

    invoke-direct {v1, v6}, Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;-><init>(Landroid/content/res/Resources;)V

    .line 454
    .local v1, "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    new-instance v12, Lcom/bumptech/glide/load/resource/bitmap/BitmapEncoder;

    invoke-direct {v12, v14}, Lcom/bumptech/glide/load/resource/bitmap/BitmapEncoder;-><init>(Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    .line 456
    .local v12, "bitmapEncoder":Lcom/bumptech/glide/load/resource/bitmap/BitmapEncoder;
    new-instance v18, Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;

    invoke-direct/range {v18 .. v18}, Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;-><init>()V

    move-object/from16 v19, v18

    .line 457
    .local v19, "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    new-instance v18, Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;

    invoke-direct/range {v18 .. v18}, Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;-><init>()V

    move-object/from16 v20, v18

    .line 459
    .local v20, "gifDrawableBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;
    move-object/from16 v18, v1

    .end local v1    # "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    .local v18, "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v1

    .line 461
    .local v1, "contentResolver":Landroid/content/ContentResolver;
    move-object/from16 v21, v1

    .end local v1    # "contentResolver":Landroid/content/ContentResolver;
    .local v21, "contentResolver":Landroid/content/ContentResolver;
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    move-object/from16 v22, v9

    .end local v9    # "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    .local v22, "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    const-class v9, Ljava/nio/ByteBuffer;

    move-object/from16 v23, v7

    .end local v7    # "resourceLoaderFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;
    .local v23, "resourceLoaderFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;
    new-instance v7, Lcom/bumptech/glide/load/model/ByteBufferEncoder;

    invoke-direct {v7}, Lcom/bumptech/glide/load/model/ByteBufferEncoder;-><init>()V

    .line 462
    invoke-virtual {v1, v9, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Lcom/bumptech/glide/load/Encoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/InputStream;

    new-instance v9, Lcom/bumptech/glide/load/model/StreamEncoder;

    invoke-direct {v9, v14}, Lcom/bumptech/glide/load/model/StreamEncoder;-><init>(Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    .line 463
    invoke-virtual {v1, v7, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Lcom/bumptech/glide/load/Encoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/nio/ByteBuffer;

    const-class v9, Landroid/graphics/Bitmap;

    .line 465
    move-object/from16 v24, v11

    .end local v11    # "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    .local v24, "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    const-string v11, "Bitmap"

    move-object/from16 v25, v15

    move-object/from16 v15, v17

    .end local v17    # "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    .local v15, "byteBufferBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    .local v25, "resourceDrawableDecoder":Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;
    invoke-virtual {v1, v11, v7, v9, v15}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/InputStream;

    const-class v9, Landroid/graphics/Bitmap;

    .line 466
    invoke-virtual {v1, v11, v7, v9, v5}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    .line 468
    invoke-static {}, Lcom/bumptech/glide/load/data/ParcelFileDescriptorRewinder;->isSupported()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 469
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v7, Landroid/os/ParcelFileDescriptor;

    const-class v9, Landroid/graphics/Bitmap;

    move-object/from16 v17, v10

    new-instance v10, Lcom/bumptech/glide/load/resource/bitmap/ParcelFileDescriptorBitmapDecoder;

    invoke-direct {v10, v8}, Lcom/bumptech/glide/load/resource/bitmap/ParcelFileDescriptorBitmapDecoder;-><init>(Lcom/bumptech/glide/load/resource/bitmap/Downsampler;)V

    invoke-virtual {v1, v11, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    goto :goto_1

    .line 468
    :cond_3
    move-object/from16 v17, v10

    .line 476
    :goto_1
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v7, Landroid/os/ParcelFileDescriptor;

    const-class v9, Landroid/graphics/Bitmap;

    .line 477
    invoke-virtual {v1, v11, v7, v9, v2}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/content/res/AssetFileDescriptor;

    const-class v9, Landroid/graphics/Bitmap;

    .line 486
    invoke-static/range {p4 .. p4}, Lcom/bumptech/glide/load/resource/bitmap/VideoDecoder;->asset(Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;)Lcom/bumptech/glide/load/ResourceDecoder;

    move-result-object v10

    .line 482
    invoke-virtual {v1, v11, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/graphics/Bitmap;

    const-class v9, Landroid/graphics/Bitmap;

    .line 487
    invoke-static {}, Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;->getInstance()Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;

    move-result-object v10

    invoke-virtual {v1, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/graphics/Bitmap;

    const-class v9, Landroid/graphics/Bitmap;

    new-instance v10, Lcom/bumptech/glide/load/resource/bitmap/UnitBitmapDecoder;

    invoke-direct {v10}, Lcom/bumptech/glide/load/resource/bitmap/UnitBitmapDecoder;-><init>()V

    .line 488
    invoke-virtual {v1, v11, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/graphics/Bitmap;

    .line 489
    invoke-virtual {v1, v7, v12}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceEncoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/nio/ByteBuffer;

    const-class v9, Landroid/graphics/drawable/BitmapDrawable;

    new-instance v10, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;

    invoke-direct {v10, v6, v15}, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;-><init>(Landroid/content/res/Resources;Lcom/bumptech/glide/load/ResourceDecoder;)V

    .line 491
    move-object/from16 v26, v8

    .end local v8    # "downsampler":Lcom/bumptech/glide/load/resource/bitmap/Downsampler;
    .local v26, "downsampler":Lcom/bumptech/glide/load/resource/bitmap/Downsampler;
    const-string v8, "BitmapDrawable"

    invoke-virtual {v1, v8, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/InputStream;

    const-class v9, Landroid/graphics/drawable/BitmapDrawable;

    new-instance v10, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;

    invoke-direct {v10, v6, v5}, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;-><init>(Landroid/content/res/Resources;Lcom/bumptech/glide/load/ResourceDecoder;)V

    .line 496
    invoke-virtual {v1, v8, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/os/ParcelFileDescriptor;

    const-class v9, Landroid/graphics/drawable/BitmapDrawable;

    new-instance v10, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;

    invoke-direct {v10, v6, v2}, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;-><init>(Landroid/content/res/Resources;Lcom/bumptech/glide/load/ResourceDecoder;)V

    .line 501
    invoke-virtual {v1, v8, v7, v9, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/graphics/drawable/BitmapDrawable;

    new-instance v8, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableEncoder;

    invoke-direct {v8, v13, v12}, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableEncoder;-><init>(Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;Lcom/bumptech/glide/load/ResourceEncoder;)V

    .line 506
    invoke-virtual {v1, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceEncoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/InputStream;

    const-class v8, Lcom/bumptech/glide/load/resource/gif/GifDrawable;

    new-instance v9, Lcom/bumptech/glide/load/resource/gif/StreamGifDecoder;

    invoke-direct {v9, v4, v3, v14}, Lcom/bumptech/glide/load/resource/gif/StreamGifDecoder;-><init>(Ljava/util/List;Lcom/bumptech/glide/load/ResourceDecoder;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    .line 508
    move-object/from16 v10, v17

    invoke-virtual {v1, v10, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/nio/ByteBuffer;

    const-class v8, Lcom/bumptech/glide/load/resource/gif/GifDrawable;

    .line 513
    invoke-virtual {v1, v10, v7, v8, v3}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Lcom/bumptech/glide/load/resource/gif/GifDrawable;

    new-instance v8, Lcom/bumptech/glide/load/resource/gif/GifDrawableEncoder;

    invoke-direct {v8}, Lcom/bumptech/glide/load/resource/gif/GifDrawableEncoder;-><init>()V

    .line 515
    invoke-virtual {v1, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceEncoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Lcom/bumptech/glide/gifdecoder/GifDecoder;

    const-class v8, Lcom/bumptech/glide/gifdecoder/GifDecoder;

    .line 519
    invoke-static {}, Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;->getInstance()Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;

    move-result-object v9

    .line 518
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Lcom/bumptech/glide/gifdecoder/GifDecoder;

    const-class v8, Landroid/graphics/Bitmap;

    new-instance v9, Lcom/bumptech/glide/load/resource/gif/GifFrameResourceDecoder;

    invoke-direct {v9, v13}, Lcom/bumptech/glide/load/resource/gif/GifFrameResourceDecoder;-><init>(Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;)V

    .line 520
    invoke-virtual {v1, v11, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/String;Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/net/Uri;

    const-class v8, Landroid/graphics/drawable/Drawable;

    .line 526
    move-object/from16 v11, v25

    .end local v25    # "resourceDrawableDecoder":Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;
    .local v11, "resourceDrawableDecoder":Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;
    invoke-virtual {v1, v7, v8, v11}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Landroid/net/Uri;

    const-class v8, Landroid/graphics/Bitmap;

    new-instance v9, Lcom/bumptech/glide/load/resource/bitmap/ResourceBitmapDecoder;

    invoke-direct {v9, v11, v13}, Lcom/bumptech/glide/load/resource/bitmap/ResourceBitmapDecoder;-><init>(Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;)V

    .line 527
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    new-instance v7, Lcom/bumptech/glide/load/resource/bytes/ByteBufferRewinder$Factory;

    invoke-direct {v7}, Lcom/bumptech/glide/load/resource/bytes/ByteBufferRewinder$Factory;-><init>()V

    .line 530
    invoke-virtual {v1, v7}, Lcom/bumptech/glide/Registry;->register(Lcom/bumptech/glide/load/data/DataRewinder$Factory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/File;

    const-class v8, Ljava/nio/ByteBuffer;

    new-instance v9, Lcom/bumptech/glide/load/model/ByteBufferFileLoader$Factory;

    invoke-direct {v9}, Lcom/bumptech/glide/load/model/ByteBufferFileLoader$Factory;-><init>()V

    .line 531
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/File;

    const-class v8, Ljava/io/InputStream;

    new-instance v9, Lcom/bumptech/glide/load/model/FileLoader$StreamFactory;

    invoke-direct {v9}, Lcom/bumptech/glide/load/model/FileLoader$StreamFactory;-><init>()V

    .line 532
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/File;

    const-class v8, Ljava/io/File;

    new-instance v9, Lcom/bumptech/glide/load/resource/file/FileDecoder;

    invoke-direct {v9}, Lcom/bumptech/glide/load/resource/file/FileDecoder;-><init>()V

    .line 533
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/File;

    const-class v8, Landroid/os/ParcelFileDescriptor;

    new-instance v9, Lcom/bumptech/glide/load/model/FileLoader$FileDescriptorFactory;

    invoke-direct {v9}, Lcom/bumptech/glide/load/model/FileLoader$FileDescriptorFactory;-><init>()V

    .line 534
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/io/File;

    const-class v8, Ljava/io/File;

    .line 536
    invoke-static {}, Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;->getInstance()Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;

    move-result-object v9

    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    new-instance v7, Lcom/bumptech/glide/load/data/InputStreamRewinder$Factory;

    invoke-direct {v7, v14}, Lcom/bumptech/glide/load/data/InputStreamRewinder$Factory;-><init>(Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;)V

    .line 538
    invoke-virtual {v1, v7}, Lcom/bumptech/glide/Registry;->register(Lcom/bumptech/glide/load/data/DataRewinder$Factory;)Lcom/bumptech/glide/Registry;

    .line 540
    invoke-static {}, Lcom/bumptech/glide/load/data/ParcelFileDescriptorRewinder;->isSupported()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 541
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    new-instance v7, Lcom/bumptech/glide/load/data/ParcelFileDescriptorRewinder$Factory;

    invoke-direct {v7}, Lcom/bumptech/glide/load/data/ParcelFileDescriptorRewinder$Factory;-><init>()V

    invoke-virtual {v1, v7}, Lcom/bumptech/glide/Registry;->register(Lcom/bumptech/glide/load/data/DataRewinder$Factory;)Lcom/bumptech/glide/Registry;

    .line 544
    :cond_4
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v8, Ljava/io/InputStream;

    .line 545
    move-object/from16 v10, v24

    .end local v24    # "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    .local v10, "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    invoke-virtual {v1, v7, v8, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v8, Landroid/os/ParcelFileDescriptor;

    .line 546
    move-object/from16 v9, v23

    .end local v23    # "resourceLoaderFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;
    .local v9, "resourceLoaderFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/lang/Integer;

    const-class v8, Ljava/io/InputStream;

    .line 547
    invoke-virtual {v1, v7, v8, v10}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/lang/Integer;

    const-class v8, Landroid/os/ParcelFileDescriptor;

    .line 548
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/lang/Integer;

    const-class v8, Landroid/net/Uri;

    .line 549
    move-object/from16 v9, v22

    .end local v22    # "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    .local v9, "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    .restart local v23    # "resourceLoaderFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$FileDescriptorFactory;
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v8, Landroid/content/res/AssetFileDescriptor;

    .line 550
    move-object/from16 v17, v2

    move-object/from16 v2, v18

    .end local v18    # "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    .local v2, "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    .local v17, "parcelFileDescriptorVideoDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Landroid/os/ParcelFileDescriptor;Landroid/graphics/Bitmap;>;"
    invoke-virtual {v1, v7, v8, v2}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/lang/Integer;

    const-class v8, Landroid/content/res/AssetFileDescriptor;

    .line 551
    invoke-virtual {v1, v7, v8, v2}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    sget-object v7, Ljava/lang/Integer;->TYPE:Ljava/lang/Class;

    const-class v8, Landroid/net/Uri;

    .line 552
    invoke-virtual {v1, v7, v8, v9}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v7, Ljava/lang/String;

    const-class v8, Ljava/io/InputStream;

    .end local v2    # "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    .restart local v18    # "resourceLoaderAssetFileDescriptorFactory":Lcom/bumptech/glide/load/model/ResourceLoader$AssetFileDescriptorFactory;
    new-instance v2, Lcom/bumptech/glide/load/model/DataUrlLoader$StreamFactory;

    invoke-direct {v2}, Lcom/bumptech/glide/load/model/DataUrlLoader$StreamFactory;-><init>()V

    .line 553
    invoke-virtual {v1, v7, v8, v2}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v7, Ljava/io/InputStream;

    new-instance v8, Lcom/bumptech/glide/load/model/DataUrlLoader$StreamFactory;

    invoke-direct {v8}, Lcom/bumptech/glide/load/model/DataUrlLoader$StreamFactory;-><init>()V

    .line 554
    invoke-virtual {v1, v2, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Ljava/lang/String;

    const-class v7, Ljava/io/InputStream;

    new-instance v8, Lcom/bumptech/glide/load/model/StringLoader$StreamFactory;

    invoke-direct {v8}, Lcom/bumptech/glide/load/model/StringLoader$StreamFactory;-><init>()V

    .line 555
    invoke-virtual {v1, v2, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Ljava/lang/String;

    const-class v7, Landroid/os/ParcelFileDescriptor;

    new-instance v8, Lcom/bumptech/glide/load/model/StringLoader$FileDescriptorFactory;

    invoke-direct {v8}, Lcom/bumptech/glide/load/model/StringLoader$FileDescriptorFactory;-><init>()V

    .line 556
    invoke-virtual {v1, v2, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Ljava/lang/String;

    const-class v7, Landroid/content/res/AssetFileDescriptor;

    new-instance v8, Lcom/bumptech/glide/load/model/StringLoader$AssetFileDescriptorFactory;

    invoke-direct {v8}, Lcom/bumptech/glide/load/model/StringLoader$AssetFileDescriptorFactory;-><init>()V

    .line 557
    invoke-virtual {v1, v2, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v7, Ljava/io/InputStream;

    new-instance v8, Lcom/bumptech/glide/load/model/AssetUriLoader$StreamFactory;

    .line 559
    move-object/from16 v22, v3

    .end local v3    # "byteBufferGifDecoder":Lcom/bumptech/glide/load/resource/gif/ByteBufferGifDecoder;
    .local v22, "byteBufferGifDecoder":Lcom/bumptech/glide/load/resource/gif/ByteBufferGifDecoder;
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    invoke-direct {v8, v3}, Lcom/bumptech/glide/load/model/AssetUriLoader$StreamFactory;-><init>(Landroid/content/res/AssetManager;)V

    invoke-virtual {v1, v2, v7, v8}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Landroid/content/res/AssetFileDescriptor;

    new-instance v7, Lcom/bumptech/glide/load/model/AssetUriLoader$FileDescriptorFactory;

    .line 563
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v8

    invoke-direct {v7, v8}, Lcom/bumptech/glide/load/model/AssetUriLoader$FileDescriptorFactory;-><init>(Landroid/content/res/AssetManager;)V

    .line 560
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/stream/MediaStoreImageThumbLoader$Factory;

    move-object/from16 v8, p1

    invoke-direct {v7, v8}, Lcom/bumptech/glide/load/model/stream/MediaStoreImageThumbLoader$Factory;-><init>(Landroid/content/Context;)V

    .line 564
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/stream/MediaStoreVideoThumbLoader$Factory;

    invoke-direct {v7, v8}, Lcom/bumptech/glide/load/model/stream/MediaStoreVideoThumbLoader$Factory;-><init>(Landroid/content/Context;)V

    .line 565
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    .line 566
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x1d

    if-lt v1, v2, :cond_5

    .line 567
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v2, Landroid/net/Uri;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/stream/QMediaStoreUriLoader$InputStreamFactory;

    invoke-direct {v7, v8}, Lcom/bumptech/glide/load/model/stream/QMediaStoreUriLoader$InputStreamFactory;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    .line 569
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v2, Landroid/net/Uri;

    const-class v3, Landroid/os/ParcelFileDescriptor;

    new-instance v7, Lcom/bumptech/glide/load/model/stream/QMediaStoreUriLoader$FileDescriptorFactory;

    invoke-direct {v7, v8}, Lcom/bumptech/glide/load/model/stream/QMediaStoreUriLoader$FileDescriptorFactory;-><init>(Landroid/content/Context;)V

    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    .line 574
    :cond_5
    iget-object v1, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v2, Landroid/net/Uri;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/UriLoader$StreamFactory;

    move-object/from16 v24, v4

    move-object/from16 v4, v21

    .end local v21    # "contentResolver":Landroid/content/ContentResolver;
    .local v4, "contentResolver":Landroid/content/ContentResolver;
    .local v24, "imageHeaderParsers":Ljava/util/List;, "Ljava/util/List<Lcom/bumptech/glide/load/ImageHeaderParser;>;"
    invoke-direct {v7, v4}, Lcom/bumptech/glide/load/model/UriLoader$StreamFactory;-><init>(Landroid/content/ContentResolver;)V

    .line 575
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Landroid/os/ParcelFileDescriptor;

    new-instance v7, Lcom/bumptech/glide/load/model/UriLoader$FileDescriptorFactory;

    invoke-direct {v7, v4}, Lcom/bumptech/glide/load/model/UriLoader$FileDescriptorFactory;-><init>(Landroid/content/ContentResolver;)V

    .line 576
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Landroid/content/res/AssetFileDescriptor;

    new-instance v7, Lcom/bumptech/glide/load/model/UriLoader$AssetFileDescriptorFactory;

    invoke-direct {v7, v4}, Lcom/bumptech/glide/load/model/UriLoader$AssetFileDescriptorFactory;-><init>(Landroid/content/ContentResolver;)V

    .line 580
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/UrlUriLoader$StreamFactory;

    invoke-direct {v7}, Lcom/bumptech/glide/load/model/UrlUriLoader$StreamFactory;-><init>()V

    .line 584
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Ljava/net/URL;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/stream/UrlLoader$StreamFactory;

    invoke-direct {v7}, Lcom/bumptech/glide/load/model/stream/UrlLoader$StreamFactory;-><init>()V

    .line 585
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Ljava/io/File;

    new-instance v7, Lcom/bumptech/glide/load/model/MediaStoreFileLoader$Factory;

    invoke-direct {v7, v8}, Lcom/bumptech/glide/load/model/MediaStoreFileLoader$Factory;-><init>(Landroid/content/Context;)V

    .line 586
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Lcom/bumptech/glide/load/model/GlideUrl;

    const-class v3, Ljava/io/InputStream;

    new-instance v7, Lcom/bumptech/glide/load/model/stream/HttpGlideUrlLoader$Factory;

    invoke-direct {v7}, Lcom/bumptech/glide/load/model/stream/HttpGlideUrlLoader$Factory;-><init>()V

    .line 587
    invoke-virtual {v1, v2, v3, v7}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Ljava/nio/ByteBuffer;

    new-instance v3, Lcom/bumptech/glide/load/model/ByteArrayLoader$ByteBufferFactory;

    invoke-direct {v3}, Lcom/bumptech/glide/load/model/ByteArrayLoader$ByteBufferFactory;-><init>()V

    .line 588
    move-object/from16 v7, v16

    invoke-virtual {v1, v7, v2, v3}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Ljava/io/InputStream;

    new-instance v3, Lcom/bumptech/glide/load/model/ByteArrayLoader$StreamFactory;

    invoke-direct {v3}, Lcom/bumptech/glide/load/model/ByteArrayLoader$StreamFactory;-><init>()V

    .line 589
    invoke-virtual {v1, v7, v2, v3}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/net/Uri;

    const-class v3, Landroid/net/Uri;

    .line 590
    nop

    .end local v4    # "contentResolver":Landroid/content/ContentResolver;
    .restart local v21    # "contentResolver":Landroid/content/ContentResolver;
    invoke-static {}, Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;->getInstance()Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/graphics/drawable/Drawable;

    const-class v3, Landroid/graphics/drawable/Drawable;

    .line 591
    invoke-static {}, Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;->getInstance()Lcom/bumptech/glide/load/model/UnitModelLoader$Factory;

    move-result-object v4

    invoke-virtual {v1, v2, v3, v4}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/model/ModelLoaderFactory;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/graphics/drawable/Drawable;

    const-class v3, Landroid/graphics/drawable/Drawable;

    new-instance v4, Lcom/bumptech/glide/load/resource/drawable/UnitDrawableDecoder;

    invoke-direct {v4}, Lcom/bumptech/glide/load/resource/drawable/UnitDrawableDecoder;-><init>()V

    .line 592
    invoke-virtual {v1, v2, v3, v4}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/graphics/Bitmap;

    const-class v3, Landroid/graphics/drawable/BitmapDrawable;

    new-instance v4, Lcom/bumptech/glide/load/resource/transcode/BitmapDrawableTranscoder;

    invoke-direct {v4, v6}, Lcom/bumptech/glide/load/resource/transcode/BitmapDrawableTranscoder;-><init>(Landroid/content/res/Resources;)V

    .line 594
    invoke-virtual {v1, v2, v3, v4}, Lcom/bumptech/glide/Registry;->register(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/resource/transcode/ResourceTranscoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/graphics/Bitmap;

    .line 595
    move-object/from16 v4, v19

    .end local v19    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    .local v4, "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    invoke-virtual {v1, v2, v7, v4}, Lcom/bumptech/glide/Registry;->register(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/resource/transcode/ResourceTranscoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Landroid/graphics/drawable/Drawable;

    new-instance v3, Lcom/bumptech/glide/load/resource/transcode/DrawableBytesTranscoder;

    move-object/from16 v16, v12

    move-object/from16 v12, v20

    .end local v20    # "gifDrawableBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;
    .local v12, "gifDrawableBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;
    .local v16, "bitmapEncoder":Lcom/bumptech/glide/load/resource/bitmap/BitmapEncoder;
    invoke-direct {v3, v13, v4, v12}, Lcom/bumptech/glide/load/resource/transcode/DrawableBytesTranscoder;-><init>(Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;Lcom/bumptech/glide/load/resource/transcode/ResourceTranscoder;Lcom/bumptech/glide/load/resource/transcode/ResourceTranscoder;)V

    .line 596
    invoke-virtual {v1, v2, v7, v3}, Lcom/bumptech/glide/Registry;->register(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/resource/transcode/ResourceTranscoder;)Lcom/bumptech/glide/Registry;

    move-result-object v1

    const-class v2, Lcom/bumptech/glide/load/resource/gif/GifDrawable;

    .line 601
    invoke-virtual {v1, v2, v7, v12}, Lcom/bumptech/glide/Registry;->register(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/resource/transcode/ResourceTranscoder;)Lcom/bumptech/glide/Registry;

    .line 603
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x17

    if-lt v1, v2, :cond_6

    .line 604
    nop

    .line 605
    invoke-static/range {p4 .. p4}, Lcom/bumptech/glide/load/resource/bitmap/VideoDecoder;->byteBuffer(Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;)Lcom/bumptech/glide/load/ResourceDecoder;

    move-result-object v1

    .line 606
    .local v1, "byteBufferVideoDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    iget-object v2, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v3, Ljava/nio/ByteBuffer;

    const-class v7, Landroid/graphics/Bitmap;

    invoke-virtual {v2, v3, v7, v1}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    .line 607
    iget-object v2, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    const-class v3, Ljava/nio/ByteBuffer;

    const-class v7, Landroid/graphics/drawable/BitmapDrawable;

    move-object/from16 v19, v4

    .end local v4    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    .restart local v19    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    new-instance v4, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;

    invoke-direct {v4, v6, v1}, Lcom/bumptech/glide/load/resource/bitmap/BitmapDrawableDecoder;-><init>(Landroid/content/res/Resources;Lcom/bumptech/glide/load/ResourceDecoder;)V

    invoke-virtual {v2, v3, v7, v4}, Lcom/bumptech/glide/Registry;->append(Ljava/lang/Class;Ljava/lang/Class;Lcom/bumptech/glide/load/ResourceDecoder;)Lcom/bumptech/glide/Registry;

    goto :goto_2

    .line 603
    .end local v1    # "byteBufferVideoDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/nio/ByteBuffer;Landroid/graphics/Bitmap;>;"
    .end local v19    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    .restart local v4    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    :cond_6
    move-object/from16 v19, v4

    .line 613
    .end local v4    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    .restart local v19    # "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    :goto_2
    new-instance v1, Lcom/bumptech/glide/request/target/ImageViewTargetFactory;

    invoke-direct {v1}, Lcom/bumptech/glide/request/target/ImageViewTargetFactory;-><init>()V

    move-object/from16 v20, v5

    .end local v5    # "streamBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/io/InputStream;Landroid/graphics/Bitmap;>;"
    .local v20, "streamBitmapDecoder":Lcom/bumptech/glide/load/ResourceDecoder;, "Lcom/bumptech/glide/load/ResourceDecoder<Ljava/io/InputStream;Landroid/graphics/Bitmap;>;"
    move-object v5, v1

    .line 614
    .local v5, "imageViewTargetFactory":Lcom/bumptech/glide/request/target/ImageViewTargetFactory;
    new-instance v7, Lcom/bumptech/glide/GlideContext;

    iget-object v4, v0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    move-object v1, v7

    move-object/from16 v2, p1

    move-object/from16 v3, p5

    move-object/from16 v31, v24

    move-object/from16 v24, v19

    move-object/from16 v19, v31

    .local v19, "imageHeaderParsers":Ljava/util/List;, "Ljava/util/List<Lcom/bumptech/glide/load/ImageHeaderParser;>;"
    .local v24, "bitmapBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/BitmapBytesTranscoder;
    move-object/from16 v25, v6

    .end local v6    # "resources":Landroid/content/res/Resources;
    .local v25, "resources":Landroid/content/res/Resources;
    move-object/from16 v6, p9

    move-object/from16 v27, v12

    move-object v12, v7

    .end local v12    # "gifDrawableBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;
    .local v27, "gifDrawableBytesTranscoder":Lcom/bumptech/glide/load/resource/transcode/GifDrawableBytesTranscoder;
    move-object/from16 v7, p10

    move-object/from16 v8, p11

    move-object/from16 v28, v9

    .end local v9    # "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    .local v28, "resourceLoaderUriFactory":Lcom/bumptech/glide/load/model/ResourceLoader$UriFactory;
    move-object/from16 v9, p2

    move-object/from16 v29, v10

    .end local v10    # "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    .local v29, "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    move-object/from16 v10, p12

    move-object/from16 v30, v29

    move-object/from16 v29, v11

    .end local v11    # "resourceDrawableDecoder":Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;
    .local v29, "resourceDrawableDecoder":Lcom/bumptech/glide/load/resource/drawable/ResourceDrawableDecoder;
    .local v30, "resourceLoaderStreamFactory":Lcom/bumptech/glide/load/model/ResourceLoader$StreamFactory;
    move/from16 v11, p8

    invoke-direct/range {v1 .. v11}, Lcom/bumptech/glide/GlideContext;-><init>(Landroid/content/Context;Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;Lcom/bumptech/glide/Registry;Lcom/bumptech/glide/request/target/ImageViewTargetFactory;Lcom/bumptech/glide/Glide$RequestOptionsFactory;Ljava/util/Map;Ljava/util/List;Lcom/bumptech/glide/load/engine/Engine;Lcom/bumptech/glide/GlideExperiments;I)V

    iput-object v12, v0, Lcom/bumptech/glide/Glide;->glideContext:Lcom/bumptech/glide/GlideContext;

    .line 626
    return-void
.end method

.method private static checkAndInitializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GeneratedAppGlideModule;)V
    .locals 2
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "generatedAppGlideModule"    # Lcom/bumptech/glide/GeneratedAppGlideModule;

    .line 206
    sget-boolean v0, Lcom/bumptech/glide/Glide;->isInitializing:Z

    if-nez v0, :cond_0

    .line 211
    const/4 v0, 0x1

    sput-boolean v0, Lcom/bumptech/glide/Glide;->isInitializing:Z

    .line 212
    invoke-static {p0, p1}, Lcom/bumptech/glide/Glide;->initializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GeneratedAppGlideModule;)V

    .line 213
    const/4 v0, 0x0

    sput-boolean v0, Lcom/bumptech/glide/Glide;->isInitializing:Z

    .line 214
    return-void

    .line 207
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "You cannot call Glide.get() in registerComponents(), use the provided Glide instance instead"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static enableHardwareBitmaps()V
    .locals 1

    .line 251
    invoke-static {}, Lcom/bumptech/glide/load/resource/bitmap/HardwareConfigState;->getInstance()Lcom/bumptech/glide/load/resource/bitmap/HardwareConfigState;

    move-result-object v0

    invoke-virtual {v0}, Lcom/bumptech/glide/load/resource/bitmap/HardwareConfigState;->unblockHardwareBitmaps()V

    .line 252
    return-void
.end method

.method public static get(Landroid/content/Context;)Lcom/bumptech/glide/Glide;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 188
    sget-object v0, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    if-nez v0, :cond_1

    .line 189
    nop

    .line 190
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/Glide;->getAnnotationGeneratedGlideModules(Landroid/content/Context;)Lcom/bumptech/glide/GeneratedAppGlideModule;

    move-result-object v0

    .line 191
    .local v0, "annotationGeneratedModule":Lcom/bumptech/glide/GeneratedAppGlideModule;
    const-class v1, Lcom/bumptech/glide/Glide;

    monitor-enter v1

    .line 192
    :try_start_0
    sget-object v2, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    if-nez v2, :cond_0

    .line 193
    invoke-static {p0, v0}, Lcom/bumptech/glide/Glide;->checkAndInitializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GeneratedAppGlideModule;)V

    .line 195
    :cond_0
    monitor-exit v1

    goto :goto_0

    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2

    .line 198
    .end local v0    # "annotationGeneratedModule":Lcom/bumptech/glide/GeneratedAppGlideModule;
    :cond_1
    :goto_0
    sget-object v0, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    return-object v0
.end method

.method private static getAnnotationGeneratedGlideModules(Landroid/content/Context;)Lcom/bumptech/glide/GeneratedAppGlideModule;
    .locals 6
    .param p0, "context"    # Landroid/content/Context;

    .line 340
    const/4 v0, 0x0

    .line 342
    .local v0, "result":Lcom/bumptech/glide/GeneratedAppGlideModule;
    :try_start_0
    const-string v1, "com.bumptech.glide.GeneratedAppGlideModuleImpl"

    .line 344
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    .line 345
    .local v1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<Lcom/bumptech/glide/GeneratedAppGlideModule;>;"
    const/4 v2, 0x1

    new-array v3, v2, [Ljava/lang/Class;

    const-class v4, Landroid/content/Context;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    .line 346
    invoke-virtual {v1, v3}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v3

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    aput-object v4, v2, v5

    invoke-virtual {v3, v2}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/bumptech/glide/GeneratedAppGlideModule;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v2

    .line 365
    .end local v1    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<Lcom/bumptech/glide/GeneratedAppGlideModule;>;"
    :cond_0
    :goto_0
    goto :goto_1

    .line 363
    :catch_0
    move-exception v1

    .line 364
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-static {v1}, Lcom/bumptech/glide/Glide;->throwIncorrectGlideModule(Ljava/lang/Exception;)V

    goto :goto_1

    .line 361
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_1
    move-exception v1

    .line 362
    .local v1, "e":Ljava/lang/NoSuchMethodException;
    invoke-static {v1}, Lcom/bumptech/glide/Glide;->throwIncorrectGlideModule(Ljava/lang/Exception;)V

    .end local v1    # "e":Ljava/lang/NoSuchMethodException;
    goto :goto_0

    .line 359
    :catch_2
    move-exception v1

    .line 360
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-static {v1}, Lcom/bumptech/glide/Glide;->throwIncorrectGlideModule(Ljava/lang/Exception;)V

    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    goto :goto_0

    .line 357
    :catch_3
    move-exception v1

    .line 358
    .local v1, "e":Ljava/lang/InstantiationException;
    invoke-static {v1}, Lcom/bumptech/glide/Glide;->throwIncorrectGlideModule(Ljava/lang/Exception;)V

    .end local v1    # "e":Ljava/lang/InstantiationException;
    goto :goto_0

    .line 347
    :catch_4
    move-exception v1

    .line 348
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    const/4 v2, 0x5

    const-string v3, "Glide"

    invoke-static {v3, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 349
    const-string v2, "Failed to find GeneratedAppGlideModule. You should include an annotationProcessor compile dependency on com.github.bumptech.glide:compiler in your application and a @GlideModule annotated AppGlideModule implementation or LibraryGlideModules will be silently ignored"

    invoke-static {v3, v2}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .line 366
    .end local v1    # "e":Ljava/lang/ClassNotFoundException;
    :goto_1
    return-object v0
.end method

.method public static getPhotoCacheDir(Landroid/content/Context;)Ljava/io/File;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 151
    const-string v0, "image_manager_disk_cache"

    invoke-static {p0, v0}, Lcom/bumptech/glide/Glide;->getPhotoCacheDir(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;

    move-result-object v0

    return-object v0
.end method

.method public static getPhotoCacheDir(Landroid/content/Context;Ljava/lang/String;)Ljava/io/File;
    .locals 4
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "cacheName"    # Ljava/lang/String;

    .line 164
    invoke-virtual {p0}, Landroid/content/Context;->getCacheDir()Ljava/io/File;

    move-result-object v0

    .line 165
    .local v0, "cacheDir":Ljava/io/File;
    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 166
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v0, p1}, Ljava/io/File;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 167
    .local v2, "result":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-nez v3, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_0

    .line 171
    :cond_0
    return-object v1

    .line 168
    :cond_1
    :goto_0
    return-object v2

    .line 173
    .end local v2    # "result":Ljava/io/File;
    :cond_2
    const/4 v2, 0x6

    const-string v3, "Glide"

    invoke-static {v3, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 174
    const-string v2, "default disk cache dir is null"

    invoke-static {v3, v2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    :cond_3
    return-object v1
.end method

.method private static getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 786
    const-string v0, "You cannot start a load on a not yet attached View or a Fragment where getActivity() returns null (which usually occurs when getActivity() is called before the Fragment is attached or after the Fragment is destroyed)."

    invoke-static {p0, v0}, Lcom/bumptech/glide/util/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    .line 791
    invoke-static {p0}, Lcom/bumptech/glide/Glide;->get(Landroid/content/Context;)Lcom/bumptech/glide/Glide;

    move-result-object v0

    invoke-virtual {v0}, Lcom/bumptech/glide/Glide;->getRequestManagerRetriever()Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    return-object v0
.end method

.method public static init(Landroid/content/Context;Lcom/bumptech/glide/GlideBuilder;)V
    .locals 3
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "builder"    # Lcom/bumptech/glide/GlideBuilder;

    .line 232
    invoke-static {p0}, Lcom/bumptech/glide/Glide;->getAnnotationGeneratedGlideModules(Landroid/content/Context;)Lcom/bumptech/glide/GeneratedAppGlideModule;

    move-result-object v0

    .line 233
    .local v0, "annotationGeneratedModule":Lcom/bumptech/glide/GeneratedAppGlideModule;
    const-class v1, Lcom/bumptech/glide/Glide;

    monitor-enter v1

    .line 234
    :try_start_0
    sget-object v2, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    if-eqz v2, :cond_0

    .line 235
    invoke-static {}, Lcom/bumptech/glide/Glide;->tearDown()V

    .line 237
    :cond_0
    invoke-static {p0, p1, v0}, Lcom/bumptech/glide/Glide;->initializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GlideBuilder;Lcom/bumptech/glide/GeneratedAppGlideModule;)V

    .line 238
    monitor-exit v1

    .line 239
    return-void

    .line 238
    :catchall_0
    move-exception v2

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v2
.end method

.method public static declared-synchronized init(Lcom/bumptech/glide/Glide;)V
    .locals 2
    .param p0, "glide"    # Lcom/bumptech/glide/Glide;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    const-class v0, Lcom/bumptech/glide/Glide;

    monitor-enter v0

    .line 224
    :try_start_0
    sget-object v1, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    if-eqz v1, :cond_0

    .line 225
    invoke-static {}, Lcom/bumptech/glide/Glide;->tearDown()V

    .line 227
    :cond_0
    sput-object p0, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 228
    monitor-exit v0

    return-void

    .line 223
    .end local p0    # "glide":Lcom/bumptech/glide/Glide;
    :catchall_0
    move-exception p0

    monitor-exit v0

    throw p0
.end method

.method private static initializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GeneratedAppGlideModule;)V
    .locals 1
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "generatedAppGlideModule"    # Lcom/bumptech/glide/GeneratedAppGlideModule;

    .line 268
    new-instance v0, Lcom/bumptech/glide/GlideBuilder;

    invoke-direct {v0}, Lcom/bumptech/glide/GlideBuilder;-><init>()V

    invoke-static {p0, v0, p1}, Lcom/bumptech/glide/Glide;->initializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GlideBuilder;Lcom/bumptech/glide/GeneratedAppGlideModule;)V

    .line 269
    return-void
.end method

.method private static initializeGlide(Landroid/content/Context;Lcom/bumptech/glide/GlideBuilder;Lcom/bumptech/glide/GeneratedAppGlideModule;)V
    .locals 9
    .param p0, "context"    # Landroid/content/Context;
    .param p1, "builder"    # Lcom/bumptech/glide/GlideBuilder;
    .param p2, "annotationGeneratedModule"    # Lcom/bumptech/glide/GeneratedAppGlideModule;

    .line 277
    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    .line 278
    .local v0, "applicationContext":Landroid/content/Context;
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v1

    .line 279
    .local v1, "manifestModules":Ljava/util/List;, "Ljava/util/List<Lcom/bumptech/glide/module/GlideModule;>;"
    if-eqz p2, :cond_0

    invoke-virtual {p2}, Lcom/bumptech/glide/GeneratedAppGlideModule;->isManifestParsingEnabled()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 280
    :cond_0
    new-instance v2, Lcom/bumptech/glide/module/ManifestParser;

    invoke-direct {v2, v0}, Lcom/bumptech/glide/module/ManifestParser;-><init>(Landroid/content/Context;)V

    invoke-virtual {v2}, Lcom/bumptech/glide/module/ManifestParser;->parse()Ljava/util/List;

    move-result-object v1

    .line 283
    :cond_1
    const/4 v2, 0x3

    const-string v3, "Glide"

    if-eqz p2, :cond_4

    .line 284
    invoke-virtual {p2}, Lcom/bumptech/glide/GeneratedAppGlideModule;->getExcludedModuleClasses()Ljava/util/Set;

    move-result-object v4

    invoke-interface {v4}, Ljava/util/Set;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_4

    .line 285
    invoke-virtual {p2}, Lcom/bumptech/glide/GeneratedAppGlideModule;->getExcludedModuleClasses()Ljava/util/Set;

    move-result-object v4

    .line 286
    .local v4, "excludedModuleClasses":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/Class<*>;>;"
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v5

    .line 287
    .local v5, "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/bumptech/glide/module/GlideModule;>;"
    :goto_0
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_4

    .line 288
    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lcom/bumptech/glide/module/GlideModule;

    .line 289
    .local v6, "current":Lcom/bumptech/glide/module/GlideModule;
    invoke-virtual {v6}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-interface {v4, v7}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v7

    if-nez v7, :cond_2

    .line 290
    goto :goto_0

    .line 292
    :cond_2
    invoke-static {v3, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v7

    if-eqz v7, :cond_3

    .line 293
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "AppGlideModule excludes manifest GlideModule: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v3, v7}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 295
    :cond_3
    invoke-interface {v5}, Ljava/util/Iterator;->remove()V

    .line 296
    .end local v6    # "current":Lcom/bumptech/glide/module/GlideModule;
    goto :goto_0

    .line 299
    .end local v4    # "excludedModuleClasses":Ljava/util/Set;, "Ljava/util/Set<Ljava/lang/Class<*>;>;"
    .end local v5    # "iterator":Ljava/util/Iterator;, "Ljava/util/Iterator<Lcom/bumptech/glide/module/GlideModule;>;"
    :cond_4
    invoke-static {v3, v2}, Landroid/util/Log;->isLoggable(Ljava/lang/String;I)Z

    move-result v2

    if-eqz v2, :cond_5

    .line 300
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_5

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/bumptech/glide/module/GlideModule;

    .line 301
    .local v4, "glideModule":Lcom/bumptech/glide/module/GlideModule;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "Discovered GlideModule from manifest: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v5}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 302
    .end local v4    # "glideModule":Lcom/bumptech/glide/module/GlideModule;
    goto :goto_1

    .line 306
    :cond_5
    if-eqz p2, :cond_6

    .line 307
    invoke-virtual {p2}, Lcom/bumptech/glide/GeneratedAppGlideModule;->getRequestManagerFactory()Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;

    move-result-object v2

    goto :goto_2

    .line 308
    :cond_6
    const/4 v2, 0x0

    :goto_2
    nop

    .line 309
    .local v2, "factory":Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;
    invoke-virtual {p1, v2}, Lcom/bumptech/glide/GlideBuilder;->setRequestManagerFactory(Lcom/bumptech/glide/manager/RequestManagerRetriever$RequestManagerFactory;)V

    .line 310
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :goto_3
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/bumptech/glide/module/GlideModule;

    .line 311
    .local v4, "module":Lcom/bumptech/glide/module/GlideModule;
    invoke-interface {v4, v0, p1}, Lcom/bumptech/glide/module/GlideModule;->applyOptions(Landroid/content/Context;Lcom/bumptech/glide/GlideBuilder;)V

    .line 312
    .end local v4    # "module":Lcom/bumptech/glide/module/GlideModule;
    goto :goto_3

    .line 313
    :cond_7
    if-eqz p2, :cond_8

    .line 314
    invoke-virtual {p2, v0, p1}, Lcom/bumptech/glide/GeneratedAppGlideModule;->applyOptions(Landroid/content/Context;Lcom/bumptech/glide/GlideBuilder;)V

    .line 316
    :cond_8
    invoke-virtual {p1, v0}, Lcom/bumptech/glide/GlideBuilder;->build(Landroid/content/Context;)Lcom/bumptech/glide/Glide;

    move-result-object v3

    .line 317
    .local v3, "glide":Lcom/bumptech/glide/Glide;
    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_4
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_9

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lcom/bumptech/glide/module/GlideModule;

    .line 319
    .local v5, "module":Lcom/bumptech/glide/module/GlideModule;
    :try_start_0
    iget-object v6, v3, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    invoke-interface {v5, v0, v3, v6}, Lcom/bumptech/glide/module/GlideModule;->registerComponents(Landroid/content/Context;Lcom/bumptech/glide/Glide;Lcom/bumptech/glide/Registry;)V
    :try_end_0
    .catch Ljava/lang/AbstractMethodError; {:try_start_0 .. :try_end_0} :catch_0

    .line 328
    nop

    .line 329
    .end local v5    # "module":Lcom/bumptech/glide/module/GlideModule;
    goto :goto_4

    .line 320
    .restart local v5    # "module":Lcom/bumptech/glide/module/GlideModule;
    :catch_0
    move-exception v4

    .line 321
    .local v4, "e":Ljava/lang/AbstractMethodError;
    new-instance v6, Ljava/lang/IllegalStateException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Attempting to register a Glide v3 module. If you see this, you or one of your dependencies may be including Glide v3 even though you\'re using Glide v4. You\'ll need to find and remove (or update) the offending dependency. The v3 module name is: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 326
    invoke-virtual {v5}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v6

    .line 330
    .end local v4    # "e":Ljava/lang/AbstractMethodError;
    .end local v5    # "module":Lcom/bumptech/glide/module/GlideModule;
    :cond_9
    if-eqz p2, :cond_a

    .line 331
    iget-object v4, v3, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    invoke-virtual {p2, v0, v3, v4}, Lcom/bumptech/glide/GeneratedAppGlideModule;->registerComponents(Landroid/content/Context;Lcom/bumptech/glide/Glide;Lcom/bumptech/glide/Registry;)V

    .line 333
    :cond_a
    invoke-virtual {v0, v3}, Landroid/content/Context;->registerComponentCallbacks(Landroid/content/ComponentCallbacks;)V

    .line 334
    sput-object v3, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    .line 335
    return-void
.end method

.method public static tearDown()V
    .locals 3

    .line 256
    const-class v0, Lcom/bumptech/glide/Glide;

    monitor-enter v0

    .line 257
    :try_start_0
    sget-object v1, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    if-eqz v1, :cond_0

    .line 258
    sget-object v1, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    invoke-virtual {v1}, Lcom/bumptech/glide/Glide;->getContext()Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    sget-object v2, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    invoke-virtual {v1, v2}, Landroid/content/Context;->unregisterComponentCallbacks(Landroid/content/ComponentCallbacks;)V

    .line 259
    sget-object v1, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    iget-object v1, v1, Lcom/bumptech/glide/Glide;->engine:Lcom/bumptech/glide/load/engine/Engine;

    invoke-virtual {v1}, Lcom/bumptech/glide/load/engine/Engine;->shutdown()V

    .line 261
    :cond_0
    const/4 v1, 0x0

    sput-object v1, Lcom/bumptech/glide/Glide;->glide:Lcom/bumptech/glide/Glide;

    .line 262
    monitor-exit v0

    .line 263
    return-void

    .line 262
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method private static throwIncorrectGlideModule(Ljava/lang/Exception;)V
    .locals 2
    .param p0, "e"    # Ljava/lang/Exception;

    .line 370
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "GeneratedAppGlideModuleImpl is implemented incorrectly. If you\'ve manually implemented this class, remove your implementation. The Annotation processor will generate a correct implementation."

    invoke-direct {v0, v1, p0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0
.end method

.method public static with(Landroid/app/Activity;)Lcom/bumptech/glide/RequestManager;
    .locals 1
    .param p0, "activity"    # Landroid/app/Activity;

    .line 830
    invoke-static {p0}, Lcom/bumptech/glide/Glide;->getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/app/Activity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0
.end method

.method public static with(Landroid/app/Fragment;)Lcom/bumptech/glide/RequestManager;
    .locals 1
    .param p0, "fragment"    # Landroid/app/Fragment;
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 872
    invoke-virtual {p0}, Landroid/app/Fragment;->getActivity()Landroid/app/Activity;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/Glide;->getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/app/Fragment;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0
.end method

.method public static with(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;
    .locals 1
    .param p0, "context"    # Landroid/content/Context;

    .line 818
    invoke-static {p0}, Lcom/bumptech/glide/Glide;->getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/content/Context;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0
.end method

.method public static with(Landroid/view/View;)Lcom/bumptech/glide/RequestManager;
    .locals 1
    .param p0, "view"    # Landroid/view/View;

    .line 902
    invoke-virtual {p0}, Landroid/view/View;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/Glide;->getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroid/view/View;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0
.end method

.method public static with(Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/RequestManager;
    .locals 1
    .param p0, "fragment"    # Landroidx/fragment/app/Fragment;

    .line 855
    invoke-virtual {p0}, Landroidx/fragment/app/Fragment;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lcom/bumptech/glide/Glide;->getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroidx/fragment/app/Fragment;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0
.end method

.method public static with(Landroidx/fragment/app/FragmentActivity;)Lcom/bumptech/glide/RequestManager;
    .locals 1
    .param p0, "activity"    # Landroidx/fragment/app/FragmentActivity;

    .line 843
    invoke-static {p0}, Lcom/bumptech/glide/Glide;->getRetriever(Landroid/content/Context;)Lcom/bumptech/glide/manager/RequestManagerRetriever;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/bumptech/glide/manager/RequestManagerRetriever;->get(Landroidx/fragment/app/FragmentActivity;)Lcom/bumptech/glide/RequestManager;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public clearDiskCache()V
    .locals 1

    .line 747
    invoke-static {}, Lcom/bumptech/glide/util/Util;->assertBackgroundThread()V

    .line 748
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->engine:Lcom/bumptech/glide/load/engine/Engine;

    invoke-virtual {v0}, Lcom/bumptech/glide/load/engine/Engine;->clearDiskCache()V

    .line 749
    return-void
.end method

.method public clearMemory()V
    .locals 1

    .line 711
    invoke-static {}, Lcom/bumptech/glide/util/Util;->assertMainThread()V

    .line 713
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->memoryCache:Lcom/bumptech/glide/load/engine/cache/MemoryCache;

    invoke-interface {v0}, Lcom/bumptech/glide/load/engine/cache/MemoryCache;->clearMemory()V

    .line 714
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

    invoke-interface {v0}, Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;->clearMemory()V

    .line 715
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->arrayPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;

    invoke-interface {v0}, Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;->clearMemory()V

    .line 716
    return-void
.end method

.method public getArrayPool()Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;
    .locals 1

    .line 653
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->arrayPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;

    return-object v0
.end method

.method public getBitmapPool()Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;
    .locals 1

    .line 648
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

    return-object v0
.end method

.method getConnectivityMonitorFactory()Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;
    .locals 1

    .line 663
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->connectivityMonitorFactory:Lcom/bumptech/glide/manager/ConnectivityMonitorFactory;

    return-object v0
.end method

.method public getContext()Landroid/content/Context;
    .locals 1

    .line 659
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->glideContext:Lcom/bumptech/glide/GlideContext;

    invoke-virtual {v0}, Lcom/bumptech/glide/GlideContext;->getBaseContext()Landroid/content/Context;

    move-result-object v0

    return-object v0
.end method

.method getGlideContext()Lcom/bumptech/glide/GlideContext;
    .locals 1

    .line 668
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->glideContext:Lcom/bumptech/glide/GlideContext;

    return-object v0
.end method

.method public getRegistry()Lcom/bumptech/glide/Registry;
    .locals 1

    .line 907
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->registry:Lcom/bumptech/glide/Registry;

    return-object v0
.end method

.method public getRequestManagerRetriever()Lcom/bumptech/glide/manager/RequestManagerRetriever;
    .locals 1

    .line 754
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->requestManagerRetriever:Lcom/bumptech/glide/manager/RequestManagerRetriever;

    return-object v0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .line 948
    return-void
.end method

.method public onLowMemory()V
    .locals 0

    .line 952
    invoke-virtual {p0}, Lcom/bumptech/glide/Glide;->clearMemory()V

    .line 953
    return-void
.end method

.method public onTrimMemory(I)V
    .locals 0
    .param p1, "level"    # I

    .line 942
    invoke-virtual {p0, p1}, Lcom/bumptech/glide/Glide;->trimMemory(I)V

    .line 943
    return-void
.end method

.method public varargs declared-synchronized preFillBitmapPool([Lcom/bumptech/glide/load/engine/prefill/PreFillType$Builder;)V
    .locals 4
    .param p1, "bitmapAttributeBuilders"    # [Lcom/bumptech/glide/load/engine/prefill/PreFillType$Builder;

    monitor-enter p0

    .line 694
    :try_start_0
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->bitmapPreFiller:Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;

    if-nez v0, :cond_0

    .line 695
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->defaultRequestOptionsFactory:Lcom/bumptech/glide/Glide$RequestOptionsFactory;

    .line 696
    invoke-interface {v0}, Lcom/bumptech/glide/Glide$RequestOptionsFactory;->build()Lcom/bumptech/glide/request/RequestOptions;

    move-result-object v0

    invoke-virtual {v0}, Lcom/bumptech/glide/request/RequestOptions;->getOptions()Lcom/bumptech/glide/load/Options;

    move-result-object v0

    sget-object v1, Lcom/bumptech/glide/load/resource/bitmap/Downsampler;->DECODE_FORMAT:Lcom/bumptech/glide/load/Option;

    invoke-virtual {v0, v1}, Lcom/bumptech/glide/load/Options;->get(Lcom/bumptech/glide/load/Option;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/bumptech/glide/load/DecodeFormat;

    .line 697
    .local v0, "decodeFormat":Lcom/bumptech/glide/load/DecodeFormat;
    new-instance v1, Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;

    iget-object v2, p0, Lcom/bumptech/glide/Glide;->memoryCache:Lcom/bumptech/glide/load/engine/cache/MemoryCache;

    iget-object v3, p0, Lcom/bumptech/glide/Glide;->bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

    invoke-direct {v1, v2, v3, v0}, Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;-><init>(Lcom/bumptech/glide/load/engine/cache/MemoryCache;Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;Lcom/bumptech/glide/load/DecodeFormat;)V

    iput-object v1, p0, Lcom/bumptech/glide/Glide;->bitmapPreFiller:Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;

    .line 700
    .end local v0    # "decodeFormat":Lcom/bumptech/glide/load/DecodeFormat;
    .end local p0    # "this":Lcom/bumptech/glide/Glide;
    :cond_0
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->bitmapPreFiller:Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;

    invoke-virtual {v0, p1}, Lcom/bumptech/glide/load/engine/prefill/BitmapPreFiller;->preFill([Lcom/bumptech/glide/load/engine/prefill/PreFillType$Builder;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 701
    monitor-exit p0

    return-void

    .line 693
    .end local p1    # "bitmapAttributeBuilders":[Lcom/bumptech/glide/load/engine/prefill/PreFillType$Builder;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method registerRequestManager(Lcom/bumptech/glide/RequestManager;)V
    .locals 3
    .param p1, "requestManager"    # Lcom/bumptech/glide/RequestManager;

    .line 923
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    monitor-enter v0

    .line 924
    :try_start_0
    iget-object v1, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 927
    iget-object v1, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 928
    monitor-exit v0

    .line 929
    return-void

    .line 925
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "Cannot register already registered manager"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p1    # "requestManager":Lcom/bumptech/glide/RequestManager;
    throw v1

    .line 928
    .restart local p1    # "requestManager":Lcom/bumptech/glide/RequestManager;
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method

.method removeFromManagers(Lcom/bumptech/glide/request/target/Target;)Z
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/bumptech/glide/request/target/Target<",
            "*>;)Z"
        }
    .end annotation

    .line 911
    .local p1, "target":Lcom/bumptech/glide/request/target/Target;, "Lcom/bumptech/glide/request/target/Target<*>;"
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    monitor-enter v0

    .line 912
    :try_start_0
    iget-object v1, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/bumptech/glide/RequestManager;

    .line 913
    .local v2, "requestManager":Lcom/bumptech/glide/RequestManager;
    invoke-virtual {v2, p1}, Lcom/bumptech/glide/RequestManager;->untrack(Lcom/bumptech/glide/request/target/Target;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 914
    const/4 v1, 0x1

    monitor-exit v0

    return v1

    .line 916
    .end local v2    # "requestManager":Lcom/bumptech/glide/RequestManager;
    :cond_0
    goto :goto_0

    .line 917
    :cond_1
    monitor-exit v0

    .line 919
    const/4 v0, 0x0

    return v0

    .line 917
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_2

    :goto_1
    throw v1

    :goto_2
    goto :goto_1
.end method

.method public setMemoryCategory(Lcom/bumptech/glide/MemoryCategory;)Lcom/bumptech/glide/MemoryCategory;
    .locals 2
    .param p1, "memoryCategory"    # Lcom/bumptech/glide/MemoryCategory;

    .line 773
    invoke-static {}, Lcom/bumptech/glide/util/Util;->assertMainThread()V

    .line 775
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->memoryCache:Lcom/bumptech/glide/load/engine/cache/MemoryCache;

    invoke-virtual {p1}, Lcom/bumptech/glide/MemoryCategory;->getMultiplier()F

    move-result v1

    invoke-interface {v0, v1}, Lcom/bumptech/glide/load/engine/cache/MemoryCache;->setSizeMultiplier(F)V

    .line 776
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

    invoke-virtual {p1}, Lcom/bumptech/glide/MemoryCategory;->getMultiplier()F

    move-result v1

    invoke-interface {v0, v1}, Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;->setSizeMultiplier(F)V

    .line 777
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->memoryCategory:Lcom/bumptech/glide/MemoryCategory;

    .line 778
    .local v0, "oldCategory":Lcom/bumptech/glide/MemoryCategory;
    iput-object p1, p0, Lcom/bumptech/glide/Glide;->memoryCategory:Lcom/bumptech/glide/MemoryCategory;

    .line 779
    return-object v0
.end method

.method public trimMemory(I)V
    .locals 3
    .param p1, "level"    # I

    .line 725
    invoke-static {}, Lcom/bumptech/glide/util/Util;->assertMainThread()V

    .line 728
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    monitor-enter v0

    .line 729
    :try_start_0
    iget-object v1, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/bumptech/glide/RequestManager;

    .line 730
    .local v2, "manager":Lcom/bumptech/glide/RequestManager;
    invoke-virtual {v2, p1}, Lcom/bumptech/glide/RequestManager;->onTrimMemory(I)V

    .line 731
    .end local v2    # "manager":Lcom/bumptech/glide/RequestManager;
    goto :goto_0

    .line 732
    :cond_0
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 734
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->memoryCache:Lcom/bumptech/glide/load/engine/cache/MemoryCache;

    invoke-interface {v0, p1}, Lcom/bumptech/glide/load/engine/cache/MemoryCache;->trimMemory(I)V

    .line 735
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->bitmapPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;

    invoke-interface {v0, p1}, Lcom/bumptech/glide/load/engine/bitmap_recycle/BitmapPool;->trimMemory(I)V

    .line 736
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->arrayPool:Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;

    invoke-interface {v0, p1}, Lcom/bumptech/glide/load/engine/bitmap_recycle/ArrayPool;->trimMemory(I)V

    .line 737
    return-void

    .line 732
    :catchall_0
    move-exception v1

    :try_start_1
    monitor-exit v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :goto_1
    throw v1

    :goto_2
    goto :goto_1
.end method

.method unregisterRequestManager(Lcom/bumptech/glide/RequestManager;)V
    .locals 3
    .param p1, "requestManager"    # Lcom/bumptech/glide/RequestManager;

    .line 932
    iget-object v0, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    monitor-enter v0

    .line 933
    :try_start_0
    iget-object v1, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 936
    iget-object v1, p0, Lcom/bumptech/glide/Glide;->managers:Ljava/util/List;

    invoke-interface {v1, p1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    .line 937
    monitor-exit v0

    .line 938
    return-void

    .line 934
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "Cannot unregister not yet registered manager"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local p1    # "requestManager":Lcom/bumptech/glide/RequestManager;
    throw v1

    .line 937
    .restart local p1    # "requestManager":Lcom/bumptech/glide/RequestManager;
    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
