Return-Path: <linux-efi+bounces-3286-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0A9A84EB1
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 22:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9F454E572E
	for <lists+linux-efi@lfdr.de>; Thu, 10 Apr 2025 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789AD293B7C;
	Thu, 10 Apr 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5v6NNon"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58A293458;
	Thu, 10 Apr 2025 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744318198; cv=none; b=ffkaZrHu5lx1UGkcSpwn2d4afIuJk08hNIerdLcgByWpSZQAuQ5STnvZU2eGlQauepqM0MdXi1e8UuxMYSGBLo6KczPyUH+vQlzaM5KyQSRwqyTchd54LxGeP2jMsaUi6NTgFSDyypEU7Gdau10lh7YeWACnw1KMgcbPrDjK5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744318198; c=relaxed/simple;
	bh=m7OTEhL6fTkCU3WMkcvzvl1kDpEY7Zj3GKlEA6iNbVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6qc0aJhMBzvQOZQKHMBx0NRuYBfn2R/0nAqbmxKJ09HDYYtbtDmbjRJSXuRsNsBosq0+5oT1aarMtd4dcxm2G9f3/s7/vW2fU6Md0vRYTAEtYnuUDQoDS7slN0FRhMBibLDPMa3q5GKAh751QfaznpafV+EFG20Wp5yIrpV/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5v6NNon; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKftlN017820;
	Thu, 10 Apr 2025 20:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=6+gm7
	03ZpFuak9AogDOipYkfkIXnjO7yBvqBPC4AX6A=; b=m5v6NNonrXZ9IQzUF1IAg
	ZG3W6yD1i985V5X6GWrVH2SVn/tSH2giUp63Xc10F3u6S/xwPJX4MRyxV2upLdr5
	DV49qvKGPRw2+60dsgYwlfWpmc2FuckaK/cRXxe2V5OtGzUmgBJsGE4JAPrLNxpT
	L15LS38wIKMl6tkYmpqPJstDeReZ7MPDme7OURPsETPcbEmOWw45BHPYwifntNWP
	Qyu7EAfLLEsscl3MYuEW7mQM8a95IwMY7nZ7pLq3bQEpmNDdzaeyZhgrl9aTz6Uo
	SsXW1o3myte02F0TSx6qQkauo+E9FUKZEdnL3Lb96Afbz9+yvegnrA7CgWRP+ALK
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xn8fg0rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 20:49:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKCJVT016358;
	Thu, 10 Apr 2025 20:49:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycrqvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:49:27 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53AKnQ9T008921;
	Thu, 10 Apr 2025 20:49:27 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycrqsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 10 Apr 2025 20:49:26 +0000
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
Date: Thu, 10 Apr 2025 13:41:44 -0700
Message-Id: <20250410204149.2576104-15-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250410204149.2576104-1-ross.philipson@oracle.com>
References: <20250410204149.2576104-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100151
X-Proofpoint-GUID: 6PdMm5F57VjH4AJL3xO2ySQCLFx4kifR
X-Proofpoint-ORIG-GUID: 6PdMm5F57VjH4AJL3xO2ySQCLFx4kifR

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


