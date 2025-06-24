Return-Path: <linux-efi+bounces-3936-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D0CAE599A
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD3D7A6C2F
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382F223DE8;
	Tue, 24 Jun 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VKY3KZmf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66532209F43
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731248; cv=none; b=A3TYfJYkdr6lM5/qZPZNRtARs2nFLFwMwQu3CYIVZRfwQpKkFp7VDGhG0zEslyYkN1nkK7hNJuodLIwk0WFrXJlxF/10a32jE+mnDDBEgEK1sl2UcYVOOuyTIOPfe/nxBSEBMxQA9MHCupeEd32Vn13Fjt+741Uv3aX6VRR7eSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731248; c=relaxed/simple;
	bh=0ZB/tSQJTgO/V9bw25UKkVrXHkwPDk176SMtQVZy7AQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ABwLzCinuzQFPfIyu4UGFTGhBhC17wdkQ5i1Qz4hT8GcxeCL8lOILAdWrIMbTnwYduBHS7f/3iAZYeRYJ5ENEVX/ma0pAmYTwPlBMD+QvLHK8II83itUzPzfXdrdYEZ39cexeNSVFSHhd9btkPixbyHwLbzvNZdI1CvME4yfXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VKY3KZmf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKlr5r015686
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AmT60A9lLQ9BuGQyHbamKb2liQFhTaf9+85rsO1JS60=; b=VKY3KZmfKORozMEd
	g6Uevva+FWVhlZwL8faIPGLO2lXyItKoexwRQFwnbN+1+Wy04GxrcevaBolvZmLJ
	MWhmzWWMTo96c47/3DFEDBoL5rEqHedbyvg2SfC/QRzuNWwzy3qNUMUaBJyL0kPl
	V6p46X+WPf0QSxJGGt1ulHSpmjzhHW6wyLkyUqPqKaK8FO8D3cf3efQiEBNc3eF8
	Pn3lH1eZpFLvT+QhR+JscCck40xIX6QDZ8KcsAEAcjGI4/JWqrnWDeF15chbcTcT
	xCsFFt6j09a7wE9c6Vz61+xCbYaw/nZ6RcWS+L4rL0ygUmgS3svMPCm3/7j2Pxlt
	IKcIUw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rptpg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d40185a630so662696385a.2
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 19:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731244; x=1751336044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmT60A9lLQ9BuGQyHbamKb2liQFhTaf9+85rsO1JS60=;
        b=hJCzYRbKvEsxChHI/erhf/DHBZTyE7Jr9eCoviQUVPmIKkMurQHf0GAU5m78SctB4O
         KztNZuj1GJVvzbNOP1WC0GrfNHm2VqRVAY9czhnFx8iEoghD0G2q2BxHC5O0adsAWM2Q
         h2PeAJDbsrXShHJoQ9NXRT9ttbMKnkBpzgJqHthUHKhznb0yZIs1hBZeg/GXcLe9XY1U
         k8QroyIHZltFvsUii5qEUwsOWdXO1nnFSvfg3cLewde4y2s7WrvENNYOrthCiln6Gb5d
         v31o12hjnZ6GOuJM2r+YJc77TW89kQzz39vz/a5KibrCL4knZk5uozcCgS6AeyJC8Dux
         Y56Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTNY5+jHYyBNA1ZJcO69EsSTpefbv+j+6jOzAKdff+qbKtYv/xxT6kf02WIeXRZTpYMQ2BGD4ypjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH78rF7q8fCsMlNNx5fUzDKHW1jn1e8g1FKd0Mk50C8QeWQSvz
	6HcqCinmlQTNtQFKjyBfXC37jS4oUjsRNJk30zDVkSmxMZRJAh9gzQ3E8tV23vxIDSaT+PlKh7j
	BuBPmomwWCf2hN/aCoEbHlnIrH4rZkjo28V8SUtWgfkiEq9Kq64hJ1L9mb0TQqUI=
X-Gm-Gg: ASbGncsLfgxWWMIlHGC34D5rg+fHqkUMhl2FL8vEVvkj8Kc7kU28siZ3pfZYFe5pQZ2
	wmKJrIlYBR7920pKe8FC40NSpcbHek9ANo5mUcPsbtpCEVncRrJaUJfThGuKVN2WC7uWiPvOMKi
	oBt/f5UrexGn+bweRKG1r1WU675+KdOZ5t+XFtEBJ+unWIPGjIEg4zIb7mU9Pi/LaltTcc8gpNl
	u6A4wtj3JZD4FSQBkjNxB0BZj20DMw3nBwVmpL0RiC9EHpjfxcLnxsidmkVNKLzvWHBvaSEbSN/
	R+diKP/oCxF/7KDlEWpinG3QyRnIf7mMgUUdJTmCsBRSkTkZachsL89lOXot7KjBz0WSphnpvQL
	UZBsuO/hE4BS5LEF+/siFmyABSbh0gMyUuLc=
X-Received: by 2002:a05:620a:4392:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7d3f995f1c7mr2572885585a.55.1750731244542;
        Mon, 23 Jun 2025 19:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYIL4+l3frydW5f5l5oqZb7/2v7MXWN/9Lgrqu/VuEHi7B++dwsM5L4Gh5qOtGXS/DiuKkOg==
X-Received: by 2002:a05:620a:4392:b0:7c5:5a51:d2d1 with SMTP id af79cd13be357-7d3f995f1c7mr2572882785a.55.1750731244164;
        Mon, 23 Jun 2025 19:14:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41446e2sm1637764e87.32.2025.06.23.19.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:14:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 05:13:53 +0300
Subject: [PATCH v3 2/8] firmware: qcom: scm: allow specifying quirks for
 QSEECOM implementations
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-more-qseecom-v3-2-95205cd88cc2@oss.qualcomm.com>
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
        devicetree@vger.kernel.org, linux-efi@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4148;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0ZB/tSQJTgO/V9bw25UKkVrXHkwPDk176SMtQVZy7AQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWgnlffFPCByp4RKefp3ZNXphmsBnCnVx4XS1R
 V5Q1j07lkCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFoJ5QAKCRCLPIo+Aiko
 1aeYCACWko1A2fakj7OHXikH01sxkD5jypkMNfkD+er9snZS8sOBHOyRBA5xSXFrDKYldT1vpES
 oGdMf5oDThzf9XSVunYVT0tJ4KdkuEmnAznWz9CTByqnEIStF0BB+nfqQYtvg7+GCrbTdX9x4gZ
 6q2ialmgnWIRTX9Yf2eLw/vE0kOemOH69Ip7ABWh2b80cmazsNbfqQ+Qke3v8ZI7M1M2QVBK35i
 EnVVYASvUZ120xd0DrxuJ4mQJN7sLgQ5mpa8oZrIXltYqU5ovk2Omwjegf/+QF9Oq3Yjx7LFVws
 pe14dBhueJpOTLsPi1XNk9D1DFzknFvgWfE+6LtXAWhZ2f2V
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685a09ed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=wTlJEWXFZO-q-0qxHBMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNyBTYWx0ZWRfXxAFwH0h1T5XW
 02VmTqeIJjQQl6PUO00ocIsFcWp39MNnLM1LlbMf4dfPTj/mdSjbicVgwcH/cbFLKTTEAMD/Py6
 paI9WtJSam7Ts/UNc9TLLR8NshQJHt22d+aGdEJpHuV9dGOSMKLxOyu/Xxd+5uNOrhTI5G8np3y
 8fP7djVdWBMSiqgMe07zNsD8ZfJjPiA0DQwb6GTudNuzgnGwWTvPiUnn8l38xwiB2ZXbaxNtwTU
 ocudDzNGS/YBlXpsCLvDpLwYlf2rPeb3v/P6gHDlXJRO3BKZxE5ELPpwS6aNr4IwvJPponJjO6f
 5Joh946q8Dwf462Vmk3p+B8DxfaVKKngIbdHWjUaBmt6IO+1NeGAsEFhxBeBbapThWQm4fQtuLu
 yATGRAoc2QTTjIRxvuR+SfwXqpy66fFCeZKMn5kX6eIr50pXUpRhN1CRHf41V78NhEfEFc6I
X-Proofpoint-ORIG-GUID: G9VYRizl6nc-HfMyKrWDn86IsWwqZ32E
X-Proofpoint-GUID: G9VYRizl6nc-HfMyKrWDn86IsWwqZ32E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240017

Some of QSEECOM implementations might need additional quirks (e.g. some
of the platforms don't (yet) support read-write UEFI variables access).
Pass the quirks to the QSEECOM driver and down to individual app
drivers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_qseecom.c |  6 +++++-
 drivers/firmware/qcom/qcom_scm.c     | 28 ++++++++++++++--------------
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom.c b/drivers/firmware/qcom/qcom_qseecom.c
index 731e6d5719f9e3e9e698f5de0117540f51ebab63..aab0d61f0420c4f3d6c1a73e384195b9513f3ef9 100644
--- a/drivers/firmware/qcom/qcom_qseecom.c
+++ b/drivers/firmware/qcom/qcom_qseecom.c
@@ -36,6 +36,7 @@ static void qseecom_client_remove(void *data)
 }
 
 static int qseecom_client_register(struct platform_device *qseecom_dev,
+				   void *data,
 				   const struct qseecom_app_desc *desc)
 {
 	struct qseecom_client *client;
@@ -56,6 +57,7 @@ static int qseecom_client_register(struct platform_device *qseecom_dev,
 
 	client->aux_dev.name = desc->dev_name;
 	client->aux_dev.dev.parent = &qseecom_dev->dev;
+	client->aux_dev.dev.platform_data = data;
 	client->aux_dev.dev.release = qseecom_client_release;
 	client->app_id = app_id;
 
@@ -89,12 +91,14 @@ static const struct qseecom_app_desc qcom_qseecom_apps[] = {
 
 static int qcom_qseecom_probe(struct platform_device *qseecom_dev)
 {
+	void *data = dev_get_platdata(&qseecom_dev->dev);
 	int ret;
 	int i;
 
 	/* Set up client devices for each base application */
 	for (i = 0; i < ARRAY_SIZE(qcom_qseecom_apps); i++) {
-		ret = qseecom_client_register(qseecom_dev, &qcom_qseecom_apps[i]);
+		ret = qseecom_client_register(qseecom_dev, data,
+					      &qcom_qseecom_apps[i]);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index f63b716be5b027550ae3a987e784f0814ea6d678..fc2ed02dbd30b389b5058f5cac70c184df7ca873 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2008,10 +2008,10 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(void)
+static bool qcom_scm_qseecom_machine_is_allowed(unsigned long *quirks)
 {
+	const struct of_device_id *match;
 	struct device_node *np;
-	bool match;
 
 	np = of_find_node_by_path("/");
 	if (!np)
@@ -2020,6 +2020,11 @@ static bool qcom_scm_qseecom_machine_is_allowed(void)
 	match = of_match_node(qcom_scm_qseecom_allowlist, np);
 	of_node_put(np);
 
+	if (match && match->data)
+		*quirks = *(unsigned long *)(match->data);
+	else
+		*quirks = 0;
+
 	return match;
 }
 
@@ -2034,6 +2039,7 @@ static void qcom_scm_qseecom_free(void *data)
 static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 {
 	struct platform_device *qseecom_dev;
+	unsigned long quirks;
 	u32 version;
 	int ret;
 
@@ -2054,7 +2060,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed()) {
+	if (!qcom_scm_qseecom_machine_is_allowed(&quirks)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}
@@ -2063,17 +2069,11 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 	 * Set up QSEECOM interface device. All application clients will be
 	 * set up and managed by the corresponding driver for it.
 	 */
-	qseecom_dev = platform_device_alloc("qcom_qseecom", -1);
-	if (!qseecom_dev)
-		return -ENOMEM;
-
-	qseecom_dev->dev.parent = scm->dev;
-
-	ret = platform_device_add(qseecom_dev);
-	if (ret) {
-		platform_device_put(qseecom_dev);
-		return ret;
-	}
+	qseecom_dev = platform_device_register_data(scm->dev,
+						    "qcom_qseecom", -1,
+						    &quirks, sizeof(quirks));
+	if (IS_ERR(qseecom_dev))
+		return PTR_ERR(qseecom_dev);
 
 	return devm_add_action_or_reset(scm->dev, qcom_scm_qseecom_free, qseecom_dev);
 }

-- 
2.39.5


