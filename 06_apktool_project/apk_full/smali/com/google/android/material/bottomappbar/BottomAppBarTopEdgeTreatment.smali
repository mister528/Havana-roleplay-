.class public Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;
.super Lcom/google/android/material/shape/EdgeTreatment;
.source "BottomAppBarTopEdgeTreatment.java"


# static fields
.field private static final ANGLE_LEFT:I = 0xb4

.field private static final ANGLE_UP:I = 0x10e

.field private static final ARC_HALF:I = 0xb4

.field private static final ARC_QUARTER:I = 0x5a


# instance fields
.field private cradleVerticalOffset:F

.field private fabDiameter:F

.field private fabMargin:F

.field private horizontalOffset:F

.field private roundedCornerRadius:F


# direct methods
.method public constructor <init>(FFF)V
    .locals 2
    .param p1, "fabMargin"    # F
    .param p2, "roundedCornerRadius"    # F
    .param p3, "cradleVerticalOffset"    # F

    .line 56
    invoke-direct {p0}, Lcom/google/android/material/shape/EdgeTreatment;-><init>()V

    .line 57
    iput p1, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabMargin:F

    .line 58
    iput p2, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->roundedCornerRadius:F

    .line 59
    iput p3, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->cradleVerticalOffset:F

    .line 61
    const/4 v0, 0x0

    cmpg-float v1, p3, v0

    if-ltz v1, :cond_0

    .line 64
    iput v0, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->horizontalOffset:F

    .line 65
    return-void

    .line 62
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "cradleVerticalOffset must be positive."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method getCradleVerticalOffset()F
    .locals 1

    .line 163
    iget v0, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->cradleVerticalOffset:F

    return v0
.end method

.method public getEdgePath(FFLcom/google/android/material/shape/ShapePath;)V
    .locals 26
    .param p1, "length"    # F
    .param p2, "interpolation"    # F
    .param p3, "shapePath"    # Lcom/google/android/material/shape/ShapePath;

    .line 69
    move-object/from16 v0, p0

    move/from16 v1, p1

    move-object/from16 v9, p3

    iget v2, v0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabDiameter:F

    const/4 v10, 0x0

    cmpl-float v3, v2, v10

    if-nez v3, :cond_0

    .line 71
    invoke-virtual {v9, v1, v10}, Lcom/google/android/material/shape/ShapePath;->lineTo(FF)V

    .line 72
    return-void

    .line 75
    :cond_0
    iget v3, v0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabMargin:F

    const/high16 v11, 0x40000000    # 2.0f

    mul-float v3, v3, v11

    add-float v12, v3, v2

    .line 76
    .local v12, "cradleDiameter":F
    div-float v13, v12, v11

    .line 77
    .local v13, "cradleRadius":F
    iget v2, v0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->roundedCornerRadius:F

    mul-float v14, p2, v2

    .line 78
    .local v14, "roundedCornerOffset":F
    div-float v2, v1, v11

    iget v3, v0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->horizontalOffset:F

    add-float v15, v2, v3

    .line 82
    .local v15, "middle":F
    iget v2, v0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->cradleVerticalOffset:F

    mul-float v2, v2, p2

    const/high16 v3, 0x3f800000    # 1.0f

    sub-float v4, v3, p2

    mul-float v4, v4, v13

    add-float v16, v2, v4

    .line 84
    .local v16, "verticalOffset":F
    div-float v17, v16, v13

    .line 85
    .local v17, "verticalOffsetRatio":F
    cmpl-float v2, v17, v3

    if-ltz v2, :cond_1

    .line 88
    invoke-virtual {v9, v1, v10}, Lcom/google/android/material/shape/ShapePath;->lineTo(FF)V

    .line 89
    return-void

    .line 98
    :cond_1
    add-float v18, v13, v14

    .line 99
    .local v18, "distanceBetweenCenters":F
    mul-float v19, v18, v18

    .line 100
    .local v19, "distanceBetweenCentersSquared":F
    add-float v20, v16, v14

    .line 101
    .local v20, "distanceY":F
    mul-float v2, v20, v20

    sub-float v2, v19, v2

    float-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    double-to-float v8, v2

    .line 104
    .local v8, "distanceX":F
    sub-float v21, v15, v8

    .line 105
    .local v21, "leftRoundedCornerCircleX":F
    add-float v22, v15, v8

    .line 108
    .local v22, "rightRoundedCornerCircleX":F
    div-float v2, v8, v20

    float-to-double v2, v2

    invoke-static {v2, v3}, Ljava/lang/Math;->atan(D)D

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Math;->toDegrees(D)D

    move-result-wide v2

    double-to-float v7, v2

    .line 109
    .local v7, "cornerRadiusArcLength":F
    const/high16 v2, 0x42b40000    # 90.0f

    sub-float v23, v2, v7

    .line 112
    .local v23, "cutoutArcOffset":F
    sub-float v2, v21, v14

    invoke-virtual {v9, v2, v10}, Lcom/google/android/material/shape/ShapePath;->lineTo(FF)V

    .line 116
    sub-float v3, v21, v14

    const/4 v4, 0x0

    add-float v5, v21, v14

    mul-float v6, v14, v11

    const/high16 v24, 0x43870000    # 270.0f

    move-object/from16 v2, p3

    move/from16 v25, v7

    .end local v7    # "cornerRadiusArcLength":F
    .local v25, "cornerRadiusArcLength":F
    move/from16 v7, v24

    move/from16 v24, v8

    .end local v8    # "distanceX":F
    .local v24, "distanceX":F
    move/from16 v8, v25

    invoke-virtual/range {v2 .. v8}, Lcom/google/android/material/shape/ShapePath;->addArc(FFFFFF)V

    .line 125
    sub-float v3, v15, v13

    neg-float v2, v13

    sub-float v4, v2, v16

    add-float v5, v15, v13

    sub-float v6, v13, v16

    const/high16 v2, 0x43340000    # 180.0f

    sub-float v7, v2, v23

    mul-float v8, v23, v11

    sub-float/2addr v8, v2

    move-object/from16 v2, p3

    invoke-virtual/range {v2 .. v8}, Lcom/google/android/material/shape/ShapePath;->addArc(FFFFFF)V

    .line 135
    sub-float v3, v22, v14

    const/4 v4, 0x0

    add-float v5, v22, v14

    mul-float v6, v14, v11

    const/high16 v2, 0x43870000    # 270.0f

    sub-float v7, v2, v25

    move-object/from16 v2, p3

    move/from16 v8, v25

    invoke-virtual/range {v2 .. v8}, Lcom/google/android/material/shape/ShapePath;->addArc(FFFFFF)V

    .line 144
    invoke-virtual {v9, v1, v10}, Lcom/google/android/material/shape/ShapePath;->lineTo(FF)V

    .line 145
    return-void
.end method

.method getFabCradleMargin()F
    .locals 1

    .line 184
    iget v0, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabMargin:F

    return v0
.end method

.method getFabCradleRoundedCornerRadius()F
    .locals 1

    .line 192
    iget v0, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->roundedCornerRadius:F

    return v0
.end method

.method getFabDiameter()F
    .locals 1

    .line 176
    iget v0, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabDiameter:F

    return v0
.end method

.method getHorizontalOffset()F
    .locals 1

    .line 154
    iget v0, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->horizontalOffset:F

    return v0
.end method

.method setCradleVerticalOffset(F)V
    .locals 0
    .param p1, "cradleVerticalOffset"    # F

    .line 172
    iput p1, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->cradleVerticalOffset:F

    .line 173
    return-void
.end method

.method setFabCradleMargin(F)V
    .locals 0
    .param p1, "fabMargin"    # F

    .line 188
    iput p1, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabMargin:F

    .line 189
    return-void
.end method

.method setFabCradleRoundedCornerRadius(F)V
    .locals 0
    .param p1, "roundedCornerRadius"    # F

    .line 196
    iput p1, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->roundedCornerRadius:F

    .line 197
    return-void
.end method

.method setFabDiameter(F)V
    .locals 0
    .param p1, "fabDiameter"    # F

    .line 180
    iput p1, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->fabDiameter:F

    .line 181
    return-void
.end method

.method setHorizontalOffset(F)V
    .locals 0
    .param p1, "horizontalOffset"    # F

    .line 149
    iput p1, p0, Lcom/google/android/material/bottomappbar/BottomAppBarTopEdgeTreatment;->horizontalOffset:F

    .line 150
    return-void
.end method
