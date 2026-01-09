Return-Path: <linux-efi+bounces-5977-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B6D0811B
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7645530223DE
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E393563F1;
	Fri,  9 Jan 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CxJMFgeA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fL3/Gsr5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204B328B6A
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949392; cv=none; b=MKd78D6LnL7/0O75NTeWuMzNUiVm6VJSbxQkagdw321cqtipEKApIwjkr3ofx1YgBUqdTtWLhK3kg6lw5YLerYpk6B1Kryeff3cE2HPdMNBafPtu1dxjIKFXC4a+nNOVmCk1J4/l6+QbBtkY6VGOj6Bbl8jHU4hth3I11TFyqZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949392; c=relaxed/simple;
	bh=ytPXjHTvH1GV8RvsZkPPTIstYiltsShCpFuzHJWXpyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaQaObvoeSFusXiTlU4VEtlUYkBQvdvgAL7wvsWE3aHYCp3CKO5iEWJvDRTeSuj2YgBnAfi19jpdEQ3VPQMqT7+RHxHOkcEEQLql2R8MYAGaB6Vx4Lcw9aCi7QngP2uzF4t/IEIvBF+iTmSnHqBpFI5r+2j5i9M9r98jZyFs/3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CxJMFgeA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fL3/Gsr5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098XObT822831
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ibs2WMFWf8i
	sMVsnKj6F0MrAqbp9ptOr31qv7TtrWfQ=; b=CxJMFgeANbWA3+z1HjSB5VWDvYz
	fs9vDLWnzwlRty/+fHxvtipcPY+7ocykV1+5nStYHGcju7tubY89qejydect3Vz8
	xC7fQbhjlGWG49ikob2QQ9CZRhqLIxSlM7M3vDIIe9VZm3HjJH06uYWeFxMS8Az5
	8rM0PA21E1nuEUhWLrHYCESYFj3jmRFS3jtLViYMx3g9PSyY7wJkNk8SY8ci0RYk
	U/yPK7KHyqbNIokW2W/61mWLrZVgsw3rJpzRjaZX8Oze9s0G8hwhMHywGhDMMLdc
	/uS1i8wDj9d+Jm6OekWqJlg0ubtPv58TlF53k33DUz4V6B5nR2S2yMNeF8g==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjx94g3ca-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81c68fef4d4so3380068b3a.2
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949389; x=1768554189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ibs2WMFWf8isMVsnKj6F0MrAqbp9ptOr31qv7TtrWfQ=;
        b=fL3/Gsr5o3gICo8+xutIZnJFLtVBeYKYjpc/hmOecwa8PIBsa+7pwlCj0by/OFQUbw
         vXQwLeA2zLKfRV9tnJMoBwCsiAV8agnGrISQyKr1cgfYMiUenJ4lKYoqk3LGA0W5MZ2i
         DznizCTHBkhciqctSx+6LMH9GYMtb3wraV07+7QVPZEaAYRG/NwUk8RkrUkRaWIK4OGm
         AqsyQda72soZXypr8Dcz4mNuzLaL2xbFuKTMTrHaP3SPIBx3w8Yh/buw/TVYCbnKf1yB
         tYswQ5X6vzhFQO0JOoPoCElVSqFghKqwU9475gYypZGlyKysUeW441wWDcRuE1O+g2mP
         HOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949389; x=1768554189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ibs2WMFWf8isMVsnKj6F0MrAqbp9ptOr31qv7TtrWfQ=;
        b=W10C8PQqrZraSFmt+c6pRlVQ2N3Cz0BgaeazGdpiYUlJg7dLe8wqUTzQ47K/rPgzzn
         ZRi00AQI6shQx7l6oHAGg+rnQJMNCgfYF05WFxO++f423kIC4dPYs2zI4LNNUUqPwcvw
         FmHlFniZY+jvfnvcsBe/S2Whn8ZDkC/bsVrtvCErkhM1iRucNG3H6XwAaSrwHlvvVHI7
         /wxoUw786EIMearG5drjUyHOEqCcfkdiylTRTFLLe7MrLs9kGedFv7DePDFIfA2ViEIt
         Pc6uETnrW7rLkG/3t1YK1CtICdHXM6G5AVQTVIwA7EyR0RCDx+Sql6zPrnk+FO0kt5HM
         04ag==
X-Forwarded-Encrypted: i=1; AJvYcCWvZIV1i+TckaboX87XP3LPRjjLRnS6olQx/3lSpEb0RDi6Odbm+aWf0HjYL53ywF5ndNPwBIHA/vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzPl6viz2pzej70EoFihCWw17BqA5MYSROkuh38FwRGZnxLEZL
	MECupWBQMld5owC1mLMtL1TMZuHoFO9IurfBEqG3YKqAubPJb5Y0elRxZ3ZblLnzNxLYzSZfJI+
	FMqt1z8EU4Z5msd2NkpWai7JdX1/yoHDs9hZefA88bcgGutOAAESIpsfrfJvBY+s=
X-Gm-Gg: AY/fxX6g8RavinE3/J3FCGtKYtYAcL+46Tt6OaP3Bugnou/mfntGZoVnqknjHTj5+mG
	3e+jWMt3j1r1vnfTz0gHGPGGurt5pEwJZ5H06nojPWRptCTrbKtru9LM2SGWWsCMn3L25GwuD4Y
	3sEsi5Qtggx2YXLwVXftTAOu7iqfJuUVucGcZyGqCpNthBzR6+cne+FCphLOhYstZKzU9TnBdXx
	6c94JNm8qJ7Cx9xXC7GGboAahao4s74363Bc7sGJQUBjDOb8jZCoeARKqj2QYWHVEE+t/Nbo/Su
	dt4TvMXaj3Ac2vRssfZGi7YNJc4VvydnD/GTxpfSKWFsfYt+rdQC2ManHSAVLU/iXf+5umS4ViY
	e3nZ2pL0tZtOMI+VnVtlesq//fHrTmHIeRWS2z6C14poB1pBe6IXQCDzTDvefP/alVKagkD/MuT
	p7gxFmzYiznivFznZ0wn1ju/JIKzJXT8N9lw==
X-Received: by 2002:a05:6a00:4c81:b0:81e:b2ba:5b36 with SMTP id d2e1a72fcca58-81eb2ba5c17mr419392b3a.63.1767949389445;
        Fri, 09 Jan 2026 01:03:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGejI7LmUB/luJhLPwMThP7DUoDGFXiiyakN6fBlGBN6FOHT6qVL/iPto6pXgjtHv9gY8I9Vw==
X-Received: by 2002:a05:6a00:4c81:b0:81e:b2ba:5b36 with SMTP id d2e1a72fcca58-81eb2ba5c17mr419361b3a.63.1767949388939;
        Fri, 09 Jan 2026 01:03:08 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:03:08 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 08/10] riscv: Introduce HEST SSE notification handlers
Date: Fri,  9 Jan 2026 14:32:22 +0530
Message-ID: <20260109090224.3105465-9-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RN2+3oi+ c=1 sm=1 tr=0 ts=6960c44e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8 a=Eu4eB5ymJzOrEwSPfFIA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 2-4o15UIl4AUvXVi1RM6szDzDTJW13hl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfX20olk39RpOfj
 tkFqhcx0STkamQTxzSgp/aDr6e2yeeVK61fOjAqaO7UUUBacyrC/g4Ic7pHE5UtjhBk3ZQl7RmR
 VOWiQXFHfUnnqyT8qAIDwcp0LL66Cer8cQIvm5MZD52P4fQtZS219slHgLPihHKCRGPjQ5G2FeD
 5eFW56AtqvpcfZfvSudjmgRZ5Ctuu6vYtz0T1TeSojUoJe7CbzVXK5gL/3GcaP42TRhr+S3Dl4M
 fvzYSq5M8TIoaArIDLqcuel4ygqB9A4Mdk0uXg28OGnqajNtBb6tLwlU2JNyTp7GfBsXG/mNvUH
 TiqOYEal8C3qavDqd8DPdHPUNWIMstWLqr9Df2xwWAUaYCXtBAj99NgsGXX3+FsIbx1zMcudkXI
 MhYfPky3b0KCVo/Col8Oko3wJLc8WDXcSKw0/CpF0U+OD5TAF5redBhjYYrsqsQNcinMDZMR2UP
 1MkcaLovMl1utxdLKwg==
X-Proofpoint-ORIG-GUID: 2-4o15UIl4AUvXVi1RM6szDzDTJW13hl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Add config option to enable SSE in APEI. When it is enabled, functions
to register/unregister a ghes entry with SSE are avilable along with
low and high priority event handers. If a SSE notification type is
determined, a ghes common handler to handle an error event is registered.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/acpi/apei/Kconfig |   5 ++
 drivers/acpi/apei/ghes.c  | 100 +++++++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..ada95a50805f 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -46,6 +46,11 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_SSE
+	bool
+	depends on RISCV && RISCV_SBI_SSE && ACPI_APEI_GHES
+	default y
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6fd84a1772c6..aa7dcd4069f9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -17,6 +17,8 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/err.h>
+#include <linux/riscv_sbi_sse.h>
 #include <linux/arm_sdei.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
@@ -99,6 +101,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#ifndef CONFIG_RISCV_SBI_SSE
+#define FIX_APEI_GHES_SSE_LOW_PRIORITY	__end_of_fixed_addresses
+#define FIX_APEI_GHES_SSE_HIGH_PRIORITY	__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1561,6 +1568,63 @@ static int apei_sdei_unregister_ghes(struct ghes *ghes)
 	return sdei_unregister_ghes(ghes);
 }
 
+#if defined(CONFIG_ACPI_APEI_SSE)
+/* SSE Handlers */
+static int __ghes_sse_callback(struct ghes *ghes,
+			       enum fixed_addresses fixmap_idx)
+{
+	if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
+		irq_work_queue(&ghes_proc_irq_work);
+
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+/* Low priority */
+static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_lo);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_lo);
+
+	return err;
+}
+
+/* High priority */
+static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
+	struct ghes *ghes = arg;
+	int err;
+
+	raw_spin_lock(&ghes_notify_lock_sse_hi);
+	err = __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY);
+	raw_spin_unlock(&ghes_notify_lock_sse_hi);
+
+	return err;
+}
+
+static int apei_sse_register_ghes(struct ghes *ghes)
+{
+	return sse_register_ghes(ghes, ghes_sse_lo_callback,
+				 ghes_sse_hi_callback);
+}
+
+static int apei_sse_unregister_ghes(struct ghes *ghes)
+{
+	return sse_unregister_ghes(ghes);
+}
+#else /* CONFIG_ACPI_APEI_SSE */
+static int apei_sse_register_ghes(struct ghes *ghes) { return -EOPNOTSUPP; }
+static int apei_sse_unregister_ghes(struct ghes *ghes) { return -EOPNOTSUPP; }
+#endif
+
 static int ghes_probe(struct platform_device *ghes_dev)
 {
 	struct acpi_hest_generic *generic;
@@ -1607,6 +1671,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			generic->header.source_id);
 		goto err;
+	case ACPI_HEST_NOTIFY_SSE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SSE is not supported\n",
+				generic->header.source_id);
+			rc = -EOPNOTSUPP;
+			goto err;
+		}
+		break;
 	default:
 		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			generic->notify.type, generic->header.source_id);
@@ -1670,6 +1742,18 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		if (rc)
 			goto err;
 		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		rc = apei_sse_register_ghes(ghes);
+		if (rc) {
+			pr_err(GHES_PFX "Failed to register for SSE notification"
+			       " on vector %d\n",
+			       generic->notify.vector);
+			goto err;
+		}
+		pr_err(GHES_PFX "Registered SSE notification on vector %d\n",
+		       generic->notify.vector);
+		break;
 	default:
 		BUG();
 	}
@@ -1699,7 +1783,6 @@ static int ghes_probe(struct platform_device *ghes_dev)
 
 static void ghes_remove(struct platform_device *ghes_dev)
 {
-	int rc;
 	struct ghes *ghes;
 	struct acpi_hest_generic *generic;
 
@@ -1733,16 +1816,11 @@ static void ghes_remove(struct platform_device *ghes_dev)
 		ghes_nmi_remove(ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
-		rc = apei_sdei_unregister_ghes(ghes);
-		if (rc) {
-			/*
-			 * Returning early results in a resource leak, but we're
-			 * only here if stopping the hardware failed.
-			 */
-			dev_err(&ghes_dev->dev, "Failed to unregister ghes (%pe)\n",
-				ERR_PTR(rc));
-			return;
-		}
+		apei_sdei_unregister_ghes(ghes);
+		break;
+
+	case ACPI_HEST_NOTIFY_SSE:
+		apei_sse_unregister_ghes(ghes);
 		break;
 	default:
 		BUG();
-- 
2.43.0


