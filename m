Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F249224A94F
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHSWYp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 18:24:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15999 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSWYc (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 18:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597875873; x=1629411873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1+exhHvoEzHZuKUfuZMQIx7m97ewKpgJpfZCAp36R5U=;
  b=Oyaz9BSP5b769Nb8UqFuXbPx5bgNg2BT6XU5V9OUqHt0iSh+ssf0Eltp
   fN/k1AZSC4NYmiBH2xj+eaqVgbPqymb+/NDqooyo+3T0mRNy5J+gdVryh
   ueCiHhd7VCC2i+CWcF4lDX7u9AWklIrwNO6Ar3G8GZUufcO155J+GATQ9
   HSOURyHBSY1+ttyUOWYP9QqoG38BbKkAbUbmaBwlDcaYOLf4tEJW9UAr8
   VnIa7C14Yi1iTuPbSNgFR0Tt4o1pUD1unBNI5lSxenYB+TEfBRWb1CV72
   x4331nRcGCKsIR5Na20EVYX4hQj7u/vMRXgQjdt0r9SpNmWDeTl2fYm8G
   A==;
IronPort-SDR: c2Sf10f97zd3zV6j1B/Y4kDW8nfBqq+NuFCPIXVIf69EbnbPTh21xKQwADAgxtrLE2MwNqCsB7
 Q77fNsWt1QdhM6qRR2jMymAjmsGoZ9XoM7agE/f/MohB7YGSD/xCSjQZd//AncCQ6k7xpmuZh2
 xhxWABXpHx5twFfo3jcDgC3dci8VjBjIT/5NT3yRbMAaw14K2h/Ewlk/SIaCzdFri24oQEAcB1
 6OpUFhg3hCIFyh+rGy3S80VQ2q/WMQeKmEqwACWRxMafnmUPgUIMIZMrjCf5WiiCDcvi5LYF+n
 Jd4=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; 
   d="scan'208";a="145373594"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 06:24:33 +0800
IronPort-SDR: gGbIaWvFsCEipycofEB+wLuXcfkI3jFaGIZxPftSeiEwa25t2p8Im52KCWDmexJDzNSMHeqLsZ
 sxE7WM6wRFOQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:12:15 -0700
IronPort-SDR: JRXjS/gPJIr4bbIeKh5yMdmXz9KUHTxYXV2rcVSdbupXXAQegWo2Fe4lcvHQa4az/74M0sC0Sn
 YLHF0OMkLBZQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2020 15:24:32 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>, Zong Li <zong.li@sifive.com>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v6 2/9] RISC-V: Add early ioremap support
Date:   Wed, 19 Aug 2020 15:24:18 -0700
Message-Id: <20200819222425.30721-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200819222425.30721-1-atish.patra@wdc.com>
References: <20200819222425.30721-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/setup.c       |  1 +
 arch/riscv/mm/init.c            | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7b5905529146..15597f5f504f 100644
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
index 6a0ee2405813..c71788e6aff4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -72,6 +72,7 @@ void __init setup_arch(char **cmdline_p)
 
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

