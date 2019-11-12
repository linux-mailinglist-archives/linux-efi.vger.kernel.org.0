Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C86BF9103
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 14:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKLNtx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 08:49:53 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLNtx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 08:49:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACDijKZ003005;
        Tue, 12 Nov 2019 13:47:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=LT6waPksh3tQZejaHtyZ9Sh8F/B1DIxRO+lN0Qg60bg=;
 b=U5CzJhNVxkjDDk9XrS5UmuNa4gBV/IaOFQeS7P0NHzHW85s4/fMLzs0wkWpEGddcfyPs
 5JoicCFPyXqY6BK9NtAWBij+8+S6YE4Q3RV+0m5DDitcecn/STp9DUqW/n2pYTUufCpE
 jtONmyD65oRI4AX8Thetzfi3wVN4OO0nL0e0Ig9bIDSWpQjV5fAsy2irYLqM9LyfHJRe
 0xjk0DIWq/VcH0O/PpywLsRpFPTLSm7CLeveu3CvD0CKxEKx+RVUtorw8dqC75QRBPcA
 7QoJK7c0HG8b4ARjv9yHYTWGnIwQDZz4aHCC4q59Ppmnpgs5AYu6ibgaQPmHTPoVfOWA QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2w5mvtmvde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 13:47:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACDiCDQ124182;
        Tue, 12 Nov 2019 13:47:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2w7j00uar4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 13:47:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xACDl5n5020432;
        Tue, 12 Nov 2019 13:47:05 GMT
Received: from tomti.i.net-space.pl (/10.175.202.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 05:47:04 -0800
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v6 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Date:   Tue, 12 Nov 2019 14:46:39 +0100
Message-Id: <20191112134640.16035-3-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191112134640.16035-1-daniel.kiper@oracle.com>
References: <20191112134640.16035-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9438 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120124
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This field contains maximal allowed type for setup_data.

Do not bump setup_header version in arch/x86/boot/header.S because it
will be followed by additional changes coming into the Linux/x86 boot
protocol.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
v6 - suggestions/fixes:
   - fix setup_type_max offset in Documentation/x86/boot.rst
     (suggested by Borislav Petkov),
   - drop "This patch" from the commit message
     (suggested by Borislav Petkov).

v5 - suggestions/fixes:
   - move incorrect references to the setup_indirect to the
     patch introducing it,
   - do not bump setup_header version in arch/x86/boot/header.S
     (suggested by H. Peter Anvin).
---
 Documentation/x86/boot.rst             | 9 ++++++++-
 arch/x86/boot/compressed/kernel_info.S | 5 +++++
 arch/x86/include/uapi/asm/bootparam.h  | 3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index c60fafda9427..6cdd767c3835 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -73,7 +73,7 @@ Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c188
 		(x86/boot: Add ACPI RSDP address to setup_header)
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
-Protocol 2.15:	(Kernel 5.5) Added the kernel_info.
+Protocol 2.15:	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
 =============	============================================================
 
 .. note::
@@ -981,6 +981,13 @@ Offset/size:	0x0008/4
   This field contains the size of the kernel_info including kernel_info.header
   and kernel_info.kernel_info_var_len_data.
 
+============	==============
+Field name:	setup_type_max
+Offset/size:	0x000c/4
+============	==============
+
+  This field contains maximal allowed type for setup_data.
+
 
 The Image Checksum
 ==================
diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index 8ea6f6e3feef..018dacbd753e 100644
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
 
+	/* Maximal allowed type for setup_data. */
+	.long	SETUP_TYPE_MAX
+
 kernel_info_var_len_data:
 	/* Empty for time being... */
 kernel_info_end:
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

