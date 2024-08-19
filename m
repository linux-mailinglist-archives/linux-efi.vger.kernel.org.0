Return-Path: <linux-efi+bounces-1552-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B03956DF0
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319A1B2774B
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE5173355;
	Mon, 19 Aug 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEFwLvhN"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA2175570
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079337; cv=none; b=ZkA664AJvQz3ycxAfdVWE76GaKZY62M0oe5hq8ru4cZSGdM4ucx11tsO/YoVy/C/kbmlsXHo5bI9X8SmasQ6oafUiiKMtEDVi2YeQkWGxKAnYbJhMA6GPG4bUD+a1Pu0NW9JjeOUa2mup3hCA5vgzYSAFcCvuqiKsYaT8vTUpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079337; c=relaxed/simple;
	bh=PBnBckwf3HHTrpM6pd6d+I3Xu0Da6Cv6R3/6mUnABVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYKiv9KdaPFd40fExf9Vbyq1HozVRJaB26oezev1/sJ1z0jaKUswVJ9upiCaXO/c63f2NQIx4uctjXuyeNG2Qyj7oHl75oS5DPmezH4tc7DhXnuJkBbl5Gg5wGHOH6uXt3ONGTqKoKsucoIX5ir6i6rOkLk+A413Bpah2/FU7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEFwLvhN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LcKEDsrUy4VHo6FTRlO8InFKgG7AEDUaPffRYgLjGFs=;
	b=fEFwLvhNQFaEx6clMddJhemB6cOjnWKW1i8juHPa7cGdDi9U9d+CSmLzdaeTBROxYve414
	Ny9DTCPE5fPxz3cOhWBn89LfbBuNAqlFfxwqY1A+HxZb78VJHvhrwbNjbwnJGbsFC28TBy
	6iS9jSymybcc2sjCZEYZF4rcmgWbe4s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-U2exi1kMPfW4KE9F8i_Osg-1; Mon,
 19 Aug 2024 10:55:31 -0400
X-MC-Unique: U2exi1kMPfW4KE9F8i_Osg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8631E1955D57;
	Mon, 19 Aug 2024 14:55:29 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D3B71956053;
	Mon, 19 Aug 2024 14:55:20 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-efi@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFCv2 4/9] efi/emulator: Turn on mmu for arm64
Date: Mon, 19 Aug 2024 22:53:37 +0800
Message-ID: <20240819145417.23367-5-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On arm64, when kexec switches to the new kernel, the mmu is off. So the
efi emulator should turn on the mmu to enable the identity mapping at
the first stage.

In fact, the kexec switching can run with mmu-on if it enters emulator,
but that requires the re-arrangement of the relocate_kernel.S [1].
After that, this patch can be drop.

But let us focus on emulator itself and keep things simple for the time
being.

[1]: https://lore.kernel.org/linux-arm-kernel/20240328115656.24090-1-piliu@redhat.com/

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi_emulator/Makefile    |   2 +-
 .../firmware/efi/efi_emulator/arm64_proc.S    | 175 ++++++++++++++++++
 drivers/firmware/efi/efi_emulator/entry.c     |   7 +
 3 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/efi_emulator/arm64_proc.S

diff --git a/drivers/firmware/efi/efi_emulator/Makefile b/drivers/firmware/efi/efi_emulator/Makefile
index d696381d168ba..9d295b77a2be3 100644
--- a/drivers/firmware/efi/efi_emulator/Makefile
+++ b/drivers/firmware/efi/efi_emulator/Makefile
@@ -65,7 +65,7 @@ emulator-y			:= head.o entry.o \
 				   core.o pe_loader.o memory.o memory_api.o config_table.o misc.o \
 				   device_handle.o protocol_simple_text_output.o protocol_device_path.o \
 				   lib.o printf.o \
-				   amba-pl011.o
+				   amba-pl011.o arm64_proc.o
 obj-y				:= efi_emulator.o
 
 
diff --git a/drivers/firmware/efi/efi_emulator/arm64_proc.S b/drivers/firmware/efi/efi_emulator/arm64_proc.S
new file mode 100644
index 0000000000000..8364c459b8348
--- /dev/null
+++ b/drivers/firmware/efi/efi_emulator/arm64_proc.S
@@ -0,0 +1,175 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Based on arch/arm/mm/proc.S
+ *
+ * Copyright (C) 2001 Deep Blue Solutions Ltd.
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+#include <linux/pgtable.h>
+#include <linux/cfi_types.h>
+#include <asm/assembler.h>
+#include <asm/asm-offsets.h>
+#include <asm/asm_pointer_auth.h>
+#include <asm/hwcap.h>
+#include <asm/kernel-pgtable.h>
+#include <asm/pgtable-hwdef.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
+#include <asm/smp.h>
+#include <asm/sysreg.h>
+
+#ifdef CONFIG_ARM64_64K_PAGES
+#define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
+#elif defined(CONFIG_ARM64_16K_PAGES)
+#define TCR_TG_FLAGS	TCR_TG0_16K | TCR_TG1_16K
+#else /* CONFIG_ARM64_4K_PAGES */
+#define TCR_TG_FLAGS	TCR_TG0_4K | TCR_TG1_4K
+#endif
+
+#ifdef CONFIG_RANDOMIZE_BASE
+#define TCR_KASLR_FLAGS	TCR_NFD1
+#else
+#define TCR_KASLR_FLAGS	0
+#endif
+
+#define TCR_SMP_FLAGS	TCR_SHARED
+
+/* PTWs cacheable, inner/outer WBWA */
+#define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
+
+#ifdef CONFIG_KASAN_SW_TAGS
+#define TCR_KASAN_SW_FLAGS TCR_TBI1 | TCR_TBID1
+#else
+#define TCR_KASAN_SW_FLAGS 0
+#endif
+
+#ifdef CONFIG_KASAN_HW_TAGS
+#define TCR_MTE_FLAGS TCR_TCMA1 | TCR_TBI1 | TCR_TBID1
+#elif defined(CONFIG_ARM64_MTE)
+/*
+ * The mte_zero_clear_page_tags() implementation uses DC GZVA, which relies on
+ * TBI being enabled at EL1.
+ */
+#define TCR_MTE_FLAGS TCR_TBI1 | TCR_TBID1
+#else
+#define TCR_MTE_FLAGS 0
+#endif
+
+/*
+ * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during mte_cpu_setup to Normal Tagged if the system supports MTE.
+ */
+#define MAIR_EL1_SET							\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
+
+SYM_FUNC_START(__cpu_setup)
+	tlbi	vmalle1				// Invalidate local TLB
+	dsb	nsh
+
+	msr	cpacr_el1, xzr			// Reset cpacr_el1
+	mov_q	x1, CPACR_EL1_FPEN_EL1EN | CPACR_EL1_FPEN_EL0EN | CPACR_EL1_ZEN_EL1EN
+	msr	cpacr_el1, x1			// avoid the trap of FPSIMD in uefi code
+	isb
+	mov	x1, #1 << 12			// Reset mdscr_el1 and disable
+	msr	mdscr_el1, x1			// access to the DCC from EL0
+	reset_pmuserenr_el0 x1			// Disable PMU access from EL0
+	reset_amuserenr_el0 x1			// Disable AMU access from EL0
+
+	/*
+	 * Default values for VMSA control registers. These will be adjusted
+	 * below depending on detected CPU features.
+	 */
+	mair	.req	x17
+	tcr	.req	x16
+	mov_q	mair, MAIR_EL1_SET
+	mov_q	tcr, TCR_T0SZ(IDMAP_VA_BITS) | TCR_T1SZ(VA_BITS_MIN) | TCR_CACHE_FLAGS | \
+		     TCR_SMP_FLAGS | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
+		     TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
+
+	tcr_clear_errata_bits tcr, x9, x5
+
+#ifdef CONFIG_ARM64_VA_BITS_52
+	mov		x9, #64 - VA_BITS
+alternative_if ARM64_HAS_VA52
+	tcr_set_t1sz	tcr, x9
+#ifdef CONFIG_ARM64_LPA2
+	orr		tcr, tcr, #TCR_DS
+#endif
+alternative_else_nop_endif
+#endif
+
+	/*
+	 * Set the IPS bits in TCR_EL1.
+	 */
+	tcr_compute_pa_size tcr, #TCR_IPS_SHIFT, x5, x6
+#ifdef CONFIG_ARM64_HW_AFDBM
+	/*
+	 * Enable hardware update of the Access Flags bit.
+	 * Hardware dirty bit management is enabled later,
+	 * via capabilities.
+	 */
+	mrs	x9, ID_AA64MMFR1_EL1
+	and	x9, x9, ID_AA64MMFR1_EL1_HAFDBS_MASK
+	cbz	x9, 1f
+	orr	tcr, tcr, #TCR_HA		// hardware Access flag update
+1:
+#endif	/* CONFIG_ARM64_HW_AFDBM */
+	msr	mair_el1, mair
+	msr	tcr_el1, tcr
+
+	mrs_s	x1, SYS_ID_AA64MMFR3_EL1
+	ubfx	x1, x1, #ID_AA64MMFR3_EL1_S1PIE_SHIFT, #4
+	cbz	x1, .Lskip_indirection
+
+	/*
+	 * The PROT_* macros describing the various memory types may resolve to
+	 * C expressions if they include the PTE_MAYBE_* macros, and so they
+	 * can only be used from C code. The PIE_E* constants below are also
+	 * defined in terms of those macros, but will mask out those
+	 * PTE_MAYBE_* constants, whether they are set or not. So #define them
+	 * as 0x0 here so we can evaluate the PIE_E* constants in asm context.
+	 */
+
+#define PTE_MAYBE_NG		0
+#define PTE_MAYBE_SHARED	0
+
+	mov_q	x0, PIE_E0
+	msr	REG_PIRE0_EL1, x0
+	mov_q	x0, PIE_E1
+	msr	REG_PIR_EL1, x0
+
+#undef PTE_MAYBE_NG
+#undef PTE_MAYBE_SHARED
+
+	mov	x0, TCR2_EL1x_PIE
+	msr	REG_TCR2_EL1, x0
+
+.Lskip_indirection:
+
+	/*
+	 * Prepare SCTLR
+	 */
+	mov_q	x0, INIT_SCTLR_EL1_MMU_ON
+	ret					// return to head.S
+
+	.unreq	mair
+	.unreq	tcr
+SYM_FUNC_END(__cpu_setup)
+
+SYM_FUNC_START(enable_sctlr_el1)
+	stp     x29, x30, [sp, #-16]!
+	bl      __cpu_setup
+	set_sctlr_el1 x0
+	ldp     x29, x30, [sp], #16
+	ret
+SYM_FUNC_END(enable_sctlr_el1)
+
diff --git a/drivers/firmware/efi/efi_emulator/entry.c b/drivers/firmware/efi/efi_emulator/entry.c
index e5a31bd303858..835021ab0f629 100644
--- a/drivers/firmware/efi/efi_emulator/entry.c
+++ b/drivers/firmware/efi/efi_emulator/entry.c
@@ -13,6 +13,13 @@ extern void enable_sctlr_el1(unsigned long scratch_reg);
 static void arch_handle_mmu(struct efi_emulator_param *param)
 {
 	if (!param->mmu_on && param->pgd_root) {
+		unsigned long scratch_reg = 0;
+		// in fact, we need SYM_FUNC_START(__cpu_setup), later, set SCTLR_EL1
+		//  At present, the mmu is not ON
+		write_sysreg(param->pgd_root, ttbr0_el1);
+		isb();
+		/* scratch_reg asks the C compiler to save x0 */
+		enable_sctlr_el1(scratch_reg);
 	}
 }
 
-- 
2.41.0


