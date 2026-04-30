.class public Lnet/lingala/zip4j/core/HeaderWriter;
.super Ljava/lang/Object;
.source "HeaderWriter.java"


# instance fields
.field private final ZIP64_EXTRA_BUF:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 37
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    const/16 v0, 0x32

    iput v0, p0, Lnet/lingala/zip4j/core/HeaderWriter;->ZIP64_EXTRA_BUF:I

    return-void
.end method

.method private byteArrayListToByteArray(Ljava/util/List;)[B
    .locals 3
    .param p1, "arrayList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 910
    if-eqz p1, :cond_2

    .line 914
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    if-gtz v0, :cond_0

    .line 915
    const/4 v0, 0x0

    return-object v0

    .line 918
    :cond_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v0

    new-array v0, v0, [B

    .line 920
    .local v0, "retBytes":[B
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-interface {p1}, Ljava/util/List;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 921
    invoke-interface {p1, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/Byte;->parseByte(Ljava/lang/String;)B

    move-result v2

    aput-byte v2, v0, v1

    .line 920
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 924
    .end local v1    # "i":I
    :cond_1
    return-object v0

    .line 911
    .end local v0    # "retBytes":[B
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input byte array list is null, cannot conver to byte array"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method private copyByteArrayToArrayList([BLjava/util/List;)V
    .locals 2
    .param p1, "byteArray"    # [B
    .param p2, "arrayList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 900
    if-eqz p2, :cond_1

    if-eqz p1, :cond_1

    .line 904
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_0

    .line 905
    aget-byte v1, p1, v0

    invoke-static {v1}, Ljava/lang/Byte;->toString(B)Ljava/lang/String;

    move-result-object v1

    invoke-interface {p2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 904
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 907
    .end local v0    # "i":I
    :cond_0
    return-void

    .line 901
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "one of the input parameters is null, cannot copy byte array to array list"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method private countNumberOfFileHeaderEntriesOnDisk(Ljava/util/ArrayList;I)I
    .locals 4
    .param p1, "fileHeaders"    # Ljava/util/ArrayList;
    .param p2, "numOfDisk"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 929
    if-eqz p1, :cond_2

    .line 933
    const/4 v0, 0x0

    .line 934
    .local v0, "noEntries":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 935
    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lnet/lingala/zip4j/model/FileHeader;

    .line 936
    .local v2, "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    invoke-virtual {v2}, Lnet/lingala/zip4j/model/FileHeader;->getDiskNumberStart()I

    move-result v3

    if-ne v3, p2, :cond_0

    .line 937
    add-int/lit8 v0, v0, 0x1

    .line 934
    .end local v2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 940
    .end local v1    # "i":I
    :cond_1
    return v0

    .line 930
    .end local v0    # "noEntries":I
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "file headers are null, cannot calculate number of entries on this disk"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw v0

    :goto_2
    goto :goto_1
.end method

.method private processHeaderData(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V
    .locals 4
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 340
    const/4 v0, 0x0

    .line 341
    .local v0, "currSplitFileCounter":I
    :try_start_0
    instance-of v1, p2, Lnet/lingala/zip4j/io/SplitOutputStream;

    if-eqz v1, :cond_0

    .line 342
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    move-object v2, p2

    check-cast v2, Lnet/lingala/zip4j/io/SplitOutputStream;

    invoke-virtual {v2}, Lnet/lingala/zip4j/io/SplitOutputStream;->getFilePointer()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setOffsetOfStartOfCentralDir(J)V

    .line 344
    move-object v1, p2

    check-cast v1, Lnet/lingala/zip4j/io/SplitOutputStream;

    invoke-virtual {v1}, Lnet/lingala/zip4j/io/SplitOutputStream;->getCurrSplitFileCounter()I

    move-result v1

    move v0, v1

    .line 348
    :cond_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 349
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v1

    if-nez v1, :cond_1

    .line 350
    new-instance v1, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    invoke-direct {v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;-><init>()V

    invoke-virtual {p1, v1}, Lnet/lingala/zip4j/model/ZipModel;->setZip64EndCentralDirRecord(Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;)V

    .line 352
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v1

    if-nez v1, :cond_2

    .line 353
    new-instance v1, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    invoke-direct {v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;-><init>()V

    invoke-virtual {p1, v1}, Lnet/lingala/zip4j/model/ZipModel;->setZip64EndCentralDirLocator(Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;)V

    .line 356
    :cond_2
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v1

    invoke-virtual {v1, v0}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setNoOfDiskStartOfZip64EndOfCentralDirRec(I)V

    .line 357
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v1

    add-int/lit8 v2, v0, 0x1

    invoke-virtual {v1, v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setTotNumberOfDiscs(I)V

    .line 359
    :cond_3
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual {v1, v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setNoOfThisDisk(I)V

    .line 360
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual {v1, v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->setNoOfThisDiskStartOfCentralDir(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 363
    .end local v0    # "currSplitFileCounter":I
    nop

    .line 364
    return-void

    .line 361
    :catch_0
    move-exception v0

    .line 362
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1
.end method

.method private updateCompressedSizeInLocalFileHeader(Lnet/lingala/zip4j/io/SplitOutputStream;Lnet/lingala/zip4j/model/LocalFileHeader;JJ[BZ)V
    .locals 7
    .param p1, "outputStream"    # Lnet/lingala/zip4j/io/SplitOutputStream;
    .param p2, "localFileHeader"    # Lnet/lingala/zip4j/model/LocalFileHeader;
    .param p3, "offset"    # J
    .param p5, "toUpdate"    # J
    .param p7, "bytesToWrite"    # [B
    .param p8, "isZip64Format"    # Z
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 863
    if-eqz p1, :cond_3

    .line 868
    :try_start_0
    invoke-virtual {p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->isWriteComprSizeInZip64ExtraRecord()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 869
    array-length v0, p7

    const/16 v1, 0x8

    if-ne v0, v1, :cond_1

    .line 883
    add-long v0, p3, p5

    const-wide/16 v2, 0x4

    add-long/2addr v0, v2

    add-long/2addr v0, v2

    const-wide/16 v2, 0x2

    add-long/2addr v0, v2

    add-long/2addr v0, v2

    invoke-virtual {p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getFileNameLength()I

    move-result v4

    int-to-long v4, v4

    add-long/2addr v0, v4

    add-long/2addr v0, v2

    add-long/2addr v0, v2

    const-wide/16 v2, 0x8

    add-long/2addr v0, v2

    .line 884
    .local v0, "zip64CompressedSizeOffset":J
    const-wide/16 v4, 0x16

    cmp-long v6, p5, v4

    if-nez v6, :cond_0

    .line 885
    add-long/2addr v0, v2

    .line 887
    :cond_0
    invoke-virtual {p1, v0, v1}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V

    .line 888
    invoke-virtual {p1, p7}, Lnet/lingala/zip4j/io/SplitOutputStream;->write([B)V

    .line 889
    .end local v0    # "zip64CompressedSizeOffset":J
    goto :goto_0

    .line 870
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "attempting to write a non 8-byte compressed size block for a zip64 file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local p2    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .end local p3    # "offset":J
    .end local p5    # "toUpdate":J
    .end local p7    # "bytesToWrite":[B
    .end local p8    # "isZip64Format":Z
    throw v0

    .line 890
    .restart local p1    # "outputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .restart local p2    # "localFileHeader":Lnet/lingala/zip4j/model/LocalFileHeader;
    .restart local p3    # "offset":J
    .restart local p5    # "toUpdate":J
    .restart local p7    # "bytesToWrite":[B
    .restart local p8    # "isZip64Format":Z
    :cond_2
    add-long v0, p3, p5

    invoke-virtual {p1, v0, v1}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V

    .line 891
    invoke-virtual {p1, p7}, Lnet/lingala/zip4j/io/SplitOutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 895
    :goto_0
    nop

    .line 897
    return-void

    .line 893
    :catch_0
    move-exception v0

    .line 894
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 864
    .end local v0    # "e":Ljava/io/IOException;
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "invalid output stream, cannot update compressed size for local file header"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private writeCentralDirectory(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;Ljava/util/List;)I
    .locals 4
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "headerBytesList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 376
    if-eqz p1, :cond_3

    if-eqz p2, :cond_3

    .line 380
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v0

    if-gtz v0, :cond_0

    goto :goto_1

    .line 386
    :cond_0
    const/4 v0, 0x0

    .line 387
    .local v0, "sizeOfCentralDir":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    if-ge v1, v2, :cond_1

    .line 388
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lnet/lingala/zip4j/model/FileHeader;

    .line 389
    .local v2, "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    invoke-direct {p0, p1, v2, p2, p3}, Lnet/lingala/zip4j/core/HeaderWriter;->writeFileHeader(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Ljava/io/OutputStream;Ljava/util/List;)I

    move-result v3

    .line 390
    .local v3, "sizeOfFileHeader":I
    add-int/2addr v0, v3

    .line 387
    .end local v2    # "fileHeader":Lnet/lingala/zip4j/model/FileHeader;
    .end local v3    # "sizeOfFileHeader":I
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 392
    .end local v1    # "i":I
    :cond_1
    return v0

    .line 383
    .end local v0    # "sizeOfCentralDir":I
    :cond_2
    :goto_1
    const/4 v0, 0x0

    return v0

    .line 377
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input parameters is null, cannot write central directory"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method private writeEndOfCentralDirectoryRecord(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;IJLjava/util/List;)V
    .locals 15
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "sizeOfCentralDir"    # I
    .param p4, "offsetCentralDir"    # J
    .param p6, "headrBytesList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 729
    move-object v1, p0

    move-wide/from16 v2, p4

    move-object/from16 v4, p6

    if-eqz p1, :cond_5

    if-eqz p2, :cond_5

    .line 735
    const/4 v0, 0x2

    :try_start_0
    new-array v0, v0, [B

    .line 736
    .local v0, "shortByte":[B
    const/4 v5, 0x4

    new-array v6, v5, [B

    .line 737
    .local v6, "intByte":[B
    const/16 v7, 0x8

    new-array v7, v7, [B

    .line 740
    .local v7, "longByte":[B
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v8

    invoke-virtual {v8}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getSignature()J

    move-result-wide v8

    long-to-int v9, v8

    const/4 v8, 0x0

    invoke-static {v6, v8, v9}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 741
    invoke-direct {p0, v6, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 744
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v9

    invoke-virtual {v9}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v9

    int-to-short v9, v9

    invoke-static {v0, v8, v9}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 745
    invoke-direct {p0, v0, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 748
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v9

    invoke-virtual {v9}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDiskStartOfCentralDir()I

    move-result v9

    int-to-short v9, v9

    invoke-static {v0, v8, v9}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 749
    invoke-direct {p0, v0, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 752
    const/4 v9, 0x0

    .line 753
    .local v9, "numEntries":I
    const/4 v10, 0x0

    .line 754
    .local v10, "numEntriesOnThisDisk":I
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v11

    if-eqz v11, :cond_4

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v11

    invoke-virtual {v11}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v11

    if-eqz v11, :cond_4

    .line 759
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v11

    invoke-virtual {v11}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v11

    invoke-virtual {v11}, Ljava/util/ArrayList;->size()I

    move-result v11

    move v9, v11

    .line 760
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->isSplitArchive()Z

    move-result v11

    if-eqz v11, :cond_0

    .line 761
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v11

    invoke-virtual {v11}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v11

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v12

    invoke-virtual {v12}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v12

    invoke-direct {p0, v11, v12}, Lnet/lingala/zip4j/core/HeaderWriter;->countNumberOfFileHeaderEntriesOnDisk(Ljava/util/ArrayList;I)I

    move-result v11

    move v10, v11

    goto :goto_0

    .line 764
    :cond_0
    move v10, v9

    .line 767
    :goto_0
    int-to-short v11, v10

    invoke-static {v0, v8, v11}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 768
    invoke-direct {p0, v0, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 771
    int-to-short v11, v9

    invoke-static {v0, v8, v11}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 772
    invoke-direct {p0, v0, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    .line 775
    move/from16 v11, p3

    :try_start_1
    invoke-static {v6, v8, v11}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 776
    invoke-direct {p0, v6, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 779
    const-wide v12, 0xffffffffL

    cmp-long v14, v2, v12

    if-lez v14, :cond_1

    .line 780
    invoke-static {v7, v8, v12, v13}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 781
    invoke-static {v7, v8, v6, v8, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 782
    invoke-direct {p0, v6, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    goto :goto_1

    .line 784
    :cond_1
    invoke-static {v7, v8, v2, v3}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 785
    invoke-static {v7, v8, v6, v8, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 787
    invoke-direct {p0, v6, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 791
    :goto_1
    const/4 v5, 0x0

    .line 792
    .local v5, "commentLength":I
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v12

    invoke-virtual {v12}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getComment()Ljava/lang/String;

    move-result-object v12

    if-eqz v12, :cond_2

    .line 793
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v12

    invoke-virtual {v12}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getCommentLength()I

    move-result v12

    move v5, v12

    .line 795
    :cond_2
    int-to-short v12, v5

    invoke-static {v0, v8, v12}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 796
    invoke-direct {p0, v0, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 799
    if-lez v5, :cond_3

    .line 800
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v8

    invoke-virtual {v8}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getCommentBytes()[B

    move-result-object v8

    invoke-direct {p0, v8, v4}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 805
    .end local v0    # "shortByte":[B
    .end local v5    # "commentLength":I
    .end local v6    # "intByte":[B
    .end local v7    # "longByte":[B
    .end local v9    # "numEntries":I
    .end local v10    # "numEntriesOnThisDisk":I
    :cond_3
    nop

    .line 806
    return-void

    .line 754
    .restart local v0    # "shortByte":[B
    .restart local v6    # "intByte":[B
    .restart local v7    # "longByte":[B
    .restart local v9    # "numEntries":I
    .restart local v10    # "numEntriesOnThisDisk":I
    :cond_4
    move/from16 v11, p3

    .line 756
    new-instance v5, Lnet/lingala/zip4j/exception/ZipException;

    const-string v8, "invalid central directory/file headers, cannot write end of central directory record"

    invoke-direct {v5, v8}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "outputStream":Ljava/io/OutputStream;
    .end local p3    # "sizeOfCentralDir":I
    .end local p4    # "offsetCentralDir":J
    .end local p6    # "headrBytesList":Ljava/util/List;
    throw v5
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 803
    .end local v0    # "shortByte":[B
    .end local v6    # "intByte":[B
    .end local v7    # "longByte":[B
    .end local v9    # "numEntries":I
    .end local v10    # "numEntriesOnThisDisk":I
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "outputStream":Ljava/io/OutputStream;
    .restart local p3    # "sizeOfCentralDir":I
    .restart local p4    # "offsetCentralDir":J
    .restart local p6    # "headrBytesList":Ljava/util/List;
    :catch_0
    move-exception v0

    goto :goto_2

    :catch_1
    move-exception v0

    move/from16 v11, p3

    .line 804
    .local v0, "e":Ljava/lang/Exception;
    :goto_2
    new-instance v5, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v5, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v5

    .line 729
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_5
    move/from16 v11, p3

    .line 730
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v5, "zip model or output stream is null, cannot write end of central directory record"

    invoke-direct {v0, v5}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private writeFileHeader(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/FileHeader;Ljava/io/OutputStream;Ljava/util/List;)I
    .locals 21
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "fileHeader"    # Lnet/lingala/zip4j/model/FileHeader;
    .param p3, "outputStream"    # Ljava/io/OutputStream;
    .param p4, "headerBytesList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 398
    move-object/from16 v1, p0

    move-object/from16 v2, p4

    if-eqz p2, :cond_10

    if-eqz p3, :cond_10

    .line 403
    const/4 v0, 0x0

    .line 405
    .local v0, "sizeOfFileHeader":I
    const/4 v3, 0x2

    :try_start_0
    new-array v4, v3, [B

    .line 406
    .local v4, "shortByte":[B
    const/4 v5, 0x4

    new-array v6, v5, [B

    .line 407
    .local v6, "intByte":[B
    const/16 v7, 0x8

    new-array v8, v7, [B

    .line 408
    .local v8, "longByte":[B
    new-array v9, v3, [B

    const/4 v10, 0x0

    aput-byte v10, v9, v10

    const/4 v11, 0x1

    aput-byte v10, v9, v11

    .line 409
    .local v9, "emptyShortByte":[B
    new-array v12, v5, [B

    aput-byte v10, v12, v10

    aput-byte v10, v12, v11

    aput-byte v10, v12, v3

    const/4 v13, 0x3

    aput-byte v10, v12, v13

    .line 411
    .local v12, "emptyIntByte":[B
    const/4 v13, 0x0

    .line 412
    .local v13, "writeZip64FileSize":Z
    const/4 v14, 0x0

    .line 414
    .local v14, "writeZip64OffsetLocalHeader":Z
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getSignature()I

    move-result v15

    invoke-static {v6, v10, v15}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 415
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 416
    add-int/2addr v0, v5

    .line 418
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getVersionMadeBy()I

    move-result v15

    int-to-short v15, v15

    invoke-static {v4, v10, v15}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 419
    invoke-direct {v1, v4, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 420
    add-int/2addr v0, v3

    .line 422
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getVersionNeededToExtract()I

    move-result v15

    int-to-short v15, v15

    invoke-static {v4, v10, v15}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 423
    invoke-direct {v1, v4, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 424
    add-int/2addr v0, v3

    .line 426
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getGeneralPurposeFlag()[B

    move-result-object v15

    invoke-direct {v1, v15, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 427
    add-int/2addr v0, v3

    .line 429
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getCompressionMethod()I

    move-result v15

    int-to-short v15, v15

    invoke-static {v4, v10, v15}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 430
    invoke-direct {v1, v4, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 431
    add-int/2addr v0, v3

    .line 433
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getLastModFileTime()I

    move-result v15

    .line 434
    .local v15, "dateTime":I
    invoke-static {v6, v10, v15}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 435
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 436
    add-int/2addr v0, v5

    .line 438
    move-object/from16 v16, v12

    .end local v12    # "emptyIntByte":[B
    .local v16, "emptyIntByte":[B
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getCrc32()J

    move-result-wide v11

    long-to-int v12, v11

    invoke-static {v6, v10, v12}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 439
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 440
    add-int/2addr v0, v5

    .line 442
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getCompressedSize()J

    move-result-wide v11

    move-object/from16 v18, v4

    .end local v4    # "shortByte":[B
    .local v18, "shortByte":[B
    const-wide v3, 0xffffffffL

    cmp-long v19, v11, v3

    if-gez v19, :cond_1

    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getUncompressedSize()J

    move-result-wide v11

    const-wide/16 v19, 0x32

    add-long v11, v11, v19

    cmp-long v19, v11, v3

    if-ltz v19, :cond_0

    goto :goto_0

    .line 455
    :cond_0
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getCompressedSize()J

    move-result-wide v11

    invoke-static {v8, v10, v11, v12}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 456
    invoke-static {v8, v10, v6, v10, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 458
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 459
    add-int/2addr v0, v5

    .line 461
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getUncompressedSize()J

    move-result-wide v11

    invoke-static {v8, v10, v11, v12}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 462
    invoke-static {v8, v10, v6, v10, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 464
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 465
    add-int/2addr v0, v5

    goto :goto_1

    .line 444
    :cond_1
    :goto_0
    invoke-static {v8, v10, v3, v4}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 445
    invoke-static {v8, v10, v6, v10, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 447
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 448
    add-int/2addr v0, v5

    .line 450
    invoke-direct {v1, v6, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 451
    add-int/2addr v0, v5

    .line 453
    const/4 v13, 0x1

    .line 468
    :goto_1
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getFileNameLength()I

    move-result v11

    int-to-short v11, v11

    move-object/from16 v12, v18

    .end local v18    # "shortByte":[B
    .local v12, "shortByte":[B
    invoke-static {v12, v10, v11}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 469
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 470
    const/4 v11, 0x2

    add-int/2addr v0, v11

    .line 474
    new-array v11, v5, [B

    .line 475
    .local v11, "offsetLocalHeaderBytes":[B
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v18

    cmp-long v20, v18, v3

    if-lez v20, :cond_2

    .line 476
    invoke-static {v8, v10, v3, v4}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 477
    invoke-static {v8, v10, v11, v10, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 478
    const/4 v14, 0x1

    goto :goto_2

    .line 480
    :cond_2
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v3

    invoke-static {v8, v10, v3, v4}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 481
    invoke-static {v8, v10, v11, v10, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 485
    :goto_2
    const/4 v3, 0x0

    .line 486
    .local v3, "extraFieldLength":I
    if-nez v13, :cond_3

    if-eqz v14, :cond_5

    .line 487
    :cond_3
    add-int/lit8 v3, v3, 0x4

    .line 488
    if-eqz v13, :cond_4

    .line 489
    add-int/lit8 v3, v3, 0x10

    .line 490
    :cond_4
    if-eqz v14, :cond_5

    .line 491
    add-int/lit8 v3, v3, 0x8

    .line 493
    :cond_5
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getAesExtraDataRecord()Lnet/lingala/zip4j/model/AESExtraDataRecord;

    move-result-object v4

    if-eqz v4, :cond_6

    .line 494
    add-int/lit8 v3, v3, 0xb

    .line 496
    :cond_6
    int-to-short v4, v3

    invoke-static {v12, v10, v4}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 497
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 498
    const/4 v4, 0x2

    add-int/2addr v0, v4

    .line 501
    invoke-direct {v1, v9, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 502
    add-int/2addr v0, v4

    .line 505
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getDiskNumberStart()I

    move-result v4

    int-to-short v4, v4

    invoke-static {v12, v10, v4}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 506
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 507
    const/4 v4, 0x2

    add-int/2addr v0, v4

    .line 510
    invoke-direct {v1, v9, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 511
    add-int/2addr v0, v4

    .line 514
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getExternalFileAttr()[B

    move-result-object v4

    if-eqz v4, :cond_7

    .line 515
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getExternalFileAttr()[B

    move-result-object v4

    invoke-direct {v1, v4, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    move-object/from16 v4, v16

    goto :goto_3

    .line 517
    :cond_7
    move-object/from16 v4, v16

    .end local v16    # "emptyIntByte":[B
    .local v4, "emptyIntByte":[B
    invoke-direct {v1, v4, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 519
    :goto_3
    add-int/2addr v0, v5

    .line 523
    invoke-direct {v1, v11, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 524
    add-int/2addr v0, v5

    .line 526
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getFileNameCharset()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_8

    .line 527
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getFileNameCharset()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v5, v7}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v5

    .line 528
    .local v5, "fileNameBytes":[B
    invoke-direct {v1, v5, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 529
    array-length v7, v5

    add-int/2addr v0, v7

    .line 530
    .end local v5    # "fileNameBytes":[B
    goto :goto_4

    .line 531
    :cond_8
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lnet/lingala/zip4j/util/Zip4jUtil;->convertCharset(Ljava/lang/String;)[B

    move-result-object v5

    invoke-direct {v1, v5, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 532
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getFileName()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lnet/lingala/zip4j/util/Zip4jUtil;->getEncodedStringLength(Ljava/lang/String;)I

    move-result v5
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_1

    add-int/2addr v0, v5

    .line 535
    :goto_4
    if-nez v13, :cond_a

    if-eqz v14, :cond_9

    goto :goto_5

    :cond_9
    move-object/from16 v5, p1

    move/from16 v18, v3

    move-object/from16 v17, v11

    goto :goto_7

    .line 536
    :cond_a
    :goto_5
    move-object/from16 v5, p1

    const/4 v7, 0x1

    :try_start_1
    invoke-virtual {v5, v7}, Lnet/lingala/zip4j/model/ZipModel;->setZip64Format(Z)V

    .line 539
    invoke-static {v12, v10, v7}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 540
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 541
    add-int/lit8 v0, v0, 0x2

    .line 544
    const/4 v7, 0x0

    .line 546
    .local v7, "dataSize":I
    if-eqz v13, :cond_b

    .line 547
    add-int/lit8 v7, v7, 0x10

    .line 549
    :cond_b
    if-eqz v14, :cond_c

    .line 550
    add-int/lit8 v7, v7, 0x8

    .line 553
    :cond_c
    move/from16 v18, v3

    .end local v3    # "extraFieldLength":I
    .local v18, "extraFieldLength":I
    int-to-short v3, v7

    invoke-static {v12, v10, v3}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 554
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 555
    const/4 v3, 0x2

    add-int/2addr v0, v3

    .line 557
    if-eqz v13, :cond_d

    .line 558
    move-object/from16 v17, v11

    .end local v11    # "offsetLocalHeaderBytes":[B
    .local v17, "offsetLocalHeaderBytes":[B
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getUncompressedSize()J

    move-result-wide v10

    const/4 v3, 0x0

    invoke-static {v8, v3, v10, v11}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 559
    invoke-direct {v1, v8, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 560
    add-int/lit8 v0, v0, 0x8

    .line 562
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getCompressedSize()J

    move-result-wide v10

    const/4 v3, 0x0

    invoke-static {v8, v3, v10, v11}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 563
    invoke-direct {v1, v8, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 564
    const/16 v10, 0x8

    add-int/2addr v0, v10

    goto :goto_6

    .line 557
    .end local v17    # "offsetLocalHeaderBytes":[B
    .restart local v11    # "offsetLocalHeaderBytes":[B
    :cond_d
    move-object/from16 v17, v11

    .line 567
    .end local v11    # "offsetLocalHeaderBytes":[B
    .restart local v17    # "offsetLocalHeaderBytes":[B
    :goto_6
    if-eqz v14, :cond_e

    .line 568
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getOffsetLocalHeader()J

    move-result-wide v10

    const/4 v3, 0x0

    invoke-static {v8, v3, v10, v11}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 569
    invoke-direct {v1, v8, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 570
    add-int/lit8 v0, v0, 0x8

    .line 574
    .end local v7    # "dataSize":I
    :cond_e
    :goto_7
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getAesExtraDataRecord()Lnet/lingala/zip4j/model/AESExtraDataRecord;

    move-result-object v7

    if-eqz v7, :cond_f

    .line 575
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/FileHeader;->getAesExtraDataRecord()Lnet/lingala/zip4j/model/AESExtraDataRecord;

    move-result-object v7

    .line 577
    .local v7, "aesExtraDataRecord":Lnet/lingala/zip4j/model/AESExtraDataRecord;
    invoke-virtual {v7}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getSignature()J

    move-result-wide v10

    long-to-int v11, v10

    int-to-short v10, v11

    const/4 v3, 0x0

    invoke-static {v12, v3, v10}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 578
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 580
    invoke-virtual {v7}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getDataSize()I

    move-result v10

    int-to-short v10, v10

    invoke-static {v12, v3, v10}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 581
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 583
    invoke-virtual {v7}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getVersionNumber()I

    move-result v10

    int-to-short v10, v10

    invoke-static {v12, v3, v10}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 584
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 586
    invoke-virtual {v7}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getVendorID()Ljava/lang/String;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/String;->getBytes()[B

    move-result-object v10

    invoke-direct {v1, v10, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 588
    const/4 v10, 0x1

    new-array v10, v10, [B

    .line 589
    .local v10, "aesStrengthBytes":[B
    invoke-virtual {v7}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getAesStrength()I

    move-result v11

    int-to-byte v11, v11

    const/4 v3, 0x0

    aput-byte v11, v10, v3

    .line 590
    invoke-direct {v1, v10, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 592
    invoke-virtual {v7}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getCompressionMethod()I

    move-result v11

    int-to-short v11, v11

    invoke-static {v12, v3, v11}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 593
    invoke-direct {v1, v12, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 595
    add-int/lit8 v0, v0, 0xb

    .line 600
    .end local v7    # "aesExtraDataRecord":Lnet/lingala/zip4j/model/AESExtraDataRecord;
    .end local v10    # "aesStrengthBytes":[B
    :cond_f
    return v0

    .line 601
    .end local v0    # "sizeOfFileHeader":I
    .end local v4    # "emptyIntByte":[B
    .end local v6    # "intByte":[B
    .end local v8    # "longByte":[B
    .end local v9    # "emptyShortByte":[B
    .end local v12    # "shortByte":[B
    .end local v13    # "writeZip64FileSize":Z
    .end local v14    # "writeZip64OffsetLocalHeader":Z
    .end local v15    # "dateTime":I
    .end local v17    # "offsetLocalHeaderBytes":[B
    .end local v18    # "extraFieldLength":I
    :catch_0
    move-exception v0

    goto :goto_8

    :catch_1
    move-exception v0

    move-object/from16 v5, p1

    .line 602
    .local v0, "e":Ljava/lang/Exception;
    :goto_8
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v3

    .line 398
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_10
    move-object/from16 v5, p1

    .line 399
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v3, "input parameters is null, cannot write local file header"

    invoke-direct {v0, v3}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private writeZip64EndOfCentralDirectoryLocator(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;Ljava/util/List;)V
    .locals 6
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "headerBytesList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 693
    if-eqz p1, :cond_0

    if-eqz p2, :cond_0

    .line 699
    const/4 v0, 0x4

    :try_start_0
    new-array v0, v0, [B

    .line 700
    .local v0, "intByte":[B
    const/16 v1, 0x8

    new-array v1, v1, [B

    .line 703
    .local v1, "longByte":[B
    const v2, 0x7064b50

    const/4 v3, 0x0

    invoke-static {v0, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 704
    invoke-direct {p0, v0, p3}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 707
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->getNoOfDiskStartOfZip64EndOfCentralDirRec()I

    move-result v2

    invoke-static {v0, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 708
    invoke-direct {p0, v0, p3}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 711
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->getOffsetZip64EndOfCentralDirRec()J

    move-result-wide v4

    invoke-static {v1, v3, v4, v5}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 712
    invoke-direct {p0, v1, p3}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 715
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    invoke-virtual {v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->getTotNumberOfDiscs()I

    move-result v2

    invoke-static {v0, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 716
    invoke-direct {p0, v0, p3}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 721
    .end local v0    # "intByte":[B
    .end local v1    # "longByte":[B
    nop

    .line 722
    return-void

    .line 719
    :catch_0
    move-exception v0

    .line 720
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 717
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 718
    .local v0, "zipException":Lnet/lingala/zip4j/exception/ZipException;
    throw v0

    .line 694
    .end local v0    # "zipException":Lnet/lingala/zip4j/exception/ZipException;
    :cond_0
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model or output stream is null, cannot write zip64 end of central directory locator"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private writeZip64EndOfCentralDirectoryRecord(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;IJLjava/util/List;)V
    .locals 9
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "sizeOfCentralDir"    # I
    .param p4, "offsetCentralDir"    # J
    .param p6, "headerBytesList"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 609
    if-eqz p1, :cond_3

    if-eqz p2, :cond_3

    .line 615
    const/4 v0, 0x2

    :try_start_0
    new-array v1, v0, [B

    .line 616
    .local v1, "shortByte":[B
    new-array v0, v0, [B

    const/4 v2, 0x0

    aput-byte v2, v0, v2

    const/4 v3, 0x1

    aput-byte v2, v0, v3

    .line 617
    .local v0, "emptyShortByte":[B
    const/4 v3, 0x4

    new-array v3, v3, [B

    .line 618
    .local v3, "intByte":[B
    const/16 v4, 0x8

    new-array v4, v4, [B

    .line 621
    .local v4, "longByte":[B
    const v5, 0x6064b50

    invoke-static {v3, v2, v5}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 622
    invoke-direct {p0, v3, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 625
    const-wide/16 v5, 0x2c

    invoke-static {v4, v2, v5, v6}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 626
    invoke-direct {p0, v4, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 630
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    if-eqz v5, :cond_0

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v5

    if-eqz v5, :cond_0

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v5

    if-lez v5, :cond_0

    .line 633
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/FileHeader;->getVersionMadeBy()I

    move-result v5

    int-to-short v5, v5

    invoke-static {v1, v2, v5}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 635
    invoke-direct {p0, v1, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 637
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lnet/lingala/zip4j/model/FileHeader;

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/FileHeader;->getVersionNeededToExtract()I

    move-result v5

    int-to-short v5, v5

    invoke-static {v1, v2, v5}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 639
    invoke-direct {p0, v1, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    goto :goto_0

    .line 641
    :cond_0
    invoke-direct {p0, v0, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 642
    invoke-direct {p0, v0, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 646
    :goto_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v5

    invoke-static {v3, v2, v5}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 647
    invoke-direct {p0, v3, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 650
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v5

    invoke-virtual {v5}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDiskStartOfCentralDir()I

    move-result v5

    invoke-static {v3, v2, v5}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 651
    invoke-direct {p0, v3, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 654
    const/4 v5, 0x0

    .line 655
    .local v5, "numEntries":I
    const/4 v6, 0x0

    .line 656
    .local v6, "numEntriesOnThisDisk":I
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v7

    if-eqz v7, :cond_2

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v7

    invoke-virtual {v7}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v7

    if-eqz v7, :cond_2

    .line 661
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v7

    invoke-virtual {v7}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v7

    invoke-virtual {v7}, Ljava/util/ArrayList;->size()I

    move-result v7

    move v5, v7

    .line 662
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isSplitArchive()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 663
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getCentralDirectory()Lnet/lingala/zip4j/model/CentralDirectory;

    move-result-object v7

    invoke-virtual {v7}, Lnet/lingala/zip4j/model/CentralDirectory;->getFileHeaders()Ljava/util/ArrayList;

    move-result-object v7

    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v8

    invoke-virtual {v8}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getNoOfThisDisk()I

    move-result v8

    invoke-direct {p0, v7, v8}, Lnet/lingala/zip4j/core/HeaderWriter;->countNumberOfFileHeaderEntriesOnDisk(Ljava/util/ArrayList;I)I

    goto :goto_1

    .line 666
    :cond_1
    move v6, v5

    .line 669
    :goto_1
    int-to-long v7, v6

    invoke-static {v4, v2, v7, v8}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 670
    invoke-direct {p0, v4, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 673
    int-to-long v7, v5

    invoke-static {v4, v2, v7, v8}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 674
    invoke-direct {p0, v4, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 677
    int-to-long v7, p3

    invoke-static {v4, v2, v7, v8}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 678
    invoke-direct {p0, v4, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 681
    invoke-static {v4, v2, p4, p5}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 682
    invoke-direct {p0, v4, p6}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 688
    .end local v0    # "emptyShortByte":[B
    .end local v1    # "shortByte":[B
    .end local v3    # "intByte":[B
    .end local v4    # "longByte":[B
    .end local v5    # "numEntries":I
    .end local v6    # "numEntriesOnThisDisk":I
    nop

    .line 689
    return-void

    .line 658
    .restart local v0    # "emptyShortByte":[B
    .restart local v1    # "shortByte":[B
    .restart local v3    # "intByte":[B
    .restart local v4    # "longByte":[B
    .restart local v5    # "numEntries":I
    .restart local v6    # "numEntriesOnThisDisk":I
    :cond_2
    new-instance v2, Lnet/lingala/zip4j/exception/ZipException;

    const-string v7, "invalid central directory/file headers, cannot write end of central directory record"

    invoke-direct {v2, v7}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    .end local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .end local p2    # "outputStream":Ljava/io/OutputStream;
    .end local p3    # "sizeOfCentralDir":I
    .end local p4    # "offsetCentralDir":J
    .end local p6    # "headerBytesList":Ljava/util/List;
    throw v2
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 686
    .end local v0    # "emptyShortByte":[B
    .end local v1    # "shortByte":[B
    .end local v3    # "intByte":[B
    .end local v4    # "longByte":[B
    .end local v5    # "numEntries":I
    .end local v6    # "numEntriesOnThisDisk":I
    .restart local p1    # "zipModel":Lnet/lingala/zip4j/model/ZipModel;
    .restart local p2    # "outputStream":Ljava/io/OutputStream;
    .restart local p3    # "sizeOfCentralDir":I
    .restart local p4    # "offsetCentralDir":J
    .restart local p6    # "headerBytesList":Ljava/util/List;
    :catch_0
    move-exception v0

    .line 687
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 684
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 685
    .local v0, "zipException":Lnet/lingala/zip4j/exception/ZipException;
    throw v0

    .line 610
    .end local v0    # "zipException":Lnet/lingala/zip4j/exception/ZipException;
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "zip model or output stream is null, cannot write zip64 end of central directory record"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private writeZipHeaderBytes(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;[B)V
    .locals 2
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .param p3, "buff"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 314
    if-eqz p3, :cond_1

    .line 319
    :try_start_0
    instance-of v0, p2, Lnet/lingala/zip4j/io/SplitOutputStream;

    if-eqz v0, :cond_0

    .line 320
    move-object v0, p2

    check-cast v0, Lnet/lingala/zip4j/io/SplitOutputStream;

    array-length v1, p3

    invoke-virtual {v0, v1}, Lnet/lingala/zip4j/io/SplitOutputStream;->checkBuffSizeAndStartNextSplitFile(I)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 321
    invoke-virtual {p0, p1, p2}, Lnet/lingala/zip4j/core/HeaderWriter;->finalizeZipFile(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V

    .line 322
    return-void

    .line 326
    :cond_0
    invoke-virtual {p2, p3}, Ljava/io/OutputStream;->write([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 329
    nop

    .line 330
    return-void

    .line 327
    :catch_0
    move-exception v0

    .line 328
    .local v0, "e":Ljava/io/IOException;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 315
    .end local v0    # "e":Ljava/io/IOException;
    :cond_1
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "invalid buff to write as zip headers"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public finalizeZipFile(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V
    .locals 11
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 216
    if-eqz p1, :cond_4

    if-eqz p2, :cond_4

    .line 221
    :try_start_0
    invoke-direct {p0, p1, p2}, Lnet/lingala/zip4j/core/HeaderWriter;->processHeaderData(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V

    .line 223
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v0

    invoke-virtual {v0}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v0

    .line 225
    .local v0, "offsetCentralDir":J
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    move-object v9, v2

    .line 227
    .local v9, "headerBytesList":Ljava/util/List;
    invoke-direct {p0, p1, p2, v9}, Lnet/lingala/zip4j/core/HeaderWriter;->writeCentralDirectory(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;Ljava/util/List;)I

    move-result v2

    move v10, v2

    .line 229
    .local v10, "sizeOfCentralDir":I
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 230
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v2

    if-nez v2, :cond_0

    .line 231
    new-instance v2, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    invoke-direct {v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;-><init>()V

    invoke-virtual {p1, v2}, Lnet/lingala/zip4j/model/ZipModel;->setZip64EndCentralDirRecord(Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;)V

    .line 233
    :cond_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    if-nez v2, :cond_1

    .line 234
    new-instance v2, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    invoke-direct {v2}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;-><init>()V

    invoke-virtual {p1, v2}, Lnet/lingala/zip4j/model/ZipModel;->setZip64EndCentralDirLocator(Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;)V

    .line 237
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    int-to-long v3, v10

    add-long/2addr v3, v0

    invoke-virtual {v2, v3, v4}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setOffsetZip64EndOfCentralDirRec(J)V

    .line 238
    instance-of v2, p2, Lnet/lingala/zip4j/io/SplitOutputStream;

    const/4 v3, 0x1

    if-eqz v2, :cond_2

    .line 239
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    move-object v4, p2

    check-cast v4, Lnet/lingala/zip4j/io/SplitOutputStream;

    invoke-virtual {v4}, Lnet/lingala/zip4j/io/SplitOutputStream;->getCurrSplitFileCounter()I

    move-result v4

    invoke-virtual {v2, v4}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setNoOfDiskStartOfZip64EndOfCentralDirRec(I)V

    .line 240
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    move-object v4, p2

    check-cast v4, Lnet/lingala/zip4j/io/SplitOutputStream;

    invoke-virtual {v4}, Lnet/lingala/zip4j/io/SplitOutputStream;->getCurrSplitFileCounter()I

    move-result v4

    add-int/2addr v4, v3

    invoke-virtual {v2, v4}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setTotNumberOfDiscs(I)V

    goto :goto_0

    .line 242
    :cond_2
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    const/4 v4, 0x0

    invoke-virtual {v2, v4}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setNoOfDiskStartOfZip64EndOfCentralDirRec(I)V

    .line 243
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v2

    invoke-virtual {v2, v3}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setTotNumberOfDiscs(I)V

    .line 246
    :goto_0
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, v10

    move-wide v6, v0

    move-object v8, v9

    invoke-direct/range {v2 .. v8}, Lnet/lingala/zip4j/core/HeaderWriter;->writeZip64EndOfCentralDirectoryRecord(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;IJLjava/util/List;)V

    .line 248
    invoke-direct {p0, p1, p2, v9}, Lnet/lingala/zip4j/core/HeaderWriter;->writeZip64EndOfCentralDirectoryLocator(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;Ljava/util/List;)V

    .line 251
    :cond_3
    move-object v2, p0

    move-object v3, p1

    move-object v4, p2

    move v5, v10

    move-wide v6, v0

    move-object v8, v9

    invoke-direct/range {v2 .. v8}, Lnet/lingala/zip4j/core/HeaderWriter;->writeEndOfCentralDirectoryRecord(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;IJLjava/util/List;)V

    .line 253
    invoke-direct {p0, v9}, Lnet/lingala/zip4j/core/HeaderWriter;->byteArrayListToByteArray(Ljava/util/List;)[B

    move-result-object v2

    invoke-direct {p0, p1, p2, v2}, Lnet/lingala/zip4j/core/HeaderWriter;->writeZipHeaderBytes(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;[B)V
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 258
    .end local v0    # "offsetCentralDir":J
    .end local v9    # "headerBytesList":Ljava/util/List;
    .end local v10    # "sizeOfCentralDir":I
    nop

    .line 259
    return-void

    .line 256
    :catch_0
    move-exception v0

    .line 257
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 254
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 255
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    throw v0

    .line 217
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    :cond_4
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input parameters is null, cannot finalize zip file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public finalizeZipFileWithoutValidations(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;)V
    .locals 11
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 271
    if-eqz p1, :cond_3

    if-eqz p2, :cond_3

    .line 277
    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 279
    .local v0, "headerBytesList":Ljava/util/List;
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getEndCentralDirRecord()Lnet/lingala/zip4j/model/EndCentralDirRecord;

    move-result-object v1

    invoke-virtual {v1}, Lnet/lingala/zip4j/model/EndCentralDirRecord;->getOffsetOfStartOfCentralDir()J

    move-result-wide v1

    move-wide v8, v1

    .line 281
    .local v8, "offsetCentralDir":J
    invoke-direct {p0, p1, p2, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->writeCentralDirectory(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;Ljava/util/List;)I

    move-result v1

    move v10, v1

    .line 283
    .local v10, "sizeOfCentralDir":I
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 284
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirRecord()Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    move-result-object v1

    if-nez v1, :cond_0

    .line 285
    new-instance v1, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;

    invoke-direct {v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;-><init>()V

    invoke-virtual {p1, v1}, Lnet/lingala/zip4j/model/ZipModel;->setZip64EndCentralDirRecord(Lnet/lingala/zip4j/model/Zip64EndCentralDirRecord;)V

    .line 287
    :cond_0
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v1

    if-nez v1, :cond_1

    .line 288
    new-instance v1, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    invoke-direct {v1}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;-><init>()V

    invoke-virtual {p1, v1}, Lnet/lingala/zip4j/model/ZipModel;->setZip64EndCentralDirLocator(Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;)V

    .line 291
    :cond_1
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/ZipModel;->getZip64EndCentralDirLocator()Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;

    move-result-object v1

    int-to-long v2, v10

    add-long/2addr v2, v8

    invoke-virtual {v1, v2, v3}, Lnet/lingala/zip4j/model/Zip64EndCentralDirLocator;->setOffsetZip64EndOfCentralDirRec(J)V

    .line 293
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, v10

    move-wide v5, v8

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lnet/lingala/zip4j/core/HeaderWriter;->writeZip64EndOfCentralDirectoryRecord(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;IJLjava/util/List;)V

    .line 294
    invoke-direct {p0, p1, p2, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->writeZip64EndOfCentralDirectoryLocator(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;Ljava/util/List;)V

    .line 297
    :cond_2
    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move v4, v10

    move-wide v5, v8

    move-object v7, v0

    invoke-direct/range {v1 .. v7}, Lnet/lingala/zip4j/core/HeaderWriter;->writeEndOfCentralDirectoryRecord(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;IJLjava/util/List;)V

    .line 299
    invoke-direct {p0, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->byteArrayListToByteArray(Ljava/util/List;)[B

    move-result-object v1

    invoke-direct {p0, p1, p2, v1}, Lnet/lingala/zip4j/core/HeaderWriter;->writeZipHeaderBytes(Lnet/lingala/zip4j/model/ZipModel;Ljava/io/OutputStream;[B)V
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 304
    .end local v0    # "headerBytesList":Ljava/util/List;
    .end local v8    # "offsetCentralDir":J
    .end local v10    # "sizeOfCentralDir":I
    nop

    .line 305
    return-void

    .line 302
    :catch_0
    move-exception v0

    .line 303
    .local v0, "e":Ljava/lang/Exception;
    new-instance v1, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v1, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v1

    .line 300
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v0

    .line 301
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    throw v0

    .line 272
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input parameters is null, cannot finalize zip file without validations"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public updateLocalFileHeader(Lnet/lingala/zip4j/model/LocalFileHeader;JILnet/lingala/zip4j/model/ZipModel;[BILnet/lingala/zip4j/io/SplitOutputStream;)V
    .locals 15
    .param p1, "localFileHeader"    # Lnet/lingala/zip4j/model/LocalFileHeader;
    .param p2, "offset"    # J
    .param p4, "toUpdate"    # I
    .param p5, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p6, "bytesToWrite"    # [B
    .param p7, "noOfDisk"    # I
    .param p8, "outputStream"    # Lnet/lingala/zip4j/io/SplitOutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 810
    move/from16 v10, p4

    move/from16 v11, p7

    if-eqz p1, :cond_5

    const-wide/16 v0, 0x0

    cmp-long v2, p2, v0

    if-ltz v2, :cond_5

    if-eqz p5, :cond_5

    .line 815
    const/4 v0, 0x0

    .line 816
    .local v0, "closeFlag":Z
    const/4 v1, 0x0

    .line 818
    .local v1, "currOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    :try_start_0
    invoke-virtual/range {p8 .. p8}, Lnet/lingala/zip4j/io/SplitOutputStream;->getCurrSplitFileCounter()I

    move-result v2

    if-eq v11, v2, :cond_1

    .line 819
    new-instance v2, Ljava/io/File;

    invoke-virtual/range {p5 .. p5}, Lnet/lingala/zip4j/model/ZipModel;->getZipFile()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 820
    .local v2, "zipFile":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->getParent()Ljava/lang/String;

    move-result-object v3

    .line 821
    .local v3, "parentFile":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lnet/lingala/zip4j/util/Zip4jUtil;->getZipFileNameWithoutExt(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 822
    .local v4, "fileNameWithoutExt":Ljava/lang/String;
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "file.separator"

    invoke-static {v6}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    .line 823
    .local v5, "fileName":Ljava/lang/String;
    const/16 v6, 0x9

    if-ge v11, v6, :cond_0

    .line 824
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, ".z0"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v7, v11, 0x1

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v5, v6

    goto :goto_0

    .line 826
    :cond_0
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v7, ".z"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    add-int/lit8 v7, v11, 0x1

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    move-object v5, v6

    .line 828
    :goto_0
    new-instance v6, Lnet/lingala/zip4j/io/SplitOutputStream;

    new-instance v7, Ljava/io/File;

    invoke-direct {v7, v5}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v6, v7}, Lnet/lingala/zip4j/io/SplitOutputStream;-><init>(Ljava/io/File;)V

    move-object v1, v6

    .line 829
    const/4 v0, 0x1

    .line 830
    .end local v2    # "zipFile":Ljava/io/File;
    .end local v3    # "parentFile":Ljava/lang/String;
    .end local v4    # "fileNameWithoutExt":Ljava/lang/String;
    .end local v5    # "fileName":Ljava/lang/String;
    move-object v12, v1

    goto :goto_1

    .line 831
    :cond_1
    move-object/from16 v1, p8

    move-object v12, v1

    .line 834
    .end local v1    # "currOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .local v12, "currOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    :goto_1
    invoke-virtual {v12}, Lnet/lingala/zip4j/io/SplitOutputStream;->getFilePointer()J

    move-result-wide v1

    move-wide v13, v1

    .line 836
    .local v13, "currOffset":J
    const/16 v1, 0xe

    if-eq v10, v1, :cond_3

    const/16 v1, 0x12

    if-eq v10, v1, :cond_2

    const/16 v1, 0x16

    if-eq v10, v1, :cond_2

    move-object/from16 v1, p6

    goto :goto_2

    .line 843
    :cond_2
    int-to-long v6, v10

    invoke-virtual/range {p5 .. p5}, Lnet/lingala/zip4j/model/ZipModel;->isZip64Format()Z

    move-result v9

    move-object v1, p0

    move-object v2, v12

    move-object/from16 v3, p1

    move-wide/from16 v4, p2

    move-object/from16 v8, p6

    invoke-direct/range {v1 .. v9}, Lnet/lingala/zip4j/core/HeaderWriter;->updateCompressedSizeInLocalFileHeader(Lnet/lingala/zip4j/io/SplitOutputStream;Lnet/lingala/zip4j/model/LocalFileHeader;JJ[BZ)V

    .line 845
    move-object/from16 v1, p6

    goto :goto_2

    .line 838
    :cond_3
    int-to-long v1, v10

    add-long v1, p2, v1

    invoke-virtual {v12, v1, v2}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2

    .line 839
    move-object/from16 v1, p6

    :try_start_1
    invoke-virtual {v12, v1}, Lnet/lingala/zip4j/io/SplitOutputStream;->write([B)V

    .line 840
    nop

    .line 849
    :goto_2
    if-eqz v0, :cond_4

    .line 850
    invoke-virtual {v12}, Lnet/lingala/zip4j/io/SplitOutputStream;->close()V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    move-object/from16 v2, p8

    goto :goto_3

    .line 855
    .end local v0    # "closeFlag":Z
    .end local v12    # "currOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local v13    # "currOffset":J
    :catch_0
    move-exception v0

    goto :goto_4

    .line 852
    .restart local v0    # "closeFlag":Z
    .restart local v12    # "currOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .restart local v13    # "currOffset":J
    :cond_4
    move-object/from16 v2, p8

    :try_start_2
    invoke-virtual {v2, v13, v14}, Lnet/lingala/zip4j/io/SplitOutputStream;->seek(J)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    .line 857
    .end local v0    # "closeFlag":Z
    .end local v12    # "currOutputStream":Lnet/lingala/zip4j/io/SplitOutputStream;
    .end local v13    # "currOffset":J
    :goto_3
    nop

    .line 858
    return-void

    .line 855
    :catch_1
    move-exception v0

    goto :goto_5

    :catch_2
    move-exception v0

    move-object/from16 v1, p6

    :goto_4
    move-object/from16 v2, p8

    .line 856
    .local v0, "e":Ljava/lang/Exception;
    :goto_5
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v3

    .line 810
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_5
    move-object/from16 v1, p6

    move-object/from16 v2, p8

    .line 811
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v3, "invalid input parameters, cannot update local file header"

    invoke-direct {v0, v3}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeExtendedLocalHeader(Lnet/lingala/zip4j/model/LocalFileHeader;Ljava/io/OutputStream;)I
    .locals 10
    .param p1, "localFileHeader"    # Lnet/lingala/zip4j/model/LocalFileHeader;
    .param p2, "outputStream"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;,
            Ljava/io/IOException;
        }
    .end annotation

    .line 172
    if-eqz p1, :cond_2

    if-eqz p2, :cond_2

    .line 176
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 177
    .local v0, "byteArrayList":Ljava/util/ArrayList;
    const/4 v1, 0x4

    new-array v1, v1, [B

    .line 180
    .local v1, "intByte":[B
    const v2, 0x8074b50

    const/4 v3, 0x0

    invoke-static {v1, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 181
    invoke-direct {p0, v1, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 184
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/LocalFileHeader;->getCrc32()J

    move-result-wide v4

    long-to-int v2, v4

    invoke-static {v1, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 185
    invoke-direct {p0, v1, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 188
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/LocalFileHeader;->getCompressedSize()J

    move-result-wide v4

    .line 189
    .local v4, "compressedSize":J
    const-wide/32 v6, 0x7fffffff

    cmp-long v2, v4, v6

    if-ltz v2, :cond_0

    .line 190
    const-wide/32 v4, 0x7fffffff

    .line 192
    :cond_0
    long-to-int v2, v4

    invoke-static {v1, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 193
    invoke-direct {p0, v1, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 196
    invoke-virtual {p1}, Lnet/lingala/zip4j/model/LocalFileHeader;->getUncompressedSize()J

    move-result-wide v8

    .line 197
    .local v8, "uncompressedSize":J
    cmp-long v2, v8, v6

    if-ltz v2, :cond_1

    .line 198
    const-wide/32 v8, 0x7fffffff

    .line 200
    :cond_1
    long-to-int v2, v8

    invoke-static {v1, v3, v2}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 201
    invoke-direct {p0, v1, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 203
    invoke-direct {p0, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->byteArrayListToByteArray(Ljava/util/List;)[B

    move-result-object v2

    .line 204
    .local v2, "extLocHdrBytes":[B
    invoke-virtual {p2, v2}, Ljava/io/OutputStream;->write([B)V

    .line 205
    array-length v3, v2

    return v3

    .line 173
    .end local v0    # "byteArrayList":Ljava/util/ArrayList;
    .end local v1    # "intByte":[B
    .end local v2    # "extLocHdrBytes":[B
    .end local v4    # "compressedSize":J
    .end local v8    # "uncompressedSize":J
    :cond_2
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input parameters is null, cannot write extended local header"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public writeLocalFileHeader(Lnet/lingala/zip4j/model/ZipModel;Lnet/lingala/zip4j/model/LocalFileHeader;Ljava/io/OutputStream;)I
    .locals 18
    .param p1, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;
    .param p2, "localFileHeader"    # Lnet/lingala/zip4j/model/LocalFileHeader;
    .param p3, "outputStream"    # Ljava/io/OutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 43
    move-object/from16 v1, p0

    move-object/from16 v2, p2

    if-eqz v2, :cond_6

    .line 48
    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 50
    .local v0, "byteArrayList":Ljava/util/ArrayList;
    const/4 v3, 0x2

    new-array v4, v3, [B

    .line 51
    .local v4, "shortByte":[B
    const/4 v5, 0x4

    new-array v6, v5, [B

    .line 52
    .local v6, "intByte":[B
    const/16 v7, 0x8

    new-array v8, v7, [B

    .line 53
    .local v8, "longByte":[B
    new-array v7, v7, [B

    const/4 v9, 0x0

    aput-byte v9, v7, v9

    const/4 v10, 0x1

    aput-byte v9, v7, v10

    aput-byte v9, v7, v3

    const/4 v3, 0x3

    aput-byte v9, v7, v3

    aput-byte v9, v7, v5

    const/4 v3, 0x5

    aput-byte v9, v7, v3

    const/4 v3, 0x6

    aput-byte v9, v7, v3

    const/4 v3, 0x7

    aput-byte v9, v7, v3

    move-object v3, v7

    .line 55
    .local v3, "emptyLongByte":[B
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getSignature()I

    move-result v7

    invoke-static {v6, v9, v7}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 56
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 57
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getVersionNeededToExtract()I

    move-result v7

    int-to-short v7, v7

    invoke-static {v4, v9, v7}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 58
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 60
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getGeneralPurposeFlag()[B

    move-result-object v7

    invoke-direct {v1, v7, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 62
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getCompressionMethod()I

    move-result v7

    int-to-short v7, v7

    invoke-static {v4, v9, v7}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 63
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 65
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getLastModFileTime()I

    move-result v7

    .line 66
    .local v7, "dateTime":I
    invoke-static {v6, v9, v7}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 67
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 69
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getCrc32()J

    move-result-wide v11

    long-to-int v12, v11

    invoke-static {v6, v9, v12}, Lnet/lingala/zip4j/util/Raw;->writeIntLittleEndian([BII)V

    .line 70
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 71
    const/4 v11, 0x0

    .line 74
    .local v11, "writingZip64Rec":Z
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getUncompressedSize()J

    move-result-wide v12
    :try_end_0
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4

    .line 75
    .local v12, "uncompressedSize":J
    const-wide/16 v14, 0x32

    add-long/2addr v14, v12

    move/from16 v16, v11

    .end local v11    # "writingZip64Rec":Z
    .local v16, "writingZip64Rec":Z
    const-wide v10, 0xffffffffL

    cmp-long v17, v14, v10

    if-ltz v17, :cond_0

    .line 76
    :try_start_1
    invoke-static {v8, v9, v10, v11}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 77
    invoke-static {v8, v9, v6, v9, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 81
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 83
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V
    :try_end_1
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_1 .. :try_end_1} :catch_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    .line 84
    move-object/from16 v10, p1

    const/4 v5, 0x1

    :try_start_2
    invoke-virtual {v10, v5}, Lnet/lingala/zip4j/model/ZipModel;->setZip64Format(Z)V

    .line 85
    const/4 v11, 0x1

    .line 86
    .end local v16    # "writingZip64Rec":Z
    .restart local v11    # "writingZip64Rec":Z
    invoke-virtual {v2, v5}, Lnet/lingala/zip4j/model/LocalFileHeader;->setWriteComprSizeInZip64ExtraRecord(Z)V

    goto :goto_0

    .line 165
    .end local v0    # "byteArrayList":Ljava/util/ArrayList;
    .end local v3    # "emptyLongByte":[B
    .end local v4    # "shortByte":[B
    .end local v6    # "intByte":[B
    .end local v7    # "dateTime":I
    .end local v8    # "longByte":[B
    .end local v11    # "writingZip64Rec":Z
    .end local v12    # "uncompressedSize":J
    :catch_0
    move-exception v0

    move-object/from16 v10, p1

    goto/16 :goto_2

    .line 163
    :catch_1
    move-exception v0

    move-object/from16 v10, p1

    goto/16 :goto_4

    .line 88
    .restart local v0    # "byteArrayList":Ljava/util/ArrayList;
    .restart local v3    # "emptyLongByte":[B
    .restart local v4    # "shortByte":[B
    .restart local v6    # "intByte":[B
    .restart local v7    # "dateTime":I
    .restart local v8    # "longByte":[B
    .restart local v12    # "uncompressedSize":J
    .restart local v16    # "writingZip64Rec":Z
    :cond_0
    move-object/from16 v10, p1

    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getCompressedSize()J

    move-result-wide v14

    invoke-static {v8, v9, v14, v15}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 89
    invoke-static {v8, v9, v6, v9, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 90
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 92
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getUncompressedSize()J

    move-result-wide v14

    invoke-static {v8, v9, v14, v15}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 93
    invoke-static {v8, v9, v6, v9, v5}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 95
    invoke-direct {v1, v6, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 97
    invoke-virtual {v2, v9}, Lnet/lingala/zip4j/model/LocalFileHeader;->setWriteComprSizeInZip64ExtraRecord(Z)V

    move/from16 v11, v16

    .line 99
    .end local v16    # "writingZip64Rec":Z
    .restart local v11    # "writingZip64Rec":Z
    :goto_0
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getFileNameLength()I

    move-result v5

    int-to-short v5, v5

    invoke-static {v4, v9, v5}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 100
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 102
    const/4 v5, 0x0

    .line 103
    .local v5, "extraFieldLength":I
    if-eqz v11, :cond_1

    .line 104
    add-int/lit8 v5, v5, 0x14

    .line 106
    :cond_1
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getAesExtraDataRecord()Lnet/lingala/zip4j/model/AESExtraDataRecord;

    move-result-object v14

    if-eqz v14, :cond_2

    .line 107
    add-int/lit8 v5, v5, 0xb

    .line 109
    :cond_2
    int-to-short v14, v5

    invoke-static {v4, v9, v14}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 110
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 111
    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getFileNameCharset()Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v14

    if-eqz v14, :cond_3

    .line 112
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getFileName()Ljava/lang/String;

    move-result-object v14

    invoke-virtual/range {p1 .. p1}, Lnet/lingala/zip4j/model/ZipModel;->getFileNameCharset()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v14

    .line 113
    .local v14, "fileNameBytes":[B
    invoke-direct {v1, v14, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 114
    .end local v14    # "fileNameBytes":[B
    goto :goto_1

    .line 115
    :cond_3
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getFileName()Ljava/lang/String;

    move-result-object v14

    invoke-static {v14}, Lnet/lingala/zip4j/util/Zip4jUtil;->convertCharset(Ljava/lang/String;)[B

    move-result-object v14

    invoke-direct {v1, v14, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 121
    :goto_1
    if-eqz v11, :cond_4

    .line 125
    const/4 v14, 0x1

    invoke-static {v4, v9, v14}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 126
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 130
    const/16 v14, 0x10

    invoke-static {v4, v9, v14}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 131
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 133
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getUncompressedSize()J

    move-result-wide v14

    invoke-static {v8, v9, v14, v15}, Lnet/lingala/zip4j/util/Raw;->writeLongLittleEndian([BIJ)V

    .line 134
    invoke-direct {v1, v8, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 136
    invoke-direct {v1, v3, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 139
    :cond_4
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getAesExtraDataRecord()Lnet/lingala/zip4j/model/AESExtraDataRecord;

    move-result-object v14

    if-eqz v14, :cond_5

    .line 140
    invoke-virtual/range {p2 .. p2}, Lnet/lingala/zip4j/model/LocalFileHeader;->getAesExtraDataRecord()Lnet/lingala/zip4j/model/AESExtraDataRecord;

    move-result-object v14

    .line 142
    .local v14, "aesExtraDataRecord":Lnet/lingala/zip4j/model/AESExtraDataRecord;
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getSignature()J

    move-result-wide v9

    long-to-int v10, v9

    int-to-short v9, v10

    const/4 v10, 0x0

    invoke-static {v4, v10, v9}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 143
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 145
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getDataSize()I

    move-result v9

    int-to-short v9, v9

    invoke-static {v4, v10, v9}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 146
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 148
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getVersionNumber()I

    move-result v9

    int-to-short v9, v9

    invoke-static {v4, v10, v9}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 149
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 151
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getVendorID()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/String;->getBytes()[B

    move-result-object v9

    invoke-direct {v1, v9, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 153
    const/4 v9, 0x1

    new-array v9, v9, [B

    .line 154
    .local v9, "aesStrengthBytes":[B
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getAesStrength()I

    move-result v10

    int-to-byte v10, v10

    const/4 v15, 0x0

    aput-byte v10, v9, v15

    .line 155
    invoke-direct {v1, v9, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 157
    invoke-virtual {v14}, Lnet/lingala/zip4j/model/AESExtraDataRecord;->getCompressionMethod()I

    move-result v10

    int-to-short v10, v10

    invoke-static {v4, v15, v10}, Lnet/lingala/zip4j/util/Raw;->writeShortLittleEndian([BIS)V

    .line 158
    invoke-direct {v1, v4, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->copyByteArrayToArrayList([BLjava/util/List;)V

    .line 160
    .end local v9    # "aesStrengthBytes":[B
    .end local v14    # "aesExtraDataRecord":Lnet/lingala/zip4j/model/AESExtraDataRecord;
    :cond_5
    invoke-direct {v1, v0}, Lnet/lingala/zip4j/core/HeaderWriter;->byteArrayListToByteArray(Ljava/util/List;)[B

    move-result-object v9
    :try_end_2
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4

    .line 161
    .local v9, "lhBytes":[B
    move-object/from16 v10, p3

    :try_start_3
    invoke-virtual {v10, v9}, Ljava/io/OutputStream;->write([B)V

    .line 162
    array-length v14, v9
    :try_end_3
    .catch Lnet/lingala/zip4j/exception/ZipException; {:try_start_3 .. :try_end_3} :catch_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_2

    return v14

    .line 165
    .end local v0    # "byteArrayList":Ljava/util/ArrayList;
    .end local v3    # "emptyLongByte":[B
    .end local v4    # "shortByte":[B
    .end local v5    # "extraFieldLength":I
    .end local v6    # "intByte":[B
    .end local v7    # "dateTime":I
    .end local v8    # "longByte":[B
    .end local v9    # "lhBytes":[B
    .end local v11    # "writingZip64Rec":Z
    .end local v12    # "uncompressedSize":J
    :catch_2
    move-exception v0

    goto :goto_3

    .line 163
    :catch_3
    move-exception v0

    goto :goto_5

    .line 165
    :catch_4
    move-exception v0

    :goto_2
    move-object/from16 v10, p3

    .line 166
    .local v0, "e":Ljava/lang/Exception;
    :goto_3
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    throw v3

    .line 163
    .end local v0    # "e":Ljava/lang/Exception;
    :catch_5
    move-exception v0

    :goto_4
    move-object/from16 v10, p3

    .line 164
    .local v0, "e":Lnet/lingala/zip4j/exception/ZipException;
    :goto_5
    throw v0

    .line 44
    .end local v0    # "e":Lnet/lingala/zip4j/exception/ZipException;
    :cond_6
    move-object/from16 v10, p3

    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v3, "input parameters are null, cannot write local file header"

    invoke-direct {v0, v3}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
