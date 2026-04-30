.class Lcom/luxury/mobile/gui/InstallActivity$1;
.super Ljava/lang/Object;
.source "InstallActivity.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/luxury/mobile/gui/InstallActivity;->getFileSize(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field f115in:Ljava/io/InputStream;

.field file:Ljava/io/FileOutputStream;

.field final synthetic this$0:Lcom/luxury/mobile/gui/InstallActivity;

.field urlConnection:Ljava/net/URLConnection;

.field final synthetic val$string:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/luxury/mobile/gui/InstallActivity;Ljava/lang/String;)V
    .locals 1
    .param p1, "this$0"    # Lcom/luxury/mobile/gui/InstallActivity;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/FileNotFoundException;
        }
    .end annotation

    .line 56
    iput-object p1, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->this$0:Lcom/luxury/mobile/gui/InstallActivity;

    iput-object p2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->val$string:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    new-instance p2, Ljava/io/FileOutputStream;

    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->this$0:Lcom/luxury/mobile/gui/InstallActivity;

    iget-object v0, v0, Lcom/luxury/mobile/gui/InstallActivity;->path_zip:Ljava/lang/String;

    invoke-direct {p2, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    iput-object p2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->file:Ljava/io/FileOutputStream;

    .line 61
    const/4 p2, 0x0

    iput-object p2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->urlConnection:Ljava/net/URLConnection;

    return-void
.end method


# virtual methods
.method public run()V
    .locals 10

    .line 65
    :try_start_0
    new-instance v0, Ljava/net/URL;

    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->val$string:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v0

    .line 66
    .local v0, "openConnection":Ljava/net/URLConnection;
    iput-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->urlConnection:Ljava/net/URLConnection;

    .line 67
    invoke-virtual {v0}, Ljava/net/URLConnection;->connect()V

    .line 68
    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->urlConnection:Ljava/net/URLConnection;

    invoke-virtual {v1}, Ljava/net/URLConnection;->getContentLength()I

    move-result v1

    .line 69
    .local v1, "length":I
    iget-object v2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->urlConnection:Ljava/net/URLConnection;

    invoke-virtual {v2}, Ljava/net/URLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v2

    iput-object v2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->f115in:Ljava/io/InputStream;

    .line 70
    const/16 v2, 0x1000

    new-array v3, v2, [B

    .line 71
    .local v3, "data":[B
    const/4 v4, 0x0

    .line 73
    .local v4, "chet":I
    :goto_0
    iget-object v5, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->f115in:Ljava/io/InputStream;

    const/4 v6, 0x0

    invoke-virtual {v5, v3, v6, v2}, Ljava/io/InputStream;->read([BII)I

    move-result v5

    .line 74
    .local v5, "read":I
    move v7, v5

    .line 75
    .local v7, "count":I
    const/4 v8, -0x1

    if-ne v5, v8, :cond_1

    .line 76
    nop

    .line 87
    .end local v5    # "read":I
    .end local v7    # "count":I
    iget-object v2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->file:Ljava/io/FileOutputStream;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_4
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 88
    .local v2, "fileOutputStream":Ljava/io/FileOutputStream;
    if-eqz v2, :cond_0

    .line 90
    :try_start_1
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_4
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 93
    goto :goto_1

    .line 91
    :catch_0
    move-exception v5

    .line 92
    .local v5, "e":Ljava/io/IOException;
    :try_start_2
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    .line 95
    .end local v5    # "e":Ljava/io/IOException;
    :cond_0
    :goto_1
    iget-object v5, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->f115in:Ljava/io/InputStream;
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_4
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 96
    .local v5, "inputStream":Ljava/io/InputStream;
    if-eqz v5, :cond_5

    .line 98
    :try_start_3
    invoke-virtual {v5}, Ljava/io/InputStream;->close()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_4
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 101
    goto :goto_5

    .line 99
    :catch_1
    move-exception v6

    .line 100
    .local v6, "e2":Ljava/io/IOException;
    :try_start_4
    invoke-virtual {v6}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_5

    .line 78
    .end local v2    # "fileOutputStream":Ljava/io/FileOutputStream;
    .end local v6    # "e2":Ljava/io/IOException;
    .local v5, "read":I
    .restart local v7    # "count":I
    :cond_1
    add-int/2addr v4, v7

    .line 79
    iget-object v8, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->file:Ljava/io/FileOutputStream;

    invoke-virtual {v8, v3, v6, v7}, Ljava/io/FileOutputStream;->write([BII)V

    .line 80
    move v6, v4

    .line 81
    .local v6, "finalChet":I
    iget-object v8, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->this$0:Lcom/luxury/mobile/gui/InstallActivity;

    new-instance v9, Lcom/luxury/mobile/gui/InstallActivity$1$1;

    invoke-direct {v9, p0, v6, v1}, Lcom/luxury/mobile/gui/InstallActivity$1$1;-><init>(Lcom/luxury/mobile/gui/InstallActivity$1;II)V

    invoke-virtual {v8, v9}, Lcom/luxury/mobile/gui/InstallActivity;->runOnUiThread(Ljava/lang/Runnable;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 86
    .end local v5    # "read":I
    .end local v6    # "finalChet":I
    .end local v7    # "count":I
    goto :goto_0

    .line 121
    .end local v0    # "openConnection":Ljava/net/URLConnection;
    .end local v1    # "length":I
    .end local v3    # "data":[B
    .end local v4    # "chet":I
    :catchall_0
    move-exception v0

    .line 122
    .local v0, "th":Ljava/lang/Throwable;
    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->file:Ljava/io/FileOutputStream;

    .line 123
    .local v1, "fileOutputStream3":Ljava/io/FileOutputStream;
    if-eqz v1, :cond_2

    .line 125
    :try_start_5
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 128
    goto :goto_2

    .line 126
    :catch_2
    move-exception v2

    .line 127
    .local v2, "e5":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 130
    .end local v2    # "e5":Ljava/io/IOException;
    :cond_2
    :goto_2
    iget-object v2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->f115in:Ljava/io/InputStream;

    .line 131
    .local v2, "inputStream3":Ljava/io/InputStream;
    if-eqz v2, :cond_3

    .line 133
    :try_start_6
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 136
    goto :goto_3

    .line 134
    :catch_3
    move-exception v3

    .line 135
    .local v3, "e6":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    .line 138
    .end local v3    # "e6":Ljava/io/IOException;
    :cond_3
    :goto_3
    throw v0

    .line 103
    .end local v0    # "th":Ljava/lang/Throwable;
    .end local v1    # "fileOutputStream3":Ljava/io/FileOutputStream;
    .end local v2    # "inputStream3":Ljava/io/InputStream;
    :catch_4
    move-exception v0

    .line 104
    .local v0, "e3":Ljava/lang/Exception;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "\u062e\u0637\u0623 "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Downn"

    invoke-static {v2, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 105
    iget-object v1, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->file:Ljava/io/FileOutputStream;

    .line 106
    .local v1, "fileOutputStream2":Ljava/io/FileOutputStream;
    if-eqz v1, :cond_4

    .line 108
    :try_start_7
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    .line 111
    goto :goto_4

    .line 109
    :catch_5
    move-exception v2

    .line 110
    .local v2, "e4":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 113
    .end local v2    # "e4":Ljava/io/IOException;
    :cond_4
    :goto_4
    iget-object v2, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->f115in:Ljava/io/InputStream;

    .line 114
    .local v2, "inputStream2":Ljava/io/InputStream;
    if-eqz v2, :cond_5

    .line 116
    :try_start_8
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_6

    .line 119
    goto :goto_5

    .line 117
    :catch_6
    move-exception v3

    .line 118
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    .line 139
    .end local v0    # "e3":Ljava/lang/Exception;
    .end local v1    # "fileOutputStream2":Ljava/io/FileOutputStream;
    .end local v2    # "inputStream2":Ljava/io/InputStream;
    .end local v3    # "e":Ljava/io/IOException;
    :cond_5
    :goto_5
    nop

    .line 140
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->this$0:Lcom/luxury/mobile/gui/InstallActivity;

    new-instance v1, Lcom/luxury/mobile/gui/InstallActivity$1$2;

    invoke-direct {v1, p0}, Lcom/luxury/mobile/gui/InstallActivity$1$2;-><init>(Lcom/luxury/mobile/gui/InstallActivity$1;)V

    invoke-virtual {v0, v1}, Lcom/luxury/mobile/gui/InstallActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 145
    iget-object v0, p0, Lcom/luxury/mobile/gui/InstallActivity$1;->this$0:Lcom/luxury/mobile/gui/InstallActivity;

    invoke-virtual {v0}, Lcom/luxury/mobile/gui/InstallActivity;->UnZip()V

    .line 146
    return-void
.end method
