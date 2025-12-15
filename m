Return-Path: <linux-efi+bounces-5854-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472BCC031C
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49648301413E
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB86232939C;
	Mon, 15 Dec 2025 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QDzWMRHG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A589329C61;
	Mon, 15 Dec 2025 23:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842068; cv=none; b=ulSt0ZN7rUHKHQ5VewdlZnGIsB+/ZPzsyRQSMN/oe39Se15eM7AaiQo/3EbmvpyRaTcZhmn6NV66kSXVf4dWGCVyB8rH06kYkHFJeFBnCdmPr3mihOp9TDMn5iVeI0oHANj0Qm8Kv9QIC5EkRdbR20iJP2iXWSP1ClYAdZ6xT4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842068; c=relaxed/simple;
	bh=4n76Lf5kF2ksT0KTz+uCR7V4PJFNJEnN2LnFRmUOiIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwuvzWkQVGJXv+JWoQcPc2v6GkSkUV7aWiv8LoOib+phW+Xg7vPKgg3veXG0rBrF9VI/IvSwnwCsaFZCUbYzeHjfjKmUiQEUGgwMlydclWRV6hJgmC8PGwnehPVl16tNOz3J0MA6K5D7dQ7Sowr021aVkPWgaLD+mUHQ/YcUKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QDzWMRHG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJCK6g2854678;
	Mon, 15 Dec 2025 23:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xMCEu
	KI2lWfN3lUjsFBQjiZjX/vUiVKxKEJMU2EayHA=; b=QDzWMRHGRpu5ZAWGYiAFn
	ug+uL1pDbNe4CYYDImaPKIEsTDrlGnR0F3EAJ82eE9IKekq0kBsTwdB5Zx5KHwli
	UHfbQJ6x6yG07ZPas23TYKxC6Elyu1iozflKK4CQ8Qi0BWnNlgY65reyZWP+o10V
	BszWPVN9k+3jBcaa5a/NCDdrQvALyIN7kFKlxlA9075ivSCu9zIVI1w6/2cBhxda
	VUBMXWMpc+amnJPuj52P8ifxuLf7/2PX+PHopjl1rR2wmgRozUpjQiFl2qyw4dX/
	ZVISOPXdwm5KceyzdygmDppb3KwDitd7UqcAqPv4q30JrcmGZPbWA/lKoURN9gva
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28b33t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:40:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFMt0pK025232;
	Mon, 15 Dec 2025 23:40:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tptx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:12 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNaCmN025641;
	Mon, 15 Dec 2025 23:40:11 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tpse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:40:11 +0000
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
Subject: [PATCH v15 05/28] tpm: Move platform specific definitions to the new PTP header
Date: Mon, 15 Dec 2025 15:32:53 -0800
Message-ID: <20251215233316.1076248-6-ross.philipson@oracle.com>
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
X-Proofpoint-GUID: 4aOvwS_tyzvcVdaWKa_FoFQHq5jOaFKr
X-Proofpoint-ORIG-GUID: 4aOvwS_tyzvcVdaWKa_FoFQHq5jOaFKr
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=69409c5d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=xt6ew7UTAAAA:8 a=UN5060LkAAAA:8
 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=FP58Ms26AAAA:8 a=QE0NePTOvqx61Eo5uxoA:9
 a=dMjLEnNuu+1HN+MEBeouubInGVw=:19 a=tn93DeGZTgJ6DdWMtdD4:22
 a=E6eXv-vVeS7VqOnxGRGn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwMyBTYWx0ZWRfX4OX+0QUXubug
 oCJOCFwA+E1Hzar6MR4e2Ib8Dt/v1WoDqD+U93rNQ77ck1x/7N77a1P22FG/A5aucuYUQG3bfsB
 Jmw/I4XohQiiNROQpicj/t9y4T5I8K8LLRUcGGwsk56rEE8L1EYJrl5mFNeT/rYZILRReXEmdBt
 8j87fWyKXAF+lSu64TcslE/gJAfW+ak4xcxzT6bvQXLq98yCTKiq6ZlNzBFgHMLnKccnHXqNqG5
 tANxN5VR55gNW6HG0X8KmxVdWkt0H5EJOnW85Wibq1vHve6npFQDFdCC5qgE3mhG5ss6OMnIWSF
 adCzPh9wcB+4WgLFsEAH/PnX3wDtRz3sdTROxhdpMA3tX4ldblebqvzlU9FmF5OQeJe3xVAx6M9
 ch6VvcEHYjPAbd2CM0Te6wFMg23s9A==

These are definitions for the TPM interface and interactions with
the platform as defined in the TCG specification:

TCG PC Client Platform TPM Profile (PTP) Specification
 - https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/

Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm_tis_core.h |  64 +--------------
 include/linux/tpm_ptp.h         | 139 ++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 63 deletions(-)
 create mode 100644 include/linux/tpm_ptp.h

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 6c3aa480396b..be68883ed399 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -19,71 +19,9 @@
 #ifndef __TPM_TIS_CORE_H__
 #define __TPM_TIS_CORE_H__
 
+#include <linux/tpm_ptp.h>
 #include "tpm.h"
 
-enum tis_access {
-	TPM_ACCESS_VALID = 0x80,
-	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
-	TPM_ACCESS_REQUEST_PENDING = 0x04,
-	TPM_ACCESS_REQUEST_USE = 0x02,
-};
-
-enum tis_status {
-	TPM_STS_VALID = 0x80,
-	TPM_STS_COMMAND_READY = 0x40,
-	TPM_STS_GO = 0x20,
-	TPM_STS_DATA_AVAIL = 0x10,
-	TPM_STS_DATA_EXPECT = 0x08,
-	TPM_STS_RESPONSE_RETRY = 0x02,
-	TPM_STS_READ_ZERO = 0x23, /* bits that must be zero on read */
-};
-
-enum tis_int_flags {
-	TPM_GLOBAL_INT_ENABLE = 0x80000000,
-	TPM_INTF_BURST_COUNT_STATIC = 0x100,
-	TPM_INTF_CMD_READY_INT = 0x080,
-	TPM_INTF_INT_EDGE_FALLING = 0x040,
-	TPM_INTF_INT_EDGE_RISING = 0x020,
-	TPM_INTF_INT_LEVEL_LOW = 0x010,
-	TPM_INTF_INT_LEVEL_HIGH = 0x008,
-	TPM_INTF_LOCALITY_CHANGE_INT = 0x004,
-	TPM_INTF_STS_VALID_INT = 0x002,
-	TPM_INTF_DATA_AVAIL_INT = 0x001,
-};
-
-enum tis_defaults {
-	TIS_MEM_LEN = 0x5000,
-	TIS_SHORT_TIMEOUT = 750,	/* ms */
-	TIS_LONG_TIMEOUT = 4000,	/* 4 secs */
-	TIS_TIMEOUT_MIN_ATML = 14700,	/* usecs */
-	TIS_TIMEOUT_MAX_ATML = 15000,	/* usecs */
-};
-
-/* Some timeout values are needed before it is known whether the chip is
- * TPM 1.0 or TPM 2.0.
- */
-#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
-#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
-#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
-#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
-
-#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
-#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
-#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
-#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
-#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
-#define	TPM_STS(l)			(0x0018 | ((l) << 12))
-#define	TPM_STS3(l)			(0x001b | ((l) << 12))
-#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
-
-#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
-#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
-
-#define LPC_CNTRL_OFFSET		0x84
-#define LPC_CLKRUN_EN			(1 << 2)
-#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
-#define ILB_REMAP_SIZE			0x100
-
 enum tpm_tis_flags {
 	TPM_TIS_ITPM_WORKAROUND		= 0,
 	TPM_TIS_INVALID_STATUS		= 1,
diff --git a/include/linux/tpm_ptp.h b/include/linux/tpm_ptp.h
new file mode 100644
index 000000000000..9b75a54089a5
--- /dev/null
+++ b/include/linux/tpm_ptp.h
@@ -0,0 +1,139 @@
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
+#ifndef __LINUX_TPM_PTP_H__
+#define __LINUX_TPM_PTP_H__
+
+/*
+ * TCG PC Client Platform TPM Profile (PTP) Specification
+ * https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+ */
+
+enum tis_access {
+	TPM_ACCESS_VALID		= 0x80,
+	TPM_ACCESS_ACTIVE_LOCALITY	= 0x20,	/* (R) */
+	TPM_ACCESS_RELINQUISH_LOCALITY	= 0x20, /* (W) */
+	TPM_ACCESS_REQUEST_PENDING	= 0x04,	/* (W) */
+	TPM_ACCESS_REQUEST_USE		= 0x02,	/* (W) */
+};
+
+enum tis_status {
+	TPM_STS_VALID		= 0x80, /* (R) */
+	TPM_STS_COMMAND_READY	= 0x40, /* (R) */
+	TPM_STS_DATA_AVAIL	= 0x10, /* (R) */
+	TPM_STS_DATA_EXPECT	= 0x08, /* (R) */
+	TPM_STS_GO		= 0x20, /* (W) */
+	TPM_STS_RESPONSE_RETRY	= 0x02, /* (R) */
+	TPM_STS_READ_ZERO	= 0x23, /* bits that must be zero on read */
+};
+
+enum tis_int_flags {
+	TPM_GLOBAL_INT_ENABLE		= 0x80000000,
+	TPM_INTF_BURST_COUNT_STATIC	= 0x100,
+	TPM_INTF_CMD_READY_INT		= 0x080,
+	TPM_INTF_INT_EDGE_FALLING	= 0x040,
+	TPM_INTF_INT_EDGE_RISING	= 0x020,
+	TPM_INTF_INT_LEVEL_LOW		= 0x010,
+	TPM_INTF_INT_LEVEL_HIGH		= 0x008,
+	TPM_INTF_LOCALITY_CHANGE_INT	= 0x004,
+	TPM_INTF_STS_VALID_INT		= 0x002,
+	TPM_INTF_DATA_AVAIL_INT		= 0x001,
+};
+
+enum tis_defaults {
+	TIS_MEM_LEN		= 0x5000,
+	TIS_SHORT_TIMEOUT	= 750,   /* ms */
+	TIS_LONG_TIMEOUT	= 4000,  /* 4 secs */
+	TIS_TIMEOUT_MIN_ATML	= 14700, /* usecs */
+	TIS_TIMEOUT_MAX_ATML	= 15000, /* usecs */
+};
+
+/*
+ * Some timeout values are needed before it is known whether the chip is
+ * TPM 1.0 or TPM 2.0.
+ */
+#define TIS_TIMEOUT_A_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_A)
+#define TIS_TIMEOUT_B_MAX	max_t(int, TIS_LONG_TIMEOUT, TPM2_TIMEOUT_B)
+#define TIS_TIMEOUT_C_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_C)
+#define TIS_TIMEOUT_D_MAX	max_t(int, TIS_SHORT_TIMEOUT, TPM2_TIMEOUT_D)
+
+#define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
+#define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
+#define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
+#define	TPM_INT_STATUS(l)		(0x0010 | ((l) << 12))
+#define	TPM_INTF_CAPS(l)		(0x0014 | ((l) << 12))
+#define	TPM_STS(l)			(0x0018 | ((l) << 12))
+#define	TPM_STS3(l)			(0x001b | ((l) << 12))
+#define	TPM_DATA_FIFO(l)		(0x0024 | ((l) << 12))
+#define	TPM_INTF_ID(l)			(0x0030 | ((l) << 12))
+
+#define	TPM_DID_VID(l)			(0x0F00 | ((l) << 12))
+#define	TPM_RID(l)			(0x0F04 | ((l) << 12))
+
+#define LPC_CNTRL_OFFSET		0x84
+#define LPC_CLKRUN_EN			(1 << 2)
+#define INTEL_LEGACY_BLK_BASE_ADDR	0xFED08000
+#define ILB_REMAP_SIZE			0x100
+
+/* TPM HW Interface and Capabilities */
+#define TPM_TIS_INTF_ACTIVE	0x00
+#define TPM_CRB_INTF_ACTIVE	0x01
+
+struct tpm_interface_id {
+	union {
+		u32 val;
+		struct {
+			u32 interface_type:4;
+			u32 interface_version:4;
+			u32 cap_locality:1;
+			u32 reserved1:4;
+			u32 cap_tis:1;
+			u32 cap_crb:1;
+			u32 cap_if_res:2;
+			u32 interface_selector:2;
+			u32 intf_sel_lock:1;
+			u32 reserved2:4;
+			u32 reserved3:8;
+		};
+	};
+} __packed;
+
+#define TPM_TIS_INTF_12		0x00
+#define TPM_TIS_INTF_13		0x02
+#define TPM2_TIS_INTF_13	0x03
+
+struct tpm_intf_capability {
+	union {
+		u32 val;
+		struct {
+			u32 data_avail_int_support:1;
+			u32 sts_valid_int_support:1;
+			u32 locality_change_int_support:1;
+			u32 interrupt_level_high:1;
+			u32 interrupt_level_low:1;
+			u32 interrupt_edge_rising:1;
+			u32 interrupt_edge_falling:1;
+			u32 command_ready_int_support:1;
+			u32 burst_count_static:1;
+			u32 data_transfer_size_support:2;
+			u32 reserved1:17;
+			u32 interface_version:3;
+			u32 reserved2:1;
+		};
+	};
+} __packed;
+
+#endif
-- 
2.43.7


