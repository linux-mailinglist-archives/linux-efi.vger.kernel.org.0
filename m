Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F054FB873
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbiDKJx4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344875AbiDKJwH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A10EB1FB
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85592B811AF
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DBF8C385A4;
        Mon, 11 Apr 2022 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670573;
        bh=dfvrz+2dbg6t5hlmtDi/5B3nL5WpnhfCyf6Bzny7Qlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osW2+eO5J1Za7vl701HD9MyfJota6a3mPqz2/3Riqb/wpEcR5erdEua8IhdtTlddw
         r5AcnL8jdDAcitjF4iVHaUYu1z7MtZeIjpkWs8GfNdKZPGJa9xqKaKfJd1ig3W/L7c
         o95vZPqA5T8VdVbD1MV1aYXj+AAUdxXmpVw/DnuITK92wONuhPXPvS+uUBjqw3v4Of
         CJ2rYsTDI7qAJsccXs2LbRLNM0qt/3NUHcBREc9svuzdkpUP7EyvxdXjuV50QgQNId
         IqRTh1Rw/ftF49MmT7KB4TZNGjR7yK4MkKPVKbLzEpdv8CZv2wquE5j4Ss5csw2yF5
         NPD1nsWDYzGyg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 21/30] arm64: head: remap the kernel text/inittext region read-only
Date:   Mon, 11 Apr 2022 11:48:15 +0200
Message-Id: <20220411094824.4176877-22-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4347; h=from:subject; bh=dfvrz+2dbg6t5hlmtDi/5B3nL5WpnhfCyf6Bzny7Qlk=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lYf9kmlG7qsfci8zLXeSNfoLU11+RwfIKrWzAl fh8M6gmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5WAAKCRDDTyI5ktmPJO2YC/ 9410Y/X6yaWlLqu96vn1eKF4S0xb9JWjwCFezuOuj2VHsnVAkYQdNcBQeAUfQi0Olz4YcI8Q4Zl8Y2 nlEHSCXEVuI9NpG/bXJiUEw41xSCRwQ6VkgQ1lpEm8iP9ztJpwDU8EPhVi+XSqOIAN0jKiBDVmWRM5 VdiHdSh4U6Tj720Z7wLxJ/A0PyR/8J7fZnzWcMl/dK+/U+BAHvGzTuj/UC3DpndgMiy4jiiLmJ7XXK s2SJiFmCnfp3Dm8uyzG1lGYdAjxvsPi12dGr0B2cchyUTcY7P4NVNm2C9UzhmV7mFeA0AVVHesuhAW AyYpjKgmKwcxTY+FRMjZ6QdEDmLvpgkEEGJzUpTLYI38kH4oPzRrjBKXD27CgHk6sDKR81KY0P+lVg ogKIqgUkcDt2HDQt8UAroDuSKuvYdgp+BIB0TFf+2UCXjTJgIE31CUQ1CYP2Q/Uyc+NlaLlRxs6yPf re/nVjU2dvhkOdl2ENIOODo1u+VBghH5DdjrIl+qZ6rGc=
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

In order to be able to run with WXN from boot (which could potentially
be under a hypervisor regime that mandates this), update the temporary
kernel page tables with read-only attributes for the text regions before
attempting to execute from them.

This is rather straight-forward for 16k and 64k granule configurations,
as the split between executable and writable regions is guaranteed to be
aligned to the granule used for the early kernel page tables. For 4k, it
involves installing a single table entry and populating it accordingly.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 71 +++++++++++++++++++-
 arch/arm64/kernel/vmlinux.lds.S |  2 +-
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 87498e414725..54886c4b6347 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -86,7 +86,7 @@
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x23        __primary_switch() .. relocate_kernel()  physical misalignment/KASLR offset
-	 *  x28        create_idmap()                           callee preserved temp register
+	 *  x28        create_idmap(), remap_kernel_text()      callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
@@ -372,10 +372,62 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	mov	x7, SWAPPER_RW_MMUFLAGS
 
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12, x13, x14
-
 	ret
 SYM_FUNC_END(create_kernel_mapping)
 
+SYM_FUNC_START_LOCAL(remap_kernel_text)
+	mov	x28, lr
+
+	ldr	x1, =_text
+	mov	x2, x1
+	ldr	x3, =__initdata_begin - 1
+	adrp	x4, _text
+	bic	x4, x4, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RX_MMUFLAGS
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
+#if SWAPPER_BLOCK_SHIFT > PAGE_SHIFT
+	/*
+	 * If the boundary between inittext and initdata happens to be aligned
+	 * sufficiently, we are done here. Otherwise, we have to replace its block
+	 * entry with a table entry, and populate the lower level table accordingly.
+	 */
+	ldr	x3, =__initdata_begin
+	tst	x3, #SWAPPER_BLOCK_SIZE - 1
+	b.eq	0f
+
+	/* First, create a table mapping to replace the block mapping */
+	ldr	x1, =_text
+	bic	x2, x3, #SWAPPER_BLOCK_SIZE - 1
+	adrp	x4, init_pg_end - PAGE_SIZE
+	mov	x5, #PMD_TYPE_TABLE
+	mov	x6, #SWAPPER_BLOCK_SHIFT
+	bl	remap_region
+
+	/* Apply executable permissions to the first subregion */
+	adrp	x0, init_pg_end - PAGE_SIZE
+	ldr	x3, =__initdata_begin - 1
+	bic	x1, x3, #SWAPPER_BLOCK_SIZE - 1
+	mov	x2, x1
+	adrp	x4, __initdata_begin
+	bic	x4, x4, #SWAPPER_BLOCK_SIZE - 1
+	mov	x5, SWAPPER_RX_MMUFLAGS | PTE_TYPE_PAGE
+	mov	x6, #PAGE_SHIFT
+	bl	remap_region
+
+	/* Apply writable permissions to the second subregion */
+	ldr	x2, =__initdata_begin
+	bic	x1, x2, #SWAPPER_BLOCK_SIZE - 1
+	orr	x3, x1, #SWAPPER_BLOCK_SIZE - 1
+	adrp	x4, __initdata_begin
+	mov	x5, SWAPPER_RW_MMUFLAGS | PTE_TYPE_PAGE
+	mov	x6, #PAGE_SHIFT
+	bl	remap_region
+#endif
+0:	ret	x28
+SYM_FUNC_END(remap_kernel_text)
+
 	/*
 	 * Initialize CPU registers with task-specific and cpu-specific context.
 	 *
@@ -805,12 +857,25 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #endif
 	bl	clear_page_tables
 	bl	create_kernel_mapping
+#ifdef CONFIG_RELOCATABLE
+	mov	x29, x0			// preserve returned page table pointer
 
 	adrp	x1, init_pg_dir
 	load_ttbr1 x1, x2
-#ifdef CONFIG_RELOCATABLE
 	bl	__relocate_kernel
+	adrp	x1, reserved_pg_dir
+	load_ttbr1 x1, x2
+
+	tlbi	vmalle1
+	dsb	nsh
+	isb
+
+	mov	x0, x29			// pass page table pointer to remap_kernel_text
 #endif
+	bl	remap_kernel_text
+	adrp	x1, init_pg_dir
+	load_ttbr1 x1, x2
+
 	ldr	x8, =__primary_switched
 	adrp	x0, __PHYS_OFFSET
 	br	x8
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 21ca72e7ad22..cb4821c411f4 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -298,7 +298,7 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	init_pg_dir = .;
-	. += INIT_DIR_SIZE;
+	. += INIT_DIR_SIZE + PAGE_SIZE;
 	init_pg_end = .;
 
 	. = ALIGN(SEGMENT_ALIGN);
-- 
2.30.2

