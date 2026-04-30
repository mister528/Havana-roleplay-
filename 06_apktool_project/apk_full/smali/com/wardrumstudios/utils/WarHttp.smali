.class public Lcom/wardrumstudios/utils/WarHttp;
.super Ljava/lang/Object;
.source "WarHttp.java"


# direct methods
.method protected constructor <init>(Lcom/wardrumstudios/utils/WarBase;)V
    .locals 2
    .param p1, "warBase"    # Lcom/wardrumstudios/utils/WarBase;

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 6
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** WarHttp::Init"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 7
    return-void
.end method


# virtual methods
.method public HttpGet(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "str"    # Ljava/lang/String;

    .line 11
    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const-string v1, "**** HttpGet"

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 12
    const-string v0, ""

    return-object v0
.end method
