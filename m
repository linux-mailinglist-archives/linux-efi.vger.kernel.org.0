Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF85441596C
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbhIWHqU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 03:46:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239777AbhIWHpe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Sep 2021 03:45:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE7161211;
        Thu, 23 Sep 2021 07:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632383043;
        bh=mJeWK+xuVoCeSQUmLH9lpzgLfVM1zzfE4HrawQix1ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDrYudBp8kqpKSZtmmIHXjlbky0zSU6IgZkAYAHvWX3IrY14LXrpS/dHIHT3SN6Vl
         nOzJWRJpdmurdxYM3sO6Mr7Ndo5qlnPMAEIZcjWgg7YxhGrKK5ymp2HkxU1pJChfIe
         1gOq6WMR0+7vnM78DS1+gp3E/ehMmeo//uouFbUGEdsXAJx7LvOBUF5q/LZTHSngpS
         jdps5qhMB1HGsJgLHs4d7tSq5Pa63rQVhYgjYBr5cVtRuPqTvwKn6l3Zg2kw0ciJXF
         6VGEcMAMuiRhUgLN59eMAPomyCoYcKW6Hv+t4savcjbNBrFB3Em9Pc6MU4TcVVPuti
         qv1IzAd/rH19A==
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        kasan-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/3] memblock: cleanup memblock_free interface
Date:   Thu, 23 Sep 2021 10:43:35 +0300
Message-Id: <20210923074335.12583-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210923074335.12583-1-rppt@kernel.org>
References: <20210923074335.12583-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

For ages memblock_free() interface dealt with physical addresses even
despite the existence of memblock_alloc_xx() functions that return a
virtual pointer.

Introduce memblock_phys_free() for freeing physical ranges and repurpose
memblock_free() to free virtual pointers to make the following pairing
abundantly clear:

	int memblock_phys_free(phys_addr_t base, phys_addr_t size);
	phys_addr_t memblock_phys_alloc(phys_addr_t base, phys_addr_t size);

	void *memblock_alloc(phys_addr_t size, phys_addr_t align);
	void memblock_free(void *ptr, size_t size);

Replace intermediate memblock_free_ptr() with memblock_free() and drop
unnecessary aliases memblock_free_early() and memblock_free_early_nid().

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/kernel/core_irongate.c         |  2 +-
 arch/arc/mm/init.c                        |  2 +-
 arch/arm/mach-hisi/platmcpm.c             |  2 +-
 arch/arm/mm/init.c                        |  2 +-
 arch/arm64/mm/mmu.c                       |  4 ++--
 arch/mips/mm/init.c                       |  2 +-
 arch/mips/sgi-ip30/ip30-setup.c           |  6 +++---
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  2 +-
 arch/powerpc/kernel/paca.c                |  4 ++--
 arch/powerpc/kernel/setup-common.c        |  2 +-
 arch/powerpc/kernel/setup_64.c            |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  2 +-
 arch/powerpc/platforms/pseries/svm.c      |  4 +---
 arch/riscv/kernel/setup.c                 |  4 ++--
 arch/s390/kernel/setup.c                  |  8 ++++----
 arch/s390/kernel/smp.c                    |  4 ++--
 arch/s390/kernel/uv.c                     |  2 +-
 arch/s390/mm/kasan_init.c                 |  2 +-
 arch/sh/boards/mach-ap325rxa/setup.c      |  2 +-
 arch/sh/boards/mach-ecovec24/setup.c      |  4 ++--
 arch/sh/boards/mach-kfr2r09/setup.c       |  2 +-
 arch/sh/boards/mach-migor/setup.c         |  2 +-
 arch/sh/boards/mach-se/7724/setup.c       |  4 ++--
 arch/sparc/kernel/smp_64.c                |  2 +-
 arch/um/kernel/mem.c                      |  2 +-
 arch/x86/kernel/setup.c                   |  4 ++--
 arch/x86/kernel/setup_percpu.c            |  2 +-
 arch/x86/mm/init.c                        |  2 +-
 arch/x86/mm/kasan_init_64.c               |  4 ++--
 arch/x86/mm/numa.c                        |  2 +-
 arch/x86/mm/numa_emulation.c              |  2 +-
 arch/x86/xen/mmu_pv.c                     |  6 +++---
 arch/x86/xen/p2m.c                        |  2 +-
 arch/x86/xen/setup.c                      |  6 +++---
 drivers/base/arch_numa.c                  |  4 ++--
 drivers/firmware/efi/memmap.c             |  2 +-
 drivers/macintosh/smu.c                   |  2 +-
 drivers/of/kexec.c                        |  2 +-
 drivers/of/of_reserved_mem.c              |  4 ++--
 drivers/s390/char/sclp_early.c            |  2 +-
 drivers/usb/early/xhci-dbc.c              | 10 +++++-----
 drivers/xen/swiotlb-xen.c                 |  2 +-
 include/linux/memblock.h                  | 16 ++--------------
 init/initramfs.c                          |  2 +-
 init/main.c                               |  2 +-
 kernel/dma/swiotlb.c                      |  2 +-
 kernel/printk/printk.c                    |  4 ++--
 lib/bootconfig.c                          |  2 +-
 lib/cpumask.c                             |  2 +-
 mm/cma.c                                  |  2 +-
 mm/memblock.c                             | 20 ++++++++++----------
 mm/memory_hotplug.c                       |  2 +-
 mm/percpu.c                               |  8 ++++----
 mm/sparse.c                               |  2 +-
 tools/bootconfig/include/linux/memblock.h |  2 +-
 55 files changed, 92 insertions(+), 106 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 72af1e72d833..6b8ed12936b6 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -233,7 +233,7 @@ albacore_init_arch(void)
 			unsigned long size;
 
 			size = initrd_end - initrd_start;
-			memblock_free(__pa(initrd_start), PAGE_ALIGN(size));
+			memblock_free((void *)initrd_start, PAGE_ALIGN(size));
 			if (!move_initrd(pci_mem))
 				printk("irongate_init_arch: initrd too big "
 				       "(%ldK)\ndisabling initrd\n",
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 699ecf119641..59408f6a02d4 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -173,7 +173,7 @@ static void __init highmem_init(void)
 #ifdef CONFIG_HIGHMEM
 	unsigned long tmp;
 
-	memblock_free(high_mem_start, high_mem_sz);
+	memblock_phys_free(high_mem_start, high_mem_sz);
 	for (tmp = min_high_pfn; tmp < max_high_pfn; tmp++)
 		free_highmem_page(pfn_to_page(tmp));
 #endif
diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index 96a484095194..258586e31333 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -339,7 +339,7 @@ static int __init hip04_smp_init(void)
 err_sysctrl:
 	iounmap(relocation);
 err_reloc:
-	memblock_free(hip04_boot_method[0], hip04_boot_method[1]);
+	memblock_phys_free(hip04_boot_method[0], hip04_boot_method[1]);
 err:
 	return ret;
 }
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 6162a070a410..6d0cb0f7bc54 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -158,7 +158,7 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 		panic("Failed to steal %pa bytes at %pS\n",
 		      &size, (void *)_RET_IP_);
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 
 	return phys;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cfd9deb347c3..f68c2d953617 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -738,8 +738,8 @@ void __init paging_init(void)
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 	init_mm.pgd = swapper_pg_dir;
 
-	memblock_free(__pa_symbol(init_pg_dir),
-		      __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
+	memblock_phys_free(__pa_symbol(init_pg_dir),
+			   __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
 
 	memblock_allow_resize();
 }
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 19347dc6bbf8..325e1552cbea 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -529,7 +529,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free_early(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/arch/mips/sgi-ip30/ip30-setup.c b/arch/mips/sgi-ip30/ip30-setup.c
index 44b1607e964d..75a34684e704 100644
--- a/arch/mips/sgi-ip30/ip30-setup.c
+++ b/arch/mips/sgi-ip30/ip30-setup.c
@@ -69,10 +69,10 @@ static void __init ip30_mem_init(void)
 		total_mem += size;
 
 		if (addr >= IP30_REAL_MEMORY_START)
-			memblock_free(addr, size);
+			memblock_phys_free(addr, size);
 		else if ((addr + size) > IP30_REAL_MEMORY_START)
-			memblock_free(IP30_REAL_MEMORY_START,
-				     size - IP30_MAX_PROM_MEMORY);
+			memblock_phys_free(IP30_REAL_MEMORY_START,
+					   size - IP30_MAX_PROM_MEMORY);
 	}
 	pr_info("Detected %luMB of physical memory.\n", MEM_SHIFT(total_mem));
 }
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 358aee7c2d79..705757f1a809 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -1095,7 +1095,7 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 
 	cpufeatures_setup_finished();
 
-	memblock_free(__pa(dt_cpu_features),
+	memblock_free(dt_cpu_features,
 			sizeof(struct dt_cpu_feature)*nr_dt_cpu_features);
 
 	return 0;
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 9bd30cac852b..4e3bde0e0679 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -322,7 +322,7 @@ void __init free_unused_pacas(void)
 
 	new_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
 	if (new_ptrs_size < paca_ptrs_size)
-		memblock_free(__pa(paca_ptrs) + new_ptrs_size,
+		memblock_free(paca_ptrs + new_ptrs_size,
 					paca_ptrs_size - new_ptrs_size);
 
 	paca_nr_cpu_ids = nr_cpu_ids;
@@ -331,7 +331,7 @@ void __init free_unused_pacas(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (early_radix_enabled()) {
 		/* Ugly fixup, see new_slb_shadow() */
-		memblock_free(__pa(paca_ptrs[boot_cpuid]->slb_shadow_ptr),
+		memblock_free(paca_ptrs[boot_cpuid]->slb_shadow_ptr,
 				sizeof(struct slb_shadow));
 		paca_ptrs[boot_cpuid]->slb_shadow_ptr = NULL;
 	}
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1e43b69a559..6b1338db8779 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -825,7 +825,7 @@ static void __init smp_setup_pacas(void)
 		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
 	}
 
-	memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
+	memblock_free(cpu_to_phys_id, nr_cpu_ids * sizeof(u32));
 	cpu_to_phys_id = NULL;
 }
 #endif
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index eaa79a0996d1..1777e992b20b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -812,7 +812,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 
 static void __init pcpu_free_bootmem(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 static int pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3dd35c327d1c..004cd6a96c8a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2981,7 +2981,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (!phb->hose) {
 		pr_err("  Can't allocate PCI controller for %pOF\n",
 		       np);
-		memblock_free(__pa(phb), sizeof(struct pnv_phb));
+		memblock_free(phb, sizeof(struct pnv_phb));
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 87f001b4c4e4..aa79a96a2749 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -55,9 +55,7 @@ void __init svm_swiotlb_init(void)
 	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, false))
 		return;
 
-
-	memblock_free_early(__pa(vstart),
-			    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	memblock_free(vstart, PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	panic("SVM: Cannot allocate SWIOTLB buffer");
 }
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b9620e5f00ba..b42bfdc67482 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -230,13 +230,13 @@ static void __init init_resources(void)
 
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
-		memblock_free(__pa(mem_res), (res_idx + 1) * sizeof(*mem_res));
+		memblock_free(mem_res, (res_idx + 1) * sizeof(*mem_res));
 	return;
 
  error:
 	/* Better an empty resource tree than an inconsistent one */
 	release_child_resources(&iomem_resource);
-	memblock_free(__pa(mem_res), mem_res_sz);
+	memblock_free(mem_res, mem_res_sz);
 }
 
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 67e5fff96ee0..d09895bc66cc 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -693,7 +693,7 @@ static void __init reserve_crashkernel(void)
 	}
 
 	if (register_memory_notifier(&kdump_mem_nb)) {
-		memblock_free(crash_base, crash_size);
+		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
 
@@ -748,7 +748,7 @@ static void __init free_mem_detect_info(void)
 
 	get_mem_detect_reserved(&start, &size);
 	if (size)
-		memblock_free(start, size);
+		memblock_phys_free(start, size);
 }
 
 static const char * __init get_mem_info_source(void)
@@ -793,7 +793,7 @@ static void __init check_initrd(void)
 	if (initrd_data.start && initrd_data.size &&
 	    !memblock_is_region_memory(initrd_data.start, initrd_data.size)) {
 		pr_err("The initial RAM disk does not fit into the memory\n");
-		memblock_free(initrd_data.start, initrd_data.size);
+		memblock_phys_free(initrd_data.start, initrd_data.size);
 		initrd_start = initrd_end = 0;
 	}
 #endif
@@ -890,7 +890,7 @@ static void __init setup_randomness(void)
 
 	if (stsi(vmms, 3, 2, 2) == 0 && vmms->count)
 		add_device_randomness(&vmms->vm, sizeof(vmms->vm[0]) * vmms->count);
-	memblock_free((unsigned long) vmms, PAGE_SIZE);
+	memblock_phys_free((unsigned long) vmms, PAGE_SIZE);
 }
 
 /*
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 1a04e5bdf655..37826d8c4f74 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -723,7 +723,7 @@ void __init smp_save_dump_cpus(void)
 			/* Get the CPU registers */
 			smp_save_cpu_regs(sa, addr, is_boot_cpu, page);
 	}
-	memblock_free(page, PAGE_SIZE);
+	memblock_phys_free(page, PAGE_SIZE);
 	diag_amode31_ops.diag308_reset();
 	pcpu_set_smt(0);
 }
@@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
 
 	/* Add CPUs present at boot */
 	__smp_rescan_cpus(info, true);
-	memblock_free_early((unsigned long)info, sizeof(*info));
+	memblock_free(info, sizeof(*info));
 }
 
 /*
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 5a656c7b7a67..d57457b16fe5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -64,7 +64,7 @@ void __init setup_uv(void)
 	}
 
 	if (uv_init(uv_stor_base, uv_info.uv_base_stor_len)) {
-		memblock_free(uv_stor_base, uv_info.uv_base_stor_len);
+		memblock_phys_free(uv_stor_base, uv_info.uv_base_stor_len);
 		goto fail;
 	}
 
diff --git a/arch/s390/mm/kasan_init.c b/arch/s390/mm/kasan_init.c
index 3e4735168019..483b9dbe0970 100644
--- a/arch/s390/mm/kasan_init.c
+++ b/arch/s390/mm/kasan_init.c
@@ -399,5 +399,5 @@ void __init kasan_copy_shadow_mapping(void)
 
 void __init kasan_free_early_identity(void)
 {
-	memblock_free(pgalloc_pos, pgalloc_freeable - pgalloc_pos);
+	memblock_phys_free(pgalloc_pos, pgalloc_freeable - pgalloc_pos);
 }
diff --git a/arch/sh/boards/mach-ap325rxa/setup.c b/arch/sh/boards/mach-ap325rxa/setup.c
index bac8a058ebd7..c77b5f00a66a 100644
--- a/arch/sh/boards/mach-ap325rxa/setup.c
+++ b/arch/sh/boards/mach-ap325rxa/setup.c
@@ -560,7 +560,7 @@ static void __init ap325rxa_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 
 	ceu_dma_membase = phys;
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index bab91a99124e..2b22ce792147 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1502,7 +1502,7 @@ static void __init ecovec_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU0 memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
@@ -1510,7 +1510,7 @@ static void __init ecovec_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU1 memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
 }
diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index eeb5ce341efd..20f4db778ed6 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -633,7 +633,7 @@ static void __init kfr2r09_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 
 	ceu_dma_membase = phys;
diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 6703a2122c0d..f60061283c48 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -633,7 +633,7 @@ static void __init migor_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 
 	ceu_dma_membase = phys;
diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 8d6541ba0186..8bbf5a6aa423 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -966,7 +966,7 @@ static void __init ms7724se_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU0 memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 	ceu0_dma_membase = phys;
 
@@ -974,7 +974,7 @@ static void __init ms7724se_mv_mem_reserve(void)
 	if (!phys)
 		panic("Failed to allocate CEU1 memory\n");
 
-	memblock_free(phys, size);
+	memblock_phys_free(phys, size);
 	memblock_remove(phys, size);
 	ceu1_dma_membase = phys;
 }
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 0224d8f19ed6..b98a7bbe6728 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1567,7 +1567,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 
 static void __init pcpu_free_bootmem(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8e636ce02949..0039771eb01c 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -47,7 +47,7 @@ void __init mem_init(void)
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
-	memblock_free(__pa(brk_end), uml_reserved - brk_end);
+	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
 	/* this will put all low memory onto the freelists */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 79f164141116..1bbe9b6173ef 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -322,7 +322,7 @@ static void __init reserve_initrd(void)
 
 	relocate_initrd();
 
-	memblock_free(ramdisk_image, ramdisk_end - ramdisk_image);
+	memblock_phys_free(ramdisk_image, ramdisk_end - ramdisk_image);
 }
 
 #else
@@ -521,7 +521,7 @@ static void __init reserve_crashkernel(void)
 	}
 
 	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-		memblock_free(crash_base, crash_size);
+		memblock_phys_free(crash_base, crash_size);
 		return;
 	}
 
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index 5afd98559193..7b65275544b2 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -135,7 +135,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size, size_t align)
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free_ptr(ptr, size);
+	memblock_free(ptr, size);
 }
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 23a14d82e783..1895986842b9 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -618,7 +618,7 @@ static void __init memory_map_top_down(unsigned long map_start,
 	 */
 	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
 					 map_end);
-	memblock_free(addr, PMD_SIZE);
+	memblock_phys_free(addr, PMD_SIZE);
 	real_end = addr + PMD_SIZE;
 
 	/* step_size need to be small so pgt_buf from BRK could cover it */
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index ef885370719a..e7b9b464a82f 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -49,7 +49,7 @@ static void __init kasan_populate_pmd(pmd_t *pmd, unsigned long addr,
 			p = early_alloc(PMD_SIZE, nid, false);
 			if (p && pmd_set_huge(pmd, __pa(p), PAGE_KERNEL))
 				return;
-			memblock_free_ptr(p, PMD_SIZE);
+			memblock_free(p, PMD_SIZE);
 		}
 
 		p = early_alloc(PAGE_SIZE, nid, true);
@@ -85,7 +85,7 @@ static void __init kasan_populate_pud(pud_t *pud, unsigned long addr,
 			p = early_alloc(PUD_SIZE, nid, false);
 			if (p && pud_set_huge(pud, __pa(p), PAGE_KERNEL))
 				return;
-			memblock_free_ptr(p, PUD_SIZE);
+			memblock_free(p, PUD_SIZE);
 		}
 
 		p = early_alloc(PAGE_SIZE, nid, true);
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1e9b93b088db..c6b1213086d6 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -355,7 +355,7 @@ void __init numa_reset_distance(void)
 
 	/* numa_distance could be 1LU marking allocation failure, test cnt */
 	if (numa_distance_cnt)
-		memblock_free_ptr(numa_distance, size);
+		memblock_free(numa_distance, size);
 	numa_distance_cnt = 0;
 	numa_distance = NULL;	/* enable table creation */
 }
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index e801e30089c4..1a02b791d273 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -517,7 +517,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 	}
 
 	/* free the copied physical distance table */
-	memblock_free_ptr(phys_dist, phys_size);
+	memblock_free(phys_dist, phys_size);
 	return;
 
 no_emu:
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 8d751939c6f3..0c831ad78933 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1025,7 +1025,7 @@ static void __init xen_free_ro_pages(unsigned long paddr, unsigned long size)
 	for (; vaddr < vaddr_end; vaddr += PAGE_SIZE)
 		make_lowmem_page_readwrite(vaddr);
 
-	memblock_free(paddr, size);
+	memblock_phys_free(paddr, size);
 }
 
 static void __init xen_cleanmfnmap_free_pgtbl(void *pgtbl, bool unpin)
@@ -1151,7 +1151,7 @@ static void __init xen_pagetable_p2m_free(void)
 		xen_cleanhighmap(addr, addr + size);
 		size = PAGE_ALIGN(xen_start_info->nr_pages *
 				  sizeof(unsigned long));
-		memblock_free(__pa(addr), size);
+		memblock_free((void *)addr, size);
 	} else {
 		xen_cleanmfnmap(addr);
 	}
@@ -1955,7 +1955,7 @@ void __init xen_relocate_p2m(void)
 		pfn_end = p2m_pfn_end;
 	}
 
-	memblock_free(PFN_PHYS(pfn), PAGE_SIZE * (pfn_end - pfn));
+	memblock_phys_free(PFN_PHYS(pfn), PAGE_SIZE * (pfn_end - pfn));
 	while (pfn < pfn_end) {
 		if (pfn == p2m_pfn) {
 			pfn = p2m_pfn_end;
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 141bb9dbd2fb..58db86f7b384 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -197,7 +197,7 @@ static void * __ref alloc_p2m_page(void)
 static void __ref free_p2m_page(void *p)
 {
 	if (unlikely(!slab_is_available())) {
-		memblock_free_ptr(p, PAGE_SIZE);
+		memblock_free(p, PAGE_SIZE);
 		return;
 	}
 
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 8bfc10330107..f387fc7e5250 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -153,7 +153,7 @@ static void __init xen_del_extra_mem(unsigned long start_pfn,
 			break;
 		}
 	}
-	memblock_free(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
+	memblock_phys_free(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
 }
 
 /*
@@ -719,7 +719,7 @@ static void __init xen_reserve_xen_mfnlist(void)
 		return;
 
 	xen_relocate_p2m();
-	memblock_free(start, size);
+	memblock_phys_free(start, size);
 }
 
 /**
@@ -885,7 +885,7 @@ char * __init xen_memory_setup(void)
 		xen_phys_memcpy(new_area, start, size);
 		pr_info("initrd moved from [mem %#010llx-%#010llx] to [mem %#010llx-%#010llx]\n",
 			start, start + size, new_area, new_area + size);
-		memblock_free(start, size);
+		memblock_phys_free(start, size);
 		boot_params.hdr.ramdisk_image = new_area;
 		boot_params.ext_ramdisk_image = new_area >> 32;
 	}
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index f6d0efd01188..cad34cec3acc 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -165,7 +165,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free_early(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 void __init setup_per_cpu_areas(void)
@@ -264,7 +264,7 @@ void __init numa_free_distance(void)
 	size = numa_distance_cnt * numa_distance_cnt *
 		sizeof(numa_distance[0]);
 
-	memblock_free_ptr(numa_distance, size);
+	memblock_free(numa_distance, size);
 	numa_distance_cnt = 0;
 	numa_distance = NULL;
 }
diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
index 2ff1883dc788..4df55a55da84 100644
--- a/drivers/firmware/efi/memmap.c
+++ b/drivers/firmware/efi/memmap.c
@@ -35,7 +35,7 @@ void __init __efi_memmap_free(u64 phys, unsigned long size, unsigned long flags)
 		if (slab_is_available())
 			memblock_free_late(phys, size);
 		else
-			memblock_free(phys, size);
+			memblock_phys_free(phys, size);
 	} else if (flags & EFI_MEMMAP_SLAB) {
 		struct page *p = pfn_to_page(PHYS_PFN(phys));
 		unsigned int order = get_order(size);
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index fe63d5ee201b..f62152111236 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -570,7 +570,7 @@ int __init smu_init (void)
 fail_db_node:
 	of_node_put(smu->db_node);
 fail_bootmem:
-	memblock_free_ptr(smu, sizeof(struct smu_device));
+	memblock_free(smu, sizeof(struct smu_device));
 	smu = NULL;
 fail_np:
 	of_node_put(np);
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 761fd870d1db..8d07f73a4389 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -170,7 +170,7 @@ int ima_free_kexec_buffer(void)
 	if (ret)
 		return ret;
 
-	return memblock_free(addr, size);
+	return memblock_phys_free(addr, size);
 
 }
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 59c1390cdf42..c48d0dce13eb 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -45,7 +45,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	if (nomap) {
 		err = memblock_mark_nomap(base, size);
 		if (err)
-			memblock_free(base, size);
+			memblock_phys_free(base, size);
 	}
 
 	return err;
@@ -282,7 +282,7 @@ void __init fdt_init_reserved_mem(void)
 				if (nomap)
 					memblock_clear_nomap(rmem->base, rmem->size);
 				else
-					memblock_free(rmem->base, rmem->size);
+					memblock_phys_free(rmem->base, rmem->size);
 			}
 		}
 	}
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index f3d5c7f4c13d..98247a4a64b7 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -139,7 +139,7 @@ int __init sclp_early_get_core_info(struct sclp_core_info *info)
 	}
 	sclp_fill_core_info(info, sccb);
 out:
-	memblock_free_early((unsigned long)sccb, length);
+	memblock_free(sccb, length);
 	return rc;
 }
 
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index be4ecbabdd58..933d77ad0a64 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -185,7 +185,7 @@ static void __init xdbc_free_ring(struct xdbc_ring *ring)
 	if (!seg)
 		return;
 
-	memblock_free(seg->dma, PAGE_SIZE);
+	memblock_phys_free(seg->dma, PAGE_SIZE);
 	ring->segment = NULL;
 }
 
@@ -665,10 +665,10 @@ int __init early_xdbc_setup_hardware(void)
 		xdbc_free_ring(&xdbc.in_ring);
 
 		if (xdbc.table_dma)
-			memblock_free(xdbc.table_dma, PAGE_SIZE);
+			memblock_phys_free(xdbc.table_dma, PAGE_SIZE);
 
 		if (xdbc.out_dma)
-			memblock_free(xdbc.out_dma, PAGE_SIZE);
+			memblock_phys_free(xdbc.out_dma, PAGE_SIZE);
 
 		xdbc.table_base = NULL;
 		xdbc.out_buf = NULL;
@@ -987,8 +987,8 @@ static int __init xdbc_init(void)
 	xdbc_free_ring(&xdbc.evt_ring);
 	xdbc_free_ring(&xdbc.out_ring);
 	xdbc_free_ring(&xdbc.in_ring);
-	memblock_free(xdbc.table_dma, PAGE_SIZE);
-	memblock_free(xdbc.out_dma, PAGE_SIZE);
+	memblock_phys_free(xdbc.table_dma, PAGE_SIZE);
+	memblock_phys_free(xdbc.out_dma, PAGE_SIZE);
 	writel(0, &xdbc.xdbc_reg->control);
 	early_iounmap(xdbc.xhci_base, xdbc.xhci_length);
 
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 8c10edf9efe6..bad266ea3bcd 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -240,7 +240,7 @@ void __init xen_swiotlb_init_early(void)
 	 */
 	rc = xen_swiotlb_fixup(start, nslabs);
 	if (rc) {
-		memblock_free(__pa(start), PAGE_ALIGN(bytes));
+		memblock_free(start, PAGE_ALIGN(bytes));
 		if (nslabs > 1024 && repeat--) {
 			/* Min is 2MB */
 			nslabs = max(1024UL, ALIGN(nslabs >> 1, IO_TLB_SEGSIZE));
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 34de69b3b8ba..e1f73b81d595 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -103,7 +103,7 @@ void memblock_allow_resize(void);
 int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
-int memblock_free(phys_addr_t base, phys_addr_t size);
+int memblock_phys_free(phys_addr_t base, phys_addr_t size);
 int memblock_reserve(phys_addr_t base, phys_addr_t size);
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
@@ -117,8 +117,8 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 
+void memblock_free(void *ptr, size_t size);
 void memblock_free_all(void);
-void memblock_free_ptr(void *ptr, size_t size);
 void reset_node_managed_pages(pg_data_t *pgdat);
 void reset_all_zones_managed_pages(void);
 
@@ -441,18 +441,6 @@ static inline void *memblock_alloc_node(phys_addr_t size,
 				      MEMBLOCK_ALLOC_ACCESSIBLE, nid);
 }
 
-static inline void memblock_free_early(phys_addr_t base,
-					      phys_addr_t size)
-{
-	memblock_free(base, size);
-}
-
-static inline void memblock_free_early_nid(phys_addr_t base,
-						  phys_addr_t size, int nid)
-{
-	memblock_free(base, size);
-}
-
 static inline void memblock_free_late(phys_addr_t base, phys_addr_t size)
 {
 	__memblock_free_late(base, size);
diff --git a/init/initramfs.c b/init/initramfs.c
index a842c0544745..c48748217c28 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -607,7 +607,7 @@ void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
 	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
 
-	memblock_free(__pa(aligned_start), aligned_end - aligned_start);
+	memblock_free((void*)aligned_start, aligned_end - aligned_start);
 #endif
 
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
diff --git a/init/main.c b/init/main.c
index 3f7216934441..a0714600a83f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -924,7 +924,7 @@ static void __init print_unknown_bootoptions(void)
 		end += sprintf(end, " %s", *p);
 
 	pr_notice("Unknown command line parameters:%s\n", unknown_options);
-	memblock_free_ptr(unknown_options, len);
+	memblock_free(unknown_options, len);
 }
 
 asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87c40517e822..02656d7ccbfd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -247,7 +247,7 @@ swiotlb_init(int verbose)
 	return;
 
 fail_free_mem:
-	memblock_free_early(__pa(tlb), bytes);
+	memblock_free(tlb, bytes);
 fail:
 	pr_warn("Cannot allocate buffer");
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a8d0a58deebc..2cae1bfa6be7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1166,9 +1166,9 @@ void __init setup_log_buf(int early)
 	return;
 
 err_free_descs:
-	memblock_free_ptr(new_descs, new_descs_size);
+	memblock_free(new_descs, new_descs_size);
 err_free_log_buf:
-	memblock_free_ptr(new_log_buf, new_log_buf_len);
+	memblock_free(new_log_buf, new_log_buf_len);
 }
 
 static bool __read_mostly ignore_loglevel;
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 5ae248b29373..547558d80e64 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -792,7 +792,7 @@ void __init xbc_destroy_all(void)
 	xbc_data = NULL;
 	xbc_data_size = 0;
 	xbc_node_num = 0;
-	memblock_free_ptr(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
+	memblock_free(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
 	brace_index = 0;
 }
diff --git a/lib/cpumask.c b/lib/cpumask.c
index c3c76b833384..a971a82d2f43 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -188,7 +188,7 @@ EXPORT_SYMBOL(free_cpumask_var);
  */
 void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 {
-	memblock_free_early(__pa(mask), cpumask_size());
+	memblock_free(mask, cpumask_size());
 }
 #endif
 
diff --git a/mm/cma.c b/mm/cma.c
index 995e15480937..f9a53bc708f2 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -378,7 +378,7 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	return 0;
 
 free_mem:
-	memblock_free(base, size);
+	memblock_phys_free(base, size);
 err:
 	pr_err("Failed to reserve %ld MiB\n", (unsigned long)size / SZ_1M);
 	return ret;
diff --git a/mm/memblock.c b/mm/memblock.c
index 184dcd2e5d99..affcfdda0ff8 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -472,7 +472,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 		kfree(old_array);
 	else if (old_array != memblock_memory_init_regions &&
 		 old_array != memblock_reserved_init_regions)
-		memblock_free_ptr(old_array, old_alloc_size);
+		memblock_free(old_array, old_alloc_size);
 
 	/*
 	 * Reserve the new array if that comes from the memblock.  Otherwise, we
@@ -796,28 +796,28 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 }
 
 /**
- * memblock_free_ptr - free boot memory allocation
- * @ptr: starting address of the  boot memory allocation
+ * memblock_free - free boot memory allocation
+ * @ptr: starting *virtual* address of the  boot memory allocation
  * @size: size of the boot memory block in bytes
  *
  * Free boot memory block previously allocated by memblock_alloc_xx() API.
  * The freeing memory will not be released to the buddy allocator.
  */
-void __init_memblock memblock_free_ptr(void *ptr, size_t size)
+void __init_memblock memblock_free(void *ptr, size_t size)
 {
 	if (ptr)
-		memblock_free(__pa(ptr), size);
+		memblock_phys_free(__pa(ptr), size);
 }
 
 /**
- * memblock_free - free boot memory block
- * @base: phys starting address of the  boot memory block
+ * memblock_free_phys - free boot memory block
+ * @base: starting *physical* address of the  boot memory block
  * @size: size of the boot memory block in bytes
  *
- * Free boot memory block previously allocated by memblock_alloc_xx() API.
+ * Free boot memory block previously allocated by memblock_phys_alloc_xx() API.
  * The freeing memory will not be released to the buddy allocator.
  */
-int __init_memblock memblock_free(phys_addr_t base, phys_addr_t size)
+int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
 
@@ -1934,7 +1934,7 @@ static void __init free_memmap(unsigned long start_pfn, unsigned long end_pfn)
 	 * memmap array.
 	 */
 	if (pg < pgend)
-		memblock_free(pg, pgend - pg);
+		memblock_phys_free(pg, pgend - pg);
 }
 
 /*
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9fd0be32a281..feffaa9423fe 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -2204,7 +2204,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
 	arch_remove_memory(start, size, altmap);
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
-		memblock_free(start, size);
+		memblock_phys_free(start, size);
 		memblock_remove(start, size);
 	}
 
diff --git a/mm/percpu.c b/mm/percpu.c
index e0a986818903..f5b2c2ea5a54 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2472,7 +2472,7 @@ struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
  */
 void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai)
 {
-	memblock_free_early(__pa(ai), ai->__ai_size);
+	memblock_free(ai, ai->__ai_size);
 }
 
 /**
@@ -3134,7 +3134,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 out_free:
 	pcpu_free_alloc_info(ai);
 	if (areas)
-		memblock_free_early(__pa(areas), areas_size);
+		memblock_free(areas, areas_size);
 	return rc;
 }
 #endif /* BUILD_EMBED_FIRST_CHUNK */
@@ -3256,7 +3256,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		free_fn(page_address(pages[j]), PAGE_SIZE);
 	rc = -ENOMEM;
 out_free_ar:
-	memblock_free_early(__pa(pages), pages_size);
+	memblock_free(pages, pages_size);
 	pcpu_free_alloc_info(ai);
 	return rc;
 }
@@ -3286,7 +3286,7 @@ static void * __init pcpu_dfl_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_dfl_fc_free(void *ptr, size_t size)
 {
-	memblock_free_early(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/mm/sparse.c b/mm/sparse.c
index 120bc8ea5293..e5c84b0cf0c9 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -451,7 +451,7 @@ static void *sparsemap_buf_end __meminitdata;
 static inline void __meminit sparse_buffer_free(unsigned long size)
 {
 	WARN_ON(!sparsemap_buf || size == 0);
-	memblock_free_early(__pa(sparsemap_buf), size);
+	memblock_free(sparsemap_buf, size);
 }
 
 static void __init sparse_buffer_init(unsigned long size, int nid)
diff --git a/tools/bootconfig/include/linux/memblock.h b/tools/bootconfig/include/linux/memblock.h
index f2e506f7d57f..e6ea42e97b22 100644
--- a/tools/bootconfig/include/linux/memblock.h
+++ b/tools/bootconfig/include/linux/memblock.h
@@ -6,6 +6,6 @@
 
 #define SMP_CACHE_BYTES	0
 #define memblock_alloc(size, align)	malloc(size)
-#define memblock_free_ptr(paddr, size)	free(paddr)
+#define memblock_free(paddr, size)	free(paddr)
 
 #endif
-- 
2.28.0

