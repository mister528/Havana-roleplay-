.class public final enum Lcom/skydoves/colorpickerview/flag/FlagMode;
.super Ljava/lang/Enum;
.source "FlagMode.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/skydoves/colorpickerview/flag/FlagMode;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/skydoves/colorpickerview/flag/FlagMode;

.field public static final enum ALWAYS:Lcom/skydoves/colorpickerview/flag/FlagMode;

.field public static final enum FADE:Lcom/skydoves/colorpickerview/flag/FlagMode;

.field public static final enum LAST:Lcom/skydoves/colorpickerview/flag/FlagMode;


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .line 22
    new-instance v0, Lcom/skydoves/colorpickerview/flag/FlagMode;

    const-string v1, "ALWAYS"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/skydoves/colorpickerview/flag/FlagMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/skydoves/colorpickerview/flag/FlagMode;->ALWAYS:Lcom/skydoves/colorpickerview/flag/FlagMode;

    .line 25
    new-instance v0, Lcom/skydoves/colorpickerview/flag/FlagMode;

    const-string v1, "LAST"

    const/4 v3, 0x1

    invoke-direct {v0, v1, v3}, Lcom/skydoves/colorpickerview/flag/FlagMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/skydoves/colorpickerview/flag/FlagMode;->LAST:Lcom/skydoves/colorpickerview/flag/FlagMode;

    .line 28
    new-instance v0, Lcom/skydoves/colorpickerview/flag/FlagMode;

    const-string v1, "FADE"

    const/4 v4, 0x2

    invoke-direct {v0, v1, v4}, Lcom/skydoves/colorpickerview/flag/FlagMode;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/skydoves/colorpickerview/flag/FlagMode;->FADE:Lcom/skydoves/colorpickerview/flag/FlagMode;

    .line 20
    const/4 v1, 0x3

    new-array v1, v1, [Lcom/skydoves/colorpickerview/flag/FlagMode;

    sget-object v5, Lcom/skydoves/colorpickerview/flag/FlagMode;->ALWAYS:Lcom/skydoves/colorpickerview/flag/FlagMode;

    aput-object v5, v1, v2

    sget-object v2, Lcom/skydoves/colorpickerview/flag/FlagMode;->LAST:Lcom/skydoves/colorpickerview/flag/FlagMode;

    aput-object v2, v1, v3

    aput-object v0, v1, v4

    sput-object v1, Lcom/skydoves/colorpickerview/flag/FlagMode;->$VALUES:[Lcom/skydoves/colorpickerview/flag/FlagMode;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 20
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/skydoves/colorpickerview/flag/FlagMode;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 20
    const-class v0, Lcom/skydoves/colorpickerview/flag/FlagMode;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/skydoves/colorpickerview/flag/FlagMode;

    return-object v0
.end method

.method public static values()[Lcom/skydoves/colorpickerview/flag/FlagMode;
    .locals 1

    .line 20
    sget-object v0, Lcom/skydoves/colorpickerview/flag/FlagMode;->$VALUES:[Lcom/skydoves/colorpickerview/flag/FlagMode;

    invoke-virtual {v0}, [Lcom/skydoves/colorpickerview/flag/FlagMode;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/skydoves/colorpickerview/flag/FlagMode;

    return-object v0
.end method
