Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F36641E1B1
	for <lists+linux-efi@lfdr.de>; Thu, 30 Sep 2021 20:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbhI3Sxe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Sep 2021 14:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345600AbhI3SxA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Sep 2021 14:53:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F2C1613CE;
        Thu, 30 Sep 2021 18:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633027877;
        bh=vvw/CX97uJRYq4lw4+eUMmguzmclRo38E917kdICwSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqsrMZIj1zkE+0A9Ivwfz/cRiqIG1V7tATijS22rkmV6/NeZl7eVMUO2JvPZO7tex
         kgV2n0FgnpGGuyEmDPWjDVT1XdopqBt/42N0NbSVzKv9hj5RDfZMVZNhbAVQST7+oB
         3+hRfHC1RZWtlQn9nTBMXWNFg1vQNd2BoPzrbIZpUdZXXBTxrLQ1JkeWLJstltMXAs
         dCnr8bwBvWL/vJLjYcVcwORnAqedFR90VvQPxGnwzpD67NyULUJbfjmvKfcCQo54eB
         gJsCrX0oPS8F5J+BYjZi9RrczVTMx9rjSEGzFA45vmX8uYaD2/vz4OXp0YzzlUnrx2
         GyiE8thi4nLMA==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        kasan-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH v2 5/6] memblock: rename memblock_free to memblock_phys_free
Date:   Thu, 30 Sep 2021 21:50:30 +0300
Message-Id: <20210930185031.18648-6-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210930185031.18648-1-rppt@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Since memblock_free() operates on a physical range, make its name reflect
it and rename it to memblock_phys_free(), so it will be a logical
counterpart to memblock_phys_alloc().

The callers are updated with the below semantic patch:

@@
expression addr;
expression size;
@@
- memblock_free(addr, size);
+ memblock_phys_free(addr, size);

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/kernel/core_irongate.c         |  3 ++-
 arch/arc/mm/init.c                        |  2 +-
 arch/arm/mach-hisi/platmcpm.c             |  2 +-
 arch/arm/mm/init.c                        |  2 +-
 arch/arm64/mm/mmu.c                       |  4 ++--
 arch/mips/mm/init.c                       |  2 +-
 arch/mips/sgi-ip30/ip30-setup.c           |  6 +++---
 arch/powerpc/kernel/dt_cpu_ftrs.c         |  4 ++--
 arch/powerpc/kernel/paca.c                |  8 ++++----
 arch/powerpc/kernel/setup-common.c        |  2 +-
 arch/powerpc/kernel/setup_64.c            |  2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c |  2 +-
 arch/powerpc/platforms/pseries/svm.c      |  3 ++-
 arch/riscv/kernel/setup.c                 |  5 +++--
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
 arch/x86/mm/init.c                        |  2 +-
 arch/x86/xen/mmu_pv.c                     |  6 +++---
 arch/x86/xen/setup.c                      |  6 +++---
 drivers/base/arch_numa.c                  |  2 +-
 drivers/firmware/efi/memmap.c             |  2 +-
 drivers/of/kexec.c                        |  3 +--
 drivers/of/of_reserved_mem.c              |  5 +++--
 drivers/s390/char/sclp_early.c            |  2 +-
 drivers/usb/early/xhci-dbc.c              | 10 +++++-----
 drivers/xen/swiotlb-xen.c                 |  2 +-
 include/linux/memblock.h                  |  2 +-
 init/initramfs.c                          |  2 +-
 kernel/dma/swiotlb.c                      |  2 +-
 lib/cpumask.c                             |  2 +-
 mm/cma.c                                  |  2 +-
 mm/memblock.c                             |  8 ++++----
 mm/memory_hotplug.c                       |  2 +-
 mm/percpu.c                               |  8 ++++----
 mm/sparse.c                               |  2 +-
 45 files changed, 79 insertions(+), 76 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 72af1e72d833..ee26dcc49418 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -233,7 +233,8 @@ albacore_init_arch(void)
 			unsigned long size;
 
 			size = initrd_end - initrd_start;
-			memblock_free(__pa(initrd_start), PAGE_ALIGN(size));
+			memblock_phys_free(__pa(initrd_start),
+					   PAGE_ALIGN(size));
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
index 21a5a7ac0037..3be1c29084fa 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -529,7 +529,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_phys_free(__pa(ptr), size);
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
index 358aee7c2d79..42839d6bd486 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -1095,8 +1095,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 
 	cpufeatures_setup_finished();
 
-	memblock_free(__pa(dt_cpu_features),
-			sizeof(struct dt_cpu_feature)*nr_dt_cpu_features);
+	memblock_phys_free(__pa(dt_cpu_features),
+			   sizeof(struct dt_cpu_feature) * nr_dt_cpu_features);
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 9bd30cac852b..4208b4044d12 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -322,8 +322,8 @@ void __init free_unused_pacas(void)
 
 	new_ptrs_size = sizeof(struct paca_struct *) * nr_cpu_ids;
 	if (new_ptrs_size < paca_ptrs_size)
-		memblock_free(__pa(paca_ptrs) + new_ptrs_size,
-					paca_ptrs_size - new_ptrs_size);
+		memblock_phys_free(__pa(paca_ptrs) + new_ptrs_size,
+				   paca_ptrs_size - new_ptrs_size);
 
 	paca_nr_cpu_ids = nr_cpu_ids;
 	paca_ptrs_size = new_ptrs_size;
@@ -331,8 +331,8 @@ void __init free_unused_pacas(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (early_radix_enabled()) {
 		/* Ugly fixup, see new_slb_shadow() */
-		memblock_free(__pa(paca_ptrs[boot_cpuid]->slb_shadow_ptr),
-				sizeof(struct slb_shadow));
+		memblock_phys_free(__pa(paca_ptrs[boot_cpuid]->slb_shadow_ptr),
+				   sizeof(struct slb_shadow));
 		paca_ptrs[boot_cpuid]->slb_shadow_ptr = NULL;
 	}
 #endif
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index b1e43b69a559..5af8993a8e6d 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -825,7 +825,7 @@ static void __init smp_setup_pacas(void)
 		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
 	}
 
-	memblock_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
+	memblock_phys_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
 	cpu_to_phys_id = NULL;
 }
 #endif
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index eaa79a0996d1..75bc294ac40d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -812,7 +812,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 
 static void __init pcpu_free_bootmem(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_phys_free(__pa(ptr), size);
 }
 
 static int pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3dd35c327d1c..b5a9d343b720 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2981,7 +2981,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (!phb->hose) {
 		pr_err("  Can't allocate PCI controller for %pOF\n",
 		       np);
-		memblock_free(__pa(phb), sizeof(struct pnv_phb));
+		memblock_phys_free(__pa(phb), sizeof(struct pnv_phb));
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index f12229ce7301..b7c017bb40f7 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -56,7 +56,8 @@ void __init svm_swiotlb_init(void)
 		return;
 
 
-	memblock_free(__pa(vstart), PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	memblock_phys_free(__pa(vstart),
+			   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	panic("SVM: Cannot allocate SWIOTLB buffer");
 }
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b9620e5f00ba..6ea7c53b82cd 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -230,13 +230,14 @@ static void __init init_resources(void)
 
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
-		memblock_free(__pa(mem_res), (res_idx + 1) * sizeof(*mem_res));
+		memblock_phys_free(__pa(mem_res),
+				   (res_idx + 1) * sizeof(*mem_res));
 	return;
 
  error:
 	/* Better an empty resource tree than an inconsistent one */
 	release_child_resources(&iomem_resource);
-	memblock_free(__pa(mem_res), mem_res_sz);
+	memblock_phys_free(__pa(mem_res), mem_res_sz);
 }
 
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 67e5fff96ee0..7fc836e9e194 100644
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
+	memblock_phys_free((unsigned long)vmms, PAGE_SIZE);
 }
 
 /*
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 066efd6d9345..78a8ea6fd582 100644
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
-	memblock_free((unsigned long)info, sizeof(*info));
+	memblock_phys_free((unsigned long)info, sizeof(*info));
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
index 0224d8f19ed6..2507549538df 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1567,7 +1567,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 
 static void __init pcpu_free_bootmem(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_phys_free(__pa(ptr), size);
 }
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 8e636ce02949..d1710ebb44f4 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -47,7 +47,7 @@ void __init mem_init(void)
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
-	memblock_free(__pa(brk_end), uml_reserved - brk_end);
+	memblock_phys_free(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
 	/* this will put all low memory onto the freelists */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 40ed44ead063..49b596db5631 100644
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
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 8d751939c6f3..3500b22ff087 100644
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
+		memblock_phys_free(__pa(addr), size);
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
index e28d9dfe3c20..7974913af09c 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -165,7 +165,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_phys_free(__pa(ptr), size);
 }
 
 void __init setup_per_cpu_areas(void)
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
diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 761fd870d1db..57ad67c04dfe 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -170,8 +170,7 @@ int ima_free_kexec_buffer(void)
 	if (ret)
 		return ret;
 
-	return memblock_free(addr, size);
-
+	return memblock_phys_free(addr, size);
 }
 
 /**
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 59c1390cdf42..161c71e1e390 100644
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
@@ -282,7 +282,8 @@ void __init fdt_init_reserved_mem(void)
 				if (nomap)
 					memblock_clear_nomap(rmem->base, rmem->size);
 				else
-					memblock_free(rmem->base, rmem->size);
+					memblock_phys_free(rmem->base,
+							   rmem->size);
 			}
 		}
 	}
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index f01d942e1c1d..c0052655fc4f 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -139,7 +139,7 @@ int __init sclp_early_get_core_info(struct sclp_core_info *info)
 	}
 	sclp_fill_core_info(info, sccb);
 out:
-	memblock_free((unsigned long)sccb, length);
+	memblock_phys_free((unsigned long)sccb, length);
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
index e56a5faac395..4b671cc0a7ea 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -241,7 +241,7 @@ void __init xen_swiotlb_init_early(void)
 	 */
 	rc = xen_swiotlb_fixup(start, nslabs);
 	if (rc) {
-		memblock_free(__pa(start), PAGE_ALIGN(bytes));
+		memblock_phys_free(__pa(start), PAGE_ALIGN(bytes));
 		if (nslabs > 1024 && repeat--) {
 			/* Min is 2MB */
 			nslabs = max(1024UL, ALIGN(nslabs >> 1, IO_TLB_SEGSIZE));
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e25f964fdd60..d32d41709513 100644
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
diff --git a/init/initramfs.c b/init/initramfs.c
index a842c0544745..1a971f070dd4 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -607,7 +607,7 @@ void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
 	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
 
-	memblock_free(__pa(aligned_start), aligned_end - aligned_start);
+	memblock_phys_free(__pa(aligned_start), aligned_end - aligned_start);
 #endif
 
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 430d2f78d540..b9fa173e5e56 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -247,7 +247,7 @@ swiotlb_init(int verbose)
 	return;
 
 fail_free_mem:
-	memblock_free(__pa(tlb), bytes);
+	memblock_phys_free(__pa(tlb), bytes);
 fail:
 	pr_warn("Cannot allocate buffer");
 }
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 045779446a18..a90786b77c1c 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -188,7 +188,7 @@ EXPORT_SYMBOL(free_cpumask_var);
  */
 void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 {
-	memblock_free(__pa(mask), cpumask_size());
+	memblock_phys_free(__pa(mask), cpumask_size());
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
index 603f4a02be9b..a23baa482f3f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -806,18 +806,18 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 void __init_memblock memblock_free_ptr(void *ptr, size_t size)
 {
 	if (ptr)
-		memblock_free(__pa(ptr), size);
+		memblock_phys_free(__pa(ptr), size);
 }
 
 /**
- * memblock_free - free boot memory block
+ * memblock_phys_free - free boot memory block
  * @base: phys starting address of the  boot memory block
  * @size: size of the boot memory block in bytes
  *
  * Free boot memory block previously allocated by memblock_alloc_xx() API.
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
index f58318cb04c0..d65ddf6f2a35 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2472,7 +2472,7 @@ struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
  */
 void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai)
 {
-	memblock_free(__pa(ai), ai->__ai_size);
+	memblock_phys_free(__pa(ai), ai->__ai_size);
 }
 
 /**
@@ -3134,7 +3134,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 out_free:
 	pcpu_free_alloc_info(ai);
 	if (areas)
-		memblock_free(__pa(areas), areas_size);
+		memblock_phys_free(__pa(areas), areas_size);
 	return rc;
 }
 #endif /* BUILD_EMBED_FIRST_CHUNK */
@@ -3256,7 +3256,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		free_fn(page_address(pages[j]), PAGE_SIZE);
 	rc = -ENOMEM;
 out_free_ar:
-	memblock_free(__pa(pages), pages_size);
+	memblock_phys_free(__pa(pages), pages_size);
 	pcpu_free_alloc_info(ai);
 	return rc;
 }
@@ -3286,7 +3286,7 @@ static void * __init pcpu_dfl_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_dfl_fc_free(void *ptr, size_t size)
 {
-	memblock_free(__pa(ptr), size);
+	memblock_phys_free(__pa(ptr), size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/mm/sparse.c b/mm/sparse.c
index 55fea0c2f927..fc3ab8d3b6bc 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -451,7 +451,7 @@ static void *sparsemap_buf_end __meminitdata;
 static inline void __meminit sparse_buffer_free(unsigned long size)
 {
 	WARN_ON(!sparsemap_buf || size == 0);
-	memblock_free(__pa(sparsemap_buf), size);
+	memblock_phys_free(__pa(sparsemap_buf), size);
 }
 
 static void __init sparse_buffer_init(unsigned long size, int nid)
-- 
2.28.0

