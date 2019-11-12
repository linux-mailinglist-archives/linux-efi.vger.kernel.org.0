Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABFF97B6
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2019 18:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLRyV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Nov 2019 12:54:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35230 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfKLRyV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Nov 2019 12:54:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUaMW-0000f1-PT; Tue, 12 Nov 2019 18:53:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C1721C0357;
        Tue, 12 Nov 2019 18:53:56 +0100 (CET)
Date:   Tue, 12 Nov 2019 17:53:56 -0000
From:   "tip-bot2 for Daniel Kiper" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Introduce kernel_info.setup_type_max
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Andy Lutomirski <luto@amacapital.net>,
        ard.biesheuvel@linaro.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        dave.hansen@linux.intel.com, eric.snowberg@oracle.com,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juergen Gross <jgross@suse.com>, kanth.ghatraju@oracle.com,
        linux-doc@vger.kernel.org, "linux-efi" <linux-efi@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rdunlap@infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, xen-devel@lists.xenproject.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191112134640.16035-3-daniel.kiper@oracle.com>
References: <20191112134640.16035-3-daniel.kiper@oracle.com>
MIME-Version: 1.0
Message-ID: <157358123601.29376.5713242923411470070.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     00cd1c154d565c62ad5e065bf3530f68bdf59490
Gitweb:        https://git.kernel.org/tip/00cd1c154d565c62ad5e065bf3530f68bdf59490
Author:        Daniel Kiper <daniel.kiper@oracle.com>
AuthorDate:    Tue, 12 Nov 2019 14:46:39 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Nov 2019 16:16:54 +01:00

x86/boot: Introduce kernel_info.setup_type_max

This field contains maximal allowed type for setup_data.

Do not bump setup_header version in arch/x86/boot/header.S because it
will be followed by additional changes coming into the Linux/x86 boot
protocol.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Ross Philipson <ross.philipson@oracle.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: ard.biesheuvel@linaro.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: dave.hansen@linux.intel.com
Cc: eric.snowberg@oracle.com
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>
Cc: kanth.ghatraju@oracle.com
Cc: linux-doc@vger.kernel.org
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: rdunlap@infradead.org
Cc: ross.philipson@oracle.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191112134640.16035-3-daniel.kiper@oracle.com
---
 Documentation/x86/boot.rst             |  9 ++++++++-
 arch/x86/boot/compressed/kernel_info.S |  5 +++++
 arch/x86/include/uapi/asm/bootparam.h  |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index c60fafd..6cdd767 100644
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
index 8ea6f6e..018dacb 100644
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
index a1ebcd7..dbb4112 100644
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
