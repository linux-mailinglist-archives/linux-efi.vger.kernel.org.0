Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1484041E18E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Sep 2021 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbhI3Sww (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Sep 2021 14:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345555AbhI3Swq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 30 Sep 2021 14:52:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89FA66135D;
        Thu, 30 Sep 2021 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633027863;
        bh=tivO3RxhX536I7wMbKedMKNTS477CjzFA9f2OsEnazU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhARG/usd0caltO5GtB0juCqz5hY7xnPMr7IDQAFGz+nbzYYJBkUHPwMW10JpfG1U
         GOjmrnB4JBMWYoWBbarrDNmo5G26FRM82TfHgLvs9xJG9DYeZ9xwwtdXHJOFYM1+zd
         broKbyPnESumKB7LYEtfnlnXQTK9RJC7LFGyyQAFNET0qbO8Ui7UyAFT3z68DsrzPC
         aSlcrogUj2KG46BRCUUxTr+2wozXgwfNdMvU4+UXXJEv8m/I8QC+L5fDpiVv8eqvrz
         KJRENgprcqiCeomJ3lhZWrrHNbhnG7JAjUXbVddnNblNFrgbfFY2trb2oFu2cP7GBo
         lH1ruowZhTR2g==
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
Subject: [PATCH v2 3/6] memblock: drop memblock_free_early_nid() and memblock_free_early()
Date:   Thu, 30 Sep 2021 21:50:28 +0300
Message-Id: <20210930185031.18648-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210930185031.18648-1-rppt@kernel.org>
References: <20210930185031.18648-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

memblock_free_early_nid() is unused and memblock_free_early() is an alias
for memblock_free().

Replace calls to memblock_free_early() with calls to memblock_free() and
remove memblock_free_early() and memblock_free_early_nid().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/mips/mm/init.c                  |  2 +-
 arch/powerpc/platforms/pseries/svm.c |  3 +--
 arch/s390/kernel/smp.c               |  2 +-
 drivers/base/arch_numa.c             |  2 +-
 drivers/s390/char/sclp_early.c       |  2 +-
 include/linux/memblock.h             | 12 ------------
 kernel/dma/swiotlb.c                 |  2 +-
 lib/cpumask.c                        |  2 +-
 mm/percpu.c                          |  8 ++++----
 mm/sparse.c                          |  2 +-
 10 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 19347dc6bbf8..21a5a7ac0037 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -529,7 +529,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free_early(__pa(ptr), size);
+	memblock_free(__pa(ptr), size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 87f001b4c4e4..f12229ce7301 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -56,8 +56,7 @@ void __init svm_swiotlb_init(void)
 		return;
 
 
-	memblock_free_early(__pa(vstart),
-			    PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
+	memblock_free(__pa(vstart), PAGE_ALIGN(io_tlb_nslabs << IO_TLB_SHIFT));
 	panic("SVM: Cannot allocate SWIOTLB buffer");
 }
 
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 1a04e5bdf655..066efd6d9345 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -880,7 +880,7 @@ void __init smp_detect_cpus(void)
 
 	/* Add CPUs present at boot */
 	__smp_rescan_cpus(info, true);
-	memblock_free_early((unsigned long)info, sizeof(*info));
+	memblock_free((unsigned long)info, sizeof(*info));
 }
 
 /*
diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index f6d0efd01188..e28d9dfe3c20 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -165,7 +165,7 @@ static void * __init pcpu_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_fc_free(void *ptr, size_t size)
 {
-	memblock_free_early(__pa(ptr), size);
+	memblock_free(__pa(ptr), size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/drivers/s390/char/sclp_early.c b/drivers/s390/char/sclp_early.c
index f3d5c7f4c13d..f01d942e1c1d 100644
--- a/drivers/s390/char/sclp_early.c
+++ b/drivers/s390/char/sclp_early.c
@@ -139,7 +139,7 @@ int __init sclp_early_get_core_info(struct sclp_core_info *info)
 	}
 	sclp_fill_core_info(info, sccb);
 out:
-	memblock_free_early((unsigned long)sccb, length);
+	memblock_free((unsigned long)sccb, length);
 	return rc;
 }
 
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 34de69b3b8ba..fc8183be340c 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
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
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87c40517e822..430d2f78d540 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -247,7 +247,7 @@ swiotlb_init(int verbose)
 	return;
 
 fail_free_mem:
-	memblock_free_early(__pa(tlb), bytes);
+	memblock_free(__pa(tlb), bytes);
 fail:
 	pr_warn("Cannot allocate buffer");
 }
diff --git a/lib/cpumask.c b/lib/cpumask.c
index c3c76b833384..045779446a18 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -188,7 +188,7 @@ EXPORT_SYMBOL(free_cpumask_var);
  */
 void __init free_bootmem_cpumask_var(cpumask_var_t mask)
 {
-	memblock_free_early(__pa(mask), cpumask_size());
+	memblock_free(__pa(mask), cpumask_size());
 }
 #endif
 
diff --git a/mm/percpu.c b/mm/percpu.c
index e0a986818903..f58318cb04c0 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2472,7 +2472,7 @@ struct pcpu_alloc_info * __init pcpu_alloc_alloc_info(int nr_groups,
  */
 void __init pcpu_free_alloc_info(struct pcpu_alloc_info *ai)
 {
-	memblock_free_early(__pa(ai), ai->__ai_size);
+	memblock_free(__pa(ai), ai->__ai_size);
 }
 
 /**
@@ -3134,7 +3134,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 out_free:
 	pcpu_free_alloc_info(ai);
 	if (areas)
-		memblock_free_early(__pa(areas), areas_size);
+		memblock_free(__pa(areas), areas_size);
 	return rc;
 }
 #endif /* BUILD_EMBED_FIRST_CHUNK */
@@ -3256,7 +3256,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 		free_fn(page_address(pages[j]), PAGE_SIZE);
 	rc = -ENOMEM;
 out_free_ar:
-	memblock_free_early(__pa(pages), pages_size);
+	memblock_free(__pa(pages), pages_size);
 	pcpu_free_alloc_info(ai);
 	return rc;
 }
@@ -3286,7 +3286,7 @@ static void * __init pcpu_dfl_fc_alloc(unsigned int cpu, size_t size,
 
 static void __init pcpu_dfl_fc_free(void *ptr, size_t size)
 {
-	memblock_free_early(__pa(ptr), size);
+	memblock_free(__pa(ptr), size);
 }
 
 void __init setup_per_cpu_areas(void)
diff --git a/mm/sparse.c b/mm/sparse.c
index 120bc8ea5293..55fea0c2f927 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -451,7 +451,7 @@ static void *sparsemap_buf_end __meminitdata;
 static inline void __meminit sparse_buffer_free(unsigned long size)
 {
 	WARN_ON(!sparsemap_buf || size == 0);
-	memblock_free_early(__pa(sparsemap_buf), size);
+	memblock_free(__pa(sparsemap_buf), size);
 }
 
 static void __init sparse_buffer_init(unsigned long size, int nid)
-- 
2.28.0

