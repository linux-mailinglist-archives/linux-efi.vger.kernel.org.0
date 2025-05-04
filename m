Return-Path: <linux-efi+bounces-3554-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C4FAA85A0
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736793B5BE6
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383D41A8409;
	Sun,  4 May 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4x2XJdLL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15A1A4F0A
	for <linux-efi@vger.kernel.org>; Sun,  4 May 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746352394; cv=none; b=rEw2A/ULSm5WaNfC7G+0TLZGTA9bZBHmHVmQyLFXRLh92lxUhQh+4HGWYt4bPdSp2I5xtLcXe28+8hop9lF9QGaC1k5bxJGR7Zdm07f0o6GIClM3E7HXoBHwsAQPGiPxAejwBmLHmIkHJMMuvxKlMWqHqnriObgLCzTccW7+TO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746352394; c=relaxed/simple;
	bh=gNZGHqyOZ8kqPKqESXMKN4wrhEpSByrTvzHlmUl4fE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hsUpMfYW0D7P6CetP9NXWLe3df1LovTXIravtIG/Xx2N7DFOJCnI7unfW33k4xV4Dobg+FAuctSoRZEfKzYCP7KLKRbtabFCU1SbPMVWhdlmW3MNzAMu7pO8AYMpSMgbu18IjDebUag9EMFOw/BnfNcQzXY56LLvDYSnRBFeUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4x2XJdLL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so17998975e9.1
        for <linux-efi@vger.kernel.org>; Sun, 04 May 2025 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746352390; x=1746957190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3KvQ4IaPUIPHwhX5gNyqgIsIykUHwLmOqlwVneJyU0=;
        b=4x2XJdLLlgQlVdFT/JwccfgjuVI9esZmr9f0LPWzrp7tC0rbk672T/TbZnXnUWysEq
         OMnV5b4S+8lvzGLaXlhTMufYQJapNOJyp6wkyvnbWUoNYn0taOrXEwYVlPHFO+Gf2mgN
         rlHwMm6eBZtwyrQIU6CC511PwT6FIMvfL0qsC2PXoMCqYdvaQLb6kl8bO7SSH4x+F9B8
         PXtDzPASsmNlL9iPDaD8EOILgcxAr5pmSUfQzz6l7fPGhVcgHXAZvjiGnrwiOMJdZ0RO
         bdBYDnvu2xdyx9QQS7otswBkmCgNUKZPV4k1FONZsT7MHUhsQ3ZQeScr4TeeNY1h7Xhi
         sO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746352390; x=1746957190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3KvQ4IaPUIPHwhX5gNyqgIsIykUHwLmOqlwVneJyU0=;
        b=PeIP/5OdLmP5ShRxH2vhQUfzGq2nPmHNs+YltiHKf69YGM6LsP90vsTZOAto3yk75g
         7udi3hVQzcFGwigth3/sdVNVVRbdNvqdk6MYDcPPyZ7A8gBqA4n1vlzk3KnXLkBRpCjQ
         ioCxbNnsghW61jLGG84pub6Bu7lDhmOgEvIFzAOFllBpFRo6rDpCPDqioXkihlSe+faE
         SseuDr1EYDyKMyEhYeRC4YG66qQua2nwr4IsQWY+5nmCArmG7eNjvua+OCpE/q2CQPDu
         9YQ6hef/+1W0zzbbEWdyNQA7BqJb8IPRW8DMOYq7n1hHZ0BohLC/xhG2ZhjAwfqzw+rk
         XhiA==
X-Gm-Message-State: AOJu0YzUM+HaamliAtCnQPWBOOcDbHzJJ0IOE0g7O30irPZQ0lvjlz+e
	1VMHEATMk46R5Nz4HQXYmPiyunOLXCkGf89JwCd+dvjt/2jU3pIa1abfLZ8DpWpBU7xPOA==
X-Google-Smtp-Source: AGHT+IH4o59y+hsvxaJrLfYuHjis35NQIrge7NC7Dy2cR0sdpFlyVLpjG9qzhqRzqll7hgTgzHEF5e5a
X-Received: from wmbbe8.prod.google.com ([2002:a05:600c:1e88:b0:441:b661:2d94])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a40e:b0:441:ac58:ead5
 with SMTP id 5b1f17b1804b1-441c1d739a8mr34930995e9.31.1746352390621; Sun, 04
 May 2025 02:53:10 -0700 (PDT)
Date: Sun,  4 May 2025 11:52:33 +0200
In-Reply-To: <20250504095230.2932860-25-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504095230.2932860-25-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9953; i=ardb@kernel.org;
 h=from:subject; bh=koYlPPxJjdcJPSpPZ44TX3JNDHpVDK2BDJVMPMG1Oms=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPc4lGbyNEnR/yenLmgVeqk7bGFu3zpC101UQGb6K9iT
 Fv/y0zvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNJv8HwT6Vs2kvuBv3ns88U
 /17rEGDvsKNk1TXnrL8x+75yX8j+P4+RYfasJc4uapq792hnuE8xvvDzy4yG34s+XZ0Qoy41bZL bPlYA
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504095230.2932860-28-ardb+git@google.com>
Subject: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping track of
 LA57 state
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

On x86_64, the core kernel is entered in long mode, which implies that
paging is enabled. This means that the CR4.LA57 control bit is
guaranteed to be in sync with the number of paging levels used by the
kernel, and there is no need to store this in a variable.

There is also no need to use variables for storing the calculations of
pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.

This removes the need for two different sources of truth (i.e., early
and late) for determining whether 5-level paging is in use: CR4.LA57
always reflects the actual state, and never changes from the point of
view of the 64-bit core kernel. It also removes the need for exposing
the associated variables to the startup code. The only potential concern
is the cost of CR4 accesses, which can be mitigated using alternatives
patching based on feature detection.

Note that even the decompressor does not manipulate any page tables
before updating CR4.LA57, so it can also avoid the associated global
variables entirely. However, as it does not implement alternatives
patching, the associated ELF sections need to be discarded.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.h         |  4 --
 arch/x86/boot/compressed/pgtable_64.c   | 12 ------
 arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
 arch/x86/boot/startup/map_kernel.c      | 12 +-----
 arch/x86/boot/startup/sme.c             |  9 ----
 arch/x86/include/asm/pgtable_64_types.h | 43 ++++++++++----------
 arch/x86/kernel/cpu/common.c            |  2 -
 arch/x86/kernel/head64.c                | 11 -----
 arch/x86/mm/kasan_init_64.c             |  3 --
 9 files changed, 24 insertions(+), 73 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index dd8d1a85f671..450d27d0f449 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -16,9 +16,6 @@
 
 #define __NO_FORTIFY
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 /*
  * Boot stub deals with identity mappings, physical and virtual addresses are
  * the same, so override these defines.
@@ -181,7 +178,6 @@ static inline int count_immovable_mem_regions(void) { return 0; }
 #endif
 
 /* ident_map_64.c */
-extern unsigned int __pgtable_l5_enabled, pgdir_shift, ptrs_per_p4d;
 extern void kernel_add_identity_map(unsigned long start, unsigned long end);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 5a6c7a190e5b..591d28f2feb6 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -10,13 +10,6 @@
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
 
-#ifdef CONFIG_X86_5LEVEL
-/* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
-unsigned int __section(".data") __pgtable_l5_enabled;
-unsigned int __section(".data") pgdir_shift = 39;
-unsigned int __section(".data") ptrs_per_p4d = 1;
-#endif
-
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
@@ -127,11 +120,6 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 			native_cpuid_eax(0) >= 7 &&
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		l5_required = true;
-
-		/* Initialize variables for 5-level paging */
-		__pgtable_l5_enabled = 1;
-		pgdir_shift = 48;
-		ptrs_per_p4d = 512;
 	}
 
 	/*
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 3b2bc61c9408..d3e786ff7dcb 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -81,6 +81,7 @@ SECTIONS
 		*(.dynamic) *(.dynsym) *(.dynstr) *(.dynbss)
 		*(.hash) *(.gnu.hash)
 		*(.note.*)
+		*(.altinstructions .altinstr_replacement)
 	}
 
 	.got.plt (INFO) : {
diff --git a/arch/x86/boot/startup/map_kernel.c b/arch/x86/boot/startup/map_kernel.c
index 099ae2559336..11f99d907f76 100644
--- a/arch/x86/boot/startup/map_kernel.c
+++ b/arch/x86/boot/startup/map_kernel.c
@@ -16,19 +16,9 @@ extern unsigned int next_early_pgt;
 
 static inline bool check_la57_support(void)
 {
-	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+	if (!pgtable_l5_enabled())
 		return false;
 
-	/*
-	 * 5-level paging is detected and enabled at kernel decompression
-	 * stage. Only check if it has been enabled there.
-	 */
-	if (!(native_read_cr4() & X86_CR4_LA57))
-		return false;
-
-	__pgtable_l5_enabled	= 1;
-	pgdir_shift		= 48;
-	ptrs_per_p4d		= 512;
 	page_offset_base	= __PAGE_OFFSET_BASE_L5;
 	vmalloc_base		= __VMALLOC_BASE_L5;
 	vmemmap_base		= __VMEMMAP_BASE_L5;
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 5738b31c8e60..ade5ad5060e9 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -25,15 +25,6 @@
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
-/*
- * This code runs before CPU feature bits are set. By default, the
- * pgtable_l5_enabled() function uses bit X86_FEATURE_LA57 to determine if
- * 5-level paging is active, so that won't work here. USE_EARLY_PGTABLE_L5
- * is provided to handle this situation and, instead, use a variable that
- * has been set by the early boot code.
- */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 5bb782d856f2..40dceb7d80f5 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -6,7 +6,10 @@
 
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
+#include <asm/alternative.h>
+#include <asm/cpufeatures.h>
 #include <asm/kaslr.h>
+#include <asm/processor-flags.h>
 
 /*
  * These are used to make use of C type-checking..
@@ -21,28 +24,24 @@ typedef unsigned long	pgprotval_t;
 typedef struct { pteval_t pte; } pte_t;
 typedef struct { pmdval_t pmd; } pmd_t;
 
-extern unsigned int __pgtable_l5_enabled;
-
-#ifdef CONFIG_X86_5LEVEL
-#ifdef USE_EARLY_PGTABLE_L5
-/*
- * cpu_feature_enabled() is not available in early boot code.
- * Use variable instead.
- */
-static inline bool pgtable_l5_enabled(void)
+static __always_inline __pure bool pgtable_l5_enabled(void)
 {
-	return __pgtable_l5_enabled;
-}
-#else
-#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
-#endif /* USE_EARLY_PGTABLE_L5 */
+	unsigned long r;
+	bool ret;
 
-#else
-#define pgtable_l5_enabled() 0
-#endif /* CONFIG_X86_5LEVEL */
+	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
+		return false;
 
-extern unsigned int pgdir_shift;
-extern unsigned int ptrs_per_p4d;
+	asm(ALTERNATIVE_TERNARY(
+		 "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
+		 %P[feat], "stc", "clc")
+		 : [reg] "=&r" (r), CC_OUT(c) (ret)
+		 : [feat] "i"  (X86_FEATURE_LA57),
+		   [la57] "i"  (X86_CR4_LA57_BIT)
+		 : "cc");
+
+	return ret;
+}
 
 #endif	/* !__ASSEMBLER__ */
 
@@ -53,7 +52,7 @@ extern unsigned int ptrs_per_p4d;
 /*
  * PGDIR_SHIFT determines what a top-level page table entry can map
  */
-#define PGDIR_SHIFT	pgdir_shift
+#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)
 #define PTRS_PER_PGD	512
 
 /*
@@ -61,7 +60,7 @@ extern unsigned int ptrs_per_p4d;
  */
 #define P4D_SHIFT		39
 #define MAX_PTRS_PER_P4D	512
-#define PTRS_PER_P4D		ptrs_per_p4d
+#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)
 #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
 #define P4D_MASK		(~(P4D_SIZE - 1))
 
@@ -76,6 +75,8 @@ extern unsigned int ptrs_per_p4d;
 #define PTRS_PER_PGD		512
 #define MAX_PTRS_PER_P4D	1
 
+#define MAX_POSSIBLE_PHYSMEM_BITS      46
+
 #endif /* CONFIG_X86_5LEVEL */
 
 /*
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126adbc3a9..eb6a7f6e20c4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
 
 #include <linux/memblock.h>
 #include <linux/linkage.h>
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 29226f3ac064..3d49abb1bb3a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -5,9 +5,6 @@
  *  Copyright (C) 2000 Andrea Arcangeli <andrea@suse.de> SuSE
  */
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/init.h>
 #include <linux/linkage.h>
 #include <linux/types.h>
@@ -50,14 +47,6 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
 unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
-#ifdef CONFIG_X86_5LEVEL
-unsigned int __pgtable_l5_enabled __ro_after_init;
-unsigned int pgdir_shift __ro_after_init = 39;
-EXPORT_SYMBOL(pgdir_shift);
-unsigned int ptrs_per_p4d __ro_after_init = 1;
-EXPORT_SYMBOL(ptrs_per_p4d);
-#endif
-
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 unsigned long page_offset_base __ro_after_init = __PAGE_OFFSET_BASE_L4;
 EXPORT_SYMBOL(page_offset_base);
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d216..7c4fafbd52cc 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define pr_fmt(fmt) "kasan: " fmt
 
-/* cpu_feature_enabled() cannot be used this early */
-#define USE_EARLY_PGTABLE_L5
-
 #include <linux/memblock.h>
 #include <linux/kasan.h>
 #include <linux/kdebug.h>
-- 
2.49.0.906.g1f30a19c02-goog


