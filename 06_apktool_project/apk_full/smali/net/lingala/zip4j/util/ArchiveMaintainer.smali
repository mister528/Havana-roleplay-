.class public Lnet/lingala/zip4j/util/ArchiveMaintainer;
.super Ljava/lang/Object;
.source "ArchiveMaintainer.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    return-void
.end method

.method static synthetic access$000(Lnet/lingala/zip4j/util/ArchiveMaintainer;Lnet/lingala/zip4j/model/ZipModel;Ljava/io/File;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 0
    .param p0, "x0"    # Lnet/lingala/zip4j/util/ArchiveMaintainer;
    .param p1, "x1"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "x2"    # Ljava/io/File;
    .param p3, "x3"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 40
    invoke-direct {p0, p1, p2, p3}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->initMergeSplitZipFile(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/File;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    return-void
.end method

.method private calculateTotalWorkForMergeOp(Lnet/lingala/zip4j/model/ZipModel;)J
    .locals 10
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 704
    const-wide/16 v0, 0x0

    .line 705
    .local v0, "totSize":J
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isSplitArchive()Z

    move-result v2

    if-eqz v2, :cond_2

    .line 706
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v2

    .line 707
    .local v2, "totNoOfSplitFiles":I
    const/4 v3, 0x0

    .line 708
    .local v3, "partFile":Ljava/lang/String;
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v4

    .line 709
    .local v4, "curZipFile":Ljava/lang/String;
    const/4 v5, 0x0

    .line 710
    .local v5, "partNumber":I
    const/4 v6, 0x0

    .local v6, "i":I
    :goto_0
    if-gt v6, v2, :cond_2

    .line 711
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v7

    invoke-virtual {v7}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v7

    if-ne v5, v7, :cond_0

    .line 712
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 714
    :cond_0
    const/16 v7, 0x9

    const-string v8, "."

    const/4 v9, 0x0

    if-lt v5, v7, :cond_1

    .line 715
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v8}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v8

    invoke-virtual {v4, v9, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, ".z"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v8, v5, 0x1

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_1

    .line 717
    :cond_1
    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v8}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v8

    invoke-virtual {v4, v9, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v8, ".z0"

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v8, v5, 0x1

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 721
    :goto_1
    new-instance v7, Ljava/io/File;

    invoke-direct {v7, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v7}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v7

    add-long/2addr v0, v7

    .line 710
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 725
    .end local v2    # "totNoOfSplitFiles":I
    .end local v3    # "partFile":Ljava/lang/String;
    .end local v4    # "curZipFile":Ljava/lang/String;
    .end local v5    # "partNumber":I
    .end local v6    # "i":I
    :cond_2
    return-wide v0
.end method

.method private calculateTotalWorkForRemoveOp(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;)J
    .locals 4
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileHeader"    # Lnet/lingala/zip4j/model/FileHeader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 689
    new-instance v0, Ljava/io/File;

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v0

    invoke-virtual {p2}, Lnet/lingala/zip4j/model/FileHeader;->getCompressedSize()J

    move-result-wide v2

    sub-long/2addr v0, v2

    return-wide v0
.end method

.method private copyFile(Ljava/io/RandomAccessFile;Ljava/io/OutputStream;JJLnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 17
    .param p1, "inputStream"    # Ljava/io/RandomAccessFile;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "start"    # J
    .param p5, "end"    # J
    .param p7, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 241
    move-object/from16 v1, p1

    move-object/from16 v2, p2

    move-wide/from16 v3, p3

    move-object/from16 v5, p7

    if-eqz v1, :cond_a

    if-eqz v2, :cond_a

    .line 245
    const-wide/16 v6, 0x0

    cmp-long v0, v3, v6

    if-ltz v0, :cond_9

    .line 249
    cmp-long v0, p5, v6

    if-ltz v0, :cond_8

    .line 253
    cmp-long v0, v3, p5

    if-gtz v0, :cond_7

    .line 257
    cmp-long v0, v3, p5

    if-nez v0, :cond_0

    .line 258
    return-void

    .line 261
    :cond_0
    invoke-virtual/range {p7 .. p7}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v0

    const/4 v6, 0x0

    const/4 v7, 0x3

    if-eqz v0, :cond_1

    .line 262
    invoke-virtual {v5, v7}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 263
    invoke-virtual {v5, v6}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V

    .line 264
    return-void

    .line 268
    :cond_1
    :try_start_0
    invoke-virtual {v1, v3, v4}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 270
    const/4 v0, -0x2

    .line 272
    .local v0, "readLen":I
    const-wide/16 v8, 0x0

    .line 273
    .local v8, "bytesRead":J
    sub-long v10, p5, v3

    .line 275
    .local v10, "bytesToRead":J
    sub-long v12, p5, v3

    const-wide/16 v14, 0x1000

    cmp-long v16, v12, v14

    if-gez v16, :cond_2

    .line 276
    sub-long v12, p5, v3

    long-to-int v13, v12

    new-array v12, v13, [B

    .local v12, "buff":[B
    goto :goto_0

    .line 278
    .end local v12    # "buff":[B
    :cond_2
    const/16 v12, 0x1000

    new-array v12, v12, [B

    .line 281
    .restart local v12    # "buff":[B
    :cond_3
    :goto_0
    invoke-virtual {v1, v12}, Ljava/io/RandomAccessFile;->read([B)I

    move-result v13

    move v0, v13

    const/4 v14, -0x1

    if-eq v13, v14, :cond_6

    .line 282
    invoke-virtual {v2, v12, v6, v0}, Ljava/io/OutputStream;->write([BII)V

    .line 284
    int-to-long v13, v0

    invoke-virtual {v5, v13, v14}, Lnet/lingala/zip4j/progress/ProgressMonitor;->updateWorkCompleted(J)V

    .line 285
    invoke-virtual/range {p7 .. p7}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v13

    if-eqz v13, :cond_4

    .line 286
    invoke-virtual {v5, v7}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 287
    return-void

    .line 290
    :cond_4
    int-to-long v13, v0

    add-long/2addr v8, v13

    .line 292
    cmp-long v13, v8, v10

    if-nez v13, :cond_5

    .line 293
    goto :goto_1

    .line 294
    :cond_5
    array-length v13, v12

    int-to-long v13, v13

    add-long/2addr v13, v8

    cmp-long v15, v13, v10

    if-lez v15, :cond_3

    .line 295
    sub-long v13, v10, v8

    long-to-int v14, v13

    new-array v13, v14, [B
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v12, v13

    goto :goto_0

    .line 303
    .end local v0    # "readLen":I
    .end local v8    # "bytesRead":J
    .end local v10    # "bytesToRead":J
    .end local v12    # "buff":[B
    :cond_6
    :goto_1
    nop

    .line 304
    return-void

    .line 301
    :catch_0
    move-exception v0

    .line 302
    .local v0, "e":Ljava/lang/Exception;
    new-instance v6, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v6, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v6

    .line 299
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 300
    .local v0, "e":Ljava/io/IOException;
    new-instance v6, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v6, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v6

    .line 254
    .end local v0    # "e":Ljava/io/IOException;
    :cond_7
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v6, "start offset is greater than end offset, cannot copy file"

    invoke-direct {v0, v6}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 250
    :cond_8
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v6, "end offset is negative, cannot copy file"

    invoke-direct {v0, v6}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 246
    :cond_9
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v6, "starting offset is negative, cannot copy file"

    invoke-direct {v0, v6}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 242
    :cond_a
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v6, "input or output stream is null, cannot copy file"

    invoke-direct {v0, v6}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method private createFileHandler(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Ljava/io/RandomAccessFile;
    .locals 3
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "mode"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 307
    if-eqz p1, :cond_0

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 312
    :try_start_0
    new-instance v0, Ljava/io/RandomAccessFile;

    new-instance v1, Ljava/io/File;

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1, p2}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 313
    :catch_0
    move-exception v0

    .line 314
    .local v0, "e":Ljava/io/FileNotFoundException;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 308
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input parameter is null in getFilePointer, cannot create file handler to remove file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private createSplitZipFileHandler(Lnet/lingala/zip4j/model/ZipModel;I)Ljava/io/RandomAccessFile;
    .locals 6
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "partNumber"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 451
    if-eqz p1, :cond_4

    .line 455
    if-ltz p2, :cond_3

    .line 460
    :try_start_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v0

    .line 461
    .local v0, "curZipFile":Ljava/lang/String;
    const/4 v1, 0x0

    .line 462
    .local v1, "partFile":Ljava/lang/String;
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v2

    if-ne p2, v2, :cond_0

    .line 463
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v2
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v2

    goto :goto_0

    .line 465
    :cond_0
    const/16 v2, 0x9

    const-string v3, "."

    const/4 v4, 0x0

    if-lt p2, v2, :cond_1

    .line 466
    :try_start_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ".z"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, p2, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v1, v2

    goto :goto_0

    .line 468
    :cond_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v3}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v4, v3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ".z0"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v3, p2, 0x1

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v1, v2

    .line 471
    :goto_0
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 473
    .local v2, "tmpFile":Ljava/io/File;
    invoke-static {v2}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/io/File;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 477
    new-instance v3, Ljava/io/RandomAccessFile;

    const-string v4, "r"

    invoke-direct {v3, v2, v4}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    return-object v3

    .line 474
    :cond_2
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "split file does not exist: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "partNumber":I
    throw v3
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 480
    .end local v0    # "curZipFile":Ljava/lang/String;
    .end local v1    # "partFile":Ljava/lang/String;
    .end local v2    # "tmpFile":Ljava/io/File;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "partNumber":I
    :catch_0
    move-exception v0

    .line 481
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 478
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 479
    .local v0, "e":Ljava/io/FileNotFoundException;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 456
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "invlaid part number, cannot create split file handler"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 452
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null, cannot create split file handler"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private initMergeSplitZipFile(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/File;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 24
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputZipFile"    # Ljava/io/File;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 342
    move-object/from16 v9, p0

    move-object/from16 v10, p1

    move-object/from16 v11, p3

    if-eqz v10, :cond_e

    .line 348
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->isSplitArchive()Z

    move-result v0

    if-eqz v0, :cond_d

    .line 354
    const/4 v1, 0x0

    .line 355
    .local v1, "outputStream":Ljava/io/OutputStream;
    const/4 v2, 0x0

    .line 356
    .local v2, "inputStream":Ljava/io/RandomAccessFile;
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    move-object v12, v0

    .line 357
    .local v12, "fileSizeList":Ljava/util/ArrayList;
    const-wide/16 v3, 0x0

    .line 358
    .local v3, "totBytesWritten":J
    const/4 v5, 0x0

    .line 361
    .local v5, "splitSigRemoved":Z
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v0

    move v13, v0

    .line 363
    .local v13, "totNoOfSplitFiles":I
    if-lez v13, :cond_a

    .line 367
    move-object/from16 v14, p2

    invoke-direct {v9, v14}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->prepareOutputStreamForMerge(Ljava/io/File;)Ljava/io/OutputStream;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_16
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_15
    .catchall {:try_start_0 .. :try_end_0} :catchall_8

    move-object v15, v0

    .line 368
    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .local v15, "outputStream":Ljava/io/OutputStream;
    const/4 v0, 0x0

    move v8, v0

    move-wide v6, v3

    .end local v3    # "totBytesWritten":J
    .local v6, "totBytesWritten":J
    .local v8, "i":I
    :goto_0
    if-gt v8, v13, :cond_7

    .line 369
    :try_start_1
    invoke-direct {v9, v10, v8}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->createSplitZipFileHandler(Lnet/lingala/zip4j/model/ZipModel;I)Ljava/io/RandomAccessFile;

    move-result-object v0
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_10
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_f
    .catchall {:try_start_1 .. :try_end_1} :catchall_6

    move-object v4, v0

    .line 371
    .end local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .local v4, "inputStream":Ljava/io/RandomAccessFile;
    const/4 v0, 0x0

    .line 372
    .local v0, "start":I
    :try_start_2
    new-instance v1, Ljava/lang/Long;

    invoke-virtual {v4}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v2

    invoke-direct {v1, v2, v3}, Ljava/lang/Long;-><init>(J)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_e
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_d
    .catchall {:try_start_2 .. :try_end_2} :catchall_5

    .line 374
    .local v1, "end":Ljava/lang/Long;
    const/4 v3, 0x0

    if-nez v8, :cond_1

    .line 375
    :try_start_3
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v2

    if-eqz v2, :cond_0

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-lez v2, :cond_0

    .line 378
    const/4 v2, 0x4

    new-array v2, v2, [B

    .line 379
    .local v2, "buff":[B
    move/from16 v16, v0

    move-object/from16 v17, v1

    .end local v0    # "start":I
    .end local v1    # "end":Ljava/lang/Long;
    .local v16, "start":I
    .local v17, "end":Ljava/lang/Long;
    const-wide/16 v0, 0x0

    invoke-virtual {v4, v0, v1}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 380
    invoke-virtual {v4, v2}, Ljava/io/RandomAccessFile;->read([B)I

    .line 381
    invoke-static {v2, v3}, Lnet/lingala/zip4j/util/Raw;->readIntLittleEndian([BI)I

    move-result v0
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    int-to-long v0, v0

    const-wide/32 v18, 0x8074b50

    cmp-long v20, v0, v18

    if-nez v20, :cond_2

    .line 382
    const/4 v0, 0x4

    .line 383
    .end local v16    # "start":I
    .restart local v0    # "start":I
    const/4 v1, 0x1

    move v5, v0

    move/from16 v16, v1

    .end local v5    # "splitSigRemoved":Z
    .local v1, "splitSigRemoved":Z
    goto :goto_2

    .line 375
    .end local v2    # "buff":[B
    .end local v17    # "end":Ljava/lang/Long;
    .local v1, "end":Ljava/lang/Long;
    .restart local v5    # "splitSigRemoved":Z
    :cond_0
    move/from16 v16, v0

    move-object/from16 v17, v1

    .end local v0    # "start":I
    .end local v1    # "end":Ljava/lang/Long;
    .restart local v16    # "start":I
    .restart local v17    # "end":Ljava/lang/Long;
    goto :goto_1

    .line 426
    .end local v8    # "i":I
    .end local v13    # "totNoOfSplitFiles":I
    .end local v16    # "start":I
    .end local v17    # "end":Ljava/lang/Long;
    :catchall_0
    move-exception v0

    move-object v2, v4

    move-wide v3, v6

    move-object v1, v15

    move-object v6, v0

    goto/16 :goto_c

    .line 422
    :catch_0
    move-exception v0

    move-object v2, v4

    move-wide v3, v6

    move-object v1, v15

    goto/16 :goto_a

    .line 419
    :catch_1
    move-exception v0

    move-object v2, v4

    move-wide v3, v6

    move-object v1, v15

    goto/16 :goto_b

    .line 374
    .restart local v0    # "start":I
    .restart local v1    # "end":Ljava/lang/Long;
    .restart local v8    # "i":I
    .restart local v13    # "totNoOfSplitFiles":I
    :cond_1
    move/from16 v16, v0

    move-object/from16 v17, v1

    .line 388
    .end local v0    # "start":I
    .end local v1    # "end":Ljava/lang/Long;
    .restart local v16    # "start":I
    .restart local v17    # "end":Ljava/lang/Long;
    :cond_2
    :goto_1
    move/from16 v23, v16

    move/from16 v16, v5

    move/from16 v5, v23

    .local v5, "start":I
    .local v16, "splitSigRemoved":Z
    :goto_2
    if-ne v8, v13, :cond_3

    .line 389
    :try_start_4
    new-instance v0, Ljava/lang/Long;

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v1

    invoke-direct {v0, v1, v2}, Ljava/lang/Long;-><init>(J)V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-object v1, v0

    move-object v2, v1

    .end local v17    # "end":Ljava/lang/Long;
    .restart local v1    # "end":Ljava/lang/Long;
    goto :goto_3

    .line 426
    .end local v1    # "end":Ljava/lang/Long;
    .end local v5    # "start":I
    .end local v8    # "i":I
    .end local v13    # "totNoOfSplitFiles":I
    :catchall_1
    move-exception v0

    move-object v2, v4

    move-wide v3, v6

    move-object v1, v15

    move/from16 v5, v16

    move-object v6, v0

    goto/16 :goto_c

    .line 422
    :catch_2
    move-exception v0

    move-object v2, v4

    move-wide v3, v6

    move-object v1, v15

    move/from16 v5, v16

    goto/16 :goto_a

    .line 419
    :catch_3
    move-exception v0

    move-object v2, v4

    move-wide v3, v6

    move-object v1, v15

    move/from16 v5, v16

    goto/16 :goto_b

    .line 388
    .restart local v5    # "start":I
    .restart local v8    # "i":I
    .restart local v13    # "totNoOfSplitFiles":I
    .restart local v17    # "end":Ljava/lang/Long;
    :cond_3
    move-object/from16 v2, v17

    .line 392
    .end local v17    # "end":Ljava/lang/Long;
    .local v2, "end":Ljava/lang/Long;
    :goto_3
    int-to-long v0, v5

    :try_start_5
    invoke-virtual {v2}, Ljava/lang/Long;->longValue()J

    move-result-wide v17
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_c
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_b
    .catchall {:try_start_5 .. :try_end_5} :catchall_4

    move-wide/from16 v19, v0

    move-object/from16 v1, p0

    move-object/from16 v21, v2

    .end local v2    # "end":Ljava/lang/Long;
    .local v21, "end":Ljava/lang/Long;
    move-object v2, v4

    const/4 v0, 0x0

    move-object v3, v15

    move-object/from16 v22, v4

    move v10, v5

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v5    # "start":I
    .local v10, "start":I
    .local v22, "inputStream":Ljava/io/RandomAccessFile;
    move-wide/from16 v4, v19

    move/from16 v19, v13

    move-wide v13, v6

    .end local v6    # "totBytesWritten":J
    .local v13, "totBytesWritten":J
    .local v19, "totNoOfSplitFiles":I
    move-wide/from16 v6, v17

    move/from16 v17, v8

    .end local v8    # "i":I
    .local v17, "i":I
    move-object/from16 v8, p3

    :try_start_6
    invoke-direct/range {v1 .. v8}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->copyFile(Ljava/io/RandomAccessFile;Ljava/io/OutputStream;JJLnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 393
    invoke-virtual/range {v21 .. v21}, Ljava/lang/Long;->longValue()J

    move-result-wide v1
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_a
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_9
    .catchall {:try_start_6 .. :try_end_6} :catchall_3

    int-to-long v3, v10

    sub-long/2addr v1, v3

    add-long v6, v13, v1

    .line 394
    .end local v13    # "totBytesWritten":J
    .restart local v6    # "totBytesWritten":J
    :try_start_7
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v1

    if-eqz v1, :cond_6

    .line 395
    const/4 v1, 0x3

    invoke-virtual {v11, v1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 396
    invoke-virtual {v11, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_8
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_2

    .line 426
    if-eqz v15, :cond_4

    .line 428
    :try_start_8
    invoke-virtual {v15}, Ljava/io/OutputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    .line 431
    goto :goto_4

    .line 429
    :catch_4
    move-exception v0

    .line 434
    :cond_4
    :goto_4
    if-eqz v22, :cond_5

    .line 436
    :try_start_9
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 439
    goto :goto_5

    .line 437
    :catch_5
    move-exception v0

    .line 439
    :cond_5
    :goto_5
    return-void

    .line 400
    :cond_6
    move-object/from16 v1, v21

    .end local v21    # "end":Ljava/lang/Long;
    .restart local v1    # "end":Ljava/lang/Long;
    :try_start_a
    invoke-virtual {v12, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_8
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_7
    .catchall {:try_start_a .. :try_end_a} :catchall_2

    .line 403
    :try_start_b
    invoke-virtual/range {v22 .. v22}, Ljava/io/RandomAccessFile;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_6
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_7
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    .line 406
    goto :goto_6

    .line 404
    :catch_6
    move-exception v0

    .line 368
    .end local v1    # "end":Ljava/lang/Long;
    .end local v10    # "start":I
    :goto_6
    add-int/lit8 v8, v17, 0x1

    move-object/from16 v10, p1

    move-object/from16 v14, p2

    move/from16 v5, v16

    move/from16 v13, v19

    move-object/from16 v2, v22

    .end local v17    # "i":I
    .restart local v8    # "i":I
    goto/16 :goto_0

    .line 426
    .end local v8    # "i":I
    .end local v19    # "totNoOfSplitFiles":I
    :catchall_2
    move-exception v0

    move-wide v3, v6

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    move-object v6, v0

    goto/16 :goto_c

    .line 422
    :catch_7
    move-exception v0

    move-wide v3, v6

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    goto/16 :goto_a

    .line 419
    :catch_8
    move-exception v0

    move-wide v3, v6

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    goto/16 :goto_b

    .line 426
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    :catchall_3
    move-exception v0

    move-object v6, v0

    move-wide v3, v13

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    goto/16 :goto_c

    .line 422
    :catch_9
    move-exception v0

    move-wide v3, v13

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    goto/16 :goto_a

    .line 419
    :catch_a
    move-exception v0

    move-wide v3, v13

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    goto/16 :goto_b

    .line 426
    .end local v13    # "totBytesWritten":J
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "totBytesWritten":J
    :catchall_4
    move-exception v0

    move-object/from16 v22, v4

    move-wide v13, v6

    move-object v6, v0

    move-wide v3, v13

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    .restart local v22    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_c

    .line 422
    .end local v13    # "totBytesWritten":J
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "totBytesWritten":J
    :catch_b
    move-exception v0

    move-object/from16 v22, v4

    move-wide v13, v6

    move-wide v3, v13

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    .restart local v22    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_a

    .line 419
    .end local v13    # "totBytesWritten":J
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "totBytesWritten":J
    :catch_c
    move-exception v0

    move-object/from16 v22, v4

    move-wide v13, v6

    move-wide v3, v13

    move-object v1, v15

    move/from16 v5, v16

    move-object/from16 v2, v22

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    .restart local v22    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_b

    .line 426
    .end local v13    # "totBytesWritten":J
    .end local v16    # "splitSigRemoved":Z
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .local v5, "splitSigRemoved":Z
    .restart local v6    # "totBytesWritten":J
    :catchall_5
    move-exception v0

    move-object/from16 v22, v4

    move-wide v13, v6

    move-object v6, v0

    move-wide v3, v13

    move-object v1, v15

    move-object/from16 v2, v22

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    .restart local v22    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_c

    .line 422
    .end local v13    # "totBytesWritten":J
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "totBytesWritten":J
    :catch_d
    move-exception v0

    move-object/from16 v22, v4

    move-wide v13, v6

    move-wide v3, v13

    move-object v1, v15

    move-object/from16 v2, v22

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    .restart local v22    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_a

    .line 419
    .end local v13    # "totBytesWritten":J
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "totBytesWritten":J
    :catch_e
    move-exception v0

    move-object/from16 v22, v4

    move-wide v13, v6

    move-wide v3, v13

    move-object v1, v15

    move-object/from16 v2, v22

    .end local v4    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    .restart local v22    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_b

    .line 426
    .end local v13    # "totBytesWritten":J
    .end local v22    # "inputStream":Ljava/io/RandomAccessFile;
    .local v2, "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "totBytesWritten":J
    :catchall_6
    move-exception v0

    move-wide v13, v6

    move-object v6, v0

    move-wide v3, v13

    move-object v1, v15

    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    goto/16 :goto_c

    .line 422
    .end local v13    # "totBytesWritten":J
    .restart local v6    # "totBytesWritten":J
    :catch_f
    move-exception v0

    move-wide v13, v6

    move-wide v3, v13

    move-object v1, v15

    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    goto/16 :goto_a

    .line 419
    .end local v13    # "totBytesWritten":J
    .restart local v6    # "totBytesWritten":J
    :catch_10
    move-exception v0

    move-wide v13, v6

    move-wide v3, v13

    move-object v1, v15

    .end local v6    # "totBytesWritten":J
    .restart local v13    # "totBytesWritten":J
    goto :goto_b

    .line 368
    .restart local v6    # "totBytesWritten":J
    .restart local v8    # "i":I
    .local v13, "totNoOfSplitFiles":I
    :cond_7
    move/from16 v17, v8

    move/from16 v19, v13

    move-wide v13, v6

    .line 409
    .end local v6    # "totBytesWritten":J
    .end local v8    # "i":I
    .local v13, "totBytesWritten":J
    .restart local v19    # "totNoOfSplitFiles":I
    :try_start_c
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lnet/lingala/zip4j/model/ZipModel;

    .line 410
    .local v0, "newZipModel":Lnet/lingala/zip4j/model/ZipModel;
    invoke-virtual {v0}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual {v1, v13, v14}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setOffsetOfStartOfCentralDir(J)V

    .line 412
    invoke-direct {v9, v0, v12, v5}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->updateSplitZipModel(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;Z)V

    .line 414
    new-instance v1, Lnet/lingala/zip4j/core/HeaderWriter;

    invoke-direct {v1}, Lnet/lingala/zip4j/core/HeaderWriter;-><init>()V

    .line 415
    .local v1, "headerWriter":Lnet/lingala/zip4j/core/HeaderWriter;
    invoke-virtual {v1, v0, v15}, Lnet/lingala/zip4j/core/HeaderWriter;->finalizeZipFileWithoutValidations(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V

    .line 417
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorSuccess()V
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_14
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_13
    .catchall {:try_start_c .. :try_end_c} :catchall_7

    .line 426
    .end local v0    # "newZipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local v1    # "headerWriter":Lnet/lingala/zip4j/core/HeaderWriter;
    .end local v19    # "totNoOfSplitFiles":I
    if-eqz v15, :cond_8

    .line 428
    :try_start_d
    invoke-virtual {v15}, Ljava/io/OutputStream;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_11

    .line 431
    goto :goto_7

    .line 429
    :catch_11
    move-exception v0

    .line 434
    :cond_8
    :goto_7
    if-eqz v2, :cond_9

    .line 436
    :try_start_e
    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->close()V
    :try_end_e
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_12

    .line 439
    :goto_8
    goto :goto_9

    .line 437
    :catch_12
    move-exception v0

    goto :goto_8

    .line 442
    :cond_9
    :goto_9
    return-void

    .line 426
    :catchall_7
    move-exception v0

    move-object v6, v0

    move-wide v3, v13

    move-object v1, v15

    goto :goto_c

    .line 422
    :catch_13
    move-exception v0

    move-wide v3, v13

    move-object v1, v15

    goto :goto_a

    .line 419
    :catch_14
    move-exception v0

    move-wide v3, v13

    move-object v1, v15

    goto :goto_b

    .line 364
    .end local v15    # "outputStream":Ljava/io/OutputStream;
    .local v1, "outputStream":Ljava/io/OutputStream;
    .restart local v3    # "totBytesWritten":J
    .local v13, "totNoOfSplitFiles":I
    :cond_a
    move/from16 v19, v13

    .end local v13    # "totNoOfSplitFiles":I
    .restart local v19    # "totNoOfSplitFiles":I
    :try_start_f
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v6, "corrupt zip model, archive not a split zip file"

    invoke-direct {v0, v6}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v3    # "totBytesWritten":J
    .end local v5    # "splitSigRemoved":Z
    .end local v12    # "fileSizeList":Ljava/util/ArrayList;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "outputZipFile":Ljava/io/File;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_16
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_15
    .catchall {:try_start_f .. :try_end_f} :catchall_8

    .line 426
    .end local v19    # "totNoOfSplitFiles":I
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v3    # "totBytesWritten":J
    .restart local v5    # "splitSigRemoved":Z
    .restart local v12    # "fileSizeList":Ljava/util/ArrayList;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "outputZipFile":Ljava/io/File;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catchall_8
    move-exception v0

    move-object v6, v0

    goto :goto_c

    .line 422
    :catch_15
    move-exception v0

    .line 423
    .local v0, "e":Ljava/lang/Exception;
    :goto_a
    :try_start_10
    invoke-virtual {v11, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 424
    new-instance v6, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v6, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v3    # "totBytesWritten":J
    .end local v5    # "splitSigRemoved":Z
    .end local v12    # "fileSizeList":Ljava/util/ArrayList;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "outputZipFile":Ljava/io/File;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v6

    .line 419
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v3    # "totBytesWritten":J
    .restart local v5    # "splitSigRemoved":Z
    .restart local v12    # "fileSizeList":Ljava/util/ArrayList;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "outputZipFile":Ljava/io/File;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catch_16
    move-exception v0

    .line 420
    .local v0, "e":Ljava/io/IOException;
    :goto_b
    invoke-virtual {v11, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 421
    new-instance v6, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v6, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v3    # "totBytesWritten":J
    .end local v5    # "splitSigRemoved":Z
    .end local v12    # "fileSizeList":Ljava/util/ArrayList;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "outputZipFile":Ljava/io/File;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v6
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_8

    .line 426
    .end local v0    # "e":Ljava/io/IOException;
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v3    # "totBytesWritten":J
    .restart local v5    # "splitSigRemoved":Z
    .restart local v12    # "fileSizeList":Ljava/util/ArrayList;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "outputZipFile":Ljava/io/File;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :goto_c
    if-eqz v1, :cond_b

    .line 428
    :try_start_11
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_11
    .catch Ljava/io/IOException; {:try_start_11 .. :try_end_11} :catch_17

    .line 431
    goto :goto_d

    .line 429
    :catch_17
    move-exception v0

    .line 434
    :cond_b
    :goto_d
    if-eqz v2, :cond_c

    .line 436
    :try_start_12
    invoke-virtual {v2}, Ljava/io/RandomAccessFile;->close()V
    :try_end_12
    .catch Ljava/io/IOException; {:try_start_12 .. :try_end_12} :catch_18

    .line 439
    goto :goto_e

    .line 437
    :catch_18
    move-exception v0

    .line 439
    :cond_c
    :goto_e
    throw v6

    .line 349
    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v3    # "totBytesWritten":J
    .end local v5    # "splitSigRemoved":Z
    .end local v12    # "fileSizeList":Ljava/util/ArrayList;
    :cond_d
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "archive not a split zip file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .line 350
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    invoke-virtual {v11, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 351
    throw v0

    .line 343
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    :cond_e
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null, cannot merge split zip file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .line 344
    .restart local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    invoke-virtual {v11, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 345
    goto :goto_10

    :goto_f
    throw v0

    :goto_10
    goto :goto_f
.end method

.method private prepareOutputStreamForMerge(Ljava/io/File;)Ljava/io/OutputStream;
    .locals 2
    .param p1, "outFile"    # Ljava/io/File;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 487
    if-eqz p1, :cond_0

    .line 492
    :try_start_0
    new-instance v0, Ljava/io/FileOutputStream;

    invoke-direct {v0, p1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 495
    :catch_0
    move-exception v0

    .line 496
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 493
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 494
    .local v0, "e":Ljava/io/FileNotFoundException;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 488
    .end local v0    # "e":Ljava/io/FileNotFoundException;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "outFile is null, cannot create outputstream"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private restoreFileName(Ljava/io/File;Ljava/lang/String;)V
    .locals 3
    .param p1, "zipFile"    # Ljava/io/File;
    .param p2, "tmpZipFileName"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 227
    invoke-virtual {p1}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 229
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 230
    .local v0, "newZipFile":Ljava/io/File;
    invoke-virtual {v0, p1}, Ljava/io/File;->renameTo(Ljava/io/File;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 233
    .end local v0    # "newZipFile":Ljava/io/File;
    nop

    .line 236
    return-void

    .line 231
    .restart local v0    # "newZipFile":Ljava/io/File;
    :cond_0
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "cannot rename modified zip file"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 234
    .end local v0    # "newZipFile":Ljava/io/File;
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "cannot delete old zip file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private updateSplitEndCentralDirectory(Lnet/lingala/zip4j/model/ZipModel;)V
    .locals 2
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 547
    if-eqz p1, :cond_1

    .line 551
    :try_start_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 555
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setNoOfThisDisk(I)V

    .line 556
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setNoOfThisDiskStartOfCentralDir(I)V

    .line 557
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setTotNoOfEntriesInCentralDir(I)V

    .line 559
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setTotNoOfEntriesInCentralDirOnThisDisk(I)V

    .line 566
    nop

    .line 567
    return-void

    .line 552
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "corrupt zip model - getCentralDirectory, cannot update split zip model"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    throw v0

    .line 564
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    :catch_0
    move-exception v0

    goto :goto_0

    .line 562
    :catch_1
    move-exception v0

    goto :goto_1

    .line 548
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null - cannot update end of central directory for split zip model"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    throw v0
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 565
    .local v0, "e":Ljava/lang/Exception;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    :goto_0
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 563
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    :goto_1
    throw v0
.end method

.method private updateSplitFileHeader(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;Z)V
    .locals 10
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileSizeList"    # Ljava/util/ArrayList;
    .param p3, "splitSigRemoved"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 517
    :try_start_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    if-eqz v0, :cond_3

    .line 521
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    .line 522
    .local v0, "fileHeaderCount":I
    const/4 v1, 0x0

    .line 523
    .local v1, "splitSigOverhead":I
    if-eqz p3, :cond_0

    .line 524
    const/4 v1, 0x4

    .line 526
    :cond_0
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v0, :cond_2

    .line 527
    const-wide/16 v3, 0x0

    .line 529
    .local v3, "offsetLHToAdd":J
    const/4 v5, 0x0

    .local v5, "j":I
    :goto_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v6

    invoke-virtual {v6}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v6}, Lnet/lingala/zip4j/model/FileHeader;->getDiskNumberStart()I

    move-result v6

    if-ge v5, v6, :cond_1

    .line 530
    invoke-virtual {p2, v5}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/Long;

    invoke-virtual {v6}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    add-long/2addr v3, v6

    .line 529
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 532
    .end local v5    # "j":I
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v6

    invoke-virtual {v6}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v6

    invoke-virtual {v6, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v6}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v6

    add-long/2addr v6, v3

    int-to-long v8, v1

    sub-long/2addr v6, v8

    invoke-virtual {v5, v6, v7}, Lnet/lingala/zip4j/model/FileHeader;->setOffsetLocalHeader(J)V

    .line 535
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lnet/lingala/zip4j/model/FileHeader;

    const/4 v6, 0x0

    invoke-virtual {v5, v6}, Lnet/lingala/zip4j/model/FileHeader;->setDiskNumberStart(I)V

    .line 526
    .end local v3    # "offsetLHToAdd":J
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 542
    .end local v0    # "fileHeaderCount":I
    .end local v1    # "splitSigOverhead":I
    .end local v2    # "i":I
    :cond_2
    nop

    .line 543
    return-void

    .line 518
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "corrupt zip model - getCentralDirectory, cannot update split zip model"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileSizeList":Ljava/util/ArrayList;
    .end local p3    # "splitSigRemoved":Z
    throw v0
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 540
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileSizeList":Ljava/util/ArrayList;
    .restart local p3    # "splitSigRemoved":Z
    :catch_0
    move-exception v0

    .line 541
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 538
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 539
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method private updateSplitZip64EndCentralDirLocator(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;)V
    .locals 5
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileSizeList"    # Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 570
    if-eqz p1, :cond_2

    .line 574
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v0

    if-nez v0, :cond_0

    .line 575
    return-void

    .line 578
    :cond_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setNoOfDiskStartOfZip64EndOfCentralDirRec(I)V

    .line 579
    const-wide/16 v0, 0x0

    .line 581
    .local v0, "offsetZip64EndCentralDirRec":J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 582
    invoke-virtual {p2, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    add-long/2addr v0, v3

    .line 581
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 584
    .end local v2    # "i":I
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->getOffsetZip64EndOfCentralDirRec()J

    move-result-wide v3

    add-long/2addr v3, v0

    invoke-virtual {v2, v3, v4}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setOffsetZip64EndOfCentralDirRec(J)V

    .line 587
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    const/4 v3, 0x1

    invoke-virtual {v2, v3}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setTotNumberOfDiscs(I)V

    .line 588
    return-void

    .line 571
    .end local v0    # "offsetZip64EndCentralDirRec":J
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null, cannot update split Zip64 end of central directory locator"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method private updateSplitZip64EndCentralDirRec(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;)V
    .locals 5
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileSizeList"    # Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 591
    if-eqz p1, :cond_2

    .line 595
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v0

    if-nez v0, :cond_0

    .line 596
    return-void

    .line 599
    :cond_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v0

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->setNoOfThisDisk(I)V

    .line 600
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->setNoOfThisDiskStartOfCentralDir(I)V

    .line 601
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getTotNoOfEntriesInCentralDir()I

    move-result v1

    int-to-long v1, v1

    invoke-virtual {v0, v1, v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->setTotNoOfEntriesInCentralDirOnThisDisk(J)V

    .line 604
    const-wide/16 v0, 0x0

    .line 606
    .local v0, "offsetStartCenDirWRTStartDiskNo":J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {p2}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_1

    .line 607
    invoke-virtual {p2, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/Long;

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    add-long/2addr v0, v3

    .line 606
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 610
    .end local v2    # "i":I
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v2

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->getOffsetStartCenDirWRTStartDiskNo()J

    move-result-wide v3

    add-long/2addr v3, v0

    invoke-virtual {v2, v3, v4}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->setOffsetStartCenDirWRTStartDiskNo(J)V

    .line 613
    return-void

    .line 592
    .end local v0    # "offsetStartCenDirWRTStartDiskNo":J
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null, cannot update split Zip64 end of central directory record"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method private updateSplitZipModel(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;Z)V
    .locals 2
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileSizeList"    # Ljava/util/ArrayList;
    .param p3, "splitSigRemoved"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 501
    if-eqz p1, :cond_1

    .line 505
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lnet/lingala/zip4j/model/ZipModel;->setSplitArchive(Z)V

    .line 506
    invoke-direct {p0, p1, p2, p3}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->updateSplitFileHeader(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;Z)V

    .line 507
    invoke-direct {p0, p1}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->updateSplitEndCentralDirectory(Lnet/lingala/zip4j/model/ZipModel;)V

    .line 508
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 509
    invoke-direct {p0, p1, p2}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->updateSplitZip64EndCentralDirLocator(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;)V

    .line 510
    invoke-direct {p0, p1, p2}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->updateSplitZip64EndCentralDirRec(Lnet/lingala/zip4j/model/ZipModel;Ljava/util/ArrayList;)V

    .line 512
    :cond_0
    return-void

    .line 502
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null, cannot update split zip model"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public initProgressMonitorForMergeOp(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 2
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 693
    if-eqz p1, :cond_0

    .line 697
    const/4 v0, 0x4

    invoke-virtual {p2, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 698
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setFileName(Ljava/lang/String;)V

    .line 699
    invoke-direct {p0, p1}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->calculateTotalWorkForMergeOp(Lnet/lingala/zip4j/model/ZipModel;)J

    move-result-wide v0

    invoke-virtual {p2, v0, v1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setTotalWork(J)V

    .line 700
    const/4 v0, 0x1

    invoke-virtual {p2, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V

    .line 701
    return-void

    .line 694
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null, cannot calculate total work for merge op"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public initProgressMonitorForRemoveOp(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 2
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileHeader"    # Lnet/lingala/zip4j/model/FileHeader;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 678
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    if-eqz p3, :cond_0

    .line 682
    const/4 v0, 0x2

    invoke-virtual {p3, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 683
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setFileName(Ljava/lang/String;)V

    .line 684
    invoke-direct {p0, p1, p2}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->calculateTotalWorkForRemoveOp(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;)J

    move-result-wide v0

    invoke-virtual {p3, v0, v1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setTotalWork(J)V

    .line 685
    const/4 v0, 0x1

    invoke-virtual {p3, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V

    .line 686
    return-void

    .line 679
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null, cannot calculate total work"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public initRemoveZipFile(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Lnet/lingala/zip4j/progress/ProgressMonitor;)Ljava/util/HashMap;
    .locals 36
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileHeader"    # Lnet/lingala/zip4j/model/FileHeader;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 71
    move-object/from16 v9, p0

    move-object/from16 v10, p1

    move-object/from16 v11, p2

    move-object/from16 v12, p3

    const-string v13, "cannot close input stream or output stream when trying to delete a file from zip file"

    if-eqz v11, :cond_17

    if-eqz v10, :cond_17

    .line 75
    const/4 v1, 0x0

    .line 76
    .local v1, "outputStream":Ljava/io/OutputStream;
    const/4 v2, 0x0

    .line 77
    .local v2, "zipFile":Ljava/io/File;
    const/4 v3, 0x0

    .line 78
    .local v3, "inputStream":Ljava/io/RandomAccessFile;
    const/4 v14, 0x0

    .line 79
    .local v14, "successFlag":Z
    const/4 v4, 0x0

    .line 80
    .local v4, "tmpZipFileName":Ljava/lang/String;
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    move-object v15, v0

    .line 83
    .local v15, "retMap":Ljava/util/HashMap;
    :try_start_0
    invoke-static/range {p1 .. p2}, Lnet/lingala/zip4j/util/Zip4jUtil;->getIndexOfFileHeader(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;)I

    move-result v0

    move v8, v0

    .line 85
    .local v8, "indexOfFileHeader":I
    if-ltz v8, :cond_13

    .line 89
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->isSplitArchive()Z

    move-result v0

    if-nez v0, :cond_12

    .line 93
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    .line 94
    .local v5, "currTime":J
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v0, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_24
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_23
    .catchall {:try_start_0 .. :try_end_0} :catchall_10

    const-wide/16 v16, 0x3e8

    move-object v7, v1

    move-object/from16 v18, v2

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "zipFile":Ljava/io/File;
    .local v7, "outputStream":Ljava/io/OutputStream;
    .local v18, "zipFile":Ljava/io/File;
    :try_start_1
    rem-long v1, v5, v16

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v4, v0

    .line 95
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_1 .. :try_end_1} :catch_20
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1f
    .catchall {:try_start_1 .. :try_end_1} :catchall_e

    move-object/from16 v19, v0

    move-wide/from16 v20, v5

    move-object v6, v4

    .line 97
    .end local v4    # "tmpZipFileName":Ljava/lang/String;
    .end local v5    # "currTime":J
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .local v19, "tmpFile":Ljava/io/File;
    .local v20, "currTime":J
    :goto_0
    :try_start_2
    invoke-virtual/range {v19 .. v19}, Ljava/io/File;->exists()Z

    move-result v0
    :try_end_2
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_2 .. :try_end_2} :catch_1e
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1d
    .catchall {:try_start_2 .. :try_end_2} :catchall_d

    if-eqz v0, :cond_0

    .line 98
    :try_start_3
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    move-wide/from16 v20, v0

    .line 99
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    rem-long v1, v20, v16

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    move-object v6, v0

    .line 100
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_3
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_0
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    move-object/from16 v19, v0

    goto :goto_0

    .line 206
    .end local v8    # "indexOfFileHeader":I
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    :catchall_0
    move-exception v0

    move-object v4, v6

    move-object v2, v7

    move-object v1, v10

    move-object v6, v15

    move-object/from16 v11, v18

    goto/16 :goto_10

    .line 202
    :catch_0
    move-exception v0

    move-object v4, v6

    move-object v2, v7

    move-object v1, v10

    move-object v6, v15

    move-object/from16 v11, v18

    goto/16 :goto_e

    .line 199
    :catch_1
    move-exception v0

    move-object v4, v6

    move-object v2, v7

    move-object v1, v10

    move-object v6, v15

    move-object/from16 v11, v18

    goto/16 :goto_f

    .line 104
    .restart local v8    # "indexOfFileHeader":I
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    :cond_0
    :try_start_4
    new-instance v0, Lnet/lingala/zip4j/io/SplitOutputStream;

    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/io/SplitOutputStream;-><init>(Ljava/io/File;)V
    :try_end_4
    .catch Ljava/io/FileNotFoundException; {:try_start_4 .. :try_end_4} :catch_1a
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_4 .. :try_end_4} :catch_1e
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1d
    .catchall {:try_start_4 .. :try_end_4} :catchall_d

    move-object v7, v0

    .line 107
    nop

    .line 109
    :try_start_5
    new-instance v0, Ljava/io/File;

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V
    :try_end_5
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_5 .. :try_end_5} :catch_19
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_18
    .catchall {:try_start_5 .. :try_end_5} :catchall_b

    move-object v4, v0

    .line 111
    .end local v18    # "zipFile":Ljava/io/File;
    .local v4, "zipFile":Ljava/io/File;
    :try_start_6
    const-string v0, "r"

    invoke-direct {v9, v10, v0}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->createFileHandler(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Ljava/io/RandomAccessFile;

    move-result-object v0
    :try_end_6
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_6 .. :try_end_6} :catch_17
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_16
    .catchall {:try_start_6 .. :try_end_6} :catchall_a

    move-object v5, v0

    .line 113
    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .local v5, "inputStream":Ljava/io/RandomAccessFile;
    :try_start_7
    new-instance v0, Lnet/lingala/zip4j/core/HeaderReader;

    invoke-direct {v0, v5}, Lnet/lingala/zip4j/core/HeaderReader;-><init>(Ljava/io/RandomAccessFile;)V

    move-object v3, v0

    .line 114
    .local v3, "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    invoke-virtual {v3, v11}, Lnet/lingala/zip4j/core/HeaderReader;->readLocalFileHeader(Lnet/lingala/zip4j/model/FileHeader;)Lnet/lingala/zip4j/model/LocalFileHeader;

    move-result-object v0

    move-object/from16 v16, v0

    .line 115
    .local v16, "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    if-eqz v16, :cond_11

    .line 119
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v0

    .line 121
    .local v0, "offsetLocalFileHeader":J
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v2
    :try_end_7
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_7 .. :try_end_7} :catch_15
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_14
    .catchall {:try_start_7 .. :try_end_7} :catchall_9

    const-wide/16 v17, -0x1

    if-eqz v2, :cond_1

    :try_start_8
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/Zip64ExtendedInfo;->getOffsetLocalHeader()J

    move-result-wide v22

    cmp-long v2, v22, v17

    if-eqz v2, :cond_1

    .line 123
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/Zip64ExtendedInfo;->getOffsetLocalHeader()J

    move-result-wide v22
    :try_end_8
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_8 .. :try_end_8} :catch_3
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    move-wide/from16 v0, v22

    goto :goto_1

    .line 206
    .end local v0    # "offsetLocalFileHeader":J
    .end local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v8    # "indexOfFileHeader":I
    .end local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    :catchall_1
    move-exception v0

    move-object v11, v4

    move-object v3, v5

    move-object v4, v6

    move-object v2, v7

    move-object v1, v10

    move-object v6, v15

    goto/16 :goto_10

    .line 202
    :catch_2
    move-exception v0

    move-object v11, v4

    move-object v3, v5

    move-object v4, v6

    move-object v2, v7

    move-object v1, v10

    move-object v6, v15

    goto/16 :goto_e

    .line 199
    :catch_3
    move-exception v0

    move-object v11, v4

    move-object v3, v5

    move-object v4, v6

    move-object v2, v7

    move-object v1, v10

    move-object v6, v15

    goto/16 :goto_f

    .line 126
    .restart local v0    # "offsetLocalFileHeader":J
    .restart local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v8    # "indexOfFileHeader":I
    .restart local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    :cond_1
    move-wide/from16 v22, v0

    .end local v0    # "offsetLocalFileHeader":J
    .local v22, "offsetLocalFileHeader":J
    :goto_1
    const-wide/16 v0, -0x1

    .line 128
    .local v0, "offsetEndOfCompressedFile":J
    :try_start_9
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v24

    .line 129
    .local v24, "offsetStartCentralDir":J
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v2
    :try_end_9
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_9 .. :try_end_9} :catch_15
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_14
    .catchall {:try_start_9 .. :try_end_9} :catchall_9

    if-eqz v2, :cond_2

    .line 130
    :try_start_a
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v2

    if-eqz v2, :cond_2

    .line 131
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->getOffsetStartCenDirWRTStartDiskNo()J

    move-result-wide v26
    :try_end_a
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_a .. :try_end_a} :catch_3
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_2
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    move-wide/from16 v24, v26

    .line 135
    :cond_2
    :try_start_b
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v2

    .line 137
    .local v2, "fileHeaderList":Ljava/util/ArrayList;
    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v26

    move-wide/from16 v27, v0

    .end local v0    # "offsetEndOfCompressedFile":J
    .local v27, "offsetEndOfCompressedFile":J
    const/4 v0, 0x1

    add-int/lit8 v1, v26, -0x1

    const-wide/16 v29, 0x1

    if-ne v8, v1, :cond_3

    .line 138
    sub-long v26, v24, v29

    .end local v27    # "offsetEndOfCompressedFile":J
    .local v26, "offsetEndOfCompressedFile":J
    goto :goto_2

    .line 140
    .end local v26    # "offsetEndOfCompressedFile":J
    .restart local v27    # "offsetEndOfCompressedFile":J
    :cond_3
    add-int/lit8 v1, v8, 0x1

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lnet/lingala/zip4j/model/FileHeader;
    :try_end_b
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_b .. :try_end_b} :catch_15
    .catch Ljava/lang/Exception; {:try_start_b .. :try_end_b} :catch_14
    .catchall {:try_start_b .. :try_end_b} :catchall_9

    .line 141
    .local v1, "nextFileHeader":Lnet/lingala/zip4j/model/FileHeader;
    if-eqz v1, :cond_4

    .line 142
    :try_start_c
    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v31

    sub-long v26, v31, v29

    .line 143
    .end local v27    # "offsetEndOfCompressedFile":J
    .restart local v26    # "offsetEndOfCompressedFile":J
    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v28

    if-eqz v28, :cond_5

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v28

    invoke-virtual/range {v28 .. v28}, Lnet/lingala/zip4j/model/Zip64ExtendedInfo;->getOffsetLocalHeader()J

    move-result-wide v31

    cmp-long v28, v31, v17

    if-eqz v28, :cond_5

    .line 145
    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v28

    invoke-virtual/range {v28 .. v28}, Lnet/lingala/zip4j/model/Zip64ExtendedInfo;->getOffsetLocalHeader()J

    move-result-wide v31
    :try_end_c
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_c .. :try_end_c} :catch_3
    .catch Ljava/lang/Exception; {:try_start_c .. :try_end_c} :catch_2
    .catchall {:try_start_c .. :try_end_c} :catchall_1

    sub-long v26, v31, v29

    goto :goto_2

    .line 141
    .end local v26    # "offsetEndOfCompressedFile":J
    .restart local v27    # "offsetEndOfCompressedFile":J
    :cond_4
    move-wide/from16 v26, v27

    .line 150
    .end local v1    # "nextFileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local v27    # "offsetEndOfCompressedFile":J
    .restart local v26    # "offsetEndOfCompressedFile":J
    :cond_5
    :goto_2
    const-wide/16 v31, 0x0

    cmp-long v1, v22, v31

    if-ltz v1, :cond_10

    cmp-long v1, v26, v31

    if-ltz v1, :cond_10

    .line 154
    if-nez v8, :cond_7

    .line 155
    :try_start_d
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1
    :try_end_d
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_d .. :try_end_d} :catch_5
    .catch Ljava/lang/Exception; {:try_start_d .. :try_end_d} :catch_4
    .catchall {:try_start_d .. :try_end_d} :catchall_2

    if-le v1, v0, :cond_6

    .line 157
    add-long v31, v26, v29

    move-object/from16 v1, p0

    move-object/from16 v28, v2

    .end local v2    # "fileHeaderList":Ljava/util/ArrayList;
    .local v28, "fileHeaderList":Ljava/util/ArrayList;
    move-object v2, v5

    move-object/from16 v33, v3

    .end local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .local v33, "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    move-object v3, v7

    move-object v11, v4

    move-object/from16 v34, v5

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .local v11, "zipFile":Ljava/io/File;
    .local v34, "inputStream":Ljava/io/RandomAccessFile;
    move-wide/from16 v4, v31

    move-object/from16 v32, v7

    move-object/from16 v31, v15

    move-object v15, v6

    .end local v6    # "tmpZipFileName":Ljava/lang/String;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .local v31, "retMap":Ljava/util/HashMap;
    .local v32, "outputStream":Ljava/io/OutputStream;
    move-wide/from16 v6, v24

    move v10, v8

    .end local v8    # "indexOfFileHeader":I
    .local v10, "indexOfFileHeader":I
    move-object/from16 v8, p3

    :try_start_e
    invoke-direct/range {v1 .. v8}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->copyFile(Ljava/io/RandomAccessFile;Ljava/io/OutputStream;JJLnet/lingala/zip4j/progress/ProgressMonitor;)V
    :try_end_e
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_e .. :try_end_e} :catch_7
    .catch Ljava/lang/Exception; {:try_start_e .. :try_end_e} :catch_6
    .catchall {:try_start_e .. :try_end_e} :catchall_3

    goto/16 :goto_3

    .line 155
    .end local v10    # "indexOfFileHeader":I
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v2    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v8    # "indexOfFileHeader":I
    .local v15, "retMap":Ljava/util/HashMap;
    :cond_6
    move-object/from16 v28, v2

    move-object/from16 v33, v3

    move-object v11, v4

    move-object/from16 v34, v5

    move-object/from16 v32, v7

    move v10, v8

    move-object/from16 v31, v15

    move-object v15, v6

    .end local v2    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "tmpZipFileName":Ljava/lang/String;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v8    # "indexOfFileHeader":I
    .restart local v10    # "indexOfFileHeader":I
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_3

    .line 206
    .end local v10    # "indexOfFileHeader":I
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    .end local v22    # "offsetLocalFileHeader":J
    .end local v24    # "offsetStartCentralDir":J
    .end local v26    # "offsetEndOfCompressedFile":J
    .end local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catchall_2
    move-exception v0

    move-object v11, v4

    move-object/from16 v34, v5

    move-object/from16 v32, v7

    move-object/from16 v31, v15

    move-object v15, v6

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object/from16 v3, v34

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "tmpZipFileName":Ljava/lang/String;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_10

    .line 202
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_4
    move-exception v0

    move-object v11, v4

    move-object/from16 v34, v5

    move-object/from16 v32, v7

    move-object/from16 v31, v15

    move-object v15, v6

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object/from16 v3, v34

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "tmpZipFileName":Ljava/lang/String;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_e

    .line 199
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_5
    move-exception v0

    move-object v11, v4

    move-object/from16 v34, v5

    move-object/from16 v32, v7

    move-object/from16 v31, v15

    move-object v15, v6

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object/from16 v3, v34

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "tmpZipFileName":Ljava/lang/String;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_f

    .line 159
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v2    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v8    # "indexOfFileHeader":I
    .local v15, "retMap":Ljava/util/HashMap;
    .restart local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    .restart local v22    # "offsetLocalFileHeader":J
    .restart local v24    # "offsetStartCentralDir":J
    .restart local v26    # "offsetEndOfCompressedFile":J
    :cond_7
    move-object/from16 v28, v2

    move-object/from16 v33, v3

    move-object v11, v4

    move-object/from16 v34, v5

    move-object/from16 v32, v7

    move v10, v8

    move-object/from16 v31, v15

    move-object v15, v6

    .end local v2    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "tmpZipFileName":Ljava/lang/String;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v8    # "indexOfFileHeader":I
    .restart local v10    # "indexOfFileHeader":I
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    :try_start_f
    invoke-virtual/range {v28 .. v28}, Ljava/util/ArrayList;->size()I

    move-result v1
    :try_end_f
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_f .. :try_end_f} :catch_11
    .catch Ljava/lang/Exception; {:try_start_f .. :try_end_f} :catch_10
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    sub-int/2addr v1, v0

    if-ne v10, v1, :cond_8

    .line 160
    const-wide/16 v4, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, v34

    move-object/from16 v3, v32

    move-wide/from16 v6, v22

    move-object/from16 v8, p3

    :try_start_10
    invoke-direct/range {v1 .. v8}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->copyFile(Ljava/io/RandomAccessFile;Ljava/io/OutputStream;JJLnet/lingala/zip4j/progress/ProgressMonitor;)V
    :try_end_10
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_10 .. :try_end_10} :catch_7
    .catch Ljava/lang/Exception; {:try_start_10 .. :try_end_10} :catch_6
    .catchall {:try_start_10 .. :try_end_10} :catchall_3

    goto :goto_3

    .line 206
    .end local v10    # "indexOfFileHeader":I
    .end local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    .end local v22    # "offsetLocalFileHeader":J
    .end local v24    # "offsetStartCentralDir":J
    .end local v26    # "offsetEndOfCompressedFile":J
    .end local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    :catchall_3
    move-exception v0

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object/from16 v3, v34

    goto/16 :goto_10

    .line 202
    :catch_6
    move-exception v0

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object/from16 v3, v34

    goto/16 :goto_e

    .line 199
    :catch_7
    move-exception v0

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object/from16 v3, v34

    goto/16 :goto_f

    .line 162
    .restart local v10    # "indexOfFileHeader":I
    .restart local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    .restart local v22    # "offsetLocalFileHeader":J
    .restart local v24    # "offsetStartCentralDir":J
    .restart local v26    # "offsetEndOfCompressedFile":J
    .restart local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    :cond_8
    const-wide/16 v4, 0x0

    move-object/from16 v1, p0

    move-object/from16 v2, v34

    move-object/from16 v3, v32

    move-wide/from16 v6, v22

    move-object/from16 v8, p3

    :try_start_11
    invoke-direct/range {v1 .. v8}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->copyFile(Ljava/io/RandomAccessFile;Ljava/io/OutputStream;JJLnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 163
    add-long v4, v26, v29

    move-object/from16 v1, p0

    move-object/from16 v2, v34

    move-object/from16 v3, v32

    move-wide/from16 v6, v24

    move-object/from16 v8, p3

    invoke-direct/range {v1 .. v8}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->copyFile(Ljava/io/RandomAccessFile;Ljava/io/OutputStream;JJLnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 166
    :goto_3
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v1
    :try_end_11
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_11 .. :try_end_11} :catch_11
    .catch Ljava/lang/Exception; {:try_start_11 .. :try_end_11} :catch_10
    .catchall {:try_start_11 .. :try_end_11} :catchall_7

    if-eqz v1, :cond_b

    .line 167
    const/4 v0, 0x3

    :try_start_12
    invoke-virtual {v12, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 168
    const/4 v0, 0x0

    invoke-virtual {v12, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_12
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_12 .. :try_end_12} :catch_7
    .catch Ljava/lang/Exception; {:try_start_12 .. :try_end_12} :catch_6
    .catchall {:try_start_12 .. :try_end_12} :catchall_3

    .line 169
    const/4 v0, 0x0

    .line 207
    if-eqz v34, :cond_9

    .line 208
    :try_start_13
    invoke-virtual/range {v34 .. v34}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_4

    .line 211
    :catch_8
    move-exception v0

    goto :goto_6

    .line 209
    :cond_9
    :goto_4
    nop

    .line 210
    invoke-virtual/range {v32 .. v32}, Ljava/io/OutputStream;->close()V
    :try_end_13
    .catch Ljava/io/IOException; {:try_start_13 .. :try_end_13} :catch_8

    .line 213
    nop

    .line 215
    if-eqz v14, :cond_a

    .line 216
    invoke-direct {v9, v11, v15}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->restoreFileName(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_5

    .line 218
    :cond_a
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v15}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 219
    .local v1, "newZipFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->delete()Z

    .line 220
    .end local v1    # "newZipFile":Ljava/io/File;
    :goto_5
    return-object v0

    .line 212
    .local v0, "e":Ljava/io/IOException;
    :goto_6
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v13}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 172
    .end local v0    # "e":Ljava/io/IOException;
    :cond_b
    :try_start_14
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1
    :try_end_14
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_14 .. :try_end_14} :catch_11
    .catch Ljava/lang/Exception; {:try_start_14 .. :try_end_14} :catch_10
    .catchall {:try_start_14 .. :try_end_14} :catchall_7

    move-object/from16 v2, v32

    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .local v2, "outputStream":Ljava/io/OutputStream;
    :try_start_15
    move-object v3, v2

    check-cast v3, Lnet/lingala/zip4j/io/SplitOutputStream;

    invoke-virtual {v3}, Lnet/lingala/zip4j/io/SplitOutputStream;->getFilePointer()J

    move-result-wide v3

    invoke-virtual {v1, v3, v4}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setOffsetOfStartOfCentralDir(J)V

    .line 173
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getTotNoOfEntriesInCentralDir()I

    move-result v3

    sub-int/2addr v3, v0

    invoke-virtual {v1, v3}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setTotNoOfEntriesInCentralDir(I)V

    .line 175
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getTotNoOfEntriesInCentralDirOnThisDisk()I

    move-result v3

    sub-int/2addr v3, v0

    invoke-virtual {v1, v3}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setTotNoOfEntriesInCentralDirOnThisDisk(I)V

    .line 178
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, v10}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    .line 180
    move v0, v10

    .local v0, "i":I
    :goto_7
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v1
    :try_end_15
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_15 .. :try_end_15} :catch_f
    .catch Ljava/lang/Exception; {:try_start_15 .. :try_end_15} :catch_e
    .catchall {:try_start_15 .. :try_end_15} :catchall_6

    if-ge v0, v1, :cond_d

    .line 181
    :try_start_16
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v3

    .line 182
    .local v3, "offsetLocalHdr":J
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v1

    if-eqz v1, :cond_c

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/Zip64ExtendedInfo;->getOffsetLocalHeader()J

    move-result-wide v5

    cmp-long v1, v5, v17

    if-eqz v1, :cond_c

    .line 184
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/FileHeader;->getZip64ExtendedInfo()Lnet/lingala/zip4j/model/Zip64ExtendedInfo;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/Zip64ExtendedInfo;->getOffsetLocalHeader()J

    move-result-wide v5

    move-wide v3, v5

    .line 187
    :cond_c
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lnet/lingala/zip4j/model/FileHeader;

    sub-long v5, v26, v22

    sub-long v5, v3, v5

    sub-long v5, v5, v29

    invoke-virtual {v1, v5, v6}, Lnet/lingala/zip4j/model/FileHeader;->setOffsetLocalHeader(J)V
    :try_end_16
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_16 .. :try_end_16} :catch_a
    .catch Ljava/lang/Exception; {:try_start_16 .. :try_end_16} :catch_9
    .catchall {:try_start_16 .. :try_end_16} :catchall_4

    .line 180
    .end local v3    # "offsetLocalHdr":J
    add-int/lit8 v0, v0, 0x1

    goto :goto_7

    .line 206
    .end local v0    # "i":I
    .end local v10    # "indexOfFileHeader":I
    .end local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    .end local v22    # "offsetLocalFileHeader":J
    .end local v24    # "offsetStartCentralDir":J
    .end local v26    # "offsetEndOfCompressedFile":J
    .end local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    :catchall_4
    move-exception v0

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v3, v34

    goto/16 :goto_10

    .line 202
    :catch_9
    move-exception v0

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v3, v34

    goto/16 :goto_e

    .line 199
    :catch_a
    move-exception v0

    move-object/from16 v1, p1

    move-object v4, v15

    move-object/from16 v6, v31

    move-object/from16 v3, v34

    goto/16 :goto_f

    .line 191
    .restart local v10    # "indexOfFileHeader":I
    .restart local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    .restart local v22    # "offsetLocalFileHeader":J
    .restart local v24    # "offsetStartCentralDir":J
    .restart local v26    # "offsetEndOfCompressedFile":J
    .restart local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    :cond_d
    :try_start_17
    new-instance v0, Lnet/lingala/zip4j/core/HeaderWriter;

    invoke-direct {v0}, Lnet/lingala/zip4j/core/HeaderWriter;-><init>()V
    :try_end_17
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_17 .. :try_end_17} :catch_f
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_e
    .catchall {:try_start_17 .. :try_end_17} :catchall_6

    .line 192
    .local v0, "headerWriter":Lnet/lingala/zip4j/core/HeaderWriter;
    move-object/from16 v1, p1

    move v5, v10

    .end local v10    # "indexOfFileHeader":I
    .local v5, "indexOfFileHeader":I
    :try_start_18
    invoke-virtual {v0, v1, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->finalizeZipFile(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V

    .line 194
    const/4 v14, 0x1

    .line 196
    const-string v3, "offsetCentralDir"

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v4

    invoke-virtual {v4}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v6

    invoke-static {v6, v7}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v4
    :try_end_18
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_18 .. :try_end_18} :catch_d
    .catch Ljava/lang/Exception; {:try_start_18 .. :try_end_18} :catch_c
    .catchall {:try_start_18 .. :try_end_18} :catchall_5

    move-object/from16 v6, v31

    .end local v31    # "retMap":Ljava/util/HashMap;
    .local v6, "retMap":Ljava/util/HashMap;
    :try_start_19
    invoke-virtual {v6, v3, v4}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_19
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_19 .. :try_end_19} :catch_13
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_12
    .catchall {:try_start_19 .. :try_end_19} :catchall_8

    .line 207
    .end local v0    # "headerWriter":Lnet/lingala/zip4j/core/HeaderWriter;
    .end local v5    # "indexOfFileHeader":I
    .end local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    .end local v22    # "offsetLocalFileHeader":J
    .end local v24    # "offsetStartCentralDir":J
    .end local v26    # "offsetEndOfCompressedFile":J
    .end local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    if-eqz v34, :cond_e

    .line 208
    :try_start_1a
    invoke-virtual/range {v34 .. v34}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_8

    .line 211
    :catch_b
    move-exception v0

    goto :goto_a

    .line 209
    :cond_e
    :goto_8
    nop

    .line 210
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_1a
    .catch Ljava/io/IOException; {:try_start_1a .. :try_end_1a} :catch_b

    .line 213
    nop

    .line 215
    if-eqz v14, :cond_f

    .line 216
    invoke-direct {v9, v11, v15}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->restoreFileName(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_9

    .line 218
    :cond_f
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v15}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 219
    .local v0, "newZipFile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 221
    .end local v0    # "newZipFile":Ljava/io/File;
    nop

    .line 223
    :goto_9
    return-object v6

    .line 212
    .local v0, "e":Ljava/io/IOException;
    :goto_a
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v13}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 206
    .end local v0    # "e":Ljava/io/IOException;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    :catchall_5
    move-exception v0

    goto :goto_b

    .line 202
    :catch_c
    move-exception v0

    goto :goto_c

    .line 199
    :catch_d
    move-exception v0

    goto :goto_d

    .line 206
    :catchall_6
    move-exception v0

    move-object/from16 v1, p1

    :goto_b
    move-object/from16 v6, v31

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v31    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_10

    .line 202
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    :catch_e
    move-exception v0

    move-object/from16 v1, p1

    :goto_c
    move-object/from16 v6, v31

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v31    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_e

    .line 199
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    :catch_f
    move-exception v0

    move-object/from16 v1, p1

    :goto_d
    move-object/from16 v6, v31

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v31    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_f

    .line 206
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    :catchall_7
    move-exception v0

    move-object/from16 v1, p1

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_10

    .line 202
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    :catch_10
    move-exception v0

    move-object/from16 v1, p1

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_e

    .line 199
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v31    # "retMap":Ljava/util/HashMap;
    .restart local v32    # "outputStream":Ljava/io/OutputStream;
    :catch_11
    move-exception v0

    move-object/from16 v1, p1

    move-object/from16 v6, v31

    move-object/from16 v2, v32

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v31    # "retMap":Ljava/util/HashMap;
    .end local v32    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_f

    .line 150
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .local v2, "fileHeaderList":Ljava/util/ArrayList;
    .local v3, "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v4    # "zipFile":Ljava/io/File;
    .local v5, "inputStream":Ljava/io/RandomAccessFile;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v8    # "indexOfFileHeader":I
    .local v15, "retMap":Ljava/util/HashMap;
    .restart local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    .restart local v22    # "offsetLocalFileHeader":J
    .restart local v24    # "offsetStartCentralDir":J
    .restart local v26    # "offsetEndOfCompressedFile":J
    :cond_10
    move-object/from16 v28, v2

    move-object/from16 v33, v3

    move-object v11, v4

    move-object/from16 v34, v5

    move-object v2, v7

    move v5, v8

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    .line 151
    .end local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v4    # "zipFile":Ljava/io/File;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v8    # "indexOfFileHeader":I
    .local v2, "outputStream":Ljava/io/OutputStream;
    .local v5, "indexOfFileHeader":I
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .restart local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    :try_start_1b
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v3, "invalid offset for start and end of local file, cannot remove file"

    invoke-direct {v0, v3}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v14    # "successFlag":Z
    .end local v15    # "tmpZipFileName":Ljava/lang/String;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0

    .line 116
    .end local v22    # "offsetLocalFileHeader":J
    .end local v24    # "offsetStartCentralDir":J
    .end local v26    # "offsetEndOfCompressedFile":J
    .end local v28    # "fileHeaderList":Ljava/util/ArrayList;
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v4    # "zipFile":Ljava/io/File;
    .local v5, "inputStream":Ljava/io/RandomAccessFile;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v8    # "indexOfFileHeader":I
    .restart local v14    # "successFlag":Z
    .local v15, "retMap":Ljava/util/HashMap;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :cond_11
    move-object/from16 v33, v3

    move-object v11, v4

    move-object/from16 v34, v5

    move-object v2, v7

    move v5, v8

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    .end local v3    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .end local v4    # "zipFile":Ljava/io/File;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v8    # "indexOfFileHeader":I
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v5, "indexOfFileHeader":I
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v3, "invalid local file header, cannot remove file from archive"

    invoke-direct {v0, v3}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v14    # "successFlag":Z
    .end local v15    # "tmpZipFileName":Ljava/lang/String;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0
    :try_end_1b
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_1b .. :try_end_1b} :catch_13
    .catch Ljava/lang/Exception; {:try_start_1b .. :try_end_1b} :catch_12
    .catchall {:try_start_1b .. :try_end_1b} :catchall_8

    .line 206
    .end local v5    # "indexOfFileHeader":I
    .end local v16    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    .end local v33    # "headerReader":Lnet/lingala/zip4j/core/HeaderReader;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .restart local v14    # "successFlag":Z
    .restart local v15    # "tmpZipFileName":Ljava/lang/String;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catchall_8
    move-exception v0

    move-object v4, v15

    move-object/from16 v3, v34

    goto/16 :goto_10

    .line 202
    :catch_12
    move-exception v0

    move-object v4, v15

    move-object/from16 v3, v34

    goto/16 :goto_e

    .line 199
    :catch_13
    move-exception v0

    move-object v4, v15

    move-object/from16 v3, v34

    goto/16 :goto_f

    .line 206
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .local v5, "inputStream":Ljava/io/RandomAccessFile;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catchall_9
    move-exception v0

    move-object v11, v4

    move-object/from16 v34, v5

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_10

    .line 202
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_14
    move-exception v0

    move-object v11, v4

    move-object/from16 v34, v5

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_e

    .line 199
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .restart local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_15
    move-exception v0

    move-object v11, v4

    move-object/from16 v34, v5

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    move-object/from16 v3, v34

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v5    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    .restart local v34    # "inputStream":Ljava/io/RandomAccessFile;
    goto/16 :goto_f

    .line 206
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v34    # "inputStream":Ljava/io/RandomAccessFile;
    .local v3, "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "zipFile":Ljava/io/File;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catchall_a
    move-exception v0

    move-object v11, v4

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_10

    .line 202
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .restart local v4    # "zipFile":Ljava/io/File;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_16
    move-exception v0

    move-object v11, v4

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_e

    .line 199
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .restart local v4    # "zipFile":Ljava/io/File;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_17
    move-exception v0

    move-object v11, v4

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    .end local v4    # "zipFile":Ljava/io/File;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_f

    .line 206
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v11    # "zipFile":Ljava/io/File;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    .restart local v18    # "zipFile":Ljava/io/File;
    :catchall_b
    move-exception v0

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    move-object/from16 v11, v18

    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_10

    .line 202
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_18
    move-exception v0

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    move-object/from16 v11, v18

    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_e

    .line 199
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_19
    move-exception v0

    move-object v2, v7

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v4, v15

    move-object/from16 v11, v18

    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_f

    .line 105
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v8    # "indexOfFileHeader":I
    .local v15, "retMap":Ljava/util/HashMap;
    .restart local v19    # "tmpFile":Ljava/io/File;
    .restart local v20    # "currTime":J
    :catch_1a
    move-exception v0

    move v5, v8

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    .line 106
    .end local v8    # "indexOfFileHeader":I
    .local v0, "e1":Ljava/io/FileNotFoundException;
    .local v5, "indexOfFileHeader":I
    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    :try_start_1c
    new-instance v2, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v2, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v14    # "successFlag":Z
    .end local v15    # "tmpZipFileName":Ljava/lang/String;
    .end local v18    # "zipFile":Ljava/io/File;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v2
    :try_end_1c
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_1c .. :try_end_1c} :catch_1c
    .catch Ljava/lang/Exception; {:try_start_1c .. :try_end_1c} :catch_1b
    .catchall {:try_start_1c .. :try_end_1c} :catchall_c

    .line 206
    .end local v0    # "e1":Ljava/io/FileNotFoundException;
    .end local v5    # "indexOfFileHeader":I
    .end local v19    # "tmpFile":Ljava/io/File;
    .end local v20    # "currTime":J
    .restart local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v14    # "successFlag":Z
    .restart local v15    # "tmpZipFileName":Ljava/lang/String;
    .restart local v18    # "zipFile":Ljava/io/File;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catchall_c
    move-exception v0

    move-object v2, v7

    move-object v4, v15

    move-object/from16 v11, v18

    goto/16 :goto_10

    .line 202
    :catch_1b
    move-exception v0

    move-object v2, v7

    move-object v4, v15

    move-object/from16 v11, v18

    goto/16 :goto_e

    .line 199
    :catch_1c
    move-exception v0

    move-object v2, v7

    move-object v4, v15

    move-object/from16 v11, v18

    goto/16 :goto_f

    .line 206
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .local v15, "retMap":Ljava/util/HashMap;
    :catchall_d
    move-exception v0

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v2, v7

    move-object v4, v15

    move-object/from16 v11, v18

    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_10

    .line 202
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_1d
    move-exception v0

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v2, v7

    move-object v4, v15

    move-object/from16 v11, v18

    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_e

    .line 199
    .local v6, "tmpZipFileName":Ljava/lang/String;
    .local v15, "retMap":Ljava/util/HashMap;
    :catch_1e
    move-exception v0

    move-object v1, v10

    move-object/from16 v35, v15

    move-object v15, v6

    move-object/from16 v6, v35

    move-object v2, v7

    move-object v4, v15

    move-object/from16 v11, v18

    .local v6, "retMap":Ljava/util/HashMap;
    .local v15, "tmpZipFileName":Ljava/lang/String;
    goto/16 :goto_f

    .line 206
    .end local v6    # "retMap":Ljava/util/HashMap;
    .local v4, "tmpZipFileName":Ljava/lang/String;
    .local v15, "retMap":Ljava/util/HashMap;
    :catchall_e
    move-exception v0

    move-object v1, v10

    move-object v6, v15

    move-object v2, v7

    move-object/from16 v11, v18

    .end local v15    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_10

    .line 202
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v15    # "retMap":Ljava/util/HashMap;
    :catch_1f
    move-exception v0

    move-object v1, v10

    move-object v6, v15

    move-object v2, v7

    move-object/from16 v11, v18

    .end local v15    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_e

    .line 199
    .end local v6    # "retMap":Ljava/util/HashMap;
    .restart local v15    # "retMap":Ljava/util/HashMap;
    :catch_20
    move-exception v0

    move-object v1, v10

    move-object v6, v15

    move-object v2, v7

    move-object/from16 v11, v18

    .end local v15    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    goto/16 :goto_f

    .line 90
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v18    # "zipFile":Ljava/io/File;
    .local v1, "outputStream":Ljava/io/OutputStream;
    .local v2, "zipFile":Ljava/io/File;
    .restart local v8    # "indexOfFileHeader":I
    .restart local v15    # "retMap":Ljava/util/HashMap;
    :cond_12
    move-object v7, v1

    move-object/from16 v18, v2

    move v5, v8

    move-object v1, v10

    move-object v6, v15

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "zipFile":Ljava/io/File;
    .end local v8    # "indexOfFileHeader":I
    .end local v15    # "retMap":Ljava/util/HashMap;
    .restart local v5    # "indexOfFileHeader":I
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v18    # "zipFile":Ljava/io/File;
    :try_start_1d
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "This is a split archive. Zip file format does not allow updating split/spanned files"

    invoke-direct {v0, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v4    # "tmpZipFileName":Ljava/lang/String;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v14    # "successFlag":Z
    .end local v18    # "zipFile":Ljava/io/File;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0

    .line 86
    .end local v5    # "indexOfFileHeader":I
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "zipFile":Ljava/io/File;
    .restart local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "tmpZipFileName":Ljava/lang/String;
    .restart local v8    # "indexOfFileHeader":I
    .restart local v14    # "successFlag":Z
    .restart local v15    # "retMap":Ljava/util/HashMap;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :cond_13
    move-object v7, v1

    move-object/from16 v18, v2

    move v5, v8

    move-object v1, v10

    move-object v6, v15

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "zipFile":Ljava/io/File;
    .end local v8    # "indexOfFileHeader":I
    .end local v15    # "retMap":Ljava/util/HashMap;
    .restart local v5    # "indexOfFileHeader":I
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v18    # "zipFile":Ljava/io/File;
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "file header not found in zip model, cannot remove file"

    invoke-direct {v0, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v4    # "tmpZipFileName":Ljava/lang/String;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v14    # "successFlag":Z
    .end local v18    # "zipFile":Ljava/io/File;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0
    :try_end_1d
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_1d .. :try_end_1d} :catch_22
    .catch Ljava/lang/Exception; {:try_start_1d .. :try_end_1d} :catch_21
    .catchall {:try_start_1d .. :try_end_1d} :catchall_f

    .line 206
    .end local v5    # "indexOfFileHeader":I
    .restart local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "tmpZipFileName":Ljava/lang/String;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v14    # "successFlag":Z
    .restart local v18    # "zipFile":Ljava/io/File;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catchall_f
    move-exception v0

    move-object v2, v7

    move-object/from16 v11, v18

    goto :goto_10

    .line 202
    :catch_21
    move-exception v0

    move-object v2, v7

    move-object/from16 v11, v18

    goto :goto_e

    .line 199
    :catch_22
    move-exception v0

    move-object v2, v7

    move-object/from16 v11, v18

    goto :goto_f

    .line 206
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v18    # "zipFile":Ljava/io/File;
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "zipFile":Ljava/io/File;
    .restart local v15    # "retMap":Ljava/util/HashMap;
    :catchall_10
    move-exception v0

    move-object v7, v1

    move-object/from16 v18, v2

    move-object v1, v10

    move-object v6, v15

    move-object v2, v7

    move-object/from16 v11, v18

    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v2    # "zipFile":Ljava/io/File;
    .end local v15    # "retMap":Ljava/util/HashMap;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v7    # "outputStream":Ljava/io/OutputStream;
    .restart local v18    # "zipFile":Ljava/io/File;
    goto :goto_10

    .line 202
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v7    # "outputStream":Ljava/io/OutputStream;
    .end local v18    # "zipFile":Ljava/io/File;
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .restart local v2    # "zipFile":Ljava/io/File;
    .restart local v15    # "retMap":Ljava/util/HashMap;
    :catch_23
    move-exception v0

    move-object v7, v1

    move-object/from16 v18, v2

    move-object v1, v10

    move-object v6, v15

    move-object v2, v7

    move-object/from16 v11, v18

    .line 203
    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v15    # "retMap":Ljava/util/HashMap;
    .local v0, "e":Ljava/lang/Exception;
    .local v2, "outputStream":Ljava/io/OutputStream;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    :goto_e
    :try_start_1e
    invoke-virtual {v12, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 204
    new-instance v5, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v5, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v4    # "tmpZipFileName":Ljava/lang/String;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v14    # "successFlag":Z
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v5

    .line 199
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v1    # "outputStream":Ljava/io/OutputStream;
    .local v2, "zipFile":Ljava/io/File;
    .restart local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "tmpZipFileName":Ljava/lang/String;
    .restart local v14    # "successFlag":Z
    .restart local v15    # "retMap":Ljava/util/HashMap;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catch_24
    move-exception v0

    move-object v7, v1

    move-object/from16 v18, v2

    move-object v1, v10

    move-object v6, v15

    move-object v2, v7

    move-object/from16 v11, v18

    .line 200
    .end local v1    # "outputStream":Ljava/io/OutputStream;
    .end local v15    # "retMap":Ljava/util/HashMap;
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    .local v2, "outputStream":Ljava/io/OutputStream;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    :goto_f
    invoke-virtual {v12, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 201
    nop

    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v4    # "tmpZipFileName":Ljava/lang/String;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v14    # "successFlag":Z
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0
    :try_end_1e
    .catchall {:try_start_1e .. :try_end_1e} :catchall_11

    .line 206
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    .restart local v2    # "outputStream":Ljava/io/OutputStream;
    .restart local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .restart local v4    # "tmpZipFileName":Ljava/lang/String;
    .restart local v6    # "retMap":Ljava/util/HashMap;
    .restart local v11    # "zipFile":Ljava/io/File;
    .restart local v14    # "successFlag":Z
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catchall_11
    move-exception v0

    .line 207
    :goto_10
    if-eqz v3, :cond_14

    .line 208
    :try_start_1f
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V

    goto :goto_11

    .line 211
    :catch_25
    move-exception v0

    goto :goto_12

    .line 209
    :cond_14
    :goto_11
    if-eqz v2, :cond_15

    .line 210
    invoke-virtual {v2}, Ljava/io/OutputStream;->close()V
    :try_end_1f
    .catch Ljava/io/IOException; {:try_start_1f .. :try_end_1f} :catch_25

    goto :goto_13

    .line 212
    .local v0, "e":Ljava/io/IOException;
    :goto_12
    new-instance v5, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v5, v13}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 213
    .end local v0    # "e":Ljava/io/IOException;
    :cond_15
    :goto_13
    nop

    .line 215
    if-eqz v14, :cond_16

    .line 216
    invoke-direct {v9, v11, v4}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->restoreFileName(Ljava/io/File;Ljava/lang/String;)V

    goto :goto_14

    .line 218
    :cond_16
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 219
    .local v5, "newZipFile":Ljava/io/File;
    invoke-virtual {v5}, Ljava/io/File;->delete()Z

    .line 220
    .end local v5    # "newZipFile":Ljava/io/File;
    :goto_14
    throw v0

    .line 71
    .end local v2    # "outputStream":Ljava/io/OutputStream;
    .end local v3    # "inputStream":Ljava/io/RandomAccessFile;
    .end local v4    # "tmpZipFileName":Ljava/lang/String;
    .end local v6    # "retMap":Ljava/util/HashMap;
    .end local v11    # "zipFile":Ljava/io/File;
    .end local v14    # "successFlag":Z
    :cond_17
    move-object v1, v10

    .line 72
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "input parameters is null in maintain zip file, cannot remove file from archive"

    invoke-direct {v0, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_16

    :goto_15
    throw v0

    :goto_16
    goto :goto_15
.end method

.method public mergeSplitZipFiles(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/File;Lnet/lingala/zip4j/progress/ProgressMonitor;Z)V
    .locals 7
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputZipFile"    # Ljava/io/File;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .param p4, "runInThread"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 325
    if-eqz p4, :cond_0

    .line 326
    new-instance v6, Lnet/lingala/zip4j/util/ArchiveMaintainer$2;

    const-string v2, "Zip4j"

    move-object v0, v6

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lnet/lingala/zip4j/util/ArchiveMaintainer$2;-><init>(Lnet/lingala/zip4j/util/ArchiveMaintainer;Ljava/lang/String;Lnet/lingala/zip4j/model/ZipModel;Ljava/io/File;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 334
    .local v0, "thread":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 335
    .end local v0    # "thread":Ljava/lang/Thread;
    goto :goto_0

    .line 336
    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->initMergeSplitZipFile(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/File;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 338
    :goto_0
    return-void
.end method

.method public removeZipFile(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Lnet/lingala/zip4j/progress/ProgressMonitor;Z)Ljava/util/HashMap;
    .locals 7
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileHeader"    # Lnet/lingala/zip4j/model/FileHeader;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .param p4, "runInThread"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 48
    if-eqz p4, :cond_0

    .line 49
    new-instance v6, Lnet/lingala/zip4j/util/ArchiveMaintainer$1;

    const-string v2, "Zip4j"

    move-object v0, v6

    move-object v1, p0

    move-object v3, p1

    move-object v4, p2

    move-object v5, p3

    invoke-direct/range {v0 .. v5}, Lnet/lingala/zip4j/util/ArchiveMaintainer$1;-><init>(Lnet/lingala/zip4j/util/ArchiveMaintainer;Ljava/lang/String;Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 58
    .local v0, "thread":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 59
    const/4 v1, 0x0

    return-object v1

    .line 61
    .end local v0    # "thread":Ljava/lang/Thread;
    :cond_0
    invoke-virtual {p0, p1, p2, p3}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->initRemoveZipFile(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Lnet/lingala/zip4j/progress/ProgressMonitor;)Ljava/util/HashMap;

    move-result-object v0

    .line 62
    .local v0, "retMap":Ljava/util/HashMap;
    invoke-virtual {p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorSuccess()V

    .line 63
    return-object v0
.end method

.method public setComment(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)V
    .locals 7
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "comment"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 616
    if-eqz p2, :cond_5

    .line 620
    if-eqz p1, :cond_4

    .line 624
    move-object v0, p2

    .line 625
    .local v0, "encodedComment":Ljava/lang/String;
    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    .line 626
    .local v1, "commentBytes":[B
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    .line 628
    .local v2, "commentLength":I
    const-string v3, "windows-1254"

    invoke-static {v3}, Lnet/lingala/zip4j/util/Zip4jUtil;->isSupportedCharset(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 630
    :try_start_0
    new-instance v4, Ljava/lang/String;

    invoke-virtual {p2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v5

    invoke-direct {v4, v5, v3}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    move-object v0, v4

    .line 631
    invoke-virtual {v0, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v3

    move-object v1, v3

    .line 632
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v3
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    move v2, v3

    .line 637
    goto :goto_0

    .line 633
    :catch_0
    move-exception v3

    .line 634
    .local v3, "e":Ljava/io/UnsupportedEncodingException;
    move-object v0, p2

    .line 635
    invoke-virtual {p2}, Ljava/lang/String;->getBytes()[B

    move-result-object v1

    .line 636
    invoke-virtual {p2}, Ljava/lang/String;->length()I

    move-result v2

    .line 640
    .end local v3    # "e":Ljava/io/UnsupportedEncodingException;
    :cond_0
    :goto_0
    const v3, 0xffff

    if-gt v2, v3, :cond_3

    .line 644
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3, v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setComment(Ljava/lang/String;)V

    .line 645
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setCommentBytes([B)V

    .line 646
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3, v2}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setCommentLength(I)V

    .line 648
    const/4 v3, 0x0

    .line 651
    .local v3, "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    :try_start_1
    new-instance v4, Lnet/lingala/zip4j/core/HeaderWriter;

    invoke-direct {v4}, Lnet/lingala/zip4j/core/HeaderWriter;-><init>()V

    .line 652
    .local v4, "headerWriter":Lnet/lingala/zip4j/core/HeaderWriter;
    new-instance v5, Lnet/lingala/zip4j/io/SplitOutputStream;

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Lnet/lingala/zip4j/io/SplitOutputStream;-><init>(Ljava/lang/String;)V

    move-object v3, v5

    .line 654
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 655
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;->getOffsetStartCenDirWRTStartDiskNo()J

    move-result-wide v5

    invoke-virtual {v3, v5, v6}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V

    goto :goto_1

    .line 657
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v5

    invoke-virtual {v3, v5, v6}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V

    .line 660
    :goto_1
    invoke-virtual {v4, p1, v3}, Lnet/lingala/zip4j/core/HeaderWriter;->finalizeZipFileWithoutValidations(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V
    :try_end_1
    .catch Ljava/io/FileNotFoundException; {:try_start_1 .. :try_end_1} :catch_3
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 666
    .end local v4    # "headerWriter":Lnet/lingala/zip4j/core/HeaderWriter;
    nop

    .line 668
    :try_start_2
    invoke-virtual {v3}, Lnet/lingala/zip4j/io/SplitOutputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_1

    .line 671
    :goto_2
    goto :goto_3

    .line 669
    :catch_1
    move-exception v4

    goto :goto_2

    .line 674
    :goto_3
    return-void

    .line 666
    :catchall_0
    move-exception v4

    goto :goto_4

    .line 663
    :catch_2
    move-exception v4

    .line 664
    .local v4, "e":Ljava/io/IOException;
    :try_start_3
    new-instance v5, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v5, v4}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v0    # "encodedComment":Ljava/lang/String;
    .end local v1    # "commentBytes":[B
    .end local v2    # "commentLength":I
    .end local v3    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "comment":Ljava/lang/String;
    throw v5

    .line 661
    .end local v4    # "e":Ljava/io/IOException;
    .restart local v0    # "encodedComment":Ljava/lang/String;
    .restart local v1    # "commentBytes":[B
    .restart local v2    # "commentLength":I
    .restart local v3    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "comment":Ljava/lang/String;
    :catch_3
    move-exception v4

    .line 662
    .local v4, "e":Ljava/io/FileNotFoundException;
    new-instance v5, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v5, v4}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v0    # "encodedComment":Ljava/lang/String;
    .end local v1    # "commentBytes":[B
    .end local v2    # "commentLength":I
    .end local v3    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "comment":Ljava/lang/String;
    throw v5
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 666
    .end local v4    # "e":Ljava/io/FileNotFoundException;
    .restart local v0    # "encodedComment":Ljava/lang/String;
    .restart local v1    # "commentBytes":[B
    .restart local v2    # "commentLength":I
    .restart local v3    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "comment":Ljava/lang/String;
    :goto_4
    if-eqz v3, :cond_2

    .line 668
    :try_start_4
    invoke-virtual {v3}, Lnet/lingala/zip4j/io/SplitOutputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_4

    .line 671
    goto :goto_5

    .line 669
    :catch_4
    move-exception v5

    .line 671
    :cond_2
    :goto_5
    throw v4

    .line 641
    .end local v3    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    :cond_3
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    const-string v4, "comment length exceeds maximum length"

    invoke-direct {v3, v4}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 621
    .end local v0    # "encodedComment":Ljava/lang/String;
    .end local v1    # "commentBytes":[B
    .end local v2    # "commentLength":I
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zipModel is null, cannot update Zip file with comment"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 617
    :cond_5
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "comment is null, cannot update Zip file with comment"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_7

    :goto_6
    throw v0

    :goto_7
    goto :goto_6
.end method
