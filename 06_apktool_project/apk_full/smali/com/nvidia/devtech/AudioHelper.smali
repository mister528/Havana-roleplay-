.class public Lcom/nvidia/devtech/AudioHelper;
.super Ljava/lang/Object;
.source "AudioHelper.java"


# static fields
.field private static final MAX_SOUND_STREAMS:I = 0xa

.field private static ResourceLocation:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "AudioHelper"

.field private static instance:Lcom/nvidia/devtech/AudioHelper;


# instance fields
.field private MusicPlayer:Landroid/media/MediaPlayer;

.field private Sounds:Landroid/media/SoundPool;

.field private context:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 37
    const-string v0, "com.nvidia.devtech.audio:raw/"

    sput-object v0, Lcom/nvidia/devtech/AudioHelper;->ResourceLocation:Ljava/lang/String;

    .line 42
    const/4 v0, 0x0

    sput-object v0, Lcom/nvidia/devtech/AudioHelper;->instance:Lcom/nvidia/devtech/AudioHelper;

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 45
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    .line 40
    iput-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    .line 41
    iput-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    .line 46
    return-void
.end method

.method public static getInstance()Lcom/nvidia/devtech/AudioHelper;
    .locals 1

    .line 87
    sget-object v0, Lcom/nvidia/devtech/AudioHelper;->instance:Lcom/nvidia/devtech/AudioHelper;

    if-nez v0, :cond_0

    .line 89
    new-instance v0, Lcom/nvidia/devtech/AudioHelper;

    invoke-direct {v0}, Lcom/nvidia/devtech/AudioHelper;-><init>()V

    sput-object v0, Lcom/nvidia/devtech/AudioHelper;->instance:Lcom/nvidia/devtech/AudioHelper;

    .line 91
    invoke-virtual {v0}, Lcom/nvidia/devtech/AudioHelper;->Initialise()V

    .line 94
    :cond_0
    sget-object v0, Lcom/nvidia/devtech/AudioHelper;->instance:Lcom/nvidia/devtech/AudioHelper;

    return-object v0
.end method


# virtual methods
.method Initialise()V
    .locals 4

    .line 50
    new-instance v0, Landroid/media/SoundPool;

    const/16 v1, 0xa

    const/4 v2, 0x3

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Landroid/media/SoundPool;-><init>(III)V

    iput-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    .line 52
    const-string v1, "AudioHelper"

    if-nez v0, :cond_0

    .line 54
    const-string v0, "failed to create soundpool instance"

    invoke-static {v1, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 57
    :cond_0
    const-string v0, "created sound pool"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    return-void
.end method

.method public LoadSound(Ljava/lang/String;I)I
    .locals 5
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "Priority"    # I

    .line 101
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "Load sound "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const-string v1, "AudioHelper"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 103
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lcom/nvidia/devtech/AudioHelper;->ResourceLocation:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 105
    .local v0, "s":Ljava/lang/String;
    iget-object v2, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    invoke-virtual {v2}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2, v0, v3, v3}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 107
    .local v2, "resID":I
    if-nez v2, :cond_0

    .line 109
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unidentified resource id for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 111
    const/4 v1, 0x0

    return v1

    .line 114
    :cond_0
    iget-object v1, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    iget-object v3, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    invoke-virtual {v1, v3, v2, p2}, Landroid/media/SoundPool;->load(Landroid/content/Context;II)I

    move-result v1

    .line 116
    .local v1, "SoundID":I
    return v1
.end method

.method public LoadSoundAsset(Ljava/lang/String;I)I
    .locals 2
    .param p1, "filename"    # Ljava/lang/String;
    .param p2, "Priority"    # I

    .line 123
    const/4 v0, 0x0

    .line 127
    .local v0, "FD":Landroid/content/res/AssetFileDescriptor;
    :try_start_0
    iget-object v1, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v1

    invoke-virtual {v1, p1}, Landroid/content/res/AssetManager;->openFd(Ljava/lang/String;)Landroid/content/res/AssetFileDescriptor;

    move-result-object v1
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 132
    goto :goto_0

    .line 129
    :catch_0
    move-exception v1

    .line 131
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 134
    .end local v1    # "e":Ljava/io/IOException;
    :goto_0
    iget-object v1, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    invoke-virtual {v1, v0, p2}, Landroid/media/SoundPool;->load(Landroid/content/res/AssetFileDescriptor;I)I

    move-result v1

    .line 136
    .local v1, "SoundID":I
    return v1
.end method

.method public MusicSetDataSource(Ljava/lang/String;)V
    .locals 5
    .param p1, "filename"    # Ljava/lang/String;

    .line 173
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lcom/nvidia/devtech/AudioHelper;->ResourceLocation:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 175
    .local v0, "s":Ljava/lang/String;
    iget-object v1, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v0, v2, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1
    :try_end_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_0 .. :try_end_0} :catch_0

    .line 177
    .local v1, "resID":I
    const-string v2, "AudioHelper"

    if-nez v1, :cond_0

    .line 179
    :try_start_1
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "unidentified resource id for "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 181
    return-void

    .line 184
    :cond_0
    iget-object v3, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    invoke-static {v3, v1}, Landroid/media/MediaPlayer;->create(Landroid/content/Context;I)Landroid/media/MediaPlayer;

    move-result-object v3

    iput-object v3, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    .line 186
    if-nez v3, :cond_1

    .line 188
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "failed to create music player"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v2, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 190
    return-void

    .line 193
    :cond_1
    invoke-virtual {v3}, Landroid/media/MediaPlayer;->start()V
    :try_end_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/IllegalStateException; {:try_start_1 .. :try_end_1} :catch_0

    .end local v0    # "s":Ljava/lang/String;
    .end local v1    # "resID":I
    goto :goto_0

    .line 199
    :catch_0
    move-exception v0

    .line 201
    .local v0, "e":Ljava/lang/IllegalStateException;
    invoke-virtual {v0}, Ljava/lang/IllegalStateException;->printStackTrace()V

    goto :goto_1

    .line 195
    .end local v0    # "e":Ljava/lang/IllegalStateException;
    :catch_1
    move-exception v0

    .line 197
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    invoke-virtual {v0}, Ljava/lang/IllegalArgumentException;->printStackTrace()V

    .line 202
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :goto_0
    nop

    .line 203
    :goto_1
    return-void
.end method

.method public MusicStart()V
    .locals 1

    .line 207
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->start()V

    .line 208
    return-void
.end method

.method public MusicStop()V
    .locals 1

    .line 225
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->isPlaying()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 227
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->stop()V

    .line 228
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0}, Landroid/media/MediaPlayer;->reset()V

    .line 230
    :cond_0
    return-void
.end method

.method public MusicVolume(FF)V
    .locals 1
    .param p1, "VolumeL"    # F
    .param p2, "VolumeR"    # F

    .line 212
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    invoke-virtual {v0, p1, p2}, Landroid/media/MediaPlayer;->setVolume(FF)V

    .line 213
    return-void
.end method

.method public PauseSound(I)V
    .locals 1
    .param p1, "SoundID"    # I

    .line 141
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    invoke-virtual {v0, p1}, Landroid/media/SoundPool;->pause(I)V

    .line 142
    return-void
.end method

.method public PlaySound(IFFIIF)I
    .locals 7
    .param p1, "SoundID"    # I
    .param p2, "lv"    # F
    .param p3, "rv"    # F
    .param p4, "priority"    # I
    .param p5, "loop"    # I
    .param p6, "rate"    # F

    .line 156
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    move v1, p1

    move v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    invoke-virtual/range {v0 .. v6}, Landroid/media/SoundPool;->play(IFFIIF)I

    move-result v0

    return v0
.end method

.method public ResumeSound(I)V
    .locals 1
    .param p1, "SoundID"    # I

    .line 146
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    invoke-virtual {v0, p1}, Landroid/media/SoundPool;->resume(I)V

    .line 147
    return-void
.end method

.method SetMaxVolume()V
    .locals 4

    .line 217
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    const-string v1, "audio"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/media/AudioManager;

    .line 218
    .local v0, "mAudioManager":Landroid/media/AudioManager;
    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Landroid/media/AudioManager;->getStreamMaxVolume(I)I

    move-result v2

    .line 220
    .local v2, "maxVolume":I
    const/4 v3, 0x0

    invoke-virtual {v0, v1, v2, v3}, Landroid/media/AudioManager;->setStreamVolume(III)V

    .line 221
    return-void
.end method

.method public SetResouceLocation(Ljava/lang/String;)V
    .locals 0
    .param p1, "s"    # Ljava/lang/String;

    .line 77
    sput-object p1, Lcom/nvidia/devtech/AudioHelper;->ResourceLocation:Ljava/lang/String;

    .line 78
    return-void
.end method

.method public SetVolume(IFF)V
    .locals 1
    .param p1, "SoundID"    # I
    .param p2, "vl"    # F
    .param p3, "vr"    # F

    .line 161
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    invoke-virtual {v0, p1, p2, p3}, Landroid/media/SoundPool;->setVolume(IFF)V

    .line 162
    return-void
.end method

.method public StopSound(I)V
    .locals 1
    .param p1, "SoundID"    # I

    .line 151
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    invoke-virtual {v0, p1}, Landroid/media/SoundPool;->stop(I)V

    .line 152
    return-void
.end method

.method public UnloadSample(I)Z
    .locals 1
    .param p1, "SoundID"    # I

    .line 166
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    invoke-virtual {v0, p1}, Landroid/media/SoundPool;->unload(I)Z

    move-result v0

    return v0
.end method

.method public finalize()V
    .locals 2

    .line 62
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 64
    invoke-virtual {v0}, Landroid/media/SoundPool;->release()V

    .line 65
    iput-object v1, p0, Lcom/nvidia/devtech/AudioHelper;->Sounds:Landroid/media/SoundPool;

    .line 68
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    if-eqz v0, :cond_1

    .line 70
    invoke-virtual {v0}, Landroid/media/MediaPlayer;->release()V

    .line 71
    iput-object v1, p0, Lcom/nvidia/devtech/AudioHelper;->MusicPlayer:Landroid/media/MediaPlayer;

    .line 73
    :cond_1
    return-void
.end method

.method public setContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 82
    iput-object p1, p0, Lcom/nvidia/devtech/AudioHelper;->context:Landroid/content/Context;

    .line 83
    return-void
.end method
