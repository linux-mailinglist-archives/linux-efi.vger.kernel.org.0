Return-Path: <linux-efi+bounces-533-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C568555D3
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C181F22906
	for <lists+linux-efi@lfdr.de>; Wed, 14 Feb 2024 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F61419B3;
	Wed, 14 Feb 2024 22:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L//qTtw+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6778A18639;
	Wed, 14 Feb 2024 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949931; cv=none; b=OcLZe5dArhNRYdwQ1GZpSgDQZWUngqi1AAkR4ZwXfNHLKSEZF6xI1mUa8rO7s8sa16fJ7rfsHwQS+wwj8Lfz75k+r7pgtmmfFCAMT1CGWOHWB9FaSV/qrJbUQY9zRQ/a1FXAaQBVkv4V67hntiaHz5Ovq6AFzh7iflswmfnjn2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949931; c=relaxed/simple;
	bh=Dv0jYuhg9P0m8GJhffOkLirHUVpBtBN04pgcBG6/UBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRe03hqVMkpkGN+CuK7YkxO/k44iio4lHTGn01H6N3oDFHy6c78j7qiE7EhF/xSKQewl4jpoSKJEs6TyB0bYeHmJphOeqH/FJTFB/hdhiUTpRKDJwJeyDgI5ELpIMK+l7K9CSVHchZoi/8Byz0n0/SYmiMJC8cjrWNZJrd3tRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L//qTtw+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELiaE2012588;
	Wed, 14 Feb 2024 22:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=Bnh/jsO288oZNYgrOSrsCN18bQgzJILZGG0JJNquEks=;
 b=L//qTtw+p7TpdiwES4aDtFkgu/obSKjZYp5OH1d7TKrDAvC6hc/M7qditigk2HltEOTW
 eyi8ty1s8sv4DaMqaO7fpFx1J7ux7ChxnDCQFNR5aD5NPqmpVy+CDCvAjmeaW4KCEkIA
 B+PvDcuz5h/z7c6YuR5k35VmPJKx16cObZi+SKoubxU6hMwPcMD3Tq/rDpVDGng4OVBL
 xUPfuJQ5QNemnYdejTJ+Syc3hU7Ag47Qa0fz1ZH6XophdLut8mKScdkyhfLwUrsk6oHD
 L+R6EjPYuW11g2GXncWNx2WBJ8+zPKrxvP6nY+qvUk4SvvPVLink4MM0ZVepA2Tir8l4 jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6rprf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELidTS000883;
	Wed, 14 Feb 2024 22:31:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n74v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTUu004281;
	Wed, 14 Feb 2024 22:31:30 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:30 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 01/15] x86/boot: Place kernel_info at a fixed offset
Date: Wed, 14 Feb 2024 14:18:33 -0800
Message-Id: <20240214221847.2066632-2-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-ORIG-GUID: vMwdpJ-e_RRLJTxEGqdSsP02NkR4zB2D
X-Proofpoint-GUID: vMwdpJ-e_RRLJTxEGqdSsP02NkR4zB2D

From: Arvind Sankar <nivedita@alum.mit.edu>

There are use cases for storing the offset of a symbol in kernel_info.
For example, the trenchboot series [0] needs to store the offset of the
Measured Launch Environment header in kernel_info.

Since commit (note: commit ID from tip/master)

commit 527afc212231 ("x86/boot: Check that there are no run-time relocations")

run-time relocations are not allowed in the compressed kernel, so simply
using the symbol in kernel_info, as

	.long	symbol

will cause a linker error because this is not position-independent.

With kernel_info being a separate object file and in a different section
from startup_32, there is no way to calculate the offset of a symbol
from the start of the image in a position-independent way.

To enable such use cases, put kernel_info into its own section which is
placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
script. This will allow calculating the symbol offset in a
position-independent way, by adding the offset from the start of
kernel_info to KERNEL_INFO_OFFSET.

Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
instead of bare labels. This stores the size of the kernel_info
structure in the ELF symbol table.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Ross Philipson <ross.philipson@oracle.com>
Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
 arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
 3 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.h

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8fba38..c18f07181dd5 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
+#include "kernel_info.h"
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * If a field needs to hold the offset of a symbol from the start
+ * of the image, use the macro below, eg
+ *	.long	rva(symbol)
+ * This will avoid creating run-time relocations, which are not
+ * allowed in the compressed kernel.
+ */
+
+#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
 
-	.global kernel_info
+	.section ".rodata.kernel_info", "a"
 
-kernel_info:
+	.balign	16
+SYM_DATA_START(kernel_info)
 	/* Header, Linux top (structure). */
 	.ascii	"LToP"
 	/* Size. */
@@ -19,4 +30,4 @@ kernel_info:
 
 kernel_info_var_len_data:
 	/* Empty for time being... */
-kernel_info_end:
+SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
new file mode 100644
index 000000000000..c127f84aec63
--- /dev/null
+++ b/arch/x86/boot/compressed/kernel_info.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
+#define BOOT_COMPRESSED_KERNEL_INFO_H
+
+#ifdef CONFIG_X86_64
+#define KERNEL_INFO_OFFSET 0x500
+#else /* 32-bit */
+#define KERNEL_INFO_OFFSET 0x100
+#endif
+
+#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 083ec6d7722a..718c52f3f1e6 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #include <asm/cache.h>
 #include <asm/page_types.h>
+#include "kernel_info.h"
 
 #ifdef CONFIG_X86_64
 OUTPUT_ARCH(i386:x86-64)
@@ -27,6 +28,11 @@ SECTIONS
 		HEAD_TEXT
 		_ehead = . ;
 	}
+	.rodata.kernel_info KERNEL_INFO_OFFSET : {
+		*(.rodata.kernel_info)
+	}
+	ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
+
 	.rodata..compressed : {
 		*(.rodata..compressed)
 	}
-- 
2.39.3


