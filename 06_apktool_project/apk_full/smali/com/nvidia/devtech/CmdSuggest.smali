.class public final Lcom/nvidia/devtech/CmdSuggest;
.super Ljava/lang/Object;
.source "CmdSuggest.java"


# static fields
.field public static final COMMANDS:[Ljava/lang/String;

.field private static sEt:Landroid/widget/EditText;

.field private static sInstalled:Z

.field private static sKbHeight:I

.field private static sScroll:Landroid/widget/HorizontalScrollView;

.field private static sStrip:Landroid/widget/LinearLayout;

.field private static final sWatcher:Landroid/text/TextWatcher;

.field private static sWrap:Landroid/widget/LinearLayout;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 32
    const/16 v0, 0x1df

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "aadmins"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "abonus"

    aput-object v2, v0, v1

    const/4 v1, 0x2

    const-string v2, "acapture"

    aput-object v2, v0, v1

    const/4 v1, 0x3

    const-string v2, "acapturecd"

    aput-object v2, v0, v1

    const/4 v1, 0x4

    const-string v2, "acapturetime"

    aput-object v2, v0, v1

    const/4 v1, 0x5

    const-string v2, "achat"

    aput-object v2, v0, v1

    const/4 v1, 0x6

    const-string v2, "addzone"

    aput-object v2, v0, v1

    const/4 v1, 0x7

    const-string v2, "admin"

    aput-object v2, v0, v1

    const/16 v1, 0x8

    const-string v2, "admins"

    aput-object v2, v0, v1

    const/16 v1, 0x9

    const-string v2, "ado"

    aput-object v2, v0, v1

    const/16 v1, 0xa

    const-string v2, "advertise"

    aput-object v2, v0, v1

    const/16 v1, 0xb

    const-string v2, "afind"

    aput-object v2, v0, v1

    const/16 v1, 0xc

    const-string v2, "afklist"

    aput-object v2, v0, v1

    const/16 v1, 0xd

    const-string v2, "agm"

    aput-object v2, v0, v1

    const/16 v1, 0xe

    const-string v2, "agun"

    aput-object v2, v0, v1

    const/16 v1, 0xf

    const-string v2, "ahelp"

    aput-object v2, v0, v1

    const/16 v1, 0x10

    const-string v2, "alerts"

    aput-object v2, v0, v1

    const/16 v1, 0x11

    const-string v2, "alogin"

    aput-object v2, v0, v1

    const/16 v1, 0x12

    const-string v2, "alt"

    aput-object v2, v0, v1

    const/16 v1, 0x13

    const-string v2, "ame"

    aput-object v2, v0, v1

    const/16 v1, 0x14

    const-string v2, "anamestore"

    aput-object v2, v0, v1

    const/16 v1, 0x15

    const-string v2, "anim"

    aput-object v2, v0, v1

    const/16 v1, 0x16

    const-string v2, "ans"

    aput-object v2, v0, v1

    const/16 v1, 0x17

    const-string v2, "apanel"

    aput-object v2, v0, v1

    const/16 v1, 0x18

    const-string v2, "armpanel"

    aput-object v2, v0, v1

    const/16 v1, 0x19

    const-string v2, "arrest"

    aput-object v2, v0, v1

    const/16 v1, 0x1a

    const-string v2, "asellbiz"

    aput-object v2, v0, v1

    const/16 v1, 0x1b

    const-string v2, "asellhouse"

    aput-object v2, v0, v1

    const/16 v1, 0x1c

    const-string v2, "asetbizprod"

    aput-object v2, v0, v1

    const/16 v1, 0x1d

    const-string v2, "asettings"

    aput-object v2, v0, v1

    const/16 v1, 0x1e

    const-string v2, "ash"

    aput-object v2, v0, v1

    const/16 v1, 0x1f

    const-string v2, "atake"

    aput-object v2, v0, v1

    const/16 v1, 0x20

    const-string v2, "audience"

    aput-object v2, v0, v1

    const/16 v1, 0x21

    const-string v2, "auninvite"

    aput-object v2, v0, v1

    const/16 v1, 0x22

    const-string v2, "az"

    aput-object v2, v0, v1

    const/16 v1, 0x23

    const-string v2, "az1"

    aput-object v2, v0, v1

    const/16 v1, 0x24

    const-string v2, "azfreeze"

    aput-object v2, v0, v1

    const/16 v1, 0x25

    const-string v2, "azid"

    aput-object v2, v0, v1

    const/16 v1, 0x26

    const-string v2, "azspawn"

    aput-object v2, v0, v1

    const/16 v1, 0x27

    const-string v2, "back"

    aput-object v2, v0, v1

    const/16 v1, 0x28

    const-string v2, "ban"

    aput-object v2, v0, v1

    const/16 v1, 0x29

    const-string v2, "banhistory"

    aput-object v2, v0, v1

    const/16 v1, 0x2a

    const-string v2, "banip"

    aput-object v2, v0, v1

    const/16 v1, 0x2b

    const-string v2, "bheal"

    aput-object v2, v0, v1

    const/16 v1, 0x2c

    const-string v2, "bind"

    aput-object v2, v0, v1

    const/16 v1, 0x2d

    const-string v2, "bind2"

    aput-object v2, v0, v1

    const/16 v1, 0x2e

    const-string v2, "bizlist"

    aput-object v2, v0, v1

    const/16 v1, 0x2f

    const-string v2, "bizwar"

    aput-object v2, v0, v1

    const/16 v1, 0x30

    const-string v2, "bpanel"

    aput-object v2, v0, v1

    const/16 v1, 0x31

    const-string v2, "break"

    aput-object v2, v0, v1

    const/16 v1, 0x32

    const-string v2, "breaking"

    aput-object v2, v0, v1

    const/16 v1, 0x33

    const-string v2, "buy"

    aput-object v2, v0, v1

    const/16 v1, 0x34

    const-string v2, "buygas"

    aput-object v2, v0, v1

    const/16 v1, 0x35

    const-string v2, "buytune"

    aput-object v2, v0, v1

    const/16 v1, 0x36

    const-string v2, "call"

    aput-object v2, v0, v1

    const/16 v1, 0x37

    const-string v2, "capto"

    aput-object v2, v0, v1

    const/16 v1, 0x38

    const-string v2, "captstats"

    aput-object v2, v0, v1

    const/16 v1, 0x39

    const-string v2, "capture"

    aput-object v2, v0, v1

    const/16 v1, 0x3a

    const-string v2, "capturecd"

    aput-object v2, v0, v1

    const/16 v1, 0x3b

    const-string v2, "capturetime"

    aput-object v2, v0, v1

    const/16 v1, 0x3c

    const-string v2, "carmenu"

    aput-object v2, v0, v1

    const/16 v1, 0x3d

    const-string v2, "cas"

    aput-object v2, v0, v1

    const/16 v1, 0x3e

    const-string v2, "ccport"

    aput-object v2, v0, v1

    const/16 v1, 0x3f

    const-string v2, "cellar"

    aput-object v2, v0, v1

    const/16 v1, 0x40

    const-string v2, "cellarlock"

    aput-object v2, v0, v1

    const/16 v1, 0x41

    const-string v2, "cellarmenu"

    aput-object v2, v0, v1

    const/16 v1, 0x42

    const-string v2, "ch"

    aput-object v2, v0, v1

    const/16 v1, 0x43

    const-string v2, "changeapassword"

    aput-object v2, v0, v1

    const/16 v1, 0x44

    const-string v2, "changehouse"

    aput-object v2, v0, v1

    const/16 v1, 0x45

    const-string v2, "changeservername"

    aput-object v2, v0, v1

    const/16 v1, 0x46

    const-string v2, "changeskin"

    aput-object v2, v0, v1

    const/16 v1, 0x47

    const-string v2, "checkip"

    aput-object v2, v0, v1

    const/16 v1, 0x48

    const-string v2, "clear"

    aput-object v2, v0, v1

    const/16 v1, 0x49

    const-string v2, "clearchat"

    aput-object v2, v0, v1

    const/16 v1, 0x4a

    const-string v2, "clearsd"

    aput-object v2, v0, v1

    const/16 v1, 0x4b

    const-string v2, "cmenu"

    aput-object v2, v0, v1

    const/16 v1, 0x4c

    const-string v2, "coin"

    aput-object v2, v0, v1

    const/16 v1, 0x4d

    const-string v2, "commands"

    aput-object v2, v0, v1

    const/16 v1, 0x4e

    const-string v2, "comp"

    aput-object v2, v0, v1

    const/16 v1, 0x4f

    const-string v2, "connections"

    aput-object v2, v0, v1

    const/16 v1, 0x50

    const-string v2, "cover"

    aput-object v2, v0, v1

    const/16 v1, 0x51

    const-string v2, "crashgame"

    aput-object v2, v0, v1

    const/16 v1, 0x52

    const-string v2, "createarea"

    aput-object v2, v0, v1

    const/16 v1, 0x53

    const-string v2, "createbusiness"

    aput-object v2, v0, v1

    const/16 v1, 0x54

    const-string v2, "createcellar"

    aput-object v2, v0, v1

    const/16 v1, 0x55

    const-string v2, "createfarm"

    aput-object v2, v0, v1

    const/16 v1, 0x56

    const-string v2, "createfvehicle"

    aput-object v2, v0, v1

    const/16 v1, 0x57

    const-string v2, "createhouse"

    aput-object v2, v0, v1

    const/16 v1, 0x58

    const-string v2, "createservervehicle"

    aput-object v2, v0, v1

    const/16 v1, 0x59

    const-string v2, "cuff"

    aput-object v2, v0, v1

    const/16 v1, 0x5a

    const-string v2, "d"

    aput-object v2, v0, v1

    const/16 v1, 0x5b

    const-string v2, "debtors"

    aput-object v2, v0, v1

    const/16 v1, 0x5c

    const-string v2, "delacc"

    aput-object v2, v0, v1

    const/16 v1, 0x5d

    const-string v2, "deletegun"

    aput-object v2, v0, v1

    const/16 v1, 0x5e

    const-string v2, "delivery"

    aput-object v2, v0, v1

    const/16 v1, 0x5f

    const-string v2, "delveh"

    aput-object v2, v0, v1

    const/16 v1, 0x60

    const-string v2, "demote"

    aput-object v2, v0, v1

    const/16 v1, 0x61

    const-string v2, "destroycar"

    aput-object v2, v0, v1

    const/16 v1, 0x62

    const-string v2, "destroylag"

    aput-object v2, v0, v1

    const/16 v1, 0x63

    const-string v2, "destroyveh"

    aput-object v2, v0, v1

    const/16 v1, 0x64

    const-string v2, "dgun"

    aput-object v2, v0, v1

    const/16 v1, 0x65

    const-string v2, "diplomacy"

    aput-object v2, v0, v1

    const/16 v1, 0x66

    const-string v2, "dir"

    aput-object v2, v0, v1

    const/16 v1, 0x67

    const-string v2, "dmexit"

    aput-object v2, v0, v1

    const/16 v1, 0x68

    const-string v2, "dmgstat"

    aput-object v2, v0, v1

    const/16 v1, 0x69

    const-string v2, "do"

    aput-object v2, v0, v1

    const/16 v1, 0x6a

    const-string v2, "donate"

    aput-object v2, v0, v1

    const/16 v1, 0x6b

    const-string v2, "dropdrugs"

    aput-object v2, v0, v1

    const/16 v1, 0x6c

    const-string v2, "dsvip"

    aput-object v2, v0, v1

    const/16 v1, 0x6d

    const-string v2, "ears"

    aput-object v2, v0, v1

    const/16 v1, 0x6e

    const-string v2, "economy"

    aput-object v2, v0, v1

    const/16 v1, 0x6f

    const-string v2, "edit"

    aput-object v2, v0, v1

    const/16 v1, 0x70

    const-string v2, "eject"

    aput-object v2, v0, v1

    const/16 v1, 0x71

    const-string v2, "election"

    aput-object v2, v0, v1

    const/16 v1, 0x72

    const-string v2, "en"

    aput-object v2, v0, v1

    const/16 v1, 0x73

    const-string v2, "end"

    aput-object v2, v0, v1

    const/16 v1, 0x74

    const-string v2, "endarea"

    aput-object v2, v0, v1

    const/16 v1, 0x75

    const-string v2, "endd"

    aput-object v2, v0, v1

    const/16 v1, 0x76

    const-string v2, "entertr"

    aput-object v2, v0, v1

    const/16 v1, 0x77

    const-string v2, "ether"

    aput-object v2, v0, v1

    const/16 v1, 0x78

    const-string v2, "event"

    aput-object v2, v0, v1

    const/16 v1, 0x79

    const-string v2, "exit"

    aput-object v2, v0, v1

    const/16 v1, 0x7a

    const-string v2, "exitpaint"

    aput-object v2, v0, v1

    const/16 v1, 0x7b

    const-string v2, "exitrace"

    aput-object v2, v0, v1

    const/16 v1, 0x7c

    const-string v2, "exittr"

    aput-object v2, v0, v1

    const/16 v1, 0x7d

    const-string v2, "f"

    aput-object v2, v0, v1

    const/16 v1, 0x7e

    const-string v2, "fam"

    aput-object v2, v0, v1

    const/16 v1, 0x7f

    const-string v2, "fcontract"

    aput-object v2, v0, v1

    const/16 v1, 0x80

    const-string v2, "ff"

    aput-object v2, v0, v1

    const/16 v1, 0x81

    const-string v2, "ffind"

    aput-object v2, v0, v1

    const/16 v1, 0x82

    const-string v2, "ffixcar"

    aput-object v2, v0, v1

    const/16 v1, 0x83

    const-string v2, "fill"

    aput-object v2, v0, v1

    const/16 v1, 0x84

    const-string v2, "find"

    aput-object v2, v0, v1

    const/16 v1, 0x85

    const-string v2, "finvite"

    aput-object v2, v0, v1

    const/16 v1, 0x86

    const-string v2, "firework"

    aput-object v2, v0, v1

    const/16 v1, 0x87

    const-string v2, "fixcar"

    aput-object v2, v0, v1

    const/16 v1, 0x88

    const-string v2, "fleave"

    aput-object v2, v0, v1

    const/16 v1, 0x89

    const-string v2, "flip"

    aput-object v2, v0, v1

    const/16 v1, 0x8a

    const-string v2, "flock"

    aput-object v2, v0, v1

    const/16 v1, 0x8b

    const-string v2, "flymode"

    aput-object v2, v0, v1

    const/16 v1, 0x8c

    const-string v2, "flymods"

    aput-object v2, v0, v1

    const/16 v1, 0x8d

    const-string v2, "fmembers"

    aput-object v2, v0, v1

    const/16 v1, 0x8e

    const-string v2, "fmute"

    aput-object v2, v0, v1

    const/16 v1, 0x8f

    const-string v2, "fn"

    aput-object v2, v0, v1

    const/16 v1, 0x90

    const-string v2, "foffmembers"

    aput-object v2, v0, v1

    const/16 v1, 0x91

    const-string v2, "frank"

    aput-object v2, v0, v1

    const/16 v1, 0x92

    const-string v2, "free"

    aput-object v2, v0, v1

    const/16 v1, 0x93

    const-string v2, "freeze"

    aput-object v2, v0, v1

    const/16 v1, 0x94

    const-string v2, "freezepanel"

    aput-object v2, v0, v1

    const/16 v1, 0x95

    const-string v2, "frisk"

    aput-object v2, v0, v1

    const/16 v1, 0x96

    const-string v2, "fsafe"

    aput-object v2, v0, v1

    const/16 v1, 0x97

    const-string v2, "fsellcar"

    aput-object v2, v0, v1

    const/16 v1, 0x98

    const-string v2, "fso"

    aput-object v2, v0, v1

    const/16 v1, 0x99

    const-string v2, "fspawnchange"

    aput-object v2, v0, v1

    const/16 v1, 0x9a

    const-string v2, "fstyle"

    aput-object v2, v0, v1

    const/16 v1, 0x9b

    const-string v2, "funinvite"

    aput-object v2, v0, v1

    const/16 v1, 0x9c

    const-string v2, "funmute"

    aput-object v2, v0, v1

    const/16 v1, 0x9d

    const-string v2, "funwarn"

    aput-object v2, v0, v1

    const/16 v1, 0x9e

    const-string v2, "fv"

    aput-object v2, v0, v1

    const/16 v1, 0x9f

    const-string v2, "fwarn"

    aput-object v2, v0, v1

    const/16 v1, 0xa0

    const-string v2, "ganginfo"

    aput-object v2, v0, v1

    const/16 v1, 0xa1

    const-string v2, "ganglist"

    aput-object v2, v0, v1

    const/16 v1, 0xa2

    const-string v2, "gangtop"

    aput-object v2, v0, v1

    const/16 v1, 0xa3

    const-string v2, "garage"

    aput-object v2, v0, v1

    const/16 v1, 0xa4

    const-string v2, "general"

    aput-object v2, v0, v1

    const/16 v1, 0xa5

    const-string v2, "get"

    aput-object v2, v0, v1

    const/16 v1, 0xa6

    const-string v2, "getadminstats"

    aput-object v2, v0, v1

    const/16 v1, 0xa7

    const-string v2, "getclient"

    aput-object v2, v0, v1

    const/16 v1, 0xa8

    const-string v2, "getdrugs"

    aput-object v2, v0, v1

    const/16 v1, 0xa9

    const-string v2, "gethere"

    aput-object v2, v0, v1

    const/16 v1, 0xaa

    const-string v2, "gethereveh"

    aput-object v2, v0, v1

    const/16 v1, 0xab

    const-string v2, "getip"

    aput-object v2, v0, v1

    const/16 v1, 0xac

    const-string v2, "getskill"

    aput-object v2, v0, v1

    const/16 v1, 0xad

    const-string v2, "gettoken"

    aput-object v2, v0, v1

    const/16 v1, 0xae

    const-string v2, "giveammo"

    aput-object v2, v0, v1

    const/16 v1, 0xaf

    const-string v2, "givedonate"

    aput-object v2, v0, v1

    const/16 v1, 0xb0

    const-string v2, "givedrugs"

    aput-object v2, v0, v1

    const/16 v1, 0xb1

    const-string v2, "givegun"

    aput-object v2, v0, v1

    const/16 v1, 0xb2

    const-string v2, "giveguns"

    aput-object v2, v0, v1

    const/16 v1, 0xb3

    const-string v2, "givelevel"

    aput-object v2, v0, v1

    const/16 v1, 0xb4

    const-string v2, "givelic"

    aput-object v2, v0, v1

    const/16 v1, 0xb5

    const-string v2, "givemc"

    aput-object v2, v0, v1

    const/16 v1, 0xb6

    const-string v2, "givemoney"

    aput-object v2, v0, v1

    const/16 v1, 0xb7

    const-string v2, "givemoneytoall"

    aput-object v2, v0, v1

    const/16 v1, 0xb8

    const-string v2, "giverank"

    aput-object v2, v0, v1

    const/16 v1, 0xb9

    const-string v2, "giveskill"

    aput-object v2, v0, v1

    const/16 v1, 0xba

    const-string v2, "givevkey"

    aput-object v2, v0, v1

    const/16 v1, 0xbb

    const-string v2, "gmcheck"

    aput-object v2, v0, v1

    const/16 v1, 0xbc

    const-string v2, "gomechanic"

    aput-object v2, v0, v1

    const/16 v1, 0xbd

    const-string v2, "gomedhelp"

    aput-object v2, v0, v1

    const/16 v1, 0xbe

    const-string v2, "gomp"

    aput-object v2, v0, v1

    const/16 v1, 0xbf

    const-string v2, "gompmap"

    aput-object v2, v0, v1

    const/16 v1, 0xc0

    const-string v2, "gopolice"

    aput-object v2, v0, v1

    const/16 v1, 0xc1

    const-string v2, "gotaxi"

    aput-object v2, v0, v1

    const/16 v1, 0xc2

    const-string v2, "goto"

    aput-object v2, v0, v1

    const/16 v1, 0xc3

    const-string v2, "gotobiz"

    aput-object v2, v0, v1

    const/16 v1, 0xc4

    const-string v2, "gotohint"

    aput-object v2, v0, v1

    const/16 v1, 0xc5

    const-string v2, "gotohouse"

    aput-object v2, v0, v1

    const/16 v1, 0xc6

    const-string v2, "gotoint"

    aput-object v2, v0, v1

    const/16 v1, 0xc7

    const-string v2, "gotome"

    aput-object v2, v0, v1

    const/16 v1, 0xc8

    const-string v2, "gotopos"

    aput-object v2, v0, v1

    const/16 v1, 0xc9

    const-string v2, "gotoveh"

    aput-object v2, v0, v1

    const/16 v1, 0xca

    const-string v2, "gotovw"

    aput-object v2, v0, v1

    const/16 v1, 0xcb

    const-string v2, "gov"

    aput-object v2, v0, v1

    const/16 v1, 0xcc

    const-string v2, "gplayurl"

    aput-object v2, v0, v1

    const/16 v1, 0xcd

    const-string v2, "gps"

    aput-object v2, v0, v1

    const/16 v1, 0xce

    const-string v2, "gun"

    aput-object v2, v0, v1

    const/16 v1, 0xcf

    const-string v2, "gzid"

    aput-object v2, v0, v1

    const/16 v1, 0xd0

    const-string v2, "gzowner"

    aput-object v2, v0, v1

    const/16 v1, 0xd1

    const-string v2, "gzspawn"

    aput-object v2, v0, v1

    const/16 v1, 0xd2

    const-string v2, "h"

    aput-object v2, v0, v1

    const/16 v1, 0xd3

    const-string v2, "heal"

    aput-object v2, v0, v1

    const/16 v1, 0xd4

    const-string v2, "healme"

    aput-object v2, v0, v1

    const/16 v1, 0xd5

    const-string v2, "help"

    aput-object v2, v0, v1

    const/16 v1, 0xd6

    const-string v2, "hgarage"

    aput-object v2, v0, v1

    const/16 v1, 0xd7

    const-string v2, "hheal"

    aput-object v2, v0, v1

    const/16 v1, 0xd8

    const-string v2, "hleave"

    aput-object v2, v0, v1

    const/16 v1, 0xd9

    const-string v2, "hlock"

    aput-object v2, v0, v1

    const/16 v1, 0xda

    const-string v2, "hmenu"

    aput-object v2, v0, v1

    const/16 v1, 0xdb

    const-string v2, "home"

    aput-object v2, v0, v1

    const/16 v1, 0xdc

    const-string v2, "hp"

    aput-object v2, v0, v1

    const/16 v1, 0xdd

    const-string v2, "hradio"

    aput-object v2, v0, v1

    const/16 v1, 0xde

    const-string v2, "iban"

    aput-object v2, v0, v1

    const/16 v1, 0xdf

    const-string v2, "id"

    aput-object v2, v0, v1

    const/16 v1, 0xe0

    const-string v2, "incas"

    aput-object v2, v0, v1

    const/16 v1, 0xe1

    const-string v2, "inter"

    aput-object v2, v0, v1

    const/16 v1, 0xe2

    const-string v2, "intlist"

    aput-object v2, v0, v1

    const/16 v1, 0xe3

    const-string v2, "inventory"

    aput-object v2, v0, v1

    const/16 v1, 0xe4

    const-string v2, "invite"

    aput-object v2, v0, v1

    const/16 v1, 0xe5

    const-string v2, "ipaccounts"

    aput-object v2, v0, v1

    const/16 v1, 0xe6

    const-string v2, "ipdata"

    aput-object v2, v0, v1

    const/16 v1, 0xe7

    const-string v2, "iwep"

    aput-object v2, v0, v1

    const/16 v1, 0xe8

    const-string v2, "jack"

    aput-object v2, v0, v1

    const/16 v1, 0xe9

    const-string v2, "jail"

    aput-object v2, v0, v1

    const/16 v1, 0xea

    const-string v2, "joblist"

    aput-object v2, v0, v1

    const/16 v1, 0xeb

    const-string v2, "jp"

    aput-object v2, v0, v1

    const/16 v1, 0xec

    const-string v2, "k"

    aput-object v2, v0, v1

    const/16 v1, 0xed

    const-string v2, "kick"

    aput-object v2, v0, v1

    const/16 v1, 0xee

    const-string v2, "kickout"

    aput-object v2, v0, v1

    const/16 v1, 0xef

    const-string v2, "kiss"

    aput-object v2, v0, v1

    const/16 v1, 0xf0

    const-string v2, "konch"

    aput-object v2, v0, v1

    const/16 v1, 0xf1

    const-string v2, "leaders"

    aput-object v2, v0, v1

    const/16 v1, 0xf2

    const-string v2, "leave"

    aput-object v2, v0, v1

    const/16 v1, 0xf3

    const-string v2, "lic"

    aput-object v2, v0, v1

    const/16 v1, 0xf4

    const-string v2, "licenses"

    aput-object v2, v0, v1

    const/16 v1, 0xf5

    const-string v2, "light"

    aput-object v2, v0, v1

    const/16 v1, 0xf6

    const-string v2, "lk"

    aput-object v2, v0, v1

    const/16 v1, 0xf7

    const-string v2, "lkr"

    aput-object v2, v0, v1

    const/16 v1, 0xf8

    const-string v2, "lmenu"

    aput-object v2, v0, v1

    const/16 v1, 0xf9

    const-string v2, "locktr"

    aput-object v2, v0, v1

    const/16 v1, 0xfa

    const-string v2, "logs"

    aput-object v2, v0, v1

    const/16 v1, 0xfb

    const-string v2, "m"

    aput-object v2, v0, v1

    const/16 v1, 0xfc

    const-string v2, "mafiainfo"

    aput-object v2, v0, v1

    const/16 v1, 0xfd

    const-string v2, "mafiatop"

    aput-object v2, v0, v1

    const/16 v1, 0xfe

    const-string v2, "makeadmin"

    aput-object v2, v0, v1

    const/16 v1, 0xff

    const-string v2, "makegun"

    aput-object v2, v0, v1

    const/16 v1, 0x100

    const-string v2, "makeleader"

    aput-object v2, v0, v1

    const/16 v1, 0x101

    const-string v2, "mapstealer"

    aput-object v2, v0, v1

    const/16 v1, 0x102

    const-string v2, "mask"

    aput-object v2, v0, v1

    const/16 v1, 0x103

    const-string v2, "me"

    aput-object v2, v0, v1

    const/16 v1, 0x104

    const-string v2, "mech"

    aput-object v2, v0, v1

    const/16 v1, 0x105

    const-string v2, "med"

    aput-object v2, v0, v1

    const/16 v1, 0x106

    const-string v2, "mhj"

    aput-object v2, v0, v1

    const/16 v1, 0x107

    const-string v2, "mm"

    aput-object v2, v0, v1

    const/16 v1, 0x108

    const-string v2, "money"

    aput-object v2, v0, v1

    const/16 v1, 0x109

    const-string v2, "moneylog"

    aput-object v2, v0, v1

    const/16 v1, 0x10a

    const-string v2, "mpanel"

    aput-object v2, v0, v1

    const/16 v1, 0x10b

    const-string v2, "msg"

    aput-object v2, v0, v1

    const/16 v1, 0x10c

    const-string v2, "mute"

    aput-object v2, v0, v1

    const/16 v1, 0x10d

    const-string v2, "mutelist"

    aput-object v2, v0, v1

    const/16 v1, 0x10e

    const-string v2, "mych"

    aput-object v2, v0, v1

    const/16 v1, 0x10f

    const-string v2, "mykiosk"

    aput-object v2, v0, v1

    const/16 v1, 0x110

    const-string v2, "mypos"

    aput-object v2, v0, v1

    const/16 v1, 0x111

    const-string v2, "myskill"

    aput-object v2, v0, v1

    const/16 v1, 0x112

    const-string v2, "myviptime"

    aput-object v2, v0, v1

    const/16 v1, 0x113

    const-string v2, "mywarn"

    aput-object v2, v0, v1

    const/16 v1, 0x114

    const-string v2, "n"

    aput-object v2, v0, v1

    const/16 v1, 0x115

    const-string v2, "namestore"

    aput-object v2, v0, v1

    const/16 v1, 0x116

    const-string v2, "newcapt"

    aput-object v2, v0, v1

    const/16 v1, 0x117

    const-string v2, "newend"

    aput-object v2, v0, v1

    const/16 v1, 0x118

    const-string v2, "newveh"

    aput-object v2, v0, v1

    const/16 v1, 0x119

    const-string v2, "nik"

    aput-object v2, v0, v1

    const/16 v1, 0x11a

    const-string v2, "nmenu"

    aput-object v2, v0, v1

    const/16 v1, 0x11b

    const-string v2, "nn"

    aput-object v2, v0, v1

    const/16 v1, 0x11c

    const-string v2, "number"

    aput-object v2, v0, v1

    const/16 v1, 0x11d

    const-string v2, "numether"

    aput-object v2, v0, v1

    const/16 v1, 0x11e

    const-string v2, "offban"

    aput-object v2, v0, v1

    const/16 v1, 0x11f

    const-string v2, "offcas"

    aput-object v2, v0, v1

    const/16 v1, 0x120

    const-string v2, "offget"

    aput-object v2, v0, v1

    const/16 v1, 0x121

    const-string v2, "offjail"

    aput-object v2, v0, v1

    const/16 v1, 0x122

    const-string v2, "offleader"

    aput-object v2, v0, v1

    const/16 v1, 0x123

    const-string v2, "offleaders"

    aput-object v2, v0, v1

    const/16 v1, 0x124

    const-string v2, "offmoneylog"

    aput-object v2, v0, v1

    const/16 v1, 0x125

    const-string v2, "offmute"

    aput-object v2, v0, v1

    const/16 v1, 0x126

    const-string v2, "offsetvip"

    aput-object v2, v0, v1

    const/16 v1, 0x127

    const-string v2, "offstats"

    aput-object v2, v0, v1

    const/16 v1, 0x128

    const-string v2, "offuninvite"

    aput-object v2, v0, v1

    const/16 v1, 0x129

    const-string v2, "offwarn"

    aput-object v2, v0, v1

    const/16 v1, 0x12a

    const-string v2, "okay"

    aput-object v2, v0, v1

    const/16 v1, 0x12b

    const-string v2, "ooc"

    aput-object v2, v0, v1

    const/16 v1, 0x12c

    const-string v2, "oosami"

    aput-object v2, v0, v1

    const/16 v1, 0x12d

    const-string v2, "orglist"

    aput-object v2, v0, v1

    const/16 v1, 0x12e

    const-string v2, "p"

    aput-object v2, v0, v1

    const/16 v1, 0x12f

    const-string v2, "park"

    aput-object v2, v0, v1

    const/16 v1, 0x130

    const-string v2, "pass"

    aput-object v2, v0, v1

    const/16 v1, 0x131

    const-string v2, "pay"

    aput-object v2, v0, v1

    const/16 v1, 0x132

    const-string v2, "paydaysami"

    aput-object v2, v0, v1

    const/16 v1, 0x133

    const-string v2, "paygang"

    aput-object v2, v0, v1

    const/16 v1, 0x134

    const-string v2, "pgun"

    aput-object v2, v0, v1

    const/16 v1, 0x135

    const-string v2, "phone"

    aput-object v2, v0, v1

    const/16 v1, 0x136

    const-string v2, "pm"

    aput-object v2, v0, v1

    const/16 v1, 0x137

    const-string v2, "ps"

    aput-object v2, v0, v1

    const/16 v1, 0x138

    const-string v2, "pts"

    aput-object v2, v0, v1

    const/16 v1, 0x139

    const-string v2, "push"

    aput-object v2, v0, v1

    const/16 v1, 0x13a

    const-string v2, "pveh"

    aput-object v2, v0, v1

    const/16 v1, 0x13b

    const-string v2, "quitjob"

    aput-object v2, v0, v1

    const/16 v1, 0x13c

    const-string v2, "r"

    aput-object v2, v0, v1

    const/16 v1, 0x13d

    const-string v2, "radar"

    aput-object v2, v0, v1

    const/16 v1, 0x13e

    const-string v2, "radio"

    aput-object v2, v0, v1

    const/16 v1, 0x13f

    const-string v2, "ram"

    aput-object v2, v0, v1

    const/16 v1, 0x140

    const-string v2, "referals"

    aput-object v2, v0, v1

    const/16 v1, 0x141

    const-string v2, "refill"

    aput-object v2, v0, v1

    const/16 v1, 0x142

    const-string v2, "renthome"

    aput-object v2, v0, v1

    const/16 v1, 0x143

    const-string v2, "repair"

    aput-object v2, v0, v1

    const/16 v1, 0x144

    const-string v2, "repairkit"

    aput-object v2, v0, v1

    const/16 v1, 0x145

    const-string v2, "report"

    aput-object v2, v0, v1

    const/16 v1, 0x146

    const-string v2, "resetweapon"

    aput-object v2, v0, v1

    const/16 v1, 0x147

    const-string v2, "returntr"

    aput-object v2, v0, v1

    const/16 v1, 0x148

    const-string v2, "rlk"

    aput-object v2, v0, v1

    const/16 v1, 0x149

    const-string v2, "rn"

    aput-object v2, v0, v1

    const/16 v1, 0x14a

    const-string v2, "robbank10"

    aput-object v2, v0, v1

    const/16 v1, 0x14b

    const-string v2, "robbank11"

    aput-object v2, v0, v1

    const/16 v1, 0x14c

    const-string v2, "robbank2"

    aput-object v2, v0, v1

    const/16 v1, 0x14d

    const-string v2, "robbank3"

    aput-object v2, v0, v1

    const/16 v1, 0x14e

    const-string v2, "robbank4"

    aput-object v2, v0, v1

    const/16 v1, 0x14f

    const-string v2, "robbank5"

    aput-object v2, v0, v1

    const/16 v1, 0x150

    const-string v2, "robbank6"

    aput-object v2, v0, v1

    const/16 v1, 0x151

    const-string v2, "robbank7"

    aput-object v2, v0, v1

    const/16 v1, 0x152

    const-string v2, "robbank8"

    aput-object v2, v0, v1

    const/16 v1, 0x153

    const-string v2, "robbank9"

    aput-object v2, v0, v1

    const/16 v1, 0x154

    const-string v2, "route"

    aput-object v2, v0, v1

    const/16 v1, 0x155

    const-string v2, "rr"

    aput-object v2, v0, v1

    const/16 v1, 0x156

    const-string v2, "s"

    aput-object v2, v0, v1

    const/16 v1, 0x157

    const-string v2, "sban"

    aput-object v2, v0, v1

    const/16 v1, 0x158

    const-string v2, "sclose"

    aput-object v2, v0, v1

    const/16 v1, 0x159

    const-string v2, "sd"

    aput-object v2, v0, v1

    const/16 v1, 0x15a

    const-string v2, "search"

    aput-object v2, v0, v1

    const/16 v1, 0x15b

    const-string v2, "sellbiz"

    aput-object v2, v0, v1

    const/16 v1, 0x15c

    const-string v2, "sellcar"

    aput-object v2, v0, v1

    const/16 v1, 0x15d

    const-string v2, "selldrugs"

    aput-object v2, v0, v1

    const/16 v1, 0x15e

    const-string v2, "sellgun"

    aput-object v2, v0, v1

    const/16 v1, 0x15f

    const-string v2, "sellgunlic"

    aput-object v2, v0, v1

    const/16 v1, 0x160

    const-string v2, "sellhouse"

    aput-object v2, v0, v1

    const/16 v1, 0x161

    const-string v2, "sellsim"

    aput-object v2, v0, v1

    const/16 v1, 0x162

    const-string v2, "selltrailer"

    aput-object v2, v0, v1

    const/16 v1, 0x163

    const-string v2, "sellzone"

    aput-object v2, v0, v1

    const/16 v1, 0x164

    const-string v2, "service"

    aput-object v2, v0, v1

    const/16 v1, 0x165

    const-string v2, "setbmoney"

    aput-object v2, v0, v1

    const/16 v1, 0x166

    const-string v2, "setbproduct"

    aput-object v2, v0, v1

    const/16 v1, 0x167

    const-string v2, "setbskin"

    aput-object v2, v0, v1

    const/16 v1, 0x168

    const-string v2, "setfvehiclecolor"

    aput-object v2, v0, v1

    const/16 v1, 0x169

    const-string v2, "setfvehiclemodel"

    aput-object v2, v0, v1

    const/16 v1, 0x16a

    const-string v2, "setfvehiclepos"

    aput-object v2, v0, v1

    const/16 v1, 0x16b

    const-string v2, "setgps"

    aput-object v2, v0, v1

    const/16 v1, 0x16c

    const-string v2, "sethouseclass"

    aput-object v2, v0, v1

    const/16 v1, 0x16d

    const-string v2, "sethunger"

    aput-object v2, v0, v1

    const/16 v1, 0x16e

    const-string v2, "setmoneyhouse"

    aput-object v2, v0, v1

    const/16 v1, 0x16f

    const-string v2, "setpc"

    aput-object v2, v0, v1

    const/16 v1, 0x170

    const-string v2, "setskin"

    aput-object v2, v0, v1

    const/16 v1, 0x171

    const-string v2, "settime"

    aput-object v2, v0, v1

    const/16 v1, 0x172

    const-string v2, "setvip"

    aput-object v2, v0, v1

    const/16 v1, 0x173

    const-string v2, "setwarehouse"

    aput-object v2, v0, v1

    const/16 v1, 0x174

    const-string v2, "setweather"

    aput-object v2, v0, v1

    const/16 v1, 0x175

    const-string v2, "sety"

    aput-object v2, v0, v1

    const/16 v1, 0x176

    const-string v2, "setyoutube"

    aput-object v2, v0, v1

    const/16 v1, 0x177

    const-string v2, "sf"

    aput-object v2, v0, v1

    const/16 v1, 0x178

    const-string v2, "siren"

    aput-object v2, v0, v1

    const/16 v1, 0x179

    const-string v2, "sitdown"

    aput-object v2, v0, v1

    const/16 v1, 0x17a

    const-string v2, "skick"

    aput-object v2, v0, v1

    const/16 v1, 0x17b

    const-string v2, "skill"

    aput-object v2, v0, v1

    const/16 v1, 0x17c

    const-string v2, "skin"

    aput-object v2, v0, v1

    const/16 v1, 0x17d

    const-string v2, "skipmiss"

    aput-object v2, v0, v1

    const/16 v1, 0x17e

    const-string v2, "slap"

    aput-object v2, v0, v1

    const/16 v1, 0x17f

    const-string v2, "sleep"

    aput-object v2, v0, v1

    const/16 v1, 0x180

    const-string v2, "sms"

    aput-object v2, v0, v1

    const/16 v1, 0x181

    const-string v2, "sopen"

    aput-object v2, v0, v1

    const/16 v1, 0x182

    const-string v2, "sp"

    aput-object v2, v0, v1

    const/16 v1, 0x183

    const-string v2, "spawn"

    aput-object v2, v0, v1

    const/16 v1, 0x184

    const-string v2, "spawnchange"

    aput-object v2, v0, v1

    const/16 v1, 0x185

    const-string v2, "spawnopen"

    aput-object v2, v0, v1

    const/16 v1, 0x186

    const-string v2, "spawntoall"

    aput-object v2, v0, v1

    const/16 v1, 0x187

    const-string v2, "spback"

    aput-object v2, v0, v1

    const/16 v1, 0x188

    const-string v2, "spcar"

    aput-object v2, v0, v1

    const/16 v1, 0x189

    const-string v2, "spcarid"

    aput-object v2, v0, v1

    const/16 v1, 0x18a

    const-string v2, "spcartime"

    aput-object v2, v0, v1

    const/16 v1, 0x18b

    const-string v2, "spoff"

    aput-object v2, v0, v1

    const/16 v1, 0x18c

    const-string v2, "ssf"

    aput-object v2, v0, v1

    const/16 v1, 0x18d

    const-string v2, "startmp"

    aput-object v2, v0, v1

    const/16 v1, 0x18e

    const-string v2, "startpaint"

    aput-object v2, v0, v1

    const/16 v1, 0x18f

    const-string v2, "startrace"

    aput-object v2, v0, v1

    const/16 v1, 0x190

    const-string v2, "stats"

    aput-object v2, v0, v1

    const/16 v1, 0x191

    const-string v2, "stopmp"

    aput-object v2, v0, v1

    const/16 v1, 0x192

    const-string v2, "stoprent"

    aput-object v2, v0, v1

    const/16 v1, 0x193

    const-string v2, "su"

    aput-object v2, v0, v1

    const/16 v1, 0x194

    const-string v2, "take"

    aput-object v2, v0, v1

    const/16 v1, 0x195

    const-string v2, "takevkey"

    aput-object v2, v0, v1

    const/16 v1, 0x196

    const-string v2, "taskill"

    aput-object v2, v0, v1

    const/16 v1, 0x197

    const-string v2, "taxi"

    aput-object v2, v0, v1

    const/16 v1, 0x198

    const-string v2, "templeader"

    aput-object v2, v0, v1

    const/16 v1, 0x199

    const-string v2, "test"

    aput-object v2, v0, v1

    const/16 v1, 0x19a

    const-string v2, "texit"

    aput-object v2, v0, v1

    const/16 v1, 0x19b

    const-string v2, "ticket"

    aput-object v2, v0, v1

    const/16 v1, 0x19c

    const-string v2, "tickets"

    aput-object v2, v0, v1

    const/16 v1, 0x19d

    const-string v2, "tie"

    aput-object v2, v0, v1

    const/16 v1, 0x19e

    const-string v2, "time"

    aput-object v2, v0, v1

    const/16 v1, 0x19f

    const-string v2, "timecar"

    aput-object v2, v0, v1

    const/16 v1, 0x1a0

    const-string v2, "todo"

    aput-object v2, v0, v1

    const/16 v1, 0x1a1

    const-string v2, "togphone"

    aput-object v2, v0, v1

    const/16 v1, 0x1a2

    const-string v2, "tp"

    aput-object v2, v0, v1

    const/16 v1, 0x1a3

    const-string v2, "tpanel"

    aput-object v2, v0, v1

    const/16 v1, 0x1a4

    const-string v2, "tphone"

    aput-object v2, v0, v1

    const/16 v1, 0x1a5

    const-string v2, "tr"

    aput-object v2, v0, v1

    const/16 v1, 0x1a6

    const-string v2, "try"

    aput-object v2, v0, v1

    const/16 v1, 0x1a7

    const-string v2, "tskill"

    aput-object v2, v0, v1

    const/16 v1, 0x1a8

    const-string v2, "tz"

    aput-object v2, v0, v1

    const/16 v1, 0x1a9

    const-string v2, "u"

    aput-object v2, v0, v1

    const/16 v1, 0x1aa

    const-string v2, "unban"

    aput-object v2, v0, v1

    const/16 v1, 0x1ab

    const-string v2, "unbanip"

    aput-object v2, v0, v1

    const/16 v1, 0x1ac

    const-string v2, "uncas"

    aput-object v2, v0, v1

    const/16 v1, 0x1ad

    const-string v2, "uncover"

    aput-object v2, v0, v1

    const/16 v1, 0x1ae

    const-string v2, "uncuff"

    aput-object v2, v0, v1

    const/16 v1, 0x1af

    const-string v2, "unfreeze"

    aput-object v2, v0, v1

    const/16 v1, 0x1b0

    const-string v2, "uninvite"

    aput-object v2, v0, v1

    const/16 v1, 0x1b1

    const-string v2, "unjail"

    aput-object v2, v0, v1

    const/16 v1, 0x1b2

    const-string v2, "unload"

    aput-object v2, v0, v1

    const/16 v1, 0x1b3

    const-string v2, "unmakeleader"

    aput-object v2, v0, v1

    const/16 v1, 0x1b4

    const-string v2, "unmask"

    aput-object v2, v0, v1

    const/16 v1, 0x1b5

    const-string v2, "unmute"

    aput-object v2, v0, v1

    const/16 v1, 0x1b6

    const-string v2, "untie"

    aput-object v2, v0, v1

    const/16 v1, 0x1b7

    const-string v2, "unwarblock"

    aput-object v2, v0, v1

    const/16 v1, 0x1b8

    const-string v2, "unwarn"

    aput-object v2, v0, v1

    const/16 v1, 0x1b9

    const-string v2, "unwarnoff"

    aput-object v2, v0, v1

    const/16 v1, 0x1ba

    const-string v2, "unyoutube"

    aput-object v2, v0, v1

    const/16 v1, 0x1bb

    const-string v2, "updorms"

    aput-object v2, v0, v1

    const/16 v1, 0x1bc

    const-string v2, "usecan"

    aput-object v2, v0, v1

    const/16 v1, 0x1bd

    const-string v2, "usedrugs"

    aput-object v2, v0, v1

    const/16 v1, 0x1be

    const-string v2, "vacancy"

    aput-object v2, v0, v1

    const/16 v1, 0x1bf

    const-string v2, "veh"

    aput-object v2, v0, v1

    const/16 v1, 0x1c0

    const-string v2, "vipchat"

    aput-object v2, v0, v1

    const/16 v1, 0x1c1

    const-string v2, "vipskins"

    aput-object v2, v0, v1

    const/16 v1, 0x1c2

    const-string v2, "vlock"

    aput-object v2, v0, v1

    const/16 v1, 0x1c3

    const-string v2, "vmute"

    aput-object v2, v0, v1

    const/16 v1, 0x1c4

    const-string v2, "vowner"

    aput-object v2, v0, v1

    const/16 v1, 0x1c5

    const-string v2, "vpark"

    aput-object v2, v0, v1

    const/16 v1, 0x1c6

    const-string v2, "vunmute"

    aput-object v2, v0, v1

    const/16 v1, 0x1c7

    const-string v2, "wanted"

    aput-object v2, v0, v1

    const/16 v1, 0x1c8

    const-string v2, "warblock"

    aput-object v2, v0, v1

    const/16 v1, 0x1c9

    const-string v2, "warn"

    aput-object v2, v0, v1

    const/16 v1, 0x1ca

    const-string v2, "warnhistory"

    aput-object v2, v0, v1

    const/16 v1, 0x1cb

    const-string v2, "warnlist"

    aput-object v2, v0, v1

    const/16 v1, 0x1cc

    const-string v2, "warsinfo"

    aput-object v2, v0, v1

    const/16 v1, 0x1cd

    const-string v2, "weapondata"

    aput-object v2, v0, v1

    const/16 v1, 0x1ce

    const-string v2, "whisper"

    aput-object v2, v0, v1

    const/16 v1, 0x1cf

    const-string v2, "wlock"

    aput-object v2, v0, v1

    const/16 v1, 0x1d0

    const-string v2, "y"

    aput-object v2, v0, v1

    const/16 v1, 0x1d1

    const-string v2, "ychat"

    aput-object v2, v0, v1

    const/16 v1, 0x1d2

    const-string v2, "ydelveh"

    aput-object v2, v0, v1

    const/16 v1, 0x1d3

    const-string v2, "ygoto"

    aput-object v2, v0, v1

    const/16 v1, 0x1d4

    const-string v2, "ygun"

    aput-object v2, v0, v1

    const/16 v1, 0x1d5

    const-string v2, "yhp"

    aput-object v2, v0, v1

    const/16 v1, 0x1d6

    const-string v2, "yoffre"

    aput-object v2, v0, v1

    const/16 v1, 0x1d7

    const-string v2, "ypveh"

    aput-object v2, v0, v1

    const/16 v1, 0x1d8

    const-string v2, "yre"

    aput-object v2, v0, v1

    const/16 v1, 0x1d9

    const-string v2, "yskinme"

    aput-object v2, v0, v1

    const/16 v1, 0x1da

    const-string v2, "ytp"

    aput-object v2, v0, v1

    const/16 v1, 0x1db

    const-string v2, "ytpanel"

    aput-object v2, v0, v1

    const/16 v1, 0x1dc

    const-string v2, "yveh"

    aput-object v2, v0, v1

    const/16 v1, 0x1dd

    const-string v2, "z"

    aput-object v2, v0, v1

    const/16 v1, 0x1de

    const-string v2, "ZD_ExitDmzombi"

    aput-object v2, v0, v1

    sput-object v0, Lcom/nvidia/devtech/CmdSuggest;->COMMANDS:[Ljava/lang/String;

    .line 625
    new-instance v0, Lcom/nvidia/devtech/CmdSuggest$1;

    invoke-direct {v0}, Lcom/nvidia/devtech/CmdSuggest$1;-><init>()V

    sput-object v0, Lcom/nvidia/devtech/CmdSuggest;->sWatcher:Landroid/text/TextWatcher;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 521
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)V
    .locals 0

    .line 30
    invoke-static {p0}, Lcom/nvidia/devtech/CmdSuggest;->refresh(Ljava/lang/String;)V

    return-void
.end method

.method static synthetic access$100()Landroid/widget/EditText;
    .locals 1

    .line 30
    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sEt:Landroid/widget/EditText;

    return-object v0
.end method

.method public static attach(Landroid/app/Activity;Landroid/widget/EditText;Landroid/widget/LinearLayout;)V
    .locals 1

    .line 524
    if-eqz p0, :cond_4

    if-eqz p1, :cond_4

    if-nez p2, :cond_0

    goto :goto_2

    .line 525
    :cond_0
    sput-object p1, Lcom/nvidia/devtech/CmdSuggest;->sEt:Landroid/widget/EditText;

    .line 527
    sget-boolean v0, Lcom/nvidia/devtech/CmdSuggest;->sInstalled:Z

    if-nez v0, :cond_1

    .line 528
    invoke-static {p0, p2}, Lcom/nvidia/devtech/CmdSuggest;->install(Landroid/app/Activity;Landroid/widget/LinearLayout;)V

    .line 529
    const/4 p0, 0x1

    sput-boolean p0, Lcom/nvidia/devtech/CmdSuggest;->sInstalled:Z

    goto :goto_0

    .line 530
    :cond_1
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    if-eqz p0, :cond_2

    .line 531
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    const/16 p2, 0x8

    invoke-virtual {p0, p2}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 534
    :cond_2
    :goto_0
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sWatcher:Landroid/text/TextWatcher;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->removeTextChangedListener(Landroid/text/TextWatcher;)V

    .line 535
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sWatcher:Landroid/text/TextWatcher;

    invoke-virtual {p1, p0}, Landroid/widget/EditText;->addTextChangedListener(Landroid/text/TextWatcher;)V

    .line 536
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p0

    if-nez p0, :cond_3

    const-string p0, ""

    goto :goto_1

    :cond_3
    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p0

    :goto_1
    invoke-static {p0}, Lcom/nvidia/devtech/CmdSuggest;->refresh(Ljava/lang/String;)V

    .line 537
    return-void

    .line 524
    :cond_4
    :goto_2
    return-void
.end method

.method private static cloneLp(Landroid/view/ViewGroup$LayoutParams;)Landroid/view/ViewGroup$LayoutParams;
    .locals 3

    .line 607
    instance-of v0, p0, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v1, -0x2

    const/4 v2, -0x1

    if-eqz v0, :cond_1

    .line 608
    check-cast p0, Landroid/widget/FrameLayout$LayoutParams;

    .line 609
    new-instance v0, Landroid/widget/FrameLayout$LayoutParams;

    invoke-direct {v0, v2, v1}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    .line 612
    iget v1, p0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    if-eqz v1, :cond_0

    iget p0, p0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    goto :goto_0

    :cond_0
    const/16 p0, 0x50

    :goto_0
    iput p0, v0, Landroid/widget/FrameLayout$LayoutParams;->gravity:I

    .line 613
    return-object v0

    .line 615
    :cond_1
    instance-of p0, p0, Landroid/widget/LinearLayout$LayoutParams;

    if-eqz p0, :cond_2

    .line 616
    new-instance p0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v2, v1}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    return-object p0

    .line 620
    :cond_2
    new-instance p0, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {p0, v2, v1}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    return-object p0
.end method

.method private static dp(Landroid/content/Context;I)I
    .locals 0

    .line 714
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    iget p0, p0, Landroid/util/DisplayMetrics;->density:F

    .line 715
    int-to-float p1, p1

    mul-float p1, p1, p0

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p0

    return p0
.end method

.method public static hide()V
    .locals 2

    .line 540
    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    if-eqz v0, :cond_0

    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 541
    :cond_0
    return-void
.end method

.method private static install(Landroid/app/Activity;Landroid/widget/LinearLayout;)V
    .locals 7

    .line 560
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getParent()Landroid/view/ViewParent;

    move-result-object v0

    check-cast v0, Landroid/view/ViewGroup;

    .line 561
    if-nez v0, :cond_0

    return-void

    .line 563
    :cond_0
    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->indexOfChild(Landroid/view/View;)I

    move-result v1

    .line 564
    invoke-virtual {p1}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    .line 567
    new-instance v3, Landroid/widget/HorizontalScrollView;

    invoke-direct {v3, p0}, Landroid/widget/HorizontalScrollView;-><init>(Landroid/content/Context;)V

    sput-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    .line 568
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/widget/HorizontalScrollView;->setHorizontalScrollBarEnabled(Z)V

    .line 569
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v3, v4}, Landroid/widget/HorizontalScrollView;->setFillViewport(Z)V

    .line 570
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    const v5, -0x33efeff0    # -3.7765184E7f

    invoke-virtual {v3, v5}, Landroid/widget/HorizontalScrollView;->setBackgroundColor(I)V

    .line 571
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    const/16 v5, 0x8

    invoke-virtual {v3, v5}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 573
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    sput-object v3, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    .line 574
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 575
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    const/16 v4, 0x10

    invoke-virtual {v3, v4}, Landroid/widget/LinearLayout;->setGravity(I)V

    .line 576
    const/4 v3, 0x4

    invoke-static {p0, v3}, Lcom/nvidia/devtech/CmdSuggest;->dp(Landroid/content/Context;I)I

    move-result v3

    .line 577
    sget-object v4, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    invoke-virtual {v4, v3, v3, v3, v3}, Landroid/widget/LinearLayout;->setPadding(IIII)V

    .line 578
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    sget-object v4, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    new-instance v5, Landroid/widget/FrameLayout$LayoutParams;

    const/4 v6, -0x2

    invoke-direct {v5, v6, v6}, Landroid/widget/FrameLayout$LayoutParams;-><init>(II)V

    invoke-virtual {v3, v4, v5}, Landroid/widget/HorizontalScrollView;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 584
    new-instance v3, Landroid/widget/LinearLayout;

    invoke-direct {v3, p0}, Landroid/widget/LinearLayout;-><init>(Landroid/content/Context;)V

    sput-object v3, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    .line 585
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    const/4 v3, 0x1

    invoke-virtual {p0, v3}, Landroid/widget/LinearLayout;->setOrientation(I)V

    .line 586
    if-eqz v2, :cond_1

    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    invoke-static {v2}, Lcom/nvidia/devtech/CmdSuggest;->cloneLp(Landroid/view/ViewGroup$LayoutParams;)Landroid/view/ViewGroup$LayoutParams;

    move-result-object v2

    invoke-virtual {p0, v2}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 589
    :cond_1
    invoke-virtual {v0, p1}, Landroid/view/ViewGroup;->removeView(Landroid/view/View;)V

    .line 590
    new-instance p0, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v2, -0x1

    invoke-direct {p0, v2, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 593
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    sget-object v4, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v3, v4, p0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 594
    new-instance p0, Landroid/widget/LinearLayout$LayoutParams;

    invoke-direct {p0, v2, v6}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 597
    sget-object v2, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    invoke-virtual {v2, p1, p0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 599
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    invoke-virtual {v0, p0, v1}, Landroid/view/ViewGroup;->addView(Landroid/view/View;I)V

    .line 603
    sget p0, Lcom/nvidia/devtech/CmdSuggest;->sKbHeight:I

    if-lez p0, :cond_2

    sget p0, Lcom/nvidia/devtech/CmdSuggest;->sKbHeight:I

    invoke-static {p0}, Lcom/nvidia/devtech/CmdSuggest;->onHeightChanged(I)V

    .line 604
    :cond_2
    return-void
.end method

.method private static makeChip(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;
    .locals 5

    .line 680
    new-instance v0, Landroid/widget/TextView;

    invoke-direct {v0, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    .line 681
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 682
    const/4 v1, -0x1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTextColor(I)V

    .line 683
    const/4 v1, 0x2

    const/high16 v2, 0x41500000    # 13.0f

    invoke-virtual {v0, v1, v2}, Landroid/widget/TextView;->setTextSize(IF)V

    .line 684
    sget-object v1, Landroid/graphics/Typeface;->DEFAULT_BOLD:Landroid/graphics/Typeface;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setTypeface(Landroid/graphics/Typeface;)V

    .line 685
    const/16 v1, 0xa

    invoke-static {p0, v1}, Lcom/nvidia/devtech/CmdSuggest;->dp(Landroid/content/Context;I)I

    move-result v1

    const/4 v2, 0x6

    invoke-static {p0, v2}, Lcom/nvidia/devtech/CmdSuggest;->dp(Landroid/content/Context;I)I

    move-result v3

    .line 686
    invoke-virtual {v0, v1, v3, v1, v3}, Landroid/widget/TextView;->setPadding(IIII)V

    .line 688
    new-instance v1, Landroid/graphics/drawable/GradientDrawable;

    invoke-direct {v1}, Landroid/graphics/drawable/GradientDrawable;-><init>()V

    .line 689
    const/4 v3, 0x0

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setShape(I)V

    .line 690
    const/16 v3, 0xe

    invoke-static {p0, v3}, Lcom/nvidia/devtech/CmdSuggest;->dp(Landroid/content/Context;I)I

    move-result v3

    int-to-float v3, v3

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setCornerRadius(F)V

    .line 691
    const v3, -0xd5d0c6

    invoke-virtual {v1, v3}, Landroid/graphics/drawable/GradientDrawable;->setColor(I)V

    .line 692
    const/4 v3, 0x1

    invoke-static {p0, v3}, Lcom/nvidia/devtech/CmdSuggest;->dp(Landroid/content/Context;I)I

    move-result v3

    const v4, -0xcd6e0b

    invoke-virtual {v1, v3, v4}, Landroid/graphics/drawable/GradientDrawable;->setStroke(II)V

    .line 693
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 695
    new-instance v1, Landroid/widget/LinearLayout$LayoutParams;

    const/4 v3, -0x2

    invoke-direct {v1, v3, v3}, Landroid/widget/LinearLayout$LayoutParams;-><init>(II)V

    .line 698
    invoke-static {p0, v2}, Lcom/nvidia/devtech/CmdSuggest;->dp(Landroid/content/Context;I)I

    move-result p0

    iput p0, v1, Landroid/widget/LinearLayout$LayoutParams;->rightMargin:I

    .line 699
    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 701
    new-instance p0, Lcom/nvidia/devtech/CmdSuggest$2;

    invoke-direct {p0, p1}, Lcom/nvidia/devtech/CmdSuggest$2;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Landroid/widget/TextView;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 710
    return-object v0
.end method

.method public static onHeightChanged(I)V
    .locals 2

    .line 549
    sput p0, Lcom/nvidia/devtech/CmdSuggest;->sKbHeight:I

    .line 550
    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    return-void

    .line 551
    :cond_0
    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    invoke-virtual {v0}, Landroid/widget/LinearLayout;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 552
    instance-of v1, v0, Landroid/widget/FrameLayout$LayoutParams;

    if-eqz v1, :cond_1

    .line 553
    check-cast v0, Landroid/widget/FrameLayout$LayoutParams;

    .line 554
    const/4 v1, 0x0

    invoke-virtual {v0, v1, v1, v1, p0}, Landroid/widget/FrameLayout$LayoutParams;->setMargins(IIII)V

    .line 555
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sWrap:Landroid/widget/LinearLayout;

    invoke-virtual {p0, v0}, Landroid/widget/LinearLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 557
    :cond_1
    return-void
.end method

.method private static refresh(Ljava/lang/String;)V
    .locals 10

    .line 634
    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    if-eqz v0, :cond_e

    sget-object v0, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    if-nez v0, :cond_0

    goto/16 :goto_8

    .line 635
    :cond_0
    const/16 v0, 0x8

    if-eqz p0, :cond_d

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v1

    if-eqz v1, :cond_d

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Ljava/lang/String;->charAt(I)C

    move-result v2

    const/16 v3, 0x2f

    if-eq v2, v3, :cond_1

    goto/16 :goto_7

    .line 640
    :cond_1
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v2

    .line 641
    const/4 v3, 0x1

    const/4 v4, 0x1

    :goto_0
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v5

    if-ge v4, v5, :cond_4

    .line 642
    invoke-virtual {p0, v4}, Ljava/lang/String;->charAt(I)C

    move-result v5

    .line 643
    const/16 v6, 0x20

    if-eq v5, v6, :cond_3

    const/16 v6, 0x9

    if-ne v5, v6, :cond_2

    goto :goto_1

    .line 641
    :cond_2
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 643
    :cond_3
    :goto_1
    move v2, v4

    .line 645
    :cond_4
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v4

    if-ge v2, v4, :cond_5

    .line 646
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {p0, v0}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 647
    return-void

    .line 649
    :cond_5
    invoke-virtual {p0, v3, v2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object p0

    .line 651
    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    .line 652
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->COMMANDS:[Ljava/lang/String;

    array-length v4, v3

    const/4 v5, 0x0

    :goto_2
    const/16 v6, 0x32

    if-ge v5, v4, :cond_8

    aget-object v7, v3, v5

    .line 653
    invoke-virtual {v7}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8, p0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v8

    if-eqz v8, :cond_6

    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 654
    :cond_6
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v7

    if-lt v7, v6, :cond_7

    goto :goto_3

    .line 652
    :cond_7
    add-int/lit8 v5, v5, 0x1

    goto :goto_2

    .line 656
    :cond_8
    :goto_3
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    const/16 v4, 0xc

    if-ge v3, v4, :cond_a

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v3

    const/4 v4, 0x2

    if-lt v3, v4, :cond_a

    .line 657
    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->COMMANDS:[Ljava/lang/String;

    array-length v4, v3

    const/4 v5, 0x0

    :goto_4
    if-ge v5, v4, :cond_a

    aget-object v7, v3, v5

    .line 658
    invoke-virtual {v7}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v8

    .line 659
    invoke-virtual {v8, p0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v9

    if-nez v9, :cond_9

    invoke-virtual {v8, p0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_9

    .line 660
    invoke-interface {v2, v7}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 661
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v7

    if-lt v7, v6, :cond_9

    goto :goto_5

    .line 657
    :cond_9
    add-int/lit8 v5, v5, 0x1

    goto :goto_4

    .line 666
    :cond_a
    :goto_5
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    invoke-virtual {p0}, Landroid/widget/LinearLayout;->removeAllViews()V

    .line 667
    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result p0

    if-eqz p0, :cond_b

    .line 668
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {p0, v0}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 669
    return-void

    .line 672
    :cond_b
    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p0

    :goto_6
    invoke-interface {p0}, Ljava/util/Iterator;->hasNext()Z

    move-result v0

    if-eqz v0, :cond_c

    invoke-interface {p0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 673
    sget-object v2, Lcom/nvidia/devtech/CmdSuggest;->sStrip:Landroid/widget/LinearLayout;

    sget-object v3, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {v3}, Landroid/widget/HorizontalScrollView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-static {v3, v0}, Lcom/nvidia/devtech/CmdSuggest;->makeChip(Landroid/content/Context;Ljava/lang/String;)Landroid/widget/TextView;

    move-result-object v0

    invoke-virtual {v2, v0}, Landroid/widget/LinearLayout;->addView(Landroid/view/View;)V

    .line 674
    goto :goto_6

    .line 675
    :cond_c
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {p0, v1}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 676
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {p0, v1, v1}, Landroid/widget/HorizontalScrollView;->scrollTo(II)V

    .line 677
    return-void

    .line 636
    :cond_d
    :goto_7
    sget-object p0, Lcom/nvidia/devtech/CmdSuggest;->sScroll:Landroid/widget/HorizontalScrollView;

    invoke-virtual {p0, v0}, Landroid/widget/HorizontalScrollView;->setVisibility(I)V

    .line 637
    return-void

    .line 634
    :cond_e
    :goto_8
    return-void
.end method
