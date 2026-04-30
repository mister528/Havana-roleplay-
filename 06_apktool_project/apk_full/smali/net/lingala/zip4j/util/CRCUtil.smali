.class public Lnet/lingala/zip4j/util/CRCUtil;
.super Ljava/lang/Object;
.source "CRCUtil.java"


# static fields
.field private static final BUF_SIZE:I = 0x4000


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static computeFileCRC(Ljava/lang/String;)J
    .locals 2
    .param p0, "inputFile"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 33
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lnet/lingala/zip4j/util/CRCUtil;->computeFileCRC(Ljava/lang/String;Lnet/lingala/zip4j/progress/ProgressMonitor;)J

    move-result-wide v0

    return-wide v0
.end method

.method public static computeFileCRC(Ljava/lang/String;Lnet/lingala/zip4j/progress/ProgressMonitor;)J
    .locals 8
    .param p0, "inputFile"    # Ljava/lang/String;
    .param p1, "progressMonitor"    # Lnet/lingala/zip4j/progress/ProgressMonitor;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lnet/lingala/zip4j/exception/ZipException;
        }
    .end annotation

    .line 44
    const-string v0, "error while closing the file after calculating crc"

    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->isStringNotNullAndNotEmpty(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    .line 47
    const/4 v1, 0x0

    .line 49
    .local v1, "inputStream":Ljava/io/InputStream;
    :try_start_0
    invoke-static {p0}, Lnet/lingala/zip4j/util/Zip4jUtil;->checkFileReadAccess(Ljava/lang/String;)Z

    .line 51
    new-instance v2, Ljava/io/FileInputStream;

    new-instance v3, Ljava/io/File;

    invoke-direct {v3, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v1, v2

    .line 53
    const/16 v2, 0x4000

    new-array v2, v2, [B

    .line 54
    .local v2, "buff":[B
    const/4 v3, -0x2

    .line 55
    .local v3, "readLen":I
    new-instance v4, Ljava/util/zip/CRC32;

    invoke-direct {v4}, Ljava/util/zip/CRC32;-><init>()V

    .line 57
    .local v4, "crc32":Ljava/util/zip/CRC32;
    :cond_0
    invoke-virtual {v1, v2}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v3, v5

    const/4 v6, -0x1

    if-eq v5, v6, :cond_1

    .line 58
    const/4 v5, 0x0

    invoke-virtual {v4, v2, v5, v3}, Ljava/util/zip/CRC32;->update([BII)V

    .line 59
    if-eqz p1, :cond_0

    .line 60
    int-to-long v6, v3

    invoke-virtual {p1, v6, v7}, Lnet/lingala/zip4j/progress/ProgressMonitor;->updateWorkCompleted(J)V

    .line 61
    invoke-virtual {p1}, Lnet/lingala/zip4j/progress/ProgressMonitor;->isCancelAllTasks()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 62
    const/4 v6, 0x3

    invoke-virtual {p1, v6}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setResult(I)V

    .line 63
    invoke-virtual {p1, v5}, Lnet/lingala/zip4j/progress/ProgressMonitor;->setState(I)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 64
    const-wide/16 v5, 0x0

    .line 75
    nop

    .line 77
    :try_start_1
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 80
    nop

    .line 79
    return-wide v5

    .line 78
    :catch_0
    move-exception v5

    .line 79
    .local v5, "e":Ljava/io/IOException;
    new-instance v6, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v6, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 69
    .end local v5    # "e":Ljava/io/IOException;
    :cond_1
    :try_start_2
    invoke-virtual {v4}, Ljava/util/zip/CRC32;->getValue()J

    move-result-wide v5
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 75
    nop

    .line 77
    :try_start_3
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1

    .line 80
    nop

    .line 79
    return-wide v5

    .line 78
    :catch_1
    move-exception v5

    .line 79
    .restart local v5    # "e":Ljava/io/IOException;
    new-instance v6, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v6, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 75
    .end local v2    # "buff":[B
    .end local v3    # "readLen":I
    .end local v4    # "crc32":Ljava/util/zip/CRC32;
    .end local v5    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v2

    goto :goto_0

    .line 72
    :catch_2
    move-exception v2

    .line 73
    .local v2, "e":Ljava/lang/Exception;
    :try_start_4
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v1    # "inputStream":Ljava/io/InputStream;
    .end local p0    # "inputFile":Ljava/lang/String;
    .end local p1    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v3

    .line 70
    .end local v2    # "e":Ljava/lang/Exception;
    .restart local v1    # "inputStream":Ljava/io/InputStream;
    .restart local p0    # "inputFile":Ljava/lang/String;
    .restart local p1    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :catch_3
    move-exception v2

    .line 71
    .local v2, "e":Ljava/io/IOException;
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v2}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/Throwable;)V

    .end local v1    # "inputStream":Ljava/io/InputStream;
    .end local p0    # "inputFile":Ljava/lang/String;
    .end local p1    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    throw v3
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 75
    .end local v2    # "e":Ljava/io/IOException;
    .restart local v1    # "inputStream":Ljava/io/InputStream;
    .restart local p0    # "inputFile":Ljava/lang/String;
    .restart local p1    # "progressMonitor":Lnet/lingala/zip4j/progress/ProgressMonitor;
    :goto_0
    if-eqz v1, :cond_2

    .line 77
    :try_start_5
    invoke-virtual {v1}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_4

    .line 80
    goto :goto_1

    .line 78
    :catch_4
    move-exception v2

    .line 79
    .restart local v2    # "e":Ljava/io/IOException;
    new-instance v3, Lnet/lingala/zip4j/exception/ZipException;

    invoke-direct {v3, v0}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    throw v3

    .end local v2    # "e":Ljava/io/IOException;
    :cond_2
    :goto_1
    throw v2

    .line 45
    .end local v1    # "inputStream":Ljava/io/InputStream;
    :cond_3
    new-instance v0, Lnet/lingala/zip4j/exception/ZipException;

    const-string v1, "input file is null or empty, cannot calculate CRC for the file"

    invoke-direct {v0, v1}, Lnet/lingala/zip4j/exception/ZipException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method
