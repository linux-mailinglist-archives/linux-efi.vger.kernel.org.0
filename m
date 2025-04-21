Return-Path: <linux-efi+bounces-3391-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059EDA95484
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18B9189558B
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A751E5B6D;
	Mon, 21 Apr 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B+lw9A9/"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40551EEA5D;
	Mon, 21 Apr 2025 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253400; cv=none; b=hb8GMF3Bgg08BUglzvh2UMNzq1RQTXDUhnWQCc9BAnuh+KhDmd0DHDN3iirOHJQQ3ADor2SeNSN7p3AUJQLoJtHnZdIKG6QbJaR1s4wlcxxXL5/ZSmMDrZF1uGZ4C/zseBVl91zwVpxHX/QJfDu2rUMpcVtVopLdAi3uzWRva8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253400; c=relaxed/simple;
	bh=m/dsHLWkq66K4gWIazNjQg9DQXN2zbZYwTZpv814Rwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAYSnE66LGegs/BZyhZbgmtMl5MewRYIfu5glibjnJeiEu43WE0E/fC5zvVELOrGEiPeaVgd+fgSZ77QQReEKGZFcAeCMbFsgGhGDt9AxKoFeGaQgTBvIiYij/RPieztmh2GGrIixKFu+/q2vOzGObsF+Kik7KDC6bO3KlqLV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B+lw9A9/; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAmxw018541;
	Mon, 21 Apr 2025 16:36:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=sHcdg
	aPZFJ2grL/OjXzV+OEaumY5oS001m+acNi9IGw=; b=B+lw9A9/eP6V81mcqCKRV
	WHxRD8/q6ysuNBQGy5dxOs+e6GlAzujCFr2VbR8bdtrhTWjHvZu00pov99JPQb//
	mpmVA8iK/9Gf0zk4jZC4XisywyRYPpbDo8qQ6uQ2A8xDmx8BgIzEU9yhnYBmJtmi
	two8+Gy5ZnyVgnQyHR9KCbrHAypf/wXOncZIOuRPytgDDRCoF4CccRsreTTmlzPD
	+vGgIPksBuzbpjS6jT0aopjNbOcJjr1dW/9/9VdYIxTIob8xIvGRpWdFIFZGHKUP
	SykQhAdAPrY35opwHTPnv6fa2cMRKdE2d7JQYfb9ccpuFfDH9EEgJ7pWcG7eqGAA
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644csttt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:36:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LFv1gK010270;
	Mon, 21 Apr 2025 16:36:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298rhff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:36:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGaA6r000450;
	Mon, 21 Apr 2025 16:36:10 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 464298rhce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:36:10 +0000
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
Subject: [PATCH v14 16/19] tpm, tpm_tis: Allow locality to be set to a different value
Date: Mon, 21 Apr 2025 09:27:09 -0700
Message-Id: <20250421162712.77452-17-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504210129
X-Proofpoint-ORIG-GUID: 1XaHbQ9RJQze08y9D58UmOEQh7HFZ-VL
X-Proofpoint-GUID: 1XaHbQ9RJQze08y9D58UmOEQh7HFZ-VL

DRTM needs to be able to set the locality used by kernel. Provide
a one-shot function tpm_chip_set_locality() for the purpose.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c     | 34 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm_tis_core.c |  2 ++
 include/linux/tpm.h             |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e25daf2396d3..a603f0dadd43 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -44,7 +44,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	rc = chip->ops->request_locality(chip, chip->kernel_locality);
 	if (rc < 0)
 		return rc;
 
@@ -380,6 +380,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	}
 
 	chip->locality = -1;
+	chip->kernel_locality = 0;
 	return chip;
 
 out:
@@ -695,3 +696,34 @@ void tpm_chip_unregister(struct tpm_chip *chip)
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tpm_chip_set_locality);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 222081e5c7f7..2bc0cf46adbf 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1124,6 +1124,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 86fe8f6a2d52..884791acba2e 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -207,6 +207,8 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+	/* the locality used by kernel */
+	u8 kernel_locality;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
@@ -355,6 +357,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(11),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -448,6 +451,7 @@ static inline u32 tpm2_rc_value(u32 rc)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.39.3


