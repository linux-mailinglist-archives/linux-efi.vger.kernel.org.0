Return-Path: <linux-efi+bounces-5851-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17268CC032B
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2F65302EF40
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC5232AABC;
	Mon, 15 Dec 2025 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pFI7nTBD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADB32ABC0;
	Mon, 15 Dec 2025 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842047; cv=none; b=IuiGDQ9cUwgv5woBRKR2JzQZq4ZueF8alFHosM+698KPMNTLS5k/9wtbD1YSVJzUe02qDNPZpCMz69sPI7A9KibFdgVftJN+8j1KjOjgHqNnIs04+zB8X2aA/Itgfe5XjQqty9BhRlITDfM0yH5j3GcZ1Q36PrDiUkoi8xcKk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842047; c=relaxed/simple;
	bh=BreK8E4qWa6FoS7mjZ9vtiM28Q1idO2CyaxN8Xh0saI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHD1UMWVbxcXSMAW4yh7fgF4gCAp/rLO8bDGpqmNy3dlJwciWle+Lh+tNAdiJ3e3p2zdH2G7TmCCtTTajncdVbLUKfpXyydSv1y460m8IrF4x4C8AKYADxIBNrmntSadh0mQCOg4CYQkQOIh9jhNiFqUrhRVJdBFFaJJvnAfxJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pFI7nTBD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCSgJ2854805;
	Mon, 15 Dec 2025 23:39:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=fU5Vj
	FWdvXMLj66UjgdiPNgTrNS7xbcqJLjgYHXbYM8=; b=pFI7nTBDCygCrqTesnGRN
	WVU5ocQ3EpWz1nXKGxs4T0p23gUXrEdZyNjwbdhiP/X1LddAA37FUNyT0TfqRVq6
	y/0d+tftc8OU2DOK48glq3difVa3ZqeTmbblEa0qKt27B7U0uAbqcwRXRHRWAxse
	0IAkNLWUXtKpRFPXhyhkrgZwLOYl8K6J1OBiDMi6trV6K7jmtij/Yj0y/lX1su9B
	z7KjriYqtRj21AzvQAGLDnVYgV3VOeaZtQ3NOi8Q1J1eTyNXZEDtgHvzokdLIhJD
	rIQ24Hhwqn+Z09VPq9E1CIH8XfIkiasSJGm1SQ8AFoiISJfinRM3dDNHG3qF996p
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28b33b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:39:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMV1iL025211;
	Mon, 15 Dec 2025 23:39:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tpmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:39:55 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNdsof032371;
	Mon, 15 Dec 2025 23:39:54 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tpky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:39:54 +0000
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
Subject: [PATCH v15 02/28] tpm: Move TPM1 specific definitions and functions to new headers
Date: Mon, 15 Dec 2025 15:32:50 -0800
Message-ID: <20251215233316.1076248-3-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150204
X-Proofpoint-GUID: iwgQd14lcj989eAPpwQSiMfJoQ-3WKKl
X-Proofpoint-ORIG-GUID: iwgQd14lcj989eAPpwQSiMfJoQ-3WKKl
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=69409c4b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=xt6ew7UTAAAA:8 a=UN5060LkAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=FP58Ms26AAAA:8 a=afNhsboDH8tTV8YAr2QA:9
 a=tn93DeGZTgJ6DdWMtdD4:22 a=E6eXv-vVeS7VqOnxGRGn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX77iKHsss8+Uu
 Xl5d+8JWaD8aeewibiaDbshkOs0E9Jg4e73pnIRWVhpvgGYdwgkItuTdelH71J8MKOQBufkfIQa
 PxU3tXDBZ/yPVujhvgYBcmUJkWu3BajQo7TkIsKAx48Uipc32MaTcmDxX455WSuh0HMhqUQdueR
 L9pVCEiy8eK6Udl0f1cSukyTcE3DO+dz/w7gGtxECbrm9xw2O1hej7RkW3NQG1mitb4LzYqcfMb
 2j7HT7ac0tE1RQCMerLIjhcjG9g83/IighC61rQY/tOkNFCYHi2fJXQNaYiVHrvFgjZj13/mJqt
 l7h18Exbwp9IlHaVWKWft8GTbtRfjGcxhnkwys3nlE7FnlicAWUwN6ouFOEkkazBiKm9IDkZByO
 rV689DZHt9iwQ75dk/E7bq9Spni7IQ==

This gathers all the TPM1 definitions and structures into two separate
header files (public tpm1.h and private tpm1_structs.h). The definitions
moved to these files correspond to the TCG specification for TPM 1 family:

TPM 1.2 Main Specification
 -  https://trustedcomputinggroup.org/resource/tpm-main-specification/

Note that the structures were pulled into tpm1_structs.h to allow their
external reuse.

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm.h          | 98 +--------------------------------
 drivers/char/tpm/tpm1-cmd.c     |  5 --
 drivers/char/tpm/tpm1_structs.h | 97 ++++++++++++++++++++++++++++++++
 include/linux/tpm1.h            | 34 +++++++++++-
 4 files changed, 132 insertions(+), 102 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1_structs.h

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index ca391b2a211c..1f9f8540eede 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -50,105 +50,9 @@ enum tpm_addr {
 	TPM_ADDR = 0x4E,
 };
 
-#define TPM_WARN_RETRY          0x800
-#define TPM_WARN_DOING_SELFTEST 0x802
-#define TPM_ERR_DEACTIVATED     0x6
-#define TPM_ERR_DISABLED        0x7
-#define TPM_ERR_FAILEDSELFTEST  0x1C
-#define TPM_ERR_INVALID_POSTINIT 38
-
-#define TPM_TAG_RQU_COMMAND 193
-
 /* TPM2 specific constants. */
 #define TPM2_SPACE_BUFFER_SIZE		16384 /* 16 kB */
 
-struct	stclear_flags_t {
-	__be16	tag;
-	u8	deactivated;
-	u8	disableForceClear;
-	u8	physicalPresence;
-	u8	physicalPresenceLock;
-	u8	bGlobalLock;
-} __packed;
-
-struct tpm1_version {
-	u8 major;
-	u8 minor;
-	u8 rev_major;
-	u8 rev_minor;
-} __packed;
-
-struct tpm1_version2 {
-	__be16 tag;
-	struct tpm1_version version;
-} __packed;
-
-struct	timeout_t {
-	__be32	a;
-	__be32	b;
-	__be32	c;
-	__be32	d;
-} __packed;
-
-struct duration_t {
-	__be32	tpm_short;
-	__be32	tpm_medium;
-	__be32	tpm_long;
-} __packed;
-
-struct permanent_flags_t {
-	__be16	tag;
-	u8	disable;
-	u8	ownership;
-	u8	deactivated;
-	u8	readPubek;
-	u8	disableOwnerClear;
-	u8	allowMaintenance;
-	u8	physicalPresenceLifetimeLock;
-	u8	physicalPresenceHWEnable;
-	u8	physicalPresenceCMDEnable;
-	u8	CEKPUsed;
-	u8	TPMpost;
-	u8	TPMpostLock;
-	u8	FIPS;
-	u8	operator;
-	u8	enableRevokeEK;
-	u8	nvLocked;
-	u8	readSRKPub;
-	u8	tpmEstablished;
-	u8	maintenanceDone;
-	u8	disableFullDALogicInfo;
-} __packed;
-
-typedef union {
-	struct	permanent_flags_t perm_flags;
-	struct	stclear_flags_t	stclear_flags;
-	__u8	owned;
-	__be32	num_pcrs;
-	struct tpm1_version version1;
-	struct tpm1_version2 version2;
-	__be32	manufacturer_id;
-	struct timeout_t  timeout;
-	struct duration_t duration;
-} cap_t;
-
-enum tpm_capabilities {
-	TPM_CAP_FLAG = 4,
-	TPM_CAP_PROP = 5,
-	TPM_CAP_VERSION_1_1 = 0x06,
-	TPM_CAP_VERSION_1_2 = 0x1A,
-};
-
-enum tpm_sub_capabilities {
-	TPM_CAP_PROP_PCR = 0x101,
-	TPM_CAP_PROP_MANUFACTURER = 0x103,
-	TPM_CAP_FLAG_PERM = 0x108,
-	TPM_CAP_FLAG_VOL = 0x109,
-	TPM_CAP_PROP_OWNER = 0x111,
-	TPM_CAP_PROP_TIS_TIMEOUT = 0x115,
-	TPM_CAP_PROP_TIS_DURATION = 0x120,
-};
-
 enum tpm2_pt_props {
 	TPM2_PT_NONE = 0x00000000,
 	TPM2_PT_GROUP = 0x00000100,
@@ -229,6 +133,8 @@ enum tpm2_pt_props {
  * compiler warnings about stack frame size. */
 #define TPM_MAX_RNG_DATA	128
 
+#include "tpm1_structs.h"
+
 extern const struct class tpm_class;
 extern const struct class tpmrm_class;
 extern dev_t tpm_devt;
diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index f29827b454d2..02f20a0aa37d 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -505,11 +505,6 @@ ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
 }
 EXPORT_SYMBOL_GPL(tpm1_getcap);
 
-struct tpm1_get_random_out {
-	__be32 rng_data_len;
-	u8 rng_data[TPM_MAX_RNG_DATA];
-} __packed;
-
 /**
  * tpm1_get_random() - get random bytes from the TPM's RNG
  * @chip:	a &struct tpm_chip instance
diff --git a/drivers/char/tpm/tpm1_structs.h b/drivers/char/tpm/tpm1_structs.h
new file mode 100644
index 000000000000..ad21376af5ab
--- /dev/null
+++ b/drivers/char/tpm/tpm1_structs.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2004 IBM Corporation
+ * Copyright (C) 2015 Intel Corporation
+ *
+ * Authors:
+ * Leendert van Doorn <leendert@watson.ibm.com>
+ * Dave Safford <safford@watson.ibm.com>
+ * Reiner Sailer <sailer@watson.ibm.com>
+ * Kylene Hall <kjhall@us.ibm.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ */
+
+#ifndef __TPM1_STRUCTS_H__
+#define __TPM1_STRUCTS_H__
+
+struct	stclear_flags_t {
+	__be16	tag;
+	u8	deactivated;
+	u8	disableForceClear;
+	u8	physicalPresence;
+	u8	physicalPresenceLock;
+	u8	bGlobalLock;
+} __packed;
+
+struct tpm1_version {
+	u8 major;
+	u8 minor;
+	u8 rev_major;
+	u8 rev_minor;
+} __packed;
+
+struct tpm1_version2 {
+	__be16 tag;
+	struct tpm1_version version;
+} __packed;
+
+struct	timeout_t {
+	__be32	a;
+	__be32	b;
+	__be32	c;
+	__be32	d;
+} __packed;
+
+struct duration_t {
+	__be32	tpm_short;
+	__be32	tpm_medium;
+	__be32	tpm_long;
+} __packed;
+
+struct permanent_flags_t {
+	__be16	tag;
+	u8	disable;
+	u8	ownership;
+	u8	deactivated;
+	u8	readPubek;
+	u8	disableOwnerClear;
+	u8	allowMaintenance;
+	u8	physicalPresenceLifetimeLock;
+	u8	physicalPresenceHWEnable;
+	u8	physicalPresenceCMDEnable;
+	u8	CEKPUsed;
+	u8	TPMpost;
+	u8	TPMpostLock;
+	u8	FIPS;
+	u8	operator;
+	u8	enableRevokeEK;
+	u8	nvLocked;
+	u8	readSRKPub;
+	u8	tpmEstablished;
+	u8	maintenanceDone;
+	u8	disableFullDALogicInfo;
+} __packed;
+
+/* Gather all capabilities related information info one type */
+typedef union {
+	struct	permanent_flags_t perm_flags;
+	struct	stclear_flags_t	stclear_flags;
+	__u8	owned;
+	__be32	num_pcrs;
+	struct tpm1_version version1;
+	struct tpm1_version2 version2;
+	__be32	manufacturer_id;
+	struct timeout_t  timeout;
+	struct duration_t duration;
+} cap_t;
+
+struct tpm1_get_random_out {
+	__be32 rng_data_len;
+	u8 rng_data[TPM_MAX_RNG_DATA];
+} __packed;
+
+#endif
diff --git a/include/linux/tpm1.h b/include/linux/tpm1.h
index 54c6c211eb9e..5fad94ac8d15 100644
--- a/include/linux/tpm1.h
+++ b/include/linux/tpm1.h
@@ -47,7 +47,39 @@ enum tpm_command_ordinals {
 	TPM_ORD_UNSEAL			= 24,
 };
 
-/* Other constants */
+enum tpm_capabilities {
+	TPM_CAP_FLAG		= 4,
+	TPM_CAP_PROP		= 5,
+	TPM_CAP_VERSION_1_1	= 0x06,
+	TPM_CAP_VERSION_1_2	= 0x1A,
+};
+
+enum tpm_sub_capabilities {
+	TPM_CAP_PROP_PCR		= 0x101,
+	TPM_CAP_PROP_MANUFACTURER	= 0x103,
+	TPM_CAP_FLAG_PERM		= 0x108,
+	TPM_CAP_FLAG_VOL		= 0x109,
+	TPM_CAP_PROP_OWNER		= 0x111,
+	TPM_CAP_PROP_TIS_TIMEOUT	= 0x115,
+	TPM_CAP_PROP_TIS_DURATION	= 0x120,
+};
+
+/* Return Codes */
+enum tpm_return_codes {
+	TPM_BASE_MASK			= 0,
+	TPM_NON_FATAL_MASK		= 0x00000800,
+	TPM_SUCCESS			= TPM_BASE_MASK + 0,
+	TPM_ERR_DEACTIVATED		= TPM_BASE_MASK + 6,
+	TPM_ERR_DISABLED		= TPM_BASE_MASK + 7,
+	TPM_ERR_FAIL			= TPM_BASE_MASK + 9,
+	TPM_ERR_FAILEDSELFTEST		= TPM_BASE_MASK + 28,
+	TPM_ERR_INVALID_POSTINIT	= TPM_BASE_MASK + 38,
+	TPM_ERR_INVALID_FAMILY		= TPM_BASE_MASK + 55,
+	TPM_WARN_RETRY			= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 0,
+	TPM_WARN_DOING_SELFTEST		= TPM_BASE_MASK + TPM_NON_FATAL_MASK + 2,
+};
+
+/* Misc. constants */
 #define SRKHANDLE                       0x40000000
 #define TPM_NONCE_SIZE                  20
 #define TPM_ST_CLEAR			1
-- 
2.43.7


