Return-Path: <linux-efi+bounces-3383-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE0A9545F
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 18:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC4B3B5EFF
	for <lists+linux-efi@lfdr.de>; Mon, 21 Apr 2025 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8B61E9B3C;
	Mon, 21 Apr 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qayfxwok"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9E1E5B90;
	Mon, 21 Apr 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253333; cv=none; b=NfOx5f2x3QukK+ztdllZVI3SQiOSAUZNJDNFofkie7hRJKLgi2eZOG8uuhih56e1tic7jS0SiX9c0hYxnUltPg2lzHFNhEulhSvN1ImIQtDqeG1ii9RHSBBmyDP723dv34HqY4GgHNWNoOOfiKVdMdRZ9NTPp8WNKR/85DspBI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253333; c=relaxed/simple;
	bh=MIhP7YS0snejMRpc3S3xVp9GKIHL3UQ1kQBp3aWJWVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNqkrxJvOSyfMI7A/mKHxetgQfKvr3+6mWbyAnsPyOrAFUxgmtN65o1WO/Jzi0yzWTy0ODwW5wBAVFaZ1h00PqRdvxOOx6bdyAWXfelGUjHZG2R1XIdGSJBTZrQWtN6EUlIb5G/wXqHvUZY1nZgiKPqXjQNrwB5PlJqpfNnUBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qayfxwok; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LCAnLD010783;
	Mon, 21 Apr 2025 16:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=8RzvD
	9yt1H96MQwyUq/armOs73ZqRgyKFJ7loqXAKPY=; b=QayfxwokTWuBPqJiatFB+
	kGLfJSqXj0/NVtEBB14zYo/3v+Mx2bIRdcb9QRBPneJT76Ek0Du0BGMSsru3wpBG
	Ykzmqoo99ZWcGx1f0hMHivJO0Ug5/r4aZumYsg1dtV4gul9VKlJDL7Jjal6ODMbb
	8P13YgscnZcIOwijtdx5aKBOiYKAZ8jhDH6Q0P7bXSXlE+7HsPNMo2Cy+4Ty6Tuw
	FyPXb5ER8E3eavVMGYtiAQKpIgToN+d1wbjf2IJChTHPbcwnbKSIRfNRW+v92PH/
	gOA0d2bDtOU5pw3/rzcqxGAkT6mT7f/vNCX3GmQJIjBvuq1oHd6iyL+i9TMh+TWK
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46428c2ukv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 16:35:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53LEnJPA033431;
	Mon, 21 Apr 2025 16:35:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642987xaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:35:01 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53LGZ062011915;
	Mon, 21 Apr 2025 16:35:00 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642987x74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 21 Apr 2025 16:35:00 +0000
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
Subject: [PATCH v14 08/19] x86/boot: Place TXT MLE header in the kernel_info section
Date: Mon, 21 Apr 2025 09:27:01 -0700
Message-Id: <20250421162712.77452-9-ross.philipson@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504210129
X-Proofpoint-ORIG-GUID: Tu-Wa-65WrXND8HKK96sv0XQUSFv2tso
X-Proofpoint-GUID: Tu-Wa-65WrXND8HKK96sv0XQUSFv2tso

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
index f818ee8fba38..2765b1786368 100644
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
index 3b2bc61c9408..eae9745f5a0b 100644
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


