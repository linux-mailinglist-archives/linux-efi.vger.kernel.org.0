Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AEB12AD30
	for <lists+linux-efi@lfdr.de>; Thu, 26 Dec 2019 16:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLZPQr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Dec 2019 10:16:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfLZPQq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 26 Dec 2019 10:16:46 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D466A20882;
        Thu, 26 Dec 2019 15:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577373406;
        bh=NGZhSFbOjCSMCE5gB6MC1CF7f/JFdBAw1Ou3iXbWcOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFCxGxVh8J2agBqMCFEIn04cEG16u+BlDRRsV1YH1wY7F37R03M1MBrlOu++e81gK
         INzkhrE8Tsz5D4lxCH7syi+h5J0jQlOEoEus09SoLzzkhEq98n0L5tSU9SwfM/VKaN
         4PdAM9fxKvXmQVai1YDy6mQhgDcFAU3B64mML9Cg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, hdegoede@redhat.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Date:   Thu, 26 Dec 2019 16:14:05 +0100
Message-Id: <20191226151407.29716-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226151407.29716-1-ardb@kernel.org>
References: <20191226151407.29716-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_call() wrapper used to invoke EFI runtime services serves
a number of purposes:
- realign the stack to 16 bytes
- preserve FP register state
- translate from SysV to MS calling convention.

Preserving the FP register state is redundant in most cases, since
efi_call() is almost always used from within the scope of a pair of
kernel_fpu_begin()/_end() calls, with the exception of the early
call to SetVirtualAddressMap() and the SGI UV support code. So let's
add a pair of kernel_fpu_begin()/_end() calls there as well, and
remove the unnecessary code from the assembly implementation of
efi_call(), and only keep the pieces that deal with the stack
alignment and the ABI translation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c      |  4 +++
 arch/x86/platform/efi/efi_stub_64.S | 36 ++------------------
 arch/x86/platform/uv/bios_uv.c      |  7 ++--
 3 files changed, 11 insertions(+), 36 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 03c2ed3c645c..3690df1d31c6 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -84,6 +84,7 @@ pgd_t * __init efi_call_phys_prolog(void)
 
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(&efi_mm);
+		kernel_fpu_begin();
 		return efi_mm.pgd;
 	}
 
@@ -141,6 +142,7 @@ pgd_t * __init efi_call_phys_prolog(void)
 	}
 
 	__flush_tlb_all();
+	kernel_fpu_begin();
 	return save_pgd;
 out:
 	efi_call_phys_epilog(save_pgd);
@@ -158,6 +160,8 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 	p4d_t *p4d;
 	pud_t *pud;
 
+	kernel_fpu_end();
+
 	if (!efi_enabled(EFI_OLD_MEMMAP)) {
 		efi_switch_mm(efi_scratch.prev_mm);
 		return;
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index b1d2313fe3bf..3e44d55ac730 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -8,41 +8,11 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/segment.h>
-#include <asm/msr.h>
-#include <asm/processor-flags.h>
-#include <asm/page_types.h>
-
-#define SAVE_XMM			\
-	mov %rsp, %rax;			\
-	subq $0x70, %rsp;		\
-	and $~0xf, %rsp;		\
-	mov %rax, (%rsp);		\
-	mov %cr0, %rax;			\
-	clts;				\
-	mov %rax, 0x8(%rsp);		\
-	movaps %xmm0, 0x60(%rsp);	\
-	movaps %xmm1, 0x50(%rsp);	\
-	movaps %xmm2, 0x40(%rsp);	\
-	movaps %xmm3, 0x30(%rsp);	\
-	movaps %xmm4, 0x20(%rsp);	\
-	movaps %xmm5, 0x10(%rsp)
-
-#define RESTORE_XMM			\
-	movaps 0x60(%rsp), %xmm0;	\
-	movaps 0x50(%rsp), %xmm1;	\
-	movaps 0x40(%rsp), %xmm2;	\
-	movaps 0x30(%rsp), %xmm3;	\
-	movaps 0x20(%rsp), %xmm4;	\
-	movaps 0x10(%rsp), %xmm5;	\
-	mov 0x8(%rsp), %rsi;		\
-	mov %rsi, %cr0;			\
-	mov (%rsp), %rsp
 
 SYM_FUNC_START(efi_call)
 	pushq %rbp
 	movq %rsp, %rbp
-	SAVE_XMM
+	and $~0xf, %rsp
 	mov 16(%rbp), %rax
 	subq $48, %rsp
 	mov %r9, 32(%rsp)
@@ -51,8 +21,6 @@ SYM_FUNC_START(efi_call)
 	mov %rcx, %r8
 	mov %rsi, %rcx
 	call *%rdi
-	addq $48, %rsp
-	RESTORE_XMM
-	popq %rbp
+	leave
 	ret
 SYM_FUNC_END(efi_call)
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index ece9cb9c1189..5c0e2eb5d87c 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -34,10 +34,13 @@ static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
 	 * callback method, which uses efi_call() directly, with the kernel page tables:
 	 */
-	if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))
+	if (unlikely(efi_enabled(EFI_OLD_MEMMAP))) {
+		kernel_fpu_begin();
 		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
-	else
+		kernel_fpu_end();
+	} else {
 		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
+	}
 
 	return ret;
 }
-- 
2.17.1

