Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFB27157F5A
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBJQDF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:05 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C13F320873;
        Mon, 10 Feb 2020 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350585;
        bh=ASaLrT97USRIvRi+4ltHkPhd6CrnQ6CT2Qgaf827Oqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbjrOzaWP4EfffJbC7QmlpEzAYa+rFP5ut4n20teI9ym5GIIvTGxMM7Jzf94UZNij
         XbuLMp22hSINgBY0vGgmg5NeJ3iwJVMEVs1nOFZE39YWE2tROLUtiGuTT9QkudZ+Sw
         Jzi9yBHkT5M9Nb1UEsrCu6jNdyQKwwpEZK8fPpGY=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 04/19] efi/libstub/arm: Relax FDT alignment requirement
Date:   Mon, 10 Feb 2020 17:02:33 +0100
Message-Id: <20200210160248.4889-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The arm64 kernel no longer requires the FDT blob to fit inside a
naturally aligned 2 MB memory block, so remove the code that aligns
the allocation to 2 MB.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/efi.h       | 7 -------
 drivers/firmware/efi/libstub/fdt.c | 6 +-----
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 56ae87401a26..45e821222774 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -57,13 +57,6 @@ efi_status_t __efi_rt_asm_wrapper(void *, const char *, ...);
 
 /* arch specific definitions used by the stub code */
 
-/*
- * AArch64 requires the DTB to be 8-byte aligned in the first 512MiB from
- * start of kernel and may not cross a 2MiB boundary. We set alignment to
- * 2MiB so we know it won't cross a 2MiB boundary.
- */
-#define EFI_FDT_ALIGN	SZ_2M   /* used by allocate_new_fdt_and_exit_boot() */
-
 /*
  * In some configurations (e.g. VMAP_STACK && 64K pages), stacks built into the
  * kernel need greater alignment than we require the segments to be padded to.
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 0a91e5232127..f71cd54823b7 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -199,10 +199,6 @@ static efi_status_t update_fdt_memmap(void *fdt, struct efi_boot_memmap *map)
 	return EFI_SUCCESS;
 }
 
-#ifndef EFI_FDT_ALIGN
-# define EFI_FDT_ALIGN EFI_PAGE_SIZE
-#endif
-
 struct exit_boot_struct {
 	efi_memory_desc_t	*runtime_map;
 	int			*runtime_entry_count;
@@ -281,7 +277,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 	pr_efi("Exiting boot services and installing virtual address map...\n");
 
 	map.map = &memory_map;
-	status = efi_high_alloc(MAX_FDT_SIZE, EFI_FDT_ALIGN,
+	status = efi_high_alloc(MAX_FDT_SIZE, EFI_PAGE_SIZE,
 				new_fdt_addr, max_addr);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err("Unable to allocate memory for new device tree.\n");
-- 
2.17.1

