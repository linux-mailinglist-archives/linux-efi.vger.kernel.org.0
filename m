Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BA6FA08E
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjEHHGI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjEHHFb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:05:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167351A1E6;
        Mon,  8 May 2023 00:04:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A8DE61F96;
        Mon,  8 May 2023 07:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE786C433D2;
        Mon,  8 May 2023 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529487;
        bh=E2w5aloeuQ0G0hJL5MGQzf9qEE3fMq6Wyl1+QQk0LOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rEmNJbMdQdN9J83vYxRk8fdLdzgUe/W7/42WwfYmQZ+6okO4dTvwP3Oqtn+FS6kLw
         7BaoY5LWJ7u0BSGYiKlA+IRjpwn5UeguQwng0Mr97nRmTqb00gA8Kk4EhKqD0I994u
         HnAhls0NapOM1aZP1nOThCVKCT6fREG1ZizEz9LViNtbNRt4bPa7sDfTEmybspRnTz
         NuvumijF9s5/VgSHGQ6vzz95/CRwqOxgWBVSsg30vS37e+AlmJeZSno7pqR5c3MVpy
         ksbwDGNpjOiEPjzOxvbLio1EesEw9yZM6YZiHdO3rdgUHgcZjEEkvjFM1vaPUDix4/
         4Y+0FdMaHQGXA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 16/20] efi: libstub: Add limit argument to efi_random_alloc()
Date:   Mon,  8 May 2023 09:03:26 +0200
Message-Id: <20230508070330.582131-17-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3943; i=ardb@kernel.org; h=from:subject; bh=E2w5aloeuQ0G0hJL5MGQzf9qEE3fMq6Wyl1+QQk0LOk=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3t65TNfa731pL/csfX3/EOPXLP61z46d+qxysu3di kNnHy+M7ShlYRDjYJAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATSTRg+Ct6fcqcrfzbBF+/ uct6wfq+ZP6Z87v2ql3gPS+fqtMl/mAKw39vth1OX1oXXth2ittfr0yn/Wn82ZYbmziFlj8sVbu 5rI8PAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

x86 will need to limit the kernel memory allocation to the lowest 512
MiB of memory, to match the behavior of the existing bare metal KASLR
physical randomization logic. So in preparation for that, add a limit
parameter to efi_random_alloc() and wire it up.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm64-stub.c  |  2 +-
 drivers/firmware/efi/libstub/efistub.h     |  2 +-
 drivers/firmware/efi/libstub/randomalloc.c | 10 ++++++----
 drivers/firmware/efi/libstub/zboot.c       |  2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 770b8ecb73984c61..8c40fc89f5f99209 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -106,7 +106,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE);
+					  EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d5a20802e0b7c6..03e3cec87ffbe2d1 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -955,7 +955,7 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
-			      int memory_type);
+			      int memory_type, unsigned long alloc_limit);
 
 efi_status_t efi_random_get_seed(void);
 
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 32c7a54923b4c127..674a064b8f7adc68 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -16,7 +16,8 @@
  */
 static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 					 unsigned long size,
-					 unsigned long align_shift)
+					 unsigned long align_shift,
+					 u64 alloc_limit)
 {
 	unsigned long align = 1UL << align_shift;
 	u64 first_slot, last_slot, region_end;
@@ -29,7 +30,7 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 		return 0;
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
-			 (u64)EFI_ALLOC_LIMIT);
+			 alloc_limit);
 	if (region_end < size)
 		return 0;
 
@@ -54,7 +55,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long align,
 			      unsigned long *addr,
 			      unsigned long random_seed,
-			      int memory_type)
+			      int memory_type,
+			      unsigned long alloc_limit)
 {
 	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
@@ -76,7 +78,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
-		slots = get_entry_num_slots(md, size, ilog2(align));
+		slots = get_entry_num_slots(md, size, ilog2(align), alloc_limit);
 		MD_NUM_SLOTS(md) = slots;
 		total_slots += slots;
 		if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index e5d7fa1f1d8fd160..bdb17eac0cb401be 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -119,7 +119,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		}
 
 		status = efi_random_alloc(alloc_size, min_kimg_align, &image_base,
-					  seed, EFI_LOADER_CODE);
+					  seed, EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to allocate memory\n");
 			goto free_cmdline;
-- 
2.39.2

