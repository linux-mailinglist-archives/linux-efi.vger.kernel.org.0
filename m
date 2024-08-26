Return-Path: <linux-efi+bounces-1590-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E74D95FD09
	for <lists+linux-efi@lfdr.de>; Tue, 27 Aug 2024 00:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25291C20FE0
	for <lists+linux-efi@lfdr.de>; Mon, 26 Aug 2024 22:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB419EEA4;
	Mon, 26 Aug 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U+gfO979"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EC19DF68;
	Mon, 26 Aug 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724712164; cv=none; b=RUK4vM3rLXrJtK2TUezrnGII9JZFDZUZ2m4FoBOSp+xvs+/6Zd1qeYqKqA6SuouOhoSUuL9F343IFHMUs3ep0yNevhRJXJfzDKwuosFfkvanoAyW6bewwR/lSdHxxX9Aojtgu+7gxXaKpY8+rGcGEuxPjPSiVu7n4ZHMZI9uBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724712164; c=relaxed/simple;
	bh=IX41m2RyjzeLHtFK0M13DVWuqzLHt8d0karynGE97vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bakh4eul5xxss9nXat8iS17sV7iWOLW4nD/rEMTcrASSjd7zhFzRQN3ze9nWEtp2t4wBZhd6Y92jbsM1PQDJDp2LVnIhqiTqo0oECm/IVkWRrtxRhpmATl6FPkBYxSG/6C950RCR0xJZEx8hD0ZKduYakQzhGDVxhSCJVACom+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U+gfO979; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QKtTWW020332;
	Mon, 26 Aug 2024 22:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=A
	iYppGeaEZDNGbGOr9HR2+PTJeFPN2F9YYIaCA7+Zmg=; b=U+gfO979jrYJCTffZ
	trOLvSQlcV1FsdKSMYFBcd5bbLqnEEnrvRxD+TXJJz05rCORyrAo8uf9JgPi3S/a
	3k4FNO5bmaUB5VSJxqT1IVtzgfGGqje3ftandV99Oq/MgKugeKQjTUjHWSlG6yVf
	tWtJ9BJit6rR3DlNArXPIK7thEFeEs6J2AZAW2tSSKmwQDiraD7HJK2PjutO/vKh
	XnPncN4siYgPX2TAag4AZ19KwHOdm1YSjeTwOQ0sgSIY8xev4QQB6papSA4QR05q
	iyBlu9CNzhPsLyt4xYq8c5KlAgnzephYkoe06jVMAaJEADuvXG6e9bv1/RdIhmkg
	uqNMg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177hwm9en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 22:42:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QLESu7020318;
	Mon, 26 Aug 2024 22:42:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8kw9r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:42:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QMgAbw012802;
	Mon, 26 Aug 2024 22:42:10 GMT
Received: from localhost.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8kw9qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 22:42:10 +0000
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
Subject: [PATCH v10 08/20] x86/boot: Place TXT MLE header in the kernel_info section
Date: Mon, 26 Aug 2024 15:38:23 -0700
Message-Id: <20240826223835.3928819-9-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408260174
X-Proofpoint-GUID: 9VWveQvujOAy5yzMbfvIdbeqEWrlrR6i
X-Proofpoint-ORIG-GUID: 9VWveQvujOAy5yzMbfvIdbeqEWrlrR6i

The MLE (measured launch environment) header must be locatable by the
boot loader and TXT must be setup to do a launch with this header's
location. While the offset to the kernel_info structure does not need
to be at a fixed offset, the offsets in the header must be relative
offsets from the start of the setup kernel. The support in the linker
file achieves this.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/kernel_info.S | 50 +++++++++++++++++++++++---
 arch/x86/boot/compressed/vmlinux.lds.S |  7 ++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8fba38..a0604a0d1756 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * The kernel_info structure is not placed at a fixed offest in the
+ * kernel image. So this macro and the support in the linker file
+ * allow the relative offsets for the MLE header within the kernel
+ * image to be configured at build time.
+ */
+#define roffset(X) ((X) - kernel_info)
 
-	.global kernel_info
+	.section ".rodata.kernel_info", "a"
 
-kernel_info:
+	.balign	16
+SYM_DATA_START(kernel_info)
 	/* Header, Linux top (structure). */
 	.ascii	"LToP"
 	/* Size. */
@@ -17,6 +25,40 @@ kernel_info:
 	/* Maximal allowed type for setup_data and setup_indirect structs. */
 	.long	SETUP_TYPE_MAX
 
+	/* Offset to the MLE header structure */
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	.long	roffset(mle_header_offset)
+#else
+	.long	0
+#endif
+
 kernel_info_var_len_data:
 	/* Empty for time being... */
-kernel_info_end:
+SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
+
+#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
+	/*
+	 * The MLE Header per the TXT Specification, section 2.1
+	 * MLE capabilities, see table 4. Capabilities set:
+	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
+	 * bit 1: Support for RLP wakeup using MONITOR address
+	 * bit 2: The ECX register will contain the pointer to the MLE page table
+	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
+	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
+	 */
+SYM_DATA_START(mle_header)
+	.long	0x9082ac5a  /* UUID0 */
+	.long	0x74a7476f  /* UUID1 */
+	.long	0xa2555c0f  /* UUID2 */
+	.long	0x42b651cb  /* UUID3 */
+	.long	0x00000034  /* MLE header size */
+	.long	0x00020002  /* MLE version 2.2 */
+	.long	roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
+	.long	0x00000000  /* First valid page of MLE */
+	.long	0x00000000  /* Offset within binary of first byte of MLE */
+	.long	roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
+	.long	0x00000227  /* Bit vector of MLE-supported capabilities */
+	.long	0x00000000  /* Starting linear address of command line (unused) */
+	.long	0x00000000  /* Ending linear address of command line (unused) */
+SYM_DATA_END(mle_header)
+#endif
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 083ec6d7722a..f82184801462 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -118,3 +118,10 @@ SECTIONS
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
+
+#ifdef CONFIG_SECURE_LAUNCH
+PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
+PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
+PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
+PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));
+#endif
-- 
2.39.3


