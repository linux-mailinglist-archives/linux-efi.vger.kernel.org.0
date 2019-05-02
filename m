Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD67F11B0E
	for <lists+linux-efi@lfdr.de>; Thu,  2 May 2019 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfEBOPW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 May 2019 10:15:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbfEBOPN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 May 2019 10:15:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42EA6pI100418
        for <linux-efi@vger.kernel.org>; Thu, 2 May 2019 10:15:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s81chjgqn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Thu, 02 May 2019 10:15:10 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 2 May 2019 15:15:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 15:15:01 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42EF0kA20775166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 14:15:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED7FE42056;
        Thu,  2 May 2019 14:14:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F74A42041;
        Thu,  2 May 2019 14:14:59 +0000 (GMT)
Received: from mschwideX1 (unknown [9.152.212.60])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 14:14:59 +0000 (GMT)
Date:   Thu, 2 May 2019 16:14:57 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, jglisse@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] mm/pgtable: Drop pgtable_t variable from pte_fn_t
 functions
In-Reply-To: <20190502134623.GA18948@bombadil.infradead.org>
References: <1556803126-26596-1-git-send-email-anshuman.khandual@arm.com>
        <20190502134623.GA18948@bombadil.infradead.org>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050214-0020-0000-0000-000003389304
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050214-0021-0000-0000-0000218B1B48
Message-Id: <20190502161457.1c9dbd94@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020096
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2 May 2019 06:46:23 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, May 02, 2019 at 06:48:46PM +0530, Anshuman Khandual wrote:
> > Drop the pgtable_t variable from all implementation for pte_fn_t as none of
> > them use it. apply_to_pte_range() should stop computing it as well. Should
> > help us save some cycles.  
> 
> You didn't add Martin Schwidefsky for some reason.  He introduced
> it originally for s390 for sub-page page tables back in 2008 (commit
> 2f569afd9c).  I think he should confirm that he no longer needs it.

With its 2K pte tables s390 can not deal with a (struct page *) as a reference
to a page table. But if there are no user of the apply_to_page_range() API
left which actually make use of the token argument we can safely drop it.

> > ---
> > - Boot tested on arm64 and x86 platforms.
> > - Build tested on multiple platforms with their defconfig
> > 
> >  arch/arm/kernel/efi.c          | 3 +--
> >  arch/arm/mm/dma-mapping.c      | 3 +--
> >  arch/arm/mm/pageattr.c         | 3 +--
> >  arch/arm64/kernel/efi.c        | 3 +--
> >  arch/arm64/mm/pageattr.c       | 3 +--
> >  arch/x86/xen/mmu_pv.c          | 3 +--
> >  drivers/gpu/drm/i915/i915_mm.c | 3 +--
> >  drivers/xen/gntdev.c           | 6 ++----
> >  drivers/xen/privcmd.c          | 6 ++----
> >  drivers/xen/xlate_mmu.c        | 3 +--
> >  include/linux/mm.h             | 3 +--
> >  mm/memory.c                    | 5 +----
> >  mm/vmalloc.c                   | 2 +-
> >  13 files changed, 15 insertions(+), 31 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/efi.c b/arch/arm/kernel/efi.c
> > index 9f43ba012d10..b1f142a01f2f 100644
> > --- a/arch/arm/kernel/efi.c
> > +++ b/arch/arm/kernel/efi.c
> > @@ -11,8 +11,7 @@
> >  #include <asm/mach/map.h>
> >  #include <asm/mmu_context.h>
> >  
> > -static int __init set_permissions(pte_t *ptep, pgtable_t token,
> > -				  unsigned long addr, void *data)
> > +static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	efi_memory_desc_t *md = data;
> >  	pte_t pte = *ptep;
> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> > index 43f46aa7ef33..739286511a18 100644
> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -496,8 +496,7 @@ void __init dma_contiguous_remap(void)
> >  	}
> >  }
> >  
> > -static int __dma_update_pte(pte_t *pte, pgtable_t token, unsigned long addr,
> > -			    void *data)
> > +static int __dma_update_pte(pte_t *pte, unsigned long addr, void *data)
> >  {
> >  	struct page *page = virt_to_page(addr);
> >  	pgprot_t prot = *(pgprot_t *)data;
> > diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
> > index 1403cb4a0c3d..c8b500940e1f 100644
> > --- a/arch/arm/mm/pageattr.c
> > +++ b/arch/arm/mm/pageattr.c
> > @@ -22,8 +22,7 @@ struct page_change_data {
> >  	pgprot_t clear_mask;
> >  };
> >  
> > -static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
> > -			void *data)
> > +static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	struct page_change_data *cdata = data;
> >  	pte_t pte = *ptep;
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index 4f9acb5fbe97..230cff073a08 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -86,8 +86,7 @@ int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
> >  	return 0;
> >  }
> >  
> > -static int __init set_permissions(pte_t *ptep, pgtable_t token,
> > -				  unsigned long addr, void *data)
> > +static int __init set_permissions(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	efi_memory_desc_t *md = data;
> >  	pte_t pte = READ_ONCE(*ptep);
> > diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> > index 6cd645edcf35..0be077628b21 100644
> > --- a/arch/arm64/mm/pageattr.c
> > +++ b/arch/arm64/mm/pageattr.c
> > @@ -27,8 +27,7 @@ struct page_change_data {
> >  
> >  bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
> >  
> > -static int change_page_range(pte_t *ptep, pgtable_t token, unsigned long addr,
> > -			void *data)
> > +static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	struct page_change_data *cdata = data;
> >  	pte_t pte = READ_ONCE(*ptep);
> > diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> > index a21e1734fc1f..308a6195fd26 100644
> > --- a/arch/x86/xen/mmu_pv.c
> > +++ b/arch/x86/xen/mmu_pv.c
> > @@ -2702,8 +2702,7 @@ struct remap_data {
> >  	struct mmu_update *mmu_update;
> >  };
> >  
> > -static int remap_area_pfn_pte_fn(pte_t *ptep, pgtable_t token,
> > -				 unsigned long addr, void *data)
> > +static int remap_area_pfn_pte_fn(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	struct remap_data *rmd = data;
> >  	pte_t pte = pte_mkspecial(mfn_pte(*rmd->pfn, rmd->prot));
> > diff --git a/drivers/gpu/drm/i915/i915_mm.c b/drivers/gpu/drm/i915/i915_mm.c
> > index e4935dd1fd37..c23bb29e6d3e 100644
> > --- a/drivers/gpu/drm/i915/i915_mm.c
> > +++ b/drivers/gpu/drm/i915/i915_mm.c
> > @@ -35,8 +35,7 @@ struct remap_pfn {
> >  	pgprot_t prot;
> >  };
> >  
> > -static int remap_pfn(pte_t *pte, pgtable_t token,
> > -		     unsigned long addr, void *data)
> > +static int remap_pfn(pte_t *pte, unsigned long addr, void *data)
> >  {
> >  	struct remap_pfn *r = data;
> >  
> > diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> > index 7cf9c51318aa..f0df481e2697 100644
> > --- a/drivers/xen/gntdev.c
> > +++ b/drivers/xen/gntdev.c
> > @@ -264,8 +264,7 @@ void gntdev_put_map(struct gntdev_priv *priv, struct gntdev_grant_map *map)
> >  
> >  /* ------------------------------------------------------------------ */
> >  
> > -static int find_grant_ptes(pte_t *pte, pgtable_t token,
> > -		unsigned long addr, void *data)
> > +static int find_grant_ptes(pte_t *pte, unsigned long addr, void *data)
> >  {
> >  	struct gntdev_grant_map *map = data;
> >  	unsigned int pgnr = (addr - map->vma->vm_start) >> PAGE_SHIFT;
> > @@ -292,8 +291,7 @@ static int find_grant_ptes(pte_t *pte, pgtable_t token,
> >  }
> >  
> >  #ifdef CONFIG_X86
> > -static int set_grant_ptes_as_special(pte_t *pte, pgtable_t token,
> > -				     unsigned long addr, void *data)
> > +static int set_grant_ptes_as_special(pte_t *pte, unsigned long addr, void *data)
> >  {
> >  	set_pte_at(current->mm, addr, pte, pte_mkspecial(*pte));
> >  	return 0;
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index b24ddac1604b..4c7268869e2c 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -730,8 +730,7 @@ struct remap_pfn {
> >  	unsigned long i;
> >  };
> >  
> > -static int remap_pfn_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
> > -			void *data)
> > +static int remap_pfn_fn(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	struct remap_pfn *r = data;
> >  	struct page *page = r->pages[r->i];
> > @@ -965,8 +964,7 @@ static int privcmd_mmap(struct file *file, struct vm_area_struct *vma)
> >   * on a per pfn/pte basis. Mapping calls that fail with ENOENT
> >   * can be then retried until success.
> >   */
> > -static int is_mapped_fn(pte_t *pte, struct page *pmd_page,
> > -	                unsigned long addr, void *data)
> > +static int is_mapped_fn(pte_t *pte, unsigned long addr, void *data)
> >  {
> >  	return pte_none(*pte) ? 0 : -EBUSY;
> >  }
> > diff --git a/drivers/xen/xlate_mmu.c b/drivers/xen/xlate_mmu.c
> > index e7df65d32c91..ba883a80b3c0 100644
> > --- a/drivers/xen/xlate_mmu.c
> > +++ b/drivers/xen/xlate_mmu.c
> > @@ -93,8 +93,7 @@ static void setup_hparams(unsigned long gfn, void *data)
> >  	info->fgfn++;
> >  }
> >  
> > -static int remap_pte_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
> > -			void *data)
> > +static int remap_pte_fn(pte_t *ptep, unsigned long addr, void *data)
> >  {
> >  	struct remap_data *info = data;
> >  	struct page *page = info->pages[info->index++];
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 6b10c21630f5..f9509d57edc6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2595,8 +2595,7 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
> >  	return 0;
> >  }
> >  
> > -typedef int (*pte_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
> > -			void *data);
> > +typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
> >  extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
> >  			       unsigned long size, pte_fn_t fn, void *data);
> >  
> > diff --git a/mm/memory.c b/mm/memory.c
> > index ab650c21bccd..dd0e64c94ddc 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1952,7 +1952,6 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >  {
> >  	pte_t *pte;
> >  	int err;
> > -	pgtable_t token;
> >  	spinlock_t *uninitialized_var(ptl);
> >  
> >  	pte = (mm == &init_mm) ?
> > @@ -1965,10 +1964,8 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> >  
> >  	arch_enter_lazy_mmu_mode();
> >  
> > -	token = pmd_pgtable(*pmd);
> > -
> >  	do {
> > -		err = fn(pte++, token, addr, data);
> > +		err = fn(pte++, addr, data);
> >  		if (err)
> >  			break;
> >  	} while (addr += PAGE_SIZE, addr != end);
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index e86ba6e74b50..94533beb6b68 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2332,7 +2332,7 @@ void __weak vmalloc_sync_all(void)
> >  }
> >  
> >  
> > -static int f(pte_t *pte, pgtable_t table, unsigned long addr, void *data)
> > +static int f(pte_t *pte, unsigned long addr, void *data)
> >  {
> >  	pte_t ***p = data;
> >  
> > -- 
> > 2.20.1
> >   
> 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

