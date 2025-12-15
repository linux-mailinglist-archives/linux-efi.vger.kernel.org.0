Return-Path: <linux-efi+bounces-5856-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3452CC0377
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E940305BFFB
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F1B32C305;
	Mon, 15 Dec 2025 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dm2h+eMo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469AD3242AA;
	Mon, 15 Dec 2025 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842070; cv=none; b=lEfVSAsGk4VL3pBNH5iWxoHdIvn0VCKLahEAnUXzgQIxdcJCo7b8ZPcyBpM0Wnb34T6Fm/l2teEPp7kkzs1vkqsmuc6k8RLSuiewoe/Yanuk9h4tSxyLFYFfv2Pm03dzo68PZ2VNYxTuJR32K9Cc/KaQcS4vvBjLuHf7EY26sOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842070; c=relaxed/simple;
	bh=KRSd5wrbqoA5rT14EUAhhr1kdNpftAgz8hFiC87AkEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgNVHQ0u8NL5Ozw068pA2bBIRsfaq/aK0n0LNxVBrMFY5GE6ZT63Y3JpXAw15iGdRn8sIaTGgy33dlhyr1+Z6Em3Q52J4wuFHfjkcI2EO1KsmafRp0H3McD7nLdMWI4aNerCMA010sdlTSA8/H+f6so1egIPqscOJyrVg0AtWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dm2h+eMo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCGOB2854637;
	Mon, 15 Dec 2025 23:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3u/Xq
	oToiD6XAJ/AVKI4/QImR0Kahdw+sYg3F9Fi74w=; b=dm2h+eMoCSGKcALaLTFj0
	XG0VCGB8f6MY7DWE2/nFKtxQ8HNWJ3bmVJmiRIMyH0B7XbsdV81X4h/xaSfMSpz1
	5eB9uhXdUrh5d0jZdRWkElfHerawiDWRwTq9AHaCSBbZVCjXvtboUjLtov9LZEcx
	nlSHrW38vRBgGsUVmiHK8hp1t+zv05/oMCRyozvftMN8SUqgg2LlgGz2m+TXGFdl
	mVeAjaNY/xVu0oOnVi/kNLr3XWUeRZ93gsWUePq7trFHD9iyZwDy4E5vR8AJeV0f
	b4LfopwH7aLjMl1m2DLWmk52+xQ6wjDQISRxw9lG40NuCwZ68dtK2vSt91QjPgjE
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28b33v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFNF88N006142;
	Mon, 15 Dec 2025 23:40:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck8v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:15 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNeERf023429;
	Mon, 15 Dec 2025 23:40:14 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkck8u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:14 +0000
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
Subject: [PATCH v15 06/28] tpm: Add TPM buffer support header for standalone reuse
Date: Mon, 15 Dec 2025 15:32:54 -0800
Message-ID: <20251215233316.1076248-7-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: HC6eybbroLLc0WBVHZNHV7BpA8y_MjW2
X-Proofpoint-ORIG-GUID: HC6eybbroLLc0WBVHZNHV7BpA8y_MjW2
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=69409c60 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UN5060LkAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=FP58Ms26AAAA:8 a=xt6ew7UTAAAA:8 a=aY4EUbk01JFM1SX_nzkA:9
 a=E6eXv-vVeS7VqOnxGRGn:22 a=tn93DeGZTgJ6DdWMtdD4:22 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX/238StPAK7c4
 V51SxpZhHFzQkUvPN0AyJ8Cl+Gsn5jAOGjY79JHzXW+jvNtJsMpZICeWt4M8DxjmzIiPG9e9qvK
 PGIZrgurEE4r7d6ezjC2hUlOjzFYsz5J/MLM/zOddmQMO8XWJsrZ1wQkckdMGMEY4FobGn8xj3y
 TpHVMMrYdJdfDjSJrHxNkCWLGnU9d7pT8v8tUfnvIv+XQQdrvHBEPI/x04S07j4U5qvO2Y36enC
 Iwyd+qnAY5uBm7tuGRqqct9QmDith4rlWBzTm8R2v6IImBqKniMuMW82jF2eTw3kXqMrxttr/m9
 CIkGG+gotJj6TSc/PvQAZl6xRSNvFP/9a4nVzKN8bBT7x25mX1IgPCtEJZlZNMVp/B57P6Ji996
 oCCqARWv6Z/5gOdn/WRlJ2fN7VRXrxEITgqRSIBlPO66rTYzaTQ=

Extact all the functions and definitions for the TPM buffer handling
and separate them into their own header. TPM buf functionality was
decoupled throughout the TPM code base in an earlier commit.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-buf.c |  7 ++++-
 include/linux/tpm.h        | 44 +----------------------------
 include/linux/tpm_buf.h    | 57 ++++++++++++++++++++++++++++++++++++++
 include/linux/tpm_common.h | 10 +++++++
 4 files changed, 74 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/tpm_buf.h

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index dae23e6de269..f0b6a7453edd 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -3,8 +3,13 @@
  * Handling of TPM command and other buffers.
  */
 
+#include <linux/types.h>
 #include <linux/module.h>
-#include <linux/tpm.h>
+#include <crypto/sha2.h>
+#include <linux/tpm_common.h>
+#include <linux/tpm1.h>
+#include <linux/tpm2.h>
+#include <linux/tpm_buf.h>
 
 static void __tpm_buf_size_invariant(struct tpm_buf *buf, u16 buf_size)
 {
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8a778bcc2dd5..4c02076a8c39 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -28,6 +28,7 @@
 #include "tpm_common.h"
 #include "tpm1.h"
 #include "tpm2.h"
+#include "tpm_buf.h"
 
 struct tpm_chip;
 struct trusted_key_payload;
@@ -35,12 +36,6 @@ struct trusted_key_options;
 /* opaque structure, holds auth session parameters like the session key */
 struct tpm2_auth;
 
-struct tpm_bank_info {
-	u16 alg_id;
-	u16 digest_size;
-	u16 crypto_id;
-};
-
 enum TPM_OPS_FLAGS {
 	TPM_OPS_AUTO_STARTUP = BIT(0),
 };
@@ -208,48 +203,11 @@ enum tpm_chip_flags {
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
-enum tpm_buf_flags {
-	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(0),
-	/* The buffer is in invalid and unusable state: */
-	TPM_BUF_INVALID		= BIT(1),
-};
-
-/*
- * A buffer for constructing and parsing TPM commands, responses and sized
- * (TPM2B) buffers.
- */
-struct tpm_buf {
-	u8 flags;
-	u8 handles;
-	u16 length;
-	u16 capacity;
-	u8 data[];
-};
-
 struct tpm2_hash {
 	unsigned int crypto_id;
 	unsigned int tpm_id;
 };
 
-void tpm_buf_init(struct tpm_buf *buf, u16 buf_size);
-void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size);
-void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
-void tpm_buf_reset_sized(struct tpm_buf *buf);
-u32 tpm_buf_length(struct tpm_buf *buf);
-void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
-void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
-void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
-void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
-u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
-u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
-u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
-void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash);
-void tpm2_buf_append_pcr_extend(struct tpm_buf *buf, struct tpm_digest *digests,
-				struct tpm_bank_info *banks,
-				unsigned int nr_banks);
-
 /*
  * Check if TPM device is in the firmware upgrade mode.
  */
diff --git a/include/linux/tpm_buf.h b/include/linux/tpm_buf.h
new file mode 100644
index 000000000000..648fec72e490
--- /dev/null
+++ b/include/linux/tpm_buf.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2004,2007,2008 IBM Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ * Debora Velarde <dvelarde@us.ibm.com>
+ *
+ * Maintained by: <tpmdd_devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ */
+#ifndef __LINUX_TPM_BUF_H__
+#define __LINUX_TPM_BUF_H__
+
+enum tpm_buf_flags {
+	/* TPM2B format: */
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
+};
+
+/*
+ * A buffer for constructing and parsing TPM commands, responses and sized
+ * (TPM2B) buffers.
+ */
+struct tpm_buf {
+	u8 flags;
+	u8 handles;
+	u16 length;
+	u16 capacity;
+	u8 data[];
+};
+
+void tpm_buf_init(struct tpm_buf *buf, u16 buf_size);
+void tpm_buf_init_sized(struct tpm_buf *buf, u16 buf_size);
+void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
+void tpm_buf_reset_sized(struct tpm_buf *buf);
+u32 tpm_buf_length(struct tpm_buf *buf);
+void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length);
+void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
+void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
+void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
+u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
+u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
+u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
+void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash);
+void tpm2_buf_append_pcr_extend(struct tpm_buf *buf, struct tpm_digest *digests,
+				struct tpm_bank_info *banks,
+				unsigned int nr_banks);
+
+#endif
diff --git a/include/linux/tpm_common.h b/include/linux/tpm_common.h
index b5c6b2c1e517..0577f8182f67 100644
--- a/include/linux/tpm_common.h
+++ b/include/linux/tpm_common.h
@@ -56,6 +56,16 @@ enum tpm_localities {
 	TPM_MAX_LOCALITY	= TPM_LOCALITY_4
 };
 
+/*
+ * Structure to represent active PCR algorithm banks usable by the
+ * TPM.
+ */
+struct tpm_bank_info {
+	u16 alg_id;
+	u16 digest_size;
+	u16 crypto_id;
+};
+
 /*
  * 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
  * bytes, but 128 is still a relatively large number of random bytes and
-- 
2.43.7


