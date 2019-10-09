Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53ACBD0D33
	for <lists+linux-efi@lfdr.de>; Wed,  9 Oct 2019 12:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfJIKzJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 9 Oct 2019 06:55:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49854 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfJIKzJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 9 Oct 2019 06:55:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99AnjSO040844;
        Wed, 9 Oct 2019 10:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=D1DI7s8LFQ5/QtMZA4sUUJEJOvqF3NRZbFcaYtB93A0=;
 b=fA8MVhIcTxHSUNaf18CxFk+ddGB/CrPPI8kjZjxTa/QYiZXAb1Ct3G+ctvV0FvIBmYol
 RHiqFAYimxe9YvNkmCpA7ZeEUNh78cV3Hh3jxh8zWpUJUtpWhxauzLnULS909JZTW2TS
 C7VAlmt3nE86jazen8bPdg3YNKiE5/cVPVYeoE9Isba0fNE9bkcVsQ3ZP3/H1Wwwhrfd
 5t+l9Xldgcs2NXnAa23xbSqOmc3O8h8aQU94Ia7jsJm7UTqpJYxb5fFJNtcai2OOZWw/
 L4Ivw7w2u273SMDa0JO8UJLkzgC/bsf+KCMkY+Y+MVsK18r5qZXK0kHoM1/1vwS/O/52 NQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vek4qka7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 10:54:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99AmsxB119322;
        Wed, 9 Oct 2019 10:54:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2vh8k0hgam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 10:54:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x99AsOhm031195;
        Wed, 9 Oct 2019 10:54:25 GMT
Received: from tomti.i.net-space.pl (/10.175.167.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 03:54:24 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, konrad.wilk@oracle.com,
        mingo@redhat.com, ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v3 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Date:   Wed,  9 Oct 2019 12:53:57 +0200
Message-Id: <20191009105358.32256-3-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191009105358.32256-1-daniel.kiper@oracle.com>
References: <20191009105358.32256-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090101
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This field contains maximal allowed type for setup_data.

Now bump the setup_header version in arch/x86/boot/header.S.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
---
 Documentation/x86/boot.rst             | 9 ++++++++-
 arch/x86/boot/compressed/kernel_info.S | 5 +++++
 arch/x86/boot/header.S                 | 2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 3 +++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index d5323a39f5e3..4c536bc8816d 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -73,7 +73,7 @@ Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c188
 		(x86/boot: Add ACPI RSDP address to setup_header)
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
-Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
+Protocol 2.15:	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
 =============	============================================================
 
 .. note::
@@ -976,6 +976,13 @@ Offset/size:	0x0008/4
   This field contains the size of the kernel_info including kernel_info.header
   and kernel_info.kernel_info_var_len_data.
 
+============	==============
+Field name:	setup_type_max
+Offset/size:	0x0008/4
+============	==============
+
+  This field contains maximal allowed type for setup_data and setup_indirect structs.
+
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index 8ea6f6e3feef..f818ee8fba38 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <asm/bootparam.h>
+
 	.section ".rodata.kernel_info", "a"
 
 	.global kernel_info
@@ -12,6 +14,9 @@ kernel_info:
 	/* Size total. */
 	.long	kernel_info_end - kernel_info
 
+	/* Maximal allowed type for setup_data and setup_indirect structs. */
+	.long	SETUP_TYPE_MAX
+
 kernel_info_var_len_data:
 	/* Empty for time being... */
 kernel_info_end:
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 22dcecaaa898..97d9b6d6c1af 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020d		# header version number (>= 0x0105)
+		.word	0x020f		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index a1ebcd7a991c..dbb41128e5a0 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -11,6 +11,9 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 
+/* max(SETUP_*) */
+#define SETUP_TYPE_MAX			SETUP_JAILHOUSE
+
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
 #define RAMDISK_PROMPT_FLAG		0x8000
-- 
2.11.0

