Return-Path: <linux-efi+bounces-5848-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA07BCC02F2
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E31593014AF5
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B82B329C57;
	Mon, 15 Dec 2025 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RzUbyLkF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86E328275;
	Mon, 15 Dec 2025 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842041; cv=none; b=WWgA2TS/UFx/KRmPizDuvkFbsZmN40kYXxyjhLrogijn4CBBArRwB02+UBQ6ZYHdcL8+X4DCGKU3vu3GO5/O1p1pnJJ7Ydt7xKe2UpQz00W5oYF1uQ6MkOOqxnjktxUxO0n3UR82BbauXcVVsCuTRKnXrdpB8OAYPwej9/PhcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842041; c=relaxed/simple;
	bh=5glUMjNA9hYridJApKPOT+UWwsY+UAvdBOOBKjfhu6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EztvaqLl5gREFMD+IK+rWf8ZeP+45bN3E5eoTfcj2Rvd5fhvAaThxGUzRwxTQTIwk313I4Ahot/elvy6BpMQi8pJeAz7DZIGc1nbFeR8E2TmoX3zTE0LMk6y5/2TmxddLgA937vJXbD3uUWAGeESdw3JaTrORQH3tom82QaTfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RzUbyLkF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCMtq2886203;
	Mon, 15 Dec 2025 23:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=tzLvZ
	FhdpkTN22O4Yy3+geQe4dPo2QF0BUp01ZQMyhs=; b=RzUbyLkFpxJeSGITogeha
	3X4KasJhKmzFuh93ZiXKz+I5DzD/rP9W4HNLj/t+08ZMDgdzMN3nqQ+y9kq32R4V
	2phUu05d1O9DFgZbg7zh/S12sU7vXMSwT8GIl0J86Xp8IllKVtfovQsWOdLYDG9b
	Ux4tlDOgLvietztW/nyCP12YGl04wLS2rvj9Qo/DhI76GOiQT++e0TkqFHUCyvO0
	zu/TbPJ+JVjX422IBnoGc2z3UMXMw38Z7SGhyDTsz6diBhSb6ajFhkX6efdPSPom
	kPUIHKQ8sl5fVqEH3h93odKlEuZppTAHlinpyJoK6FJichA0bdmAsruCWTq8g9yq
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015u17m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:39:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFLHPPh022550;
	Mon, 15 Dec 2025 23:39:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkbj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:39:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNdmOW007493;
	Mon, 15 Dec 2025 23:39:48 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkjkbhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:39:48 +0000
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
Subject: [PATCH v15 01/28] tpm: Initial step to reorganize TPM public headers
Date: Mon, 15 Dec 2025 15:32:49 -0800
Message-ID: <20251215233316.1076248-2-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: _xGkpnAJf8R05egiksTREaWadUM__DrT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX6tdjJsl1NoeB
 DS5OSXIuY6fZf6i8Dux0u91y6pTRP4laoGgDxJVMPk2BRLqQ+hvDiS5w63nWgNRS1CJVFFUgh4Q
 b7vE3Yyindy83M46GtVDokYtWtbgu1ntMTJ1ykikERfOE/mB3rc/xbJylxBQoasAtefEj1SWSK1
 fL5LCqdXl4xQavpiGysVz9q6D+/xvllesNx+F5WkMl1yc4bGRzPNJFaPMpO7kFvmOhDLSP0jLYR
 Ya3c02qYkqlCxlEKNqj21VLaabfM+OFoaMzkm9RP+jyi8FzX0t1U4OKK0H93nhqRL7kuE5E7ouf
 GFuhhI3We8y1dQiP2uOAh0Ypf90hrZW+VzybxQYiUfEtQgVktCu8gJtiHR0rphypnU1sIy5TJNA
 +EjQ7W0DQzKEIpoTzudqbImCusUI6lHYyCHBxzcJ7Utiz6/1X28=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=69409c47 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=xt6ew7UTAAAA:8 a=UN5060LkAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=FP58Ms26AAAA:8 a=CLgDDJZMEY7syEPonIoA:9
 a=tn93DeGZTgJ6DdWMtdD4:22 a=E6eXv-vVeS7VqOnxGRGn:22 cc=ntf awl=host:13654
X-Proofpoint-ORIG-GUID: _xGkpnAJf8R05egiksTREaWadUM__DrT

Replace the existing public header tpm_command.h with the first two
new public headers tpm1.h and tpm_common.h. In addition, related
definitions in tpm1_cmd.c were moved to the new tpm1.h.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-buf.c                |  3 +-
 drivers/char/tpm/tpm1-cmd.c               | 13 +-----
 include/keys/trusted_tpm.h                |  1 -
 include/linux/tpm.h                       |  3 ++
 include/linux/tpm1.h                      | 55 +++++++++++++++++++++++
 include/linux/tpm_command.h               | 30 -------------
 include/linux/tpm_common.h                | 22 +++++++++
 security/keys/trusted-keys/trusted_tpm1.c |  1 -
 security/keys/trusted-keys/trusted_tpm2.c |  1 -
 9 files changed, 82 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/tpm1.h
 delete mode 100644 include/linux/tpm_command.h
 create mode 100644 include/linux/tpm_common.h

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 1cb649938c01..dae23e6de269 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -3,7 +3,6 @@
  * Handling of TPM command and other buffers.
  */
 
-#include <linux/tpm_command.h>
 #include <linux/module.h>
 #include <linux/tpm.h>
 
@@ -296,7 +295,7 @@ void tpm1_buf_append_extend(struct tpm_buf *buf, u32 pcr_idx, const u8 *hash)
 	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
-	if (!tpm1_buf_is_command(buf, TPM_ORD_EXTEND)) {
+	if (!tpm1_buf_is_command(buf, TPM_ORD_PCR_EXTEND)) {
 		WARN(1, "tpm_buf: invalid TPM_Extend command\n");
 		buf->flags |= TPM_BUF_INVALID;
 		return;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index bc156d7d59f2..f29827b454d2 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -18,12 +18,9 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/freezer.h>
-#include <linux/tpm_command.h>
 #include <linux/tpm_eventlog.h>
 #include "tpm.h"
 
-#define TPM_MAX_ORDINAL 243
-
 /*
  * Array with one entry per ordinal defining the maximum amount
  * of time the chip could take to return the result.  The ordinal
@@ -308,9 +305,6 @@ unsigned long tpm1_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
 		return duration;
 }
 
-#define TPM_ORD_STARTUP 153
-#define TPM_ST_CLEAR 1
-
 /**
  * tpm1_startup() - turn on the TPM
  * @chip: TPM chip to use
@@ -478,7 +472,6 @@ int tpm1_pcr_extend(struct tpm_chip *chip, u32 pcr_idx, const u8 *hash,
 	return rc;
 }
 
-#define TPM_ORD_GET_CAP 101
 ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 		    const char *desc, size_t min_cap_length)
 {
@@ -574,7 +567,6 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	return rc;
 }
 
-#define TPM_ORD_PCRREAD 21
 int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 {
 	int rc;
@@ -584,7 +576,7 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 		return -ENOMEM;
 
 	tpm_buf_init(buf, TPM_BUFSIZE);
-	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCRREAD);
+	tpm_buf_reset(buf, TPM_TAG_RQU_COMMAND, TPM_ORD_PCR_READ);
 	tpm_buf_append_u32(buf, pcr_idx);
 
 	rc = tpm_transmit_cmd(chip, buf, TPM_DIGEST_SIZE,
@@ -599,7 +591,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf)
 	return rc;
 }
 
-#define TPM_ORD_CONTINUE_SELFTEST 83
 /**
  * tpm1_continue_selftest() - run TPM's selftest
  * @chip: TPM chip to use
@@ -716,8 +707,6 @@ int tpm1_auto_startup(struct tpm_chip *chip)
 	return rc;
 }
 
-#define TPM_ORD_SAVESTATE 152
-
 /**
  * tpm1_pm_suspend() - pm suspend handler
  * @chip: TPM chip to use.
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 0fadc6a4f166..3a0fa3bc8454 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -3,7 +3,6 @@
 #define __TRUSTED_TPM_H
 
 #include <keys/trusted-type.h>
-#include <linux/tpm_command.h>
 
 extern struct trusted_key_ops trusted_key_tpm_ops;
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8da49e8769d5..ef81e0b59657 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -25,6 +25,9 @@
 #include <crypto/hash_info.h>
 #include <crypto/aes.h>
 
+#include "tpm_common.h"
+#include "tpm1.h"
+
 #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
 #define TPM_HEADER_SIZE		10
 #define TPM_BUFSIZE		4096
diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
new file mode 100644
index 000000000000..54c6c211eb9e
--- /dev/null
+++ b/include/linux/tpm1.h
@@ -0,0 +1,55 @@
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
+#ifndef __LINUX_TPM1_H__
+#define __LINUX_TPM1_H__
+
+/*
+ * TPM 1.2 Main Specification
+ * https://trustedcomputinggroup.org/resource/tpm-main-specification/
+ */
+
+/* Command TAGS */
+enum tpm_command_tags {
+	TPM_TAG_RQU_COMMAND		= 193,
+	TPM_TAG_RQU_AUTH1_COMMAND	= 194,
+	TPM_TAG_RQU_AUTH2_COMMAND	= 195,
+	TPM_TAG_RSP_COMMAND		= 196,
+	TPM_TAG_RSP_AUTH1_COMMAND	= 197,
+	TPM_TAG_RSP_AUTH2_COMMAND	= 198,
+};
+
+/* Command Ordinals */
+enum tpm_command_ordinals {
+	TPM_ORD_CONTINUE_SELFTEST	= 83,
+	TPM_ORD_GET_CAP			= 101,
+	TPM_ORD_GET_RANDOM		= 70,
+	TPM_ORD_PCR_EXTEND		= 20,
+	TPM_ORD_PCR_READ		= 21,
+	TPM_ORD_OSAP			= 11,
+	TPM_ORD_OIAP			= 10,
+	TPM_ORD_SAVESTATE		= 152,
+	TPM_ORD_SEAL			= 23,
+	TPM_ORD_STARTUP			= 153,
+	TPM_ORD_UNSEAL			= 24,
+};
+
+/* Other constants */
+#define SRKHANDLE                       0x40000000
+#define TPM_NONCE_SIZE                  20
+#define TPM_ST_CLEAR			1
+
+#endif
diff --git a/include/linux/tpm_command.h b/include/linux/tpm_command.h
deleted file mode 100644
index 02038972a05f..000000000000
--- a/include/linux/tpm_command.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_TPM_COMMAND_H__
-#define __LINUX_TPM_COMMAND_H__
-
-/*
- * TPM Command constants from specifications at
- * http://www.trustedcomputinggroup.org
- */
-
-/* Command TAGS */
-#define TPM_TAG_RQU_COMMAND             193
-#define TPM_TAG_RQU_AUTH1_COMMAND       194
-#define TPM_TAG_RQU_AUTH2_COMMAND       195
-#define TPM_TAG_RSP_COMMAND             196
-#define TPM_TAG_RSP_AUTH1_COMMAND       197
-#define TPM_TAG_RSP_AUTH2_COMMAND       198
-
-/* Command Ordinals */
-#define TPM_ORD_OIAP                    10
-#define TPM_ORD_OSAP                    11
-#define TPM_ORD_EXTEND			20
-#define TPM_ORD_SEAL                    23
-#define TPM_ORD_UNSEAL                  24
-#define TPM_ORD_GET_RANDOM              70
-
-/* Other constants */
-#define SRKHANDLE                       0x40000000
-#define TPM_NONCE_SIZE                  20
-
-#endif
diff --git a/include/linux/tpm_common.h b/include/linux/tpm_common.h
new file mode 100644
index 000000000000..b8be669913dd
--- /dev/null
+++ b/include/linux/tpm_common.h
@@ -0,0 +1,22 @@
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
+#ifndef __LINUX_TPM_COMMON_H__
+#define __LINUX_TPM_COMMON_H__
+
+#define TPM_MAX_ORDINAL 243
+
+#endif
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 6e6a9fb48e63..3717a06a5212 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -17,7 +17,6 @@
 #include <keys/trusted-type.h>
 #include <linux/key-type.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted_tpm.h>
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0a99bd051a25..e6000c71eeb6 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -9,7 +9,6 @@
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/tpm.h>
-#include <linux/tpm_command.h>
 
 #include <keys/trusted-type.h>
 #include <keys/trusted_tpm.h>
-- 
2.43.7


