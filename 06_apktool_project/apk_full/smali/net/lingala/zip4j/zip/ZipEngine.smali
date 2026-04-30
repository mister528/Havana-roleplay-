.class public Lnet/lingala/zip4j/zip/ZipEngine;
.super Ljava/lang/Object;
.source "ZipEngine.java"


# instance fields
.field private zipModel:Lnet/lingala/zip4j/model/ZipModel;


# direct methods
.method public constructor <init>(Lnet/lingala/zip4j/model/ZipModel;)V
    .locals 2
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    if-eqz p1, :cond_0

    .line 52
    iput-object p1, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    .line 53
    return-void

    .line 49
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model is null in ZipEngine constructor"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static synthetic access$000(Lnet/lingala/zip4j/zip/ZipEngine;Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 0
    .param p0, "x0"    # Lnet/lingala/zip4j/zip/ZipEngine;
    .param p1, "x1"    # Ljava/util/ArrayList;
    .param p2, "x2"    # Lnet/lingala/zip4j/model/ZipParameters;
    .param p3, "x3"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 42
    invoke-direct {p0, p1, p2, p3}, Lnet/lingala/zip4j/zip/ZipEngine;->initAddFiles(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    return-void
.end method

.method private calculateTotalWork(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;)J
    .locals 9
    .param p1, "fileList"    # Ljava/util/ArrayList;
    .param p2, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 453
    if-eqz p1, :cond_3

    .line 457
    const-wide/16 v0, 0x0

    .line 459
    .local v0, "totalWork":J
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-ge v2, v3, :cond_2

    .line 460
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    instance-of v3, v3, Ljava/io/File;

    if-eqz v3, :cond_1

    .line 461
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 462
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->isEncryptFiles()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->getEncryptionMethod()I

    move-result v3

    if-nez v3, :cond_0

    .line 464
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/io/File;

    invoke-static {v3}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v3

    const-wide/16 v5, 0x2

    mul-long v3, v3, v5

    add-long/2addr v0, v3

    goto :goto_1

    .line 466
    :cond_0
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/io/File;

    invoke-static {v3}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v3

    add-long/2addr v0, v3

    .line 469
    :goto_1
    iget-object v3, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v3

    if-eqz v3, :cond_1

    iget-object v3, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-lez v3, :cond_1

    .line 472
    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/io/File;

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->getRootFolderInZip()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->getDefaultFolderPath()Ljava/lang/String;

    move-result-object v5

    invoke-static {v3, v4, v5}, Lnet/lingala/zip4j/util/Zip4jUtil;->getRelativeFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 474
    .local v3, "relativeFileName":Ljava/lang/String;
    iget-object v4, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-static {v4, v3}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileHeader(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;

    move-result-object v4

    .line 475
    .local v4, "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    if-eqz v4, :cond_1

    .line 476
    new-instance v5, Ljava/io/File;

    iget-object v6, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v6}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-static {v5}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v5

    invoke-virtual {v4}, Lnet/lingala/zip4j/model/FileHeader;->getCompressedSize()J

    move-result-wide v7

    sub-long/2addr v5, v7

    add-long/2addr v0, v5

    .line 459
    .end local v3    # "relativeFileName":Ljava/lang/String;
    .end local v4    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    :cond_1
    add-int/lit8 v2, v2, 0x1

    goto/16 :goto_0

    .line 483
    .end local v2    # "i":I
    :cond_2
    return-wide v0

    .line 454
    .end local v0    # "totalWork":J
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "file list is null, cannot calculate total work"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method private checkParameters(Lnet/lingala/zip4j/model/ZipParameters;)V
    .locals 2
    .param p1, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 303
    if-eqz p1, :cond_8

    .line 307
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getCompressionMethod()I

    move-result v0

    const/16 v1, 0x8

    if-eqz v0, :cond_1

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getCompressionMethod()I

    move-result v0

    if-ne v0, v1, :cond_0

    goto :goto_0

    .line 309
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "unsupported compression type"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 312
    :cond_1
    :goto_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getCompressionMethod()I

    move-result v0

    if-ne v0, v1, :cond_3

    .line 313
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getCompressionLevel()I

    move-result v0

    if-gez v0, :cond_3

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getCompressionLevel()I

    move-result v0

    const/16 v1, 0x9

    if-gt v0, v1, :cond_2

    goto :goto_1

    .line 314
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "invalid compression level. compression level dor deflate should be in the range of 0-9"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 318
    :cond_3
    :goto_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->isEncryptFiles()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 319
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getEncryptionMethod()I

    move-result v0

    if-eqz v0, :cond_5

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getEncryptionMethod()I

    move-result v0

    const/16 v1, 0x63

    if-ne v0, v1, :cond_4

    goto :goto_2

    .line 321
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "unsupported encryption method"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 324
    :cond_5
    :goto_2
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getPassword()[C

    move-result-object v0

    if-eqz v0, :cond_6

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipParameters;->getPassword()[C

    move-result-object v0

    array-length v0, v0

    if-lez v0, :cond_6

    goto :goto_3

    .line 325
    :cond_6
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input password is empty or null"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 328
    :cond_7
    const/4 v0, -0x1

    invoke-virtual {p1, v0}, Lnet/lingala/zip4j/model/ZipParameters;->setAesKeyStrength(I)V

    .line 329
    invoke-virtual {p1, v0}, Lnet/lingala/zip4j/model/ZipParameters;->setEncryptionMethod(I)V

    .line 332
    :goto_3
    return-void

    .line 304
    :cond_8
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "cannot validate zip parameters"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private createEndOfCentralDirectoryRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;
    .locals 3

    .line 443
    new-instance v0, Lnet/lingala/zip4j/model/EndCentralDirRecord;

    invoke-direct {v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;-><init>()V

    .line 444
    .local v0, "endCentralDirRecord":Lnet/lingala/zip4j/model/EndCentralDirRecord;
    const-wide/32 v1, 0x6054b50

    invoke-virtual {v0, v1, v2}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setSignature(J)V

    .line 445
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setNoOfThisDisk(I)V

    .line 446
    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setTotNoOfEntriesInCentralDir(I)V

    .line 447
    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setTotNoOfEntriesInCentralDirOnThisDisk(I)V

    .line 448
    const-wide/16 v1, 0x0

    invoke-virtual {v0, v1, v2}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setOffsetOfStartOfCentralDir(J)V

    .line 449
    return-object v0
.end method

.method private initAddFiles(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 17
    .param p1, "fileList"    # Ljava/util/ArrayList;
    .param p2, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 92
    move-object/from16 v1, p0

    move-object/from16 v2, p1

    move-object/from16 v3, p2

    move-object/from16 v4, p3

    if-eqz v2, :cond_10

    if-eqz v3, :cond_10

    .line 96
    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_f

    .line 100
    iget-object v0, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    if-nez v0, :cond_0

    .line 101
    iget-object v0, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-direct/range {p0 .. p0}, Lnet/lingala/zip4j/zip/ZipEngine;->createEndOfCentralDirectoryRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v5

    invoke-virtual {v0, v5}, Lnet/lingala/zip4j/model/ZipModel;->setEndCentralDirRecord(Lnet/lingala/zip4j/model/EndCentralDirRecord;)V

    .line 104
    :cond_0
    const/4 v5, 0x0

    .line 105
    .local v5, "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    const/4 v6, 0x0

    .line 107
    .local v6, "inputStream":Ljava/io/InputStream;
    :try_start_0
    invoke-direct {v1, v3}, Lnet/lingala/zip4j/zip/ZipEngine;->checkParameters(Lnet/lingala/zip4j/model/ZipParameters;)V

    .line 109
    invoke-direct/range {p0 .. p3}, Lnet/lingala/zip4j/zip/ZipEngine;->removeFilesIfExists(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 111
    iget-object v0, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/lang/String;)Z

    move-result v0

    move v7, v0

    .line 113
    .local v7, "isZipFileAlreadExists":Z
    new-instance v0, Lnet/lingala/zip4j/io/SplitOutputStream;

    new-instance v8, Ljava/io/File;

    iget-object v9, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v9}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v9

    invoke-direct {v8, v9}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object v9, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v9}, Lnet/lingala/zip4j/model/ZipModel;->getSplitLength()J

    move-result-wide v9

    invoke-direct {v0, v8, v9, v10}, Lnet/lingala/zip4j/io/SplitOutputStream;-><init>(Ljava/io/File;J)V

    move-object v8, v0

    .line 114
    .local v8, "splitOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    new-instance v0, Lnet/lingala/zip4j/io/ZipOutputStream;

    iget-object v9, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-direct {v0, v8, v9}, Lnet/lingala/zip4j/io/ZipOutputStream;-><init>(Ljava/io/OutputStream;Lnet/lingala/zip4j/model/ZipModel;)V

    move-object v5, v0

    .line 116
    if-eqz v7, :cond_2

    .line 117
    iget-object v0, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 120
    iget-object v0, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v9

    invoke-virtual {v8, v9, v10}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V

    goto :goto_0

    .line 118
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v9, "invalid end of central directory record"

    invoke-direct {v0, v9}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local v6    # "inputStream":Ljava/io/InputStream;
    .end local p1    # "fileList":Ljava/util/ArrayList;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0

    .line 122
    .restart local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .restart local v6    # "inputStream":Ljava/io/InputStream;
    .restart local p1    # "fileList":Ljava/util/ArrayList;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :cond_2
    :goto_0
    const/16 v0, 0x1000

    new-array v0, v0, [B
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_b
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_a
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    move-object v9, v0

    .line 123
    .local v9, "readBuff":[B
    const/4 v0, -0x1

    .line 124
    .local v0, "readLen":I
    const/4 v10, 0x0

    move v11, v10

    move-object v10, v6

    move v6, v0

    .end local v0    # "readLen":I
    .local v6, "readLen":I
    .local v10, "inputStream":Ljava/io/InputStream;
    .local v11, "i":I
    :goto_1
    :try_start_1
    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-ge v11, v0, :cond_b

    .line 126
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v0

    const/4 v12, 0x3

    const/4 v13, 0x0

    if-eqz v0, :cond_4

    .line 127
    invoke-virtual {v4, v12}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 128
    invoke-virtual {v4, v13}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_1
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_1 .. :try_end_1} :catch_9
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_8
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 189
    if-eqz v10, :cond_3

    .line 191
    :try_start_2
    invoke-virtual {v10}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 193
    goto :goto_2

    .line 192
    :catch_0
    move-exception v0

    .line 196
    :cond_3
    :goto_2
    nop

    .line 198
    :try_start_3
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 200
    goto :goto_3

    .line 199
    :catch_1
    move-exception v0

    .line 200
    :goto_3
    return-void

    .line 132
    :cond_4
    :try_start_4
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/ZipParameters;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lnet/lingala/zip4j/model/ZipParameters;

    move-object v14, v0

    .line 134
    .local v14, "fileParameters":Lnet/lingala/zip4j/model/ZipParameters;
    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setFileName(Ljava/lang/String;)V

    .line 136
    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-nez v0, :cond_7

    .line 137
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/ZipParameters;->isEncryptFiles()Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-virtual {v14}, Lnet/lingala/zip4j/model/ZipParameters;->getEncryptionMethod()I

    move-result v0

    if-nez v0, :cond_6

    .line 138
    invoke-virtual {v4, v12}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 139
    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, v4}, Lnet/lingala/zip4j/util/CRCUtil;->computeFileCRC(Ljava/lang/String;Lnet/lingala/zip4j/progress/ProgressMonitor;)J

    move-result-wide v12

    long-to-int v0, v12

    invoke-virtual {v14, v0}, Lnet/lingala/zip4j/model/ZipParameters;->setSourceFileCRC(I)V

    .line 140
    const/4 v0, 0x0

    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 142
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v12

    if-eqz v12, :cond_6

    .line 143
    const/4 v12, 0x3

    invoke-virtual {v4, v12}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 144
    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_4
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_4 .. :try_end_4} :catch_9
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_8
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 189
    if-eqz v10, :cond_5

    .line 191
    :try_start_5
    invoke-virtual {v10}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 193
    goto :goto_4

    .line 192
    :catch_2
    move-exception v0

    .line 196
    :cond_5
    :goto_4
    nop

    .line 198
    :try_start_6
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 200
    goto :goto_5

    .line 199
    :catch_3
    move-exception v0

    .line 200
    :goto_5
    return-void

    .line 149
    :cond_6
    :try_start_7
    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileLengh(Ljava/io/File;)J

    move-result-wide v12

    const-wide/16 v15, 0x0

    cmp-long v0, v12, v15

    if-nez v0, :cond_7

    .line 150
    const/4 v0, 0x0

    invoke-virtual {v14, v0}, Lnet/lingala/zip4j/model/ZipParameters;->setCompressionMethod(I)V

    .line 154
    :cond_7
    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v5, v0, v14}, Lnet/lingala/zip4j/io/ZipOutputStream;->putNextEntry(Ljava/io/File;Lnet/lingala/zip4j/model/ZipParameters;)V

    .line 155
    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_8

    .line 156
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->closeEntry()V

    .line 157
    goto :goto_9

    .line 160
    :cond_8
    new-instance v0, Ljava/io/FileInputStream;

    invoke-virtual {v2, v11}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/io/File;

    invoke-direct {v0, v12}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v10, v0

    .line 162
    :goto_6
    invoke-virtual {v10, v9}, Ljava/io/InputStream;->read([B)I

    move-result v0

    move v6, v0

    const/4 v12, -0x1

    if-eq v0, v12, :cond_a

    .line 163
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v0

    if-eqz v0, :cond_9

    .line 164
    const/4 v0, 0x3

    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 165
    const/4 v0, 0x0

    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_7
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_7 .. :try_end_7} :catch_9
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_8
    .catchall {:try_start_7 .. :try_end_7} :catchall_0

    .line 189
    nop

    .line 191
    :try_start_8
    invoke-virtual {v10}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_4

    .line 193
    goto :goto_7

    .line 192
    :catch_4
    move-exception v0

    .line 196
    :goto_7
    nop

    .line 198
    :try_start_9
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_5

    .line 200
    goto :goto_8

    .line 199
    :catch_5
    move-exception v0

    .line 200
    :goto_8
    return-void

    .line 169
    :cond_9
    const/4 v0, 0x3

    const/4 v12, 0x0

    :try_start_a
    invoke-virtual {v5, v9, v12, v6}, Lnet/lingala/zip4j/io/ZipOutputStream;->write([BII)V

    .line 170
    int-to-long v0, v6

    invoke-virtual {v4, v0, v1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->updateWorkCompleted(J)V

    move-object/from16 v1, p0

    goto :goto_6

    .line 173
    :cond_a
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->closeEntry()V

    .line 175
    nop

    .line 176
    invoke-virtual {v10}, Ljava/io/InputStream;->close()V

    .line 124
    .end local v14    # "fileParameters":Lnet/lingala/zip4j/model/ZipParameters;
    :goto_9
    add-int/lit8 v11, v11, 0x1

    move-object/from16 v1, p0

    goto/16 :goto_1

    .line 180
    .end local v11    # "i":I
    :cond_b
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->finish()V

    .line 181
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorSuccess()V
    :try_end_a
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_a .. :try_end_a} :catch_9
    .catch Ljava/lang/Exception; {:try_start_a .. :try_end_a} :catch_8
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 189
    .end local v6    # "readLen":I
    .end local v7    # "isZipFileAlreadExists":Z
    .end local v8    # "splitOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local v9    # "readBuff":[B
    if-eqz v10, :cond_c

    .line 191
    :try_start_b
    invoke-virtual {v10}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_6

    .line 193
    goto :goto_a

    .line 192
    :catch_6
    move-exception v0

    .line 196
    :cond_c
    :goto_a
    nop

    .line 198
    :try_start_c
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_7

    .line 200
    :goto_b
    goto :goto_c

    .line 199
    :catch_7
    move-exception v0

    goto :goto_b

    .line 203
    :goto_c
    return-void

    .line 189
    :catchall_0
    move-exception v0

    move-object v1, v0

    move-object v6, v10

    goto :goto_f

    .line 185
    :catch_8
    move-exception v0

    move-object v6, v10

    goto :goto_d

    .line 182
    :catch_9
    move-exception v0

    move-object v6, v10

    goto :goto_e

    .line 189
    .end local v10    # "inputStream":Ljava/io/InputStream;
    .local v6, "inputStream":Ljava/io/InputStream;
    :catchall_1
    move-exception v0

    move-object v1, v0

    goto :goto_f

    .line 185
    :catch_a
    move-exception v0

    .line 186
    .local v0, "e":Ljava/lang/Exception;
    :goto_d
    :try_start_d
    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 187
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local v6    # "inputStream":Ljava/io/InputStream;
    .end local p1    # "fileList":Ljava/util/ArrayList;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v1

    .line 182
    .end local v0    # "e":Ljava/lang/Exception;
    .restart local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .restart local v6    # "inputStream":Ljava/io/InputStream;
    .restart local p1    # "fileList":Ljava/util/ArrayList;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catch_b
    move-exception v0

    .line 183
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    :goto_e
    invoke-virtual {v4, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->endProgressMonitorError(Ljava/lang/Throwable;)V

    .line 184
    nop

    .end local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local v6    # "inputStream":Ljava/io/InputStream;
    .end local p1    # "fileList":Ljava/util/ArrayList;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v0
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_1

    .line 189
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    .restart local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .restart local v6    # "inputStream":Ljava/io/InputStream;
    .restart local p1    # "fileList":Ljava/util/ArrayList;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :goto_f
    if-eqz v6, :cond_d

    .line 191
    :try_start_e
    invoke-virtual {v6}, Ljava/io/InputStream;->close()V
    :try_end_e
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_c

    .line 193
    goto :goto_10

    .line 192
    :catch_c
    move-exception v0

    .line 196
    :cond_d
    :goto_10
    if-eqz v5, :cond_e

    .line 198
    :try_start_f
    invoke-virtual {v5}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_d

    .line 200
    goto :goto_11

    .line 199
    :catch_d
    move-exception v0

    .line 200
    :cond_e
    :goto_11
    throw v1

    .line 97
    .end local v5    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local v6    # "inputStream":Ljava/io/InputStream;
    :cond_f
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "no files to add"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 93
    :cond_10
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null when adding files"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_13

    :goto_12
    throw v0

    :goto_13
    goto :goto_12
.end method

.method private prepareFileOutputStream()Ljava/io/RandomAccessFile;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 426
    iget-object v0, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v0

    .line 427
    .local v0, "outPath":Ljava/lang/String;
    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 432
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 433
    .local v1, "outFile":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_0

    .line 434
    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    .line 436
    :cond_0
    new-instance v2, Ljava/io/RandomAccessFile;

    const-string v3, "rw"

    invoke-direct {v2, v1, v3}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 437
    .end local v1    # "outFile":Ljava/io/File;
    :catch_0
    move-exception v1

    .line 438
    .local v1, "e":Ljava/io/FileNotFoundException;
    new-instance v2, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v2, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v2

    .line 428
    .end local v1    # "e":Ljava/io/FileNotFoundException;
    :cond_1
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    const-string v2, "invalid output path"

    invoke-direct {v1, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method private removeFilesIfExists(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V
    .locals 16
    .param p1, "fileList"    # Ljava/util/ArrayList;
    .param p2, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 347
    move-object/from16 v1, p0

    move-object/from16 v2, p3

    const-string v0, "offsetCentralDir"

    iget-object v3, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    if-eqz v3, :cond_8

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v3

    if-eqz v3, :cond_8

    iget-object v3, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v3

    if-eqz v3, :cond_8

    iget-object v3, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v3

    invoke-virtual {v3}, Ljava/util/ArrayList;->size()I

    move-result v3

    if-gtz v3, :cond_0

    move-object/from16 v5, p1

    goto/16 :goto_b

    .line 353
    :cond_0
    const/4 v3, 0x0

    .line 356
    .local v3, "outputStream":Ljava/io/RandomAccessFile;
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    :try_start_0
    invoke-virtual/range {p1 .. p1}, Ljava/util/ArrayList;->size()I

    move-result v5
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_5
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-ge v4, v5, :cond_5

    .line 357
    move-object/from16 v5, p1

    :try_start_1
    invoke-virtual {v5, v4}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/io/File;

    .line 359
    .local v6, "file":Ljava/io/File;
    invoke-virtual {v6}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/ZipParameters;->getRootFolderInZip()Ljava/lang/String;

    move-result-object v8

    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/ZipParameters;->getDefaultFolderPath()Ljava/lang/String;

    move-result-object v9

    invoke-static {v7, v8, v9}, Lnet/lingala/zip4j/util/Zip4jUtil;->getRelativeFileName(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    .line 362
    .local v7, "fileName":Ljava/lang/String;
    iget-object v8, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-static {v8, v7}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFileHeader(Lnet/lingala/zip4j/model/ZipModel;Ljava/lang/String;)Lnet/lingala/zip4j/model/FileHeader;

    move-result-object v8

    .line 363
    .local v8, "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    if-eqz v8, :cond_4

    .line 365
    if-eqz v3, :cond_1

    .line 366
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V

    .line 367
    const/4 v3, 0x0

    .line 370
    :cond_1
    new-instance v9, Lnet/lingala/zip4j/util/ArchiveMaintainer;

    invoke-direct {v9}, Lnet/lingala/zip4j/util/ArchiveMaintainer;-><init>()V

    .line 371
    .local v9, "archiveMaintainer":Lnet/lingala/zip4j/util/ArchiveMaintainer;
    const/4 v10, 0x2

    invoke-virtual {v2, v10}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 372
    iget-object v10, v1, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v9, v10, v8, v2}, Lnet/lingala/zip4j/util/ArchiveMaintainer;->initRemoveZipFile(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Lnet/lingala/zip4j/progress/ProgressMonitor;)Ljava/util/HashMap;

    move-result-object v10

    .line 375
    .local v10, "retMap":Ljava/util/HashMap;
    invoke-virtual/range {p3 .. p3}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v11

    const/4 v12, 0x0

    if-eqz v11, :cond_3

    .line 376
    const/4 v0, 0x3

    invoke-virtual {v2, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 377
    invoke-virtual {v2, v12}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_3
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 415
    if-eqz v3, :cond_2

    .line 417
    :try_start_2
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    .line 420
    goto :goto_1

    .line 418
    :catch_0
    move-exception v0

    .line 420
    :cond_2
    :goto_1
    return-void

    .line 381
    :cond_3
    :try_start_3
    invoke-virtual {v2, v12}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 384
    if-nez v3, :cond_4

    .line 385
    invoke-direct/range {p0 .. p0}, Lnet/lingala/zip4j/zip/ZipEngine;->prepareFileOutputStream()Ljava/io/RandomAccessFile;

    move-result-object v11

    move-object v3, v11

    .line 387
    if-eqz v10, :cond_4

    .line 388
    invoke-virtual {v10, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-eqz v11, :cond_4

    .line 389
    const-wide/16 v11, -0x1

    .line 391
    .local v11, "offsetCentralDir":J
    :try_start_4
    invoke-virtual {v10, v0}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Ljava/lang/String;

    invoke-static {v13}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v13
    :try_end_4
    .catch Ljava/lang/NumberFormatException; {:try_start_4 .. :try_end_4} :catch_2
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_1
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3
    .catchall {:try_start_4 .. :try_end_4} :catchall_1

    move-wide v11, v13

    .line 402
    nop

    .line 404
    const-wide/16 v13, 0x0

    cmp-long v15, v11, v13

    if-ltz v15, :cond_4

    .line 405
    :try_start_5
    invoke-virtual {v3, v11, v12}, Ljava/io/RandomAccessFile;->seek(J)V

    goto :goto_4

    .line 398
    :catch_1
    move-exception v0

    goto :goto_2

    .line 394
    :catch_2
    move-exception v0

    goto :goto_3

    .line 399
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    new-instance v13, Lnet/lingala/zip4j/exception/ZipException;

    const-string v14, "Error while parsing offset central directory. Cannot update already existing file header"

    invoke-direct {v13, v14}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v3    # "outputStream":Ljava/io/RandomAccessFile;
    .end local p1    # "fileList":Ljava/util/ArrayList;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v13

    .line 395
    .local v0, "e":Ljava/lang/NumberFormatException;
    .restart local v3    # "outputStream":Ljava/io/RandomAccessFile;
    .restart local p1    # "fileList":Ljava/util/ArrayList;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :goto_3
    new-instance v13, Lnet/lingala/zip4j/exception/ZipException;

    const-string v14, "NumberFormatException while parsing offset central directory. Cannot update already existing file header"

    invoke-direct {v13, v14}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v3    # "outputStream":Ljava/io/RandomAccessFile;
    .end local p1    # "fileList":Ljava/util/ArrayList;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v13
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_3
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .line 356
    .end local v0    # "e":Ljava/lang/NumberFormatException;
    .end local v6    # "file":Ljava/io/File;
    .end local v7    # "fileName":Ljava/lang/String;
    .end local v8    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local v9    # "archiveMaintainer":Lnet/lingala/zip4j/util/ArchiveMaintainer;
    .end local v10    # "retMap":Ljava/util/HashMap;
    .end local v11    # "offsetCentralDir":J
    .restart local v3    # "outputStream":Ljava/io/RandomAccessFile;
    .restart local p1    # "fileList":Ljava/util/ArrayList;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :cond_4
    :goto_4
    add-int/lit8 v4, v4, 0x1

    goto/16 :goto_0

    .line 412
    .end local v4    # "i":I
    :catch_3
    move-exception v0

    goto :goto_8

    .line 356
    .restart local v4    # "i":I
    :cond_5
    move-object/from16 v5, p1

    .line 415
    .end local v4    # "i":I
    if-eqz v3, :cond_6

    .line 417
    :try_start_6
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    .line 420
    :goto_5
    goto :goto_6

    .line 418
    :catch_4
    move-exception v0

    goto :goto_5

    .line 423
    :cond_6
    :goto_6
    return-void

    .line 415
    :catchall_0
    move-exception v0

    move-object/from16 v5, p1

    :goto_7
    move-object v4, v0

    goto :goto_9

    .line 412
    :catch_5
    move-exception v0

    move-object/from16 v5, p1

    .line 413
    .local v0, "e":Ljava/io/IOException;
    :goto_8
    :try_start_7
    new-instance v4, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v4, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v3    # "outputStream":Ljava/io/RandomAccessFile;
    .end local p1    # "fileList":Ljava/util/ArrayList;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .end local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v4
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    .line 415
    .end local v0    # "e":Ljava/io/IOException;
    .restart local v3    # "outputStream":Ljava/io/RandomAccessFile;
    .restart local p1    # "fileList":Ljava/util/ArrayList;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    .restart local p3    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catchall_1
    move-exception v0

    goto :goto_7

    :goto_9
    if-eqz v3, :cond_7

    .line 417
    :try_start_8
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_6

    .line 420
    goto :goto_a

    .line 418
    :catch_6
    move-exception v0

    .line 420
    :cond_7
    :goto_a
    throw v4

    .line 347
    .end local v3    # "outputStream":Ljava/io/RandomAccessFile;
    :cond_8
    move-object/from16 v5, p1

    .line 351
    :goto_b
    return-void
.end method


# virtual methods
.method public addFiles(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;Z)V
    .locals 7
    .param p1, "fileList"    # Ljava/util/ArrayList;
    .param p2, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .param p4, "runInThread"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 58
    if-eqz p1, :cond_2

    if-eqz p2, :cond_2

    .line 62
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-lez v0, :cond_1

    .line 66
    const/4 v0, 0x0

    invoke-virtual {p3, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setCurrentOperation(I)V

    .line 67
    const/4 v1, 0x1

    invoke-virtual {p3, v1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V

    .line 68
    invoke-virtual {p3, v1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 70
    if-eqz p4, :cond_0

    .line 71
    invoke-direct {p0, p1, p2}, Lnet/lingala/zip4j/zip/ZipEngine;->calculateTotalWork(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;)J

    move-result-wide v1

    invoke-virtual {p3, v1, v2}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setTotalWork(J)V

    .line 72
    invoke-virtual {p1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p3, v0}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setFileName(Ljava/lang/String;)V

    .line 74
    new-instance v0, Lnet/lingala/zip4j/zip/ZipEngine$1;

    const-string v3, "Zip4j"

    move-object v1, v0

    move-object v2, p0

    move-object v4, p1

    move-object v5, p2

    move-object v6, p3

    invoke-direct/range {v1 .. v6}, Lnet/lingala/zip4j/zip/ZipEngine$1;-><init>(Lnet/lingala/zip4j/zip/ZipEngine;Ljava/lang/String;Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 82
    .local v0, "thread":Ljava/lang/Thread;
    invoke-virtual {v0}, Ljava/lang/Thread;->start()V

    .line 84
    .end local v0    # "thread":Ljava/lang/Thread;
    goto :goto_0

    .line 85
    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lnet/lingala/zip4j/zip/ZipEngine;->initAddFiles(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;)V

    .line 87
    :goto_0
    return-void

    .line 63
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "no files to add"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 59
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null when adding files"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public addFolderToZip(Ljava/io/File;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;Z)V
    .locals 3
    .param p1, "file"    # Ljava/io/File;
    .param p2, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .param p3, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .param p4, "runInThread"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 259
    if-eqz p1, :cond_9

    if-eqz p2, :cond_9

    .line 263
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 267
    invoke-virtual {p1}, Ljava/io/File;->isDirectory()Z

    move-result v0

    if-eqz v0, :cond_7

    .line 271
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileReadAccess(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    .line 275
    const/4 v0, 0x0

    .line 276
    .local v0, "rootFolderPath":Ljava/lang/String;
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->isIncludeRootFolder()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 277
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    const-string v2, ""

    if-eqz v1, :cond_1

    .line 278
    invoke-virtual {p1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_0

    invoke-virtual {p1}, Ljava/io/File;->getAbsoluteFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    :cond_0
    move-object v0, v2

    goto :goto_0

    .line 280
    :cond_1
    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    if-eqz v1, :cond_2

    invoke-virtual {p1}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    :cond_2
    move-object v0, v2

    goto :goto_0

    .line 283
    :cond_3
    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    .line 286
    :goto_0
    invoke-virtual {p2, v0}, Lnet/lingala/zip4j/model/ZipParameters;->setDefaultFolderPath(Ljava/lang/String;)V

    .line 288
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->isReadHiddenFiles()Z

    move-result v1

    invoke-static {p1, v1}, Lnet/lingala/zip4j/util/Zip4jUtil;->getFilesInDirectoryRec(Ljava/io/File;Z)Ljava/util/ArrayList;

    move-result-object v1

    .line 290
    .local v1, "fileList":Ljava/util/ArrayList;
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->isIncludeRootFolder()Z

    move-result v2

    if-eqz v2, :cond_5

    .line 291
    if-nez v1, :cond_4

    .line 292
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move-object v1, v2

    .line 294
    :cond_4
    invoke-virtual {v1, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 297
    :cond_5
    invoke-virtual {p0, v1, p2, p3, p4}, Lnet/lingala/zip4j/zip/ZipEngine;->addFiles(Ljava/util/ArrayList;Lnet/lingala/zip4j/model/ZipParameters;Lnet/lingala/zip4j/progress/ProgressMonitor;Z)V

    .line 298
    return-void

    .line 272
    .end local v0    # "rootFolderPath":Ljava/lang/String;
    .end local v1    # "fileList":Ljava/util/ArrayList;
    :cond_6
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "cannot read folder: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 268
    :cond_7
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file is not a folder, user addFileToZip method to add files"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 264
    :cond_8
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input folder does not exist"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 260
    :cond_9
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null, cannot add folder to zip"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public addStreamToZip(Ljava/io/InputStream;Lnet/lingala/zip4j/model/ZipParameters;)V
    .locals 7
    .param p1, "inputStream"    # Ljava/io/InputStream;
    .param p2, "parameters"    # Lnet/lingala/zip4j/model/ZipParameters;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 206
    if-eqz p1, :cond_4

    if-eqz p2, :cond_4

    .line 210
    const/4 v0, 0x0

    .line 213
    .local v0, "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    :try_start_0
    invoke-direct {p0, p2}, Lnet/lingala/zip4j/zip/ZipEngine;->checkParameters(Lnet/lingala/zip4j/model/ZipParameters;)V

    .line 215
    iget-object v1, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileExists(Ljava/lang/String;)Z

    move-result v1

    .line 217
    .local v1, "isZipFileAlreadExists":Z
    new-instance v2, Lnet/lingala/zip4j/io/SplitOutputStream;

    new-instance v3, Ljava/io/File;

    iget-object v4, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v4}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    iget-object v4, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v4}, Lnet/lingala/zip4j/model/ZipModel;->getSplitLength()J

    move-result-wide v4

    invoke-direct {v2, v3, v4, v5}, Lnet/lingala/zip4j/io/SplitOutputStream;-><init>(Ljava/io/File;J)V

    .line 218
    .local v2, "splitOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    new-instance v3, Lnet/lingala/zip4j/io/ZipOutputStream;

    iget-object v4, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-direct {v3, v2, v4}, Lnet/lingala/zip4j/io/ZipOutputStream;-><init>(Ljava/io/OutputStream;Lnet/lingala/zip4j/model/ZipModel;)V

    move-object v0, v3

    .line 220
    if-eqz v1, :cond_1

    .line 221
    iget-object v3, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 224
    iget-object v3, p0, Lnet/lingala/zip4j/zip/ZipEngine;->zipModel:Lnet/lingala/zip4j/model/ZipModel;

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v3

    invoke-virtual {v3}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v3

    invoke-virtual {v2, v3, v4}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V

    goto :goto_0

    .line 222
    :cond_0
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    const-string v4, "invalid end of central directory record"

    invoke-direct {v3, v4}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local p1    # "inputStream":Ljava/io/InputStream;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    throw v3

    .line 227
    .restart local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .restart local p1    # "inputStream":Ljava/io/InputStream;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    :cond_1
    :goto_0
    const/16 v3, 0x1000

    new-array v3, v3, [B

    .line 228
    .local v3, "readBuff":[B
    const/4 v4, -0x1

    .line 230
    .local v4, "readLen":I
    const/4 v5, 0x0

    invoke-virtual {v0, v5, p2}, Lnet/lingala/zip4j/io/ZipOutputStream;->putNextEntry(Ljava/io/File;Lnet/lingala/zip4j/model/ZipParameters;)V

    .line 232
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->getFileNameInZip()Ljava/lang/String;

    move-result-object v5

    const-string v6, "/"

    invoke-virtual {v5, v6}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    invoke-virtual {p2}, Lnet/lingala/zip4j/model/ZipParameters;->getFileNameInZip()Ljava/lang/String;

    move-result-object v5

    const-string v6, "\\"

    invoke-virtual {v5, v6}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_2

    .line 234
    :goto_1
    invoke-virtual {p1, v3}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v4, v5

    const/4 v6, -0x1

    if-eq v5, v6, :cond_2

    .line 235
    const/4 v5, 0x0

    invoke-virtual {v0, v3, v5, v4}, Lnet/lingala/zip4j/io/ZipOutputStream;->write([BII)V

    goto :goto_1

    .line 239
    :cond_2
    invoke-virtual {v0}, Lnet/lingala/zip4j/io/ZipOutputStream;->closeEntry()V

    .line 240
    invoke-virtual {v0}, Lnet/lingala/zip4j/io/ZipOutputStream;->finish()V
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 247
    .end local v1    # "isZipFileAlreadExists":Z
    .end local v2    # "splitOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local v3    # "readBuff":[B
    .end local v4    # "readLen":I
    nop

    .line 249
    :try_start_1
    invoke-virtual {v0}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 252
    :goto_2
    goto :goto_3

    .line 250
    :catch_0
    move-exception v1

    goto :goto_2

    .line 255
    :goto_3
    return-void

    .line 247
    :catchall_0
    move-exception v1

    goto :goto_4

    .line 244
    :catch_1
    move-exception v1

    .line 245
    .local v1, "e":Ljava/lang/Exception;
    :try_start_2
    new-instance v2, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v2, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local p1    # "inputStream":Ljava/io/InputStream;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    throw v2

    .line 242
    .end local v1    # "e":Ljava/lang/Exception;
    .restart local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .restart local p1    # "inputStream":Ljava/io/InputStream;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    :catch_2
    move-exception v1

    .line 243
    .local v1, "e":Lnet/lingala/zip4j/exception/ZipException;
    nop

    .end local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .end local p1    # "inputStream":Ljava/io/InputStream;
    .end local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    throw v1
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 247
    .end local v1    # "e":Lnet/lingala/zip4j/exception/ZipException;
    .restart local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    .restart local p1    # "inputStream":Ljava/io/InputStream;
    .restart local p2    # "parameters":Lnet/lingala/zip4j/model/ZipParameters;
    :goto_4
    if-eqz v0, :cond_3

    .line 249
    :try_start_3
    invoke-virtual {v0}, Lnet/lingala/zip4j/io/ZipOutputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .line 252
    goto :goto_5

    .line 250
    :catch_3
    move-exception v2

    .line 252
    :cond_3
    :goto_5
    throw v1

    .line 207
    .end local v0    # "outputStream":Lnet/lingala/zip4j/io/ZipOutputStream;
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null, cannot add stream to zip"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_7

    :goto_6
    throw v0

    :goto_7
    goto :goto_6
.end method
