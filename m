Return-Path: <linux-efi+bounces-3965-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C356AAE7296
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 00:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A50416EA63
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B006225D53E;
	Tue, 24 Jun 2025 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgTEzcUQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404825D205
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805618; cv=none; b=DfKbzO5h2FKYQtfMDv3GGUA3PWSQ5JGRF3LCnFcNmyw0hChxnLHMQEUbJhf3M+et9H4FQEPg9LP4ExLeRX5XKwlwyZ9n5hMbvNuGpab5GFFXsZKmejuYA4sTZ4wJwJS1b0RxtZPIkT4S90WezjSk3I9qz0oaI9HiB9kWWNP+Nrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805618; c=relaxed/simple;
	bh=W0YLJNz5/2SAiapxbVHEzsfqeAiPqnoxKuIVDr0TVNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIFseV0rDbCBHOVMhORfCN5EfIxPvRkiVFyU6fJzAXVcN/zbHYUFhpRKmqzUmBc9aqXfJyIlbkMwrLzUzlm2L7gwrl6oCbidRRU/fzAuQ6vKYGD3iTfZzu74dz9JNoy+Bi1k8ovsQmzsQv5ugGYaQjbgTOgD6qA0xU6mL0VI7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jgTEzcUQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFCCBp028021
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 22:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PYGYwAigTe4Xg8FBE8LvVKj2tXUXuFCqznUuXtFksk=; b=jgTEzcUQJEULxLqC
	XiSOzdXI0rEcSbcfgr0UxPef2I6p2NEV0dA49pvPKa+GHnfoKPiO20rjwmGGx+0B
	EIcAzPOFOwhqWG7OQSpig5Fg3NP5wzHIIVL8m9tHge2IBm2O35XN+q6N7eo0WB30
	gwtZPyEIJNX4PUpcuVdslWnYQ17WjP+Y2AgMpsYNhpSCZlom1s7rYeDTIptBEGWC
	Y8I5MGHFGfA6xtLwTZn6xjwErx0a6oL1uIDQSkS7x/MsW6jC04r9XlB5GScX+mcY
	rNB6T/h40ya7HpKijr70bxU/6ucoOLL4DTVPsnB154xLKnybLFZUQnas+Zfp3NdV
	PyiV7g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqmat5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 22:53:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3f0958112so140688485a.0
        for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 15:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805615; x=1751410415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PYGYwAigTe4Xg8FBE8LvVKj2tXUXuFCqznUuXtFksk=;
        b=KOxB0krn2l4ZkVP/LEAfAqdZW/YjR8yxq8QkOgWca+4rnB2GlQwCPJieE0aGOf/llB
         NF4jpnPgxrxp/14+GRPcgLKBq/ZXVqyQIr1ykjYPwZNSBLyJuRFkImE+kHAL8QNSXrap
         +T+hLWrliHE109pC4HtcF68ja5Zy7ePQkVeJIIYySI7MohC+XNDFX9bVZT2L0O1LBJ7d
         wEDxYodvUW10xjsCIZ9nOhWw3pi64UOoa2URiVQe9DoJ8muryoiCdTC+srOIiNuGC7Yt
         d73ShlFryoYVP9fxYlhuaRda959PGi/riccT8dvq2073UYrSqu65+q8j86IF696SFkuX
         Pfcw==
X-Forwarded-Encrypted: i=1; AJvYcCV8t/3A+PqanKcL/1SuEt+120cItm1+o4GEjB2E+//x1PSUVq0q9gENfu0wt0xUQNWi+HY6uPtpG2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QEGzhQFTqVoHCJeAgGx66gIBsHlS21Iepq+4ZQirXpcucPt+
	PbKTeLCOxJMLkc04etSjwJHRtd/cCv6CQHmKf6PlUgWKlUBQbitVZBmTJyg39bW1F/sDlD+FEYA
	2UEd70oF+/tukcRJXXvOgFjmh4qlY49Hfldq71DqPiwTlhV7nZP0lUoXNObNRliA=
X-Gm-Gg: ASbGncsbgx6gJraOc50mr/87KghPrvr9bpqoZUqt1LwuEAEkmqDn5giTMUeHBOpsxkS
	k6i16RrFI1nmYpfD5XieldNvtCX8q15YT1R2wZS8j1GmwdjGk51cxjte1FH1kEgN22gdZTmkf15
	/J/entdL9tJshfnul/Kf973QR7nFcVb7R4K0uzmFTrTyOEHypt+BE0b4Z/dtsqGKHzjpwfF2pGw
	0AwFXe8/DBrbNbjiOBftexyvQCZtiV4DGmNmed6ER6oLOledsBLCFNjZsLwbqPyz91gLP6Qdc2E
	M6o+ZuWzVQlzfTlLk+zzSV8v6Vau39454x8+f1k8J2kiQhhRC/X+9VUAyz091F6dR3+LdhW2kyj
	MfCzgm0+de2i+X2NTsT17WsJlxMnoHabDodw=
X-Received: by 2002:a05:620a:4050:b0:7c7:b4aa:85bc with SMTP id af79cd13be357-7d429660e04mr113562685a.17.1750805615331;
        Tue, 24 Jun 2025 15:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41nDKvy8NSvFSuE+GkqRN5rEbL009m+aNzEf5Aeh6gwiaJ1JjFjqhlwEUZpFQ41nVpXLjzw==
X-Received: by 2002:a05:620a:4050:b0:7c7:b4aa:85bc with SMTP id af79cd13be357-7d429660e04mr113559785a.17.1750805614907;
        Tue, 24 Jun 2025 15:53:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32b97f5980bsm17843851fa.7.2025.06.24.15.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 15:53:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 01:53:24 +0300
Subject: [PATCH v4 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP CRD
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-more-qseecom-v4-5-aacca9306cee@oss.qualcomm.com>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
In-Reply-To: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=W0YLJNz5/2SAiapxbVHEzsfqeAiPqnoxKuIVDr0TVNM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWyxj0Fb4cA5VMjgnwN72vznUyGiXQ/4qhUCvh
 dIttwizDleJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFssYwAKCRCLPIo+Aiko
 1Rm9B/9T0FUesziKizU38v76pcYTiA6w4sBqSbxkzsktq0nA2q0sSBVPUtwLWt/yJTIVokgN04M
 MFcYDkc/AS1ImaYPtlBWux5XC4SJCh5Nvbclq5BxJDQ22fkijV0vrgTxkfYyn4V1FuzupIeWoQw
 Bx2Bzktqtj5ShsO6vI99DSh0LYEp9cDpfWoQoNbfVvQnwKvRKKaoSzqe5u5sJ3O47RY2qiOQOlj
 cRIPTCdVRn/bREB+itNQJVAkcUc7TqVPcxixkQYqtMS7Th7Bdk0bxLnR8ru6bEsFnVz5bXKEmaI
 ynV0525X9ouUotWTbiY7J8Vn41M2wQYrYfMAUj6zMaXXHDub
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: tT9tv0i2wGUXi6BzI07Nq3EeLm0lXa9p
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685b2c70 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=GpPnMnrImHjYsJApwW0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: tT9tv0i2wGUXi6BzI07Nq3EeLm0lXa9p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE4MiBTYWx0ZWRfXwHM7IQv5AfRV
 kuNBR14LdAvH6drxe/YTpphUSWbUyqTYxLQ2NXur3za8pxuFN3uFbResvWcKeyOUrDWZoAprqJd
 p3asxCASpsxhuyJ0JWOuxj+O2QD3BLiBDQD02uJo+Ddz9Cm7h5zXLt2eZjMu67FMfBDPB7mWzE3
 7j0ojhhswBYQPzYJEZpEFYpVpHrjK3ZiIIHU0pBfqjxi6v2UAZpgMlHKTVqCIUgWhiKtF1MODWX
 5Wj6yeDoiss67rVNywJBCcs8UIlGl/JjtZRCbLVZTKHUmZblkZHqqF1U4/Ucx/oj9qo9y4gPKNj
 QNhzLTug+I2bry33dW3nK7XeoYrCXinHLEx/tkwVq5jBtnKqfAEGTu/jnUIw8q/9KOGIQJE4USf
 7Rij2zcLrTKtiXB1K5KaG6HOP//+0/tHnPUJPXx7GIZnhKF2m6fJhe/UW+yavmgTTg9GvA3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240182

As reported by Johan, this platform also doesn't currently support
updating of the UEFI variables. In preparation to reworking match list
for QSEECOM mark this platform as supporting QSEECOM with R/O UEFI
variables.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index dbb77c3f69ddaa931e7faa73911207a83634bda1..27ef2497089e11b5a902d949de2e16b7443a2ca4 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2005,6 +2005,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
 	{ .compatible = "qcom,sc8180x-primus" },
+	{ .compatible = "qcom,sc8280xp-crd", .data = &qcom_qseecom_ro_uefi, },
 	{ .compatible = "qcom,x1e001de-devkit" },
 	{ .compatible = "qcom,x1e80100-crd" },
 	{ .compatible = "qcom,x1e80100-qcp" },

-- 
2.39.5


