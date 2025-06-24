Return-Path: <linux-efi+bounces-3942-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96826AE59B3
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2100E4A6DF9
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FFC24887C;
	Tue, 24 Jun 2025 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mTbTcNjo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0620124468D
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731263; cv=none; b=mvnmeOhTML3pLVTzHbSdjFI+n6qejp8XRWJT6RywId9iYDfqPH7L860eChk7X89bwntegB6hNu7p5C6oQi/X/VNZZSFZDO33Hpp7RTlYX/Wu4VCAtEeOWdDn9zjqATW1YzjmaT8E2xBGeFK44+FvrIhl41E/B3ujaxj8cHN6nHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731263; c=relaxed/simple;
	bh=s2o+RnAnwuuTYdNz0c1fk/UXp0JDkRHvl3NhwSnxORg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V5MR3fFBB+aevrK925BXBqu6cJO3w5ib21I9WwEd3sHisyMLsoxRvIneSQUZAd1BnDa4muUMf4/UmUu5hExkcO8d2oaBs+cWwy+t3strZ4AB8jP6/gwWWBERgP7gVa8uMJMbupdl39vFNYZrsJGmAblfwyvCISilFqV71BZArKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mTbTcNjo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDRrEK017016
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rXsS7jxuGefUn2n4a2PcfVZg4ooOKFqRyiTGh+plE6Q=; b=mTbTcNjoFIMpupY3
	M9nf6M0iO7jrbBzOGCTzmv3I2kNdXddeHZRe0dd0S5f+z8qnJv1CHG0J8AoxAZk7
	IOrfelL6P9VYacCnzrgEJgoXHNMv60fcBq+41/cSO47ZY6TS8TcW/FkmPBPfEErX
	kVaX4UR9oF/IDnupDcV3/1+gtp+UheDaCCwSjESMwRiDOY2DrEJHP6R8r4wMgNrw
	N+lqT1YympUowDsgf7W9iGveMmU5bISNygHLS0U9i9vV5K7nN4e4j1zXhXUSNgEn
	3tvuiPf8En5fSQZmNmtewgJaiGNpuqB8HZU/eaMW/NOaiXxSn17UROsd53gXvhFs
	M7DviA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f7ttspwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5e2872e57so745975985a.0
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 19:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731260; x=1751336060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXsS7jxuGefUn2n4a2PcfVZg4ooOKFqRyiTGh+plE6Q=;
        b=hAsMPoQMe7sQfVUKTmeD9R/pdUHsglZo1rw0Aw/bOmrSfb3Zx+z3zRMgUVkBSCCRAa
         0p9GYTWnDU9mJZPtuaOTNTECDmMFsJDGjH1kmQkZN5Vgv/5Al6sDb96yaG2EwfGZeEp+
         NC/GGfeBBi1P0XwEEBhjq1XEPUoV7Kpfoel4AbjVNydD+rhT8yS6nxk8PFO6Y0sVxaxV
         zJYc4RXTTzBtUns4rZ6U148f6r3JHHAIZkBX4zCLfq/VAVkhfJXwGYkBFKqBHgrrxtmZ
         0I7HAtuWZyEFU/1FWmSdvMgFUgJZzskGuGXFLjEr5vppTpUAK5rc5EgTeb8LRbuQu0z6
         jNkA==
X-Forwarded-Encrypted: i=1; AJvYcCUR2SHQS4dMFMZ8Sk/FJ6Y225mU1DqWQ+eIwvSVH3BYu4NPx7u6+fEq9PRcddGY4lib0Ek0rOUIT48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzOvmizuwjdtuPLPjjrlGDmnkHNcm8lbbPwWXWpR9BN/sGFwe
	3HV0zJ9IoToO5pr4mKtHoV2fPJ6XP0WL7P4GVUfu6o2/ufgokhpKNI5QXsdtSq3QJ4dw1kwSmrn
	XyMI4sSIqX98KOqiiZBsifDN10L6BeHBxTzyFNSC4159hDj1WbwJR4OVeEegqWzM=
X-Gm-Gg: ASbGncsgwlYNdTimr9QqjGGab+pdRIQJzRWWbX7tYTlDphsaMFmf3zpZ6mQIHyfobYP
	xXRO+2KqtoULP1/JZiIYJeLa0CEMAMK+naGdTRAC0cBKOY5FB2gjqw16XynopyuhzefKVwumz+W
	1J3ejEzAa4e8r8NAsmlZ1BCOmUani3V+AyYaJnO0gAnG5cvpBL83yqwdPAu1JSDgkKDqj+bvwkD
	zlcWuUvp+S/yzL9Gy/VdDmiVLkpK6mYoaJvuZVfeASHMyasbevPJXTn2rewO7djMSPD52yzmnzg
	i3VzZso6zskmaPOB8OTCHsH23lkaQ98dQDJBioKdj0aMlYva1OCqsQTxlUlPdibcD17I52wh14G
	nykwxv/dviYBkpQtPlBN6aIZ1BZpgLZheET4=
X-Received: by 2002:a05:620a:1922:b0:7cd:331d:bb3e with SMTP id af79cd13be357-7d3f9935e7emr2022904385a.32.1750731254912;
        Mon, 23 Jun 2025 19:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPRQEcxIl/1tKf9CY1/kqMs19qtzRY7gdh2XwyltdEkmnKpY5wXHxxDtB4ZK5neoLM+qrbsg==
X-Received: by 2002:a05:620a:1922:b0:7cd:331d:bb3e with SMTP id af79cd13be357-7d3f9935e7emr2022901985a.32.1750731254441;
        Mon, 23 Jun 2025 19:14:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41446e2sm1637764e87.32.2025.06.23.19.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:14:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 05:13:57 +0300
Subject: [PATCH v3 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-more-qseecom-v3-6-95205cd88cc2@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3235;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=l/2vDz7zeLnp6OwntquJZV6YAtUYQ1dSv5z/W2j9Xfw=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0YU57MOZyPTF/dlmU/ODlc/cNRYcel5y538c/YknT9vr
 KZ4qP5cJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmMp+N/Z+NbJ3txjX7GioD
 /sdFlzMbu/ieiEotK///rsihPOJijY/1k4+bL22pOzPdPkiM629qs5+N0VG7X2tSfUulSiPflqZ
 l7tml6dJ9Pn+Hw/IeuSOn+H79nNe0ZEbNWen5n+/GKUcEJi0X/JI+J65Ecb4ot0yh4AH7om8MtU
 FLD0yNbcuQ3OVw/OSG8ss3Dbse90spqpXvPqpZsJl54b7bTpXSonahWyZ9Yr7Tk9fNl/M8vU1a4
 TVzTVb+f6bLM9Y3bUyV1I3eU51z1b/0v873JzHz/t/VSBSU2NTxYbXVtB/3/qlMaS1hWcYgv7lb
 Uu6nROf8g5y5jA+N2ZSKU/WvfTy1k7m34nP1nQsHFNIcAQ==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=QINoRhLL c=1 sm=1 tr=0 ts=685a09fc cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=JMKUWE_9wimnfyHsXasA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: a9tWinRbgYBJJvGDOS7oipoFDtF8ZkjC
X-Proofpoint-GUID: a9tWinRbgYBJJvGDOS7oipoFDtF8ZkjC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNiBTYWx0ZWRfX8Bl6jxJngM21
 PKeHbUtA4sTczY3OQ41S8isK60jY4BICfwOrAzQqwb5WYM2iLbsdh0yx+Sm5KtRwOIo+AdQSiYn
 EBV39WRzfHFaozRDe2oiDz9pv0t3RPN1kHIP0VhGI8YC7HPwdouzsrAMGUuoTD7/lnWJHjlYOOs
 ljshrNIqw5TPmSJdUX80U074p1Cjxk2k0aBNnQRAs3oPKdj6gEJvSHjCPDWo91r+kVPl5rV0QK0
 rD0O9KIehKPl5z+BxYcasuRPYJAMU2nysZEnAFFCRXHk8HParqJDDKxpqiZ3nvNB1czENHT7u+M
 cmVjQYBtpJAaL3V8DooUObs3B00b04vVxD3MlCh2aI36BK/Ehu9XzqT6fkmK5XivWvYaHjBfKOn
 YifDHoJ2eC9YfiOaEhA/4wP0afMSi7fmOYpkhVP+/tn+jB/tI7oFD6eRh2eNVP3mtWhKQLTF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240016

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

In preparation to enabling QSEECOM for the platforms rather than
individual machines provide a mechanism for the user to override default
selection. Allow users to use qcom_scm.qseecom modparam.

Setting it to 'force' will enable QSEECOM even if it disabled or not
handled by the allowlist.

Setting it to 'off' will forcibly disable the QSEECOM interface,
allowing incompatible machines to function.

Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
variables read-only.

All other values mean 'auto', trusting the allowlist in the module.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 27ef2497089e11b5a902d949de2e16b7443a2ca4..5bf59eba2a863ba16e59df7fa2de1c50b0a218d0 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1983,9 +1983,14 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
 
 static unsigned long qcom_qseecom_ro_uefi = QCOM_QSEECOM_QUIRK_RO_UEFIVARS;
 
+static char *qseecom = "auto";
+MODULE_PARM_DESC(qseecom, "Enable QSEECOM interface (force | roefivars | off | auto)");
+module_param(qseecom, charp, 0);
+
 /*
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
- + any potential issues with this, only allow validated machines for now.
+ * any potential issues with this, only allow validated machines for now. Users
+ * still can manually enable or disable it via the qcom_scm.qseecom modparam.
  */
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "asus,vivobook-s15" },
@@ -2013,11 +2018,27 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(unsigned long *quirks)
+static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev,
+						unsigned long *quirks)
 {
 	const struct of_device_id *match;
 	struct device_node *np;
 
+	if (!strcmp(qseecom, "off")) {
+		dev_info(scm_dev, "qseecom: disabled by modparam\n");
+		return false;
+	} else if (!strcmp(qseecom, "force")) {
+		dev_info(scm_dev, "qseecom: forcibly enabled\n");
+		*quirks = 0;
+		return true;
+	} else if (!strcmp(qseecom, "roefivars")) {
+		dev_info(scm_dev, "qseecom: enabling with R/O UEFI variables\n");
+		*quirks = QCOM_QSEECOM_QUIRK_RO_UEFIVARS;
+		return true;
+	} else if (strcmp(qseecom, "auto")) {
+		dev_warn(scm_dev, "qseecom: invalid value for the modparam, ignoring\n");
+	}
+
 	np = of_find_node_by_path("/");
 	if (!np)
 		return false;
@@ -2065,7 +2086,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed(&quirks)) {
+	if (!qcom_scm_qseecom_machine_is_allowed(scm->dev, &quirks)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}

-- 
2.39.5


