Return-Path: <linux-efi+bounces-1764-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2668C9789AA
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C991C20D37
	for <lists+linux-efi@lfdr.de>; Fri, 13 Sep 2024 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56DB148317;
	Fri, 13 Sep 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VC/UJO/f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FD1482ED;
	Fri, 13 Sep 2024 20:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258419; cv=none; b=P/7NpRBhkEtriMt+CBdnkD2c6QEq+TIqNIm50KePurIeJ6/OeGdBTHIPHlZu6oo5eNP0ykvc0nMo+8tIgLR6zCecVjz7GQvH2ZQk3C7EUV2dqCBNeHZbPg7PDgKP+PhJwiysxVStn+TdS8OYXLZplKd1vMo1By1zqsQ8yAlCj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258419; c=relaxed/simple;
	bh=A5yWA2Yof3imHF9mJmsEV/fUrAli1kdWe/Sjhyjiy8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SKFRQcX+P1LIf7ymG0gozrMc1D5QE2kQd6rTDGXcDTu4vClTnn6EnmCWbczNphgw50K5isAk78mTrfZRfGu/XXZqwyZp+6PtLPkLSqZBQhCpg9DhiNRMX4fUsLHbraa6Xf+3Ign8cHuwVdo7pPV3Y6KTpp/2PE4dD0pJYW8tEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VC/UJO/f; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJ0Vfm032521;
	Fri, 13 Sep 2024 20:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=K
	6ORuNu13NYA3/O3+8UFEwXM/dCnt1zIbKf2sPjeEj0=; b=VC/UJO/fIC9UpJpQ9
	O7eKqlWhqRJ1rSQCMGdxrZG213Ejn2ISFsM59cqnHe7h+Xk/a0YwKispxGKeXtyV
	JGI22Wwt+u7yFm22vwQ4NYSNyd8n1wJEC+crN0AJQL0lEpybtBbFayJeyxWdgYP4
	F3xc3Yt6J3S6z7HqDhDLrG1sXHquzBWuzRqyF6/K4sT+SuQfaZjC6abV2ivKjPFO
	arKKIo3ZTSF0bUhgCalw//GI0ehc2NEhx/UKCNlCYOP92aY3JOZmMOnL80neNFnu
	AIdWsHN8RyhBVfODAoMn5fGRbrSDnSAeEpRYPG453rqYP3U83Zwy4p3raUN1JWw+
	gfZtg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdm2xk4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 20:12:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48DJciVG005931;
	Fri, 13 Sep 2024 20:12:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d5ywa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:12:50 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48DKB8bs025184;
	Fri, 13 Sep 2024 20:12:49 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9d5yvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 13 Sep 2024 20:12:49 +0000
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
Subject: [PATCH v11 17/20] tpm: Add ability to set the default locality the TPM chip uses
Date: Fri, 13 Sep 2024 13:05:14 -0700
Message-Id: <20240913200517.3085794-18-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913200517.3085794-1-ross.philipson@oracle.com>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130143
X-Proofpoint-GUID: QutIQg804CrywgkmDb9zl4-o6ZNfDBYk
X-Proofpoint-ORIG-GUID: QutIQg804CrywgkmDb9zl4-o6ZNfDBYk

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


