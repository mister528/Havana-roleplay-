.class public Lnet/lingala/zip4j/util/Zip4jUtil;
.super Ljava/lang/Object;
.source "Zip4jUtil.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static checkArrayListTypes(Ljava/util/ArrayList;I)Z
    .locals 3
    .param p0, "sourceList"    # Ljava/util/ArrayList;
    .param p1, "type"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 515
    if-eqz p0, :cond_7

    .line 519
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x1

    if-gtz v0, :cond_0

    .line 520
    return v1

    .line 523
    :cond_0
    const/4 v0, 0x0

    .line 525
    .local v0, "invalidFound":Z
    if-eq p1, v1, :cond_4

    const/4 v1, 0x2

    if-eq p1, v1, :cond_1

    goto :goto_4

    .line 535
    :cond_1
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_3

    .line 536
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    instance-of v2, v2, Ljava/lang/String;

    if-nez v2, :cond_2

    .line 537
    const/4 v0, 0x1

    .line 538
    goto :goto_1

    .line 535
    :cond_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 541
    .end local v1    # "i":I
    :cond_3
    :goto_1
    goto :goto_4

    .line 527
    :cond_4
    const/4 v1, 0x0

    .restart local v1    # "i":I
    :goto_2
    invoke-virtual {p0}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_6

    .line 528
    invoke-virtual {p0, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    instance-of v2, v2, Ljava/io/File;

    if-nez v2, :cond_5

    .line 529
    const/4 v0, 0x1

    .line 530
    goto :goto_3

    .line 527
    :cond_5
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 533
    .end local v1    # "i":I
    :cond_6
    :goto_3
    nop

    .line 545
    :goto_4
    xor-int/lit8 v1, v0, 0x1

    return v1

    .line 516
    .end local v0    # "invalidFound":Z
    :cond_7
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input arraylist is null, cannot check types"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_6

    :goto_5
    throw v0

    :goto_6
    goto :goto_5
.end method

.method public static checkFileExists(Ljava/io/File;)Z
    .locals 2
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 128
    if-eqz p0, :cond_0

    .line 131
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    return v0

    .line 129
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "cannot check if file exists: input file is null"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static checkFileExists(Ljava/lang/String;)Z
    .locals 2
    .param p0, "path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 119
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 123
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 124
    .local v0, "file":Ljava/io/File;
    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/io/File;)Z

    move-result v1

    return v1

    .line 120
    .end local v0    # "file":Ljava/io/File;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "path is null"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static checkFileReadAccess(Ljava/lang/String;)Z
    .locals 3
    .param p0, "path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 85
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 89
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 94
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 95
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->canRead()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .line 96
    .end local v0    # "file":Ljava/io/File;
    :catch_0
    move-exception v0

    .line 97
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "cannot read zip file"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 90
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file does not exist: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 86
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "path is null"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static checkFileWriteAccess(Ljava/lang/String;)Z
    .locals 3
    .param p0, "path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 102
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 106
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 111
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 112
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->canWrite()Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    .line 113
    .end local v0    # "file":Ljava/io/File;
    :catch_0
    move-exception v0

    .line 114
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "cannot read zip file"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 107
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file does not exist: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 103
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "path is null"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static checkOutputFolder(Ljava/lang/String;)Z
    .locals 4
    .param p0, "path"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 43
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    .line 47
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 49
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    const-string v2, "output folder is not valid"

    if-eqz v1, :cond_2

    .line 51
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 55
    invoke-virtual {v0}, Ljava/io/File;->canWrite()Z

    move-result v1

    if-eqz v1, :cond_0

    goto :goto_0

    .line 56
    :cond_0
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "no write access to output folder"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 52
    :cond_1
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 60
    :cond_2
    :try_start_0
    invoke-virtual {v0}, Ljava/io/File;->mkdirs()Z

    .line 61
    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v1

    if-eqz v1, :cond_4

    .line 65
    invoke-virtual {v0}, Ljava/io/File;->canWrite()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 78
    nop

    .line 81
    :goto_0
    const/4 v1, 0x1

    return v1

    .line 66
    :cond_3
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "no write access to destination folder"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v0    # "file":Ljava/io/File;
    .end local p0    # "path":Ljava/lang/String;
    throw v1

    .line 62
    .restart local v0    # "file":Ljava/io/File;
    .restart local p0    # "path":Ljava/lang/String;
    :cond_4
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v0    # "file":Ljava/io/File;
    .end local p0    # "path":Ljava/lang/String;
    throw v1
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 76
    .restart local v0    # "file":Ljava/io/File;
    .restart local p0    # "path":Ljava/lang/String;
    :catch_0
    move-exception v1

    .line 77
    .local v1, "e":Ljava/lang/Exception;
    new-instance v2, Lnet/lingala/zip4j/exception/ZipException;

    const-string v3, "Cannot create destination folder"

    invoke-direct {v2, v3}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 44
    .end local v0    # "file":Ljava/io/File;
    .end local v1    # "e":Ljava/lang/Exception;
    :cond_5
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/NullPointerException;

    const-string v2, "output path is null"

    invoke-direct {v1, v2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v0
.end method

.method public static convertCharset(Ljava/lang/String;)[B
    .locals 5
    .param p0, "str"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 439
    const-string v0, "UTF8"

    const-string v1, "Cp850"

    const/4 v2, 0x0

    .line 440
    .local v2, "converted":[B
    :try_start_0
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->detectCharSet(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 441
    .local v3, "charSet":Ljava/lang/String;
    invoke-virtual {v3, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 442
    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .end local v2    # "converted":[B
    .local v0, "converted":[B
    goto :goto_0

    .line 443
    .end local v0    # "converted":[B
    .restart local v2    # "converted":[B
    :cond_0
    invoke-virtual {v3, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 444
    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    .end local v2    # "converted":[B
    .restart local v0    # "converted":[B
    goto :goto_0

    .line 446
    .end local v0    # "converted":[B
    .restart local v2    # "converted":[B
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 448
    .end local v2    # "converted":[B
    .restart local v0    # "converted":[B
    :goto_0
    return-object v0

    .line 452
    .end local v0    # "converted":[B
    .end local v3    # "charSet":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 453
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 450
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 451
    .local v0, "err":Ljava/io/UnsupportedEncodingException;
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    return-object v1
.end method

.method public static decodeFileName([BZ)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # [B
    .param p1, "isUTF8"    # Z

    .line 467
    if-eqz p1, :cond_0

    .line 469
    :try_start_0
    new-instance v0, Ljava/lang/String;

    const-string v1, "UTF8"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 470
    :catch_0
    move-exception v0

    .line 471
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p0}, Ljava/lang/String;-><init>([B)V

    return-object v1

    .line 474
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->getCp850EncodedString([B)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static detectCharSet(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "str"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 556
    const-string v0, "UTF8"

    const-string v1, "Cp850"

    if-eqz p0, :cond_2

    .line 561
    :try_start_0
    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    .line 562
    .local v2, "byteString":[B
    new-instance v3, Ljava/lang/String;

    invoke-direct {v3, v2, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    .line 564
    .local v3, "tempString":Ljava/lang/String;
    invoke-virtual {p0, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 565
    return-object v1

    .line 568
    :cond_0
    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v1

    .line 569
    .end local v2    # "byteString":[B
    .local v1, "byteString":[B
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v1, v0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    .line 571
    .end local v3    # "tempString":Ljava/lang/String;
    .local v2, "tempString":Ljava/lang/String;
    invoke-virtual {p0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 572
    return-object v0

    .line 575
    :cond_1
    sget-object v0, Lnet/lingala/zip4j/util/InternalZipConstants;->CHARSET_DEFAULT:Ljava/lang/String;
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 578
    .end local v1    # "byteString":[B
    .end local v2    # "tempString":Ljava/lang/String;
    :catch_0
    move-exception v0

    goto :goto_0

    .line 576
    :catch_1
    move-exception v0

    goto :goto_1

    .line 579
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    sget-object v1, Lnet/lingala/zip4j/util/InternalZipConstants;->CHARSET_DEFAULT:Ljava/lang/String;

    return-object v1

    .line 577
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    :goto_1
    sget-object v1, Lnet/lingala/zip4j/util/InternalZipConstants;->CHARSET_DEFAULT:Ljava/lang/String;

    return-object v1

    .line 557
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input string is null, cannot detect charset"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static dosToJavaTme(I)J
    .locals 14
    .param p0, "dosTime"    # I

    .line 280
    and-int/lit8 v0, p0, 0x1f

    mul-int/lit8 v0, v0, 0x2

    .line 281
    .local v0, "sec":I
    shr-int/lit8 v1, p0, 0x5

    and-int/lit8 v8, v1, 0x3f

    .line 282
    .local v8, "min":I
    shr-int/lit8 v1, p0, 0xb

    and-int/lit8 v9, v1, 0x1f

    .line 283
    .local v9, "hrs":I
    shr-int/lit8 v1, p0, 0x10

    and-int/lit8 v10, v1, 0x1f

    .line 284
    .local v10, "day":I
    shr-int/lit8 v1, p0, 0x15

    and-int/lit8 v1, v1, 0xf

    add-int/lit8 v11, v1, -0x1

    .line 285
    .local v11, "mon":I
    shr-int/lit8 v1, p0, 0x19

    and-int/lit8 v1, v1, 0x7f

    add-int/lit16 v12, v1, 0x7bc

    .line 287
    .local v12, "year":I
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v13

    .line 288
    .local v13, "cal":Ljava/util/Calendar;
    move-object v1, v13

    move v2, v12

    move v3, v11

    move v4, v10

    move v5, v9

    move v6, v8

    move v7, v0

    invoke-virtual/range {v1 .. v7}, Ljava/util/Calendar;->set(IIIIII)V

    .line 289
    const/16 v1, 0xe

    const/4 v2, 0x0

    invoke-virtual {v13, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 290
    invoke-virtual {v13}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/Date;->getTime()J

    move-result-wide v1

    return-wide v1
.end method

.method public static getAbsoluteFilePath(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p0, "filePath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 499
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 503
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 504
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 500
    .end local v0    # "file":Ljava/io/File;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "filePath is null or empty, cannot get absolute file path"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getAllHeaderSignatures()[J
    .locals 6

    .line 757
    const/16 v0, 0xb

    new-array v0, v0, [J

    .line 759
    .local v0, "allSigs":[J
    const/4 v1, 0x0

    const-wide/32 v2, 0x4034b50

    aput-wide v2, v0, v1

    .line 760
    const/4 v1, 0x1

    const-wide/32 v2, 0x8074b50

    aput-wide v2, v0, v1

    .line 761
    const/4 v1, 0x2

    const-wide/32 v4, 0x2014b50    # 1.6619997E-316

    aput-wide v4, v0, v1

    .line 762
    const/4 v1, 0x3

    const-wide/32 v4, 0x6054b50

    aput-wide v4, v0, v1

    .line 763
    const/4 v1, 0x4

    const-wide/32 v4, 0x5054b50

    aput-wide v4, v0, v1

    .line 764
    const/4 v1, 0x5

    const-wide/32 v4, 0x8064b50

    aput-wide v4, v0, v1

    .line 765
    const/4 v1, 0x6

    aput-wide v2, v0, v1

    .line 766
    const/4 v1, 0x7

    const-wide/32 v2, 0x7064b50

    aput-wide v2, v0, v1

    .line 767
    const/16 v1, 0x8

    const-wide/32 v2, 0x6064b50

    aput-wide v2, v0, v1

    .line 768
    const/16 v1, 0x9

    const-wide/16 v2, 0x1

    aput-wide v2, v0, v1

    .line 769
    const/16 v1, 0xa

    const-wide/32 v2, 0x9901

    aput-wide v2, v0, v1

    .line 771
    return-object v0
.end method

.method public static getCp850EncodedString([B)Ljava/lang/String;
    .locals 2
    .param p0, "data"    # [B

    .line 486
    :try_start_0
    new-instance v0, Ljava/lang/String;

    const-string v1, "Cp850"

    invoke-direct {v0, p0, v1}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    .line 487
    .local v0, "retString":Ljava/lang/String;
    return-object v0

    .line 488
    .end local v0    # "retString":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 489
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    new-instance v1, Ljava/lang/String;

    invoke-direct {v1, p0}, Ljava/lang/String;-><init>([B)V

    return-object v1
.end method

.method public static getEncodedStringLength(Ljava/lang/String;)I
    .locals 2
    .param p0, "str"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 592
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 596
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->detectCharSet(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 597
    .local v0, "charset":Ljava/lang/String;
    invoke-static {p0, v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->getEncodedStringLength(Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    return v1

    .line 593
    .end local v0    # "charset":Ljava/lang/String;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input string is null, cannot calculate encoded String length"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getEncodedStringLength(Ljava/lang/String;Ljava/lang/String;)I
    .locals 4
    .param p0, "str"    # Ljava/lang/String;
    .param p1, "charset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 608
    const-string v0, "UTF8"

    const-string v1, "Cp850"

    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 612
    invoke-static {p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 616
    const/4 v2, 0x0

    .line 619
    .local v2, "byteBuffer":Ljava/nio/ByteBuffer;
    :try_start_0
    invoke-virtual {p1, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 620
    invoke-virtual {p0, v1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .end local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    .local v0, "byteBuffer":Ljava/nio/ByteBuffer;
    goto :goto_2

    .line 621
    .end local v0    # "byteBuffer":Ljava/nio/ByteBuffer;
    .restart local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    :cond_0
    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 622
    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .end local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    .restart local v0    # "byteBuffer":Ljava/nio/ByteBuffer;
    goto :goto_2

    .line 624
    .end local v0    # "byteBuffer":Ljava/nio/ByteBuffer;
    .restart local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    :cond_1
    invoke-virtual {p0, p1}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    .restart local v0    # "byteBuffer":Ljava/nio/ByteBuffer;
    goto :goto_2

    .line 628
    .end local v0    # "byteBuffer":Ljava/nio/ByteBuffer;
    .restart local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    :catch_0
    move-exception v0

    goto :goto_0

    .line 626
    :catch_1
    move-exception v0

    goto :goto_1

    .line 629
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 627
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    :goto_1
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 630
    .end local v2    # "byteBuffer":Ljava/nio/ByteBuffer;
    .local v0, "byteBuffer":Ljava/nio/ByteBuffer;
    :goto_2
    nop

    .line 632
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->limit()I

    move-result v1

    return v1

    .line 613
    .end local v0    # "byteBuffer":Ljava/nio/ByteBuffer;
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "encoding is not defined, cannot calculate string length"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 609
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input string is null, cannot calculate encoded String length"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getFileHeader(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;
    .locals 3
    .param p0, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p1, "fileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 294
    if-eqz p0, :cond_2

    .line 298
    invoke-static {p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 302
    const/4 v0, 0x0

    .line 303
    .local v0, "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    invoke-static {p0, p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileHeaderWithExactMatch(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;

    move-result-object v0

    .line 305
    if-nez v0, :cond_0

    .line 306
    const-string v1, "\\\\"

    const-string v2, "/"

    invoke-virtual {p1, v1, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 307
    invoke-static {p0, p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileHeaderWithExactMatch(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;

    move-result-object v0

    .line 309
    if-nez v0, :cond_0

    .line 310
    invoke-virtual {p1, v2, v1}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 311
    invoke-static {p0, p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileHeaderWithExactMatch(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;

    move-result-object v0

    .line 315
    :cond_0
    return-object v0

    .line 299
    .end local v0    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file name is null, cannot determine file header for fileName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 295
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "zip model is null, cannot determine file header for fileName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getFileHeaderWithExactMatch(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;
    .locals 6
    .param p0, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p1, "fileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 319
    if-eqz p0, :cond_7

    .line 323
    invoke-static {p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 327
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 331
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    if-eqz v0, :cond_4

    .line 335
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    if-gtz v0, :cond_0

    .line 336
    return-object v1

    .line 338
    :cond_0
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    .line 339
    .local v0, "fileHeaders":Ljava/util/ArrayList;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_3

    .line 340
    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lnet/lingala/zip4j/model/FileHeader;

    .line 341
    .local v3, "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    invoke-virtual {v3}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v4

    .line 342
    .local v4, "fileNameForHdr":Ljava/lang/String;
    invoke-static {v4}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_1

    .line 343
    goto :goto_1

    .line 346
    :cond_1
    invoke-virtual {p1, v4}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_2

    .line 347
    return-object v3

    .line 339
    .end local v3    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local v4    # "fileNameForHdr":Ljava/lang/String;
    :cond_2
    :goto_1
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 351
    .end local v2    # "i":I
    :cond_3
    return-object v1

    .line 332
    .end local v0    # "fileHeaders":Ljava/util/ArrayList;
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file Headers are null, cannot determine file header with exact match for fileName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 328
    :cond_5
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "central directory is null, cannot determine file header with exact match for fileName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 324
    :cond_6
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "file name is null, cannot determine file header with exact match for fileName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 320
    :cond_7
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "zip model is null, cannot determine file header with exact match for fileName: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method public static getFileLengh(Ljava/io/File;)J
    .locals 2
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 244
    if-eqz p0, :cond_1

    .line 248
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 249
    const-wide/16 v0, -0x1

    return-wide v0

    .line 252
    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->length()J

    move-result-wide v0

    return-wide v0

    .line 245
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file is null, cannot calculate file length"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getFileLengh(Ljava/lang/String;)J
    .locals 2
    .param p0, "file"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 236
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 240
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v0

    return-wide v0

    .line 237
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "invalid file name"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getFileNameFromFilePath(Ljava/io/File;)Ljava/lang/String;
    .locals 2
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 224
    if-eqz p0, :cond_1

    .line 228
    invoke-virtual {p0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 229
    const/4 v0, 0x0

    return-object v0

    .line 232
    :cond_0
    invoke-virtual {p0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 225
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file is null, cannot get file name"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getFilesInDirectoryRec(Ljava/io/File;Z)Ljava/util/ArrayList;
    .locals 6
    .param p0, "path"    # Ljava/io/File;
    .param p1, "readHiddenFiles"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 396
    if-eqz p0, :cond_4

    .line 400
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 401
    .local v0, "result":Ljava/util/ArrayList;
    invoke-virtual {p0}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v1

    .line 402
    .local v1, "filesAndDirs":[Ljava/io/File;
    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v2

    .line 404
    .local v2, "filesDirs":Ljava/util/List;
    invoke-virtual {p0}, Ljava/io/File;->canRead()Z

    move-result v3

    if-nez v3, :cond_0

    .line 405
    return-object v0

    .line 408
    :cond_0
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v4

    if-ge v3, v4, :cond_3

    .line 409
    invoke-interface {v2, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/io/File;

    .line 410
    .local v4, "file":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->isHidden()Z

    move-result v5

    if-eqz v5, :cond_1

    if-nez p1, :cond_1

    .line 411
    return-object v0

    .line 413
    :cond_1
    invoke-virtual {v0, v4}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 414
    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 415
    invoke-static {v4, p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFilesInDirectoryRec(Ljava/io/File;Z)Ljava/util/ArrayList;

    move-result-object v5

    .line 416
    .local v5, "deeperList":Ljava/util/List;
    invoke-virtual {v0, v5}, Ljava/util/ArrayList;->addAll(Ljava/util/Collection;)Z

    .line 408
    .end local v4    # "file":Ljava/io/File;
    .end local v5    # "deeperList":Ljava/util/List;
    :cond_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 419
    .end local v3    # "i":I
    :cond_3
    return-object v0

    .line 397
    .end local v0    # "result":Ljava/util/ArrayList;
    .end local v1    # "filesAndDirs":[Ljava/io/File;
    .end local v2    # "filesDirs":Ljava/util/List;
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input path is null, cannot read files in the directory"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method public static getIndexOfFileHeader(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;)I
    .locals 7
    .param p0, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p1, "fileHeader"    # Lnet/lingala/zip4j/model/FileHeader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 357
    if-eqz p0, :cond_7

    if-eqz p1, :cond_7

    .line 361
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    if-eqz v0, :cond_6

    .line 365
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    if-eqz v0, :cond_5

    .line 369
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, -0x1

    if-gtz v0, :cond_0

    .line 370
    return v1

    .line 372
    :cond_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v0

    .line 374
    .local v0, "fileName":Ljava/lang/String;
    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    .line 378
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v2

    .line 379
    .local v2, "fileHeaders":Ljava/util/ArrayList;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v4

    if-ge v3, v4, :cond_3

    .line 380
    invoke-virtual {v2, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lnet/lingala/zip4j/model/FileHeader;

    .line 381
    .local v4, "fileHeaderTmp":Lnet/lingala/zip4j/model/FileHeader;
    invoke-virtual {v4}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v5

    .line 382
    .local v5, "fileNameForHdr":Ljava/lang/String;
    invoke-static {v5}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 383
    goto :goto_1

    .line 386
    :cond_1
    invoke-virtual {v0, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    .line 387
    return v3

    .line 379
    .end local v4    # "fileHeaderTmp":Lnet/lingala/zip4j/model/FileHeader;
    .end local v5    # "fileNameForHdr":Ljava/lang/String;
    :cond_2
    :goto_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 390
    .end local v3    # "i":I
    :cond_3
    return v1

    .line 375
    .end local v2    # "fileHeaders":Ljava/util/ArrayList;
    :cond_4
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "file name in file header is empty or null, cannot determine index of file header"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 366
    .end local v0    # "fileName":Ljava/lang/String;
    :cond_5
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "file Headers are null, cannot determine index of file header"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 362
    :cond_6
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "central directory is null, ccannot determine index of file header"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 358
    :cond_7
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input parameters is null, cannot determine index of file header"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method public static getLastModifiedFileTime(Ljava/io/File;Ljava/util/TimeZone;)J
    .locals 2
    .param p0, "file"    # Ljava/io/File;
    .param p1, "timeZone"    # Ljava/util/TimeZone;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 212
    if-eqz p0, :cond_1

    .line 216
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 220
    invoke-virtual {p0}, Ljava/io/File;->lastModified()J

    move-result-wide v0

    return-wide v0

    .line 217
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file does not exist, cannot read last modified file time"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 213
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file is null, cannot read last modified file time"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getRelativeFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "file"    # Ljava/lang/String;
    .param p1, "rootFolderInZip"    # Ljava/lang/String;
    .param p2, "rootFolderPath"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 703
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    .line 707
    const/4 v0, 0x0

    .line 709
    .local v0, "fileName":Ljava/lang/String;
    invoke-static {p2}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v1

    const-string v2, "/"

    if-eqz v1, :cond_3

    .line 711
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 713
    .local v1, "rootFolderFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    .line 715
    .local v3, "rootFolderFileRef":Ljava/lang/String;
    sget-object v4, Lnet/lingala/zip4j/util/InternalZipConstants;->FILE_SEPARATOR:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 716
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    sget-object v5, Lnet/lingala/zip4j/util/InternalZipConstants;->FILE_SEPARATOR:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 719
    :cond_0
    invoke-virtual {v3}, Ljava/lang/String;->length()I

    move-result v4

    invoke-virtual {p0, v4}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 720
    .local v4, "tmpFileName":Ljava/lang/String;
    const-string v5, "file.separator"

    invoke-static {v5}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 721
    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v4

    .line 724
    :cond_1
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 726
    .local v5, "tmpFile":Ljava/io/File;
    invoke-virtual {v5}, Ljava/io/File;->isDirectory()Z

    move-result v6

    const-string v7, "\\\\"

    if-eqz v6, :cond_2

    .line 727
    invoke-virtual {v4, v7, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 728
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .end local v4    # "tmpFileName":Ljava/lang/String;
    .local v2, "tmpFileName":Ljava/lang/String;
    goto :goto_0

    .line 730
    .end local v2    # "tmpFileName":Ljava/lang/String;
    .restart local v4    # "tmpFileName":Ljava/lang/String;
    :cond_2
    const/4 v6, 0x0

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v4, v8}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v8

    invoke-virtual {v4, v6, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v6

    .line 731
    .local v6, "bkFileName":Ljava/lang/String;
    invoke-virtual {v6, v7, v2}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 732
    .end local v6    # "bkFileName":Ljava/lang/String;
    .local v2, "bkFileName":Ljava/lang/String;
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    move-object v2, v4

    .line 735
    .end local v4    # "tmpFileName":Ljava/lang/String;
    .local v2, "tmpFileName":Ljava/lang/String;
    :goto_0
    move-object v0, v2

    .line 736
    .end local v1    # "rootFolderFile":Ljava/io/File;
    .end local v2    # "tmpFileName":Ljava/lang/String;
    .end local v3    # "rootFolderFileRef":Ljava/lang/String;
    .end local v5    # "tmpFile":Ljava/io/File;
    goto :goto_1

    .line 737
    :cond_3
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 738
    .local v1, "relFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v3

    if-eqz v3, :cond_4

    .line 739
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_1

    .line 741
    :cond_4
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v2}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileNameFromFilePath(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    .line 745
    .end local v1    # "relFile":Ljava/io/File;
    :goto_1
    invoke-static {p1}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    .line 746
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 749
    :cond_5
    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    .line 753
    return-object v0

    .line 750
    :cond_6
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "Error determining file name"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 704
    .end local v0    # "fileName":Ljava/lang/String;
    :cond_7
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file path/name is empty, cannot calculate relative file name"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static getSplitZipFiles(Lnet/lingala/zip4j/model/ZipModel;)Ljava/util/ArrayList;
    .locals 9
    .param p0, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 657
    if-eqz p0, :cond_8

    .line 661
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    if-nez v0, :cond_0

    .line 662
    const/4 v0, 0x0

    return-object v0

    .line 665
    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 666
    .local v0, "retList":Ljava/util/ArrayList;
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v1

    .line 667
    .local v1, "currZipFile":Ljava/lang/String;
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    .line 668
    .local v2, "zipFileName":Ljava/lang/String;
    const/4 v3, 0x0

    .line 670
    .local v3, "partFile":Ljava/lang/String;
    invoke-static {v1}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    .line 674
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->isSplitArchive()Z

    move-result v4

    if-nez v4, :cond_1

    .line 675
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 676
    return-object v0

    .line 679
    :cond_1
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v4

    invoke-virtual {v4}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v4

    .line 681
    .local v4, "numberOfThisDisk":I
    if-nez v4, :cond_2

    .line 682
    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 683
    return-object v0

    .line 685
    :cond_2
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    if-gt v5, v4, :cond_6

    .line 686
    if-ne v5, v4, :cond_3

    .line 687
    invoke-virtual {p0}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v0, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_2

    .line 689
    :cond_3
    const-string v6, ".z0"

    .line 690
    .local v6, "fileExt":Ljava/lang/String;
    const/16 v7, 0x9

    if-le v5, v7, :cond_4

    .line 691
    const-string v6, ".z"

    .line 693
    :cond_4
    const-string v7, "."

    invoke-virtual {v2, v7}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v8

    if-ltz v8, :cond_5

    const/4 v8, 0x0

    invoke-virtual {v1, v7}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v1, v8, v7}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v7

    goto :goto_1

    :cond_5
    move-object v7, v1

    :goto_1
    move-object v3, v7

    .line 694
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v7, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v7, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v8, v5, 0x1

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 695
    invoke-virtual {v0, v3}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 685
    .end local v6    # "fileExt":Ljava/lang/String;
    :goto_2
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 699
    .end local v5    # "i":I
    :cond_6
    return-object v0

    .line 671
    .end local v4    # "numberOfThisDisk":I
    :cond_7
    new-instance v4, Lnet/lingala/zip4j/exception/ZipException;

    const-string v5, "cannot get split zip files: zipfile is null"

    invoke-direct {v4, v5}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v4

    .line 658
    .end local v0    # "retList":Ljava/util/ArrayList;
    .end local v1    # "currZipFile":Ljava/lang/String;
    .end local v2    # "zipFileName":Ljava/lang/String;
    .end local v3    # "partFile":Ljava/lang/String;
    :cond_8
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "cannot get split zip files: zipmodel is null"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_4

    :goto_3
    throw v0

    :goto_4
    goto :goto_3
.end method

.method public static getZipFileNameWithoutExt(Ljava/lang/String;)Ljava/lang/String;
    .locals 3
    .param p0, "zipFile"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 423
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_2

    .line 426
    move-object v0, p0

    .line 427
    .local v0, "tmpFileName":Ljava/lang/String;
    const-string v1, "file.separator"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {p0, v2}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-ltz v2, :cond_0

    .line 428
    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    .line 431
    :cond_0
    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v2

    if-lez v2, :cond_1

    .line 432
    const/4 v2, 0x0

    invoke-virtual {v0, v1}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v2, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 434
    :cond_1
    return-object v0

    .line 424
    .end local v0    # "tmpFileName":Ljava/lang/String;
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip file name is empty or null, cannot determine zip file name"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static isStringNotNullAndNotEmpty(Ljava/lang/String;)Z
    .locals 1
    .param p0, "str"    # Ljava/lang/String;

    .line 35
    if-eqz p0, :cond_1

    invoke-virtual {p0}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v0

    if-gtz v0, :cond_0

    goto :goto_0

    .line 39
    :cond_0
    const/4 v0, 0x1

    return v0

    .line 36
    :cond_1
    :goto_0
    const/4 v0, 0x0

    return v0
.end method

.method public static isSupportedCharset(Ljava/lang/String;)Z
    .locals 2
    .param p0, "charset"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 642
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 647
    :try_start_0
    new-instance v0, Ljava/lang/String;

    const-string v1, "a"

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    invoke-direct {v0, v1, p0}, Ljava/lang/String;-><init>([BLjava/lang/String;)V
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 648
    const/4 v0, 0x1

    return v0

    .line 651
    :catch_0
    move-exception v0

    .line 652
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 649
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 650
    .local v0, "e":Ljava/io/UnsupportedEncodingException;
    const/4 v1, 0x0

    return v1

    .line 643
    .end local v0    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "charset is null or empty, cannot check if it is supported"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static isWindows()Z
    .locals 2

    .line 135
    const-string v0, "os.name"

    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    .line 136
    .local v0, "os":Ljava/lang/String;
    const-string v1, "win"

    invoke-virtual {v0, v1}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v1

    if-ltz v1, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public static javaToDosTime(J)J
    .locals 7
    .param p0, "time"    # J

    .line 262
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 263
    .local v0, "cal":Ljava/util/Calendar;
    invoke-virtual {v0, p0, p1}, Ljava/util/Calendar;->setTimeInMillis(J)V

    .line 265
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v2

    .line 266
    .local v2, "year":I
    const/16 v3, 0x7bc

    if-ge v2, v3, :cond_0

    .line 267
    const-wide/32 v3, 0x210000

    return-wide v3

    .line 269
    :cond_0
    add-int/lit16 v3, v2, -0x7bc

    shl-int/lit8 v3, v3, 0x19

    const/4 v4, 0x2

    invoke-virtual {v0, v4}, Ljava/util/Calendar;->get(I)I

    move-result v4

    add-int/2addr v4, v1

    shl-int/lit8 v4, v4, 0x15

    or-int/2addr v3, v4

    const/4 v4, 0x5

    invoke-virtual {v0, v4}, Ljava/util/Calendar;->get(I)I

    move-result v5

    shl-int/lit8 v5, v5, 0x10

    or-int/2addr v3, v5

    const/16 v5, 0xb

    invoke-virtual {v0, v5}, Ljava/util/Calendar;->get(I)I

    move-result v6

    shl-int/lit8 v5, v6, 0xb

    or-int/2addr v3, v5

    const/16 v5, 0xc

    invoke-virtual {v0, v5}, Ljava/util/Calendar;->get(I)I

    move-result v5

    shl-int/lit8 v4, v5, 0x5

    or-int/2addr v3, v4

    const/16 v4, 0xd

    invoke-virtual {v0, v4}, Ljava/util/Calendar;->get(I)I

    move-result v4

    shr-int/lit8 v1, v4, 0x1

    or-int/2addr v1, v3

    int-to-long v3, v1

    return-wide v3
.end method

.method public static setFileArchive(Ljava/io/File;)V
    .locals 0
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 190
    return-void
.end method

.method public static setFileHidden(Ljava/io/File;)V
    .locals 0
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 166
    return-void
.end method

.method public static setFileReadOnly(Ljava/io/File;)V
    .locals 2
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 140
    if-eqz p0, :cond_1

    .line 144
    invoke-virtual {p0}, Ljava/io/File;->exists()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 145
    invoke-virtual {p0}, Ljava/io/File;->setReadOnly()Z

    .line 147
    :cond_0
    return-void

    .line 141
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file is null. cannot set read only file attribute"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static setFileSystemMode(Ljava/io/File;)V
    .locals 0
    .param p0, "file"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 209
    return-void
.end method
