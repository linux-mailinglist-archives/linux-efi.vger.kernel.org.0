Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E1760149E
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJQRSs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiJQRS0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:18:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55B171989
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:18:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F8DCCE1817
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E742C43470;
        Mon, 17 Oct 2022 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027101;
        bh=pn3uv7rgLxZ1qF/hkwLpf5AbiChNI8X5Ui+Q4jez+ok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8/WTUxC/SrRBer1k8VhowsrWfuZetEQ0B08vLSbi2M2flKwuVIwe6jyAclDcUDxM
         3349+sW7CKUHhuPE99ncRaCVkvIA+VeuXWar87wB8bZIhMhpbionfpqdwXo/enIU6h
         bZ8Eojz/eEx8UX8aXwf0DZYjgrHx45a1nfEhipz05OrH4mVvQJQ35xjRLBxcHvzGYP
         Ssr7uRjMPhvMLl+dOtP7V5uN6HS2ujLIwNwQczKdWiT5sCCRiO2ry7U+0EHYEfQ3Vm
         Yu7/LHpT1KzTwuDkXJ1fOlxN2Ik19WHfJnCSWTVH3geH12XX5OtfIBfFoqL23Q9Isi
         a1A9GaqiHxE7g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 19/21] efi/loongarch: Don't jump to kernel entry via the old image
Date:   Mon, 17 Oct 2022 19:16:58 +0200
Message-Id: <20221017171700.3736890-20-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808; i=ardb@kernel.org; h=from:subject; bh=pn3uv7rgLxZ1qF/hkwLpf5AbiChNI8X5Ui+Q4jez+ok=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY4IZ2PoRAFM/JT+vkOW2DBoFSBXayZqnRYpdKbT ooPHSHqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02OCAAKCRDDTyI5ktmPJPMgC/ 9Sn5+mBl/WnYA8wO/uksISMAHyUgfoL3RmbGPuwG/eQuYZm+2HatQOcRTzED+6B3ceHnfOUlSWm6hf b6pyP+/q4Vzty2yW7KQxFhCZGC6svsE0Gb+9i0FIUENbkCiCBdnQ5bRG8dX0qN+eoO2ToZ37lu0EWA z+Mw2gQeaXM2pChzLfMEx1oy+9jKBR3oK891Gh9wBkCqXSD8Jy2iFMjHMirqk3Rn2eHwcF4xqlFtF5 6qESynn5N/uO8n03Omo03pcw+BcMlw6ThjMhoppOb0q+cshkSwVJdklMSoy8mqm4SEgDfahLLSsJ+q P11OOKoWzB8ybrjH1p2sW5pMtOkfmT+qSP8gJ4Hjep4/1MqM5D/YXXYRuTunXz4/snoAnQHP8yYA52 y4/jJQDQlSJNhFiHFK5fwDJs8s2I/0wM4jkCoTi0ptlN87YCRBnjCYmv6OCzoVWIDt/LnpM+L1jiT+ 6RC91FpWyMPqC+5nlBhjLfOTmukKjXfsIuq+h/N9SeoRg=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, the EFI entry code for LoongArch is set up to copy the
executable image to the preferred offset, but instead of branching
directly into that image, it branches to the local copy of kernel_entry,
and relies on the logic in that function to switch to the link time
address instead.

This is a bit sloppy, and not something we can support once we merge the
EFI decompressor with the EFI stub. So let's clean this up a bit, by
adding a helper that computes the offset of kernel_entry from the start
of the image, and simply adding the result to VMLINUX_LOAD_ADDRESS.

And considering that we cannot execute from anywhere else anyway, let's
avoid efi_relocate_kernel() and just allocate the pages instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/loongarch/include/asm/efi.h              |  2 ++
 drivers/firmware/efi/libstub/loongarch-stub.c | 33 ++++++++++++++------
 2 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/include/asm/efi.h b/arch/loongarch/include/asm/efi.h
index 5a470c8d2bbc..97f16e60c6ff 100644
--- a/arch/loongarch/include/asm/efi.h
+++ b/arch/loongarch/include/asm/efi.h
@@ -31,4 +31,6 @@ static inline unsigned long efi_get_kimg_min_align(void)
 
 #define EFI_KIMG_PREFERRED_ADDRESS	PHYSADDR(VMLINUX_LOAD_ADDRESS)
 
+unsigned long kernel_entry_address(void);
+
 #endif /* _ASM_LOONGARCH_EFI_H */
diff --git a/drivers/firmware/efi/libstub/loongarch-stub.c b/drivers/firmware/efi/libstub/loongarch-stub.c
index a2e55e5c4003..6b30fc281458 100644
--- a/drivers/firmware/efi/libstub/loongarch-stub.c
+++ b/drivers/firmware/efi/libstub/loongarch-stub.c
@@ -29,18 +29,27 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 				 efi_loaded_image_t *image,
 				 efi_handle_t image_handle)
 {
+	int nr_pages = round_up(kernel_asize, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
+	efi_physical_addr_t kernel_addr = EFI_KIMG_PREFERRED_ADDRESS;
 	efi_status_t status;
-	unsigned long kernel_addr = 0;
 
-	kernel_addr = (unsigned long)&kernel_offset - kernel_offset;
-
-	status = efi_relocate_kernel(&kernel_addr, kernel_fsize, kernel_asize,
-				     EFI_KIMG_PREFERRED_ADDRESS,
-				     efi_get_kimg_min_align(), 0x0);
+	/*
+	 * Allocate space for the kernel image at the preferred offset. This is
+	 * the only location in memory from where we can execute the image, so
+	 * no point in falling back to another allocation.
+	 */
+	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
+			     EFI_LOADER_DATA, nr_pages, &kernel_addr);
+	if (status != EFI_SUCCESS)
+		return status;
 
-	*image_addr = kernel_addr;
+	*image_addr = EFI_KIMG_PREFERRED_ADDRESS;
 	*image_size = kernel_asize;
 
+	memcpy((void *)EFI_KIMG_PREFERRED_ADDRESS,
+	       (void *)&kernel_offset - kernel_offset,
+	       kernel_fsize);
+
 	return status;
 }
 
@@ -64,6 +73,13 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map, void *priv)
 	return EFI_SUCCESS;
 }
 
+unsigned long kernel_entry_address(void)
+{
+	unsigned long base = (unsigned long)&kernel_offset - kernel_offset;
+
+	return (unsigned long)&kernel_entry - base + VMLINUX_LOAD_ADDRESS;
+}
+
 efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 			     unsigned long kernel_addr, char *cmdline_ptr)
 {
@@ -95,8 +111,7 @@ efi_status_t efi_boot_kernel(void *handle, efi_loaded_image_t *image,
 	csr_write64(CSR_DMW0_INIT, LOONGARCH_CSR_DMWIN0);
 	csr_write64(CSR_DMW1_INIT, LOONGARCH_CSR_DMWIN1);
 
-	real_kernel_entry = (kernel_entry_t)
-		((unsigned long)&kernel_entry - kernel_addr + VMLINUX_LOAD_ADDRESS);
+	real_kernel_entry = (void *)kernel_entry_address();
 
 	real_kernel_entry(true, (unsigned long)cmdline_ptr,
 			  (unsigned long)efi_system_table);
-- 
2.35.1

