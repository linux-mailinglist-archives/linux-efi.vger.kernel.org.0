Return-Path: <linux-efi+bounces-5864-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528CCC042B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B61FE3058624
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F5B3314D1;
	Mon, 15 Dec 2025 23:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NOu+rubU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587DE32F764;
	Mon, 15 Dec 2025 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842124; cv=none; b=oZUUyZJVO4u9+q60qXZ5o7OwpgY1HCBHLJWa/WveBiV6U3oLG8tv49o9BArQAK7Y2kFxVFUbd23DGnx6yaR/u5y5PMIwYhB2euWgv0zeWUxoAzJ5q027HdFEgcaMugfAP2MgIZAn0SlPnBQdnMHFb/CC0EAnweDpj9bNufh3HD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842124; c=relaxed/simple;
	bh=5Lo835+FLp/iLLIAcUTIuN8L/OtZukDfxw5actJa47A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWjgOf5S8tEd18JtBLN0SKrfOhV4pwc03lmxrne01kSPC/6B0vz6gIhPVzjZIPHuUn/novoZqESfGUFxpTaipX0UDbvstXjFxn/L61whkRWfmhBXzBbaW6WwNoeT/3QF7QHI3mJ3VvE4A5lnxdEWfY3I/htvraETwg4losTZXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NOu+rubU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCOt42789071;
	Mon, 15 Dec 2025 23:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+Q+8Q
	RqKqNJJXNSZFwSfexLAcPeFNUd3jw/NWjBcWsY=; b=NOu+rubUxUawDFzq8VKYw
	0e7dgzUB52dI2mjJ566v6P5twaOof+o8bfvX6AFKPWwFns/JzUN4uQ1+KytP4Ny2
	haJo8NY9I9Y76RANToetDu5+aEsl8D+5OYcIMtGScB4yDO/jJY7qiGrNkMfHvsWv
	ijobAl31WKNKGjqWmP3yh20e7ZgtCAZYtuM3A6ImazeQhglSX2DEyO0g4IrLaDS1
	fMYL2hTv2oqSeDrE6K33gnBboUlOrd7j0pZSpNrOPoiWXkuUW0SHzLvtMwuIpuG0
	ofg73N052kz1uwgDC7E2WIRPCcrzoHxQ+dNGmfxkT5AndJTRG29jA61Cc/dMvMjR
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b10prk13x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMF40o024721;
	Mon, 15 Dec 2025 23:40:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9j7pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeVco004554;
	Mon, 15 Dec 2025 23:40:31 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9j7mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:31 +0000
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
Subject: [PATCH v15 10/28] tpm/tpm_tis: Allow locality to be set to a different value
Date: Mon, 15 Dec 2025 15:32:58 -0800
Message-ID: <20251215233316.1076248-11-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251215233316.1076248-1-ross.philipson@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_05,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfX3YIQux1pFfJP
 pD7ccL4yGUq9KemNOB0UWsyo4hirsuSS0DRcnWS2W2iqfLA9w8tzU5QZjDOBFVVFpmJxc5JaVYA
 48XIoXHKQhyLoF5ol7ImcsaUWpx/HZ6qEH5E/gGEQqgUKNceLl1NMVJ2Tsawkq9z59/9peUOXO4
 1haCm++3RuM5vOB+2BytKTTUSNlY/qc0YdcxdJK5d+aweK2BVyA4zRlzA3GYLNhj33Vbk08zVIh
 F+u4EzWdtVxXrMuUWu4wRuy/VaqYgFG7PIoEjlhNKLW7Axb8bNclF7Z+hRTdX31Ab3RnEk/nkAf
 OaPE+EKRQKRuo1oSOwfXGbQlHRCwiwFkuqDH+Fm2nGDQoSX7otx1LHB872QJ6PYVxGGXjZca8Az
 6GG6OILitg05Ip5eIvRu3ei9oImCGg==
X-Proofpoint-GUID: hkBmul1oM5qmeNSKlzD5nuCTVQ2hy84t
X-Proofpoint-ORIG-GUID: hkBmul1oM5qmeNSKlzD5nuCTVQ2hy84t
X-Authority-Analysis: v=2.4 cv=dParWeZb c=1 sm=1 tr=0 ts=69409c71 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=4DNJ525XC-kOuaC0:21 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=bkliQRudbypyXRIMEAEA:9

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
index 6cb25862688f..3171684ca782 100644
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
@@ -700,3 +701,34 @@ void tpm_chip_unregister(struct tpm_chip *chip)
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
+	if (locality >= TPM_MAX_LOCALITY)
+		return -EINVAL;
+
+	ret = tpm_try_get_ops(chip);
+	if (ret)
+		return ret;
+
+	if (!(chip->flags & TPM_CHIP_FLAG_SET_LOCALITY_ENABLED)) {
+		tpm_put_ops(chip);
+		return -EPERM;
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
index 14a7e60bfbb8..07e3b6e137f7 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -1125,6 +1125,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	chip->flags |= TPM_CHIP_FLAG_SET_LOCALITY_ENABLED;
+
 #ifdef CONFIG_ACPI
 	chip->acpi_dev_handle = acpi_dev_handle;
 #endif
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 87978cc584ee..11264d04a9ef 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -167,6 +167,8 @@ struct tpm_chip {
 
 	/* active locality */
 	int locality;
+	/* the locality used by kernel */
+	u8 kernel_locality;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 	/* details for communication security via sessions */
@@ -205,6 +207,7 @@ enum tpm_chip_flags {
 	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
 	TPM_CHIP_FLAG_DISABLE			= BIT(10),
 	TPM_CHIP_FLAG_SYNC			= BIT(11),
+	TPM_CHIP_FLAG_SET_LOCALITY_ENABLED	= BIT(12),
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -252,6 +255,7 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
 extern int tpm_is_tpm2(struct tpm_chip *chip);
 extern __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 extern void tpm_put_ops(struct tpm_chip *chip);
+int tpm_chip_set_locality(struct tpm_chip *chip, u8 locality);
 extern ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
 				size_t min_rsp_body_length, const char *desc);
 extern int tpm_pcr_read(struct tpm_chip *chip, u32 pcr_idx,
-- 
2.43.7


