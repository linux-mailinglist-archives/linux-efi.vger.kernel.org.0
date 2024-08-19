Return-Path: <linux-efi+bounces-1556-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C837F956DFA
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD4C1F23D1A
	for <lists+linux-efi@lfdr.de>; Mon, 19 Aug 2024 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F5A17920A;
	Mon, 19 Aug 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVtoQz+J"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1D1779B1
	for <linux-efi@vger.kernel.org>; Mon, 19 Aug 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079377; cv=none; b=VSTM3FNFcr23KW8PEAEiyLvJYUkkLF5lcgxBR4bV6RnMa1hbsJ9G5qtI1JMbdHlOxloiTMRITK9v6HEG1qJnnUhXEKF6T7xAyDNl80hBpMQK0l8W/Vxv+VIxo7hOaUJX7LnjQq32KnMgyKXyshGGEh6RoOjt3ylZMp2GAoBnRmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079377; c=relaxed/simple;
	bh=ehRAQ21OMPu9VTeAFsmD9ehQvbNSIsV1Aulxae74dQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs7hJok+4nqa7TNCQPwDCB6X56Ye6gdN7EE0azQSYwS6v2r+9yRl6dzbI3QF1j3J3Pq1VfLzV6P3zeVlm9fa2+sbgfFHTT5CEpyMvtIJHbIlsNRhhT8sGOmA8DkmyQOegcVMiiKagYolpbS1E/TMo0485adrK4lw1IMLJLfInIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVtoQz+J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724079375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1wlLI8HeV7ugiPZwClPrcrHBMcL2Ga2rfvmngOKpRU=;
	b=CVtoQz+JoYnvxaLm+l2cMxTw5a7Hh8S+mtQ8OPrbxA+qzDl6GGO/S2F4+FpyQmB//DCDKC
	qLpxNI+F06JMIST9dSH+LX1WZhFAY20Ht9olfUHJC5zsBTK8A4jlo7lTr2MWeV/Z3k3On+
	TqJzU9xdVTBCG/wFYX8DYQJnM5Qy2ac=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-C2pU-VYVONmHz2FowVFgWg-1; Mon,
 19 Aug 2024 10:56:10 -0400
X-MC-Unique: C2pU-VYVONmHz2FowVFgWg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C97BB1955BF2;
	Mon, 19 Aug 2024 14:56:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D257319560A3;
	Mon, 19 Aug 2024 14:55:59 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFCv2 8/9] arm64: kexec: Prepare page table for emulator
Date: Mon, 19 Aug 2024 22:53:41 +0800
Message-ID: <20240819145417.23367-9-piliu@redhat.com>
In-Reply-To: <20240819145417.23367-1-piliu@redhat.com>
References: <20240819145417.23367-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The emulator will run in identity mapping, and the first kernel prepares
for it. The special allocator resorts to kimage_alloc_control_pages(),
which can avoid the allocation on the spot of the destination and
overwritten during copying the kernel.

The identity mapping covers only all of the kexec segments and efi
runtime service.  This reduces the memory consumption of page table.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/machine_kexec.c | 101 ++++++++++++++++++++++++++++--
 include/linux/kexec.h             |   5 +-
 2 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 6958c1fc84a5a..871ee1163ebca 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -14,6 +14,7 @@
 #include <linux/reboot.h>
 #include <linux/set_memory.h>
 #include <linux/smp.h>
+#include <linux/efi_emulator.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -86,8 +87,22 @@ static void kexec_segment_flush(const struct kimage *kimage)
 	}
 }
 
+/* todo: alloc page for the pgtable used by efi emulator in crashkernel range */
+static phys_addr_t crash_page_alloc(int unused, void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	int i;
+
+	//skip kimage->segment[].mem
+	for (i = 0; i < kimage->nr_segments; i ++) {
+		//seg = &kimage->segment[i];
+	}
+	//skip any range allocated
+	return -1;
+}
+
 /* Allocates pages for kexec page table */
-static void *kexec_page_alloc(void *arg)
+static void *__kexec_page_alloc(void *arg)
 {
 	struct kimage *kimage = arg;
 	struct page *page = kimage_alloc_control_pages(kimage, 0);
@@ -102,6 +117,82 @@ static void *kexec_page_alloc(void *arg)
 	return vaddr;
 }
 
+static phys_addr_t kexec_page_alloc(int unused, void *arg)
+{
+	void *vaddr;
+
+	vaddr = __kexec_page_alloc(arg);
+	if (!vaddr)
+		return (phys_addr_t)-1;
+	return virt_to_phys(vaddr);
+}
+
+/*
+ * This function should be called after all kimage segments have been profiled 
+ * Return physical address of page table's root
+ */
+phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage,
+		struct efi_emulator_param *param)
+{
+	efi_memory_desc_t *md;
+	struct kexec_segment *seg;
+	unsigned long paddr, vaddr, sz;
+	pgd_t *pgd;
+	typedef phys_addr_t (* alloc_fn)(int, void *);
+	alloc_fn alloc;
+	phys_addr_t pgd_paddr;
+	int i;
+
+	/*
+	 * Set up pgtable of emulator, either for crash or for reboot.
+	 * All of the segments have been profiled, and kimage_alloc_normal_control_pages()
+	 * will allocate page in safe zone.
+	 * On the other hand, these pages are not in any segment, which means they are
+	 * left, not copied. Hence the radix tree laying out on them is not broken.
+	 */
+	if (kimage->head & IND_DONE)
+		alloc = crash_page_alloc;
+	else
+		alloc = kexec_page_alloc;
+	pgd_paddr = alloc(0, kimage);
+	pgd = (pgd_t *)phys_to_virt(pgd_paddr);
+	for (i = 0; i < kimage->nr_segments; i ++) {
+		seg = &kimage->segment[i];
+		paddr = ALIGN_DOWN(seg->mem, PAGE_SIZE);
+		sz = ALIGN(seg->mem - paddr + seg->memsz, PAGE_SIZE);
+		kexec_dprintk("Set up mapping for phyaddr: 0x%lx, size:0x%lx", paddr, sz);
+		//todo: distinguish executable segment
+		__create_pgd_mapping_locked(pgd, paddr, paddr, sz,
+				PAGE_KERNEL_EXEC, alloc, kimage, 0);
+	}
+
+	/*
+	 * UEFI stub can call EFI runtime service either before or after one-shot
+	 * SetVirtualAddressMap(). That means the mapping for
+	 * EFI_RUNTIME_SERVICES_CODE/_DATA should be set up here.
+	 * And the virtual address range occupied by md must be reserved,
+	 * accordingly, its physical address should not be allocated by kexec
+	 * allocator
+	 */
+	for_each_efi_memory_desc(md) {
+		if (md->attribute & EFI_MEMORY_RUNTIME) {
+			vaddr = md->virt_addr;
+			paddr = md->phys_addr;
+			sz = md->num_pages * EFI_PAGE_SIZE;
+			kexec_dprintk("Set up mapping for md phyaddr: 0x%lx, virt: 0x%lx, size:0x%lx", paddr, vaddr, sz);
+			__create_pgd_mapping_locked(pgd, paddr, vaddr, sz,
+					PAGE_KERNEL_EXEC, alloc, kimage, 0);
+		}
+	}
+
+	if (param->print_enabled)
+		__create_pgd_mapping_locked(pgd, param->earlycon_reg_base,
+				param->earlycon_reg_base, param->earlycon_reg_sz,
+				pgprot_device(PAGE_KERNEL), alloc, kimage, 0);
+
+	return pgd_paddr;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	int rc;
@@ -109,7 +200,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	long reloc_size;
 	struct trans_pgd_info info = {
-		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_page	= __kexec_page_alloc,
 		.trans_alloc_arg	= kimage,
 	};
 
@@ -129,7 +220,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 	}
 
 	/* Create a copy of the linear map */
-	trans_pgd = kexec_page_alloc(kimage);
+	trans_pgd = __kexec_page_alloc(kimage);
 	if (!trans_pgd)
 		return -ENOMEM;
 	rc = trans_pgd_create_copy(&info, &trans_pgd, PAGE_OFFSET, PAGE_END);
@@ -145,6 +236,7 @@ int machine_kexec_post_load(struct kimage *kimage)
 				  &kimage->arch.t0sz, reloc_code);
 	if (rc)
 		return rc;
+
 	kimage->arch.phys_offset = virt_to_phys(kimage) - (long)kimage;
 
 	/* Flush the reloc_code in preparation for its execution. */
@@ -175,7 +267,6 @@ void machine_kexec(struct kimage *kimage)
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
 	pr_info("Bye!\n");
-
 	local_daif_mask();
 
 	/*
@@ -192,6 +283,7 @@ void machine_kexec(struct kimage *kimage)
 
 		cpu_install_idmap();
 		restart = (void *)__pa_symbol(cpu_soft_restart);
+		/* kimage->start can be either the entry of kernel or efi emulator */
 		restart(is_hyp_nvhe(), kimage->start, kimage->arch.param_mem,
 			0, 0);
 	} else {
@@ -201,6 +293,7 @@ void machine_kexec(struct kimage *kimage)
 			__hyp_set_vectors(kimage->arch.el2_vectors);
 		cpu_install_ttbr0(kimage->arch.ttbr0, kimage->arch.t0sz);
 		kernel_reloc = (void *)kimage->arch.kern_reloc;
+		//tell between the emulator and normal kernel inside the relocate code 
 		kernel_reloc(kimage);
 	}
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 57b98bcaa5228..1599c21e7c5d5 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -22,6 +22,7 @@
 
 #include <uapi/linux/kexec.h>
 #include <linux/verification.h>
+#include <linux/efi_emulator.h>
 
 extern note_buf_t __percpu *crash_notes;
 
@@ -464,7 +465,9 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
-extern phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage);
+extern phys_addr_t arch_emulator_prepare_pgtable(struct kimage *kimage,
+		struct efi_emulator_param *param);
+
 extern bool kexec_file_dbg_print;
 
 #define kexec_dprintk(fmt, arg...) \
-- 
2.41.0


