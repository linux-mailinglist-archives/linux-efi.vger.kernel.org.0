Return-Path: <linux-efi+bounces-3117-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E753A7531E
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 00:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4EA1894E85
	for <lists+linux-efi@lfdr.de>; Fri, 28 Mar 2025 23:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3581F8725;
	Fri, 28 Mar 2025 23:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AIBtuWty"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A0F1F8722;
	Fri, 28 Mar 2025 23:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203654; cv=none; b=aRkidNnNwVP4lDkEotWcSld1IaeQeVVFuq1jzuON4nh/+tgYn2GtqZsZAxt87s/h1eJVrzniZzOxv+Ex+hw4w0jsxxKaeDvLVlqw9Qjv1/8fdRGHe2dO5XXxPJPM7BjQOh6KsqifbcPVcpc79lbfuR4UsmmPs3McLaNBLbj4qUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203654; c=relaxed/simple;
	bh=m7OTEhL6fTkCU3WMkcvzvl1kDpEY7Zj3GKlEA6iNbVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oifJukqS5nQaC4q54ngpymXe//jp7tJjsvus/RXVWdz2rQM9rNPnECRdHE1de4CuuNKPlhkojd9ybbB9sog8nI08ryYI/BWuT8YzVdPtV6nK6Rs6ZTAPbNhy8A6+oSQ39beqUv4GWm2NlRKZw8AJ0BePioZIu24ST9W/wYQaI7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AIBtuWty; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKWBPc024483;
	Fri, 28 Mar 2025 23:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=6+gm7
	03ZpFuak9AogDOipYkfkIXnjO7yBvqBPC4AX6A=; b=AIBtuWtyDc3SRz4453u+H
	DQ9V+OXQ0k3Mwns67BzALvKCs/eNr4n8/jYorPqrD/l4NRTeY7rQzXjUYNTbHhkX
	uUkBzfiwTLpE93cATosN7UZ5SMVaV1e7ehL4/DUZ2qR09avztU9Iy1tzRi5i1WDA
	op6PAi2EVk2bxLAgjAZWY+qE3iDkvGcar8jxgWaph50iec9q0CLOyRklh9fCfe2l
	Recp0RfUs4b4I14Hl34fmtZMXDa4plPBj2qgxhXeoUAA93TbJPFzeRgobXIqIhUX
	T6zIbci2n15PwPznlxbr+QmkRsVLSas/DDyVz4bc4bIOmgr7FmksQAUcUivLd5IA
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrsqxjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:13:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SLp0Nw029514;
	Fri, 28 Mar 2025 23:13:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc5smgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:13:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52SNDgJT034268;
	Fri, 28 Mar 2025 23:13:42 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc5smg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:13:42 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
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
Subject: [PATCH v13 14/19] tpm, tpm_tis: Close all localities
Date: Fri, 28 Mar 2025 16:08:09 -0700
Message-Id: <20250328230814.2210230-15-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250328230814.2210230-1-ross.philipson@oracle.com>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280156
X-Proofpoint-GUID: fpqoRLfxEi40Q5CwgSmMGkwlOeBdWVhh
X-Proofpoint-ORIG-GUID: fpqoRLfxEi40Q5CwgSmMGkwlOeBdWVhh

From: "Daniel P. Smith" <dpsmith@apertussolutions.com>

There are environments, for example, those that comply with the TCG D-RTM
specification that requires the TPM to be left in locality 2. Prepare
kernel for such environments by closing all the localities.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm_tis_core.c | 11 ++++++++++-
 include/linux/tpm.h             |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index fdef214b9f6b..2edf0ac0f810 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1104,7 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1166,6 +1166,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		goto out_err;
 	}
 
+	/*
+	 * In order to comply with the TCG D-RTM specification, relinquish all
+	 * the localities.
+	 */
+	for (i = 0; i <= TPM_MAX_LOCALITY; i++) {
+		if (check_locality(chip, i))
+			tpm_tis_relinquish_locality(chip, i);
+	}
+
 	/* Take control of the TPM's interrupt hardware and shut it off */
 	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
 	if (rc < 0)
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 20a40ade8030..c5a4a2d7dd15 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -147,6 +147,12 @@ struct tpm_chip_seqops {
  */
 #define TPM2_MAX_CONTEXT_SIZE 4096
 
+/*
+ * The maximum locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+#define TPM_MAX_LOCALITY		4
+
 struct tpm_chip {
 	struct device dev;
 	struct device devs;
-- 
2.39.3


