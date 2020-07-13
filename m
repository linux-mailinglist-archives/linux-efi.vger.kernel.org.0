Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C721E21E
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jul 2020 23:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGMVax (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jul 2020 17:30:53 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:27084 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbgGMVau (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jul 2020 17:30:50 -0400
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DLNU8e014637;
        Mon, 13 Jul 2020 21:30:01 GMT
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 3276mf37vt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 21:30:01 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id DE9A86F;
        Mon, 13 Jul 2020 21:29:59 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
        id DA3B8200F8C3A; Mon, 13 Jul 2020 16:29:55 -0500 (CDT)
Message-ID: <20200713212955.786177105@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 13 Jul 2020 16:30:05 -0500
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
Subject: [patch v3 11/13] x86: Remove references to no-longer-used efi_have_uv1_memmap()
References: <20200713212954.444086564@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_17:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=2
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007130153
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In removing UV1 support, efi_have_uv1_memmap is no longer used.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/kexec-bzimage64.c |    9 ---------
 arch/x86/platform/efi/efi.c       |   14 +++-----------
 arch/x86/platform/efi/efi_64.c    |   38 +++-----------------------------------
 arch/x86/platform/efi/quirks.c    |    8 --------
 4 files changed, 6 insertions(+), 63 deletions(-)

--- linux.orig/arch/x86/kernel/kexec-bzimage64.c	2020-07-07 10:49:49.933510781 -0500
+++ linux/arch/x86/kernel/kexec-bzimage64.c	2020-07-07 10:56:15.393045519 -0500
@@ -170,15 +170,6 @@ setup_efi_state(struct boot_params *para
 	if (!current_ei->efi_memmap_size)
 		return 0;
 
-	/*
-	 * If 1:1 mapping is not enabled, second kernel can not setup EFI
-	 * and use EFI run time services. User space will have to pass
-	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
-	 * without efi.
-	 */
-	if (efi_have_uv1_memmap())
-		return 0;
-
 	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
--- linux.orig/arch/x86/platform/efi/efi.c	2020-07-07 10:49:49.933510781 -0500
+++ linux/arch/x86/platform/efi/efi.c	2020-07-07 10:56:15.401045510 -0500
@@ -648,7 +648,7 @@ static inline void *efi_map_next_entry_r
  */
 static void *efi_map_next_entry(void *entry)
 {
-	if (!efi_have_uv1_memmap() && efi_enabled(EFI_64BIT)) {
+	if (efi_enabled(EFI_64BIT)) {
 		/*
 		 * Starting in UEFI v2.5 the EFI_PROPERTIES_TABLE
 		 * config table feature requires us to map all entries
@@ -777,11 +777,9 @@ static void __init kexec_enter_virtual_m
 
 	/*
 	 * We don't do virtual mode, since we don't do runtime services, on
-	 * non-native EFI. With the UV1 memmap, we don't do runtime services in
-	 * kexec kernel because in the initial boot something else might
-	 * have been mapped at these virtual addresses.
+	 * non-native EFI.
 	 */
-	if (efi_is_mixed() || efi_have_uv1_memmap()) {
+	if (efi_is_mixed()) {
 		efi_memmap_unmap();
 		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
@@ -832,12 +830,6 @@ static void __init kexec_enter_virtual_m
  * has the runtime attribute bit set in its memory descriptor into the
  * efi_pgd page table.
  *
- * The old method which used to update that memory descriptor with the
- * virtual address obtained from ioremap() is still supported when the
- * kernel is booted on SG1 UV1 hardware. Same old method enabled the
- * runtime services to be called without having to thunk back into
- * physical mode for every invocation.
- *
  * The new method does a pagetable switch in a preemption-safe manner
  * so that we're in a different address space when calling a runtime
  * function. For function arguments passing we do copy the PUDs of the
--- linux.orig/arch/x86/platform/efi/efi_64.c	2020-07-07 10:49:49.933510781 -0500
+++ linux/arch/x86/platform/efi/efi_64.c	2020-07-07 10:56:15.405045505 -0500
@@ -74,9 +74,6 @@ int __init efi_alloc_page_tables(void)
 	pud_t *pud;
 	gfp_t gfp_mask;
 
-	if (efi_have_uv1_memmap())
-		return 0;
-
 	gfp_mask = GFP_KERNEL | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_pages(gfp_mask, PGD_ALLOCATION_ORDER);
 	if (!efi_pgd)
@@ -115,9 +112,6 @@ void efi_sync_low_kernel_mappings(void)
 	pud_t *pud_k, *pud_efi;
 	pgd_t *efi_pgd = efi_mm.pgd;
 
-	if (efi_have_uv1_memmap())
-		return;
-
 	/*
 	 * We can share all PGD entries apart from the one entry that
 	 * covers the EFI runtime mapping space.
@@ -206,9 +200,6 @@ int __init efi_setup_page_tables(unsigne
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
 
-	if (efi_have_uv1_memmap())
-		return 0;
-
 	/*
 	 * It can happen that the physical address of new_memmap lands in memory
 	 * which is not mapped in the EFI page table. Therefore we need to go
@@ -315,9 +306,6 @@ void __init efi_map_region(efi_memory_de
 	unsigned long size = md->num_pages << PAGE_SHIFT;
 	u64 pa = md->phys_addr;
 
-	if (efi_have_uv1_memmap())
-		return old_map_region(md);
-
 	/*
 	 * Make sure the 1:1 mappings are present as a catch-all for b0rked
 	 * firmware which doesn't update all internal pointers after switching
@@ -420,12 +408,6 @@ void __init efi_runtime_update_mappings(
 {
 	efi_memory_desc_t *md;
 
-	if (efi_have_uv1_memmap()) {
-		if (__supported_pte_mask & _PAGE_NX)
-			runtime_code_page_mkexec();
-		return;
-	}
-
 	/*
 	 * Use the EFI Memory Attribute Table for mapping permissions if it
 	 * exists, since it is intended to supersede EFI_PROPERTIES_TABLE.
@@ -474,10 +456,7 @@ void __init efi_runtime_update_mappings(
 void __init efi_dump_pagetable(void)
 {
 #ifdef CONFIG_EFI_PGT_DUMP
-	if (efi_have_uv1_memmap())
-		ptdump_walk_pgd_level(NULL, &init_mm);
-	else
-		ptdump_walk_pgd_level(NULL, &efi_mm);
+	ptdump_walk_pgd_level(NULL, &efi_mm);
 #endif
 }
 
@@ -849,21 +828,13 @@ efi_set_virtual_address_map(unsigned lon
 	const efi_system_table_t *systab = (efi_system_table_t *)systab_phys;
 	efi_status_t status;
 	unsigned long flags;
-	pgd_t *save_pgd = NULL;
 
 	if (efi_is_mixed())
 		return efi_thunk_set_virtual_address_map(memory_map_size,
 							 descriptor_size,
 							 descriptor_version,
 							 virtual_map);
-
-	if (efi_have_uv1_memmap()) {
-		save_pgd = efi_uv1_memmap_phys_prolog();
-		if (!save_pgd)
-			return EFI_ABORTED;
-	} else {
-		efi_switch_mm(&efi_mm);
-	}
+	efi_switch_mm(&efi_mm);
 
 	kernel_fpu_begin();
 
@@ -879,10 +850,7 @@ efi_set_virtual_address_map(unsigned lon
 	/* grab the virtually remapped EFI runtime services table pointer */
 	efi.runtime = READ_ONCE(systab->runtime);
 
-	if (save_pgd)
-		efi_uv1_memmap_phys_epilog(save_pgd);
-	else
-		efi_switch_mm(efi_scratch.prev_mm);
+	efi_switch_mm(efi_scratch.prev_mm);
 
 	return status;
 }
--- linux.orig/arch/x86/platform/efi/quirks.c	2020-07-07 10:56:15.209045740 -0500
+++ linux/arch/x86/platform/efi/quirks.c	2020-07-07 10:56:15.409045500 -0500
@@ -381,14 +381,6 @@ static void __init efi_unmap_pages(efi_m
 	u64 va = md->virt_addr;
 
 	/*
-	 * To Do: Remove this check after adding functionality to unmap EFI boot
-	 * services code/data regions from direct mapping area because the UV1
-	 * memory map maps EFI regions in swapper_pg_dir.
-	 */
-	if (efi_have_uv1_memmap())
-		return;
-
-	/*
 	 * EFI mixed mode has all RAM mapped to access arguments while making
 	 * EFI runtime calls, hence don't unmap EFI boot services code/data
 	 * regions.

