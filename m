Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA0E3154
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2019 13:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJXLt0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 24 Oct 2019 07:49:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfJXLt0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 24 Oct 2019 07:49:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OBdxUn027790;
        Thu, 24 Oct 2019 11:48:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=z13BAF6ghH9YJkJPP/cOfQet3c3eWcpMKhNqVJkkLRM=;
 b=bWrkHXfqnm9iQapN5MJCYi1RPzf0CfNulUZ4eLSmNGn83Pg/jE/OBDfrGJWsbm0hvQfi
 qj9hwLqAKRC/OlqQ8JffjEb5wsFJF41FWAjXSwr29vDXHJ2fUIITjsjHOfCzNqnUFBGY
 EShZtABmBBD0CyQtpyXpOUFQHzNJLQhXXFFqwzYMjUM0UzMkcy4fbccV2+mGsN2DFFBm
 DVXnJUPgN+MQglCoq9T3j+lKkXqOtuiIfE/i9gBKrfoFX2vSxNzp6ctnS3gSB8cgrZSW
 8U6m8nMA6o9Bn8Lm6LjD71b+43h6k7k4vB/xq5UDMgv5Skn08Rq+UmvWNjgnP2A4L33o Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vqteq323h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 11:48:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OBdDSh050160;
        Thu, 24 Oct 2019 11:48:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vtjkjcsf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 11:48:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9OBmjeO010783;
        Thu, 24 Oct 2019 11:48:46 GMT
Received: from tomti.i.net-space.pl (/10.175.165.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 04:48:45 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v4 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Date:   Thu, 24 Oct 2019 13:48:13 +0200
Message-Id: <20191024114814.6488-3-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191024114814.6488-1-daniel.kiper@oracle.com>
References: <20191024114814.6488-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240116
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This field contains maximal allowed type for setup_data.

Now bump the setup_header version in arch/x86/boot/header.S.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 Documentation/x86/boot.rst             | 9 ++++++++-
 arch/x86/boot/compressed/kernel_info.S | 5 +++++
 arch/x86/boot/header.S                 | 2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 3 +++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index c60fafda9427..8e523c23ede3 100644
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

