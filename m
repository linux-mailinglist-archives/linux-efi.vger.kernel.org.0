Return-Path: <linux-efi+bounces-3939-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB9AE59A7
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 04:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A160B7B099A
	for <lists+linux-efi@lfdr.de>; Tue, 24 Jun 2025 02:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB67217F3D;
	Tue, 24 Jun 2025 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BrGSRHkJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756423875D
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731257; cv=none; b=FI4G0MFAeo6YLgmE2nLb6IR45E+zch7pXSzJJpb/4aeDk8PZcHX4ZUafS7C1HsjUDq5SdTw9PVQef+SWMWZy4CB/6NB4r+YAsJBcZTwAaKjbSO29y5cvYyFHxT/STOI/E8XxNMg8vE7PFkbaiZE9pIPqcZcR/FK1m0LnQ7ULCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731257; c=relaxed/simple;
	bh=W0YLJNz5/2SAiapxbVHEzsfqeAiPqnoxKuIVDr0TVNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C73gZlIS4UREXUBe/9SNunFxOWvZkDUzRDRAKMRKEc4Sf0OI+QCseIp0FhBCefgnP9mPs96yUdeeFq5jeS00Em2W/BsVLVTPBi46/pli+6Xf0alTh9J0y3JjUoBulOk4AvmF/6P8Tt1WNqin/pbvPU0NXAyhzl+Z9xHO1FgMVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BrGSRHkJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NKmJD6022214
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PYGYwAigTe4Xg8FBE8LvVKj2tXUXuFCqznUuXtFksk=; b=BrGSRHkJ+ZVhmIaU
	VvgViOfBXB/1beYYf7lneNmkHpG5f0ibRiCfjd85pqXZ0pJ/YdZ6W+4JMZ1PwHJW
	WhDCkkgWslGfbdaK1kEwOkxBXv9pkw7pFJMOtovb01PfvP1Sgl9H+cxBEvBT0mii
	b6HA6A8tj/OPe/8RtUWYJ3+pDT8wVPaOpbqP+5vAw2zaRn3EX0Ym4iyh6H4DcHlN
	kJSfT9IoGdkUyqmYXDbb0VgiNrijVqKfbV7Ec55FW+LFJg6fyEaYMr85t3rpRfzo
	+OsH7u/XvsyRbj+tHyo7t3SCgvMev6SD44czfjWYPcdwQdIx+6reLfsTCwD/kOCk
	6/0nkQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fdfwrnpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 24 Jun 2025 02:14:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d09bc05b77so799731185a.1
        for <linux-efi@vger.kernel.org>; Mon, 23 Jun 2025 19:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731252; x=1751336052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PYGYwAigTe4Xg8FBE8LvVKj2tXUXuFCqznUuXtFksk=;
        b=U/xOG2DgggMxGV62bSdJhtjp7xeyj5/g4rHa61R/q3EJdIxmVQCj3+ZH4MDgz63BYs
         dkEot9ab6M50Jm4WbTbVr4agr1gqZofDww6XoOEZydjag06yLsOytKDUfnpz0x85JI3R
         Fhi2Kv9ZQFdMK1P7GxV/FkxSnlHtKq/31oeeZGsYPWOJ/MMy+ndIEnqqEH7zypPkeQP0
         EMAakzJn7wZHcxrEJ4hrkvYefy6lvlvsmRrWDIWI76bZ3l+qBF+tB/qPejrFGWwwIVar
         MrQZr6/tvrxZFRtS+BgenA09CGiArsR0qPu3E8D1pVAz+VJQ6uGyYsfxkvaVUZAzIcr/
         BvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ6vFf/DdhhfGvn0tX0YXwdvZ3XFaE4wjdpejsZR8XQi5CFE+23ju0YnDYShnhR2KT+9iAW0CqEPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxljC4tVAV8H48x+XjHjCv6fmDKRuFF8CaNrBkN6sLXTchcGmII
	u6LWE7TPU+MN79YPjaLA1utXp0rQHRWOz1Ks8sucHVVXjtSm4/lCRlJtY+G5yRqeU1b/ff/ofNb
	GkXepiv7Z/LG8uLjrINTWmNcbWWi90qxS6n32Bj9cOjd2QGqQ+fkbjbOqHoUadYM=
X-Gm-Gg: ASbGncsicksJT78td8hYwGn2J1zDLtIiQuIP1Lp7BSfpKV2WxdLxNPKTisU0kgJtHd1
	nmgo7d+eXTTInUJL6ohTdZA+aqV8tPBGBrl5gbOqYdDvrpZCuoQUsBkXdKWeMSxZ+h0OgWuMIUX
	A4tywG1M9YC58g/i8nc4y9UaMK1X671Oi8k3a5BNlP7Lg28/PaLFR+QUZ4UWKwe2+VBM5HHDF/T
	yngQdaj+Dbe4Y8fTS1Kr/JY1e8Tmz9TO/MAj1kSs+or9aoZ8UTKz8yR5aVDhCAE+pgqFj50F9BW
	5zTuL3nPhOYwfAf5NJ7PFmwZzLBxbjdgDh4Nle1aTGHt66O3lFxt6Jc7/LbNyS2LuOEkJVTLOHO
	s4YcS3cbHERNVgjCicfSySjfxxWMAqLWSPg0=
X-Received: by 2002:a05:620a:4144:b0:7d3:b3e1:af51 with SMTP id af79cd13be357-7d3f99369e0mr1998467485a.29.1750731252359;
        Mon, 23 Jun 2025 19:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT/ySO9NQqMHT/LWZy4N2MmWqYkkmw6tiI4yElX8MxWZ75E2UpHJaJIjsjDu3cbO89+VOoCg==
X-Received: by 2002:a05:620a:4144:b0:7d3:b3e1:af51 with SMTP id af79cd13be357-7d3f99369e0mr1998465885a.29.1750731251969;
        Mon, 23 Jun 2025 19:14:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41446e2sm1637764e87.32.2025.06.23.19.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:14:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 05:13:56 +0300
Subject: [PATCH v3 5/8] firmware; qcom: scm: enable QSEECOM on SC8280XP CRD
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-more-qseecom-v3-5-95205cd88cc2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=W0YLJNz5/2SAiapxbVHEzsfqeAiPqnoxKuIVDr0TVNM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoWgnmzxRFX3uMqrpeWnKCOEbYAqwAQm0shNR9N
 YZQHH4LNxWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaFoJ5gAKCRCLPIo+Aiko
 1fBVB/91ODQjaD57ly/5cNAYMElD9ll89OMq6NlKN0qrBbfuJ1bY2gy3jhxt9N4S5WyZRXMD/ML
 l9qXjPgucZH/DwUrA8oZeucUpf838fm3Ya5R/x0OeFLa3Tc0EGL5ApEeJmoShPuAebi9qaS+BuE
 lqxglI85n5Y3eVwKRPOkhCGNLgiSF1ZcXG9tPiW2ViY9j69ECG7Jrb/SJNOeQj54kXg4RN+XzUu
 yAUtaxRNLgETNHQS8NGTXaeBenNw91u5ZlyfemMtyHXlrgqDRB4xk4b8YkC8/+We1HguJLg0Nns
 qdNl29k53TzYzO0sHg1U1r/mxlQ5nS14SZmFXbaNSBikfI3c
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: l3kyMePDtRRSz4QnwTPM2neZw3EHzcIC
X-Proofpoint-ORIG-GUID: l3kyMePDtRRSz4QnwTPM2neZw3EHzcIC
X-Authority-Analysis: v=2.4 cv=MtZS63ae c=1 sm=1 tr=0 ts=685a09f5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=GpPnMnrImHjYsJApwW0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDAxNyBTYWx0ZWRfX3ogpn1TnVnet
 /ArrquqH0VClc5HMCwOAYz3/+BbGn7o6zknKHdoZYobe6bRUX2K4/lQHsKs3fgNcKkajzkmkqZI
 EL9HY/94gxscfBQHKROcFiZ1YRItLSgwrCo6IW9xZ4AJefclJRZJRR2cabJ7/LgRmDtjjfpGIpD
 CQw1DN/Hz/bYPLp5MHue+0eo4T59mRjh+uhVH2o3gN0boITd7D4aQM3xpGP/QoCYke5c1wvRitP
 JjxLDI4//XZ47zUN/5ihm1ZIFXZe91YzGrEZwuotXzB6HeABNXMT7klXICwdT34EqqlVkaNDzGg
 cELvhQmMFSSVcrQ50Ub7krz1EBSFduHwWE31HFo6kScAPPFa8clYYBzqw4IMdPIta699dZavgbn
 Vsaumh0PW3AOHGoVB/K3sDPo3B7pdzWwsukPXjbwYzwQdr5XMwJcZ36R60Vni3KLOHLG8Evh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240017

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


