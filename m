Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91A541B728
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 21:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242462AbhI1TMM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 15:12:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41284 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242404AbhI1TMI (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 28 Sep 2021 15:12:08 -0400
Received: from zn.tnic (p200300ec2f13b20078349fd04295260b.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:7834:9fd0:4295:260b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D73F01EC0758;
        Tue, 28 Sep 2021 21:10:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632856224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xuBkPqpCyWNevmjV3bnFgYXgef5NjlBoPtZLL0ekMdo=;
        b=cg+k4SGFGxEbKI8CV0vT1wiATRXzFrE1+YP3SiLZh58JiMB8hwzIVyPVwP6jZKAVfX8fDQ
        0cfbR4Pxt8ydhPdF32dRpK9PPsAKSvfcJ1FebN0Za5Vsx7w52Q2WefRdjf2msTdPZTZoKu
        UvpFb3DAoRHJGV01hdmU6SoZTGUfZ3Y=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org
Subject: [PATCH 6/8] x86/sev: Replace occurrences of sev_active() with cc_platform_has()
Date:   Tue, 28 Sep 2021 21:10:07 +0200
Message-Id: <20210928191009.32551-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
References: <20210928191009.32551-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Replace uses of sev_active() with the more generic cc_platform_has()
using CC_ATTR_GUEST_MEM_ENCRYPT. If future support is added for other
memory encryption technologies, the use of CC_ATTR_GUEST_MEM_ENCRYPT
can be updated, as required.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/mem_encrypt.h |  2 --
 arch/x86/kernel/crash_dump_64.c    |  4 +++-
 arch/x86/kernel/kvm.c              |  3 ++-
 arch/x86/kernel/kvmclock.c         |  4 ++--
 arch/x86/kernel/machine_kexec_64.c |  4 ++--
 arch/x86/kvm/svm/svm.c             |  3 ++-
 arch/x86/mm/ioremap.c              |  6 +++---
 arch/x86/mm/mem_encrypt.c          | 21 ++++++++-------------
 arch/x86/platform/efi/efi_64.c     |  9 +++++----
 9 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 63c5b99ccae5..a5a58ccd1ee3 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sev_active(void);
 bool sev_es_active(void);
 
 #define __bss_decrypted __section(".bss..decrypted")
@@ -75,7 +74,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 
 static inline int __init
diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
index 045e82e8945b..a7f617a3981d 100644
--- a/arch/x86/kernel/crash_dump_64.c
+++ b/arch/x86/kernel/crash_dump_64.c
@@ -10,6 +10,7 @@
 #include <linux/crash_dump.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/cc_platform.h>
 
 static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 				  unsigned long offset, int userbuf,
@@ -73,5 +74,6 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
 
 ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
 {
-	return read_from_oldmem(buf, count, ppos, 0, sev_active());
+	return read_from_oldmem(buf, count, ppos, 0,
+				cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index b656456c3a94..8863d1941f1b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -27,6 +27,7 @@
 #include <linux/nmi.h>
 #include <linux/swait.h>
 #include <linux/syscore_ops.h>
+#include <linux/cc_platform.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -418,7 +419,7 @@ static void __init sev_map_percpu_data(void)
 {
 	int cpu;
 
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index ad273e5861c1..fc3930c5db1b 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -16,9 +16,9 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
+#include <linux/cc_platform.h>
 
 #include <asm/hypervisor.h>
-#include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/kvmclock.h>
 
@@ -232,7 +232,7 @@ static void __init kvmclock_init_mem(void)
 	 * hvclock is shared between the guest and the hypervisor, must
 	 * be mapped decrypted.
 	 */
-	if (sev_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		r = set_memory_decrypted((unsigned long) hvclock_mem,
 					 1UL << order);
 		if (r) {
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 7040c0fa921c..f5da4a18070a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -167,7 +167,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	}
 	pte = pte_offset_kernel(pmd, vaddr);
 
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		prot = PAGE_KERNEL_EXEC;
 
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
@@ -207,7 +207,7 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	level4p = (pgd_t *)__va(start_pgtable);
 	clear_page(level4p);
 
-	if (sev_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		info.page_flag   |= _PAGE_ENC;
 		info.kernpg_flag |= _PAGE_ENC;
 	}
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 05e8d4d27969..a2f78a8cfdaa 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/rwsem.h>
+#include <linux/cc_platform.h>
 
 #include <asm/apic.h>
 #include <asm/perf_event.h>
@@ -455,7 +456,7 @@ static int has_svm(void)
 		return 0;
 	}
 
-	if (sev_active()) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 		pr_info("KVM is unsupported when running as an SEV guest\n");
 		return 0;
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index a7250fa3d45f..b59a5cbc6bc5 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -92,7 +92,7 @@ static unsigned int __ioremap_check_ram(struct resource *res)
  */
 static unsigned int __ioremap_check_encrypted(struct resource *res)
 {
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return 0;
 
 	switch (res->desc) {
@@ -112,7 +112,7 @@ static unsigned int __ioremap_check_encrypted(struct resource *res)
  */
 static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *desc)
 {
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	if (!IS_ENABLED(CONFIG_EFI))
@@ -556,7 +556,7 @@ static bool memremap_should_map_decrypted(resource_size_t phys_addr,
 	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 		/* For SEV, these areas are encrypted */
-		if (sev_active())
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 			break;
 		fallthrough;
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 2163485a74e1..932007a6913b 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -194,7 +194,7 @@ void __init sme_early_init(void)
 	for (i = 0; i < ARRAY_SIZE(protection_map); i++)
 		protection_map[i] = pgprot_encrypted(protection_map[i]);
 
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		swiotlb_force = SWIOTLB_FORCE;
 }
 
@@ -203,7 +203,7 @@ void __init sev_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
-	if (!sev_active())
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
 	/*
@@ -364,8 +364,8 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 /*
  * SME and SEV are very similar but they are not the same, so there are
  * times that the kernel will need to distinguish between SME and SEV. The
- * sme_active() and sev_active() functions are used for this.  When a
- * distinction isn't needed, the mem_encrypt_active() function can be used.
+ * cc_platform_has() function is used for this.  When a distinction isn't
+ * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
  *
  * The trampoline code is a good example for this requirement.  Before
  * paging is activated, SME will access all memory as decrypted, but SEV
@@ -373,11 +373,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
  * up under SME the trampoline area cannot be encrypted, whereas under SEV
  * the trampoline area must be encrypted.
  */
-bool sev_active(void)
-{
-	return sev_status & MSR_AMD64_SEV_ENABLED;
-}
-EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
 bool noinstr sev_es_active(void)
@@ -391,7 +386,7 @@ bool force_dma_unencrypted(struct device *dev)
 	/*
 	 * For SEV, all DMA must be to unencrypted addresses.
 	 */
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return true;
 
 	/*
@@ -450,7 +445,7 @@ static void print_mem_encrypt_feature_info(void)
 	}
 
 	/* Secure Encrypted Virtualization */
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
@@ -473,7 +468,7 @@ void __init mem_encrypt_init(void)
 	 * With SEV, we need to unroll the rep string I/O instructions,
 	 * but SEV-ES supports them through the #VC handler.
 	 */
-	if (sev_active() && !sev_es_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) && !sev_es_active())
 		static_branch_enable(&sev_enable_key);
 
 	print_mem_encrypt_feature_info();
@@ -481,6 +476,6 @@ void __init mem_encrypt_init(void)
 
 int arch_has_restricted_virtio_memory_access(void)
 {
-	return sev_active();
+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
 }
 EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 7515e78ef898..1f3675453a57 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -33,7 +33,7 @@
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/ucs2_string.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/sched/task.h>
 
 #include <asm/setup.h>
@@ -284,7 +284,8 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
 	if (!(md->attribute & EFI_MEMORY_WB))
 		flags |= _PAGE_PCD;
 
-	if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	    md->type != EFI_MEMORY_MAPPED_IO)
 		flags |= _PAGE_ENC;
 
 	pfn = md->phys_addr >> PAGE_SHIFT;
@@ -390,7 +391,7 @@ static int __init efi_update_mem_attr(struct mm_struct *mm, efi_memory_desc_t *m
 	if (!(md->attribute & EFI_MEMORY_RO))
 		pf |= _PAGE_RW;
 
-	if (sev_active())
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		pf |= _PAGE_ENC;
 
 	return efi_update_mappings(md, pf);
@@ -438,7 +439,7 @@ void __init efi_runtime_update_mappings(void)
 			(md->type != EFI_RUNTIME_SERVICES_CODE))
 			pf |= _PAGE_RW;
 
-		if (sev_active())
+		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 			pf |= _PAGE_ENC;
 
 		efi_update_mappings(md, pf);
-- 
2.29.2

