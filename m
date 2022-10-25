Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5229D60CEA7
	for <lists+linux-efi@lfdr.de>; Tue, 25 Oct 2022 16:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiJYOOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Oct 2022 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiJYONu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Oct 2022 10:13:50 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64423A3A98;
        Tue, 25 Oct 2022 07:13:49 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id D439340737A1;
        Tue, 25 Oct 2022 14:13:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D439340737A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1666707227;
        bh=EwGUAT+V+D/fvt7ukarce/X9DVxbqrCy0Vh2rp1s7+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVqWWoXZI9tBYsQ1lkC5/lEq7XnwOexMTfKDrNHL1M/ZC+on1RfeFA7tv+ivI/1Qo
         eEOlnvVGLge1fCmbJEk9UYgrYLqOvD7Xdg+W+c0KhlASU5I7eQ8O5DsdsZ2ZpZyX9w
         V+i3ag0LEcvC/Fr8qcFi5yOroDGOpFJ1P4ab/NwI=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Evgeniy Baskov <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>, lvc-project@linuxtesting.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 10/23] efi/libstub: Move helper function to related file
Date:   Tue, 25 Oct 2022 17:12:48 +0300
Message-Id: <70dd035f58199cb933526303792ef238080a235c.1666705333.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1666705333.git.baskov@ispras.ru>
References: <cover.1666705333.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

efi_adjust_memory_range_protection() can be useful outside x86-stub.c.

Move it to mem.c, where memory related code resides and make it
non-static.

Change its behavior to setup exact attributes and disallow making
memory regions readable and writable simultaneously for supported
configurations.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 drivers/firmware/efi/libstub/efistub.h  |   4 +
 drivers/firmware/efi/libstub/mem.c      | 102 ++++++++++++++++++++++++
 drivers/firmware/efi/libstub/x86-stub.c |  66 ++-------------
 3 files changed, 112 insertions(+), 60 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index a30fb5d8ef05..63f5157341fe 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -917,6 +917,10 @@ efi_status_t efi_relocate_kernel(unsigned long *image_addr,
 				 unsigned long alignment,
 				 unsigned long min_addr);
 
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size,
+						unsigned long attributes);
+
 efi_status_t efi_parse_options(char const *cmdline);
 
 void efi_parse_option_graphics(char *option);
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 45841ef55a9f..cdf1e6fb6430 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -125,3 +125,105 @@ void efi_free(unsigned long size, unsigned long addr)
 	nr_pages = round_up(size, EFI_ALLOC_ALIGN) / EFI_PAGE_SIZE;
 	efi_bs_call(free_pages, addr, nr_pages);
 }
+
+/**
+ * efi_adjust_memory_range_protection() - change memory range protection attributes
+ * @start:	memory range start address
+ * @size:	memory range size
+ *
+ * Actual memory range for which memory attributes are modified is
+ * the smallest ranged with start address and size aligned to EFI_PAGE_SIZE
+ * that includes [start, start + size].
+ *
+ * @return: status code
+ */
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size,
+						unsigned long attributes)
+{
+	efi_status_t status;
+	efi_gcd_memory_space_desc_t desc;
+	efi_physical_addr_t end, next;
+	efi_physical_addr_t rounded_start, rounded_end;
+	efi_physical_addr_t unprotect_start, unprotect_size;
+
+	if (efi_dxe_table == NULL)
+		return EFI_UNSUPPORTED;
+
+	/*
+	 * This function should not be used to modify attributes
+	 * other than writable/executable.
+	 */
+
+	if ((attributes & ~(EFI_MEMORY_RO | EFI_MEMORY_XP)) != 0)
+		return EFI_INVALID_PARAMETER;
+
+	/*
+	 * Disallow simultaniously executable and writable memory
+	 * to inforce W^X policy if direct extraction code is enabled.
+	 */
+
+	if ((attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0) {
+		efi_warn("W^X violation at [%08lx,%08lx]\n",
+			 (unsigned long)rounded_start,
+			 (unsigned long)rounded_end);
+	}
+
+	rounded_start = rounddown(start, EFI_PAGE_SIZE);
+	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
+
+	/*
+	 * Don't modify memory region attributes, they are
+	 * already suitable, to lower the possibility to
+	 * encounter firmware bugs.
+	 */
+
+	for (end = start + size; start < end; start = next) {
+
+		status = efi_dxe_call(get_memory_space_descriptor,
+				      start, &desc);
+
+		if (status != EFI_SUCCESS) {
+			efi_warn("Unable to get memory descriptor at %lx\n",
+				 start);
+			return status;
+		}
+
+		next = desc.base_address + desc.length;
+
+		/*
+		 * Only system memory is suitable for trampoline/kernel image
+		 * placement, so only this type of memory needs its attributes
+		 * to be modified.
+		 */
+
+		if (desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory) {
+			efi_warn("Attempted to change protection of special memory range\n");
+			return EFI_UNSUPPORTED;
+		}
+
+		if (((desc.attributes ^ attributes) &
+		     (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0)
+			continue;
+
+		desc.attributes &= ~(EFI_MEMORY_RO | EFI_MEMORY_XP);
+		desc.attributes |= attributes;
+
+		unprotect_start = max(rounded_start, desc.base_address);
+		unprotect_size = min(rounded_end, next) - unprotect_start;
+
+		status = efi_dxe_call(set_memory_space_attributes,
+				      unprotect_start, unprotect_size,
+				      desc.attributes);
+
+		if (status != EFI_SUCCESS) {
+			efi_warn("Unable to unprotect memory range [%08lx,%08lx]: %lx\n",
+				 (unsigned long)unprotect_start,
+				 (unsigned long)(unprotect_start + unprotect_size),
+				 status);
+			return status;
+		}
+	}
+
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 33a7811e12c6..2fddb88613cd 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -212,61 +212,6 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-static void
-adjust_memory_range_protection(unsigned long start, unsigned long size)
-{
-	efi_status_t status;
-	efi_gcd_memory_space_desc_t desc;
-	unsigned long end, next;
-	unsigned long rounded_start, rounded_end;
-	unsigned long unprotect_start, unprotect_size;
-
-	if (efi_dxe_table == NULL)
-		return;
-
-	rounded_start = rounddown(start, EFI_PAGE_SIZE);
-	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
-
-	/*
-	 * Don't modify memory region attributes, they are
-	 * already suitable, to lower the possibility to
-	 * encounter firmware bugs.
-	 */
-
-	for (end = start + size; start < end; start = next) {
-
-		status = efi_dxe_call(get_memory_space_descriptor, start, &desc);
-
-		if (status != EFI_SUCCESS)
-			return;
-
-		next = desc.base_address + desc.length;
-
-		/*
-		 * Only system memory is suitable for trampoline/kernel image placement,
-		 * so only this type of memory needs its attributes to be modified.
-		 */
-
-		if (desc.gcd_memory_type != EfiGcdMemoryTypeSystemMemory ||
-		    (desc.attributes & (EFI_MEMORY_RO | EFI_MEMORY_XP)) == 0)
-			continue;
-
-		unprotect_start = max(rounded_start, (unsigned long)desc.base_address);
-		unprotect_size = min(rounded_end, next) - unprotect_start;
-
-		status = efi_dxe_call(set_memory_space_attributes,
-				      unprotect_start, unprotect_size,
-				      EFI_MEMORY_WB);
-
-		if (status != EFI_SUCCESS) {
-			efi_warn("Unable to unprotect memory range [%08lx,%08lx]: %lx\n",
-				 unprotect_start,
-				 unprotect_start + unprotect_size,
-				 status);
-		}
-	}
-}
-
 /*
  * Trampoline takes 2 pages and can be loaded in first megabyte of memory
  * with its end placed between 128k and 640k where BIOS might start.
@@ -290,12 +235,12 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 	 * and relocated kernel image.
 	 */
 
-	adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
-				       TRAMPOLINE_PLACEMENT_SIZE);
+	efi_adjust_memory_range_protection(TRAMPOLINE_PLACEMENT_BASE,
+					   TRAMPOLINE_PLACEMENT_SIZE, 0);
 
 #ifdef CONFIG_64BIT
 	if (image_base != (unsigned long)startup_32)
-		adjust_memory_range_protection(image_base, image_size);
+		efi_adjust_memory_range_protection(image_base, image_size, 0);
 #else
 	/*
 	 * Clear protection flags on a whole range of possible
@@ -305,8 +250,9 @@ setup_memory_protection(unsigned long image_base, unsigned long image_size)
 	 * need to remove possible protection on relocated image
 	 * itself disregarding further relocations.
 	 */
-	adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
-				       KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR);
+	efi_adjust_memory_range_protection(LOAD_PHYSICAL_ADDR,
+					   KERNEL_IMAGE_SIZE - LOAD_PHYSICAL_ADDR,
+					   0);
 #endif
 }
 
-- 
2.37.4

