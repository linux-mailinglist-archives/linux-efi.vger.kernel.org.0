Return-Path: <linux-efi+bounces-3941-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE579AE59B1
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98707B2BC0
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA1246BAC;
	Tue, 24 Jun 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RhIrK496"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86123ABAD
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731262; cv=none; b=Sx9S1Meo4IJD0JFBh0uf4H2ES9QudpjhnH1yr7PehF0sPKW6e0kdBUo88alkRg9DtXuxclFB3C4YkWWyb5MZDjpm2bZ7bVbVXw477D1kc4U8A+fYu+R++qR6QNDXbgV+bmmlKAZhJjWp7+WTGLwBgIojmOQCEypcfy/4P6rLcqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731262; c=relaxed/simple;
	bh=wwPgZquGtv5ruN02X/fEQJ5qyMWldQS8yZQEL7GHlMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sb180DxvoYWhxdg9Kz9ym52vGTsfPCbjv6lK1Ruymc/QrscKxQ2H4Cjj9tc+XWvH+dDP+MizkY8UuqCWX2P5t2Z9tqcoV3nL3ucpLBB9Pvo4gvKEAlkvYd0C9hC+VbmoWsjccdfrdXb0ylWI/ycklQx/aA1fgygPDh2ZqjKlAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RhIrK496; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKmErQ016718
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tyyvulGuGpaTaUXvNlB8/sd2dCkHRiL8Dbbs2iTh6WI=; b=RhIrK496DGvoc9Wq
	TQqdEOsYTafZ1lXbcNr9n7kduseRDUEh9YBoZy+lFrygL8hAip0xcWtLTWBmPxTO
	2j1DZdgbzxPJFL84zRGE/kDitfLPpPnb89DkYBndni+JCeQ/DPz8n69v8s0yQiya
	/AQiMFSK8ciEP4WfRiZ2tvzu6e7InG/du1GtHvGxWmgzjQG4imYKsk/vNRBU01S7
	2CQ9LQ9kc+lYv8c/LAUPsNrinSBs7UnHEH5ng1+kp+YkBrxoIJrFU909NGzD07SO
	iBKARZA98YVixRxXxZyoE9bpkoDIpCrUR1v+NZ8kHoPA9FzIHr+rXSzBbzR0uF6D
	iYelgA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqgy5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d40185a630so662726485a.2
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 19:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731259; x=1751336059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyyvulGuGpaTaUXvNlB8/sd2dCkHRiL8Dbbs2iTh6WI=;
        b=NWQbVhmx/c/vCrPlqRcVsVclSVuiDi6YWeSxl/SWuHJpqMlVdRlghNi6xGvDWHCnQq
         MLLy4dIjTwMu1tLwv6ymYsipfyVPY199sT7hQOab8J/al8nAAKYpb9FR7O91nzzo3crE
         jwecvO7xbcH4LAkZbHZDGcDkcvZ1HnCeWYn1QeoxPQ77HH5yLOIzy6zJoeEBQdYVoMq1
         YtR8ks72RTf1ilEMvtFoIkIvhD6nBLpeWIwxphc03uY2LRf2+YGv8PneHhg4l3ZNMVQX
         5FzWt2XQqOs67as5jt3rYQtv4nkXMWwe84tGzkLlJuFSGX5sAudKzRzlSCZvdVqFl8UL
         tgHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH/oT2khMj/uVLPlP9Fa4YocWfgygmykT4IwCBzQBd0lzbMxQEpPVthunls3Rb9tBYc0l9tTjc5yA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzNq5BnuPgc2k5XtANErCHppWYZAu7/snQc3Nm9wRYSpMRLHB8
	WuaxHdMNwuV67GONJagh+Z+/zra9T6aXy+v7BDHX3C2fOO0krrHB4AgHquAGpo8nNlP3XnZE4ca
	DOaTM2KaLSXSI43U1WdqUXhpNHL4piOx4Qhs1PxpRTOEGQfieW4RYgbZPkQjXnyk=
X-Gm-Gg: ASbGncs2PxuslNgv/XekObX5S5pGYY7ZIDdrZHgk2ro7PLpeE94/MW+PhjN0gX3dNtt
	BWXGRuqybvuJ3jKgX4rcZTKCuRBQYFc9KgwoOl/bLeys7SIFh+0hm5Tgozi2XK+lIh8W7U88tzs
	jrgjdgb28eaVnGok06GJ2p+TPA5Rf7AFSD7cav+VuY14SGR3TTjLtVo49YQHF3Z5IE52S/A3pVd
	MoDR/WBcK2iTozWH3l115alGOMbvoGUvv5aotelqgyD4qgwffbAOgkhSi1qJN1k/hDa6I6YQE3c
	z9oRGWENwB15IwQeEgbkzlf72RTlh0Ao6Vxs8knFqweUytIMQl0/ux9BuyxkZI4DGDnuD/A+PDD
	y3CoEt5uVHZRVE3crwde9LvD3keVVfxLYoA4=
X-Received: by 2002:a05:620a:c4a:b0:7d0:a096:cf80 with SMTP id af79cd13be357-7d3f9932d64mr2264381185a.31.1750731259204;
        Mon, 23 Jun 2025 19:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA55butSic+ng2eWxkWHewC/1gHyAW1PqwPfZPRr+TsnW2sMpp6SRzI1+0SpA8shvosX3lrw==
X-Received: by 2002:a05:620a:c4a:b0:7d0:a096:cf80 with SMTP id af79cd13be357-7d3f9932d64mr2264378685a.31.1750731258714;
        Mon, 23 Jun 2025 19:14:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41446e2sm1637764e87.32.2025.06.23.19.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:14:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 05:13:59 +0300
Subject: [PATCH v3 8/8] arm64: dts: qcom: sdm850-lenovo-yoga-c630: fix RTC
 offset info
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-more-qseecom-v3-8-95205cd88cc2@oss.qualcomm.com>
References: <20250624-more-qseecom-v3-0-95205cd88cc2@oss.qualcomm.com>
In-Reply-To: <20250624-more-qseecom-v3-0-95205cd88cc2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wwPgZquGtv5ruN02X/fEQJ5qyMWldQS8yZQEL7GHlMM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWgnmG1HaZB/YzzH63NYrvRaoUuv8/0tpXEBpI
 iEyvwE9gBqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFoJ5gAKCRCLPIo+Aiko
 1YhKB/9SkuLIh9Eh2/Cyz3LLhzdaEGoxyryhuSqprotgQQyo4Emt0TqpBt5aW0XKf96gbkh9iRD
 CTE2U3rM+DE9TtfBW8fAFWuZSNSRlagYb1kUoqgcT/ZDbN/Av7r2eUgUuc/5twxpbSzrzIpNMJO
 uiDsAbHRd3euOJmD8zyDjBmQcg+/l9Bl9WsQNbW8EQwop8GXOnjBv2cij9GOv9PURcJ/ylFfKU+
 ZrWP3Djdnb1iC9UAry83VRNtpJIP2DC9aQvv2zpUECjFZf682RYwQUqPYfea9oml2Io2eiUMFbz
 GYh2tX2XCvtFpT0YdWbxSw9Oc/hv6CFOCRe1G1mOyJkTb1/E
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: f7n6N9vpeAcelnGkIduNlfXLQcm7QJAl
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685a09fc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=lpcYNmPcDvg0ODyLRbEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: f7n6N9vpeAcelnGkIduNlfXLQcm7QJAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNyBTYWx0ZWRfXwjcOcW2juopy
 YegYK9DVYrglpTCysrJjsXiJaj9x8FyIyWOY6XRgAI+7xtlbEG8NTcF4NONbJ7/ZNvoFKMwRF4t
 Yz4nI2tEblCJgDF2/8X//BDPkA2mjHdxXtAnp0YUXuK2Xv8klyWVF3oMY0AZz8epB+QkjkqhZtq
 KPSfQ+WLAmt8sg5kG9ys4pldO1q9J/iLnTQ4HHUlzlU4pgjISS1VZgTN5SXwkTXlXRGhCVHC+X3
 v/YNUYn+l417JqyEzC2LoYYBPz3uh5FIgipQZjTGCK/uf3mLuhpxifpuI0vCXvjTezoUND6j1qw
 abJ7vXT9X+XG5xsc1Uno8nbMs6seTeH/JF76mUO/cMBybDXeAVGFvrwhFMDR6NVQEIAryZV2daj
 xiW0Hr7jKM93LDa7Cr1VA2Tcnl4Vhbi3DlX/kqNUOIMJ37N7xEKNz46tfAgsy6eGerjM92TX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=982 phishscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240017

Lenovo Yoga C630 as most of the other WoA devices stores RTC offset in
the UEFI variable. Add corresponding property to the RTC device in order
to make RTC driver wait for UEFI variables to become available and then
read offset value from the corresponding variable.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi                 | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 3ecb330590e59a6640f833a0bf4d2c62f40de17d..50b41942b06cf1a3f43f9c754b3bf2e1eaa4d353 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -101,7 +101,7 @@ pm8998_adc_tm: adc-tm@3400 {
 			status = "disabled";
 		};
 
-		rtc@6000 {
+		pm8998_rtc: rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
 			reg-names = "rtc", "alarm";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 8ef6db3be6e3dffe4ec819288193a183b32db8e8..c0c007ce8682cacd1cbfe816ddb975c0a099ac89 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -592,6 +592,10 @@ sw_edp_1p2_en: pm8998-gpio9-state {
 	};
 };
 
+&pm8998_rtc {
+	qcom,uefi-rtc-info;
+};
+
 &qup_i2c10_default {
 	drive-strength = <2>;
 	bias-disable;

-- 
2.39.5


