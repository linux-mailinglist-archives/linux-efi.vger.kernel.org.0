Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498F941B70D
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 21:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242450AbhI1TML (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 15:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbhI1TMI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 15:12:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABCC06161C;
        Tue, 28 Sep 2021 12:10:24 -0700 (PDT)
Received: from zn.tnic (p200300ec2f13b20078349fd04295260b.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:b200:7834:9fd0:4295:260b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 993D01EC0779;
        Tue, 28 Sep 2021 21:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632856222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lL0AvGZ0cRGZkAOxlyOt/8l8PjtH/LtVpdXS0Fviles=;
        b=QWPhSIROzz/+Ws+H1ihgFrVRQQVq0N/1Uo5iJdrdZu1Ij4DWV7vqJoOV3PvMuLyovDC9Ly
        LlfjD89Ijyk+E2m6tyT23cx0Ka+YDO5YvVHGWCDGlpVo5u0OKljMCUWwhlyElKwbX1Bs6s
        4+8zEAwu3jTorm4wXgoyzxUtF8CxJX4=
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
Subject: [PATCH 5/8] x86/sme: Replace occurrences of sme_active() with cc_platform_has()
Date:   Tue, 28 Sep 2021 21:10:06 +0200
Message-Id: <20210928191009.32551-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210928191009.32551-1-bp@alien8.de>
References: <20210928191009.32551-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Tom Lendacky <thomas.lendacky@amd.com>

Replace uses of sme_active() with the more generic cc_platform_has()
using CC_ATTR_HOST_MEM_ENCRYPT. If future support is added for other
memory encryption technologies, the use of CC_ATTR_HOST_MEM_ENCRYPT
can be updated, as required.

This also replaces two usages of sev_active() that are really geared
towards detecting if SME is active.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/include/asm/mem_encrypt.h   |  2 --
 arch/x86/kernel/machine_kexec_64.c   | 15 ++++++++-------
 arch/x86/kernel/pci-swiotlb.c        |  9 ++++-----
 arch/x86/kernel/relocate_kernel_64.S |  2 +-
 arch/x86/mm/ioremap.c                |  6 +++---
 arch/x86/mm/mem_encrypt.c            | 13 ++++---------
 arch/x86/mm/mem_encrypt_identity.c   |  9 ++++++++-
 arch/x86/realmode/init.c             |  5 +++--
 drivers/iommu/amd/init.c             |  7 ++++---
 10 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 0a6e34b07017..11b7c06e2828 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -129,7 +129,7 @@ relocate_kernel(unsigned long indirection_page,
 		unsigned long page_list,
 		unsigned long start_address,
 		unsigned int preserve_context,
-		unsigned int sme_active);
+		unsigned int host_mem_enc_active);
 #endif
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 3fb9f5ebefa4..63c5b99ccae5 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool sme_active(void);
 bool sev_active(void);
 bool sev_es_active(void);
 
@@ -76,7 +75,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool sme_active(void) { return false; }
 static inline bool sev_active(void) { return false; }
 static inline bool sev_es_active(void) { return false; }
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 131f30fdcfbd..7040c0fa921c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/cc_platform.h>
 
 #include <asm/init.h>
 #include <asm/tlbflush.h>
@@ -358,7 +359,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       sme_active());
+				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
@@ -569,12 +570,12 @@ void arch_kexec_unprotect_crashkres(void)
  */
 int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 {
-	if (sev_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return 0;
 
 	/*
-	 * If SME is active we need to be sure that kexec pages are
-	 * not encrypted because when we boot to the new kernel the
+	 * If host memory encryption is active we need to be sure that kexec
+	 * pages are not encrypted because when we boot to the new kernel the
 	 * pages won't be accessed encrypted (initially).
 	 */
 	return set_memory_decrypted((unsigned long)vaddr, pages);
@@ -582,12 +583,12 @@ int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, gfp_t gfp)
 
 void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
 {
-	if (sev_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/*
-	 * If SME is active we need to reset the pages back to being
-	 * an encrypted mapping before freeing them.
+	 * If host memory encryption is active we need to reset the pages back
+	 * to being an encrypted mapping before freeing them.
 	 */
 	set_memory_encrypted((unsigned long)vaddr, pages);
 }
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..814ab46a0dad 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -6,7 +6,7 @@
 #include <linux/swiotlb.h>
 #include <linux/memblock.h>
 #include <linux/dma-direct.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/iommu.h>
 #include <asm/swiotlb.h>
@@ -45,11 +45,10 @@ int __init pci_swiotlb_detect_4gb(void)
 		swiotlb = 1;
 
 	/*
-	 * If SME is active then swiotlb will be set to 1 so that bounce
-	 * buffers are allocated and used for devices that do not support
-	 * the addressing range required for the encryption mask.
+	 * Set swiotlb to 1 so that bounce buffers are allocated and used for
+	 * devices that can't support DMA to encrypted memory.
 	 */
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		swiotlb = 1;
 
 	return swiotlb;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c53271aebb64..c8fe74a28143 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -47,7 +47,7 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	 * %rsi page_list
 	 * %rdx start address
 	 * %rcx preserve_context
-	 * %r8  sme_active
+	 * %r8  host_mem_enc_active
 	 */
 
 	/* Save the CPU context, used for jumping back */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index ccff76cedd8f..a7250fa3d45f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/efi.h>
 #include <linux/pgtable.h>
 
@@ -703,7 +703,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
 	if (flags & MEMREMAP_DEC)
 		return false;
 
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		if (memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			return false;
@@ -729,7 +729,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
 
 	encrypted_prot = true;
 
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		if (early_memremap_is_setup_data(phys_addr, size) ||
 		    memremap_is_efi_data(phys_addr, size))
 			encrypted_prot = false;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index e29b1418d00c..2163485a74e1 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	/* Get the command line address before unmapping the real_mode_data */
@@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
 	struct boot_params *boot_data;
 	unsigned long cmdline_paddr;
 
-	if (!sme_active())
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		return;
 
 	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
@@ -377,11 +377,6 @@ bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
-
-bool sme_active(void)
-{
-	return sme_me_mask && !sev_active();
-}
 EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
@@ -404,7 +399,7 @@ bool force_dma_unencrypted(struct device *dev)
 	 * device does not support DMA to addresses that include the
 	 * encryption mask.
 	 */
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
 		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
 						dev->bus_dma_limit);
@@ -445,7 +440,7 @@ static void print_mem_encrypt_feature_info(void)
 	pr_info("AMD Memory Encryption Features active:");
 
 	/* Secure Memory Encryption */
-	if (sme_active()) {
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
 		/*
 		 * SME is mutually exclusive with any of the SEV
 		 * features below.
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 470b20208430..f8c612902038 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -30,6 +30,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -287,7 +288,13 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
 	unsigned long pgtable_area_len;
 	unsigned long decrypted_base;
 
-	if (!sme_active())
+	/*
+	 * This is early code, use an open coded check for SME instead of
+	 * using cc_platform_has(). This eliminates worries about removing
+	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
+	 * function.
+	 */
+	if (!sme_get_me_mask() || sev_status & MSR_AMD64_SEV_ENABLED)
 		return;
 
 	/*
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 31b5856010cb..c878c5ee5a4c 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -3,6 +3,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <linux/pgtable.h>
 
 #include <asm/set_memory.h>
@@ -44,7 +45,7 @@ void __init reserve_real_mode(void)
 static void sme_sev_setup_real_mode(struct trampoline_header *th)
 {
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
 	if (sev_es_active()) {
@@ -81,7 +82,7 @@ static void __init setup_real_mode(void)
 	 * decrypted memory in order to bring up other processors
 	 * successfully. This is not needed for SEV.
 	 */
-	if (sme_active())
+	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		set_memory_decrypted((unsigned long)base, size >> PAGE_SHIFT);
 
 	memcpy(base, real_mode_blob, size);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2a822b229bd0..c6c53e18dace 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -20,7 +20,7 @@
 #include <linux/amd-iommu.h>
 #include <linux/export.h>
 #include <linux/kmemleak.h>
-#include <linux/mem_encrypt.h>
+#include <linux/cc_platform.h>
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
@@ -964,7 +964,7 @@ static bool copy_device_table(void)
 		pr_err("The address of old device table is above 4G, not trustworthy!\n");
 		return false;
 	}
-	old_devtb = (sme_active() && is_kdump_kernel())
+	old_devtb = (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) && is_kdump_kernel())
 		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
 							dev_table_size)
 		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
@@ -3032,7 +3032,8 @@ static int __init amd_iommu_init(void)
 
 static bool amd_iommu_sme_check(void)
 {
-	if (!sme_active() || (boot_cpu_data.x86 != 0x17))
+	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) ||
+	    (boot_cpu_data.x86 != 0x17))
 		return true;
 
 	/* For Fam17h, a specific level of support is required */
-- 
2.29.2

