.class final Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;
.super Ljava/lang/Object;
.source "SingletonConnectivityReceiver.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitorPreApi24;,
        Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitorPostApi24;,
        Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;
    }
.end annotation


# static fields
.field private static final TAG:Ljava/lang/String; = "ConnectivityMonitor"

.field private static volatile instance:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;


# instance fields
.field private final frameworkConnectivityMonitor:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;

.field private isRegistered:Z

.field final listeners:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 4
    .param p1, "context"    # Landroid/content/Context;

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 36
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->listeners:Ljava/util/Set;

    .line 60
    new-instance v0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$1;

    invoke-direct {v0, p0, p1}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$1;-><init>(Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;Landroid/content/Context;)V

    .line 61
    invoke-static {v0}, Lcom/bumptech/glide/util/GlideSuppliers;->memorize(Lcom/bumptech/glide/util/GlideSuppliers$GlideSupplier;)Lcom/bumptech/glide/util/GlideSuppliers$GlideSupplier;

    move-result-object v0

    .line 68
    .local v0, "connectivityManager":Lcom/bumptech/glide/util/GlideSuppliers$GlideSupplier;, "Lcom/bumptech/glide/util/GlideSuppliers$GlideSupplier<Landroid/net/ConnectivityManager;>;"
    new-instance v1, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$2;

    invoke-direct {v1, p0}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$2;-><init>(Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;)V

    .line 82
    .local v1, "connectivityListener":Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;
    nop

    .line 83
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x18

    if-lt v2, v3, :cond_0

    .line 84
    new-instance v2, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitorPostApi24;

    invoke-direct {v2, v0, v1}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitorPostApi24;-><init>(Lcom/bumptech/glide/util/GlideSuppliers$GlideSupplier;Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;)V

    goto :goto_0

    .line 85
    :cond_0
    new-instance v2, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitorPreApi24;

    invoke-direct {v2, p1, v0, v1}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitorPreApi24;-><init>(Landroid/content/Context;Lcom/bumptech/glide/util/GlideSuppliers$GlideSupplier;Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;)V

    :goto_0
    iput-object v2, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->frameworkConnectivityMonitor:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;

    .line 87
    return-void
.end method

.method static get(Landroid/content/Context;)Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;
    .locals 3
    .param p0, "context"    # Landroid/content/Context;

    .line 44
    sget-object v0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->instance:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    if-nez v0, :cond_1

    .line 45
    const-class v0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    monitor-enter v0

    .line 46
    :try_start_0
    sget-object v1, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->instance:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    if-nez v1, :cond_0

    .line 47
    new-instance v1, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    invoke-virtual {p0}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-direct {v1, v2}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;-><init>(Landroid/content/Context;)V

    sput-object v1, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->instance:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    .line 49
    :cond_0
    monitor-exit v0

    goto :goto_0

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1

    .line 51
    :cond_1
    :goto_0
    sget-object v0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->instance:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    return-object v0
.end method

.method private maybeRegisterReceiver()V
    .locals 1

    .line 107
    iget-boolean v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->isRegistered:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->listeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 110
    :cond_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->frameworkConnectivityMonitor:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;

    invoke-interface {v0}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;->register()Z

    move-result v0

    iput-boolean v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->isRegistered:Z

    .line 111
    return-void

    .line 108
    :cond_1
    :goto_0
    return-void
.end method

.method private maybeUnregisterReceiver()V
    .locals 1

    .line 115
    iget-boolean v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->isRegistered:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->listeners:Ljava/util/Set;

    invoke-interface {v0}, Ljava/util/Set;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    goto :goto_0

    .line 119
    :cond_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->frameworkConnectivityMonitor:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;

    invoke-interface {v0}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver$FrameworkConnectivityMonitor;->unregister()V

    .line 120
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->isRegistered:Z

    .line 121
    return-void

    .line 116
    :cond_1
    :goto_0
    return-void
.end method

.method static reset()V
    .locals 1

    .line 56
    const/4 v0, 0x0

    sput-object v0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->instance:Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;

    .line 57
    return-void
.end method


# virtual methods
.method declared-synchronized register(Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;

    monitor-enter p0

    .line 90
    :try_start_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 91
    invoke-direct {p0}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->maybeRegisterReceiver()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 92
    monitor-exit p0

    return-void

    .line 89
    .end local p0    # "this":Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;
    .end local p1    # "listener":Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method

.method declared-synchronized unregister(Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;)V
    .locals 1
    .param p1, "listener"    # Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;

    monitor-enter p0

    .line 101
    :try_start_0
    iget-object v0, p0, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->listeners:Ljava/util/Set;

    invoke-interface {v0, p1}, Ljava/util/Set;->remove(Ljava/lang/Object;)Z

    .line 102
    invoke-direct {p0}, Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;->maybeUnregisterReceiver()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 103
    monitor-exit p0

    return-void

    .line 100
    .end local p0    # "this":Lcom/bumptech/glide/manager/SingletonConnectivityReceiver;
    .end local p1    # "listener":Lcom/bumptech/glide/manager/ConnectivityMonitor$ConnectivityListener;
    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
