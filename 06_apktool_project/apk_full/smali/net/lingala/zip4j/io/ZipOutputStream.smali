.class public Lnet/lingala/zip4j/io/ZipOutputStream;
.super Lnet/lingala/zip4j/io/DeflaterOutputStream;
.source "ZipOutputStream.java"


# direct methods
.method public constructor <init>(Ljava/io/OutputStream;)V
    .locals 1
    .param p1, "outputStream"    # Ljava/io/OutputStream;

    .line 11
    const/4 v0, 0x0

    invoke-direct {p0, p1, v0}, Lnet/lingala/zip4j/io/ZipOutputStream;-><init>(Ljava/io/OutputStream;Lnet/lingala/zip4j/model/ZipModel;)V

    .line 12
    return-void
.end method

.method public constructor <init>(Ljava/io/OutputStream;Lnet/lingala/zip4j/model/ZipModel;)V
    .locals 0
    .param p1, "outputStream"    # Ljava/io/OutputStream;
    .param p2, "zipModel"    # Lnet/lingala/zip4j/model/ZipModel;

    .line 15
    invoke-direct {p0, p1, p2}, Lnet/lingala/zip4j/io/DeflaterOutputStream;-><init>(Ljava/io/OutputStream;Lnet/lingala/zip4j/model/ZipModel;)V

    .line 16
    return-void
.end method


# virtual methods
.method public write(I)V
    .locals 4
    .param p1, "bval"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 19
    const/4 v0, 0x1

    new-array v1, v0, [B

    .line 20
    .local v1, "b":[B
    int-to-byte v2, p1

    const/4 v3, 0x0

    aput-byte v2, v1, v3

    .line 21
    invoke-virtual {p0, v1, v3, v0}, Lnet/lingala/zip4j/io/ZipOutputStream;->write([BII)V

    .line 22
    return-void
.end method

.method public write([B)V
    .locals 2
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 25
    array-length v0, p1

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v1, v0}, Lnet/lingala/zip4j/io/ZipOutputStream;->write([BII)V

    .line 26
    return-void
.end method

.method public write([BII)V
    .locals 1
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 29
    iget-object v0, p0, Lnet/lingala/zip4j/io/ZipOutputStream;->crc:Ljava/util/zip/CRC32;

    invoke-virtual {v0, p1, p2, p3}, Ljava/util/zip/CRC32;->update([BII)V

    .line 30
    invoke-virtual {p0, p3}, Lnet/lingala/zip4j/io/ZipOutputStream;->updateTotalBytesRead(I)V

    .line 31
    invoke-super {p0, p1, p2, p3}, Lnet/lingala/zip4j/io/DeflaterOutputStream;->write([BII)V

    .line 32
    return-void
.end method
