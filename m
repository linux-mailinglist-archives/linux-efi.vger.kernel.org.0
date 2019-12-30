Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B212D31D
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfL3SJY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfL3SJX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:23 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A9A2077B;
        Mon, 30 Dec 2019 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729363;
        bh=lYiVIzYYUZSJJVP1dDUsssZd9JwW2wL+S4neiF08D4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sfzjqbjbMSyD3i70NjaNkS1r7TQgOdlHke9yRODa3hQvuTzoJRePblYDbuiy4yqSE
         Y5pbahJDi4i58W0mc6v8OUtdf+n57uqjnu6ZK7SIviWZB+GPA8Cvc7hUXTKyXpYba8
         d2TWh7I3vJH/i+Mf7uO+oqTuzOnZ/jGe1GYCDtkA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 01/14] efi/libstub: fix boot argument handling in mixed mode entry code
Date:   Mon, 30 Dec 2019 19:08:21 +0100
Message-Id: <20191230180834.75601-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230180834.75601-1-ardb@kernel.org>
References: <20191230180834.75601-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The mixed mode refactor actually broke mixed mode by failing to
pass the bootparam structure to startup_32(). This went unnoticed
because it apparently has a high tolerance for being passed random
junk, and still boots fine in some cases. So let's fix this by
populating %esi as required when entering via efi32_stub_entry,
and while at it, preserve the arguments themselves instead of their
address in memory (via the stack pointer) since that memory could
be clobbered before we get to it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index a6f3ee9ca61d..44a6bb6964b5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -208,13 +208,12 @@ SYM_FUNC_START(startup_32)
 	pushl	$__KERNEL_CS
 	leal	startup_64(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
-	movl	efi32_boot_args(%ebp), %ebx
-	cmp	$0, %ebx
+	movl	efi32_boot_args(%ebp), %edi
+	cmp	$0, %edi
 	jz	1f
 	leal	handover_entry(%ebp), %eax
-	movl	0(%ebx), %edi
-	movl	4(%ebx), %esi
-	movl	8(%ebx), %edx
+	movl	%esi, %edx
+	movl	efi32_boot_args+4(%ebp), %esi
 	movl	$0x0, %ecx
 1:
 #endif
@@ -232,12 +231,16 @@ SYM_FUNC_END(startup_32)
 	.org 0x190
 SYM_FUNC_START(efi32_stub_entry)
 	add	$0x4, %esp		/* Discard return address */
+	popl	%ecx
+	popl	%edx
+	popl	%esi
 
 	call	1f
 1:	pop	%ebp
 	subl	$1b, %ebp
 
-	movl	%esp, efi32_boot_args(%ebp)
+	movl	%ecx, efi32_boot_args(%ebp)
+	movl	%edx, efi32_boot_args+4(%ebp)
 	sgdtl	efi32_boot_gdt(%ebp)
 
 	/* Disable paging */
@@ -628,7 +631,7 @@ SYM_DATA_START_LOCAL(gdt)
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_MIXED
-SYM_DATA_LOCAL(efi32_boot_args, .long 0)
+SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0)
 #endif
 
 /*
-- 
2.20.1

