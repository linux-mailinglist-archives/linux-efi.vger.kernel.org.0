Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124FD41E1B3
	for <lists+linux-efi@lfdr.de>; Thu, 30 Sep 2021 20:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346174AbhI3Sxf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Sep 2021 14:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346273AbhI3SxH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Sep 2021 14:53:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9D6861209;
        Thu, 30 Sep 2021 18:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633027884;
        bh=JK9jLNwOn83tFpdzsz5SWNGjwtk9QqdCPfSb8ZeVHJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bqq6vS5DF/5QPQwMSg/5caCykDp4qGu0WNz6OZuOntVpri/vaYk4DPD7qZBstqQpc
         yBKMwZVZLHzYCS4qoZ2CHcBvuvSU82Rzb1xMSbQUdJ9phkjqqi5REj6uQASji/ETA/
         lhvo4thwbHBCzfvMgpHCbChiFuLrNUKBRpS2P3wLxZhQ4PiADHmQtC5G+QBcZOAZWh
         J0qJaKhs5xHST0xaxZtmkoJ11M7yzqr9KTdWJk8m11M5+3oDPbXQGANhne9SWTYDa/
         znUyN54iw3g3seQ/KCoAhzChw/r8H2PuZS71dZ8b/Lc6wXAQ2y5oMw/SZez4Rcqqg9
         PGa760fcOAZMg==
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
Subject: [PATCH v2 6/6] memblock: use memblock_free for freeing virtual pointers
Date:   Thu, 30 Sep 2021 21:50:31 +0300
Message-Id: <20210930185031.18648-7-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210930185031.18648-1-rppt@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Rename memblock_free_ptr() to memblock_free() and use memblock_free()
when freeing a virtual pointer so that memblock_free() will be a
counterpart of memblock_alloc()

The callers are updated with the below semantic patch and manual addition
of (void *) casting to pointers that are represented by unsigned long
variables.

@@
identifier vaddr;
expression size;
@@
(
- memblock_phys_free(__pa(vaddr), size);
+ memblock_free(vaddr, size);
|
- memblock_free_ptr(vaddr, size);
+ memblock_free(vaddr, size);
)

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/alpha/kernel/core_irongate.c         | 3 +--
 arch/mips/mm/init.c                       | 2 +-
 arch/powerpc/kernel/dt_cpu_ftrs.c         | 4 ++--
 arch/powerpc/kernel/setup-common.c        | 2 +-
 arch/powerpc/kernel/setup_64.c            | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 arch/powerpc/platforms/pseries/svm.c      | 3 +--
 arch/riscv/kernel/setup.c                 | 5 ++---
 arch/sparc/kernel/smp_64.c                | 2 +-
 arch/um/kernel/mem.c                      | 2 +-
 arch/x86/kernel/setup_percpu.c            | 2 +-
 arch/x86/mm/kasan_init_64.c               | 4 ++--
 arch/x86/mm/numa.c                        | 2 +-
 arch/x86/mm/numa_emulation.c              | 2 +-
 arch/x86/xen/mmu_pv.c                     | 2 +-
 arch/x86/xen/p2m.c                        | 2 +-
 drivers/base/arch_numa.c                  | 4 ++--
 drivers/macintosh/smu.c                   | 2 +-
 drivers/xen/swiotlb-xen.c                 | 2 +-
 include/linux/memblock.h                  | 2 +-
 init/initramfs.c                          | 2 +-
 init/main.c                               | 2 +-
 kernel/dma/swiotlb.c                      | 2 +-
 kernel/printk/printk.c                    | 4 ++--
 lib/bootconfig.c                          | 2 +-
 lib/cpumask.c                             | 2 +-
 mm/memblock.c                             | 6 +++---
 mm/percpu.c                               | 8 ++++----
 mm/sparse.c                               | 2 +-
 29 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index ee26dcc49418..6b8ed12936b6 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -233,8 +233,7 @@ albacore_init_arch(void)
 			unsigned long size;
 
 			size = initrd_end - initrd_start;
-			memblock_phys_free(__pa(initrd_start),
-					   PAGE_ALIGN(size));
+			memblock_free((void *)initrd_start, PAGE_ALIGN(size));
 			if (!move_initrd(pci_mem))
 				printk("irongate_init_arch: initrd too big "
 				       "(%ldK)\ndisabling initrd\n",
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 3be1c29084fa..325e1552cbea 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -529,7 +529,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_phys_free(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 42839d6bd486..ba527fb52993 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -1095,8 +1095,8 @@ static int __init dt_cpu_ftrs_scan_callback(unsigned long node, const char
 
 	cpufeatures_setup_finished();
 
-	memblock_phys_free(__pa(dt_cpu_features),
-			   sizeof(struct dt_cpu_feature) * nr_dt_cpu_features);
+	memblock_free(dt_cpu_features,
+		      sizeof(struct dt_cpu_feature) * nr_dt_cpu_features);
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 5af8993a8e6d..6b1338db8779 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -825,7 +825,7 @@ static void __init smp_setup_pacas(void)
 		set_hard_smp_processor_id(cpu, cpu_to_phys_id[cpu]);
 	}
 
-	memblock_phys_free(__pa(cpu_to_phys_id), nr_cpu_ids * sizeof(u32));
+	memblock_free(cpu_to_phys_id, nr_cpu_ids * sizeof(u32));
 	cpu_to_phys_id = NULL;
 }
 #endif
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 75bc294ac40d..1777e992b20b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -812,7 +812,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 
 static void __init pcpu_free_bootmem(void *ptr, size_t size)
 {
-	memblock_phys_free(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 static int pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b5a9d343b720..004cd6a96c8a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2981,7 +2981,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (!phb->hose) {
 		pr_err("  Can't allocate PCI controller for %pOF\n",
 		       np);
-		memblock_phys_free(__pa(phb), sizeof(struct pnv_phb));
+		memblock_free(phb, sizeof(struct pnv_phb));
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index b7c017bb40f7..6332365d2891 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -56,8 +56,7 @@ void __init svm_swiotlb_init(void)
 		return;
 
 
-	memblock_phys_free(__pa(vstart),
-			   PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	memblock_free(vstart, PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	panic("SVM: Cannot allocate SWIOTLB buffer");
 }
 
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 6ea7c53b82cd..b42bfdc67482 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -230,14 +230,13 @@ static void __init init_resources(void)
 
 	/* Clean-up any unused pre-allocated resources */
 	if (res_idx >= 0)
-		memblock_phys_free(__pa(mem_res),
-				   (res_idx + 1) * sizeof(*mem_res));
+		memblock_free(mem_res, (res_idx + 1) * sizeof(*mem_res));
 	return;
 
  error:
 	/* Better an empty resource tree than an inconsistent one */
 	release_child_resources(&iomem_resource);
-	memblock_phys_free(__pa(mem_res), mem_res_sz);
+	memblock_free(mem_res, mem_res_sz);
 }
 
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 2507549538df..b98a7bbe6728 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1567,7 +1567,7 @@ static void * __init pcpu_alloc_bootmem(unsigned int cpu, size_t size,
 
 static void __init pcpu_free_bootmem(void *ptr, size_t size)
 {
-	memblock_phys_free(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 static int __init pcpu_cpu_distance(unsigned int from, unsigned int to)
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index d1710ebb44f4..0039771eb01c 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -47,7 +47,7 @@ void __init mem_init(void)
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
-	memblock_phys_free(__pa(brk_end), uml_reserved - brk_end);
+	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
 	/* this will put all low memory onto the freelists */
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
index 3500b22ff087..0c831ad78933 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1151,7 +1151,7 @@ static void __init xen_pagetable_p2m_free(void)
 		xen_cleanhighmap(addr, addr + size);
 		size = PAGE_ALIGN(xen_start_info->nr_pages *
 				  sizeof(unsigned long));
-		memblock_phys_free(__pa(addr), size);
+		memblock_free((void *)addr, size);
 	} else {
 		xen_cleanmfnmap(addr);
 	}
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
 
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 7974913af09c..cad34cec3acc 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -165,7 +165,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_phys_free(__pa(ptr), size);
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
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 4b671cc0a7ea..f083194e2634 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -241,7 +241,7 @@ void __init xen_swiotlb_init_early(void)
 	 */
 	rc = xen_swiotlb_fixup(start, nslabs);
 	if (rc) {
-		memblock_phys_free(__pa(start), PAGE_ALIGN(bytes));
+		memblock_free(start, PAGE_ALIGN(bytes));
 		if (nslabs > 1024 && repeat--) {
 			/* Min is 2MB */
 			nslabs = max(1024UL, ALIGN(nslabs >> 1, IO_TLB_SEGSIZE));
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d32d41709513..484650681bee 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -118,7 +118,7 @@ int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 
 void memblock_free_all(void);
-void memblock_free_ptr(void *ptr, size_t size);
+void memblock_free(void *ptr, size_t size);
 void reset_node_managed_pages(pg_data_t *pgdat);
 void reset_all_zones_managed_pages(void);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 1a971f070dd4..2f3d96dc3db6 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -607,7 +607,7 @@ void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 	unsigned long aligned_start = ALIGN_DOWN(start, PAGE_SIZE);
 	unsigned long aligned_end = ALIGN(end, PAGE_SIZE);
 
-	memblock_phys_free(__pa(aligned_start), aligned_end - aligned_start);
+	memblock_free((void *)aligned_start, aligned_end - aligned_start);
 #endif
 
 	free_reserved_area((void *)start, (void *)end, POISON_FREE_INITMEM,
diff --git a/init/main.c b/init/main.c
index 81a79a77db46..2bfcf9054f8e 100644
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
index b9fa173e5e56..02656d7ccbfd 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -247,7 +247,7 @@ swiotlb_init(int verbose)
 	return;
 
 fail_free_mem:
-	memblock_phys_free(__pa(tlb), bytes);
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
index a90786b77c1c..a971a82d2f43 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -188,7 +188,7 @@ EXPORT_SYMBOL(free_cpumask_var);
  */
 void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 {
-	memblock_phys_free(__pa(mask), cpumask_size());
+	memblock_free(mask, cpumask_size());
 }
 #endif
 
diff --git a/mm/memblock.c b/mm/memblock.c
index a23baa482f3f..3b0def459f97 100644
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
@@ -796,14 +796,14 @@ int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 }
 
 /**
- * memblock_free_ptr - free boot memory allocation
+ * memblock_free - free boot memory allocation
  * @ptr: starting address of the  boot memory allocation
  * @size: size of the boot memory block in bytes
  *
  * Free boot memory block previously allocated by memblock_alloc_xx() API.
  * The freeing memory will not be released to the buddy allocator.
  */
-void __init_memblock memblock_free_ptr(void *ptr, size_t size)
+void __init_memblock memblock_free(void *ptr, size_t size)
 {
 	if (ptr)
 		memblock_phys_free(__pa(ptr), size);
diff --git a/mm/percpu.c b/mm/percpu.c
index d65ddf6f2a35..f5b2c2ea5a54 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2472,7 +2472,7 @@ struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
  */
 void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai)
 {
-	memblock_phys_free(__pa(ai), ai->__ai_size);
+	memblock_free(ai, ai->__ai_size);
 }
 
 /**
@@ -3134,7 +3134,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 out_free:
 	pcpu_free_alloc_info(ai);
 	if (areas)
-		memblock_phys_free(__pa(areas), areas_size);
+		memblock_free(areas, areas_size);
 	return rc;
 }
 #endif /* BUILD_EMBED_FIRST_CHUNK */
@@ -3256,7 +3256,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		free_fn(page_address(pages[j]), PAGE_SIZE);
 	rc = -ENOMEM;
 out_free_ar:
-	memblock_phys_free(__pa(pages), pages_size);
+	memblock_free(pages, pages_size);
 	pcpu_free_alloc_info(ai);
 	return rc;
 }
@@ -3286,7 +3286,7 @@ static void * __init pcpu_dfl_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_dfl_fc_free(void *ptr, size_t size)
 {
-	memblock_phys_free(__pa(ptr), size);
+	memblock_free(ptr, size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/mm/sparse.c b/mm/sparse.c
index fc3ab8d3b6bc..e5c84b0cf0c9 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -451,7 +451,7 @@ static void *sparsemap_buf_end __meminitdata;
 static inline void __meminit sparse_buffer_free(unsigned long size)
 {
 	WARN_ON(!sparsemap_buf || size == 0);
-	memblock_phys_free(__pa(sparsemap_buf), size);
+	memblock_free(sparsemap_buf, size);
 }
 
 static void __init sparse_buffer_init(unsigned long size, int nid)
-- 
2.28.0

