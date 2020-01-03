Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0578E12F795
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgACLkT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbgACLkS (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:18 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 633D62465E;
        Fri,  3 Jan 2020 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051618;
        bh=lYiVIzYYUZSJJVP1dDUsssZd9JwW2wL+S4neiF08D4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzOqUpLISL+XFDefToBmPL8bBVAVoZJTIfD7zJtAUbYGqkfdTbM8XwujA8wML67Ff
         yCpZotSoMeAorVlCZ5k3N1UclpLO5Hn9vhvAugn4373FVvJ+cZ8G9A4fMpZN6c+Ts4
         0yWIZLI2c5UKEYpD/7ymZ00F6Itd+DTlhAhZkwuc=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 01/20] efi/libstub: fix boot argument handling in mixed mode entry code
Date:   Fri,  3 Jan 2020 12:39:34 +0100
Message-Id: <20200103113953.9571-2-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
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

