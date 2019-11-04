Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB575EE35D
	for <lists+linux-efi@lfdr.de>; Mon,  4 Nov 2019 16:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfKDPQc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 Nov 2019 10:16:32 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPQc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 Nov 2019 10:16:32 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FCOqk018209;
        Mon, 4 Nov 2019 15:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=4g6rIyW2HVYzag3aHGnsRCeX4Q0Rd09J0Dv6UEG9yS0=;
 b=V8Fupi4cyW56hfzBq+dFWXkR+05lvuQ6x9/a0+g9I8ubebW3pKJiavAWlsTXq2G/WN6W
 G6zey1A7vmiy9mi5M8t7DkxY5WwtOh8o3aP/6ahza+L6xn3VoYZ2xYeyvvGI1FuyrN4s
 PxQtjeTGkmVIgwgKEq3wauXdPDRKGQI862DU7GUfH+fba6/Owlh9eaGfS86+PeCvepDC
 BzqNHLQUJOYClCOUo4lIeMdL4DXaGKyCORwi3exKcuud5Pe0ju/EJ7nvUNUD7LG7HnPp
 Br8e6igUmYwf16GVU3AQI2N/3J3H1rXTGKIOPO1ytj0iXWFyexP5UQ87uPpvRueY+md1 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w12eqyv4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA4FB3o2136319;
        Mon, 4 Nov 2019 15:14:30 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w1k8uxuu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Nov 2019 15:14:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA4FEPcQ014465;
        Mon, 4 Nov 2019 15:14:26 GMT
Received: from tomti.i.net-space.pl (/10.175.168.29)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Nov 2019 07:14:25 -0800
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Cc:     ard.biesheuvel@linaro.org, boris.ostrovsky@oracle.com,
        bp@alien8.de, corbet@lwn.net, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, eric.snowberg@oracle.com,
        hpa@zytor.com, jgross@suse.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com, rdunlap@infradead.org,
        ross.philipson@oracle.com, tglx@linutronix.de
Subject: [PATCH v5 2/3] x86/boot: Introduce the kernel_info.setup_type_max
Date:   Mon,  4 Nov 2019 16:13:53 +0100
Message-Id: <20191104151354.28145-3-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191104151354.28145-1-daniel.kiper@oracle.com>
References: <20191104151354.28145-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911040151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9431 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911040151
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This field contains maximal allowed type for setup_data.

This patch does not bump setup_header version in arch/x86/boot/header.S
because it will be followed by additional changes coming into the
Linux/x86 boot protocol.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
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
index c60fafda9427..1dad6eee8a5c 100644
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

