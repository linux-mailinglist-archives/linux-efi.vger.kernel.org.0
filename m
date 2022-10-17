Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE6601486
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJQRRZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJQRRY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16656E895
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3F55B819D0
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750B8C43470;
        Mon, 17 Oct 2022 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027041;
        bh=Z/U4ee43YwCQtbpS+erJrlD6etCprE4ciwkhw4HluFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVH1Tckv0C+BEE7ppJplUt7NERqKhJ6deIuFTbDOYXVBVTKFSyYTHeDWrXOaK+2lC
         x9BQiyRvwClUljrbM3lX6+s8lk2Piy6QKD6PzPJoPT7E9w4MRTu5bKUcr6zE4G7jos
         pQOWpGPTgSbk5eqhSoOfBLXghlcoJwN4aFwJMCc0hnnMkRXcF1KWis1/GK36YjJCDB
         x2+X/WDjqELJNZW5xOBdcFZ9unELhqLmvjAqkDX3D0wSNqN5EAqyv7fIrCMK2KzNLG
         x3SkLBd2c0CdgxRSkOEE684HFaqQ2jvUuszM3+UfF/ovGaYYy8gP9AccDUN21UQbnw
         3Zo1Wrdwbpz+A==
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
Subject: [PATCH 01/21] arm64: efi: Move dcache cleaning of loaded image out of efi_enter_kernel()
Date:   Mon, 17 Oct 2022 19:16:40 +0200
Message-Id: <20221017171700.3736890-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=ardb@kernel.org; h=from:subject; bh=Z/U4ee43YwCQtbpS+erJrlD6etCprE4ciwkhw4HluFw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3quuXELSWwupLiAJd0cFsye30VMCkORloCf6R1 bArAoTGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N6gAKCRDDTyI5ktmPJHvNC/ 9B0DKczV2J9CEhF4XhnK7SF9DX7N08oWSclWY6X4vsKVe9nHAAKHTzEvJFG9pnI6IV788fRBT8axUk E15N7ZKSC5NJiY2mkTEe8SduA8Fv89c8f85pN9dwuJuWOH5aFHT/+xm1iTnDhG0vub8hvw6PGbUHqY 1jIYdRLg0Cdw0AQX7N75P3KjCk7WInXbv5YSV7mZIGmqxgqXS37zBN1gCCOwepA7Nni56fTgwGVydf el5l4x227jFepGbS8OaC2dmPKolDd3JBTKiGNNotQXcqbveAZsUKCNQ547V6A6YpBIfBiSIrHMW0VC zu6d80s6YmGmQQG0oYertGWyVQp/Wy84l54Drxu89s4/OvMAE5xvAbDSJitEODQ+SMS3XUJrf9r7m9 eUEtSCLkon0IKCQQ8pts+xt34bdiATPzAvO5NcWodid5Ss+N74zXGiYha9egDoWBVgf8ZtnHMS+z3e RnIcbW77YvDTEs80WsPR+3BcJL477gGiu2gANYmjehuTQ=
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

The efi_enter_kernel() routine will be shared between the existing EFI
stub and the zboot decompressor, and the version of
dcache_clean_to_poc() that the core kernel exports to the stub will not
be available in the latter case.

So move the handling into the .c file which will remain part of the stub
build that integrates directly with the kernel proper.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-entry.S             |  9 ---------
 arch/arm64/kernel/image-vars.h            |  1 -
 drivers/firmware/efi/libstub/arm64-stub.c | 10 +++++++++-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 61a87fa1c305..1c1be004a271 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -23,15 +23,6 @@ SYM_CODE_START(efi_enter_kernel)
 	add	x19, x0, x2		// relocated Image entrypoint
 	mov	x20, x1			// DTB address
 
-	/*
-	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
-	 * stale icache entries from before relocation.
-	 */
-	ldr	w1, =kernel_size
-	add	x1, x0, x1
-	bl	dcache_clean_poc
-	ic	ialluis
-
 	/*
 	 * Clean the remainder of this routine to the PoC
 	 * so that we can safely disable the MMU and caches.
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 8151412653de..74d20835cf91 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -10,7 +10,6 @@
 #error This file should only be included in vmlinux.lds.S
 #endif
 
-PROVIDE(__efistub_kernel_size		= _edata - _text);
 PROVIDE(__efistub_primary_entry_offset	= primary_entry - _text);
 
 /*
diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
index 598c76c4bbaa..e767a5ac8c3d 100644
--- a/drivers/firmware/efi/libstub/arm64-stub.c
+++ b/drivers/firmware/efi/libstub/arm64-stub.c
@@ -157,7 +157,7 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 			 */
 			*image_addr = (u64)_text;
 			*reserve_size = 0;
-			return EFI_SUCCESS;
+			goto clean_image_to_poc;
 		}
 
 		status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
@@ -174,5 +174,13 @@ efi_status_t handle_kernel_image(unsigned long *image_addr,
 	*image_addr = *reserve_addr;
 	memcpy((void *)*image_addr, _text, kernel_size);
 
+clean_image_to_poc:
+	/*
+	 * Clean the copied Image to the PoC, and ensure it is not shadowed by
+	 * stale icache entries from before relocation.
+	 */
+	dcache_clean_poc(*image_addr, *image_addr + kernel_size);
+	asm("ic ialluis");
+
 	return EFI_SUCCESS;
 }
-- 
2.35.1

