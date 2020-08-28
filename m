Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2786255F93
	for <lists+linux-efi@lfdr.de>; Fri, 28 Aug 2020 19:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgH1RUy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Aug 2020 13:20:54 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11691 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgH1RUp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Aug 2020 13:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598635245; x=1630171245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uBXOC7gYWlhczehhZY3QEsUN9Uby27rSKymYN+y1E7o=;
  b=NSkPxOLZmufje9zYGayDXDC3rkGNJnMtawTzTtEBCcxQcFgaXCID7S5m
   FWEne6xaehz2Fq90lRckMjwU4+8S3GlSjmmmkWbT66yKuu/jgrM/vxgAY
   g1ZDZqHV/GQrt0/8tCzeVgiv4hBlKfmjePw6El2LRTO8bysdZcfK/RZtP
   QFnS2ok/22Y6KcR406NhOJVJebqcK8wc+2jmcLNKn4+16igOYN99hZaE0
   qpkvXO42KfOrSJkQ4mlBsa3dWfw9KEjoT5kB9y+bWgxryiDVAbRw7vCtI
   idCae9RloluCV6Ohs870v5aCjqT0ppPHvYrqdDzNaZgfGJCvSRFhffqUh
   g==;
IronPort-SDR: fDoW0DojN3Av9x/rIaNqk8u+EJXDHJvG+e4Jq0XtFTV3b+Q3WmPqoNVg/4iaB4EP70PzuvO/mA
 JYjkXFA2A2aPz5NCMHvARlOubrp3D4gY9qlpIGgKFdzMS1kaE2s9BpbQ6URCh0QjGFgYcic9gl
 6ZbAfsaIUJhdZT5UNPW+RwpcQNrUUCogjPUG09mlkfmCfMg7AumqejTN1lfrviw5tvCAPMqWt2
 Tqmhi2MNahCbsON85nk9QdZisCP2rdb2RPsXNujOBNvxjDVf3pAHkAR736cqP6VbVZIYVsoIj4
 UJU=
X-IronPort-AV: E=Sophos;i="5.76,364,1592841600"; 
   d="scan'208";a="146018511"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2020 01:20:43 +0800
IronPort-SDR: KUvP3SVXKbvwUTGnp8hKCDYO/QzFkMiBYNBUB1+ED954jeXvdmUFTGHf24/ZNWkr9blFMZHHjR
 vVTtDU+v5clw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:08:15 -0700
IronPort-SDR: d4FaQpP59/1hwIbhNKijmMWqa6effNdgkooFMgMADBpTb5fmy0vgHUlDBohd8Z46JHYkJ0dhk/
 ncXpA3jReDMg==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.137])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Aug 2020 10:20:43 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v7 2/9] RISC-V: Add early ioremap support
Date:   Fri, 28 Aug 2020 10:20:29 -0700
Message-Id: <20200828172036.8056-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200828172036.8056-1-atish.patra@wdc.com>
References: <20200828172036.8056-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI uses early IO or memory mappings for runtime services before
normal ioremap() is usable. Add the necessary fixmap bindings and
pmd mappings for generic ioremap support to work.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/fixmap.h | 13 +++++++++++++
 arch/riscv/include/asm/io.h     |  1 +
 arch/riscv/kernel/setup.c       |  2 ++
 arch/riscv/mm/init.c            | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 51 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index df18372861d8..5e4ace64acbc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,6 +37,7 @@ config RISCV
 	select GENERIC_ARCH_TOPOLOGY if SMP
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_EARLY_IOREMAP
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
 	select GENERIC_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 3d9410bb4de0..59dd7be55005 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += kvm_para.h
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 11613f38228a..54cbf07fb4e9 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -27,6 +27,19 @@ enum fixed_addresses {
 	FIX_TEXT_POKE1,
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
+
+	__end_of_permanent_fixed_addresses,
+	/*
+	 * Temporary boot-time mappings, used by early_ioremap(),
+	 * before ioremap() is functional.
+	 */
+#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#define FIX_BTMAPS_SLOTS	7
+#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
+
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
+
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 3835c3295dc5..c025a746a148 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/pgtable.h>
 #include <asm/mmiowb.h>
+#include <asm/early_ioremap.h>
 
 /*
  * MMIO access functions are separated out to break dependency cycles
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index edea7ef88402..41ef96d0d97a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 
 #include <asm/cpu_ops.h>
+#include <asm/early_ioremap.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>
@@ -71,6 +72,7 @@ void __init setup_arch(char **cmdline_p)
 
 	*cmdline_p = boot_command_line;
 
+	early_ioremap_setup();
 	parse_early_param();
 
 	setup_bootmem();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2b651f63f5c4..b75ebe8e7a92 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -403,6 +403,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
 	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_t fix_bmap_spmd, fix_bmap_epmd;
+#endif
 
 	va_pa_offset = PAGE_OFFSET - load_pa;
 	pfn_base = PFN_DOWN(load_pa);
@@ -456,6 +459,36 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 			   pa + PGDIR_SIZE, PGDIR_SIZE, PAGE_KERNEL);
 	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PGDIR_SIZE - 1));
 	dtb_early_pa = dtb_pa;
+
+	/*
+	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
+	 * range can not span multiple pmds.
+	 */
+	BUILD_BUG_ON((__fix_to_virt(FIX_BTMAP_BEGIN) >> PMD_SHIFT)
+		     != (__fix_to_virt(FIX_BTMAP_END) >> PMD_SHIFT));
+
+#ifndef __PAGETABLE_PMD_FOLDED
+	/*
+	 * Early ioremap fixmap is already created as it lies within first 2MB
+	 * of fixmap region. We always map PMD_SIZE. Thus, both FIX_BTMAP_END
+	 * FIX_BTMAP_BEGIN should lie in the same pmd. Verify that and warn
+	 * the user if not.
+	 */
+	fix_bmap_spmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_BEGIN))];
+	fix_bmap_epmd = fixmap_pmd[pmd_index(__fix_to_virt(FIX_BTMAP_END))];
+	if (pmd_val(fix_bmap_spmd) != pmd_val(fix_bmap_epmd)) {
+		WARN_ON(1);
+		pr_warn("fixmap btmap start [%08lx] != end [%08lx]\n",
+			pmd_val(fix_bmap_spmd), pmd_val(fix_bmap_epmd));
+		pr_warn("fix_to_virt(FIX_BTMAP_BEGIN): %08lx\n",
+			fix_to_virt(FIX_BTMAP_BEGIN));
+		pr_warn("fix_to_virt(FIX_BTMAP_END):   %08lx\n",
+			fix_to_virt(FIX_BTMAP_END));
+
+		pr_warn("FIX_BTMAP_END:       %d\n", FIX_BTMAP_END);
+		pr_warn("FIX_BTMAP_BEGIN:     %d\n", FIX_BTMAP_BEGIN);
+	}
+#endif
 }
 
 static void __init setup_vm_final(void)
-- 
2.24.0

