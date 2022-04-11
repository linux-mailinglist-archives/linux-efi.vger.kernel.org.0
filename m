Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4211E4FB840
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbiDKJwN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344863AbiDKJwB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF60419B6
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25B361182
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515A7C385B0;
        Mon, 11 Apr 2022 09:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670556;
        bh=TEd74fUGGrd4Z1cRABQmAm27ke5FtcewQadVTliZWAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=APCDKPvnrCFnc/yFQCpADw9E/+8oaOnTBY3oiuTMME/g2E5WUtw9Ug1Egx1RPyxzT
         EjiEzpbQnwpfVC2LZHJQELZoltQTiGPa0ghutlkMEVeZ6lKxHxlz56ookfqsAB8sZz
         Gnv4uVaYRmN+lyXILOrrys4CXZ6IZMfIDfGQBvM3T407gd8dgOl7nDJqtkBbqhl/fo
         bkYj//+mvVzGWLQCG5dcS5x2Rk8MFhWcyqXxQRAsASipW9n9tzrpdXKj6pAQuB1VhP
         b23fo96u8xrd/fH4Ba9cF7P87FnRomkI7XY541RnmtUGi/mjQUtb2Ik/wV4ufVS1LX
         k3qd3J3EdpHHA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 14/30] arm64: head: create a temporary FDT mapping in the initial ID map
Date:   Mon, 11 Apr 2022 11:48:08 +0200
Message-Id: <20220411094824.4176877-15-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3233; h=from:subject; bh=TEd74fUGGrd4Z1cRABQmAm27ke5FtcewQadVTliZWAk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lMCk6FU1TDgS+d/bUIgpicu6zDRlE/gdeBj3bp /lk4Jn6JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5TAAKCRDDTyI5ktmPJLGMC/ 9hBgnHrXB5qXx9kUoOG/jVi3qO3tUka8huOBorTeivyB/WXIQIn1ee8HVbMbsMvEA8nRkKkozI/YUR fEO5YHcy2EB0g/4cpFiHOyXBfR9AyYUmeV0BIbsMq3V+UbOkrA8OH5YmHU3uqZNaISOwCDOI5KEq2o /9X711XQ4DP0aWBdishsWkAa+lkqfeknOCGji8bePW6A0UZKrRbgio5Jl54RNN9CPL9jBnsC3NBG/Q +vsk+S4a6T9gGSpsY6XdQOB3KbxtHMV87+yQB5bauNvGMwlNg/nR+MDiK0GvE5+WUUfRCPkBSxE4oi y9H0W7xYC0E3RVbff4WmeiQVxAAFmKnELoApi8O5NwVCFRuyFpIO7HBKQrchQQIE7nbxqs+6UYZGG3 OufMrJhtuhYpHSDStTY1y1IRmlpZ4Je2O6dK2Mv6r+3MhY2455pxM26mX8VnLSS/9p3Z15tFWkl73Y PaZKpgB/CJZgjVU6vyaldd+9Jqk7BplYHIlmE1Q9pKBVE=
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

We need to access the DT very early to get at the command line and the
KASLR seed, which currently means we rely on some hacks to call into the
kernel before really calling into the kernel, which is undesirable.

So instead, let's create a mapping for the FDT in the initial ID map,
which is feasible now that it has been extended to cover more than a
single page or block, and can be updated in place to remap other output
addresses.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/kernel-pgtable.h |  6 ++++--
 arch/arm64/kernel/head.S                | 14 +++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 5395e5a04f35..02e59fa8f293 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -8,6 +8,7 @@
 #ifndef __ASM_KERNEL_PGTABLE_H
 #define __ASM_KERNEL_PGTABLE_H
 
+#include <asm/boot.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/sparsemem.h>
 
@@ -88,10 +89,11 @@
 
 /* the initial ID map may need two extra pages if it needs to be extended */
 #if VA_BITS < 48
-#define INIT_IDMAP_DIR_SIZE	(INIT_DIR_SIZE + (2 * PAGE_SIZE))
+#define INIT_IDMAP_DIR_SIZE	((INIT_IDMAP_DIR_PAGES + 2) * PAGE_SIZE)
 #else
-#define INIT_IDMAP_DIR_SIZE	INIT_DIR_SIZE
+#define INIT_IDMAP_DIR_SIZE	(INIT_IDMAP_DIR_PAGES * PAGE_SIZE)
 #endif
+#define INIT_IDMAP_DIR_PAGES	EARLY_PAGES(KIMAGE_VADDR, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE)
 
 /* Initial memory map size */
 #if ARM64_KERNEL_USES_PMD_MAPS
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2c491cac4871..bec3805c941c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -82,6 +82,7 @@
 	 * primary lowlevel boot path:
 	 *
 	 *  Register   Scope                      Purpose
+	 *  x19        create_idmap() .. __ start_kernel()      ID map VA of the DT blob
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        primary_entry() .. start_kernel()        physical misalignment/KASLR offset
 	 *  x28        clear_page_tables()                      callee preserved temp register
@@ -346,7 +347,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 #endif
 	adrp	x0, init_idmap_pg_dir
 	adrp	x3, _text
-	adrp	x6, _end
+	adrp	x6, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
 	mov	x7, SWAPPER_RX_MMUFLAGS
 
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x14, EXTRA_SHIFT
@@ -360,6 +361,17 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	mov	x6, #SWAPPER_BLOCK_SHIFT
 	bl	remap_region
 
+	/* Remap the FDT read-only after the kernel image */
+	adrp	x1, _text
+	adrp	x19, _end + SWAPPER_BLOCK_SIZE
+	bic	x2, x19, #SWAPPER_BLOCK_SIZE - 1
+	bfi	x19, x21, #0, #SWAPPER_BLOCK_SHIFT		// remapped FDT address
+	add	x3, x2, #MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
+	bic	x4, x21, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RX_MMUFLAGS
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
 	/*
 	 * Since the page tables have been populated with non-cacheable
 	 * accesses (MMU disabled), invalidate those tables again to
-- 
2.30.2

