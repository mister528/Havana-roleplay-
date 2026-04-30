.class public Lcom/luxury/mobile/gui/SettingsActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "SettingsActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# instance fields
.field button_nik:Landroid/widget/ImageButton;

.field button_uninstall:Landroid/widget/ImageButton;

.field editText:Landroid/widget/EditText;

.field imageButton:Landroid/widget/ImageButton;

.field imageButton10:Landroid/widget/ImageButton;

.field imageButton13:Landroid/widget/ImageButton;

.field imageButton14:Landroid/widget/ImageButton;

.field imageButton3:Landroid/widget/ImageButton;

.field imageButton4:Landroid/widget/ImageButton;

.field imageButton6:Landroid/widget/ImageButton;

.field imageButton7:Landroid/widget/ImageButton;

.field nickName:Ljava/lang/String;

.field textView23:Landroid/widget/TextView;

.field textView24:Landroid/widget/TextView;

.field textView25:Landroid/widget/TextView;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method public OpenNick()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 155
    new-instance v0, Lorg/ini4j/Wini;

    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, "/LuxuryMobile/SAMP/settings.ini"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lorg/ini4j/Wini;-><init>(Ljava/io/File;)V

    const-string v1, "client"

    const-string v2, "name"

    invoke-virtual {v0, v1, v2}, Lorg/ini4j/Wini;->get(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 156
    .local v0, "str":Ljava/lang/String;
    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->nickName:Ljava/lang/String;

    .line 157
    iget-object v1, p0, Lcom/luxury/mobile/gui/SettingsActivity;->editText:Landroid/widget/EditText;

    invoke-virtual {v1, v0}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 158
    return-void
.end method

.method public Save(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "vbr"    # Ljava/lang/String;
    .param p2, "kolvo"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 173
    new-instance v0, Lorg/ini4j/Wini;

    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, "/Oriongrp/SAMP/settings.ini"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lorg/ini4j/Wini;-><init>(Ljava/io/File;)V

    .line 174
    .local v0, "ini":Lorg/ini4j/Wini;
    const-string v1, "gui"

    invoke-virtual {v0, v1, p1, p2}, Lorg/ini4j/Wini;->put(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    .line 175
    invoke-virtual {v0}, Lorg/ini4j/Wini;->store()V

    .line 176
    return-void
.end method

.method public SaveNick()V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 161
    new-instance v0, Lorg/ini4j/Wini;

    new-instance v1, Ljava/io/File;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v3, "/LuxuryMobile/SAMP/settings.ini"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v0, v1}, Lorg/ini4j/Wini;-><init>(Ljava/io/File;)V

    .line 162
    .local v0, "ini":Lorg/ini4j/Wini;
    iget-object v1, p0, Lcom/luxury/mobile/gui/SettingsActivity;->editText:Landroid/widget/EditText;

    invoke-virtual {v1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 163
    .local v1, "obj":Ljava/lang/String;
    iput-object v1, p0, Lcom/luxury/mobile/gui/SettingsActivity;->nickName:Ljava/lang/String;

    .line 164
    const-string v2, "client"

    const-string v3, "name"

    invoke-virtual {v0, v2, v3, v1}, Lorg/ini4j/Wini;->put(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/String;

    .line 165
    invoke-virtual {v0}, Lorg/ini4j/Wini;->store()V

    .line 166
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/SettingsActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    .line 167
    .local v2, "applicationContext":Landroid/content/Context;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "\u0627\u0633\u0645\u0643: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lcom/luxury/mobile/gui/SettingsActivity;->nickName:Ljava/lang/String;

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "   \u062a\u0645 \u0627\u0644\u062d\u0641\u0638 \u0628\u0646\u062c\u0627\u062d!"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x1

    invoke-static {v2, v3, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v3

    .line 168
    .local v3, "toast":Landroid/widget/Toast;
    const/16 v4, 0x11

    const/4 v5, 0x0

    invoke-virtual {v3, v4, v5, v5}, Landroid/widget/Toast;->setGravity(III)V

    .line 169
    invoke-virtual {v3}, Landroid/widget/Toast;->show()V

    .line 170
    return-void
.end method

.method public onClick(Landroid/view/View;)V
    .locals 6
    .param p1, "v"    # Landroid/view/View;

    .line 78
    invoke-virtual {p1}, Landroid/view/View;->getId()I

    move-result v0

    const-string v1, "#114028"

    const-string v2, "fps"

    const/4 v3, 0x0

    const-string v4, "#FFFFFF"

    const/4 v5, 0x4

    sparse-switch v0, :sswitch_data_0

    .line 150
    return-void

    .line 138
    :sswitch_0
    :try_start_0
    const-string v0, "90"

    invoke-virtual {p0, v2, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->Save(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 141
    goto :goto_0

    .line 139
    :catch_0
    move-exception v0

    .line 140
    .local v0, "e5":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 142
    .end local v0    # "e5":Ljava/io/IOException;
    :goto_0
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton13:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 143
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton14:Landroid/widget/ImageButton;

    invoke-virtual {v0, v3}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 144
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton4:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 145
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView23:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 146
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView24:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 147
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView25:Landroid/widget/TextView;

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 148
    return-void

    .line 125
    :sswitch_1
    :try_start_1
    const-string v0, "60"

    invoke-virtual {p0, v2, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->Save(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .line 128
    goto :goto_1

    .line 126
    :catch_1
    move-exception v0

    .line 127
    .local v0, "e4":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 129
    .end local v0    # "e4":Ljava/io/IOException;
    :goto_1
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton13:Landroid/widget/ImageButton;

    invoke-virtual {v0, v3}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 130
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton14:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 131
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton4:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 132
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView23:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/widget/TextView;->setTextColor(I)V

    .line 133
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView24:Landroid/widget/TextView;

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 134
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView25:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 135
    return-void

    .line 112
    :sswitch_2
    :try_start_2
    const-string v0, "30"

    invoke-virtual {p0, v2, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->Save(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_2

    .line 115
    goto :goto_2

    .line 113
    :catch_2
    move-exception v0

    .line 114
    .local v0, "e3":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 116
    .end local v0    # "e3":Ljava/io/IOException;
    :goto_2
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton13:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 117
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton14:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 118
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton4:Landroid/widget/ImageButton;

    invoke-virtual {v0, v3}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 119
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView23:Landroid/widget/TextView;

    invoke-static {v1}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 120
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView24:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 121
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView25:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 122
    return-void

    .line 103
    :sswitch_3
    :try_start_3
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/SettingsActivity;->SaveNick()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_3

    .line 106
    goto :goto_3

    .line 104
    :catch_3
    move-exception v0

    .line 105
    .local v0, "e2":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 107
    .end local v0    # "e2":Ljava/io/IOException;
    :goto_3
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/luxury/mobile/gui/MenuActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->startActivity(Landroid/content/Intent;)V

    .line 108
    invoke-virtual {p0, v3, v3}, Lcom/luxury/mobile/gui/SettingsActivity;->overridePendingTransition(II)V

    .line 109
    return-void

    .line 93
    :sswitch_4
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->editText:Landroid/widget/EditText;

    const/4 v1, 0x0

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/EditText;->setText(Ljava/lang/CharSequence;)V

    .line 94
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton13:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 95
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton14:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 96
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton4:Landroid/widget/ImageButton;

    invoke-virtual {v0, v5}, Landroid/widget/ImageButton;->setVisibility(I)V

    .line 97
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView23:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 98
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView24:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 99
    iget-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView25:Landroid/widget/TextView;

    invoke-static {v4}, Landroid/graphics/Color;->parseColor(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 100
    return-void

    .line 89
    :sswitch_5
    new-instance v0, Landroid/content/Intent;

    const-class v1, Lcom/luxury/mobile/gui/InstallActivity;

    invoke-direct {v0, p0, v1}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->startActivity(Landroid/content/Intent;)V

    .line 90
    invoke-virtual {p0, v3, v3}, Lcom/luxury/mobile/gui/SettingsActivity;->overridePendingTransition(II)V

    .line 91
    return-void

    .line 81
    :sswitch_6
    :try_start_4
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/SettingsActivity;->SaveNick()V

    .line 82
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/SettingsActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    const-string v1, "\u062a\u0645 \u062d\u0641\u0638 \u0627\u0644\u0627\u0633\u0645!"

    const/4 v2, 0x1

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_4

    .line 83
    return-void

    .line 84
    :catch_4
    move-exception v0

    .line 85
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 86
    return-void

    nop

    :sswitch_data_0
    .sparse-switch
        0x7f090078 -> :sswitch_6
        0x7f09007a -> :sswitch_5
        0x7f090136 -> :sswitch_4
        0x7f090137 -> :sswitch_3
        0x7f09013c -> :sswitch_2
        0x7f09013f -> :sswitch_1
        0x7f090140 -> :sswitch_0
    .end sparse-switch
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 43
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    .line 44
    const v0, 0x7f0c001f

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->setContentView(I)V

    .line 45
    const v0, 0x7f0900cc

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/EditText;

    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->editText:Landroid/widget/EditText;

    .line 46
    const v0, 0x7f090078

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->button_nik:Landroid/widget/ImageButton;

    .line 47
    const v0, 0x7f090136

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton:Landroid/widget/ImageButton;

    .line 48
    const v0, 0x7f09013d

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton4:Landroid/widget/ImageButton;

    .line 49
    const v0, 0x7f09013f

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton6:Landroid/widget/ImageButton;

    .line 50
    const v0, 0x7f090140

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton7:Landroid/widget/ImageButton;

    .line 51
    const v0, 0x7f09013c

    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageButton;

    .line 52
    .local v0, "imageButton2":Landroid/widget/ImageButton;
    iput-object v0, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton3:Landroid/widget/ImageButton;

    .line 53
    invoke-virtual {v0, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 54
    const v1, 0x7f090139

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    iput-object v1, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton13:Landroid/widget/ImageButton;

    .line 55
    const v1, 0x7f09013a

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    iput-object v1, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton14:Landroid/widget/ImageButton;

    .line 56
    const v1, 0x7f090137

    invoke-virtual {p0, v1}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    .line 57
    .local v1, "imageButton5":Landroid/widget/ImageButton;
    iput-object v1, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton10:Landroid/widget/ImageButton;

    .line 58
    invoke-virtual {v1, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 59
    const v2, 0x7f09023e

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView23:Landroid/widget/TextView;

    .line 60
    const v2, 0x7f09023f

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView24:Landroid/widget/TextView;

    .line 61
    const v2, 0x7f090240

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    iput-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->textView25:Landroid/widget/TextView;

    .line 62
    iget-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton7:Landroid/widget/ImageButton;

    invoke-virtual {v2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 63
    iget-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton6:Landroid/widget/ImageButton;

    invoke-virtual {v2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 64
    iget-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton4:Landroid/widget/ImageButton;

    invoke-virtual {v2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 65
    const v2, 0x7f09007a

    invoke-virtual {p0, v2}, Lcom/luxury/mobile/gui/SettingsActivity;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageButton;

    .line 66
    .local v2, "imageButton8":Landroid/widget/ImageButton;
    iput-object v2, p0, Lcom/luxury/mobile/gui/SettingsActivity;->button_uninstall:Landroid/widget/ImageButton;

    .line 67
    invoke-virtual {v2, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 68
    iget-object v3, p0, Lcom/luxury/mobile/gui/SettingsActivity;->imageButton:Landroid/widget/ImageButton;

    invoke-virtual {v3, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 69
    iget-object v3, p0, Lcom/luxury/mobile/gui/SettingsActivity;->button_nik:Landroid/widget/ImageButton;

    invoke-virtual {v3, p0}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 71
    :try_start_0
    invoke-virtual {p0}, Lcom/luxury/mobile/gui/SettingsActivity;->OpenNick()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 74
    goto :goto_0

    .line 72
    :catch_0
    move-exception v3

    .line 73
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    .line 75
    .end local v3    # "e":Ljava/io/IOException;
    :goto_0
    return-void
.end method

.method public openBrowser(Landroid/view/View;)V
    .locals 2
    .param p1, "view"    # Landroid/view/View;

    .line 179
    new-instance v0, Landroid/content/Intent;

    invoke-direct {v0}, Landroid/content/Intent;-><init>()V

    .line 180
    .local v0, "intent":Landroid/content/Intent;
    const-string v1, "android.intent.action.VIEW"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    .line 181
    const-string v1, "android.intent.category.BROWSABLE"

    invoke-virtual {v0, v1}, Landroid/content/Intent;->addCategory(Ljava/lang/String;)Landroid/content/Intent;

    .line 182
    invoke-virtual {p1}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    invoke-static {v1}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/content/Intent;->setData(Landroid/net/Uri;)Landroid/content/Intent;

    .line 183
    invoke-virtual {p0, v0}, Lcom/luxury/mobile/gui/SettingsActivity;->startActivity(Landroid/content/Intent;)V

    .line 184
    return-void
.end method
