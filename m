Return-Path: <linux-efi+bounces-1963-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8189899C83C
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2024 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F471C26245
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2024 11:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA631AA7A2;
	Mon, 14 Oct 2024 11:02:19 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDE31DD860;
	Mon, 14 Oct 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903738; cv=none; b=XkAKuOneSGzFlkapxH1SG2TwCEvCvA02vhqYwKzO8ISkn5IctbAVmfJ24/O5PRLvt2XBvcIVAIdvFr6bpkx5PSz7jt0LSTDbyM9mvzXeBBBnKf1aL1guFE4vHrGurKwFfeKlQwEDqTES8izSjgr6k7/cTQnRTF+vvssxfG5XXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903738; c=relaxed/simple;
	bh=wXcWDfoIbzEAXadEzvyVMkkfOTcBg0Jj+Po0Slo/R4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYRUugAfWfEP9XLBDF9Hg5diLQyo6Nk1NklV6tSTgREqSVBDCLiCCOw1YM6iIJabyMey7ZkcO1tfhdVUjax6f5gkPMBu7B7Ex9d7ZhvsKthn7nHBFICRyPLvr/w+WnkEDk0jvKq0lALs0iBUcO2E+ID4sW4q8ryVVqimM/AuzAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C0D71756;
	Mon, 14 Oct 2024 04:02:46 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FB423F51B;
	Mon, 14 Oct 2024 04:02:13 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Oliver Upton <oliver.upton@linux.dev>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 56/57] arm64: Determine THREAD_SIZE at boot-time
Date: Mon, 14 Oct 2024 11:59:03 +0100
Message-ID: <20241014105912.3207374-56-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since THREAD_SIZE depends on PAGE_SIZE when stacks are vmapped, we must
defer the decision on THREAD_SIZE until we have selected PAGE_SIZE at
boot.

The one wrinkle is entry.S's requirement to have THREAD_SHIFT as an
immediate in order to check that the stack has not overflowed without
clobbering any registers, early in the exception handler. Solve this by
patching alternatives. During early boot, all 3 options are NOPs until
the alternative is patched in. So we forgo overflow checking until
boot-cpu patching is complete.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/include/asm/assembler.h |  5 +++
 arch/arm64/include/asm/efi.h       |  2 +-
 arch/arm64/include/asm/memory.h    | 51 +++++++++++++++++++++++++-----
 arch/arm64/kernel/efi.c            |  2 +-
 arch/arm64/kernel/entry.S          | 10 +++++-
 arch/arm64/kernel/head.S           |  3 +-
 arch/arm64/kernel/vmlinux.lds.S    |  4 +--
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S  |  2 +-
 8 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0cfa7c3efd214..745328e7768b7 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -928,4 +928,9 @@ alternative_cb_end
 	get_tg0 \val
 	value_for_page_size \val, \val, (~(SZ_4K-1)), (~(SZ_16K-1)), (~(SZ_64K-1))
 	.endm
+
+	.macro	get_task_size, val
+	get_tg0 \val
+	value_for_page_size \val, \val, (1 << THREAD_SHIFT_4K), (1 << THREAD_SHIFT_16K), (1 << THREAD_SHIFT_64K)
+	.endm
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index bcd5622aa0968..913f599c14e40 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -68,7 +68,7 @@ void arch_efi_call_virt_teardown(void);
  * kernel need greater alignment than we require the segments to be padded to.
  */
 #define EFI_KIMG_ALIGN	\
-	(SEGMENT_ALIGN > THREAD_ALIGN ? SEGMENT_ALIGN : THREAD_ALIGN)
+	(SEGMENT_ALIGN > THREAD_ALIGN_MAX ? SEGMENT_ALIGN : THREAD_ALIGN_MAX)
 
 /*
  * On arm64, we have to ensure that the initrd ends up in the linear region,
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 5393a859183f7..e28f5700ef022 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -110,23 +110,56 @@
 #define PAGE_END		(_PAGE_END(VA_BITS_MIN))
 #endif /* CONFIG_KASAN */
 
-#define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
+#define IDEAL_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
 
 /*
  * VMAP'd stacks are allocated at page granularity, so we must ensure that such
  * stacks are a multiple of page size.
  */
-#if defined(CONFIG_VMAP_STACK) && (MIN_THREAD_SHIFT < PAGE_SHIFT)
-#define THREAD_SHIFT		PAGE_SHIFT
+
+#if defined(CONFIG_VMAP_STACK)
+#define THREAD_SHIFT							\
+	(IDEAL_THREAD_SHIFT < PAGE_SHIFT ? PAGE_SHIFT : IDEAL_THREAD_SHIFT)
+#if (IDEAL_THREAD_SHIFT < PAGE_SHIFT_MIN)
+#define THREAD_SHIFT_MIN	PAGE_SHIFT_MIN
 #else
-#define THREAD_SHIFT		MIN_THREAD_SHIFT
+#define THREAD_SHIFT_MIN	IDEAL_THREAD_SHIFT
 #endif
-
-#if THREAD_SHIFT >= PAGE_SHIFT
-#define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
+#if (IDEAL_THREAD_SHIFT < PAGE_SHIFT_MAX)
+#define THREAD_SHIFT_MAX	PAGE_SHIFT_MAX
+#else
+#define THREAD_SHIFT_MAX	IDEAL_THREAD_SHIFT
+#endif
+#if (IDEAL_THREAD_SHIFT < ARM64_PAGE_SHIFT_4K)
+#define THREAD_SHIFT_4K		ARM64_PAGE_SHIFT_4K
+#else
+#define THREAD_SHIFT_4K		IDEAL_THREAD_SHIFT
+#endif
+#if (IDEAL_THREAD_SHIFT < ARM64_PAGE_SHIFT_16K)
+#define THREAD_SHIFT_16K	ARM64_PAGE_SHIFT_16K
+#else
+#define THREAD_SHIFT_16K	IDEAL_THREAD_SHIFT
+#endif
+#if (IDEAL_THREAD_SHIFT < ARM64_PAGE_SHIFT_64K)
+#define THREAD_SHIFT_64K	ARM64_PAGE_SHIFT_64K
+#else
+#define THREAD_SHIFT_64K	IDEAL_THREAD_SHIFT
 #endif
+#else
+#define THREAD_SHIFT		IDEAL_THREAD_SHIFT
+#define THREAD_SHIFT_MIN	IDEAL_THREAD_SHIFT
+#define THREAD_SHIFT_MAX	IDEAL_THREAD_SHIFT
+#define THREAD_SHIFT_4K		IDEAL_THREAD_SHIFT
+#define THREAD_SHIFT_16K	IDEAL_THREAD_SHIFT
+#define THREAD_SHIFT_64K	IDEAL_THREAD_SHIFT
+#endif
+
+#define THREAD_SIZE_ORDER						\
+	(PAGE_SHIFT < THREAD_SHIFT ? THREAD_SHIFT - PAGE_SHIFT : 0)
 
 #define THREAD_SIZE		(UL(1) << THREAD_SHIFT)
+#define THREAD_SIZE_MIN		(UL(1) << THREAD_SHIFT_MIN)
+#define THREAD_SIZE_MAX		(UL(1) << THREAD_SHIFT_MAX)
 
 /*
  * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
@@ -135,11 +168,13 @@
  */
 #ifdef CONFIG_VMAP_STACK
 #define THREAD_ALIGN		(2 * THREAD_SIZE)
+#define THREAD_ALIGN_MAX	(2 * THREAD_SIZE_MAX)
 #else
 #define THREAD_ALIGN		THREAD_SIZE
+#define THREAD_ALIGN_MAX	THREAD_SIZE_MAX
 #endif
 
-#define IRQ_STACK_SIZE		THREAD_SIZE
+#define IRQ_STACK_SIZE		THREAD_SIZE_MIN
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 712718aed5dd9..ebc44b7e83199 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -197,7 +197,7 @@ bool efi_runtime_fixup_exception(struct pt_regs *regs, const char *msg)
 }
 
 /* EFI requires 8 KiB of stack space for runtime services */
-static_assert(THREAD_SIZE >= SZ_8K);
+static_assert(THREAD_SIZE_MIN >= SZ_8K);
 
 static int __init arm64_efi_rt_init(void)
 {
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index ba47dc8672c04..1ab65e406b62e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -62,7 +62,15 @@
 	 */
 	add	sp, sp, x0			// sp' = sp + x0
 	sub	x0, sp, x0			// x0' = sp' - x0 = (sp + x0) - x0 = sp
-	tbnz	x0, #THREAD_SHIFT, 0f
+alternative_if ARM64_USE_PAGE_SIZE_4K
+	tbnz	x0, #THREAD_SHIFT_4K, 0f
+alternative_else_nop_endif
+alternative_if ARM64_USE_PAGE_SIZE_16K
+	tbnz	x0, #THREAD_SHIFT_16K, 0f
+alternative_else_nop_endif
+alternative_if ARM64_USE_PAGE_SIZE_64K
+	tbnz	x0, #THREAD_SHIFT_64K, 0f
+alternative_else_nop_endif
 	sub	x0, sp, x0			// x0'' = sp' - x0' = (sp + x0) - sp = x0
 	sub	sp, sp, x0			// sp'' = sp' - x0 = (sp + x0) - x0 = sp
 	b	el\el\ht\()_\regsize\()_\label
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 761b7f5633e15..2530ee5cee548 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -198,7 +198,8 @@ SYM_CODE_END(preserve_boot_args)
 	msr	sp_el0, \tsk
 
 	ldr	\tmp1, [\tsk, #TSK_STACK]
-	add	sp, \tmp1, #THREAD_SIZE
+	get_task_size \tmp2
+	add	sp, \tmp1, \tmp2
 	sub	sp, sp, #PT_REGS_SIZE
 
 	stp	xzr, xzr, [sp, #S_STACKFRAME]
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 09fcc234c0f77..937900a458a89 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -60,11 +60,11 @@
 #define RO_EXCEPTION_TABLE_ALIGN	4
 #define RUNTIME_DISCARD_EXIT
 
+#include <asm/memory.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/kexec.h>
-#include <asm/memory.h>
 #include <asm/page.h>
 
 #include "image.h"
@@ -292,7 +292,7 @@ SECTIONS
 
 	_data = .;
 	_sdata = .;
-	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE_MAX, THREAD_ALIGN)
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE_MAX, THREAD_ALIGN_MAX)
 
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 74c7c21626270..fe1fbfa8f8f05 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -7,9 +7,9 @@
  */
 
 #include <asm/hyp_image.h>
+#include <asm/memory.h>
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
-#include <asm/memory.h>
 
 SECTIONS {
 	HYP_SECTION(.idmap.text)
-- 
2.43.0


