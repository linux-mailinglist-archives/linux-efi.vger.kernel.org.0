Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE85A3891
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiH0P7T (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiH0P7T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007C62A410
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0383B8095D
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D6AC433D6;
        Sat, 27 Aug 2022 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615955;
        bh=1ugsc/xgrgpTQysZCBr5xGnswtBu7R/DIZa479XsB6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2+/fas12iYER7ks/8ZuPmpnd9N8t0noXYE/xKA+3M0FZ1eLoQMYSM765FHN1Sbtb
         62yEucqy5g2HrGtIacIn8zI5oJCiNS3tzWDERrZBogFJSXnvjer/7APGX1J3qVJJr2
         HYV0QVpO/HZ9KVksE2gCnNVWe82LjtCc5Ofznf+a2J9YN4ChK+Aml0Uve+CebRPosF
         5FKMAwaM7o8oka37KY8IPELdW4UbixIn6tQyu5YCRxBuWwluOqfFRCIE3C9XkXMQ8j
         WC5QoGrvwfOo7Ijy+IxfpLQ8UtzQu3nJr10QggWtxySkNNyv47ZM+BKf4JomkVfix6
         vUyF3oSxEERKg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 6/7] arm64: efi/libstub: use EFI_LOADER_CODE region when moving the kernel in memory
Date:   Sat, 27 Aug 2022 17:58:51 +0200
Message-Id: <20220827155852.3338551-7-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5560; i=ardb@kernel.org; h=from:subject; bh=1ugsc/xgrgpTQysZCBr5xGnswtBu7R/DIZa479XsB6M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj86KiosZ1MlMTg8yzWqRoDL/573FgoYNU/ofe+u Mjkt1gKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/OgAKCRDDTyI5ktmPJOKwDA CgmQ7US54AsQCSU9snyAXw+JURU90lNCbIk27FnN/kjJnbfa+HRMRYb88FjNmhJLco4hOmjVkqRu0I 5ewvBMDIc7liKX69GvW3jE+MCd8EtJsXkvAu94AgDKiI4ylvsZTWIzMEm9gYNeHwlhnxGwZ9saQdFW 561gsMJx8kQ+pLtjf1HX4n+Du/WYtD23NA+Yy02yhewKP1lQhR+VGPTHTBSq41Hg3fIPUhJ7nlyiWO p8apXrEYuawwIhwx/D4lvGTR+5SwJlVqqP0dtJwx/IhRjUyP5XNIN9A/wpjUh7CbIhwSWFyS3Cot3j G0cQ9g3uuz873Hz8HBPlSNWXDwBiJcprCZGo31fxgcDVc27Tscw1s80oPdRtKTr+GrKmphdEW7dorm TKVexLAT6DBGFggiztSx4EaiNQVrdjkuHofj7vguJr+sBWMoDIrYJPY+Klnqt/9lS0GIsaidgOxHMP 5V5rWLPewVmx9F3YJdUqG+LwR/5RWJxVJoam9lTzQ4Q1o=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI spec is not very clear about which permissions are being given
when allocating pages of a certain type. However, it is quite obvious
that EFI_LOADER_CODE is more likely to permit execution than
EFI_LOADER_DATA, which becomes relevant once we permit booting the
kernel proper with the firmware's 1:1 mapping still active.

(Note that GRUB for arm64 uses EFI_LOADER_CODE allocations for its
executable modules, and therefore relies on these regions having the
right permissions as well)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/alignedmem.c  | 5 +++--
 drivers/firmware/efi/libstub/arm64-stub.c  | 6 ++++--
 drivers/firmware/efi/libstub/efistub.h     | 6 ++++--
 drivers/firmware/efi/libstub/mem.c         | 3 ++-
 drivers/firmware/efi/libstub/randomalloc.c | 5 +++--
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index 1de9878ddd3a..174832661251 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -22,7 +22,8 @@
  * Return:	status code
  */
 efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
-					unsigned long max, unsigned long align)
+					unsigned long max, unsigned long align,
+					int memory_type)
 {
 	efi_physical_addr_t alloc_addr;
 	efi_status_t status;
@@ -36,7 +37,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 	slack = align / EFI_PAGE_SIZE - 1;
 
 	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
-			     EFI_LOADER_DATA, size / EFI_PAGE_SIZE + slack,
+			     memory_type, size / EFI_PAGE_SIZE + slack,
 			     &alloc_addr);
 	if (status != EFI_SUCCESS)
 		return status;
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index ad7392e6c200..f32e89b4049f 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -140,7 +140,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 * locate the kernel at a randomized offset in physical memory.
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
-					  reserve_addr, phys_seed);
+					  reserve_addr, phys_seed,
+					  EFI_LOADER_CODE);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
@@ -161,7 +162,8 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
-						    ULONG_MAX, min_kimg_align);
+						    ULONG_MAX, min_kimg_align,
+						    EFI_LOADER_CODE);
 
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to relocate kernel\n");
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index b0ae0a454404..ab9e990447d3 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -871,7 +871,8 @@ void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
 efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
-			      unsigned long *addr, unsigned long random_seed);
+			      unsigned long *addr, unsigned long random_seed,
+			      int memory_type);
 
 efi_status_t check_platform_features(void);
 
@@ -895,7 +896,8 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 				unsigned long max);
 
 efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
-					unsigned long max, unsigned long align);
+					unsigned long max, unsigned long align,
+					int memory_type);
 
 efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
 				 unsigned long *addr, unsigned long min);
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index feef8d4be113..1e543c90c0ea 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -96,7 +96,8 @@ efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
 
 	if (EFI_ALLOC_ALIGN > EFI_PAGE_SIZE)
 		return efi_allocate_pages_aligned(size, addr, max,
-						  EFI_ALLOC_ALIGN);
+						  EFI_ALLOC_ALIGN,
+						  EFI_LOADER_DATA);
 
 	alloc_addr = ALIGN_DOWN(max + 1, EFI_ALLOC_ALIGN) - 1;
 	status = efi_bs_call(allocate_pages, EFI_ALLOCATE_MAX_ADDRESS,
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 715f37479154..ca859e63bac2 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -53,7 +53,8 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long align,
 			      unsigned long *addr,
-			      unsigned long random_seed)
+			      unsigned long random_seed,
+			      int memory_type)
 {
 	unsigned long map_size, desc_size, total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
@@ -127,7 +128,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
-				     EFI_LOADER_DATA, pages, &target);
+				     memory_type, pages, &target);
 		if (status == EFI_SUCCESS)
 			*addr = target;
 		break;
-- 
2.35.1

