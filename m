Return-Path: <linux-efi+bounces-1599-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6035495FD3B
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 00:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F281C20F97
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2024 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7619EEA4;
	Mon, 26 Aug 2024 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RNttU17w"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1A19DF5F;
	Mon, 26 Aug 2024 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712247; cv=none; b=kH2x77BtCrW0k+EjYiUsDnuvXBf5fAi/ZHuf0AyT0ch8C+eTsjfwthIJPBoou0kUX8Dky0VItHdZgpPAC5i4UfNtJtm7w4+SXA2fsJR0o91kM4G2ViOJpVd+eHkL4C3OH8D11vMQnmqdKBRy0LARh/VmHBCQdMTN0mSPNCOLi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712247; c=relaxed/simple;
	bh=A5yWA2Yof3imHF9mJmsEV/fUrAli1kdWe/Sjhyjiy8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BD5qQEf4INut4pZ1qFGpXEyjjzUYxFERdlUgkgf2CPnMFhKPZAtE/iT4eG3LwesML02FqeSUlm74wlJAHOYQQh6SrcmMHWkri4ijYzM/5KWEYbJETzefmbLjNX8xA5v4oyV2xW17HEM5IUs1aPKWvYeqe3uYYmScA5ftX12TndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RNttU17w; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QKtS2G007312;
	Mon, 26 Aug 2024 22:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=K
	6ORuNu13NYA3/O3+8UFEwXM/dCnt1zIbKf2sPjeEj0=; b=RNttU17wdmWbLi09P
	ptXJZin3ycfnptvS0FOzMvnV9vytzCJsvdTfIQTZ43gcaFUENdlO9TsKRCzD9FVf
	nt6xRpryXr+oIms+Un5sEGH21/sEnjuXGOBJRvQRX8deKAclhOTG5ZGdA/u1G8Rs
	3x9tFXjIHyTeYpdKWeMidjxPdelvOJG8zun6eatKbhvXi5zHJk5ybnTAnR05wigG
	lnXUfT7NO6K+FEjnX8D50aoKX4wdrDa73zE36OfKX4VydYS8GZMys5HeQZ5DLnO2
	k4Yv6DpsWDlET6LOBM1zszKwT/qJWyEMmsI2C/7FIJPvpScFSyOsdfcsRwnn5zPc
	QNu0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6mbf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 22:43:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QL43so010556;
	Mon, 26 Aug 2024 22:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894m7tjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:43:33 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QMhWkX002895;
	Mon, 26 Aug 2024 22:43:32 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41894m7tf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:43:32 +0000
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
Subject: [PATCH v10 17/20] tpm: Add ability to set the default locality the TPM chip uses
Date: Mon, 26 Aug 2024 15:38:32 -0700
Message-Id: <20240826223835.3928819-18-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240826223835.3928819-1-ross.philipson@oracle.com>
References: <20240826223835.3928819-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_16,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260174
X-Proofpoint-ORIG-GUID: Zi_S6H-Hjgh_qNZH-yiis30lo3_NZ4cB
X-Proofpoint-GUID: Zi_S6H-Hjgh_qNZH-yiis30lo3_NZ4cB

Curently the locality is hard coded to 0 but for DRTM support, access
is needed to localities 1 through 4.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 24 +++++++++++++++++++++++-
 include/linux/tpm.h         |  4 ++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 854546000c92..1ca390a742ed 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->default_locality);
 	if (rc < 0)
 		return rc;
 
@@ -143,6 +143,27 @@ void tpm_chip_stop(struct tpm_chip *chip)
 }
 EXPORT_SYMBOL_GPL(tpm_chip_stop);
 
+/**
+ * tpm_chip_set_default_locality() - set the TPM chip default locality to open
+ * @chip:	a TPM chip to use
+ * @locality:   the default locality to set
+ *
+ * Return:
+ * * true      - Preferred locality set
+ * * false     - Invalid locality specified
+ */
+bool tpm_chip_set_default_locality(struct tpm_chip *chip, int locality)
+{
+	if (locality < 0 || locality >=TPM_MAX_LOCALITY)
+		return false;
+
+	mutex_lock(&chip->tpm_mutex);
+	chip->default_locality = locality;
+	mutex_unlock(&chip->tpm_mutex);
+	return true;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_set_default_locality);
+
 /**
  * tpm_try_get_ops() - Get a ref to the tpm_chip
  * @chip: Chip to ref
@@ -374,6 +395,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->default_locality = 0;
 	return chip;
 
 out:
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 98f2c7c1c52e..83e94b2f0cef 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -219,6 +219,9 @@ struct tpm_chip {
 	u8 null_ec_key_y[EC_PT_SZ];
 	struct tpm2_auth *auth;
 #endif
+
+	/* preferred locality - default 0 */
+	int default_locality;
 };
 
 #define TPM_HEADER_SIZE		10
@@ -446,6 +449,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+extern bool tpm_chip_set_default_locality(struct tpm_chip *chip, int locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.39.3


