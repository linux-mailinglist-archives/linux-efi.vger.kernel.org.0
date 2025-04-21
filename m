Return-Path: <linux-efi+bounces-3389-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3385A95490
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531063B6164
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAB1E9B0C;
	Mon, 21 Apr 2025 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OxgpVQuv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE91E5210;
	Mon, 21 Apr 2025 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253385; cv=none; b=l7sheS8w0zt01PbuSq7UqRc1K4MXjhPOjcmvhpM1ypUAdAhhj64zfy5sqCS49UWe5DpLWst9uCkKCw48t3f0EUvd0015Yd7hw578/2khnuOujkkkUVPV6eAQyf6VVFRxv45XC54r6KF1y5klgIV3/haP1a1xJ2YP8AXvCZVla9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253385; c=relaxed/simple;
	bh=mFBWB+Zh5HfTbZFqTGwmjM5vRfHm0I2Ma4+dfepi+Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5k4ev/sjBztLv/Z2QzUSXfBEjNmFH5aIAR1I7djN7BBTTmIRm9wLJJBtq0UbfToK8hstTFYFYjpYZIfL0hI2akaBdPVQjUS2ZIFePy/2vY8VxZ9OtBSyXl8jeXSGFGQdylVZnvKA1SrJnwSLSRvhkX1T8FpAeoes5c8gLqrhBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OxgpVQuv; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAjlh016592;
	Mon, 21 Apr 2025 16:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=HGOB0
	rIsdQtfCrCqphCravAWJ/cte9DutwXo5krlzWk=; b=OxgpVQuvheZxDjxrYrxa9
	Eq4hx9SUSpt1pXkJKs3l6JFFhfA7jMBVED6Gc0WRLxa+4HzmndQoq/OOSRtvsElh
	3aQ7e1Yj1I3K2XxXGH55moEfMJnqZ/ExG2Fklw3zrfRlK8SyVl9YovVHl4my9TOn
	3A+6QgwX+6lf1yqUTioj/2S3rhZNKQZfflhQfXfG8dTMyn6HaKPacPLb8+F7UeoH
	Ja85F+jsj+Gjn2R4jU2+swsZy5AoDwT155Sm4NGHJ71DNgDWNd+32pMZahXpxtmC
	YB38vrwFhkVJWeTIlXN4kdSBJO8yqp4mLeBRgaIsitdM4ZUJj1DRW7DjbcTMjnNf
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4643vc2v1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:35:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LF1gfN005974;
	Mon, 21 Apr 2025 16:35:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465dehem92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:35:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGZn5t000373;
	Mon, 21 Apr 2025 16:35:49 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 465dehem7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:35:49 +0000
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
Subject: [PATCH v14 14/19] tpm, tpm_tis: Close all localities
Date: Mon, 21 Apr 2025 09:27:07 -0700
Message-Id: <20250421162712.77452-15-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250421162712.77452-1-ross.philipson@oracle.com>
References: <20250421162712.77452-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_08,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-GUID: 440mRjb4DP80zgrY_WbrzP4irAK28GX2
X-Proofpoint-ORIG-GUID: 440mRjb4DP80zgrY_WbrzP4irAK28GX2

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
index ed0d3d8449b3..d73b9ef3fd15 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1111,7 +1111,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	u32 intmask;
 	u32 clkrun_val;
 	u8 rid;
-	int rc, probe;
+	int rc, probe, i;
 	struct tpm_chip *chip;
 
 	chip = tpmm_chip_alloc(dev, &tpm_tis);
@@ -1176,6 +1176,15 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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
index 6c3125300c00..86fe8f6a2d52 100644
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


