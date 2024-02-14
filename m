Return-Path: <linux-efi+bounces-543-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B4D85562A
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 23:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210D01F2BCB1
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 22:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E91146911;
	Wed, 14 Feb 2024 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X95W3c9S"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE101468FD;
	Wed, 14 Feb 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707950200; cv=none; b=rPIn+Q+1XD7HRPRXJLadoesOox7fiLHgCWyAb2cOZ/HSCh05qFTSg4J0kG3P0YBodNvAxnIw51n/mot+pyIWFkRzc1z3DGZDwOgBOrUjf2YnpOaeNdd0VvDRl2KhNkryFd4YJQD3OwyPRZD/XBlB8+6jNAVdrW2tziBIvJ17pd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707950200; c=relaxed/simple;
	bh=8h3WjM/2k6NNW0IlEPjcYdWWKkzbtjALriacHK9e02k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyVQ76OL7Ioxw4L8yIz7h6xXWAERnrUUnKt0XZK8hROPL5sGpnlBRsVi7lgxbU2HwH81cmPq7HLfLg8gNWVnpkeEn7hrPk0JkZMxdU49YcCjGOeBkIlqGoDLK9gkZs6priFzQ+xyNsNMJKBSGiTBHG+sEYFYm3ilZuDkVgsNz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X95W3c9S; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELibl8028692;
	Wed, 14 Feb 2024 22:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=b4oJ7O5uXtHdoQDNZitFBZAfxacBiAtRwCnCravNnwU=;
 b=X95W3c9SM1DlouEOCXta15LZI489m/283wE5mRGW5HADODGoiqwBtIHabYBMiLoJ6eTq
 1mIFbMwol4ipetdqI6lWeLrrY/J1J6hKFI/Q7xbO5X6yzTPq1tRijPQHAD2vyClJAv0O
 b8J3WqyxoB2BdcHxIcfpmN5IuLBrvVoI4nGURUb0/s1wc3H1yzyRmDsr5fWjJYjRAPz3
 ZisO/IvVUZ/EghzBz6br5af5LqWuKne9U6cJ2z5DTrWv4XhGj0n3tOHHxWHnricNutWN
 OS6RtpIxJwceBcY08PXwtJ44dKuCoyXnPZT8YizjDmArNCnIqvrBoYWchphWi9scAQxO bA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f00sry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELexle000607;
	Wed, 14 Feb 2024 22:31:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVI004281;
	Wed, 14 Feb 2024 22:31:43 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:43 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 12/15] tpm: Add ability to set the preferred locality the TPM chip uses
Date: Wed, 14 Feb 2024 14:18:44 -0800
Message-Id: <20240214221847.2066632-13-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-ORIG-GUID: 6u0qho0pdR5oLqVesCM1T1HwwPG9_4kP
X-Proofpoint-GUID: 6u0qho0pdR5oLqVesCM1T1HwwPG9_4kP

Curently the locality is hard coded to 0 but for DRTM support, access
is needed to localities 1 through 4.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c      | 24 +++++++++++++++++++++++-
 drivers/char/tpm/tpm-interface.c | 15 +++++++++++++++
 drivers/char/tpm/tpm.h           |  1 +
 include/linux/tpm.h              | 10 ++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 42b1062e33cd..e4d591e8857b 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->pref_locality);
 	if (rc < 0)
 		return rc;
 
@@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
 
+/**
+ * tpm_chip_preferred_locality() - set the TPM chip preferred locality to open
+ * @chip:	a TPM chip to use
+ * @locality:   the preferred locality
+ *
+ * Return:
+ * * true      - Preferred locality set
+ * * false     - Invalid locality specified
+ */
+bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality)
+{
+	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
+		return false;
+
+	mutex_lock(&chip->tpm_mutex);
+	chip->pref_locality = locality;
+	mutex_unlock(&chip->tpm_mutex);
+	return true;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_preferred_locality);
+
 /**
  * tpm_try_get_ops() - Get a ref to the tpm_chip
  * @chip: Chip to ref
@@ -368,6 +389,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->pref_locality = 0;
 	return chip;
 
 out:
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 66b16d26eecc..7a758c6d6d09 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -273,6 +273,21 @@ int tpm_is_tpm2(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_is_tpm2);
 
+/**
+ * tpm_preferred_locality() - set the TPM chip preferred locality to open
+ * @chip:	a TPM chip to use
+ * @locality:   the preferred locality
+ *
+ * Return:
+ * * true      - Preferred locality set
+ * * false     - Invalid locality specified
+ */
+bool tpm_preferred_locality(struct tpm_chip *chip, int locality)
+{
+	return tpm_chip_preferred_locality(chip, locality);
+}
+EXPORT_SYMBOL_GPL(tpm_preferred_locality);
+
 /**
  * tpm_pcr_read - read a PCR value from SHA1 bank
  * @chip:	a &struct tpm_chip instance, %NULL for the default chip
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..389b117e68c2 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -267,6 +267,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
 int tpm_chip_bootstrap(struct tpm_chip *chip);
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
+bool tpm_chip_preferred_locality(struct tpm_chip *chip, int locality);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 
 struct tpm_chip *tpm_chip_alloc(struct device *dev,
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 4ee9d13749ad..a61d4e5e4b2d 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -116,6 +116,12 @@ struct tpm_chip_seqops {
 	const struct seq_operations *seqops;
 };
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
@@ -170,6 +176,9 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+
+	/* preferred locality - default 0 */
+	int pref_locality;
 };
 
 #define TPM_HEADER_SIZE		10
@@ -421,6 +430,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 #if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
 
 extern int tpm_is_tpm2(struct tpm_chip *chip);
+extern bool tpm_preferred_locality(struct tpm_chip *chip, int locality);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
-- 
2.39.3


