.class final Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
.super Lkotlin/coroutines/jvm/internal/RestrictedSuspendLambda;
.source "SlidingWindow.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lkotlin/collections/SlidingWindowKt;->windowedIterator(Ljava/util/Iterator;IIZZ)Ljava/util/Iterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/RestrictedSuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlin/sequences/SequenceScope<",
        "-",
        "Ljava/util/List<",
        "+TT;>;>;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    bv = {
        0x1,
        0x0,
        0x3
    }
    d1 = {
        "\u0000\u0014\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010 \n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u0001\"\u0004\u0008\u0000\u0010\u0002*\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u0002H\u00020\u00040\u0003H\u008a@\u00a2\u0006\u0004\u0008\u0005\u0010\u0006"
    }
    d2 = {
        "<anonymous>",
        "",
        "T",
        "Lkotlin/sequences/SequenceScope;",
        "",
        "invoke",
        "(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;"
    }
    k = 0x3
    mv = {
        0x1,
        0x4,
        0x0
    }
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "kotlin.collections.SlidingWindowKt$windowedIterator$1"
    f = "SlidingWindow.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x1,
        0x1,
        0x1,
        0x1,
        0x1,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x3,
        0x3,
        0x3,
        0x3,
        0x4,
        0x4,
        0x4,
        0x4
    }
    l = {
        0x22,
        0x28,
        0x31,
        0x37,
        0x3a
    }
    m = "invokeSuspend"
    n = {
        "$this$iterator",
        "bufferInitialCapacity",
        "gap",
        "buffer",
        "skip",
        "e",
        "$this$iterator",
        "bufferInitialCapacity",
        "gap",
        "buffer",
        "skip",
        "$this$iterator",
        "bufferInitialCapacity",
        "gap",
        "buffer",
        "e",
        "$this$iterator",
        "bufferInitialCapacity",
        "gap",
        "buffer",
        "$this$iterator",
        "bufferInitialCapacity",
        "gap",
        "buffer"
    }
    s = {
        "L$0",
        "I$0",
        "I$1",
        "L$1",
        "I$2",
        "L$2",
        "L$0",
        "I$0",
        "I$1",
        "L$1",
        "I$2",
        "L$0",
        "I$0",
        "I$1",
        "L$1",
        "L$2",
        "L$0",
        "I$0",
        "I$1",
        "L$1",
        "L$0",
        "I$0",
        "I$1",
        "L$1"
    }
.end annotation


# instance fields
.field final synthetic $iterator:Ljava/util/Iterator;

.field final synthetic $partialWindows:Z

.field final synthetic $reuseBuffer:Z

.field final synthetic $size:I

.field final synthetic $step:I

.field I$0:I

.field I$1:I

.field I$2:I

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field label:I

.field private p$:Lkotlin/sequences/SequenceScope;


# direct methods
.method constructor <init>(IILjava/util/Iterator;ZZLkotlin/coroutines/Continuation;)V
    .locals 0

    iput p1, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    iput p2, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$step:I

    iput-object p3, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$iterator:Ljava/util/Iterator;

    iput-boolean p4, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$reuseBuffer:Z

    iput-boolean p5, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$partialWindows:Z

    const/4 p1, 0x2

    invoke-direct {p0, p1, p6}, Lkotlin/coroutines/jvm/internal/RestrictedSuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    const-string v0, "completion"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;

    iget v2, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    iget v3, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$step:I

    iget-object v4, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$iterator:Ljava/util/Iterator;

    iget-boolean v5, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$reuseBuffer:Z

    iget-boolean v6, p0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$partialWindows:Z

    move-object v1, v0

    move-object v7, p2

    invoke-direct/range {v1 .. v7}, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;-><init>(IILjava/util/Iterator;ZZLkotlin/coroutines/Continuation;)V

    move-object v1, p1

    check-cast v1, Lkotlin/sequences/SequenceScope;

    move-object v1, p1

    check-cast v1, Lkotlin/sequences/SequenceScope;

    iput-object v1, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->p$:Lkotlin/sequences/SequenceScope;

    return-object v0
.end method

.method public final invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 0

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object p1

    check-cast p1, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;

    sget-object p2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {p1, p2}, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 17
    .param p1, "$result"    # Ljava/lang/Object;

    move-object/from16 v0, p0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 24
    iget v2, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->label:I

    const/4 v3, 0x5

    const/4 v4, 0x4

    const/4 v5, 0x3

    const/4 v6, 0x2

    const/4 v7, 0x1

    if-eqz v2, :cond_5

    const/4 v8, 0x0

    const/4 v9, 0x0

    if-eq v2, v7, :cond_4

    if-eq v2, v6, :cond_3

    if-eq v2, v5, :cond_2

    if-eq v2, v4, :cond_1

    if-ne v2, v3, :cond_0

    move-object v1, v9

    .local v1, "$this$iterator":Lkotlin/sequences/SequenceScope;
    move v2, v8

    .local v2, "gap":I
    move v3, v8

    .local v3, "bufferInitialCapacity":I
    move-object v4, v9

    .local v4, "buffer":Lkotlin/collections/RingBuffer;
    iget-object v5, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    move-object v4, v5

    check-cast v4, Lkotlin/collections/RingBuffer;

    iget v2, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iget v3, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iget-object v5, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    move-object v1, v5

    check-cast v1, Lkotlin/sequences/SequenceScope;

    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v11, v0

    move-object v6, v1

    move-object/from16 v1, p1

    goto/16 :goto_c

    .line 61
    .end local v1    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local v2    # "gap":I
    .end local v3    # "bufferInitialCapacity":I
    .end local v4    # "buffer":Lkotlin/collections/RingBuffer;
    :cond_0
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v2, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v1, v2}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 24
    :cond_1
    move-object v2, v9

    .local v2, "$this$iterator":Lkotlin/sequences/SequenceScope;
    move v5, v8

    .local v5, "gap":I
    move v6, v8

    .local v6, "bufferInitialCapacity":I
    move-object v8, v9

    .local v8, "buffer":Lkotlin/collections/RingBuffer;
    iget-object v9, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    move-object v8, v9

    check-cast v8, Lkotlin/collections/RingBuffer;

    iget v5, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iget v6, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iget-object v9, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    move-object v2, v9

    check-cast v2, Lkotlin/sequences/SequenceScope;

    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v11, v0

    move v10, v5

    move-object v9, v8

    move v8, v6

    move-object v6, v2

    move-object v2, v1

    move-object/from16 v1, p1

    goto/16 :goto_b

    .end local v2    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local v5    # "gap":I
    .end local v6    # "bufferInitialCapacity":I
    .end local v8    # "buffer":Lkotlin/collections/RingBuffer;
    :cond_2
    move-object v2, v9

    .restart local v2    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    move v6, v8

    .local v6, "e":Ljava/lang/Object;
    move v10, v8

    .local v8, "bufferInitialCapacity":I
    .local v9, "buffer":Lkotlin/collections/RingBuffer;
    .local v10, "gap":I
    iget-object v11, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$3:Ljava/lang/Object;

    check-cast v11, Ljava/util/Iterator;

    iget-object v6, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$2:Ljava/lang/Object;

    iget-object v12, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    move-object v9, v12

    check-cast v9, Lkotlin/collections/RingBuffer;

    iget v10, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iget v8, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iget-object v12, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    move-object v2, v12

    check-cast v2, Lkotlin/sequences/SequenceScope;

    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v12, v0

    move-object v13, v6

    move-object v6, v2

    move-object v2, v1

    move-object/from16 v1, p1

    goto/16 :goto_7

    .end local v2    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local v6    # "e":Ljava/lang/Object;
    .end local v8    # "bufferInitialCapacity":I
    .end local v9    # "buffer":Lkotlin/collections/RingBuffer;
    .end local v10    # "gap":I
    :cond_3
    move-object v1, v9

    .restart local v1    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    move v2, v8

    .local v2, "skip":I
    move v3, v8

    .local v3, "gap":I
    move v4, v8

    .local v4, "bufferInitialCapacity":I
    move-object v5, v9

    .local v5, "buffer":Ljava/util/ArrayList;
    iget v2, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$2:I

    iget-object v6, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    move-object v5, v6

    check-cast v5, Ljava/util/ArrayList;

    iget v3, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iget v4, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iget-object v6, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    move-object v1, v6

    check-cast v1, Lkotlin/sequences/SequenceScope;

    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v11, v0

    move v8, v4

    move v4, v2

    move-object v2, v1

    move-object/from16 v1, p1

    goto/16 :goto_4

    .end local v1    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local v2    # "skip":I
    .end local v3    # "gap":I
    .end local v4    # "bufferInitialCapacity":I
    .end local v5    # "buffer":Ljava/util/ArrayList;
    :cond_4
    move-object v2, v9

    .local v2, "$this$iterator":Lkotlin/sequences/SequenceScope;
    move v3, v8

    .local v3, "skip":I
    move v4, v8

    .local v4, "gap":I
    move v5, v8

    .local v5, "bufferInitialCapacity":I
    move-object v8, v9

    .local v8, "e":Ljava/lang/Object;
    .local v9, "buffer":Ljava/util/ArrayList;
    iget-object v10, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$3:Ljava/lang/Object;

    check-cast v10, Ljava/util/Iterator;

    iget-object v8, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$2:Ljava/lang/Object;

    iget v3, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$2:I

    iget-object v11, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    move-object v9, v11

    check-cast v9, Ljava/util/ArrayList;

    iget v4, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iget v5, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iget-object v11, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    move-object v2, v11

    check-cast v2, Lkotlin/sequences/SequenceScope;

    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object v12, v0

    move-object v11, v10

    move-object v10, v9

    move v9, v4

    move v4, v3

    move-object v3, v1

    move-object/from16 v1, p1

    goto :goto_1

    .end local v2    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local v3    # "skip":I
    .end local v4    # "gap":I
    .end local v5    # "bufferInitialCapacity":I
    .end local v8    # "e":Ljava/lang/Object;
    .end local v9    # "buffer":Ljava/util/ArrayList;
    :cond_5
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    iget-object v2, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->p$:Lkotlin/sequences/SequenceScope;

    .line 25
    .restart local v2    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    iget v8, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    const/16 v9, 0x400

    invoke-static {v8, v9}, Lkotlin/ranges/RangesKt;->coerceAtMost(II)I

    move-result v8

    .line 26
    .local v8, "bufferInitialCapacity":I
    iget v9, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$step:I

    iget v10, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    sub-int/2addr v9, v10

    .line 27
    .local v9, "gap":I
    if-ltz v9, :cond_d

    .line 28
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v8}, Ljava/util/ArrayList;-><init>(I)V

    .line 29
    .local v3, "buffer":Ljava/util/ArrayList;
    const/4 v4, 0x0

    .line 30
    .local v4, "skip":I
    iget-object v5, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$iterator:Ljava/util/Iterator;

    move-object v11, v0

    move-object v10, v5

    move-object v5, v3

    move-object v3, v1

    move-object/from16 v1, p1

    .end local v3    # "buffer":Ljava/util/ArrayList;
    .end local p0    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .end local p1    # "$result":Ljava/lang/Object;
    .local v1, "$result":Ljava/lang/Object;
    .local v5, "buffer":Ljava/util/ArrayList;
    .local v11, "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :goto_0
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v12

    if-eqz v12, :cond_a

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v12

    .line 31
    .local v12, "e":Ljava/lang/Object;
    if-lez v4, :cond_6

    add-int/lit8 v4, v4, -0x1

    goto :goto_3

    .line 32
    :cond_6
    invoke-virtual {v5, v12}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 33
    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v13

    iget v14, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    if-ne v13, v14, :cond_9

    .line 34
    iput-object v2, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    iput v8, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iput v9, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iput-object v5, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    iput v4, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$2:I

    iput-object v12, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$2:Ljava/lang/Object;

    iput-object v10, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$3:Ljava/lang/Object;

    iput v7, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->label:I

    invoke-virtual {v2, v5, v11}, Lkotlin/sequences/SequenceScope;->yield(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v13

    if-ne v13, v3, :cond_7

    .line 24
    return-object v3

    .line 34
    :cond_7
    move-object/from16 v16, v10

    move-object v10, v5

    move v5, v8

    move-object v8, v12

    move-object v12, v11

    move-object/from16 v11, v16

    .line 35
    .end local v11    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .local v5, "bufferInitialCapacity":I
    .local v8, "e":Ljava/lang/Object;
    .local v10, "buffer":Ljava/util/ArrayList;
    .local v12, "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :goto_1
    iget-boolean v13, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$reuseBuffer:Z

    if-eqz v13, :cond_8

    invoke-virtual {v10}, Ljava/util/ArrayList;->clear()V

    goto :goto_2

    :cond_8
    new-instance v13, Ljava/util/ArrayList;

    iget v14, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    invoke-direct {v13, v14}, Ljava/util/ArrayList;-><init>(I)V

    move-object v10, v13

    .line 36
    :goto_2
    move v4, v9

    move v8, v5

    move-object v5, v10

    move-object v10, v11

    move-object v11, v12

    .line 30
    .end local v10    # "buffer":Ljava/util/ArrayList;
    .end local v12    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .local v5, "buffer":Ljava/util/ArrayList;
    .local v8, "bufferInitialCapacity":I
    .restart local v11    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :cond_9
    :goto_3
    goto :goto_0

    .line 39
    :cond_a
    move-object v10, v5

    check-cast v10, Ljava/util/Collection;

    invoke-interface {v10}, Ljava/util/Collection;->isEmpty()Z

    move-result v10

    xor-int/2addr v7, v10

    if-eqz v7, :cond_19

    .line 40
    iget-boolean v7, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$partialWindows:Z

    if-nez v7, :cond_b

    invoke-virtual {v5}, Ljava/util/ArrayList;->size()I

    move-result v7

    iget v10, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    if-ne v7, v10, :cond_19

    :cond_b
    iput-object v2, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    iput v8, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iput v9, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iput-object v5, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    iput v4, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$2:I

    iput v6, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->label:I

    invoke-virtual {v2, v5, v11}, Lkotlin/sequences/SequenceScope;->yield(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v6

    if-ne v6, v3, :cond_c

    .line 24
    return-object v3

    .line 40
    :cond_c
    move v3, v9

    .end local v9    # "gap":I
    .local v3, "gap":I
    :goto_4
    goto/16 :goto_d

    .line 43
    .end local v1    # "$result":Ljava/lang/Object;
    .end local v3    # "gap":I
    .end local v4    # "skip":I
    .end local v5    # "buffer":Ljava/util/ArrayList;
    .end local v11    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .restart local v9    # "gap":I
    .restart local p1    # "$result":Ljava/lang/Object;
    :cond_d
    new-instance v6, Lkotlin/collections/RingBuffer;

    invoke-direct {v6, v8}, Lkotlin/collections/RingBuffer;-><init>(I)V

    .line 44
    .local v6, "buffer":Lkotlin/collections/RingBuffer;
    iget-object v10, v0, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$iterator:Ljava/util/Iterator;

    move-object v12, v0

    move-object v11, v10

    move v10, v9

    move-object v9, v6

    move-object v6, v2

    move-object v2, v1

    move-object/from16 v1, p1

    .end local v2    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v1    # "$result":Ljava/lang/Object;
    .local v6, "$this$iterator":Lkotlin/sequences/SequenceScope;
    .local v9, "buffer":Lkotlin/collections/RingBuffer;
    .local v10, "gap":I
    .restart local v12    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :goto_5
    invoke-interface {v11}, Ljava/util/Iterator;->hasNext()Z

    move-result v13

    if-eqz v13, :cond_12

    invoke-interface {v11}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v13

    .line 45
    .local v13, "e":Ljava/lang/Object;
    invoke-virtual {v9, v13}, Lkotlin/collections/RingBuffer;->add(Ljava/lang/Object;)V

    .line 46
    invoke-virtual {v9}, Lkotlin/collections/RingBuffer;->isFull()Z

    move-result v14

    if-eqz v14, :cond_11

    .line 47
    invoke-virtual {v9}, Lkotlin/collections/RingBuffer;->size()I

    move-result v14

    iget v15, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$size:I

    if-ge v14, v15, :cond_e

    invoke-virtual {v9, v15}, Lkotlin/collections/RingBuffer;->expanded(I)Lkotlin/collections/RingBuffer;

    move-result-object v9

    goto :goto_8

    .line 49
    :cond_e
    iget-boolean v14, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$reuseBuffer:Z

    if-eqz v14, :cond_f

    move-object v14, v9

    check-cast v14, Ljava/util/List;

    goto :goto_6

    :cond_f
    new-instance v14, Ljava/util/ArrayList;

    move-object v15, v9

    check-cast v15, Ljava/util/Collection;

    invoke-direct {v14, v15}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    check-cast v14, Ljava/util/List;

    :goto_6
    iput-object v6, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    iput v8, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iput v10, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iput-object v9, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    iput-object v13, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$2:Ljava/lang/Object;

    iput-object v11, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$3:Ljava/lang/Object;

    iput v5, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->label:I

    invoke-virtual {v6, v14, v12}, Lkotlin/sequences/SequenceScope;->yield(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v14

    if-ne v14, v2, :cond_10

    .line 24
    return-object v2

    .line 50
    :cond_10
    :goto_7
    iget v14, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$step:I

    invoke-virtual {v9, v14}, Lkotlin/collections/RingBuffer;->removeFirst(I)V

    .line 44
    .end local v13    # "e":Ljava/lang/Object;
    :cond_11
    :goto_8
    goto :goto_5

    .line 53
    :cond_12
    iget-boolean v5, v12, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$partialWindows:Z

    if-eqz v5, :cond_18

    move-object v11, v12

    .line 54
    .end local v12    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .restart local v11    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :goto_9
    invoke-virtual {v9}, Lkotlin/collections/RingBuffer;->size()I

    move-result v5

    iget v12, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$step:I

    if-le v5, v12, :cond_15

    .line 55
    iget-boolean v5, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$reuseBuffer:Z

    if-eqz v5, :cond_13

    move-object v5, v9

    check-cast v5, Ljava/util/List;

    goto :goto_a

    :cond_13
    new-instance v5, Ljava/util/ArrayList;

    move-object v12, v9

    check-cast v12, Ljava/util/Collection;

    invoke-direct {v5, v12}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    check-cast v5, Ljava/util/List;

    :goto_a
    iput-object v6, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    iput v8, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iput v10, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iput-object v9, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    iput v4, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->label:I

    invoke-virtual {v6, v5, v11}, Lkotlin/sequences/SequenceScope;->yield(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5

    if-ne v5, v2, :cond_14

    .line 24
    return-object v2

    .line 56
    :cond_14
    :goto_b
    iget v5, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->$step:I

    invoke-virtual {v9, v5}, Lkotlin/collections/RingBuffer;->removeFirst(I)V

    .line 54
    goto :goto_9

    .line 58
    :cond_15
    move-object v4, v9

    check-cast v4, Ljava/util/Collection;

    invoke-interface {v4}, Ljava/util/Collection;->isEmpty()Z

    move-result v4

    xor-int/2addr v4, v7

    if-eqz v4, :cond_17

    iput-object v6, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$0:Ljava/lang/Object;

    iput v8, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$0:I

    iput v10, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->I$1:I

    iput-object v9, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->L$1:Ljava/lang/Object;

    iput v3, v11, Lkotlin/collections/SlidingWindowKt$windowedIterator$1;->label:I

    invoke-virtual {v6, v9, v11}, Lkotlin/sequences/SequenceScope;->yield(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v3

    if-ne v3, v2, :cond_16

    .line 24
    return-object v2

    .line 58
    :cond_16
    move v3, v8

    move-object v4, v9

    move v2, v10

    .line 60
    .end local v8    # "bufferInitialCapacity":I
    .end local v9    # "buffer":Lkotlin/collections/RingBuffer;
    .end local v10    # "gap":I
    .local v2, "gap":I
    .local v3, "bufferInitialCapacity":I
    .local v4, "buffer":Lkotlin/collections/RingBuffer;
    :goto_c
    move-object v2, v6

    goto :goto_d

    .line 58
    .end local v2    # "gap":I
    .end local v3    # "bufferInitialCapacity":I
    .end local v4    # "buffer":Lkotlin/collections/RingBuffer;
    .restart local v8    # "bufferInitialCapacity":I
    .restart local v9    # "buffer":Lkotlin/collections/RingBuffer;
    .restart local v10    # "gap":I
    :cond_17
    move-object v2, v6

    goto :goto_d

    .line 53
    .end local v11    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .restart local v12    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :cond_18
    move-object v2, v6

    move-object v11, v12

    .line 61
    .end local v6    # "$this$iterator":Lkotlin/sequences/SequenceScope;
    .end local v8    # "bufferInitialCapacity":I
    .end local v9    # "buffer":Lkotlin/collections/RingBuffer;
    .end local v10    # "gap":I
    .end local v12    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    .local v2, "$this$iterator":Lkotlin/sequences/SequenceScope;
    .restart local v11    # "this":Lkotlin/collections/SlidingWindowKt$windowedIterator$1;
    :cond_19
    :goto_d
    sget-object v3, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v3
.end method
