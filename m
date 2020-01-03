Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0319412F776
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgACLkh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgACLkg (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:36 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7D724655;
        Fri,  3 Jan 2020 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051634;
        bh=ZGdQNY/m9AfSk+pXTJniPsz4ZCTpoChydYzo6TM28KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqXIcsleGh1sbnbDc6Z4fIuKO8/sF2C2TAlz4pOeLhhAx7xe0YnY/z4OYY0RSPgKR
         o9HpyPnt4tnC97qyji0nd35rpGxKuN9IMEAb4I8pgVcfc6Nh1LC3MJA2v+AEB0AOJk
         DfY/pzxthR/v3enCi56nZsPuT2IaV1YCUTjrkGak=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 09/20] efi/x86: simplify 64-bit EFI firmware call wrapper
Date:   Fri,  3 Jan 2020 12:39:42 +0100
Message-Id: <20200103113953.9571-10-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efi_call() wrapper used to invoke EFI runtime services serves
a number of purposes:
- realign the stack to 16 bytes
- preserve FP and CR0 register state
- translate from SysV to MS calling convention.

Preserving CR0.TS is no longer necessary in Linux, and preserving the
FP register state is also redundant in most cases, since efi_call() is
almost always used from within the scope of a pair of kernel_fpu_begin()/
kernel_fpu_end() calls, with the exception of the early call to
SetVirtualAddressMap() and the SGI UV support code.

So let's add a pair of kernel_fpu_begin()/_end() calls there as well,
and remove the unnecessary code from the assembly implementation of
efi_call(), and only keep the pieces that deal with the stack
alignment and the ABI translation.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/Makefile      |  1 -
 arch/x86/platform/efi/efi_64.c      |  3 +++
 arch/x86/platform/efi/efi_stub_64.S | 39 +++--------------------------
 arch/x86/platform/uv/bios_uv.c      |  7 ++++--
 4 files changed, 12 insertions(+), 38 deletions(-)

diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index fe29f3f5d384..7ec3a8b31f8b 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
-OBJECT_FILES_NON_STANDARD_efi_stub_$(BITS).o := y
 
 obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index a7f11d1ff7c4..03565dad0c4b 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -1019,6 +1019,8 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 		efi_switch_mm(&efi_mm);
 	}
 
+	kernel_fpu_begin();
+
 	/* Disable interrupts around EFI calls: */
 	local_irq_save(flags);
 	status = efi_call(efi.systab->runtime->set_virtual_address_map,
@@ -1026,6 +1028,7 @@ efi_status_t __init efi_set_virtual_address_map(unsigned long memory_map_size,
 			  descriptor_version, virtual_map);
 	local_irq_restore(flags);
 
+	kernel_fpu_end();
 
 	if (save_pgd)
 		efi_old_memmap_phys_epilog(save_pgd);
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index b1d2313fe3bf..e7e1020f4ccb 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -8,41 +8,12 @@
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
+#include <asm/nospec-branch.h>
 
 SYM_FUNC_START(efi_call)
 	pushq %rbp
 	movq %rsp, %rbp
-	SAVE_XMM
+	and $~0xf, %rsp
 	mov 16(%rbp), %rax
 	subq $48, %rsp
 	mov %r9, 32(%rsp)
@@ -50,9 +21,7 @@ SYM_FUNC_START(efi_call)
 	mov %r8, %r9
 	mov %rcx, %r8
 	mov %rsi, %rcx
-	call *%rdi
-	addq $48, %rsp
-	RESTORE_XMM
-	popq %rbp
+	CALL_NOSPEC %rdi
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
2.20.1

