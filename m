Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4508217D279
	for <lists+linux-efi@lfdr.de>; Sun,  8 Mar 2020 09:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCHIKB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 8 Mar 2020 04:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCHIKA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 8 Mar 2020 04:10:00 -0400
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B1020838;
        Sun,  8 Mar 2020 08:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583654999;
        bh=yzHPt2YhbeU/znqfMo6nGW1vySv6oU4FD8ygWXE8deY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYArbS58VqcVVv0vweSCSAHSCyyus3+fTBs0a14/RirmiH5aFmyJCzXaoweuDgDye
         MdlW6vIMNqELknh9Kmxu90vN0LbW0zHz7spHrKhJKJHkDMxMpLp7jXzIrGtPr/uq9r
         JnpcI3xEgkkNxeSm1SZL3TwIdxqf3ABAHIlB8hVE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nikolai Merinov <n.merinov@inango-systems.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 15/28] x86/boot/compressed/32: Save the output address instead of recalculating it
Date:   Sun,  8 Mar 2020 09:08:46 +0100
Message-Id: <20200308080859.21568-16-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200308080859.21568-1-ardb@kernel.org>
References: <20200308080859.21568-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

In preparation for being able to decompress into a buffer starting at a
different address than startup_32, save the calculated output address
instead of recalculating it later.

We now keep track of three addresses:
	%edx: startup_32 as we were loaded by bootloader
	%ebx: new location of compressed kernel
	%ebp: start of decompression buffer

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200303221205.4048668-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index f250fc49cd61..2a8965aec234 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -75,11 +75,11 @@ SYM_FUNC_START(startup_32)
  */
 	leal	(BP_scratch+4)(%esi), %esp
 	call	1f
-1:	popl	%ebp
-	subl	$1b, %ebp
+1:	popl	%edx
+	subl	$1b, %edx
 
 	/* Load new GDT */
-	leal	gdt(%ebp), %eax
+	leal	gdt(%edx), %eax
 	movl	%eax, 2(%eax)
 	lgdt	(%eax)
 
@@ -92,13 +92,14 @@ SYM_FUNC_START(startup_32)
 	movl	%eax, %ss
 
 /*
- * %ebp contains the address we are loaded at by the boot loader and %ebx
+ * %edx contains the address we are loaded at by the boot loader and %ebx
  * contains the address where we should move the kernel image temporarily
- * for safe in-place decompression.
+ * for safe in-place decompression. %ebp contains the address that the kernel
+ * will be decompressed to.
  */
 
 #ifdef CONFIG_RELOCATABLE
-	movl	%ebp, %ebx
+	movl	%edx, %ebx
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl    %eax, %ebx
@@ -110,10 +111,10 @@ SYM_FUNC_START(startup_32)
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
 
+	movl	%ebx, %ebp	// Save the output address for later
 	/* Target address to relocate to for decompression */
-	movl    BP_init_size(%esi), %eax
-	subl    $_end, %eax
-	addl    %eax, %ebx
+	addl    BP_init_size(%esi), %ebx
+	subl    $_end, %ebx
 
 	/* Set up the stack */
 	leal	boot_stack_end(%ebx), %esp
@@ -127,7 +128,7 @@ SYM_FUNC_START(startup_32)
  * where decompression in place becomes safe.
  */
 	pushl	%esi
-	leal	(_bss-4)(%ebp), %esi
+	leal	(_bss-4)(%edx), %esi
 	leal	(_bss-4)(%ebx), %edi
 	movl	$(_bss - startup_32), %ecx
 	shrl	$2, %ecx
@@ -197,9 +198,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 				/* push arguments for extract_kernel: */
 	pushl	$z_output_len	/* decompressed length, end of relocs */
 
-	leal	_end(%ebx), %eax
-	subl    BP_init_size(%esi), %eax
-	pushl	%eax		/* output address */
+	pushl	%ebp		/* output address */
 
 	pushl	$z_input_len	/* input_len */
 	leal	input_data(%ebx), %eax
-- 
2.17.1

