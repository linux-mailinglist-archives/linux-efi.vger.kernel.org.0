Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510F4EC8A5
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348358AbiC3PoY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbiC3PoX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100337A33
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F83461727
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DBBC340F0;
        Wed, 30 Mar 2022 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654956;
        bh=AsUy16QUY67g3cS9+sxlqLA5RhJmuo9X0eKR6mPfwig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sc++pzOgPSOxWcZ51a1lE51OLcOiq9zPJcM+d258YEHKBpggGgk+mBNxgHtTAgNm+
         arrqjO3CkZOyEqvzc/MTFPZmwTjhmdMjGyOCata8fWUYQdkKyiZWPZncxIr4/6RMc7
         VXg/AIi9fRhIvUZ62XynQ07EbnMgqwPjZE44bgnvBePhPxZ2fCxjH4iAl0KlneH9sd
         pww1NhxwtaygJX3jdNAsB6+bvVSxXg21oLsG0/zvmMpkofBbczWGMAe8CqMMf1xY9j
         nkdDXq/y8aMjU0CO345P44hba+p/aSzJBF3CcPJ7+X3/wBi+Kv0wUfigxM4WL9rgUD
         HhMeMYrHJELtQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 13/18] arm64: head: record CPU boot mode after enabling the MMU
Date:   Wed, 30 Mar 2022 17:42:00 +0200
Message-Id: <20220330154205.2483167-14-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; h=from:subject; bh=AsUy16QUY67g3cS9+sxlqLA5RhJmuo9X0eKR6mPfwig=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpEqXtN+pBQ/DQKM/BAqICQqlF1Cql9agBDHxba aB1kIWSJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6RAAKCRDDTyI5ktmPJItgDA C9DxMVEU5LifGT1wvhh15YlNaqztd3h3VkMMG/Qb9WXtg4zqafbH/uwtRO9S87KYIFkuPBh399oKLI uzwn//fDmT5gI2Fo6QVxBh+1kO9qzYd4UjOYuMtlESha/Mkc5hfTbmgsiR0qDNWLGJec6s11Lre0EN QYc88PBu9Oazx34VQeEgSQeXrFeFpt/zYiQEe4dtscIbylYlHAYEdQ9JiSf5awKP0Q/Pt8XLjnihHh lNn14Cj4gPoY4C7yPfQLIp2WexswvnMuwQU2pazJG8qk3sCZmnlQ3UsvrMmWfmQkDc+9LtfJysvAjd aqXBaLCoVQKs5dVi/3YXTkSwut3w4/zEhUoyPrAsKyKO5efpZzHz6JQVj+/Qk4OwTtKw4Xp60pEVFJ 8ffy7vKz0cHT/ZnB5cVGzivxGhf8BKAjbZVsc9LH08omBbGJ5ZI58XAedj5vLBllFc00ZHxxRuIIg9 3U3bKzqPzBS0ZZa8v3ZAvS2APpcXrzcIQsF1zH+tMeFcU=
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

In order to avoid having to touch memory with the MMU and caches
disabled, and therefore having to invalidate it from the caches
explicitly, just defer storing the boot mode until after the MMU has
been turned on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index db315129f15d..ec57a29f3f43 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -81,7 +81,8 @@
 	 * The following callee saved general purpose registers are used on the
 	 * primary lowlevel boot path:
 	 *
-	 *  Register   Scope                      Purpose
+	 *  Register   Scope                                    Purpose
+	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x23        __primary_switch() .. relocate_kernel()  physical misalignment/KASLR offset
@@ -91,7 +92,7 @@ SYM_CODE_START(primary_entry)
 	bl	preserve_boot_args
 	bl	create_idmap
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
+	mov	x20, x0
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -576,8 +577,6 @@ SYM_FUNC_START_LOCAL(set_cpu_boot_mode_flag)
 	b.ne	1f
 	add	x1, x1, #4
 1:	str	w0, [x1]			// Save CPU boot mode
-	dmb	sy
-	dc	ivac, x1			// Invalidate potentially stale cache line
 	ret
 SYM_FUNC_END(set_cpu_boot_mode_flag)
 
@@ -615,7 +614,7 @@ SYM_DATA_END(__early_cpu_boot_status)
 	 */
 SYM_FUNC_START(secondary_holding_pen)
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
+	mov	x20, x0
 	mrs	x0, mpidr_el1
 	mov_q	x1, MPIDR_HWID_BITMASK
 	and	x0, x0, x1
@@ -633,7 +632,7 @@ SYM_FUNC_END(secondary_holding_pen)
 	 */
 SYM_FUNC_START(secondary_entry)
 	bl	init_kernel_el			// w0=cpu_boot_mode
-	bl	set_cpu_boot_mode_flag
+	mov	x20, x0
 	b	secondary_startup
 SYM_FUNC_END(secondary_entry)
 
@@ -646,6 +645,8 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
 	bl	__enable_mmu
+	mov	x0, x20
+	bl	set_cpu_boot_mode_flag
 	ldr	x8, =__secondary_switched
 	br	x8
 SYM_FUNC_END(secondary_startup)
@@ -861,6 +862,9 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	bl	__enable_mmu
 	bl	clear_page_tables
 
+	mov	x0, x20
+	bl	set_cpu_boot_mode_flag
+
 #ifdef CONFIG_RELOCATABLE
 	adrp	x23, __PHYS_OFFSET
 	and	x23, x23, MIN_KIMG_ALIGN - 1
-- 
2.30.2

