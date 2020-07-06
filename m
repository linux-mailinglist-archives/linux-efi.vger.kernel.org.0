Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1432D215D13
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgGFR0i (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:26:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41529 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgGFR0h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056422; x=1625592422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nglTD4UGuoe/uqWlZLpzP4BN9AAnND7WFwPf/vb2+9A=;
  b=NH/ZoGNeiGNu7FaGyGpFPb2mHQguB9Z+cAtmxUBt37xGXCo8S/qA8B5M
   gpzFHhQ1GFgF3uEdBFj9DoplZyYZvup1wuiUPLKXd19Qm3gwO+YCV5vxI
   nQoMA5G1sq5nOG0mKqecQIRDa7V8ee1zrw1koGluxPr+PeSIGBw+1Qo/e
   ETqMatgMOpPRydbU/R3gYAbt6I57IWaHwLry9oPzywM2llsPaNoAhhGGU
   F2EV4MqUVfmbLkSPRreQcgXQeytAw0vWv+K3ACNqM56FWyNN5UumwOJuj
   q5NruiZV6T5+s14gogzmnz5OGo8TGXiPOZ1wJB/76nxBMM+CzL0scj5nT
   Q==;
IronPort-SDR: mKGa5QMT/3WfG4u4umz9mrap/fcyO9eK7k1PvyVIWKjUNLdRi32a+Hn12NJd0RVAmHWB9Uqb3k
 mp1nQq5L48jO/uYxOX+915+BTiKh4D70eFuE8ASt2cPPPd3ihLUxisplzhGYTtHOF6nFPxbvJK
 IS13Mj7SlErVbXpqk/mKYaSOzgrC3XLRfgRM7K3jG9VUq3Q9RvsH0+CT8ah0aTmzMEb3wJeoJ/
 JUA5DWKbv5wkrBsa3criIgEUGmqqf8XZHecCqFLkKIJY3OGk1E7qNBYXid3Uwud6o6gbmiwJma
 nCI=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770179"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:53 +0800
IronPort-SDR: oKKCsbNCmvBjYoNrMDNf5gaxj7Eg6xELB6+EilXvN7uqRrWoFvUjk159ctDXFrODCGfptmcw0w
 kDRVcWf8qMYnXo2G4yl6kr+dSZHQJgqWs=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:39 -0700
IronPort-SDR: gDKpxTkf6kRQVCNHFTZKzeJePNqqwOyT895u69WUMRsx6FMtPceebiL50Lkyg9sjTJz7zphSC0
 o+OC9FBlwPIQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:30 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 04/11] RISC-V: Add early ioremap support
Date:   Mon,  6 Jul 2020 10:26:02 -0700
Message-Id: <20200706172609.25965-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
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
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/fixmap.h | 13 +++++++++++++
 arch/riscv/include/asm/io.h     |  1 +
 arch/riscv/kernel/setup.c       |  1 +
 arch/riscv/mm/init.c            | 33 +++++++++++++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 128192e14ff2..fda90093e588 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,6 +32,7 @@ config RISCV
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
index 8519a6d29857..1244b433fe7c 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -72,6 +72,7 @@ void __init setup_arch(char **cmdline_p)
 
 	*cmdline_p = boot_command_line;
 
+	early_ioremap_setup();
 	parse_early_param();
 
 	setup_bootmem();
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c18c94ab3b23..bad60686d080 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -377,6 +377,9 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
 	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_t fix_bmap_spmd, fix_bmap_epmd;
+#endif
 
 	va_pa_offset = PAGE_OFFSET - load_pa;
 	pfn_base = PFN_DOWN(load_pa);
@@ -427,6 +430,36 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	dtb_size = fdt_totalsize((void *)dtb_pa);
 	dtb_size = (dtb_size > DTB_EARLY_SIZE) ? DTB_EARLY_SIZE : dtb_size;
 	memcpy((void *)pa, (void *)dtb_pa, dtb_size);
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

