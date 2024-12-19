Return-Path: <linux-efi+bounces-2415-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F049F853A
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 21:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D6E18953D6
	for <lists+linux-efi@lfdr.de>; Thu, 19 Dec 2024 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2391D7E30;
	Thu, 19 Dec 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BcoSgSk+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643EC1BD9D3;
	Thu, 19 Dec 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638275; cv=none; b=tJPUFWTMmb36n1sujDng/ptHH+i/CY85V1quOokjWtLDfj47gaVmanS5RNejPXT9Tp/hNEy/sf8K2fFr4JO96/afRX7F1QNnh2xHrDZUYZqeCDUd06XIJLh92gtXvSNVC/pAiGYiG82bGakALVkf6/Al/ccLztclYRoekqgT78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638275; c=relaxed/simple;
	bh=YFamG+fH4nzvw3qWGUpwbOLI4ZSWMUf4j3XW+YT9TDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I6K9JeinUm7NCBtyDy2oT5TAHWmTWnTnI7blkIt8gcxq7WuvgkA9N8CS+z/gsWMA1+lfvqGNsxchxrbHxesVK0ETl/DFD3FSCLIS/8eFMfs0OpcHoCRKwK8yQ7Bkq7P46rnBnyMzBwdEFDUsPxgXOXRIPJEulXOOljsVo781CDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BcoSgSk+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJIMhhd005249;
	Thu, 19 Dec 2024 19:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=bMmN2
	o5dVO+yPPaIiGMTqTFDB88vYcDecc1Itih9LzU=; b=BcoSgSk+f6n5ZenW7PqZ7
	VToynRulCIlIbmjTs0+U+PWY4CDTelO5lcQCV/BhdSKLcrIP3F9vhY119gsfMoG0
	8LZbxfo+hCLYLI5MJcFNE2VxIAESaX4om9BVkXr278ANQvGfPfdYqzzyf0Kck2bN
	y4VWu/dAPja6ilRVMuHdhhSfsiqyVuDbTIFZPOYTkK3A8cJCTfGCDhezHVBsZipM
	IcSXxgWJY/wZAfi68wiDk9HQCQ9SRZoUtw1/0+GyzEV3yhJSziT1pePK0b8c7Mem
	9Ut5c+L8IOLQVXlawdhRm56BTQEBNatlJAQf+WzEZSvPJKAi5M+4Ro4rsYN2Md/Y
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0t2ksfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Dec 2024 19:56:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJI317w032823;
	Thu, 19 Dec 2024 19:56:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fhvp08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:56:25 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4BJJsDd7006892;
	Thu, 19 Dec 2024 19:56:23 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fhvnyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 19 Dec 2024 19:56:23 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v12 16/19] tpm, tpm_tis: Allow locality to be set to a different value
Date: Thu, 19 Dec 2024 11:42:13 -0800
Message-Id: <20241219194216.152839-17-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219194216.152839-1-ross.philipson@oracle.com>
References: <20241219194216.152839-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-19_09,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412190158
X-Proofpoint-ORIG-GUID: M3neXl7K8yR5H0uRy9IacTDEQLDtMvMQ
X-Proofpoint-GUID: M3neXl7K8yR5H0uRy9IacTDEQLDtMvMQ

DRTM needs to be able to set the locality used by kernel. Provide
a one-shot function tpm_chip_set_locality() for the purpose.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c     | 33 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c |  2 ++
 include/linux/tpm.h             |  4 ++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 7df7abaf3e52..ac200514c4d7 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
 	if (rc < 0)
 		return rc;
 
@@ -374,6 +374,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->kernel_locality = 0;
 	return chip;
 
 out:
@@ -689,3 +690,33 @@ void tpm_chip_unregister(struct tpm_chip *chip)
 	tpm_del_char_device(chip);
 }
 EXPORT_SYMBOL_GPL(tpm_chip_unregister);
+
+/**
+ * tpm_chip_set_locality() - Set the TPM locality kernel uses
+ * @chip:	&tpm_chip instance
+ * @locality:   new locality
+ *
+ * This a one-shot function. Returns zero or POSIX error on failure.
+ */
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality)
+{
+	int ret;
+
+	if (locality < 0 || locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
+		tpm_put_ops(chip);
+		return -EINVAL;
+	}
+
+	chip->kernel_locality = locality;
+	chip->flags &= ~TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+	tpm_put_ops(chip);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index c86100ad743a..b85677eccc86 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1114,6 +1114,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index c5a4a2d7dd15..9f910d3bc2e4 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -207,6 +207,8 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+	/* the locality used by kernel */
+	u8 kernel_locality;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
@@ -354,6 +356,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -447,6 +450,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.39.3


