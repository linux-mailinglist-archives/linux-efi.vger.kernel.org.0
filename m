Return-Path: <linux-efi+bounces-5866-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C6CC0431
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 00:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D45F305959B
	for <lists+linux-efi@lfdr.de>; Mon, 15 Dec 2025 23:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5F335098;
	Mon, 15 Dec 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fkyiA5SZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38334335074;
	Mon, 15 Dec 2025 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765842131; cv=none; b=L8bFjTD9QdFCdr2B/8koK4dWPEMtv2CIwv28ImfWkUwBUYO3lxrxCz8s7+AqoX2JVmMnfiKb6gbbBRlHcyn1GLty3KHkDYpbLP0WAiYsDL8Sey2bgY9I38d95vO+1Nq8V+/kXbrZ73J9yn3Q3+m54FmCzisjbmuof94eC1p9jCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765842131; c=relaxed/simple;
	bh=ijx0D2nIjRCSDhpCgVCY+zAcrDZEMH5L7845oBdl8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgznyGWc9TgtRH8ORYhITZAUW2u9P69jdIjo3v1aHGMZ1szJz0P/8U6bhDML47awTsiB/b1LzloREAJ5SOvNu7fTa9fRGLaH4+MA2zNudSaFuOHfkfi0ZlIekUxSOytddWZdOUdXieuy4ZG76EaM7h8Pl50Z5t0bNVagqN/uulY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fkyiA5SZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFJC4pp2829840;
	Mon, 15 Dec 2025 23:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Th/Hp
	8MUxlbmkIZvEw/Cp6iVmBm7q1kHQzNxvbSuvVw=; b=fkyiA5SZMBLWNxDY4ZDia
	7szZjYBgWMEMYO8UBcQD9/lZ3dEkTKoZCaqnOMX70NN3OtQ8+fEJAua7YgYB+zH4
	lIS8SIFwOKQEVdKfUQwFDCWaLhZGJs5TX/roxCw11NasDEixCep1CJhUS82jLZcF
	rlerZRS6Pw6j055nt5lJfLF1TsLsZu3ZJoUxFQ5RRTfWzaHn3DnfvUqur2mdy92C
	DksRotLl8wXq0QuSx9L39LRFtuDO43fHo1Gyjnm2UouKfiv9yJL3o3jHlggGmF+b
	NBEPWx/Vq+kaUnYJygib2A8h7HSL0MBJL4yGMjetUuBR865zA/GI3WvIVd1oQoFm
	g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xx2b138-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 23:41:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BFM8q1V025860;
	Mon, 15 Dec 2025 23:41:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tqmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:17 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BFNfGCS036248;
	Mon, 15 Dec 2025 23:41:16 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk9tqkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 15 Dec 2025 23:41:16 +0000
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
Subject: [PATCH v15 21/28] x86/boot: Place TXT MLE header in the kernel_info section
Date: Mon, 15 Dec 2025 15:33:09 -0800
Message-ID: <20251215233316.1076248-22-ross.philipson@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=B8W0EetM c=1 sm=1 tr=0 ts=69409c9e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=uiFmQ-llDw8WHDt2iqYA:9
X-Proofpoint-ORIG-GUID: 6HZUW2iCv5aWgqghQl9TBTr2RGGrei7n
X-Proofpoint-GUID: 6HZUW2iCv5aWgqghQl9TBTr2RGGrei7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDIwNCBTYWx0ZWRfXzG/ZQNI2hxc3
 YC7Xp2ZccH1SS3Ncd4sVwhmlXhg6jCzkKscr56WPm2XRLVbJAhVQx9LaLANgjVwgiTPN8fSAk14
 We2ftTkq6bFjHc1pLd02a6JljJlE+s7N2dPZp+gua4mdiVKHt7pRoNuwlgHwKPOluOfvJDwPdhX
 pBkEvm1dLMs/qTetxVdgpfLcu5QzH+Ai0bVQNaIafym7cOSurQ/pksRguNTM4afKtGeK+2Gf4qG
 hW0mVE9DXh3DnXGXzDRYXUMVYI3nKia6b9HeyjyXbiQJhIieJfhOoIeBi5U/W53WpencdbMW1QQ
 bnmxjaVMOZ3g36aJZbGDThW8eCR6/ef4HqeeGeIdOafDgYgafbL6KAUgRAxiFxRle4f+sGGx26C
 jKI80p4padaY633CF+nNvPUXq56XNg==

The Measured Launch Environment (MLE) header must be locatable by the
boot loader and Intel TXT must be setup to do a launch with this header's
location. While the offset to the kernel_info structure does not need
to be at a fixed offset, the offsets in the header must be relative
offsets from the start of the setup kernel. Note that from the viewpoint
of the prelaunch phase and TXT, the setup kernel image as loaded into
memory is the MLE image.

The changes to the linker file achieve this by making available the
offset values which are updated in the MLE header structure. The following
are the needed offsets from the beginning of the setup kernel image:

- kernel_info_offset: Offset of the main kernel_info structure.
- mle_header_offset: Offset of the MLE header structure.
- sl_stub_entry_offset: Offset of the Secure Launch initial entry point.
- _edata_offset: Offset of the _edata label used as the end of the MLE image.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/kernel_info.S | 50 +++++++++++++++++++++++---
 arch/x86/boot/compressed/vmlinux.lds.S |  7 ++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8fba38..e3c9816eacbf 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * The kernel_info structure is not placed at a fixed offset in the
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
+	.long	0x9082ac5a			/* UUID0 */
+	.long	0x74a7476f			/* UUID1 */
+	.long	0xa2555c0f			/* UUID2 */
+	.long	0x42b651cb			/* UUID3 */
+	.long	0x00000034			/* MLE header size */
+	.long	0x00020002			/* MLE version 2.2 */
+	.long	roffset(sl_stub_entry_offset)	/* Linear entry point of MLE (virt. address) */
+	.long	0x00000000			/* First valid page of MLE */
+	.long	0x00000000			/* Offset within binary of first byte of MLE */
+	.long	roffset(_edata_offset)		/* Offset within binary of last byte + 1 of MLE */
+	.long	0x00000227			/* Bit vector of MLE-supported capabilities */
+	.long	0x00000000			/* Starting linear address of command line (unused) */
+	.long	0x00000000			/* Ending linear address of command line (unused) */
+SYM_DATA_END(mle_header)
+#endif
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 587ce3e7c504..d061ae6046b2 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -126,3 +126,10 @@ SECTIONS
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
2.43.7


