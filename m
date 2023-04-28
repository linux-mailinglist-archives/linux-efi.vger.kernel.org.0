Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7C6F14B6
	for <lists+linux-efi@lfdr.de>; Fri, 28 Apr 2023 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjD1J4k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Apr 2023 05:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345925AbjD1J4G (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Apr 2023 05:56:06 -0400
Received: from out187-16.us.a.mail.aliyun.com (out187-16.us.a.mail.aliyun.com [47.90.187.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317A5584;
        Fri, 28 Apr 2023 02:55:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047213;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=44;SR=0;TI=SMTPD_---.STCEPzg_1682675659;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPzg_1682675659)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:54:20 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Alexander Potapenko" <glider@google.com>,
        "Marco Elver" <elver@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
        "Andrey Konovalov" <andreyknvl@gmail.com>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Darren Hart" <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "=?UTF-8?B?TWlrZSBSYXBvcG9ydCAoSUJNKQ==?=" <rppt@kernel.org>,
        "Guo Ren" <guoren@kernel.org>, "Stafford Horne" <shorne@gmail.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Anshuman Khandual" <anshuman.khandual@arm.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Pasha Tatashin" <pasha.tatashin@soleen.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Brian Gerst" <brgerst@gmail.com>,
        "XueBing Chen" <chenxuebing@jari.cn>,
        "Yuntao Wang" <ytcoode@gmail.com>,
        "Jonathan McDowell" <noodles@fb.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Jane Chu" <jane.chu@oracle.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        "Sean Christopherson" <seanjc@google.com>,
        <kasan-dev@googlegroups.com>, <linux-efi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: [PATCH RFC 42/43] x86/pie: Allow kernel image to be relocated in top 512G
Date:   Fri, 28 Apr 2023 17:51:22 +0800
Message-Id: <e7626d59df5791db397798caaa496796f0b0dff6.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

For PIE kernel image, it could be relocated at any address. To be
simplified, treat the 2G area which including kernel image, modules area
and fixmap area as a whole, allow it to be relocated in top 512G.  After
that, the relocated kernel address may be below than __START_KERNEL_map,
so use a global variable to store the base of relocated kernel image.
And pa/va transformation of kernel image address is adapted.

Suggested-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Thomas Garnier <thgarnie@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/kmsan.h            |  6 ++---
 arch/x86/include/asm/page_64.h          |  8 +++----
 arch/x86/include/asm/page_64_types.h    |  8 +++++++
 arch/x86/include/asm/pgtable_64_types.h | 10 ++++----
 arch/x86/kernel/head64.c                | 32 ++++++++++++++++++-------
 arch/x86/kernel/head_64.S               | 12 ++++++++++
 arch/x86/kernel/setup.c                 |  6 +++++
 arch/x86/mm/dump_pagetables.c           |  9 ++++---
 arch/x86/mm/init_64.c                   |  8 +++----
 arch/x86/mm/kasan_init_64.c             |  4 ++--
 arch/x86/mm/pat/set_memory.c            |  2 +-
 arch/x86/mm/physaddr.c                  | 14 +++++------
 arch/x86/platform/efi/efi_thunk_64.S    |  4 ++++
 13 files changed, 87 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kmsan.h b/arch/x86/include/asm/kmsan.h
index 8fa6ac0e2d76..a635d825342d 100644
--- a/arch/x86/include/asm/kmsan.h
+++ b/arch/x86/include/asm/kmsan.h
@@ -63,16 +63,16 @@ static inline bool kmsan_phys_addr_valid(unsigned long addr)
 static inline bool kmsan_virt_addr_valid(void *addr)
 {
 	unsigned long x = (unsigned long)addr;
-	unsigned long y = x - __START_KERNEL_map;
+	unsigned long y = x - KERNEL_MAP_BASE;
 
-	/* use the carry flag to determine if x was < __START_KERNEL_map */
+	/* use the carry flag to determine if x was < KERNEL_MAP_BASE */
 	if (unlikely(x > y)) {
 		x = y + phys_base;
 
 		if (y >= KERNEL_IMAGE_SIZE)
 			return false;
 	} else {
-		x = y + (__START_KERNEL_map - PAGE_OFFSET);
+		x = y + (KERNEL_MAP_BASE - PAGE_OFFSET);
 
 		/* carry flag will be set if starting x was >= PAGE_OFFSET */
 		if ((x > y) || !kmsan_phys_addr_valid(x))
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index cc6b8e087192..b8692e6cc939 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -20,10 +20,10 @@ extern unsigned long vmemmap_base;
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
-	unsigned long y = x - __START_KERNEL_map;
+	unsigned long y = x - KERNEL_MAP_BASE;
 
-	/* use the carry flag to determine if x was < __START_KERNEL_map */
-	x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
+	/* use the carry flag to determine if x was < KERNEL_MAP_BASE */
+	x = y + ((x > y) ? phys_base : (KERNEL_MAP_BASE - PAGE_OFFSET));
 
 	return x;
 }
@@ -34,7 +34,7 @@ extern unsigned long __phys_addr_symbol(unsigned long);
 #else
 #define __phys_addr(x)		__phys_addr_nodebug(x)
 #define __phys_addr_symbol(x) \
-	((unsigned long)(x) - __START_KERNEL_map + phys_base)
+	((unsigned long)(x) - KERNEL_MAP_BASE + phys_base)
 #endif
 
 #define __phys_reloc_hide(x)	(x)
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e9e2c3ba5923..933d37845064 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -4,6 +4,8 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/kaslr.h>
+
+extern unsigned long kernel_map_base;
 #endif
 
 #ifdef CONFIG_KASAN
@@ -49,6 +51,12 @@
 
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
+#ifdef CONFIG_X86_PIE
+#define KERNEL_MAP_BASE		kernel_map_base
+#else
+#define KERNEL_MAP_BASE		__START_KERNEL_map
+#endif /* CONFIG_X86_PIE */
+
 /* See Documentation/x86/x86_64/mm.rst for a description of the memory map. */
 
 #define __PHYSICAL_MASK_SHIFT	52
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38bf837e3554..3d6951128a07 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -187,14 +187,16 @@ extern unsigned int ptrs_per_p4d;
 #define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
 #endif /* CONFIG_KMSAN */
 
-#define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
+#define RAW_MODULES_VADDR	(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
+#define MODULES_VADDR		(KERNEL_MAP_BASE + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
 #ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
-# define MODULES_END		_AC(0xffffffffff000000, UL)
+# define RAW_MODULES_END       _AC(0xffffffffff000000, UL)
 #else
-# define MODULES_END		_AC(0xfffffffffe000000, UL)
+# define RAW_MODULES_END       _AC(0xfffffffffe000000, UL)
 #endif
-#define MODULES_LEN		(MODULES_END - MODULES_VADDR)
+#define MODULES_LEN		(RAW_MODULES_END - RAW_MODULES_VADDR)
+#define MODULES_END		(MODULES_VADDR + MODULES_LEN)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
 #define ESPFIX_BASE_ADDR	(ESPFIX_PGD_ENTRY << P4D_SHIFT)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index c5cd61aab8ae..234ac796863a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -66,6 +66,11 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
+#ifdef CONFIG_X86_PIE
+unsigned long kernel_map_base __ro_after_init = __START_KERNEL_map;
+EXPORT_SYMBOL(kernel_map_base);
+#endif
+
 /*
  * GDT used on the boot CPU before switching to virtual addresses.
  */
@@ -193,6 +198,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 {
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
+	unsigned long kernel_map_base_offset = 0;
 	pgdval_t *pgd;
 	p4dval_t *p4d;
 	pudval_t *pud;
@@ -252,6 +258,13 @@ unsigned long __head __startup_64(unsigned long physaddr,
 		pud[511] += load_delta;
 	}
 
+#ifdef CONFIG_X86_PIE
+	kernel_map_base_offset = text_base & PUD_MASK;
+	*fixup_long(&kernel_map_base, physaddr) = kernel_map_base_offset;
+	kernel_map_base_offset -= __START_KERNEL_map;
+	*fixup_long(&__FIXADDR_TOP, physaddr) += kernel_map_base_offset;
+#endif
+
 	pmd = fixup_pointer(level2_fixmap_pgt, physaddr);
 	for (i = FIXMAP_PMD_TOP; i > FIXMAP_PMD_TOP - FIXMAP_PMD_NUM; i--)
 		pmd[i] += load_delta;
@@ -328,7 +341,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	/* fixup pages that are part of the kernel image */
 	for (; i <= pmd_index(end_base); i++)
 		if (pmd[i] & _PAGE_PRESENT)
-			pmd[i] += load_delta;
+			pmd[i] += load_delta + kernel_map_base_offset;
 
 	/* invalidate pages after the kernel image */
 	for (; i < PTRS_PER_PMD; i++)
@@ -338,7 +351,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 * Fixup phys_base - remove the memory encryption mask to obtain
 	 * the true physical address.
 	 */
-	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
+	*fixup_long(&phys_base, physaddr) += load_delta + kernel_map_base_offset -
+					     sme_get_me_mask();
 
 	return sme_postprocess_startup(bp, pmd);
 }
@@ -376,7 +390,7 @@ bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 	if (!pgtable_l5_enabled())
 		p4d_p = pgd_p;
 	else if (pgd)
-		p4d_p = (p4dval_t *)((pgd & PTE_PFN_MASK) + __START_KERNEL_map - phys_base);
+		p4d_p = (p4dval_t *)((pgd & PTE_PFN_MASK) + KERNEL_MAP_BASE - phys_base);
 	else {
 		if (next_early_pgt >= EARLY_DYNAMIC_PAGE_TABLES) {
 			reset_early_page_tables();
@@ -385,13 +399,13 @@ bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 
 		p4d_p = (p4dval_t *)early_dynamic_pgts[next_early_pgt++];
 		memset(p4d_p, 0, sizeof(*p4d_p) * PTRS_PER_P4D);
-		*pgd_p = (pgdval_t)p4d_p - __START_KERNEL_map + phys_base + _KERNPG_TABLE;
+		*pgd_p = (pgdval_t)p4d_p - KERNEL_MAP_BASE + phys_base + _KERNPG_TABLE;
 	}
 	p4d_p += p4d_index(address);
 	p4d = *p4d_p;
 
 	if (p4d)
-		pud_p = (pudval_t *)((p4d & PTE_PFN_MASK) + __START_KERNEL_map - phys_base);
+		pud_p = (pudval_t *)((p4d & PTE_PFN_MASK) + KERNEL_MAP_BASE - phys_base);
 	else {
 		if (next_early_pgt >= EARLY_DYNAMIC_PAGE_TABLES) {
 			reset_early_page_tables();
@@ -400,13 +414,13 @@ bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 
 		pud_p = (pudval_t *)early_dynamic_pgts[next_early_pgt++];
 		memset(pud_p, 0, sizeof(*pud_p) * PTRS_PER_PUD);
-		*p4d_p = (p4dval_t)pud_p - __START_KERNEL_map + phys_base + _KERNPG_TABLE;
+		*p4d_p = (p4dval_t)pud_p - KERNEL_MAP_BASE + phys_base + _KERNPG_TABLE;
 	}
 	pud_p += pud_index(address);
 	pud = *pud_p;
 
 	if (pud)
-		pmd_p = (pmdval_t *)((pud & PTE_PFN_MASK) + __START_KERNEL_map - phys_base);
+		pmd_p = (pmdval_t *)((pud & PTE_PFN_MASK) + KERNEL_MAP_BASE - phys_base);
 	else {
 		if (next_early_pgt >= EARLY_DYNAMIC_PAGE_TABLES) {
 			reset_early_page_tables();
@@ -415,7 +429,7 @@ bool __init __early_make_pgtable(unsigned long address, pmdval_t pmd)
 
 		pmd_p = (pmdval_t *)early_dynamic_pgts[next_early_pgt++];
 		memset(pmd_p, 0, sizeof(*pmd_p) * PTRS_PER_PMD);
-		*pud_p = (pudval_t)pmd_p - __START_KERNEL_map + phys_base + _KERNPG_TABLE;
+		*pud_p = (pudval_t)pmd_p - KERNEL_MAP_BASE + phys_base + _KERNPG_TABLE;
 	}
 	pmd_p[pmd_index(address)] = pmd;
 
@@ -497,6 +511,7 @@ static void __init copy_bootdata(char *real_mode_data)
 
 asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode_data)
 {
+#ifndef CONFIG_X86_PIE
 	/*
 	 * Build-time sanity checks on the kernel image and module
 	 * area mappings. (these are purely build-time and produce no code)
@@ -509,6 +524,7 @@ asmlinkage __visible void __init __noreturn x86_64_start_kernel(char * real_mode
 	BUILD_BUG_ON(!(MODULES_VADDR > __START_KERNEL));
 	MAYBE_BUILD_BUG_ON(!(((MODULES_END - 1) & PGDIR_MASK) ==
 				(__START_KERNEL & PGDIR_MASK)));
+#endif
 
 	cr4_init_shadow();
 
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 19cb2852238b..feb14304d1ed 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -130,7 +130,13 @@ SYM_CODE_START_NOALIGN(startup_64)
 	popq	%rsi
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
+#ifdef CONFIG_X86_PIE
+	movq	kernel_map_base(%rip), %rdi
+	movabs	$early_top_pgt, %rcx
+	subq	%rdi, %rcx
+#else
 	movabs  $(early_top_pgt - __START_KERNEL_map), %rcx
+#endif
 	addq    %rcx, %rax
 	jmp 1f
 SYM_CODE_END(startup_64)
@@ -179,7 +185,13 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 #endif
 
 	/* Form the CR3 value being sure to include the CR3 modifier */
+#ifdef CONFIG_X86_PIE
+	movq	kernel_map_base(%rip), %rdi
+	movabs	$init_top_pgt, %rcx
+	subq	%rdi, %rcx
+#else
 	movabs	$(init_top_pgt - __START_KERNEL_map), %rcx
+#endif
 	addq    %rcx, %rax
 1:
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 16babff771bd..e68ca78b829c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -808,11 +808,17 @@ static int
 dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 {
 	if (kaslr_enabled()) {
+#ifdef CONFIG_X86_PIE
+		pr_emerg("Kernel Offset: 0x%lx from 0x%lx\n",
+			kaslr_offset(),
+			__START_KERNEL);
+#else
 		pr_emerg("Kernel Offset: 0x%lx from 0x%lx (relocation range: 0x%lx-0x%lx)\n",
 			 kaslr_offset(),
 			 __START_KERNEL,
 			 __START_KERNEL_map,
 			 MODULES_VADDR-1);
+#endif
 	} else {
 		pr_emerg("Kernel Offset: disabled\n");
 	}
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 81aa1c0b39cc..d5c6f61242aa 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -102,9 +102,9 @@ static struct addr_marker address_markers[] = {
 #ifdef CONFIG_EFI
 	[EFI_END_NR]		= { EFI_VA_END,		"EFI Runtime Services" },
 #endif
-	[HIGH_KERNEL_NR]	= { __START_KERNEL_map,	"High Kernel Mapping" },
-	[MODULES_VADDR_NR]	= { MODULES_VADDR,	"Modules" },
-	[MODULES_END_NR]	= { MODULES_END,	"End Modules" },
+	[HIGH_KERNEL_NR]	= { 0UL,		"High Kernel Mapping" },
+	[MODULES_VADDR_NR]	= { 0UL,		"Modules" },
+	[MODULES_END_NR]	= { 0UL,		"End Modules" },
 	[FIXADDR_START_NR]	= { 0UL,		"Fixmap Area" },
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
@@ -475,6 +475,9 @@ static int __init pt_dump_init(void)
 	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
 	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
 #endif
+	address_markers[HIGH_KERNEL_NR].start_address = KERNEL_MAP_BASE;
+	address_markers[MODULES_VADDR_NR].start_address = MODULES_VADDR;
+	address_markers[MODULES_END_NR].start_address = MODULES_END;
 	address_markers[FIXADDR_START_NR].start_address = FIXADDR_START;
 #endif
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b7fd05a1ba1d..54bcd46c229d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -413,7 +413,7 @@ void __init init_extra_mapping_uc(unsigned long phys, unsigned long size)
 /*
  * The head.S code sets up the kernel high mapping:
  *
- *   from __START_KERNEL_map to __START_KERNEL_map + size (== _end-_text)
+ *   from KERNEL_MAP_BASE to KERNEL_MAP_BASE + size (== _end-_text)
  *
  * phys_base holds the negative offset to the kernel, which is added
  * to the compile time generated pmds. This results in invalid pmds up
@@ -425,8 +425,8 @@ void __init init_extra_mapping_uc(unsigned long phys, unsigned long size)
  */
 void __init cleanup_highmap(void)
 {
-	unsigned long vaddr = __START_KERNEL_map;
-	unsigned long vaddr_end = __START_KERNEL_map + KERNEL_IMAGE_SIZE;
+	unsigned long vaddr = KERNEL_MAP_BASE;
+	unsigned long vaddr_end = KERNEL_MAP_BASE + KERNEL_IMAGE_SIZE;
 	unsigned long end = roundup((unsigned long)_brk_end, PMD_SIZE) - 1;
 	pmd_t *pmd = level2_kernel_pgt;
 
@@ -436,7 +436,7 @@ void __init cleanup_highmap(void)
 	 *	arch/x86/xen/mmu.c:xen_setup_kernel_pagetable().
 	 */
 	if (max_pfn_mapped)
-		vaddr_end = __START_KERNEL_map + (max_pfn_mapped << PAGE_SHIFT);
+		vaddr_end = KERNEL_MAP_BASE + (max_pfn_mapped << PAGE_SHIFT);
 
 	for (; vaddr + PMD_SIZE - 1 < vaddr_end; pmd++, vaddr += PMD_SIZE) {
 		if (pmd_none(*pmd))
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0302491d799d..0edc8fdfb419 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -197,7 +197,7 @@ static inline p4d_t *early_p4d_offset(pgd_t *pgd, unsigned long addr)
 		return (p4d_t *)pgd;
 
 	p4d = pgd_val(*pgd) & PTE_PFN_MASK;
-	p4d += __START_KERNEL_map - phys_base;
+	p4d += KERNEL_MAP_BASE - phys_base;
 	return (p4d_t *)p4d + p4d_index(addr);
 }
 
@@ -420,7 +420,7 @@ void __init kasan_init(void)
 			      shadow_cea_per_cpu_begin, 0);
 
 	kasan_populate_early_shadow((void *)shadow_cea_end,
-			kasan_mem_to_shadow((void *)__START_KERNEL_map));
+			kasan_mem_to_shadow((void *)KERNEL_MAP_BASE));
 
 	kasan_populate_shadow((unsigned long)kasan_mem_to_shadow(_stext),
 			      (unsigned long)kasan_mem_to_shadow(_end),
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c434aea9939c..2fb89be3a750 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1709,7 +1709,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
 	    __cpa_pfn_in_highmap(cpa->pfn)) {
 		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
-					       __START_KERNEL_map - phys_base;
+					       KERNEL_MAP_BASE - phys_base;
 		alias_cpa = *cpa;
 		alias_cpa.vaddr = &temp_cpa_vaddr;
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
diff --git a/arch/x86/mm/physaddr.c b/arch/x86/mm/physaddr.c
index fc3f3d3e2ef2..9cb6d898329c 100644
--- a/arch/x86/mm/physaddr.c
+++ b/arch/x86/mm/physaddr.c
@@ -14,15 +14,15 @@
 #ifdef CONFIG_DEBUG_VIRTUAL
 unsigned long __phys_addr(unsigned long x)
 {
-	unsigned long y = x - __START_KERNEL_map;
+	unsigned long y = x - KERNEL_MAP_BASE;
 
-	/* use the carry flag to determine if x was < __START_KERNEL_map */
+	/* use the carry flag to determine if x was < KERNEL_MAP_BASE */
 	if (unlikely(x > y)) {
 		x = y + phys_base;
 
 		VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);
 	} else {
-		x = y + (__START_KERNEL_map - PAGE_OFFSET);
+		x = y + (KERNEL_MAP_BASE - PAGE_OFFSET);
 
 		/* carry flag will be set if starting x was >= PAGE_OFFSET */
 		VIRTUAL_BUG_ON((x > y) || !phys_addr_valid(x));
@@ -34,7 +34,7 @@ EXPORT_SYMBOL(__phys_addr);
 
 unsigned long __phys_addr_symbol(unsigned long x)
 {
-	unsigned long y = x - __START_KERNEL_map;
+	unsigned long y = x - KERNEL_MAP_BASE;
 
 	/* only check upper bounds since lower bounds will trigger carry */
 	VIRTUAL_BUG_ON(y >= KERNEL_IMAGE_SIZE);
@@ -46,16 +46,16 @@ EXPORT_SYMBOL(__phys_addr_symbol);
 
 bool __virt_addr_valid(unsigned long x)
 {
-	unsigned long y = x - __START_KERNEL_map;
+	unsigned long y = x - KERNEL_MAP_BASE;
 
-	/* use the carry flag to determine if x was < __START_KERNEL_map */
+	/* use the carry flag to determine if x was < KERNEL_MAP_BASE */
 	if (unlikely(x > y)) {
 		x = y + phys_base;
 
 		if (y >= KERNEL_IMAGE_SIZE)
 			return false;
 	} else {
-		x = y + (__START_KERNEL_map - PAGE_OFFSET);
+		x = y + (KERNEL_MAP_BASE - PAGE_OFFSET);
 
 		/* carry flag will be set if starting x was >= PAGE_OFFSET */
 		if ((x > y) || !phys_addr_valid(x))
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index c4b1144f99f6..0997363821e7 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -52,7 +52,11 @@ STACK_FRAME_NON_STANDARD __efi64_thunk
 	/*
 	 * Calculate the physical address of the kernel text.
 	 */
+#ifdef CONFIG_X86_PIE
+	movq	kernel_map_base(%rip), %rax
+#else
 	movq	$__START_KERNEL_map, %rax
+#endif
 	subq	phys_base(%rip), %rax
 
 	leaq	1f(%rip), %rbp
-- 
2.31.1

