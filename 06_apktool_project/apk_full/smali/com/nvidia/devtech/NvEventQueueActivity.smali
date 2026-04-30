.class public abstract Lcom/nvidia/devtech/NvEventQueueActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "NvEventQueueActivity.java"

# interfaces
.implements Landroid/hardware/SensorEventListener;
.implements Lcom/nvidia/devtech/InputManager$InputListener;
.implements Landroid/view/View$OnTouchListener;
.implements Lcom/nvidia/devtech/HeightProvider$HeightListener;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;,
        Lcom/nvidia/devtech/NvEventQueueActivity$RawData;
    }
.end annotation


# static fields
.field private static final EGL_CONTEXT_CLIENT_VERSION:I = 0x3098

.field private static final EGL_OPENGL_ES2_BIT:I = 0x4

.field private static final EGL_OPENGL_ES3_BIT:I = 0x40

.field private static final EGL_RENDERABLE_TYPE:I = 0x3040

.field private static instance:Lcom/nvidia/devtech/NvEventQueueActivity;


# instance fields
.field private GameIsFocused:Z

.field private HasGLExtensions:Z

.field protected ResumeEventDone:Z

.field private SwapBufferSkip:I

.field protected alphaSize:I

.field protected blueSize:I

.field protected cachedSurfaceHolder:Landroid/view/SurfaceHolder;

.field protected configAttrs:[I

.field protected contextAttrs:[I

.field protected depthSize:I

.field protected display:Landroid/view/Display;

.field egl:Ljavax/microedition/khronos/egl/EGL10;

.field protected eglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

.field protected eglContext:Ljavax/microedition/khronos/egl/EGLContext;

.field protected eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

.field protected eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

.field private fixedHeight:I

.field private fixedWidth:I

.field gl:Ljavax/microedition/khronos/opengles/GL11;

.field private glExtensions:Ljava/lang/String;

.field private glRenderer:Ljava/lang/String;

.field private glVendor:Ljava/lang/String;

.field private glVersion:Ljava/lang/String;

.field protected greenSize:I

.field protected handler:Landroid/os/Handler;

.field mAndroidUI:Landroid/widget/FrameLayout;

.field protected mClipboardManager:Landroid/content/ClipboardManager;

.field private mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

.field private mDialogClientSettings:Lcom/luxury/mobile/core/DialogClientSettings;

.field private mHeightProvider:Lcom/nvidia/devtech/HeightProvider;

.field private mHudManager:Lcom/luxury/mobile/gui/HudManager;

.field private mInputManager:Lcom/nvidia/devtech/InputManager;

.field private mRootFrame:Landroid/widget/FrameLayout;

.field protected mSensorDelay:I

.field protected mSensorManager:Landroid/hardware/SensorManager;

.field private mSpeedometer:Lcom/luxury/mobile/gui/Speedometer;

.field private mSurfaceView:Landroid/view/SurfaceView;

.field private mUseFullscreen:I

.field protected paused:Z

.field private ranInit:Z

.field protected redSize:I

.field protected stencilSize:I

.field protected supportPauseResume:Z

.field private surfaceHeight:I

.field private surfaceWidth:I

.field private viewIsActive:Z

.field protected wantsAccelerometer:Z

.field protected wantsMultitouch:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 88
    const/4 v0, 0x0

    sput-object v0, Lcom/nvidia/devtech/NvEventQueueActivity;->instance:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-void
.end method

.method public constructor <init>()V
    .locals 4

    .line 84
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    .line 89
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->handler:Landroid/os/Handler;

    .line 91
    const/4 v1, 0x0

    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->SwapBufferSkip:I

    .line 93
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->paused:Z

    .line 95
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->wantsMultitouch:Z

    .line 97
    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->supportPauseResume:Z

    .line 98
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    .line 101
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->wantsAccelerometer:Z

    .line 102
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorManager:Landroid/hardware/SensorManager;

    .line 103
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mClipboardManager:Landroid/content/ClipboardManager;

    .line 104
    iput v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorDelay:I

    .line 105
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->display:Landroid/view/Display;

    .line 107
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mAndroidUI:Landroid/widget/FrameLayout;

    .line 113
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    .line 114
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->gl:Ljavax/microedition/khronos/opengles/GL11;

    .line 116
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ranInit:Z

    .line 117
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 118
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 119
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 120
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 122
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    .line 123
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceWidth:I

    .line 124
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceHeight:I

    .line 126
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->fixedWidth:I

    .line 127
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->fixedHeight:I

    .line 128
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->HasGLExtensions:Z

    .line 129
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVendor:Ljava/lang/String;

    .line 130
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glExtensions:Ljava/lang/String;

    .line 131
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glRenderer:Ljava/lang/String;

    .line 132
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVersion:Ljava/lang/String;

    .line 133
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->GameIsFocused:Z

    .line 134
    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->viewIsActive:Z

    .line 136
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mRootFrame:Landroid/widget/FrameLayout;

    .line 137
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSurfaceView:Landroid/view/SurfaceView;

    .line 139
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mInputManager:Lcom/nvidia/devtech/InputManager;

    .line 140
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHeightProvider:Lcom/nvidia/devtech/HeightProvider;

    .line 141
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialogClientSettings:Lcom/luxury/mobile/core/DialogClientSettings;

    .line 143
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

    .line 144
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHudManager:Lcom/luxury/mobile/gui/HudManager;

    .line 145
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSpeedometer:Lcom/luxury/mobile/gui/Speedometer;

    .line 222
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mUseFullscreen:I

    .line 1065
    const/4 v2, 0x5

    iput v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->redSize:I

    .line 1067
    const/4 v3, 0x6

    iput v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->greenSize:I

    .line 1069
    iput v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->blueSize:I

    .line 1071
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->alphaSize:I

    .line 1073
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->stencilSize:I

    .line 1075
    const/16 v1, 0x10

    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->depthSize:I

    .line 1078
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1080
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->contextAttrs:[I

    return-void
.end method

.method static synthetic access$000(Lcom/nvidia/devtech/NvEventQueueActivity;)Lcom/luxury/mobile/core/DialogClientSettings;
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 84
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialogClientSettings:Lcom/luxury/mobile/core/DialogClientSettings;

    return-object v0
.end method

.method static synthetic access$002(Lcom/nvidia/devtech/NvEventQueueActivity;Lcom/luxury/mobile/core/DialogClientSettings;)Lcom/luxury/mobile/core/DialogClientSettings;
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;
    .param p1, "x1"    # Lcom/luxury/mobile/core/DialogClientSettings;

    .line 84
    iput-object p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialogClientSettings:Lcom/luxury/mobile/core/DialogClientSettings;

    return-object p1
.end method

.method static synthetic access$100(Lcom/nvidia/devtech/NvEventQueueActivity;)I
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 84
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->fixedWidth:I

    return v0
.end method

.method static synthetic access$200(Lcom/nvidia/devtech/NvEventQueueActivity;)I
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 84
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->fixedHeight:I

    return v0
.end method

.method static synthetic access$302(Lcom/nvidia/devtech/NvEventQueueActivity;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;
    .param p1, "x1"    # Z

    .line 84
    iput-boolean p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ranInit:Z

    return p1
.end method

.method static synthetic access$400(Lcom/nvidia/devtech/NvEventQueueActivity;)I
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 84
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceWidth:I

    return v0
.end method

.method static synthetic access$402(Lcom/nvidia/devtech/NvEventQueueActivity;I)I
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;
    .param p1, "x1"    # I

    .line 84
    iput p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceWidth:I

    return p1
.end method

.method static synthetic access$500(Lcom/nvidia/devtech/NvEventQueueActivity;)I
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 84
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceHeight:I

    return v0
.end method

.method static synthetic access$502(Lcom/nvidia/devtech/NvEventQueueActivity;I)I
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;
    .param p1, "x1"    # I

    .line 84
    iput p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceHeight:I

    return p1
.end method

.method static synthetic access$602(Lcom/nvidia/devtech/NvEventQueueActivity;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;
    .param p1, "x1"    # Z

    .line 84
    iput-boolean p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->viewIsActive:Z

    return p1
.end method

.method static synthetic access$700(Lcom/nvidia/devtech/NvEventQueueActivity;)Lcom/nvidia/devtech/InputManager;
    .locals 1
    .param p0, "x0"    # Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 84
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mInputManager:Lcom/nvidia/devtech/InputManager;

    return-object v0
.end method

.method public static getInstance()Lcom/nvidia/devtech/NvEventQueueActivity;
    .locals 1

    .line 1494
    sget-object v0, Lcom/nvidia/devtech/NvEventQueueActivity;->instance:Lcom/nvidia/devtech/NvEventQueueActivity;

    return-object v0
.end method

.method private native onInputEnd([B)V
.end method

.method private native onNativeHeightChanged(II)V
.end method

.method private processCutout()V
    .locals 2

    .line 226
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x1c

    if-lt v0, v1, :cond_0

    .line 228
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mUseFullscreen:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    .line 230
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getAttributes()Landroid/view/WindowManager$LayoutParams;

    move-result-object v0

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->layoutInDisplayCutoutMode:I

    .line 233
    :cond_0
    return-void
.end method


# virtual methods
.method public DoResumeEvent()V
    .locals 2

    .line 770
    new-instance v0, Ljava/lang/Thread;

    new-instance v1, Lcom/nvidia/devtech/NvEventQueueActivity$3;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$3;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-direct {v0, v1}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 780
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 781
    return-void
.end method

.method public GetGLExtensions()V
    .locals 3

    .line 1333
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->HasGLExtensions:Z

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->gl:Ljavax/microedition/khronos/opengles/GL11;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    if-eqz v1, :cond_0

    .line 1335
    const/16 v1, 0x1f00

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/opengles/GL11;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVendor:Ljava/lang/String;

    .line 1336
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->gl:Ljavax/microedition/khronos/opengles/GL11;

    const/16 v1, 0x1f03

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/opengles/GL11;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glExtensions:Ljava/lang/String;

    .line 1337
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->gl:Ljavax/microedition/khronos/opengles/GL11;

    const/16 v1, 0x1f01

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/opengles/GL11;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glRenderer:Ljava/lang/String;

    .line 1338
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->gl:Ljavax/microedition/khronos/opengles/GL11;

    const/16 v1, 0x1f02

    invoke-interface {v0, v1}, Ljavax/microedition/khronos/opengles/GL11;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVersion:Ljava/lang/String;

    .line 1339
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Vendor: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVendor:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1340
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Extensions "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glExtensions:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1341
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Renderer: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glRenderer:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1342
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GIVersion: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVersion:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1343
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVendor:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 1345
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->HasGLExtensions:Z

    .line 1348
    :cond_0
    return-void
.end method

.method public GetSurfaceView()Landroid/view/SurfaceView;
    .locals 1

    .line 946
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSurfaceView:Landroid/view/SurfaceView;

    return-object v0
.end method

.method public InitEGLAndGLES2(I)Z
    .locals 4
    .param p1, "i"    # I

    .line 888
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "lnitEGLAndGLES2"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 889
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 891
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "InitEGLAndGLES2 failed, cachedSurfaceHoIder is null"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 892
    return v1

    .line 895
    :cond_0
    const/4 v0, 0x1

    .line 896
    .local v0, "eglInitialized":Z
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    if-nez v2, :cond_1

    .line 898
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->initEGL()Z

    move-result v0

    .line 900
    :cond_1
    if-eqz v0, :cond_3

    .line 902
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "Should we create a surface?"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 903
    iget-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->viewIsActive:Z

    if-nez v1, :cond_2

    .line 905
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "Yes! Calling create surface"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 906
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    invoke-virtual {p0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->createEGLSurface(Landroid/view/SurfaceHolder;)Z

    .line 907
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "Done creating surface"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 909
    :cond_2
    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->viewIsActive:Z

    .line 910
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->SwapBufferSkip:I

    .line 918
    return v1

    .line 914
    :cond_3
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "initEGlAndGLES2 failed, core EGL init failure"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 915
    return v1
.end method

.method public OnInputEnd(Ljava/lang/String;)V
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    .line 931
    const/4 v0, 0x0

    .line 934
    .local v0, "toReturn":[B
    :try_start_0
    const-string v1, "windows-1251"

    invoke-virtual {p1, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v0, v1

    .line 939
    goto :goto_0

    .line 936
    :catch_0
    move-exception v1

    .line 941
    :goto_0
    invoke-direct {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onInputEnd([B)V

    .line 942
    return-void
.end method

.method public native accelerometerEvent(FFF)Z
.end method

.method public callLauncherActivity()V
    .locals 1

    .line 1419
    new-instance v0, Lcom/nvidia/devtech/NvEventQueueActivity$5;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$5;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1434
    return-void
.end method

.method public native changeConnection(Z)V
.end method

.method public native cleanup()V
.end method

.method protected cleanupEGL()V
    .locals 5

    .line 1254
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "cleanupEGL"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1255
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->destroyEGLSurface()V

    .line 1256
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-eqz v0, :cond_0

    .line 1257
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v0, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 1258
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    if-eqz v0, :cond_1

    .line 1259
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v1, v2, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroyContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 1260
    :cond_1
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-eqz v0, :cond_2

    .line 1261
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v1, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglTerminate(Ljavax/microedition/khronos/egl/EGLDisplay;)Z

    .line 1263
    :cond_2
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 1264
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 1265
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 1267
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ranInit:Z

    .line 1268
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    .line 1270
    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    .line 1271
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceWidth:I

    .line 1272
    iput v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceHeight:I

    .line 1273
    return-void
.end method

.method protected createEGLSurface(Landroid/view/SurfaceHolder;)Z
    .locals 7
    .param p1, "surface"    # Landroid/view/SurfaceHolder;

    .line 1212
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    const/4 v3, 0x0

    invoke-interface {v0, v1, v2, p1, v3}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateWindowSurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljava/lang/Object;[I)Ljavax/microedition/khronos/egl/EGLSurface;

    move-result-object v0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 1214
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "eglSurface: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v2, ", err: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1215
    const/4 v0, 0x1

    new-array v1, v0, [I

    .line 1217
    .local v1, "sizes":[I
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/16 v5, 0x3057

    invoke-interface {v2, v3, v4, v5, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    .line 1218
    const/4 v2, 0x0

    aget v3, v1, v2

    iput v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceWidth:I

    .line 1219
    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v5, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/16 v6, 0x3056

    invoke-interface {v3, v4, v5, v6, v1}, Ljavax/microedition/khronos/egl/EGL10;->eglQuerySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;I[I)Z

    .line 1220
    aget v2, v1, v2

    iput v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceHeight:I

    .line 1222
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "checking glVendor == null?"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1223
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->glVendor:Ljava/lang/String;

    if-nez v2, :cond_0

    .line 1224
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Making current and back"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1225
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->makeCurrent()Z

    .line 1226
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->unMakeCurrent()Z

    .line 1229
    :cond_0
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v3, "Done create EGL surface"

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1231
    return v0
.end method

.method public native customMultiTouchEvent(IIIIIIII)Z
.end method

.method protected destroyEGLSurface()V
    .locals 5

    .line 1240
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "*** destroyEGLSurface"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1241
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eqz v1, :cond_0

    .line 1242
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v1, v0, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    .line 1243
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-eqz v0, :cond_1

    .line 1244
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v1, v2, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglDestroySurface(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    .line 1245
    :cond_1
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    .line 1246
    return-void
.end method

.method public getClipboardText()[B
    .locals 3

    .line 1466
    const-string v0, " "

    .line 1468
    .local v0, "retn":Ljava/lang/String;
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mClipboardManager:Landroid/content/ClipboardManager;

    invoke-virtual {v1}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 1470
    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mClipboardManager:Landroid/content/ClipboardManager;

    invoke-virtual {v1}, Landroid/content/ClipboardManager;->getPrimaryClip()Landroid/content/ClipData;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/content/ClipData;->getItemAt(I)Landroid/content/ClipData$Item;

    move-result-object v1

    .line 1471
    .local v1, "item":Landroid/content/ClipData$Item;
    if-eqz v1, :cond_0

    .line 1473
    invoke-virtual {v1}, Landroid/content/ClipData$Item;->getText()Ljava/lang/CharSequence;

    move-result-object v2

    .line 1474
    .local v2, "sequence":Ljava/lang/CharSequence;
    if-eqz v2, :cond_0

    .line 1476
    invoke-interface {v2}, Ljava/lang/CharSequence;->toString()Ljava/lang/String;

    move-result-object v0

    .line 1481
    .end local v1    # "item":Landroid/content/ClipData$Item;
    .end local v2    # "sequence":Ljava/lang/CharSequence;
    :cond_0
    const/4 v1, 0x0

    .line 1484
    .local v1, "toReturn":[B
    :try_start_0
    const-string v2, "windows-1251"

    invoke-virtual {v0, v2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v2

    .line 1489
    goto :goto_0

    .line 1486
    :catch_0
    move-exception v2

    .line 1490
    :goto_0
    return-object v1
.end method

.method public getHudElementColor(I)Ljava/lang/String;
    .locals 4
    .param p1, "id"    # I

    .line 202
    invoke-virtual {p0, p1}, Lcom/nvidia/devtech/NvEventQueueActivity;->getNativeHudElementColor(I)[B

    move-result-object v0

    .line 203
    .local v0, "color":[B
    const/4 v1, 0x0

    .line 205
    .local v1, "str":Ljava/lang/String;
    :try_start_0
    new-instance v2, Ljava/lang/String;

    const-string v3, "windows-1251"

    invoke-direct {v2, v0, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v2

    .line 210
    goto :goto_0

    .line 207
    :catch_0
    move-exception v2

    .line 212
    :goto_0
    return-object v1
.end method

.method public native getNativeCutoutSettings()Z
.end method

.method public native getNativeDialog()Z
.end method

.method public native getNativeFpsCounterSettings()Z
.end method

.method public native getNativeHpArmourText()Z
.end method

.method public native getNativeHud()Z
.end method

.method public native getNativeHudElementColor(I)[B
.end method

.method public native getNativeHudElementPosition(I)[I
.end method

.method public native getNativeHudElementScale(I)[I
.end method

.method public native getNativeKeyboardSettings()Z
.end method

.method public native getNativeOutfitGunsSettings()Z
.end method

.method public native getNativePcMoney()Z
.end method

.method public native getNativeRadarrect()Z
.end method

.method public native getNativeSkyBox()Z
.end method

.method public native getNativeWidgetPositionAndScale(I)[I
.end method

.method public getOrientation()I
    .locals 1

    .line 1379
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->display:Landroid/view/Display;

    invoke-virtual {v0}, Landroid/view/Display;->getOrientation()I

    move-result v0

    return v0
.end method

.method public getSupportPauseResume()Z
    .locals 1

    .line 1311
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->supportPauseResume:Z

    return v0
.end method

.method public getSurfaceHeight()I
    .locals 1

    .line 1321
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceHeight:I

    return v0
.end method

.method public getSurfaceWidth()I
    .locals 1

    .line 1316
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->surfaceWidth:I

    return v0
.end method

.method public hideAllUI()V
    .locals 1

    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$FlyHideAll;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$FlyHideAll;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public hideDialogWithoutReset()V
    .locals 1

    .line 1460
    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$kV5eVLOU0dcPj5rRLEPEm10oZVA;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$kV5eVLOU0dcPj5rRLEPEm10oZVA;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public hideHud()V
    .locals 1

    .line 1503
    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$kiBKiOX3ot7vFfNG1cRG-KX2ec8;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$kiBKiOX3ot7vFfNG1cRG-KX2ec8;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public hideInputLayout()V
    .locals 1

    .line 1448
    new-instance v0, Lcom/nvidia/devtech/NvEventQueueActivity$7;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$7;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1454
    return-void
.end method

.method public hideSpeed()V
    .locals 1

    .line 1521
    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$9tMIJ8ZzfRmV97j1BaJfCJFRAGw;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$9tMIJ8ZzfRmV97j1BaJfCJFRAGw;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public hideSystemUI()V
    .locals 2

    .line 262
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    .line 263
    .local v0, "decorView":Landroid/view/View;
    const/16 v1, 0x1f06

    invoke-virtual {v0, v1}, Landroid/view/View;->setSystemUiVisibility(I)V

    .line 274
    return-void
.end method

.method public native imeClosed()V
.end method

.method public native init(Z)Z
.end method

.method protected initEGL()Z
    .locals 29

    .line 1090
    move-object/from16 v0, p0

    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    const/16 v2, 0x3038

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-nez v1, :cond_0

    .line 1091
    new-array v1, v4, [I

    aput v2, v1, v3

    iput-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1092
    :cond_0
    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1094
    .local v1, "oldConf":[I
    array-length v5, v1

    const/4 v6, 0x3

    add-int/2addr v5, v6

    sub-int/2addr v5, v4

    new-array v5, v5, [I

    iput-object v5, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1095
    const/4 v5, 0x0

    .line 1096
    .local v5, "i":I
    const/4 v5, 0x0

    :goto_0
    array-length v7, v1

    sub-int/2addr v7, v4

    if-ge v5, v7, :cond_1

    .line 1097
    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    aget v8, v1, v5

    aput v8, v7, v5

    .line 1096
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 1098
    :cond_1
    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    add-int/lit8 v8, v5, 0x1

    .end local v5    # "i":I
    .local v8, "i":I
    const/16 v9, 0x3040

    aput v9, v7, v5

    .line 1099
    add-int/lit8 v5, v8, 0x1

    .end local v8    # "i":I
    .restart local v5    # "i":I
    const/4 v9, 0x4

    aput v9, v7, v8

    .line 1100
    add-int/lit8 v8, v5, 0x1

    .end local v5    # "i":I
    .restart local v8    # "i":I
    aput v2, v7, v5

    .line 1102
    new-array v5, v6, [I

    fill-array-data v5, :array_0

    iput-object v5, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->contextAttrs:[I

    .line 1108
    if-nez v7, :cond_2

    .line 1109
    new-array v5, v4, [I

    aput v2, v5, v3

    iput-object v5, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1110
    :cond_2
    iget-object v5, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1112
    .local v5, "oldConfES2":[I
    array-length v6, v5

    add-int/lit8 v6, v6, 0xd

    sub-int/2addr v6, v4

    new-array v6, v6, [I

    iput-object v6, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    .line 1113
    const/4 v6, 0x0

    .end local v8    # "i":I
    .local v6, "i":I
    :goto_1
    array-length v7, v5

    sub-int/2addr v7, v4

    if-ge v6, v7, :cond_3

    .line 1114
    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    aget v8, v5, v6

    aput v8, v7, v6

    .line 1113
    add-int/lit8 v6, v6, 0x1

    goto :goto_1

    .line 1115
    :cond_3
    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    const/16 v9, 0x3024

    aput v9, v7, v6

    .line 1116
    add-int/lit8 v6, v8, 0x1

    .end local v8    # "i":I
    .restart local v6    # "i":I
    iget v10, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->redSize:I

    aput v10, v7, v8

    .line 1117
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    const/16 v10, 0x3023

    aput v10, v7, v6

    .line 1118
    add-int/lit8 v6, v8, 0x1

    .end local v8    # "i":I
    .restart local v6    # "i":I
    iget v11, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->greenSize:I

    aput v11, v7, v8

    .line 1119
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    const/16 v11, 0x3022

    aput v11, v7, v6

    .line 1120
    add-int/lit8 v6, v8, 0x1

    .end local v8    # "i":I
    .restart local v6    # "i":I
    iget v12, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->blueSize:I

    aput v12, v7, v8

    .line 1121
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    const/16 v12, 0x3021

    aput v12, v7, v6

    .line 1122
    add-int/lit8 v6, v8, 0x1

    .end local v8    # "i":I
    .restart local v6    # "i":I
    iget v13, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->alphaSize:I

    aput v13, v7, v8

    .line 1123
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    const/16 v13, 0x3026

    aput v13, v7, v6

    .line 1124
    add-int/lit8 v6, v8, 0x1

    .end local v8    # "i":I
    .restart local v6    # "i":I
    iget v14, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->stencilSize:I

    aput v14, v7, v8

    .line 1125
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    const/16 v14, 0x3025

    aput v14, v7, v6

    .line 1126
    add-int/lit8 v6, v8, 0x1

    .end local v8    # "i":I
    .restart local v6    # "i":I
    iget v15, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->depthSize:I

    aput v15, v7, v8

    .line 1127
    add-int/lit8 v8, v6, 0x1

    .end local v6    # "i":I
    .restart local v8    # "i":I
    aput v2, v7, v6

    .line 1129
    invoke-static {}, Ljavax/microedition/khronos/egl/EGLContext;->getEGL()Ljavax/microedition/khronos/egl/EGL;

    move-result-object v2

    check-cast v2, Ljavax/microedition/khronos/egl/EGL10;

    iput-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    .line 1130
    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    .line 1131
    iget-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    sget-object v6, Ljavax/microedition/khronos/egl/EGL10;->EGL_DEFAULT_DISPLAY:Ljava/lang/Object;

    invoke-interface {v2, v6}, Ljavax/microedition/khronos/egl/EGL10;->eglGetDisplay(Ljava/lang/Object;)Ljavax/microedition/khronos/egl/EGLDisplay;

    move-result-object v2

    iput-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    .line 1132
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "eglDisplay: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v7, ", errr: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1133
    const/4 v2, 0x2

    new-array v2, v2, [I

    .line 1134
    .local v2, "version":[I
    iget-object v6, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v6, v7, v2}, Ljavax/microedition/khronos/egl/EGL10;->eglInitialize(Ljavax/microedition/khronos/egl/EGLDisplay;[I)Z

    move-result v6

    .line 1135
    .local v6, "ret":Z
    sget-object v7, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "EGLInitialize returned: "

    invoke-virtual {v15, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v6}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v7, v13}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1136
    if-nez v6, :cond_4

    .line 1138
    return v3

    .line 1140
    :cond_4
    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v7}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v7

    .line 1141
    .local v7, "eglErr":I
    const/16 v13, 0x3000

    if-eq v7, v13, :cond_5

    .line 1142
    return v3

    .line 1143
    :cond_5
    sget-object v13, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "eglInitialize err: "

    invoke-virtual {v15, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v15, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v15}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-virtual {v13, v14}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1145
    const/16 v13, 0x14

    new-array v13, v13, [Ljavax/microedition/khronos/egl/EGLConfig;

    .line 1146
    .local v13, "config":[Ljavax/microedition/khronos/egl/EGLConfig;
    new-array v14, v4, [I

    .line 1147
    .local v14, "num_configs":[I
    iget-object v15, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v12, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v11, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    array-length v10, v13

    move-object/from16 v17, v15

    move-object/from16 v18, v12

    move-object/from16 v19, v11

    move-object/from16 v20, v13

    move/from16 v21, v10

    move-object/from16 v22, v14

    invoke-interface/range {v17 .. v22}, Ljavax/microedition/khronos/egl/EGL10;->eglChooseConfig(Ljavax/microedition/khronos/egl/EGLDisplay;[I[Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 1148
    sget-object v10, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, "eglChooseConfig err: "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v12, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v12}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1150
    const/high16 v10, 0x1000000

    .line 1151
    .local v10, "score":I
    new-array v11, v4, [I

    .line 1152
    .local v11, "val":[I
    const/4 v8, 0x0

    :goto_2
    aget v12, v14, v3

    if-ge v8, v12, :cond_c

    .line 1154
    const/4 v12, 0x1

    .line 1155
    .local v12, "cont":Z
    const/4 v15, 0x0

    .line 1157
    .local v15, "currScore":I
    const/16 v17, 0x0

    move/from16 v9, v17

    .local v9, "j":I
    :goto_3
    array-length v3, v1

    sub-int/2addr v3, v4

    shr-int/2addr v3, v4

    if-ge v9, v3, :cond_7

    .line 1159
    iget-object v3, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    move-object/from16 v20, v1

    .end local v1    # "oldConf":[I
    .local v20, "oldConf":[I
    aget-object v1, v13, v8

    move-object/from16 v21, v2

    .end local v2    # "version":[I
    .local v21, "version":[I
    iget-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    mul-int/lit8 v22, v9, 0x2

    aget v2, v2, v22

    invoke-interface {v3, v4, v1, v2, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 1160
    const/4 v1, 0x0

    aget v2, v11, v1

    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    mul-int/lit8 v3, v9, 0x2

    const/4 v4, 0x1

    add-int/2addr v3, v4

    aget v3, v1, v3

    and-int/2addr v2, v3

    mul-int/lit8 v3, v9, 0x2

    add-int/2addr v3, v4

    aget v1, v1, v3

    if-eq v2, v1, :cond_6

    .line 1162
    const/4 v12, 0x0

    .line 1163
    goto :goto_4

    .line 1157
    :cond_6
    add-int/lit8 v9, v9, 0x1

    move-object/from16 v1, v20

    move-object/from16 v2, v21

    const/4 v3, 0x0

    const/4 v4, 0x1

    goto :goto_3

    .end local v20    # "oldConf":[I
    .end local v21    # "version":[I
    .restart local v1    # "oldConf":[I
    .restart local v2    # "version":[I
    :cond_7
    move-object/from16 v20, v1

    move-object/from16 v21, v2

    .line 1166
    .end local v1    # "oldConf":[I
    .end local v2    # "version":[I
    .end local v9    # "j":I
    .restart local v20    # "oldConf":[I
    .restart local v21    # "version":[I
    :goto_4
    if-nez v12, :cond_8

    .line 1167
    move-object/from16 v22, v5

    move/from16 v23, v6

    move/from16 v24, v7

    move-object/from16 v26, v14

    const/4 v14, 0x0

    goto/16 :goto_7

    .line 1168
    :cond_8
    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v3, v13, v8

    const/16 v4, 0x3024

    invoke-interface {v1, v2, v3, v4, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    const/4 v1, 0x0

    aget v2, v11, v1

    .line 1169
    .local v2, "r":I
    iget-object v3, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v4, v13, v8

    move-object/from16 v22, v5

    const/16 v5, 0x3023

    .end local v5    # "oldConfES2":[I
    .local v22, "oldConfES2":[I
    invoke-interface {v3, v9, v4, v5, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    aget v3, v11, v1

    .line 1170
    .local v3, "g":I
    iget-object v4, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v5, v13, v8

    move/from16 v23, v6

    const/16 v6, 0x3022

    .end local v6    # "ret":Z
    .local v23, "ret":Z
    invoke-interface {v4, v9, v5, v6, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    aget v4, v11, v1

    .line 1171
    .local v4, "b":I
    iget-object v5, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v6, v13, v8

    move/from16 v24, v7

    const/16 v7, 0x3021

    .end local v7    # "eglErr":I
    .local v24, "eglErr":I
    invoke-interface {v5, v9, v6, v7, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    aget v5, v11, v1

    .line 1172
    .local v5, "a":I
    iget-object v6, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v7, v13, v8

    move/from16 v25, v12

    const/16 v12, 0x3025

    .end local v12    # "cont":Z
    .local v25, "cont":Z
    invoke-interface {v6, v9, v7, v12, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    aget v6, v11, v1

    .line 1173
    .local v6, "d":I
    iget-object v7, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    aget-object v12, v13, v8

    move-object/from16 v26, v14

    const/16 v14, 0x3026

    .end local v14    # "num_configs":[I
    .local v26, "num_configs":[I
    invoke-interface {v7, v9, v12, v14, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    aget v7, v11, v1

    .line 1175
    .local v7, "s":I
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v12, ">>> EGL Config ["

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v12, "] R"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v12, "G"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v12, "B"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v12, "A"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v12, " D"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v12, "S"

    invoke-virtual {v9, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v9, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v1, v9}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1177
    iget v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->redSize:I

    sub-int v1, v2, v1

    invoke-static {v1}, Ljava/lang/Math;->abs(I)I

    move-result v1

    iget v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->greenSize:I

    sub-int v9, v3, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v9

    add-int/2addr v1, v9

    iget v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->blueSize:I

    sub-int v9, v4, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v9

    add-int/2addr v1, v9

    iget v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->alphaSize:I

    sub-int v9, v5, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v9

    add-int/2addr v1, v9

    shl-int/lit8 v1, v1, 0x10

    .line 1178
    .end local v15    # "currScore":I
    .local v1, "currScore":I
    iget v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->depthSize:I

    sub-int v9, v6, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v9

    shl-int/lit8 v9, v9, 0x8

    add-int/2addr v1, v9

    .line 1179
    iget v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->stencilSize:I

    sub-int v9, v7, v9

    invoke-static {v9}, Ljava/lang/Math;->abs(I)I

    move-result v9

    add-int/2addr v1, v9

    .line 1181
    if-ge v1, v10, :cond_b

    .line 1183
    sget-object v9, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v12, "--------------------------"

    invoke-virtual {v9, v12}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1184
    sget-object v9, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v15, "New config chosen: "

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v9, v12}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1185
    const/4 v9, 0x0

    .restart local v9    # "j":I
    :goto_5
    iget-object v12, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    array-length v15, v12

    const/16 v16, 0x1

    add-int/lit8 v15, v15, -0x1

    shr-int/lit8 v15, v15, 0x1

    if-ge v9, v15, :cond_a

    .line 1187
    iget-object v15, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v14, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    move/from16 v27, v2

    .end local v2    # "r":I
    .local v27, "r":I
    aget-object v2, v13, v8

    mul-int/lit8 v28, v9, 0x2

    aget v12, v12, v28

    invoke-interface {v15, v14, v2, v12, v11}, Ljavax/microedition/khronos/egl/EGL10;->eglGetConfigAttrib(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;I[I)Z

    .line 1188
    const/4 v2, 0x0

    aget v12, v11, v2

    iget-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->configAttrs:[I

    mul-int/lit8 v14, v9, 0x2

    const/4 v15, 0x1

    add-int/2addr v14, v15

    aget v2, v2, v14

    if-lt v12, v2, :cond_9

    .line 1189
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "setting "

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v14, ", matches: "

    invoke-virtual {v12, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const/4 v14, 0x0

    aget v15, v11, v14

    invoke-virtual {v12, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v2, v12}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_6

    .line 1188
    :cond_9
    const/4 v14, 0x0

    .line 1185
    :goto_6
    add-int/lit8 v9, v9, 0x1

    move/from16 v2, v27

    const/16 v14, 0x3026

    goto :goto_5

    .end local v27    # "r":I
    .restart local v2    # "r":I
    :cond_a
    move/from16 v27, v2

    const/4 v14, 0x0

    .line 1192
    .end local v2    # "r":I
    .end local v9    # "j":I
    .restart local v27    # "r":I
    move v2, v1

    .line 1193
    .end local v10    # "score":I
    .local v2, "score":I
    aget-object v9, v13, v8

    iput-object v9, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    move v10, v2

    goto :goto_7

    .line 1181
    .end local v27    # "r":I
    .local v2, "r":I
    .restart local v10    # "score":I
    :cond_b
    move/from16 v27, v2

    const/4 v14, 0x0

    .line 1152
    .end local v1    # "currScore":I
    .end local v2    # "r":I
    .end local v3    # "g":I
    .end local v4    # "b":I
    .end local v5    # "a":I
    .end local v6    # "d":I
    .end local v7    # "s":I
    .end local v25    # "cont":Z
    :goto_7
    add-int/lit8 v8, v8, 0x1

    move-object/from16 v1, v20

    move-object/from16 v2, v21

    move-object/from16 v5, v22

    move/from16 v6, v23

    move/from16 v7, v24

    move-object/from16 v14, v26

    const/4 v3, 0x0

    const/4 v4, 0x1

    const/16 v9, 0x3024

    goto/16 :goto_2

    .line 1196
    .end local v20    # "oldConf":[I
    .end local v21    # "version":[I
    .end local v22    # "oldConfES2":[I
    .end local v23    # "ret":Z
    .end local v24    # "eglErr":I
    .end local v26    # "num_configs":[I
    .local v1, "oldConf":[I
    .local v2, "version":[I
    .local v5, "oldConfES2":[I
    .local v6, "ret":Z
    .local v7, "eglErr":I
    .restart local v14    # "num_configs":[I
    :cond_c
    move-object/from16 v20, v1

    move-object/from16 v21, v2

    move-object/from16 v22, v5

    .end local v1    # "oldConf":[I
    .end local v2    # "version":[I
    .end local v5    # "oldConfES2":[I
    .restart local v20    # "oldConf":[I
    .restart local v21    # "version":[I
    .restart local v22    # "oldConfES2":[I
    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    iget-object v5, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->contextAttrs:[I

    invoke-interface {v1, v2, v3, v4, v5}, Ljavax/microedition/khronos/egl/EGL10;->eglCreateContext(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLConfig;Ljavax/microedition/khronos/egl/EGLContext;[I)Ljavax/microedition/khronos/egl/EGLContext;

    move-result-object v1

    iput-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    .line 1197
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "eglCreateContext: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v3}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1199
    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-virtual {v1}, Ljavax/microedition/khronos/egl/EGLContext;->getGL()Ljavax/microedition/khronos/opengles/GL;

    move-result-object v1

    check-cast v1, Ljavax/microedition/khronos/opengles/GL11;

    iput-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->gl:Ljavax/microedition/khronos/opengles/GL11;

    .line 1200
    const/4 v1, 0x1

    return v1

    nop

    :array_0
    .array-data 4
        0x3098
        0x2
        0x3038
    .end array-data
.end method

.method public native initSAMP()V
.end method

.method public native keyEvent(IIIILandroid/view/KeyEvent;)Z
.end method

.method public synthetic lambda$flyHideAll$NvEventQueueActivity()V
    .locals 3

    const v0, 0x7f090262

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    const/16 v2, 0x8

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public synthetic lambda$flyShowAll$NvEventQueueActivity()V
    .locals 3

    const v0, 0x7f090262

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    if-eqz v1, :cond_0

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    :cond_0
    return-void
.end method

.method public synthetic lambda$hideDialogWithoutReset$1$NvEventQueueActivity()V
    .locals 1

    .line 1460
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->hideWithoutReset()V

    return-void
.end method

.method public synthetic lambda$hideHud$5$NvEventQueueActivity()V
    .locals 1

    .line 1503
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHudManager:Lcom/luxury/mobile/gui/HudManager;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/HudManager;->HideHud()V

    return-void
.end method

.method public synthetic lambda$hideSpeed$8$NvEventQueueActivity()V
    .locals 1

    .line 1521
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSpeedometer:Lcom/luxury/mobile/gui/Speedometer;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/Speedometer;->HideSpeed()V

    return-void
.end method

.method public synthetic lambda$showDialog$0$NvEventQueueActivity(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 7
    .param p1, "dialogId"    # I
    .param p2, "dialogTypeId"    # I
    .param p3, "caption"    # Ljava/lang/String;
    .param p4, "content"    # Ljava/lang/String;
    .param p5, "leftBtnText"    # Ljava/lang/String;
    .param p6, "rightBtnText"    # Ljava/lang/String;

    .line 1457
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

    move v1, p1

    move v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Lcom/luxury/mobile/gui/dialogs/Dialog;->show(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public synthetic lambda$showDialogWithOldContent$2$NvEventQueueActivity()V
    .locals 1

    .line 1462
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/dialogs/Dialog;->showWithOldContent()V

    return-void
.end method

.method public synthetic lambda$showHud$4$NvEventQueueActivity()V
    .locals 1

    .line 1501
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHudManager:Lcom/luxury/mobile/gui/HudManager;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/HudManager;->ShowHud()V

    return-void
.end method

.method public synthetic lambda$showSpeed$7$NvEventQueueActivity()V
    .locals 1

    .line 1519
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSpeedometer:Lcom/luxury/mobile/gui/Speedometer;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/Speedometer;->ShowSpeed()V

    return-void
.end method

.method public synthetic lambda$updateHudInfo$3$NvEventQueueActivity(IIIIIIIII)V
    .locals 11
    .param p1, "health"    # I
    .param p2, "kaban"    # I
    .param p3, "armour"    # I
    .param p4, "hunger"    # I
    .param p5, "weaponid"    # I
    .param p6, "ammo"    # I
    .param p7, "playerid"    # I
    .param p8, "money"    # I
    .param p9, "wanted"    # I

    .line 1499
    move-object v0, p0

    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHudManager:Lcom/luxury/mobile/gui/HudManager;

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    invoke-virtual/range {v1 .. v10}, Lcom/luxury/mobile/gui/HudManager;->UpdateHudInfo(IIIIIIIII)V

    return-void
.end method

.method public synthetic lambda$updateSpeedInfo$6$NvEventQueueActivity(IIIIIIII)V
    .locals 10
    .param p1, "speed"    # I
    .param p2, "fuel"    # I
    .param p3, "hp"    # I
    .param p4, "mileage"    # I
    .param p5, "engine"    # I
    .param p6, "light"    # I
    .param p7, "belt"    # I
    .param p8, "lock"    # I

    .line 1517
    move-object v0, p0

    iget-object v1, v0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSpeedometer:Lcom/luxury/mobile/gui/Speedometer;

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    invoke-virtual/range {v1 .. v9}, Lcom/luxury/mobile/gui/Speedometer;->UpdateSpeedInfo(IIIIIIII)V

    return-void
.end method

.method public loadFile(Ljava/lang/String;)Lcom/nvidia/devtech/NvEventQueueActivity$RawData;
    .locals 5
    .param p1, "filename"    # Ljava/lang/String;

    .line 382
    const/4 v0, 0x0

    .line 383
    .local v0, "is":Ljava/io/InputStream;
    new-instance v1, Lcom/nvidia/devtech/NvEventQueueActivity$RawData;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$RawData;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    .line 387
    .local v1, "ret":Lcom/nvidia/devtech/NvEventQueueActivity$RawData;
    :try_start_0
    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "/data/"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v0, v2

    .line 398
    goto :goto_0

    .line 409
    :catchall_0
    move-exception v2

    goto :goto_1

    .line 404
    :catch_0
    move-exception v2

    goto :goto_3

    .line 389
    :catch_1
    move-exception v2

    .line 393
    .local v2, "e":Ljava/lang/Exception;
    :try_start_1
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    invoke-virtual {v3, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v3
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_2
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v0, v3

    .line 397
    goto :goto_0

    .line 395
    :catch_2
    move-exception v3

    .line 399
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_0
    :try_start_2
    invoke-virtual {v0}, Ljava/io/InputStream;->available()I

    move-result v2

    .line 400
    .local v2, "size":I
    iput v2, v1, Lcom/nvidia/devtech/NvEventQueueActivity$RawData;->length:I

    .line 401
    new-array v3, v2, [B

    iput-object v3, v1, Lcom/nvidia/devtech/NvEventQueueActivity$RawData;->data:[B

    .line 402
    iget-object v3, v1, Lcom/nvidia/devtech/NvEventQueueActivity$RawData;->data:[B

    invoke-virtual {v0, v3}, Ljava/io/InputStream;->read([B)I
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 409
    nop

    .end local v2    # "size":I
    if-eqz v0, :cond_1

    .line 411
    :try_start_3
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_3

    goto :goto_4

    :catch_3
    move-exception v2

    goto :goto_4

    .line 409
    :goto_1
    if-eqz v0, :cond_0

    .line 411
    :try_start_4
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4

    goto :goto_2

    :catch_4
    move-exception v3

    .line 413
    :cond_0
    :goto_2
    throw v2

    .line 409
    :goto_3
    if-eqz v0, :cond_1

    .line 411
    :try_start_5
    invoke-virtual {v0}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_3

    .line 414
    :cond_1
    :goto_4
    return-object v1
.end method

.method public loadTexture(Ljava/lang/String;)Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;
    .locals 17
    .param p1, "filename"    # Ljava/lang/String;

    .line 435
    move-object/from16 v1, p1

    new-instance v0, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;

    move-object/from16 v2, p0

    invoke-direct {v0, v2}, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    move-object v3, v0

    .line 437
    .local v3, "ret":Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;
    const/4 v4, 0x0

    .line 440
    .local v4, "is":Ljava/io/InputStream;
    :try_start_0
    new-instance v0, Ljava/io/FileInputStream;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "/data/"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v0, v5}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v4, v0

    .line 451
    goto :goto_0

    .line 442
    :catch_0
    move-exception v0

    move-object v5, v0

    .line 446
    .local v5, "e":Ljava/lang/Exception;
    :try_start_1
    invoke-virtual/range {p0 .. p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    move-object v4, v0

    .line 450
    goto :goto_0

    .line 448
    :catch_1
    move-exception v0

    .line 453
    .end local v5    # "e":Ljava/lang/Exception;
    :goto_0
    :try_start_2
    invoke-static {v4}, Landroid/graphics/BitmapFactory;->decodeStream(Ljava/io/InputStream;)Landroid/graphics/Bitmap;

    move-result-object v5

    .line 454
    .local v5, "bmp":Landroid/graphics/Bitmap;
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    iput v0, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->width:I

    .line 455
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v0

    iput v0, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->height:I

    .line 456
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v6

    mul-int v0, v0, v6

    new-array v0, v0, [I

    .line 457
    .local v0, "pixels":[I
    const/4 v7, 0x0

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v8

    const/4 v9, 0x0

    const/4 v10, 0x0

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v11

    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v12

    move-object v6, v0

    invoke-virtual/range {v5 .. v12}, Landroid/graphics/Bitmap;->getPixels([IIIIIII)V

    .line 460
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v6

    new-array v6, v6, [I

    .line 461
    .local v6, "tmp":[I
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v7

    .line 462
    .local v7, "w":I
    invoke-virtual {v5}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v8

    .line 463
    .local v8, "h":I
    const/4 v9, 0x0

    .local v9, "i":I
    :goto_1
    shr-int/lit8 v10, v8, 0x1

    if-ge v9, v10, :cond_0

    .line 465
    mul-int v10, v9, v7

    const/4 v11, 0x0

    invoke-static {v0, v10, v6, v11, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 466
    add-int/lit8 v10, v8, -0x1

    sub-int/2addr v10, v9

    mul-int v10, v10, v7

    mul-int v12, v9, v7

    invoke-static {v0, v10, v0, v12, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 467
    add-int/lit8 v10, v8, -0x1

    sub-int/2addr v10, v9

    mul-int v10, v10, v7

    invoke-static {v6, v11, v0, v10, v7}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 463
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 471
    .end local v9    # "i":I
    :cond_0
    array-length v9, v0

    mul-int/lit8 v9, v9, 0x4

    iput v9, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->length:I

    .line 472
    iget v9, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->length:I

    new-array v9, v9, [B

    iput-object v9, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->data:[B

    .line 473
    const/4 v9, 0x0

    .line 474
    .local v9, "pos":I
    const/4 v10, 0x0

    .line 475
    .local v10, "bpos":I
    const/4 v11, 0x0

    .local v11, "y":I
    :goto_2
    if-ge v11, v8, :cond_2

    .line 477
    const/4 v12, 0x0

    .local v12, "x":I
    :goto_3
    if-ge v12, v7, :cond_1

    .line 479
    aget v13, v0, v9

    .line 480
    .local v13, "p":I
    iget-object v14, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->data:[B

    add-int/lit8 v15, v10, 0x1

    .end local v10    # "bpos":I
    .local v15, "bpos":I
    move-object/from16 v16, v0

    .end local v0    # "pixels":[I
    .local v16, "pixels":[I
    shr-int/lit8 v0, v13, 0x10

    and-int/lit16 v0, v0, 0xff

    int-to-byte v0, v0

    aput-byte v0, v14, v10

    .line 481
    iget-object v0, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->data:[B

    add-int/lit8 v10, v15, 0x1

    .end local v15    # "bpos":I
    .restart local v10    # "bpos":I
    shr-int/lit8 v14, v13, 0x8

    and-int/lit16 v14, v14, 0xff

    int-to-byte v14, v14

    aput-byte v14, v0, v15

    .line 482
    iget-object v0, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->data:[B

    add-int/lit8 v14, v10, 0x1

    .end local v10    # "bpos":I
    .local v14, "bpos":I
    shr-int/lit8 v15, v13, 0x0

    and-int/lit16 v15, v15, 0xff

    int-to-byte v15, v15

    aput-byte v15, v0, v10

    .line 483
    iget-object v0, v3, Lcom/nvidia/devtech/NvEventQueueActivity$RawTexture;->data:[B

    add-int/lit8 v10, v14, 0x1

    .end local v14    # "bpos":I
    .restart local v10    # "bpos":I
    shr-int/lit8 v15, v13, 0x18

    and-int/lit16 v15, v15, 0xff

    int-to-byte v15, v15

    aput-byte v15, v0, v14
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2

    .line 477
    .end local v13    # "p":I
    add-int/lit8 v12, v12, 0x1

    add-int/lit8 v9, v9, 0x1

    move-object/from16 v0, v16

    goto :goto_3

    .end local v16    # "pixels":[I
    .restart local v0    # "pixels":[I
    :cond_1
    move-object/from16 v16, v0

    .line 475
    .end local v0    # "pixels":[I
    .end local v12    # "x":I
    .restart local v16    # "pixels":[I
    add-int/lit8 v11, v11, 0x1

    goto :goto_2

    .end local v16    # "pixels":[I
    .restart local v0    # "pixels":[I
    :cond_2
    move-object/from16 v16, v0

    .line 490
    .end local v0    # "pixels":[I
    .end local v4    # "is":Ljava/io/InputStream;
    .end local v5    # "bmp":Landroid/graphics/Bitmap;
    .end local v6    # "tmp":[I
    .end local v7    # "w":I
    .end local v8    # "h":I
    .end local v9    # "pos":I
    .end local v10    # "bpos":I
    .end local v11    # "y":I
    goto :goto_4

    .line 487
    :catch_2
    move-exception v0

    .line 489
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 491
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_4
    return-object v3
.end method

.method public native lowMemoryEvent()V
.end method

.method public mSleep(J)V
    .locals 1
    .param p1, "milis"    # J

    .line 763
    :try_start_0
    invoke-static {p1, p2}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 765
    goto :goto_0

    .line 764
    :catch_0
    move-exception v0

    .line 766
    :goto_0
    return-void
.end method

.method public makeCurrent()Z
    .locals 5

    .line 1352
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 1354
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "eglContext is NULL"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1355
    return v1

    .line 1357
    :cond_0
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    if-nez v2, :cond_1

    .line 1359
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "eglSurface is NULL"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1360
    return v1

    .line 1362
    :cond_1
    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v3, v4, v2, v2, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1364
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    iget-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglContext:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v2, v3, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1366
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "eglMakeCurrent err: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v3}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1367
    return v1

    .line 1373
    :cond_2
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->GetGLExtensions()V

    .line 1374
    const/4 v0, 0x1

    return v0
.end method

.method public native multiTouchEvent(IIIIIILandroid/view/MotionEvent;)Z
.end method

.method public native notifyChange(Ljava/lang/String;I)V
.end method

.method public native nvAcquireTimeExtension()V
.end method

.method public native nvGetSystemTime()J
.end method

.method public onAccuracyChanged(Landroid/hardware/Sensor;I)V
    .locals 0
    .param p1, "sensor"    # Landroid/hardware/Sensor;
    .param p2, "accuracy"    # I

    .line 785
    return-void
.end method

.method public onBackPressed()V
    .locals 0

    .line 218
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onBackPressed()V

    .line 219
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onEventBackPressed()V

    .line 220
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .line 609
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 610
    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 552
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** onCreate"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 553
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 554
    sput-object p0, Lcom/nvidia/devtech/NvEventQueueActivity;->instance:Lcom/nvidia/devtech/NvEventQueueActivity;

    .line 555
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->supportPauseResume:Z

    if-eqz v0, :cond_0

    .line 557
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "Calling init(false)"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 558
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->init(Z)Z

    .line 559
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "Calling initSAMP"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 560
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->initSAMP()V

    .line 561
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "Called"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 563
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-direct {v0}, Landroid/os/Handler;-><init>()V

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->handler:Landroid/os/Handler;

    .line 564
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->wantsAccelerometer:Z

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorManager:Landroid/hardware/SensorManager;

    if-nez v0, :cond_1

    .line 565
    const-string v0, "sensor"

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/hardware/SensorManager;

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorManager:Landroid/hardware/SensorManager;

    .line 568
    :cond_1
    const-string v0, "clipboard"

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/content/ClipboardManager;

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mClipboardManager:Landroid/content/ClipboardManager;

    .line 570
    invoke-static {}, Lcom/nvidia/devtech/NvUtil;->getInstance()Lcom/nvidia/devtech/NvUtil;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/nvidia/devtech/NvUtil;->setActivity(Landroid/app/Activity;)V

    .line 571
    invoke-static {}, Lcom/nvidia/devtech/NvAPKFileHelper;->getInstance()Lcom/nvidia/devtech/NvAPKFileHelper;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/nvidia/devtech/NvAPKFileHelper;->setContext(Landroid/content/Context;)V

    .line 573
    const-string v0, "window"

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/WindowManager;

    invoke-interface {v0}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v0

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->display:Landroid/view/Display;

    .line 575
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    const/16 v1, 0x400

    invoke-virtual {v0, v1}, Landroid/view/Window;->addFlags(I)V

    .line 577
    const/4 v0, 0x6

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->setRequestedOrientation(I)V

    .line 579
    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 585
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->systemInit()Z

    .line 587
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->hideSystemUI()V

    .line 591
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/Window;->getDecorView()Landroid/view/View;

    move-result-object v0

    new-instance v1, Lcom/nvidia/devtech/NvEventQueueActivity$2;

    invoke-direct {v1, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$2;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {v0, v1}, Landroid/view/View;->setOnSystemUiVisibilityChangeListener(Landroid/view/View$OnSystemUiVisibilityChangeListener;)V

    .line 605
    invoke-direct {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->processCutout()V

    .line 606
    return-void
.end method

.method public onDestroy()V
    .locals 2

    .line 745
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** onDestroy"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 746
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->supportPauseResume:Z

    if-eqz v0, :cond_0

    .line 748
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->quitAndWait()V

    .line 749
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->finish()V

    .line 751
    :cond_0
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onDestroy()V

    .line 752
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->systemCleanup()V

    .line 753
    return-void
.end method

.method public native onEventBackPressed()V
.end method

.method public onHeightChanged(II)V
    .locals 1
    .param p1, "orientation"    # I
    .param p2, "height"    # I

    .line 325
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mInputManager:Lcom/nvidia/devtech/InputManager;

    if-eqz v0, :cond_0

    .line 327
    invoke-virtual {v0, p2}, Lcom/nvidia/devtech/InputManager;->onHeightChanged(I)V

    .line 329
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

    .line 330
    .local v0, "dialog":Lcom/luxury/mobile/gui/dialogs/Dialog;
    if-eqz v0, :cond_1

    .line 331
    invoke-virtual {v0, p2}, Lcom/luxury/mobile/gui/dialogs/Dialog;->onHeightChanged(I)V

    .line 333
    :cond_1
    nop

    .line 337
    return-void
.end method

.method public onKeyDown(ILandroid/view/KeyEvent;)Z
    .locals 7
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .line 839
    const/4 v0, 0x0

    .line 841
    .local v0, "ret":Z
    const/4 v1, 0x4

    if-ne p1, v1, :cond_0

    .line 843
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->onEventBackPressed()V

    .line 846
    :cond_0
    const/16 v2, 0x18

    if-eq p1, v2, :cond_6

    const/16 v2, 0x19

    if-ne p1, v2, :cond_1

    goto :goto_1

    .line 849
    :cond_1
    const/16 v2, 0x59

    if-eq p1, v2, :cond_5

    const/16 v2, 0x55

    if-eq p1, v2, :cond_5

    const/16 v2, 0x5a

    if-ne p1, v2, :cond_2

    goto :goto_0

    .line 852
    :cond_2
    const/16 v2, 0x52

    if-eq p1, v2, :cond_3

    if-eq p1, v1, :cond_3

    .line 853
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AppCompatActivity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v0

    .line 855
    :cond_3
    if-nez v0, :cond_4

    .line 856
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result v2

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getUnicodeChar()I

    move-result v4

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getMetaState()I

    move-result v5

    move-object v1, p0

    move v3, p1

    move-object v6, p2

    invoke-virtual/range {v1 .. v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->keyEvent(IIIILandroid/view/KeyEvent;)Z

    move-result v0

    .line 858
    :cond_4
    return v0

    .line 850
    :cond_5
    :goto_0
    const/4 v1, 0x0

    return v1

    .line 847
    :cond_6
    :goto_1
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AppCompatActivity;->onKeyDown(ILandroid/view/KeyEvent;)Z

    move-result v1

    return v1
.end method

.method public onKeyUp(ILandroid/view/KeyEvent;)Z
    .locals 8
    .param p1, "keyCode"    # I
    .param p2, "event"    # Landroid/view/KeyEvent;

    .line 869
    const/16 v0, 0x73

    if-ne p1, v0, :cond_1

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0xb

    if-lt v0, v1, :cond_1

    .line 871
    invoke-virtual {p2}, Landroid/view/KeyEvent;->isCapsLockOn()Z

    move-result v0

    .line 872
    .local v0, "capsLockOn":Z
    if-eqz v0, :cond_0

    const/4 v1, 0x3

    const/4 v3, 0x3

    goto :goto_0

    :cond_0
    const/4 v1, 0x4

    const/4 v3, 0x4

    :goto_0
    const/16 v4, 0x73

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v2, p0

    move-object v7, p2

    invoke-virtual/range {v2 .. v7}, Lcom/nvidia/devtech/NvEventQueueActivity;->keyEvent(IIIILandroid/view/KeyEvent;)Z

    .line 874
    .end local v0    # "capsLockOn":Z
    :cond_1
    const/16 v0, 0x59

    if-eq p1, v0, :cond_4

    const/16 v0, 0x55

    if-eq p1, v0, :cond_4

    const/16 v0, 0x5a

    if-ne p1, v0, :cond_2

    goto :goto_1

    .line 878
    :cond_2
    invoke-super {p0, p1, p2}, Landroidx/appcompat/app/AppCompatActivity;->onKeyUp(ILandroid/view/KeyEvent;)Z

    move-result v0

    .line 879
    .local v0, "onKeyUp":Z
    if-eqz v0, :cond_3

    .line 881
    return v0

    .line 883
    :cond_3
    invoke-virtual {p2}, Landroid/view/KeyEvent;->getAction()I

    move-result v2

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getUnicodeChar()I

    move-result v4

    invoke-virtual {p2}, Landroid/view/KeyEvent;->getMetaState()I

    move-result v5

    move-object v1, p0

    move v3, p1

    move-object v6, p2

    invoke-virtual/range {v1 .. v6}, Lcom/nvidia/devtech/NvEventQueueActivity;->keyEvent(IIIILandroid/view/KeyEvent;)Z

    move-result v1

    return v1

    .line 876
    .end local v0    # "onKeyUp":Z
    :cond_4
    :goto_1
    const/4 v0, 0x0

    return v0
.end method

.method protected onPause()V
    .locals 2

    .line 706
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** onPause"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 707
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onPause()V

    .line 708
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->paused:Z

    .line 710
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    if-eqz v0, :cond_0

    .line 712
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "java is invoking pauseEvent(), this will block until\nthe client calls NVEventPauseProcessed"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 713
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->pauseEvent()V

    .line 714
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "pauseEvent() returned"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 716
    :cond_0
    return-void
.end method

.method protected onRestart()V
    .locals 2

    .line 695
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** onRestart"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 696
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onRestart()V

    .line 697
    return-void
.end method

.method protected onResume()V
    .locals 4

    .line 663
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** onResume"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 664
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onResume()V

    .line 665
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorManager:Landroid/hardware/SensorManager;

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 666
    nop

    .line 668
    invoke-virtual {v0, v1}, Landroid/hardware/SensorManager;->getDefaultSensor(I)Landroid/hardware/Sensor;

    move-result-object v2

    iget v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorDelay:I

    .line 666
    invoke-virtual {v0, p0, v2, v3}, Landroid/hardware/SensorManager;->registerListener(Landroid/hardware/SensorEventListener;Landroid/hardware/Sensor;I)Z

    .line 670
    :cond_0
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->paused:Z

    .line 672
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHeightProvider:Lcom/nvidia/devtech/HeightProvider;

    if-eqz v0, :cond_1

    .line 674
    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mRootFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v0, v2}, Lcom/nvidia/devtech/HeightProvider;->init(Landroid/view/View;)Lcom/nvidia/devtech/HeightProvider;

    .line 677
    :cond_1
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->viewIsActive:Z

    if-eqz v0, :cond_2

    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    if-eqz v0, :cond_2

    .line 679
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->resumeEvent()V

    .line 680
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->cachedSurfaceHolder:Landroid/view/SurfaceHolder;

    if-eqz v0, :cond_2

    .line 682
    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setKeepScreenOn(Z)V

    .line 685
    :cond_2
    return-void
.end method

.method public onSensorChanged(Landroid/hardware/SensorEvent;)V
    .locals 7
    .param p1, "event"    # Landroid/hardware/SensorEvent;

    .line 794
    iget-object v0, p1, Landroid/hardware/SensorEvent;->sensor:Landroid/hardware/Sensor;

    invoke-virtual {v0}, Landroid/hardware/Sensor;->getType()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_4

    .line 796
    const/4 v0, 0x0

    .line 797
    .local v0, "roll":F
    const/4 v2, 0x0

    .line 798
    .local v2, "pitch":F
    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->display:Landroid/view/Display;

    invoke-virtual {v3}, Landroid/view/Display;->getRotation()I

    move-result v3

    const/4 v4, 0x2

    const/4 v5, 0x0

    if-eqz v3, :cond_3

    if-eq v3, v1, :cond_2

    if-eq v3, v4, :cond_1

    const/4 v6, 0x3

    if-eq v3, v6, :cond_0

    goto :goto_0

    .line 812
    :cond_0
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v1, v3, v1

    neg-float v0, v1

    .line 813
    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v2, v1, v5

    goto :goto_0

    .line 808
    :cond_1
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v3, v5

    .line 809
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v2, v3, v1

    .line 810
    goto :goto_0

    .line 804
    :cond_2
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v0, v3, v1

    .line 805
    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v2, v1, v5

    .line 806
    goto :goto_0

    .line 800
    :cond_3
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v3, v3, v5

    neg-float v0, v3

    .line 801
    iget-object v3, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v2, v3, v1

    .line 802
    nop

    .line 816
    :goto_0
    iget-object v1, p1, Landroid/hardware/SensorEvent;->values:[F

    aget v1, v1, v4

    invoke-virtual {p0, v0, v2, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->accelerometerEvent(FFF)Z

    .line 818
    .end local v0    # "roll":F
    .end local v2    # "pitch":F
    :cond_4
    return-void
.end method

.method public native onSettingsWindowDefaults(I)V
.end method

.method public native onSettingsWindowSave()V
.end method

.method protected onStop()V
    .locals 2

    .line 726
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** onStop"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 727
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSensorManager:Landroid/hardware/SensorManager;

    if-eqz v0, :cond_0

    .line 728
    invoke-virtual {v0, p0}, Landroid/hardware/SensorManager;->unregisterListener(Landroid/hardware/SensorEventListener;)V

    .line 729
    :cond_0
    invoke-super {p0}, Landroidx/appcompat/app/AppCompatActivity;->onStop()V

    .line 730
    return-void
.end method

.method public native onTabClose()V
.end method

.method public onTouch(Landroid/view/View;Landroid/view/MotionEvent;)Z
    .locals 22
    .param p1, "view"    # Landroid/view/View;
    .param p2, "event"    # Landroid/view/MotionEvent;

    .line 279
    move-object/from16 v9, p0

    move-object/from16 v10, p2

    iget-object v0, v9, Lcom/nvidia/devtech/NvEventQueueActivity;->mRootFrame:Landroid/widget/FrameLayout;

    const/4 v11, 0x1

    move-object/from16 v12, p1

    if-ne v12, v0, :cond_5

    .line 281
    iget-boolean v0, v9, Lcom/nvidia/devtech/NvEventQueueActivity;->wantsMultitouch:Z

    if-eqz v0, :cond_4

    .line 283
    const/4 v0, 0x0

    .local v0, "x1":I
    const/4 v1, 0x0

    .local v1, "y1":I
    const/4 v2, 0x0

    .local v2, "x2":I
    const/4 v3, 0x0

    .local v3, "y2":I
    const/4 v4, 0x0

    .local v4, "x3":I
    const/4 v5, 0x0

    .line 285
    .local v5, "y3":I
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v13

    .line 286
    .local v13, "numEvents":I
    const/4 v6, 0x0

    move v14, v0

    move v15, v1

    move/from16 v16, v2

    move/from16 v17, v3

    move/from16 v18, v4

    move/from16 v19, v5

    .end local v0    # "x1":I
    .end local v1    # "y1":I
    .end local v2    # "x2":I
    .end local v3    # "y2":I
    .end local v4    # "x3":I
    .end local v5    # "y3":I
    .local v6, "i":I
    .local v14, "x1":I
    .local v15, "y1":I
    .local v16, "x2":I
    .local v17, "y2":I
    .local v18, "x3":I
    .local v19, "y3":I
    :goto_0
    if-ge v6, v13, :cond_3

    .line 289
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v0

    .line 290
    .local v0, "pointerId":I
    if-nez v0, :cond_0

    .line 292
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    float-to-int v1, v1

    .line 293
    .end local v14    # "x1":I
    .local v1, "x1":I
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    float-to-int v2, v2

    move v14, v1

    move v15, v2

    .end local v15    # "y1":I
    .local v2, "y1":I
    goto :goto_1

    .line 295
    .end local v1    # "x1":I
    .end local v2    # "y1":I
    .restart local v14    # "x1":I
    .restart local v15    # "y1":I
    :cond_0
    if-ne v0, v11, :cond_1

    .line 297
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    float-to-int v1, v1

    .line 298
    .end local v16    # "x2":I
    .local v1, "x2":I
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    float-to-int v2, v2

    move/from16 v16, v1

    move/from16 v17, v2

    .end local v17    # "y2":I
    .local v2, "y2":I
    goto :goto_1

    .line 300
    .end local v1    # "x2":I
    .end local v2    # "y2":I
    .restart local v16    # "x2":I
    .restart local v17    # "y2":I
    :cond_1
    const/4 v1, 0x2

    if-ne v0, v1, :cond_2

    .line 302
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getX(I)F

    move-result v1

    float-to-int v1, v1

    .line 303
    .end local v18    # "x3":I
    .local v1, "x3":I
    invoke-virtual {v10, v6}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    float-to-int v2, v2

    move/from16 v18, v1

    move/from16 v19, v2

    .line 286
    .end local v0    # "pointerId":I
    .end local v1    # "x3":I
    .restart local v18    # "x3":I
    :cond_2
    :goto_1
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 307
    .end local v6    # "i":I
    :cond_3
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getActionIndex()I

    move-result v0

    invoke-virtual {v10, v0}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v20

    .line 308
    .local v20, "pointerId":I
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getActionMasked()I

    move-result v21

    .line 309
    .local v21, "action":I
    move-object/from16 v0, p0

    move/from16 v1, v21

    move/from16 v2, v20

    move v3, v14

    move v4, v15

    move/from16 v5, v16

    move/from16 v6, v17

    move/from16 v7, v18

    move/from16 v8, v19

    invoke-virtual/range {v0 .. v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->customMultiTouchEvent(IIIIIIII)Z

    .line 311
    .end local v13    # "numEvents":I
    .end local v14    # "x1":I
    .end local v15    # "y1":I
    .end local v16    # "x2":I
    .end local v17    # "y2":I
    .end local v18    # "x3":I
    .end local v19    # "y3":I
    .end local v20    # "pointerId":I
    .end local v21    # "action":I
    goto :goto_2

    .line 314
    :cond_4
    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    float-to-int v1, v1

    invoke-virtual/range {p2 .. p2}, Landroid/view/MotionEvent;->getY()F

    move-result v2

    float-to-int v2, v2

    invoke-virtual {v9, v0, v1, v2, v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->touchEvent(IIILandroid/view/MotionEvent;)Z

    .line 317
    :cond_5
    :goto_2
    return v11
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "event"    # Landroid/view/MotionEvent;

    .line 828
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v0

    return v0
.end method

.method public native onWeaponChanged()V
.end method

.method public onWindowFocusChanged(Z)V
    .locals 1
    .param p1, "hasFocus"    # Z

    .line 614
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialogClientSettings:Lcom/luxury/mobile/core/DialogClientSettings;

    if-eqz v0, :cond_0

    .line 616
    invoke-virtual {v0}, Lcom/luxury/mobile/core/DialogClientSettings;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 617
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialogClientSettings:Lcom/luxury/mobile/core/DialogClientSettings;

    invoke-virtual {v0}, Lcom/luxury/mobile/core/DialogClientSettings;->getDialog()Landroid/app/Dialog;

    move-result-object v0

    invoke-virtual {v0}, Landroid/app/Dialog;->isShowing()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 619
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->hideSystemUI()V

    .line 620
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onWindowFocusChanged(Z)V

    .line 621
    return-void

    .line 626
    :cond_0
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ResumeEventDone:Z

    if-eqz v0, :cond_4

    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->viewIsActive:Z

    if-eqz v0, :cond_4

    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->paused:Z

    if-nez v0, :cond_4

    .line 628
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->GameIsFocused:Z

    if-eqz v0, :cond_2

    if-nez p1, :cond_2

    .line 630
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mInputManager:Lcom/nvidia/devtech/InputManager;

    if-eqz v0, :cond_1

    .line 632
    invoke-virtual {v0}, Lcom/nvidia/devtech/InputManager;->IsShowing()Z

    move-result v0

    if-nez v0, :cond_3

    .line 634
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->pauseEvent()V

    goto :goto_0

    .line 639
    :cond_1
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->pauseEvent()V

    goto :goto_0

    .line 642
    :cond_2
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->GameIsFocused:Z

    if-nez v0, :cond_3

    if-eqz p1, :cond_3

    .line 644
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->resumeEvent()V

    .line 646
    :cond_3
    :goto_0
    iput-boolean p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->GameIsFocused:Z

    .line 648
    :cond_4
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onWindowFocusChanged(Z)V

    .line 649
    if-eqz p1, :cond_5

    .line 651
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->hideSystemUI()V

    .line 653
    :cond_5
    return-void
.end method

.method public native pauseEvent()V
.end method

.method public native postCleanup()V
.end method

.method public native processTouchpadAsPointer(Landroid/view/ViewParent;Z)Z
.end method

.method public native quitAndWait()V
.end method

.method public native resumeEvent()V
.end method

.method public native sendDialogResponse(III[B)V
.end method

.method public native sendRPC(I[BI)V
.end method

.method public setFixedSize(II)V
    .locals 0
    .param p1, "fw"    # I
    .param p2, "fh"    # I

    .line 152
    iput p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->fixedWidth:I

    .line 153
    iput p2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->fixedHeight:I

    .line 154
    return-void
.end method

.method public native setNativeCutoutSettings(Z)V
.end method

.method public native setNativeDialog(Z)V
.end method

.method public native setNativeFpsCounterSettings(Z)V
.end method

.method public native setNativeHpArmourText(Z)V
.end method

.method public native setNativeHud(Z)V
.end method

.method public native setNativeHudElementColor(IIIII)V
.end method

.method public native setNativeHudElementPosition(III)V
.end method

.method public native setNativeHudElementScale(III)V
.end method

.method public native setNativeKeyboardSettings(Z)V
.end method

.method public native setNativeOutfitGunsSettings(Z)V
.end method

.method public native setNativePcMoney(Z)V
.end method

.method public native setNativeRadarrect(Z)V
.end method

.method public native setNativeSkyBox(Z)V
.end method

.method public native setNativeWidgetPositionAndScale(IIII)V
.end method

.method public setPauseState(Z)V
    .locals 1
    .param p1, "z2"    # Z

    .line 1506
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mAndroidUI:Landroid/widget/FrameLayout;

    if-nez v0, :cond_0

    .line 1507
    const v0, 0x7f090262

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/FrameLayout;

    iput-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mAndroidUI:Landroid/widget/FrameLayout;

    .line 1509
    :cond_0
    new-instance v0, Lcom/nvidia/devtech/NvEventQueueActivity$8;

    invoke-direct {v0, p0, p1}, Lcom/nvidia/devtech/NvEventQueueActivity$8;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;Z)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1515
    return-void
.end method

.method public setUseFullscreen(I)V
    .locals 0
    .param p1, "b"    # I

    .line 237
    iput p1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mUseFullscreen:I

    .line 238
    return-void
.end method

.method public native setWindowSize(II)V
.end method

.method public showAllUI()V
    .locals 1

    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$FlyShowAll;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$FlyShowAll;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public showClientSettings()V
    .locals 1

    .line 242
    new-instance v0, Lcom/nvidia/devtech/NvEventQueueActivity$1;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$1;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 253
    return-void
.end method

.method public showDialog(IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 9
    .param p1, "dialogId"    # I
    .param p2, "dialogTypeId"    # I
    .param p3, "caption"    # Ljava/lang/String;
    .param p4, "content"    # Ljava/lang/String;
    .param p5, "leftBtnText"    # Ljava/lang/String;
    .param p6, "rightBtnText"    # Ljava/lang/String;

    .line 1457
    new-instance v8, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$cYYvcUiXNQiUDN6eH125bgbZg3s;

    move-object v0, v8

    move-object v1, p0

    move v2, p1

    move v3, p2

    move-object v4, p3

    move-object v5, p4

    move-object v6, p5

    move-object v7, p6

    invoke-direct/range {v0 .. v7}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$cYYvcUiXNQiUDN6eH125bgbZg3s;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;IILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {p0, v8}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1458
    return-void
.end method

.method public showDialogWithOldContent()V
    .locals 1

    .line 1462
    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$freYZOSKspe4NHgm0KfovL6W9qU;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$freYZOSKspe4NHgm0KfovL6W9qU;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public showHud()V
    .locals 1

    .line 1501
    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$JLdm-TpZAd6tLvt6ICXizr_affk;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$JLdm-TpZAd6tLvt6ICXizr_affk;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public showInputLayout()V
    .locals 1

    .line 1438
    new-instance v0, Lcom/nvidia/devtech/NvEventQueueActivity$6;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/NvEventQueueActivity$6;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 1444
    return-void
.end method

.method public showSpeed()V
    .locals 1

    .line 1519
    new-instance v0, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$ynmpBDqVpmGHkfYCZ1PmWCeqtCg;

    invoke-direct {v0, p0}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$ynmpBDqVpmGHkfYCZ1PmWCeqtCg;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-virtual {p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public native showTab()V
.end method

.method public swapBuffers()Z
    .locals 5

    .line 1287
    iget v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->SwapBufferSkip:I

    const/4 v1, 0x1

    if-lez v0, :cond_0

    .line 1288
    sub-int/2addr v0, v1

    iput v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->SwapBufferSkip:I

    .line 1289
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "swapBuffer wait"

    invoke-virtual {v0, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1290
    return v1

    .line 1292
    :cond_0
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglSurface:Ljavax/microedition/khronos/egl/EGLSurface;

    const/4 v2, 0x0

    if-nez v0, :cond_1

    .line 1294
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "eglSurface is NULL"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1295
    return v2

    .line 1297
    :cond_1
    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    invoke-interface {v3, v4, v0}, Ljavax/microedition/khronos/egl/EGL10;->eglSwapBuffers(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;)Z

    move-result v0

    if-nez v0, :cond_2

    .line 1299
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "eglSwapBufferrr: "

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v3}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1300
    return v2

    .line 1306
    :cond_2
    return v1
.end method

.method protected systemCleanup()V
    .locals 1

    .line 1410
    iget-boolean v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->ranInit:Z

    if-eqz v0, :cond_0

    .line 1411
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->cleanup()V

    .line 1412
    :cond_0
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->cleanupEGL()V

    .line 1415
    return-void
.end method

.method protected systemInit()Z
    .locals 6

    .line 951
    move-object v0, p0

    .line 953
    .local v0, "act":Lcom/nvidia/devtech/NvEventQueueActivity;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v2, "ln systemInit"

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 955
    const v1, 0x7f0c0043

    invoke-virtual {p0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->setContentView(I)V

    .line 957
    const v1, 0x7f09016d

    invoke-virtual {p0, v1}, Lcom/nvidia/devtech/NvEventQueueActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/view/SurfaceView;

    .line 959
    .local v1, "view":Landroid/view/SurfaceView;
    iput-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSurfaceView:Landroid/view/SurfaceView;

    .line 960
    const v2, 0x7f09016b

    invoke-virtual {p0, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/FrameLayout;

    iput-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mRootFrame:Landroid/widget/FrameLayout;

    .line 961
    const v2, 0x7f090262

    invoke-virtual {p0, v2}, Lcom/nvidia/devtech/NvEventQueueActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/FrameLayout;

    iput-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mAndroidUI:Landroid/widget/FrameLayout;

    .line 963
    invoke-virtual {v1}, Landroid/view/SurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v2

    .line 964
    .local v2, "holder":Landroid/view/SurfaceHolder;
    const/4 v3, 0x2

    invoke-interface {v2, v3}, Landroid/view/SurfaceHolder;->setType(I)V

    .line 965
    const/4 v3, 0x1

    invoke-interface {v2, v3}, Landroid/view/SurfaceHolder;->setKeepScreenOn(Z)V

    .line 967
    invoke-virtual {v1, v3}, Landroid/view/SurfaceView;->setFocusable(Z)V

    .line 968
    invoke-virtual {v1, v3}, Landroid/view/SurfaceView;->setFocusableInTouchMode(Z)V

    .line 970
    iget-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mRootFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v4, p0}, Landroid/widget/FrameLayout;->setOnTouchListener(Landroid/view/View$OnTouchListener;)V

    .line 972
    new-instance v4, Lcom/nvidia/devtech/InputManager;

    invoke-direct {v4, p0}, Lcom/nvidia/devtech/InputManager;-><init>(Landroid/app/Activity;)V

    iput-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mInputManager:Lcom/nvidia/devtech/InputManager;

    .line 973
    new-instance v4, Lcom/nvidia/devtech/HeightProvider;

    invoke-direct {v4, p0}, Lcom/nvidia/devtech/HeightProvider;-><init>(Landroid/app/Activity;)V

    iget-object v5, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mRootFrame:Landroid/widget/FrameLayout;

    invoke-virtual {v4, v5}, Lcom/nvidia/devtech/HeightProvider;->init(Landroid/view/View;)Lcom/nvidia/devtech/HeightProvider;

    move-result-object v4

    invoke-virtual {v4, p0}, Lcom/nvidia/devtech/HeightProvider;->setHeightListener(Lcom/nvidia/devtech/HeightProvider$HeightListener;)Lcom/nvidia/devtech/HeightProvider;

    move-result-object v4

    iput-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHeightProvider:Lcom/nvidia/devtech/HeightProvider;

    .line 975
    new-instance v4, Lcom/luxury/mobile/gui/dialogs/Dialog;

    invoke-direct {v4, p0}, Lcom/luxury/mobile/gui/dialogs/Dialog;-><init>(Landroid/app/Activity;)V

    iput-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mDialog:Lcom/luxury/mobile/gui/dialogs/Dialog;

    .line 976
    new-instance v4, Lcom/luxury/mobile/gui/HudManager;

    invoke-direct {v4, p0}, Lcom/luxury/mobile/gui/HudManager;-><init>(Landroid/app/Activity;)V

    iput-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mHudManager:Lcom/luxury/mobile/gui/HudManager;

    .line 977
    new-instance v4, Lcom/luxury/mobile/gui/Speedometer;

    invoke-direct {v4, p0}, Lcom/luxury/mobile/gui/Speedometer;-><init>(Landroid/app/Activity;)V

    iput-object v4, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->mSpeedometer:Lcom/luxury/mobile/gui/Speedometer;

    .line 979
    invoke-virtual {p0}, Lcom/nvidia/devtech/NvEventQueueActivity;->DoResumeEvent()V

    .line 981
    new-instance v4, Lcom/nvidia/devtech/NvEventQueueActivity$4;

    invoke-direct {v4, p0, v0}, Lcom/nvidia/devtech/NvEventQueueActivity$4;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;Lcom/nvidia/devtech/NvEventQueueActivity;)V

    invoke-interface {v2, v4}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 1060
    return v3
.end method

.method public native togglePlayer(I)V
.end method

.method public native touchEvent(IIILandroid/view/MotionEvent;)Z
.end method

.method public unMakeCurrent()Z
    .locals 5

    .line 1390
    iget-object v0, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    iget-object v1, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->eglDisplay:Ljavax/microedition/khronos/egl/EGLDisplay;

    sget-object v2, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v3, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_SURFACE:Ljavax/microedition/khronos/egl/EGLSurface;

    sget-object v4, Ljavax/microedition/khronos/egl/EGL10;->EGL_NO_CONTEXT:Ljavax/microedition/khronos/egl/EGLContext;

    invoke-interface {v0, v1, v2, v3, v4}, Ljavax/microedition/khronos/egl/EGL10;->eglMakeCurrent(Ljavax/microedition/khronos/egl/EGLDisplay;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLSurface;Ljavax/microedition/khronos/egl/EGLContext;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 1392
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "egl(Un)MakeCurrent err: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, p0, Lcom/nvidia/devtech/NvEventQueueActivity;->egl:Ljavax/microedition/khronos/egl/EGL10;

    invoke-interface {v2}, Ljavax/microedition/khronos/egl/EGL10;->eglGetError()I

    move-result v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 1393
    const/4 v0, 0x0

    return v0

    .line 1396
    :cond_0
    const/4 v0, 0x1

    return v0
.end method

.method public updateHudInfo(IIIIIIIII)V
    .locals 12
    .param p1, "health"    # I
    .param p2, "kaban"    # I
    .param p3, "armour"    # I
    .param p4, "hunger"    # I
    .param p5, "weaponid"    # I
    .param p6, "ammo"    # I
    .param p7, "playerid"    # I
    .param p8, "money"    # I
    .param p9, "wanted"    # I

    .line 1499
    new-instance v11, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$YbV9cYXBPdU1XwpQjQSoS48XQ0U;

    move-object v0, v11

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move/from16 v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    invoke-direct/range {v0 .. v10}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$YbV9cYXBPdU1XwpQjQSoS48XQ0U;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;IIIIIIIII)V

    move-object v0, p0

    invoke-virtual {p0, v11}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method

.method public updateSpeedInfo(IIIIIIII)V
    .locals 11
    .param p1, "speed"    # I
    .param p2, "fuel"    # I
    .param p3, "hp"    # I
    .param p4, "mileage"    # I
    .param p5, "engine"    # I
    .param p6, "light"    # I
    .param p7, "belt"    # I
    .param p8, "lock"    # I

    .line 1517
    new-instance v10, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$6X8USpolCbzxEonmxJjDOlaZKFY;

    move-object v0, v10

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    invoke-direct/range {v0 .. v9}, Lcom/nvidia/devtech/-$$Lambda$NvEventQueueActivity$6X8USpolCbzxEonmxJjDOlaZKFY;-><init>(Lcom/nvidia/devtech/NvEventQueueActivity;IIIIIIII)V

    move-object v0, p0

    invoke-virtual {p0, v10}, Lcom/nvidia/devtech/NvEventQueueActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
