.class Lcom/skydoves/colorpickerview/ColorUtils;
.super Ljava/lang/Object;
.source "ColorUtils.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getColorARGB(I)[I
    .locals 3
    .param p0, "color"    # I

    .line 36
    const/4 v0, 0x4

    new-array v0, v0, [I

    .line 37
    .local v0, "argb":[I
    invoke-static {p0}, Landroid/graphics/Color;->alpha(I)I

    move-result v1

    const/4 v2, 0x0

    aput v1, v0, v2

    .line 38
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v1

    const/4 v2, 0x1

    aput v1, v0, v2

    .line 39
    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v1

    const/4 v2, 0x2

    aput v1, v0, v2

    .line 40
    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result v1

    const/4 v2, 0x3

    aput v1, v0, v2

    .line 41
    return-object v0
.end method

.method public static getHexCode(I)Ljava/lang/String;
    .locals 8
    .param p0, "color"    # I

    .line 27
    invoke-static {p0}, Landroid/graphics/Color;->alpha(I)I

    move-result v0

    .line 28
    .local v0, "a":I
    invoke-static {p0}, Landroid/graphics/Color;->red(I)I

    move-result v1

    .line 29
    .local v1, "r":I
    invoke-static {p0}, Landroid/graphics/Color;->green(I)I

    move-result v2

    .line 30
    .local v2, "g":I
    invoke-static {p0}, Landroid/graphics/Color;->blue(I)I

    move-result v3

    .line 31
    .local v3, "b":I
    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v4

    const/4 v5, 0x4

    new-array v5, v5, [Ljava/lang/Object;

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/4 v7, 0x0

    aput-object v6, v5, v7

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/4 v7, 0x1

    aput-object v6, v5, v7

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/4 v7, 0x2

    aput-object v6, v5, v7

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v6

    const/4 v7, 0x3

    aput-object v6, v5, v7

    const-string v6, "%02X%02X%02X%02X"

    invoke-static {v4, v6, v5}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    return-object v4
.end method
