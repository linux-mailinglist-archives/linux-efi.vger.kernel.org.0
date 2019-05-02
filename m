Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D72119EE
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEBNTB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 09:19:01 -0400
Received: from foss.arm.com ([217.140.101.70]:45642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBNTB (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 2 May 2019 09:19:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9F9374;
        Thu,  2 May 2019 06:19:00 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47B2C3F719;
        Thu,  2 May 2019 06:18:48 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, jglisse@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] mm/pgtable: Drop pgtable_t variable from pte_fn_t functions
Date:   Thu,  2 May 2019 18:48:46 +0530
Message-Id: <1556803126-26596-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Drop the pgtable_t variable from all implementation for pte_fn_t as none of
them use it. apply_to_pte_range() should stop computing it as well. Should
help us save some cycles.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <jglisse@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-mm@kvack.org
---
- Boot tested on arm64 and x86 platforms.
- Build tested on multiple platforms with their defconfig

 arch/arm/kernel/efi.c          | 3 +--
 arch/arm/mm/dma-mapping.c      | 3 +--
 arch/arm/mm/pageattr.c         | 3 +--
 arch/arm64/kernel/efi.c        | 3 +--
 arch/arm64/mm/pageattr.c       | 3 +--
 arch/x86/xen/mmu_pv.c          | 3 +--
 drivers/gpu/drm/i915/i915_mm.c | 3 +--
 drivers/xen/gntdev.c           | 6 ++----
 drivers/xen/privcmd.c          | 6 ++----
 drivers/xen/xlate_mmu.c        | 3 +--
 include/linux/mm.h             | 3 +--
 mm/memory.c                    | 5 +----
 mm/vmalloc.c                   | 2 +-
 13 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
index 9f43ba012d10..b1f142a01f2f 100644
--- a/arch/arm/kernel/efi.c
+++ b/arch/arm/kernel/efi.c
@@ -11,8 +11,7 @@
 #include <asm/mach/map.h>
 #include <asm/mmu_context.h>
 
-static int __init set_permissions(pte_t *ptep, pgtable_t token,
-				  unsigned long addr, void *data)
+static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	efi_memory_desc_t *md = data;
 	pte_t pte = *ptep;
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 43f46aa7ef33..739286511a18 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -496,8 +496,7 @@ void __init dma_contiguous_remap(void)
 	}
 }
 
-static int __dma_update_pte(pte_t *pte, pgtable_t token, unsigned long addr,
-			    void *data)
+static int __dma_update_pte(pte_t *pte, unsigned long addr, void *data)
 {
 	struct page *page = virt_to_page(addr);
 	pgprot_t prot = *(pgprot_t *)data;
diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index 1403cb4a0c3d..c8b500940e1f 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -22,8 +22,7 @@ struct page_change_data {
 	pgprot_t clear_mask;
 };
 
-static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
-			void *data)
+static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
 	pte_t pte = *ptep;
diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index 4f9acb5fbe97..230cff073a08 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -86,8 +86,7 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 	return 0;
 }
 
-static int __init set_permissions(pte_t *ptep, pgtable_t token,
-				  unsigned long addr, void *data)
+static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
 {
 	efi_memory_desc_t *md = data;
 	pte_t pte = READ_ONCE(*ptep);
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 6cd645edcf35..0be077628b21 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -27,8 +27,7 @@ struct page_change_data {
 
 bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
 
-static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
-			void *data)
+static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
 	pte_t pte = READ_ONCE(*ptep);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index a21e1734fc1f..308a6195fd26 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2702,8 +2702,7 @@ struct remap_data {
 	struct mmu_update *mmu_update;
 };
 
-static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
-				 unsigned long addr, void *data)
+static int remap_area_pfn_pte_fn(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_data *rmd = data;
 	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
diff --git a/drivers/gpu/drm/i915/i915_mm.c b/drivers/gpu/drm/i915/i915_mm.c
index e4935dd1fd37..c23bb29e6d3e 100644
--- a/drivers/gpu/drm/i915/i915_mm.c
+++ b/drivers/gpu/drm/i915/i915_mm.c
@@ -35,8 +35,7 @@ struct remap_pfn {
 	pgprot_t prot;
 };
 
-static int remap_pfn(pte_t *pte, pgtable_t token,
-		     unsigned long addr, void *data)
+static int remap_pfn(pte_t *pte, unsigned long addr, void *data)
 {
 	struct remap_pfn *r = data;
 
diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 7cf9c51318aa..f0df481e2697 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -264,8 +264,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
 
 /* ------------------------------------------------------------------ */
 
-static int find_grant_ptes(pte_t *pte, pgtable_t token,
-		unsigned long addr, void *data)
+static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
 {
 	struct gntdev_grant_map *map = data;
 	unsigned int pgnr = (addr - map->vma->vm_start) >> PAGE_SHIFT;
@@ -292,8 +291,7 @@ static int find_grant_ptes(pte_t *pte, pgtable_t token,
 }
 
 #ifdef CONFIG_X86
-static int set_grant_ptes_as_special(pte_t *pte, pgtable_t token,
-				     unsigned long addr, void *data)
+static int set_grant_ptes_as_special(pte_t *pte, unsigned long addr, void *data)
 {
 	set_pte_at(current->mm, addr, pte, pte_mkspecial(*pte));
 	return 0;
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b24ddac1604b..4c7268869e2c 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -730,8 +730,7 @@ struct remap_pfn {
 	unsigned long i;
 };
 
-static int remap_pfn_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
-			void *data)
+static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_pfn *r = data;
 	struct page *page = r->pages[r->i];
@@ -965,8 +964,7 @@ static int privcmd_mmap(struct file *file, struct vm_area_struct *vma)
  * on a per pfn/pte basis. Mapping calls that fail with ENOENT
  * can be then retried until success.
  */
-static int is_mapped_fn(pte_t *pte, struct page *pmd_page,
-	                unsigned long addr, void *data)
+static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
 {
 	return pte_none(*pte) ? 0 : -EBUSY;
 }
diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
index e7df65d32c91..ba883a80b3c0 100644
--- a/drivers/xen/xlate_mmu.c
+++ b/drivers/xen/xlate_mmu.c
@@ -93,8 +93,7 @@ static void setup_hparams(unsigned long gfn, void *data)
 	info->fgfn++;
 }
 
-static int remap_pte_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
-			void *data)
+static int remap_pte_fn(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct remap_data *info = data;
 	struct page *page = info->pages[info->index++];
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b10c21630f5..f9509d57edc6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2595,8 +2595,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 	return 0;
 }
 
-typedef int (*pte_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
-			void *data);
+typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
 
diff --git a/mm/memory.c b/mm/memory.c
index ab650c21bccd..dd0e64c94ddc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1952,7 +1952,6 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 {
 	pte_t *pte;
 	int err;
-	pgtable_t token;
 	spinlock_t *uninitialized_var(ptl);
 
 	pte = (mm == &init_mm) ?
@@ -1965,10 +1964,8 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
 
 	arch_enter_lazy_mmu_mode();
 
-	token = pmd_pgtable(*pmd);
-
 	do {
-		err = fn(pte++, token, addr, data);
+		err = fn(pte++, addr, data);
 		if (err)
 			break;
 	} while (addr += PAGE_SIZE, addr != end);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e86ba6e74b50..94533beb6b68 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2332,7 +2332,7 @@ void __weak vmalloc_sync_all(void)
 }
 
 
-static int f(pte_t *pte, pgtable_t table, unsigned long addr, void *data)
+static int f(pte_t *pte, unsigned long addr, void *data)
 {
 	pte_t ***p = data;
 
-- 
2.20.1

