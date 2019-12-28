Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012FB12BDE5
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL1PVy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 10:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfL1PVy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 28 Dec 2019 10:21:54 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E102168B;
        Sat, 28 Dec 2019 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577546513;
        bh=sSreNz0BgNWPgPqS+PVI2d0B5MA9+WUjYp7smqMpL3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsGK7PlOBVt8siAeolq/fxTjPYALc7HOeXJjD6oQg5/mp/22efX5sj3lEVkCpYg0v
         QFuSSXpvkmAtnYQBok09XADwoUdA+1tq0WtTMtiGhOJr1NTpRCfKDeaRjN0Tgd6RJm
         SMFMhZDyu4H08WwOxjjRom0YibeijNAi6zMOkbmE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/7] efi/libstub: fix boot argument handling in mixed mode entry code
Date:   Sat, 28 Dec 2019 16:21:03 +0100
Message-Id: <20191228152109.6301-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228152109.6301-1-ardb@kernel.org>
References: <20191228152109.6301-1-ardb@kernel.org>
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
2.17.1

