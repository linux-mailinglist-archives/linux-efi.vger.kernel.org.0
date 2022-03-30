Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880724EC8A4
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbiC3PoZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348370AbiC3PoV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C443615F
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F36261729
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79648C340F2;
        Wed, 30 Mar 2022 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654954;
        bh=NKARMdFIpPuUO+fngR3uplP5bKMzLEZRMWLNCU6j1kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8Rd9RJut7Nn9lpz7AetrlSRRW8rA+5kZYVD+70C+DVhrLO19BNe9/EKVVgRSCQqQ
         a36mO0etxVjm0FUUEP2r5YkfAq7/CwaCWC7hrvSWLyGpvTqy3nAurrJLt4CiZ4VC+D
         I4jx3XbZSzmqwX5Cxwk1sO5Loqb2zWtswPQSi0z4LNwZrS2otIp+mRQe0vF45O7BD5
         2pHuvh+6BNOM/ani7lzBI+jkzYg2NGvumlSkXqjmP9stSvIWaxYqH+dXK3F5gh0Adm
         4Vt/X6lbxETjACk5U3vx6uz1iB5QW20nAF8PJa6vnNvfspgTeO0+5UsqTyZCMuPIc9
         0o3zXiMB5hHxw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 12/18] arm64: head: avoid cache invalidation when entering with the MMU on
Date:   Wed, 30 Mar 2022 17:41:59 +0200
Message-Id: <20220330154205.2483167-13-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2876; h=from:subject; bh=NKARMdFIpPuUO+fngR3uplP5bKMzLEZRMWLNCU6j1kE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpCqqsO4VFBa2X4f5zJeq/GZgYbbyd4r4kj7Kwu SyJa3WOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6QgAKCRDDTyI5ktmPJO4LDA CNR59DspwJN3JhnhbtoSuLvXaz04oPBpP7bhp8CgIzzQ4RE7flSCs6C5xdA+Zuz6XrMir0r7+wgroG YvynNADmkE1gcQJWMQ0E2a8vrMoiYr5U2GQ0I95cEnITN1WCR2vbUNtH4GHGx3cs7Q87lKLFmYwg9i CZJvnOoFkYJO9g7IJ9xPlNxAWGZTDRVu9WKm1w6opMnCVRqmF8yWx9ytRrJIiU/A9FHgbveayokBXW AZYN9jQuR8qK4ZMaaM2MN9Y/ZWFFxwii51jYk8k4OhjUOj+pLmIVzLmgPNE6hpffcp0OWpLuwifu7O pNZw2+8e5E34JYzu21A2tzO2VFb50v1qjHhYDrwxWcXN705iWbhXEyXgjFt1SpD/9YUdK6i6/dCOLR LqEMgq1UU5yq+3tePK2KNSqGOZtPhQlBCS9BZ2U3FwJUVpY/l6/WPVex3/yKQdFPM6FlbI02WOviae pCVSjBWNnrb9FhqtKpEPhKqotNzk24uLGWWZRYURA8uYM=
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

If we enter with the MMU on, there is no need for explicit cache
invalidation for stores to memory, as they will be coherent with the
caches.

Let's take advantage of this, and create the ID map with the MMU still
enabled if that is how we entered, and avoid any cache invalidation
calls in that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 836237289ffb..db315129f15d 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -89,9 +89,9 @@
 SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
+	bl	create_idmap
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
-	bl	create_idmap
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -124,11 +124,13 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
 	stp	x2, x3, [x0, #16]
 
+	cbnz	x22, 0f				// skip cache invalidation if MMU is on
 	dmb	sy				// needed before dc ivac with
 						// MMU off
 
 	add	x1, x0, #0x20			// 4 x 8 bytes
 	b	dcache_inval_poc		// tail call
+0:	ret
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
@@ -292,8 +294,10 @@ SYM_FUNC_START_LOCAL(create_idmap)
 1:
 	adr_l	x6, vabits_actual
 	str	x5, [x6]
+	cbnz	x22, 2f			// skip cache invalidation if MMU is on
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
+2:
 #endif
 	/*
 	 * VA_BITS may be too small to allow for an ID mapping to be created
@@ -311,13 +315,14 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x5, _end
 	clz	x5, x5
 	cmp	x5, TCR_T0SZ(VA_BITS_MIN) // default T0SZ small enough?
-	b.ge	1f			// .. then skip VA range extension
+	b.ge	4f			// .. then skip VA range extension
 
 	adr_l	x6, idmap_t0sz
 	str	x5, [x6]
+	cbnz	x22, 3f			// skip cache invalidation if MMU is on
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
-
+3:
 #if (VA_BITS < 48)
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
 #define EXTRA_PTRS	(1 << (PHYS_MASK_SHIFT - EXTRA_SHIFT))
@@ -343,7 +348,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 */
 	mov	x4, #1 << (PHYS_MASK_SHIFT - PGDIR_SHIFT)
 #endif
-1:
+4:
 	adr_l	x6, _end			// __pa(_end)
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
@@ -354,11 +359,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * accesses (MMU disabled), invalidate those tables again to
 	 * remove any speculatively loaded cache lines.
 	 */
+	cbnz	x22, 5f			// skip cache invalidation if MMU is on
 	dmb	sy
 
 	adrp	x0, idmap_pg_dir
 	adrp	x1, idmap_pg_end
 	b	dcache_inval_poc		// tail call
+5:	ret
 SYM_FUNC_END(create_idmap)
 
 SYM_FUNC_START_LOCAL(create_kernel_mapping)
-- 
2.30.2

