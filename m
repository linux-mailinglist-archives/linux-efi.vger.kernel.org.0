Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A50221A2C3
	for <lists+linux-efi@lfdr.de>; Thu,  9 Jul 2020 16:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgGIO4K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Jul 2020 10:56:10 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59834 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726710AbgGIOzn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Jul 2020 10:55:43 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069EmSUk009919;
        Thu, 9 Jul 2020 14:54:53 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 325k1aqgrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 14:54:53 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 6ECF78D;
        Thu,  9 Jul 2020 14:54:51 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id 1963320203306; Thu,  9 Jul 2020 09:54:49 -0500 (CDT)
Message-ID: <20200709145448.997973748@hpe.com>
User-Agent: quilt/0.66
Date:   Thu, 09 Jul 2020 09:54:59 -0500
From:   steve.wahl@hpe.com
To:     Steve Wahl <steve.wahl@hpe.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Austin Kim <austindh.kim@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Cc:     Russ Anderson <rja@hpe.com>
Subject: [patch v2 12/13] x86: Remove uv bios and efi code related to (now unused) EFI_UV1_MEMMAP
References: <20200709145447.549145421@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 spamscore=0 suspectscore=2 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090111
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

With UV1 removed, EFI_UV1_MEMMAP is not used.  Remove code used by it
in arch/x86/platform/uv/bios_uv.c and turn off code in
arch/x86/platform/efi/efi.c that referenced this code.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/platform/efi/efi.c    |    2 
 arch/x86/platform/uv/bios_uv.c |  159 -----------------------------------------
 2 files changed, 2 insertions(+), 159 deletions(-)

--- linux.orig/arch/x86/platform/uv/bios_uv.c	2020-07-07 10:56:15.025045961 -0500
+++ linux/arch/x86/platform/uv/bios_uv.c	2020-07-07 10:56:15.613045257 -0500
@@ -30,17 +30,7 @@ static s64 __uv_bios_call(enum uv_bios_c
 		 */
 		return BIOS_STATUS_UNIMPLEMENTED;
 
-	/*
-	 * If EFI_UV1_MEMMAP is set, we need to fall back to using our old EFI
-	 * callback method, which uses efi_call() directly, with the kernel page tables:
-	 */
-	if (unlikely(efi_enabled(EFI_UV1_MEMMAP))) {
-		kernel_fpu_begin();
-		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
-		kernel_fpu_end();
-	} else {
-		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
-	}
+	ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
 
 	return ret;
 }
@@ -209,150 +199,3 @@ int uv_bios_init(void)
 	pr_info("UV: UVsystab: Revision:%x\n", uv_systab->revision);
 	return 0;
 }
-
-static void __init early_code_mapping_set_exec(int executable)
-{
-	efi_memory_desc_t *md;
-
-	if (!(__supported_pte_mask & _PAGE_NX))
-		return;
-
-	/* Make EFI service code area executable */
-	for_each_efi_memory_desc(md) {
-		if (md->type == EFI_RUNTIME_SERVICES_CODE ||
-		    md->type == EFI_BOOT_SERVICES_CODE)
-			efi_set_executable(md, executable);
-	}
-}
-
-void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd)
-{
-	/*
-	 * After the lock is released, the original page table is restored.
-	 */
-	int pgd_idx, i;
-	int nr_pgds;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-
-	nr_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT) , PGDIR_SIZE);
-
-	for (pgd_idx = 0; pgd_idx < nr_pgds; pgd_idx++) {
-		pgd = pgd_offset_k(pgd_idx * PGDIR_SIZE);
-		set_pgd(pgd_offset_k(pgd_idx * PGDIR_SIZE), save_pgd[pgd_idx]);
-
-		if (!pgd_present(*pgd))
-			continue;
-
-		for (i = 0; i < PTRS_PER_P4D; i++) {
-			p4d = p4d_offset(pgd,
-					 pgd_idx * PGDIR_SIZE + i * P4D_SIZE);
-
-			if (!p4d_present(*p4d))
-				continue;
-
-			pud = (pud_t *)p4d_page_vaddr(*p4d);
-			pud_free(&init_mm, pud);
-		}
-
-		p4d = (p4d_t *)pgd_page_vaddr(*pgd);
-		p4d_free(&init_mm, p4d);
-	}
-
-	kfree(save_pgd);
-
-	__flush_tlb_all();
-	early_code_mapping_set_exec(0);
-}
-
-pgd_t * __init efi_uv1_memmap_phys_prolog(void)
-{
-	unsigned long vaddr, addr_pgd, addr_p4d, addr_pud;
-	pgd_t *save_pgd, *pgd_k, *pgd_efi;
-	p4d_t *p4d, *p4d_k, *p4d_efi;
-	pud_t *pud;
-
-	int pgd;
-	int n_pgds, i, j;
-
-	early_code_mapping_set_exec(1);
-
-	n_pgds = DIV_ROUND_UP((max_pfn << PAGE_SHIFT), PGDIR_SIZE);
-	save_pgd = kmalloc_array(n_pgds, sizeof(*save_pgd), GFP_KERNEL);
-	if (!save_pgd)
-		return NULL;
-
-	/*
-	 * Build 1:1 identity mapping for UV1 memmap usage. Note that
-	 * PAGE_OFFSET is PGDIR_SIZE aligned when KASLR is disabled, while
-	 * it is PUD_SIZE ALIGNED with KASLR enabled. So for a given physical
-	 * address X, the pud_index(X) != pud_index(__va(X)), we can only copy
-	 * PUD entry of __va(X) to fill in pud entry of X to build 1:1 mapping.
-	 * This means here we can only reuse the PMD tables of the direct mapping.
-	 */
-	for (pgd = 0; pgd < n_pgds; pgd++) {
-		addr_pgd = (unsigned long)(pgd * PGDIR_SIZE);
-		vaddr = (unsigned long)__va(pgd * PGDIR_SIZE);
-		pgd_efi = pgd_offset_k(addr_pgd);
-		save_pgd[pgd] = *pgd_efi;
-
-		p4d = p4d_alloc(&init_mm, pgd_efi, addr_pgd);
-		if (!p4d) {
-			pr_err("Failed to allocate p4d table!\n");
-			goto out;
-		}
-
-		for (i = 0; i < PTRS_PER_P4D; i++) {
-			addr_p4d = addr_pgd + i * P4D_SIZE;
-			p4d_efi = p4d + p4d_index(addr_p4d);
-
-			pud = pud_alloc(&init_mm, p4d_efi, addr_p4d);
-			if (!pud) {
-				pr_err("Failed to allocate pud table!\n");
-				goto out;
-			}
-
-			for (j = 0; j < PTRS_PER_PUD; j++) {
-				addr_pud = addr_p4d + j * PUD_SIZE;
-
-				if (addr_pud > (max_pfn << PAGE_SHIFT))
-					break;
-
-				vaddr = (unsigned long)__va(addr_pud);
-
-				pgd_k = pgd_offset_k(vaddr);
-				p4d_k = p4d_offset(pgd_k, vaddr);
-				pud[j] = *pud_offset(p4d_k, vaddr);
-			}
-		}
-		pgd_offset_k(pgd * PGDIR_SIZE)->pgd &= ~_PAGE_NX;
-	}
-
-	__flush_tlb_all();
-	return save_pgd;
-out:
-	efi_uv1_memmap_phys_epilog(save_pgd);
-	return NULL;
-}
-
-void __iomem *__init efi_ioremap(unsigned long phys_addr, unsigned long size,
-				 u32 type, u64 attribute)
-{
-	unsigned long last_map_pfn;
-
-	if (type == EFI_MEMORY_MAPPED_IO)
-		return ioremap(phys_addr, size);
-
-	last_map_pfn = init_memory_mapping(phys_addr, phys_addr + size,
-					   PAGE_KERNEL);
-	if ((last_map_pfn << PAGE_SHIFT) < phys_addr + size) {
-		unsigned long top = last_map_pfn << PAGE_SHIFT;
-		efi_ioremap(top, size - (top - phys_addr), type, attribute);
-	}
-
-	if (!(attribute & EFI_MEMORY_WB))
-		efi_memory_uc((u64)(unsigned long)__va(phys_addr), size);
-
-	return (void __iomem *)__va(phys_addr);
-}
--- linux.orig/arch/x86/platform/efi/efi.c	2020-07-07 10:56:15.401045510 -0500
+++ linux/arch/x86/platform/efi/efi.c	2020-07-07 10:56:15.625045241 -0500
@@ -496,7 +496,7 @@ void __init efi_init(void)
 		efi_print_memmap();
 }
 
-#if defined(CONFIG_X86_32) || defined(CONFIG_X86_UV)
+#if defined(CONFIG_X86_32)
 
 void __init efi_set_executable(efi_memory_desc_t *md, bool executable)
 {

