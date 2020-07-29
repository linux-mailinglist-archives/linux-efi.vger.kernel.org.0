Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3851232838
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgG2XhR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 19:37:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22294 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728097AbgG2Xgz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 19:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596065815; x=1627601815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DyEurdMM7t8WzBtZdDLIioAaOEsgMahGYE+/JYR6gZQ=;
  b=jW4SYwcvGtexJYaO1Dt18y5UXgzdJ/y2V3luFZVSjR4GuN0UDnKGzfam
   rsHji590mHXimLKWqUisDnfjaz2Gj+YBroky3Bg/yyGH5V910QmiuBjg7
   0CAxhz8hA/uGgD+oPxRd7ladvNQX/CLr856Em1R5iYZd2vbjU+Lj++/3H
   5i1dcDhACFhqeTonOfxIxCqexg/oNsfmqN7Si0D7R30Ptp6ZIsjGhri0+
   bulPKywEt16ELXMvqftcWo+qE0pS3pnD0V0Vmw604C3vZ4rbJXQ1LXC+6
   BIHisjdR5cye+pDBN/epqQWiXuJR+XCKx1Xn7q+nFNLYvCHdsHY8c7LW9
   A==;
IronPort-SDR: 8Y/LR+e7L84GN7CEvjn8Gbtsk9N4N2KOR1BMpbksmWuFOJMMmZ+82FBrdh5MIZjEqe+F7GRHtR
 7hsLlOgv3cSSZf1bYrq4HPrkylR9cP7etVTZgWLQJpWtXdU9vRzHCuXA34aseVqYDe0Wkralbv
 FXPkihy2d/03NSWYLtZaZ3xcCf60lYmdcwM1wnDl01IOg9SywZlJ85H2XsmpHxsO+UGzhtBWUe
 +TQdsHWD5SFxXTae5gUshRKbBTyb/kBW8NUOtxrSU2qbztjnOvV02qAJLRI571b8h9w6kahKhg
 54M=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="144951800"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 07:36:54 +0800
IronPort-SDR: bFGQCEi2Q9DjKf7iJlN0WlSjakK07zel8WTKQE/3T0JJrdDPbRpc/qnQLYdDIDvTc+og3buV4T
 IU/kHT/Bvl0I0XQOgMrPj9Bnkyn4kh9ls=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:25:01 -0700
IronPort-SDR: pZDzXPWULnCuyCiOuS3QpLbSXXunBDLbHFoUdamqzzwaKyWJ2yyNVRytnIpaFbvwyr1lpG/qvq
 LT0Yr1745Ljw==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2020 16:36:54 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: [RFT PATCH v4 3/9] RISC-V: Implement late mapping page table allocation functions
Date:   Wed, 29 Jul 2020 16:36:29 -0700
Message-Id: <20200729233635.14406-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200729233635.14406-1-atish.patra@wdc.com>
References: <20200729233635.14406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, page table setup is done during setup_va_final where fixmap can
be used to create the temporary mappings. The physical frame is allocated
from memblock_alloc_* functions. However, this won't work if page table
mapping needs to be created for a different mm context (i.e. efi mm) at
a later point of time.

Use generic kernel page allocation function & macros for any mapping
after setup_vm_final.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 68c608a0e91f..cba03fec08c1 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -212,6 +212,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 static bool mmu_enabled;
+static bool late_mapping;
 
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
 
@@ -236,7 +237,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 
 static pte_t *__init get_pte_virt(phys_addr_t pa)
 {
-	if (mmu_enabled) {
+	if (late_mapping)
+		return (pte_t *) __va(pa);
+	else if (mmu_enabled) {
 		clear_fixmap(FIX_PTE);
 		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 	} else {
@@ -246,13 +249,19 @@ static pte_t *__init get_pte_virt(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pte(uintptr_t va)
 {
+	unsigned long vaddr;
 	/*
 	 * We only create PMD or PGD early mappings so we
 	 * should never reach here with MMU disabled.
 	 */
 	BUG_ON(!mmu_enabled);
-
-	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+	if (late_mapping) {
+		vaddr = __get_free_page(GFP_KERNEL);
+		if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
+			BUG();
+		return __pa(vaddr);
+	} else
+		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
 static void __init create_pte_mapping(pte_t *ptep,
@@ -281,7 +290,9 @@ pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt(phys_addr_t pa)
 {
-	if (mmu_enabled) {
+	if (late_mapping)
+		return (pmd_t *) __va(pa);
+	else if (mmu_enabled) {
 		clear_fixmap(FIX_PMD);
 		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 	} else {
@@ -292,8 +303,13 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
 static phys_addr_t __init alloc_pmd(uintptr_t va)
 {
 	uintptr_t pmd_num;
+	unsigned long vaddr;
 
-	if (mmu_enabled)
+	if (late_mapping) {
+		vaddr = __get_free_page(GFP_KERNEL);
+		BUG_ON(!vaddr);
+		return __pa(vaddr);
+	} else if (mmu_enabled)
 		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 
 	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
@@ -533,6 +549,9 @@ static void __init setup_vm_final(void)
 	/* Move to swapper page table */
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
+
+	/* generic page allocation function must be used to setup page table */
+	late_mapping = true;
 }
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
-- 
2.24.0

