Return-Path: <linux-efi+bounces-3937-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07407AE599C
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1913C3B416F
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219EA1FCCF8;
	Tue, 24 Jun 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjdmwOXO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750962253B0
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731250; cv=none; b=pHlQzS+hPixRoUnaSprLsW1FlJBVS1YNKI3NofPrr4NhUgG3TYOqf/d9yiaxC13xEsKRUucSB0xUpnCUJ/wDRSijWbQA8X03ww0kArJD2NawtLQM74vyCArDzGepc8rSBpldbkRxRXgQbcOhiBi66DK9fjP0EfU7yINfbCzK2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731250; c=relaxed/simple;
	bh=wG551jlH0C2VxSckm5aelE4czzDPVSQlL7LK/7YjW04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JRyQgSLUWFPncCbTyRlTpccPtg5R3CYf8lTYp7FEFPt2vzZnyjSxLsp0HGWCqLDqP+ctJtxC/FnLGSwlU57JFirqC3i1zQ5+EL0VJR0B/BDU8tEw2nHqrwlroE5bRHDMiVzSvpiKN1C99zpOQO3H4l++sbD3qi9JOnIp18BXcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pjdmwOXO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKlA4r012128
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cvUFSAy9l8jMi9mogfX6vjAbGULsygLy9EYrsovMUQs=; b=pjdmwOXOmVPsTvYX
	Wx8Schg4YuQH/zvPFHiWsYud922Kza1sKs9PvLHBX3ff7uGQ8v2V69Fk79Oc0+37
	SwBpK2gx6ND9SS3jbcakmeahzK3QHNlmSNw4qcbCIt70d9Khslr4e4Dx9l/fMY3G
	Kd6UKR6eVGyV93+uKd4xqCcxIOAra81gmFd0lbh9i+2nIPrbkCRAdKtApMSEisTR
	yLDBVP8BYOxTtD3wiKmM5fJGHvmjv1aBn1QayuVt/laImqRysMWnTSrvcd+05M+t
	VN7d+ixaqmk/ZBQsTRsrThIn2NXXKS/QbZisf8MiNs3pRC9W9qcFR13/dH5WIkXx
	VO6DSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm1ryxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d09bc05b77so799724185a.1
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 19:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731246; x=1751336046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvUFSAy9l8jMi9mogfX6vjAbGULsygLy9EYrsovMUQs=;
        b=bcQIY3ErMRPwVuz6NABSyXvDuRnv3Y9qh93upbHtoPBemvKVLvV/qSRzzlZXCQbZHs
         FrEpeE2AWwapKnajXcuA4pKptJhbeKlkiOmMQdL8Y193pPRP96wD/j3cJvBY5dwtbC4n
         2aHKpWOPhLIcRKidUEyFFhWo6eJbu84+bPO4HdRFF3L3RnqHidYPndTW5aoU+7oKTSM5
         X5S7xrytncBALhaqGsPGQN2MLjFcARbwltxf/HqM7V7vRLQRwPH2IUs75orzBpc2q34q
         VX0WsibeXN0+tDEFe02lytk+nUF9Q2MHS8VwpkgjeGydwgtGeWFojQCxXb2B08ZHj/oA
         64Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVBZJTNQoUq2pE7AVj8kWMtrdIdDQ7PxWEFi8atl7lh4gXdZOTAuAzHjJr9YyN0KY1iwfYFMohRMEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBAYlcBM/wULR56zaBuTZeHXNq4/nB9jV+12TNYD2KlW9R5FE
	RLIkEYdZCBK2OX8SC1EzBPfXq/I1qCK9ZgXj81379vnO6ILsDFdoEDMkLWOXRTr3n2uUJJKE1e8
	/ABSJ+7/5tkQU21lCOszFRl3xvmHK0C4PjTlf4X79sJDdZnxXtjCFjLvj0jedZ5k=
X-Gm-Gg: ASbGncvVKLhSo9BU1/p2LvUO27RTYiH9BiAzGw1k98idtmpG1WiQlYXSLRUQYZACuh7
	SuY8PPP71qM8RSzM/FpcyIhWZh0vk7ZNJxGdtlUkBNyqpqVawioIXiCsfBEyGjb3mYAnDs0eguE
	aVwGJD7/5dwK2j6mU+CCwkOVy39tK0HNP9Wk+6TyYwdi+fbWv/uoHWtvrwA7fNdF0+Y+Ahes2MN
	4+E9dMDHkD3u/5csJ9Ybja/6W39MJpO8w15SxNVsU5eNfXM/hDQ7KiZsy8OkuzLAosN/m1Qx5GV
	H8vkhvEYwM0s/JCDKjKHsl95+B4uvCxKI5JnaHZ7wHhbtUeQEbN2M4dXDKj8q0zGZNo2HbgVR+p
	Txcs5cR+oFSUdJzKM0r/RqgrXXri1pJpM0yY=
X-Received: by 2002:a05:620a:2947:b0:7d0:97d6:e94b with SMTP id af79cd13be357-7d3f9935975mr2351199485a.31.1750731246379;
        Mon, 23 Jun 2025 19:14:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkXbJittVHOSyXOOLR1ysMuHaAOy9QfdW5AffuasgX73iivo36XMGte8oHvZuzT9Ip0TpTtA==
X-Received: by 2002:a05:620a:2947:b0:7d0:97d6:e94b with SMTP id af79cd13be357-7d3f9935975mr2351196685a.31.1750731245967;
        Mon, 23 Jun 2025 19:14:05 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41446e2sm1637764e87.32.2025.06.23.19.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:14:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 05:13:54 +0300
Subject: [PATCH v3 3/8] firmware: qcom: uefisecapp: add support for R/O
 UEFI vars
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-more-qseecom-v3-3-95205cd88cc2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2869;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wG551jlH0C2VxSckm5aelE4czzDPVSQlL7LK/7YjW04=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ0YU51MeVrlae4UlrlnnYqbzb/6qnhx8TOdaYcICmbnXL
 vuwf7vXyWjMwsDIxSArpsjiU9AyNWZTctiHHVPrYQaxMoFMYeDiFICJeL9n/+9jxL3+bqdxJOf3
 82b9bDekLtscEFZocS+zqC/6L9v3QYxn35TgxxHVi7a0uIXyOr/tVTP443dSgyVdu+vWF7WEjdk
 LDsj06Lc8+Sb6QFjiRrzcNPd/EzPfRTxuXMf3q6nBY0eL+1kF+8MLd8Qec1jW+qBH2+bGL/+ab9
 90/ee8WHO/PCjX6VifckiR644jxVEH3zax7TZl2hB3adYWnc97Nx4IqO3TZSxy7t9SxH0sYE7a0
 S7JPKZ5/161PklOz27bEGGdWnlOsijIz9y3frPxrq9FZrGH/od+ehryMO78RmZn5TmbX/orJoSV
 rXkQt9x/6dbFz1U3Ky/slucy47q3dGJsZrZy0rxM3y13AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685a09ef cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=hoImanld2GFzOgiN87EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: -pxK58doX4WNeojvMJ94s9TN8ZLyr0DK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNyBTYWx0ZWRfX7Q6KiQnW73MA
 RbYj2oGsq/zT1vtFE9niq9PAFjPTBE7cQXmJgnN4vcxTv1GhNWWDoZXN4IauvPHMz7oFbSUCXva
 RmnclVlkDcif+q10eMM18AYzPcz12kpWMyCkFwjnAF7df8UA6qfR9gU+d5ZH2HAsdFymXkBa1Jr
 HkjOvCtA0X2JD5lYC6/o4zU6tsBMWVakCWvqv7uxmdLXoBmkKx3lD2ibUD/WtcEdWEMIruvLY4d
 YVB03jn4g3tNhH20jMIvrDyQ4YWFcvfZFEIZxt7uu5W8n0Rhu/aJJoNpRhxq25iEQGKOqqIYsgm
 159nZ3VBCJqnRaK+McHRANc+91t6y1oT1q9j4HhB9muu6pUzzv/d+go0VY1Hke3vWbdkKWA1YMy
 33+e0PPPCavhrA0sn1YLbM+6zeRnx2J79xcArOtQhfbWvxwNI/zOmRyuyrzqEaSRIK5F7TQq
X-Proofpoint-ORIG-GUID: -pxK58doX4WNeojvMJ94s9TN8ZLyr0DK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240017

For some platforms (e.g. Lenovo Yoga C630) we don't yet know a way to
update variables in the permanent storage. However being able to read
the vars is still useful as it allows us to get e.g. RTC offset.

Add a quirk for QSEECOM specifying that UEFI variables for this platform
should be registered in read-only mode.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c | 18 +++++++++++++++++-
 include/linux/firmware/qcom/qcom_qseecom.h      |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 98a463e9774bf04f2deb0f7fa1318bd0d2edfa49..05f700dcb8cf3189f640237ff0e045564abb8264 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -792,6 +792,12 @@ static efi_status_t qcuefi_query_variable_info(u32 attr, u64 *storage_space, u64
 	return status;
 }
 
+static const struct efivar_operations qcom_efivars_ro_ops = {
+	.get_variable = qcuefi_get_variable,
+	.get_next_variable = qcuefi_get_next_variable,
+	.query_variable_info = qcuefi_query_variable_info,
+};
+
 static const struct efivar_operations qcom_efivar_ops = {
 	.get_variable = qcuefi_get_variable,
 	.set_variable = qcuefi_set_variable,
@@ -804,7 +810,9 @@ static const struct efivar_operations qcom_efivar_ops = {
 static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 				 const struct auxiliary_device_id *aux_dev_id)
 {
+	unsigned long *quirks = aux_dev->dev.platform_data;
 	struct qcom_tzmem_pool_config pool_config;
+	const struct efivar_operations *ops;
 	struct qcuefi_client *qcuefi;
 	int status;
 
@@ -829,7 +837,15 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 	if (status)
 		return status;
 
-	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
+	if (quirks &&
+	    *quirks & QCOM_QSEECOM_QUIRK_RO_UEFIVARS) {
+		dev_dbg(&aux_dev->dev, "R/O UEFI vars implementation\n");
+		ops = &qcom_efivars_ro_ops;
+	} else {
+		ops = &qcom_efivar_ops;
+	}
+
+	status = efivars_register(&qcuefi->efivars, ops);
 	if (status)
 		qcuefi_set_reference(NULL);
 
diff --git a/include/linux/firmware/qcom/qcom_qseecom.h b/include/linux/firmware/qcom/qcom_qseecom.h
index 3387897bf36843cccd0bd933dd562390bf674b14..8d6d660e854fdb0fabbef10ab5ee6ff23ad79826 100644
--- a/include/linux/firmware/qcom/qcom_qseecom.h
+++ b/include/linux/firmware/qcom/qcom_qseecom.h
@@ -51,4 +51,6 @@ static inline int qcom_qseecom_app_send(struct qseecom_client *client,
 	return qcom_scm_qseecom_app_send(client->app_id, req, req_size, rsp, rsp_size);
 }
 
+#define QCOM_QSEECOM_QUIRK_RO_UEFIVARS		BIT(0)
+
 #endif /* __QCOM_QSEECOM_H */

-- 
2.39.5


