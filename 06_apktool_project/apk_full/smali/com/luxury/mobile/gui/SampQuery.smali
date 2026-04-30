.class public Lcom/luxury/mobile/gui/SampQuery;
.super Ljava/lang/Object;
.source "SampQuery.java"


# instance fields
.field private f117in:Ljava/io/BufferedReader;

.field private out:Ljava/io/PrintWriter;

.field private port:I

.field private server:Ljava/net/InetAddress;

.field private serverString:Ljava/lang/String;

.field private socket:Ljava/net/DatagramSocket;


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 2
    .param p1, "server2"    # Ljava/lang/String;
    .param p2, "port2"    # I

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 21
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->f117in:Ljava/io/BufferedReader;

    .line 22
    iput-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->out:Ljava/io/PrintWriter;

    .line 23
    const/4 v1, 0x0

    iput v1, p0, Lcom/luxury/mobile/gui/SampQuery;->port:I

    .line 24
    iput-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->server:Ljava/net/InetAddress;

    .line 25
    const-string v1, ""

    iput-object v1, p0, Lcom/luxury/mobile/gui/SampQuery;->serverString:Ljava/lang/String;

    .line 26
    iput-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->socket:Ljava/net/DatagramSocket;

    .line 30
    :try_start_0
    iput-object p1, p0, Lcom/luxury/mobile/gui/SampQuery;->serverString:Ljava/lang/String;

    .line 31
    invoke-static {p1}, Ljava/net/InetAddress;->getByName(Ljava/lang/String;)Ljava/net/InetAddress;

    move-result-object v0

    iput-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->server:Ljava/net/InetAddress;
    :try_end_0
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_0

    .line 34
    goto :goto_0

    .line 32
    :catch_0
    move-exception v0

    .line 33
    .local v0, "e":Ljava/net/UnknownHostException;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 36
    .end local v0    # "e":Ljava/net/UnknownHostException;
    :goto_0
    :try_start_1
    new-instance v0, Ljava/net/DatagramSocket;

    invoke-direct {v0}, Ljava/net/DatagramSocket;-><init>()V

    .line 37
    .local v0, "datagramSocket":Ljava/net/DatagramSocket;
    iput-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->socket:Ljava/net/DatagramSocket;

    .line 38
    const/16 v1, 0x7d0

    invoke-virtual {v0, v1}, Ljava/net/DatagramSocket;->setSoTimeout(I)V
    :try_end_1
    .catch Ljava/net/SocketException; {:try_start_1 .. :try_end_1} :catch_1

    .line 41
    .end local v0    # "datagramSocket":Ljava/net/DatagramSocket;
    goto :goto_1

    .line 39
    :catch_1
    move-exception v0

    .line 40
    .local v0, "e2":Ljava/net/SocketException;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 42
    .end local v0    # "e2":Ljava/net/SocketException;
    :goto_1
    iput p2, p0, Lcom/luxury/mobile/gui/SampQuery;->port:I

    .line 43
    return-void
.end method

.method private assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;
    .locals 7
    .param p1, "type"    # Ljava/lang/String;

    .line 203
    :try_start_0
    new-instance v0, Ljava/util/StringTokenizer;

    iget-object v1, p0, Lcom/luxury/mobile/gui/SampQuery;->serverString:Ljava/lang/String;

    const-string v2, "."

    invoke-direct {v0, v1, v2}, Ljava/util/StringTokenizer;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 204
    .local v0, "tok":Ljava/util/StringTokenizer;
    const-string v1, "SAMP"

    .line 205
    .local v1, "packetData":Ljava/lang/String;
    :goto_0
    invoke-virtual {v0}, Ljava/util/StringTokenizer;->hasMoreTokens()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 206
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/util/StringTokenizer;->nextToken()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v3

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    move-object v1, v2

    goto :goto_0

    .line 208
    :cond_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/luxury/mobile/gui/SampQuery;->port:I

    and-int/lit16 v3, v3, 0xff

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    iget v3, p0, Lcom/luxury/mobile/gui/SampQuery;->port:I

    shr-int/lit8 v3, v3, 0x8

    and-int/lit16 v3, v3, 0xff

    int-to-char v3, v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "US-ASCII"

    invoke-virtual {v2, v3}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object v2

    .line 209
    .local v2, "data":[B
    new-instance v3, Ljava/net/DatagramPacket;

    array-length v4, v2

    iget-object v5, p0, Lcom/luxury/mobile/gui/SampQuery;->server:Ljava/net/InetAddress;

    iget v6, p0, Lcom/luxury/mobile/gui/SampQuery;->port:I

    invoke-direct {v3, v2, v4, v5, v6}, Ljava/net/DatagramPacket;-><init>([BILjava/net/InetAddress;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v3

    .line 210
    .end local v0    # "tok":Ljava/util/StringTokenizer;
    .end local v1    # "packetData":Ljava/lang/String;
    .end local v2    # "data":[B
    :catch_0
    move-exception v0

    .line 211
    .local v0, "e":Ljava/lang/Exception;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 212
    const/4 v1, 0x0

    return-object v1
.end method

.method private receive()Ljava/lang/String;
    .locals 4

    .line 225
    const/16 v0, 0x400

    new-array v0, v0, [B

    .line 227
    .local v0, "receivedData":[B
    :try_start_0
    new-instance v1, Ljava/net/DatagramPacket;

    array-length v2, v0

    invoke-direct {v1, v0, v2}, Ljava/net/DatagramPacket;-><init>([BI)V

    .line 228
    .local v1, "receivedPacket":Ljava/net/DatagramPacket;
    iget-object v2, p0, Lcom/luxury/mobile/gui/SampQuery;->socket:Ljava/net/DatagramSocket;

    invoke-virtual {v2, v1}, Ljava/net/DatagramSocket;->receive(Ljava/net/DatagramPacket;)V

    .line 229
    new-instance v2, Ljava/lang/String;

    invoke-virtual {v1}, Ljava/net/DatagramPacket;->getData()[B

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/String;-><init>([B)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v2

    .line 230
    .end local v1    # "receivedPacket":Ljava/net/DatagramPacket;
    :catch_0
    move-exception v1

    .line 231
    .local v1, "e":Ljava/io/IOException;
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v2, v1}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 232
    const/4 v2, 0x0

    return-object v2
.end method

.method private receiveBytes()[B
    .locals 4

    .line 237
    const/16 v0, 0xc00

    new-array v0, v0, [B

    .line 238
    .local v0, "receivedData":[B
    const/4 v1, 0x0

    .line 240
    .local v1, "receivedPacket":Ljava/net/DatagramPacket;
    :try_start_0
    new-instance v2, Ljava/net/DatagramPacket;

    array-length v3, v0

    invoke-direct {v2, v0, v3}, Ljava/net/DatagramPacket;-><init>([BI)V

    move-object v1, v2

    .line 241
    iget-object v2, p0, Lcom/luxury/mobile/gui/SampQuery;->socket:Ljava/net/DatagramSocket;

    invoke-virtual {v2, v1}, Ljava/net/DatagramSocket;->receive(Ljava/net/DatagramPacket;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 244
    goto :goto_0

    .line 242
    :catch_0
    move-exception v2

    .line 243
    .local v2, "e":Ljava/io/IOException;
    sget-object v3, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v3, v2}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 245
    .end local v2    # "e":Ljava/io/IOException;
    :goto_0
    invoke-virtual {v1}, Ljava/net/DatagramPacket;->getData()[B

    move-result-object v2

    return-object v2
.end method

.method private send(Ljava/net/DatagramPacket;)V
    .locals 2
    .param p1, "packet"    # Ljava/net/DatagramPacket;

    .line 218
    :try_start_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->socket:Ljava/net/DatagramSocket;

    invoke-virtual {v0, p1}, Ljava/net/DatagramSocket;->send(Ljava/net/DatagramPacket;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 221
    goto :goto_0

    .line 219
    :catch_0
    move-exception v0

    .line 220
    .local v0, "e":Ljava/io/IOException;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v1, v0}, Ljava/io/PrintStream;->println(Ljava/lang/Object;)V

    .line 222
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    return-void
.end method


# virtual methods
.method public close()V
    .locals 1

    .line 198
    iget-object v0, p0, Lcom/luxury/mobile/gui/SampQuery;->socket:Ljava/net/DatagramSocket;

    invoke-virtual {v0}, Ljava/net/DatagramSocket;->close()V

    .line 199
    return-void
.end method

.method public connect()Z
    .locals 4

    .line 186
    const-string v0, "p0101"

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/luxury/mobile/gui/SampQuery;->send(Ljava/net/DatagramPacket;)V

    .line 188
    const/4 v1, 0x0

    :try_start_0
    invoke-direct {p0}, Lcom/luxury/mobile/gui/SampQuery;->receive()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-eqz v0, :cond_0

    .line 189
    const/4 v0, 0x1

    return v0

    .line 191
    :cond_0
    return v1

    .line 192
    :catch_0
    move-exception v0

    .line 193
    .local v0, "e":Ljava/lang/Exception;
    return v1
.end method

.method public getBasicPlayers()[[Ljava/lang/String;
    .locals 14

    .line 89
    const-string v0, "c"

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->send(Ljava/net/DatagramPacket;)V

    .line 90
    invoke-direct {p0}, Lcom/luxury/mobile/gui/SampQuery;->receiveBytes()[B

    move-result-object v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 91
    .local v0, "buff":Ljava/nio/ByteBuffer;
    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 92
    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 93
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v1

    .line 94
    .local v1, "i":I
    const/4 v2, 0x2

    new-array v3, v2, [I

    .line 95
    .local v3, "iArr":[I
    const/4 v4, 0x1

    aput v2, v3, v4

    .line 96
    const/4 v2, 0x0

    aput v1, v3, v2

    .line 97
    const-class v5, Ljava/lang/String;

    invoke-static {v5, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [[Ljava/lang/String;

    .line 98
    .local v5, "players":[[Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "i2":I
    :goto_0
    array-length v7, v5

    if-le v7, v6, :cond_1

    .line 99
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v7

    .line 100
    .local v7, "len":I
    new-array v8, v7, [B

    .line 101
    .local v8, "nameBA":[B
    const/4 v9, 0x0

    .local v9, "j":I
    :goto_1
    if-le v7, v9, :cond_0

    .line 102
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v10

    aput-byte v10, v8, v9

    .line 101
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 104
    .end local v9    # "j":I
    :cond_0
    new-instance v9, Ljava/lang/String;

    invoke-direct {v9, v8}, Ljava/lang/String;-><init>([B)V

    .line 105
    .local v9, "name":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v10

    .line 106
    .local v10, "score":I
    aget-object v11, v5, v6

    aput-object v9, v11, v2

    .line 107
    aget-object v11, v5, v6

    .line 108
    .local v11, "strArr":[Ljava/lang/String;
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, ""

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    aput-object v12, v11, v4

    .line 98
    .end local v7    # "len":I
    .end local v8    # "nameBA":[B
    .end local v9    # "name":Ljava/lang/String;
    .end local v10    # "score":I
    .end local v11    # "strArr":[Ljava/lang/String;
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 110
    .end local v6    # "i2":I
    :cond_1
    return-object v5
.end method

.method public getDetailedPlayers()[[Ljava/lang/String;
    .locals 20

    .line 114
    move-object/from16 v0, p0

    const-string v1, "d"

    invoke-direct {v0, v1}, Lcom/luxury/mobile/gui/SampQuery;->assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/luxury/mobile/gui/SampQuery;->send(Ljava/net/DatagramPacket;)V

    .line 115
    invoke-direct/range {p0 .. p0}, Lcom/luxury/mobile/gui/SampQuery;->receiveBytes()[B

    move-result-object v1

    invoke-static {v1}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v1

    .line 116
    .local v1, "buff":Ljava/nio/ByteBuffer;
    sget-object v2, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 117
    const/16 v2, 0xb

    invoke-virtual {v1, v2}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 118
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v2

    .line 119
    .local v2, "playerCount":I
    const/4 v3, 0x2

    new-array v4, v3, [I

    .line 120
    .local v4, "iArr":[I
    const/4 v5, 0x4

    const/4 v6, 0x1

    aput v5, v4, v6

    .line 121
    const/4 v5, 0x0

    .line 122
    .local v5, "c":C
    const/4 v7, 0x0

    aput v2, v4, v7

    .line 123
    const-class v7, Ljava/lang/String;

    invoke-static {v7, v4}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, [[Ljava/lang/String;

    .line 124
    .local v7, "players":[[Ljava/lang/String;
    const/4 v8, 0x0

    .line 125
    .local v8, "i":I
    :goto_0
    array-length v9, v7

    if-le v9, v8, :cond_1

    .line 126
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->get()B

    move-result v9

    .line 127
    .local v9, "id":I
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->get()B

    move-result v10

    .line 128
    .local v10, "len":I
    new-array v11, v10, [B

    .line 129
    .local v11, "nameBA":[B
    const/4 v12, 0x0

    .local v12, "j":I
    :goto_1
    if-le v10, v12, :cond_0

    .line 130
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->get()B

    move-result v13

    aput-byte v13, v11, v12

    .line 129
    add-int/lit8 v12, v12, 0x1

    goto :goto_1

    .line 132
    .end local v12    # "j":I
    :cond_0
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v11}, Ljava/lang/String;-><init>([B)V

    .line 133
    .local v12, "name":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v13

    .line 134
    .local v13, "score":I
    invoke-virtual {v1}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v14

    .line 135
    .local v14, "ping":I
    aget-object v15, v7, v8

    .line 136
    .local v15, "strArr":[Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, ""

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v15, v5

    .line 137
    aget-object v3, v7, v8

    const/16 v17, 0x1

    aput-object v12, v3, v17

    .line 138
    aget-object v3, v7, v8

    .line 139
    .local v3, "strArr2":[Ljava/lang/String;
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v13}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/16 v16, 0x2

    aput-object v0, v3, v16

    .line 140
    aget-object v0, v7, v8

    .line 141
    .local v0, "strArr3":[Ljava/lang/String;
    const/16 v18, 0x3

    move-object/from16 v19, v1

    .end local v1    # "buff":Ljava/nio/ByteBuffer;
    .local v19, "buff":Ljava/nio/ByteBuffer;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v14}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    aput-object v1, v0, v18

    .line 142
    add-int/lit8 v8, v8, 0x1

    .line 143
    const/4 v5, 0x0

    .line 144
    .end local v0    # "strArr3":[Ljava/lang/String;
    .end local v3    # "strArr2":[Ljava/lang/String;
    .end local v9    # "id":I
    .end local v10    # "len":I
    .end local v11    # "nameBA":[B
    .end local v12    # "name":Ljava/lang/String;
    .end local v13    # "score":I
    .end local v14    # "ping":I
    .end local v15    # "strArr":[Ljava/lang/String;
    const/4 v3, 0x2

    const/4 v6, 0x1

    move-object/from16 v0, p0

    move-object/from16 v1, v19

    goto :goto_0

    .line 145
    .end local v19    # "buff":Ljava/nio/ByteBuffer;
    .restart local v1    # "buff":Ljava/nio/ByteBuffer;
    :cond_1
    return-object v7
.end method

.method public getInfo()[Ljava/lang/String;
    .locals 22

    .line 46
    move-object/from16 v0, p0

    const-string v1, "i"

    invoke-direct {v0, v1}, Lcom/luxury/mobile/gui/SampQuery;->assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;

    move-result-object v1

    .line 47
    .local v1, "packet":Ljava/net/DatagramPacket;
    invoke-direct {v0, v1}, Lcom/luxury/mobile/gui/SampQuery;->send(Ljava/net/DatagramPacket;)V

    .line 48
    invoke-direct/range {p0 .. p0}, Lcom/luxury/mobile/gui/SampQuery;->receiveBytes()[B

    move-result-object v2

    .line 49
    .local v2, "reply":[B
    invoke-static {v2}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v3

    .line 50
    .local v3, "buff":Ljava/nio/ByteBuffer;
    sget-object v4, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 51
    const/16 v4, 0xb

    invoke-virtual {v3, v4}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 52
    const/4 v4, 0x6

    new-array v4, v4, [Ljava/lang/String;

    .line 53
    .local v4, "serverInfo":[Ljava/lang/String;
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->get()B

    move-result v5

    .line 54
    .local v5, "password":I
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v6

    .line 55
    .local v6, "players":S
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v7

    .line 56
    .local v7, "maxPlayers":S
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v8

    .line 57
    .local v8, "len":I
    new-array v9, v8, [B

    .line 58
    .local v9, "hostnameBA":[B
    const/4 v10, 0x0

    .local v10, "i":I
    :goto_0
    if-le v8, v10, :cond_0

    .line 59
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->get()B

    move-result v11

    aput-byte v11, v9, v10

    .line 58
    add-int/lit8 v10, v10, 0x1

    goto :goto_0

    .line 61
    .end local v10    # "i":I
    :cond_0
    new-instance v10, Ljava/lang/String;

    invoke-direct {v10, v9}, Ljava/lang/String;-><init>([B)V

    .line 62
    .local v10, "hostname":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v11

    .line 63
    .local v11, "lenG":I
    new-array v12, v11, [B

    .line 64
    .local v12, "gamemodeBA":[B
    const/4 v13, 0x0

    .local v13, "i2":I
    :goto_1
    if-le v11, v13, :cond_1

    .line 65
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->get()B

    move-result v14

    aput-byte v14, v12, v13

    .line 64
    add-int/lit8 v13, v13, 0x1

    goto :goto_1

    .line 67
    .end local v13    # "i2":I
    :cond_1
    new-instance v13, Ljava/lang/String;

    invoke-direct {v13, v12}, Ljava/lang/String;-><init>([B)V

    .line 68
    .local v13, "gamemode":Ljava/lang/String;
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->getInt()I

    move-result v14

    .line 69
    .local v14, "lenM":I
    new-array v15, v14, [B

    .line 70
    .local v15, "mapBA":[B
    const/16 v16, 0x0

    move/from16 v0, v16

    .local v0, "i3":I
    :goto_2
    if-le v14, v0, :cond_2

    .line 71
    invoke-virtual {v3}, Ljava/nio/ByteBuffer;->get()B

    move-result v16

    aput-byte v16, v15, v0

    .line 70
    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    .line 73
    .end local v0    # "i3":I
    :cond_2
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, v15}, Ljava/lang/String;-><init>([B)V

    .line 74
    .local v0, "map":Ljava/lang/String;
    move-object/from16 v16, v1

    .line 75
    .local v16, "datagramPacket":Ljava/net/DatagramPacket;
    new-instance v17, Ljava/lang/StringBuilder;

    invoke-direct/range {v17 .. v17}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v18, v17

    .line 76
    .local v18, "sb":Ljava/lang/StringBuilder;
    move-object/from16 v17, v2

    .line 77
    .local v17, "bArr":[B
    move-object/from16 v19, v1

    .end local v1    # "packet":Ljava/net/DatagramPacket;
    .local v19, "packet":Ljava/net/DatagramPacket;
    const-string v1, ""

    move-object/from16 v20, v2

    move-object/from16 v2, v18

    .end local v18    # "sb":Ljava/lang/StringBuilder;
    .local v2, "sb":Ljava/lang/StringBuilder;
    .local v20, "reply":[B
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 78
    invoke-virtual {v2, v5}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 79
    const/16 v18, 0x0

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v4, v18

    .line 80
    move-object/from16 v18, v2

    .end local v2    # "sb":Ljava/lang/StringBuilder;
    .restart local v18    # "sb":Ljava/lang/StringBuilder;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const/16 v21, 0x1

    aput-object v2, v4, v21

    .line 81
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v7}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x2

    aput-object v1, v4, v2

    .line 82
    const/4 v1, 0x3

    aput-object v10, v4, v1

    .line 83
    const/4 v1, 0x4

    aput-object v13, v4, v1

    .line 84
    const/4 v1, 0x5

    aput-object v0, v4, v1

    .line 85
    return-object v4
.end method

.method public getPing()J
    .locals 5

    .line 178
    const-string v0, "p0101"

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;

    move-result-object v0

    .line 179
    .local v0, "packet":Ljava/net/DatagramPacket;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    .line 180
    .local v1, "beforeSend":J
    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->send(Ljava/net/DatagramPacket;)V

    .line 181
    invoke-direct {p0}, Lcom/luxury/mobile/gui/SampQuery;->receiveBytes()[B

    .line 182
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    sub-long/2addr v3, v1

    return-wide v3
.end method

.method public getRules()[[Ljava/lang/String;
    .locals 14

    .line 149
    const-string v0, "r"

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->assemblePacket(Ljava/lang/String;)Ljava/net/DatagramPacket;

    move-result-object v0

    invoke-direct {p0, v0}, Lcom/luxury/mobile/gui/SampQuery;->send(Ljava/net/DatagramPacket;)V

    .line 150
    invoke-direct {p0}, Lcom/luxury/mobile/gui/SampQuery;->receiveBytes()[B

    move-result-object v0

    invoke-static {v0}, Ljava/nio/ByteBuffer;->wrap([B)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 151
    .local v0, "buff":Ljava/nio/ByteBuffer;
    sget-object v1, Ljava/nio/ByteOrder;->LITTLE_ENDIAN:Ljava/nio/ByteOrder;

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->order(Ljava/nio/ByteOrder;)Ljava/nio/ByteBuffer;

    .line 152
    const/16 v1, 0xb

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 153
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->getShort()S

    move-result v1

    .line 154
    .local v1, "i":I
    const/4 v2, 0x2

    new-array v3, v2, [I

    .line 155
    .local v3, "iArr":[I
    const/4 v4, 0x1

    aput v2, v3, v4

    .line 156
    const/4 v2, 0x0

    aput v1, v3, v2

    .line 157
    const-class v5, Ljava/lang/String;

    invoke-static {v5, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;[I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [[Ljava/lang/String;

    .line 158
    .local v5, "rules":[[Ljava/lang/String;
    const/4 v6, 0x0

    .local v6, "i2":I
    :goto_0
    array-length v7, v5

    if-le v7, v6, :cond_2

    .line 159
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v7

    .line 160
    .local v7, "len":I
    new-array v8, v7, [B

    .line 161
    .local v8, "ruleBA":[B
    const/4 v9, 0x0

    .local v9, "j":I
    :goto_1
    if-le v7, v9, :cond_0

    .line 162
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v10

    aput-byte v10, v8, v9

    .line 161
    add-int/lit8 v9, v9, 0x1

    goto :goto_1

    .line 164
    .end local v9    # "j":I
    :cond_0
    new-instance v9, Ljava/lang/String;

    invoke-direct {v9, v8}, Ljava/lang/String;-><init>([B)V

    .line 165
    .local v9, "rule":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v10

    .line 166
    .local v10, "lenV":I
    new-array v11, v10, [B

    .line 167
    .local v11, "valBA":[B
    const/4 v12, 0x0

    .local v12, "j2":I
    :goto_2
    if-le v10, v12, :cond_1

    .line 168
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->get()B

    move-result v13

    aput-byte v13, v11, v12

    .line 167
    add-int/lit8 v12, v12, 0x1

    goto :goto_2

    .line 170
    .end local v12    # "j2":I
    :cond_1
    new-instance v12, Ljava/lang/String;

    invoke-direct {v12, v11}, Ljava/lang/String;-><init>([B)V

    .line 171
    .local v12, "val":Ljava/lang/String;
    aget-object v13, v5, v6

    aput-object v9, v13, v2

    .line 172
    aget-object v13, v5, v6

    aput-object v12, v13, v4

    .line 158
    .end local v7    # "len":I
    .end local v8    # "ruleBA":[B
    .end local v9    # "rule":Ljava/lang/String;
    .end local v10    # "lenV":I
    .end local v11    # "valBA":[B
    .end local v12    # "val":Ljava/lang/String;
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 174
    .end local v6    # "i2":I
    :cond_2
    return-object v5
.end method
