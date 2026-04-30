.class public Lcom/tuyenmonkey/mkloader/exception/InvalidNumberOfPulseException;
.super Ljava/lang/Exception;
.source "InvalidNumberOfPulseException.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Exception;-><init>()V

    return-void
.end method


# virtual methods
.method public getMessage()Ljava/lang/String;
    .locals 1

    .line 10
    const-string v0, "The number of pulse must be between 2 and 6"

    return-object v0
.end method
