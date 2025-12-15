Return-Path: <linux-efi+bounces-5849-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE6ECC030D
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F27301E587
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412232ABC6;
	Mon, 15 Dec 2025 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PPRiASG4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26C32861E;
	Mon, 15 Dec 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842043; cv=none; b=VCXGGATi1fSG93uomLz4rcXNWi60jORLfMEtO+TpfyygPCX709WMUJEJD4VycLJnRlZZJbUa5mlKhj/FQCIaByg2b0JUdb1AeYfU5cb2IvBdtR3MmhM3Folrnhr2b7/ZwokTdjGYLXVsN3SUd8TZ8fEntRADgGA5YWjk0fUExAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842043; c=relaxed/simple;
	bh=C31jWfEF2cTShdygeGm8mhO7k+yDNQG/BDeA1GlYZNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pY1s2+MvyVEi/U36r93bHF8ZTpVV8cCb8hEF0DNWtkXoGh82+PVgd17AMei4YCxedeuO70AlRLSG0uvYPPQxTWuRwnHXNG6hn4UbE99SOahu7buym85Tl9eu+HFqNMZBg5kgtT/G5iE0bS7+H5Kv3NwW9uGJCEYb5HMG5Gz4sgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PPRiASG4; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCmwx2886593;
	Mon, 15 Dec 2025 23:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=r0UQ5
	Pa/nI/fSjiz3YrcmFxneLEF6dJc2oNctVuUkmo=; b=PPRiASG41ENxVLL2haC3b
	a04U0iUJrdiB3en6ceFhH+FuhEKB1u2K2jGFQUuThxIR3bn3+Zc6eNxun5WvUszS
	j659l89R47aUlbunqN0B+0zmwrc8oAuCF7tlBkvyYPWorvcoOAEOG5monZxR78PA
	VW8YCtC1dyHeUddRebRCUru0SF1MYXfF7bxon6/QpSThfuuEHsxeSIVmSr1qrk46
	g0TouM1kepGI9+8Eap5aYuEiPeKweOhOuR8K5k+tXnBzHgwXve34Mwtk+2awI/RE
	3E3UJB4sHtLkT+KbIXN1jaoMVGb182YkFNWsreFGJeyqs454HTEGoOjtxkQ8AgdK
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015u17y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFM3OQg024610;
	Mon, 15 Dec 2025 23:40:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t7xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:06 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNe549026660;
	Mon, 15 Dec 2025 23:40:06 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9t7v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:05 +0000
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
Subject: [PATCH v15 04/28] tpm: Move TPM common base definitions to new public common header
Date: Mon, 15 Dec 2025 15:32:52 -0800
Message-ID: <20251215233316.1076248-5-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: l7higQ6UCfMQPO5738wiPVjWTreliM4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX75KB+bN3DSgQ
 uOzz8P42ACGFxNtc2hxmsVHfJmbB+ngNy1blXREpJVhG1+KUOec5LggE78uWZqe7gKjzxpAcMRL
 zNPPRWaoqhaEvZ8iN2qXspXCnfJ74EkCNUhCl91s5xHQpX9+NBt3alZDY/7yvWVPTdXlsbf8ceA
 qh80Y1Um4ascqCJQylNnv3A+v+gSyi+JlKTaKgreCJ4UKoV1l6xTZoJDEkvqgXdk33MfugOd9ui
 8KWTsbZ1BYtLAQS2HMUKrUijJkDLDKpWPZQbkF2ZApMLvpRf50YfTqn7ZTzxcYw3JCR1UUfqd0o
 7sTut6h3+HVrIUbitGcAuQMQXHDTr3XI+VWqofjVTNAOBvcWx/XkJ+RfvXp6+pubW3zVXTl5idX
 MQIKnkr1MHTPVwKeLMOTaxOPEAGLVw==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69409c57 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=9u39xqQJ7Ymw5X7hPw4A:9 a=E6eXv-vVeS7VqOnxGRGn:22
X-Proofpoint-ORIG-GUID: l7higQ6UCfMQPO5738wiPVjWTreliM4A

These are top level definitions shared by both TPM 1 and 2
family chips. This includes core definitions like TPM localities,
timeouts, and common crypto algorithm IDs.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm.h     |  6 ----
 include/linux/tpm.h        | 44 -------------------------
 include/linux/tpm2.h       |  5 ---
 include/linux/tpm_common.h | 67 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 55 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index faac3c7065bf..7d608b166bbf 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -50,12 +50,6 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-/* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
- * bytes, but 128 is still a relatively large number of random bytes and
- * anything much bigger causes users of struct tpm_cmd_t to start getting
- * compiler warnings about stack frame size. */
-#define TPM_MAX_RNG_DATA	128
-
 #include "tpm1_structs.h"
 #include "tpm2_structs.h"
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index e77e3e2c1d9e..8a778bcc2dd5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -29,47 +29,12 @@
 #include "tpm1.h"
 #include "tpm2.h"
 
-#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
-#define TPM_HEADER_SIZE		10
-#define TPM_BUFSIZE		4096
-
-#define TPM2_PLATFORM_PCR	24
-#define TPM2_PCR_SELECT_MIN	3
-#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
-#define TPM2_MAX_BANKS		4
-
 struct tpm_chip;
 struct trusted_key_payload;
 struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-/* if you add a new hash to this, increment TPM_MAX_HASHES below */
-enum tpm_algorithms {
-	TPM_ALG_ERROR		= 0x0000,
-	TPM_ALG_SHA1		= 0x0004,
-	TPM_ALG_AES		= 0x0006,
-	TPM_ALG_KEYEDHASH	= 0x0008,
-	TPM_ALG_SHA256		= 0x000B,
-	TPM_ALG_SHA384		= 0x000C,
-	TPM_ALG_SHA512		= 0x000D,
-	TPM_ALG_NULL		= 0x0010,
-	TPM_ALG_SM3_256		= 0x0012,
-	TPM_ALG_ECC		= 0x0023,
-	TPM_ALG_CFB		= 0x0043,
-};
-
-/*
- * maximum number of hashing algorithms a TPM can have.  This is
- * basically a count of every hash in tpm_algorithms above
- */
-#define TPM_MAX_HASHES	5
-
-struct tpm_digest {
-	u16 alg_id;
-	u8 digest[TPM2_MAX_DIGEST_SIZE];
-} __packed;
-
 struct tpm_bank_info {
 	u16 alg_id;
 	u16 digest_size;
@@ -243,15 +208,6 @@ enum tpm_chip_flags {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-struct tpm_header {
-	__be16 tag;
-	__be32 length;
-	union {
-		__be32 ordinal;
-		__be32 return_code;
-	};
-} __packed;
-
 enum tpm_buf_flags {
 	/* TPM2B format: */
 	TPM_BUF_TPM2B		= BIT(0),
diff --git a/include/linux/tpm2.h b/include/linux/tpm2.h
index f87489aea780..c2ece73a54c5 100644
--- a/include/linux/tpm2.h
+++ b/include/linux/tpm2.h
@@ -164,11 +164,6 @@ enum tpm2_session_attributes {
 	TPM2_SA_AUDIT			= BIT(7),
 };
 
-enum tpm2_pcr_select {
-	TPM2_PLATFORM_PCR	= 24,
-	TPM2_PCR_SELECT_MIN	= ((TPM2_PLATFORM_PCR + 7) / 8),
-};
-
 enum tpm2_handle_types {
 	TPM2_HT_HMAC_SESSION	= 0x02000000,
 	TPM2_HT_POLICY_SESSION	= 0x03000000,
diff --git a/include/linux/tpm_common.h b/include/linux/tpm_common.h
index b8be669913dd..b5c6b2c1e517 100644
--- a/include/linux/tpm_common.h
+++ b/include/linux/tpm_common.h
@@ -19,4 +19,71 @@
 
 #define TPM_MAX_ORDINAL 243
 
+#define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
+#define TPM_HEADER_SIZE		10
+#define TPM_BUFSIZE		4096
+
+#define TPM2_PLATFORM_PCR	24
+#define TPM2_PCR_SELECT_MIN	3
+#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
+#define TPM2_MAX_BANKS		4
+
+/* if you add a new hash to this, increment TPM_MAX_HASHES below */
+enum tpm_algorithms {
+	TPM_ALG_ERROR		= 0x0000,
+	TPM_ALG_SHA1		= 0x0004,
+	TPM_ALG_AES		= 0x0006,
+	TPM_ALG_KEYEDHASH	= 0x0008,
+	TPM_ALG_SHA256		= 0x000B,
+	TPM_ALG_SHA384		= 0x000C,
+	TPM_ALG_SHA512		= 0x000D,
+	TPM_ALG_NULL		= 0x0010,
+	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_ECC		= 0x0023,
+	TPM_ALG_CFB		= 0x0043,
+};
+
+/*
+ * The locality (0 - 4) for a TPM, as defined in section 3.2 of the
+ * Client Platform Profile Specification.
+ */
+enum tpm_localities {
+	TPM_LOCALITY_0		= 0, /* Static RTM */
+	TPM_LOCALITY_1		= 1, /* Dynamic OS */
+	TPM_LOCALITY_2		= 2, /* DRTM Environment */
+	TPM_LOCALITY_3		= 3, /* Aux Components */
+	TPM_LOCALITY_4		= 4, /* CPU DRTM Establishment */
+	TPM_MAX_LOCALITY	= TPM_LOCALITY_4
+};
+
+/*
+ * 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
+ * bytes, but 128 is still a relatively large number of random bytes and
+ * anything much bigger causes users of struct tpm_cmd_t to start getting
+ * compiler warnings about stack frame size.
+ */
+#define TPM_MAX_RNG_DATA	128
+
+/*
+ * maximum number of hashing algorithms a TPM can have.  This is
+ * basically a count of every hash in tpm_algorithms above
+ */
+#define TPM_MAX_HASHES	5
+
+struct tpm_digest {
+	u16 alg_id;
+	u8 digest[TPM2_MAX_DIGEST_SIZE];
+} __packed;
+
+#define TPM_HEADER_SIZE		10
+
+struct tpm_header {
+	__be16 tag;
+	__be32 length;
+	union {
+		__be32 ordinal;
+		__be32 return_code;
+	};
+} __packed;
+
 #endif
-- 
2.43.7


