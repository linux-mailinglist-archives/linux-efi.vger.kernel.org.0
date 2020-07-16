Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41231222F45
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jul 2020 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGPXlq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Jul 2020 19:41:46 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7110 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgGPXlS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Jul 2020 19:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594942877; x=1626478877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BM/mH4XsaV/6iCpj8IfqSeogZjHIyxg63ZlS/DCX0c=;
  b=bWozXJjWX/dLxTFMipke3XG5IhtTUqj4XSYdvBgzXvnjtIcpgjL4Pl6+
   9hbkSYLDgYSh8eINSJdS9rI5SGi/mHKXsHyv0xN2wkM5sDjDwE8vBGLUV
   /TkDZZVy/FZWF90xre1wjNkC2Fxz4JT44vJyLOXBZNwvN9AiKYXP5U0c9
   2CgzfgkUh++BtruY5kcXCtGJjgYBkohLLaAfyhUzElyDe3SK/KI0jueN4
   c1jjn1BH0v9QK9g9b1Cw9KJ9LVb/EIRKYO3+lxPAtRIhRFxYlyPujFjls
   KbVPqeibev9Vpb790t+BO1hGBebUFCQCQ78tA6oWqzJ2CcIXnHrhPUefj
   g==;
IronPort-SDR: E1qMwgvkhJXXAEncXXncfyJ4a/P1BjVROU9A+TlcQ1cgvLxTAOC2ei+mesUBZRCuIWr/FEQVqF
 NfzQOA25+ohKVCme4k5FGKJO7TZ1zTPRI7LpQ3uCm8Vkfw0iBKcgNUc0pKMSOiJOYeHkLomYs9
 bzWN2p8VDrlCxz2qoVlVz9nBgBdboRAdeL2AdUJeS8pDXZCxI1Z8xR/dJbbUdWquxLg+Y+6h0j
 mhQjAzRPKadBgneGzBwzf1anJAuv4ORVTkQMU682LfzbK40kdkF3ptJ9e2sZmcKaUHBqk84Xvx
 fMw=
X-IronPort-AV: E=Sophos;i="5.75,360,1589212800"; 
   d="scan'208";a="251923207"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 07:41:16 +0800
IronPort-SDR: 59Rt/3fG9F5IciexHfeGgmO95EmL3uclDqx+YJIiaQPe1tLY5yFiFRaTMz+W/dmEzlO5BQfZBO
 N9aTNqnNjguHAlhjwMA5ySakMEJYFi/OE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 16:29:40 -0700
IronPort-SDR: 1+ar9xAJ3WTp7oABqVmJQP3GTHTux1IitmQm3mpW+sB48jlZAs+hJYRHCo86g6rEcJCK8R9Kxq
 CuVbwebNiq1g==
WDCIronportException: Internal
Received: from phd004806.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.54])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Jul 2020 16:41:16 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFT PATCH v3 3/9] RISC-V: Implement late mapping page table allocation functions
Date:   Thu, 16 Jul 2020 16:40:58 -0700
Message-Id: <20200716234104.29049-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200716234104.29049-1-atish.patra@wdc.com>
References: <20200716234104.29049-1-atish.patra@wdc.com>
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
index 62c90161765f..9f3129c76985 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -209,6 +209,7 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
 static bool mmu_enabled;
+static bool late_mapping;
 
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
 
@@ -233,7 +234,9 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 
 static pte_t *__init get_pte_virt(phys_addr_t pa)
 {
-	if (mmu_enabled) {
+	if (late_mapping)
+		return (pte_t *) __va(pa);
+	else if (mmu_enabled) {
 		clear_fixmap(FIX_PTE);
 		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
 	} else {
@@ -243,13 +246,19 @@ static pte_t *__init get_pte_virt(phys_addr_t pa)
 
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
@@ -278,7 +287,9 @@ pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt(phys_addr_t pa)
 {
-	if (mmu_enabled) {
+	if (late_mapping)
+		return (pmd_t *) __va(pa);
+	else if (mmu_enabled) {
 		clear_fixmap(FIX_PMD);
 		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
 	} else {
@@ -289,8 +300,13 @@ static pmd_t *__init get_pmd_virt(phys_addr_t pa)
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
@@ -528,6 +544,9 @@ static void __init setup_vm_final(void)
 	/* Move to swapper page table */
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
+
+	/* generic page allocation function must be used to setup page table */
+	late_mapping = true;
 }
 #else
 void *dtb_early_va __initdata;
-- 
2.24.0

