Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539496658EE
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbjAKKXb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbjAKKXI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:23:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7341121
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EACAB81AD7
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4A4C433EF;
        Wed, 11 Jan 2023 10:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432583;
        bh=lVzL4u7fbFytqZHkA+bhDd+RiaDuxY4ERcF5wmkoAQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwB9smYWakiTL3SCgfLGlPEht4vl342Alzh3dZm0/sdPEX079eJn1pmxwdJYd6XIB
         NYqUQmG7FzGGOi+mreT1BtAea+r8HglTBWyhtqx92FAZDCEbiA1c4JdzlD1d7gtOQU
         DAa7dtJAm6qnFVOsR4tm6ixnsAYgguLeGNz1Wmo1YPSNuXZQR2JXkFyBJgg7kxwuk1
         Vum+qy/jMsT7q9ElxDAOp77tIqYShSSGBpyke75nCN+KrDnt7h/lic0PyM+jI7pB/w
         Jqb4ZIbLO1p61NMeXFetH0bcX25CX8HJMd4Qk6W2So0btrxuAqEjuottnHf2K5ZzaZ
         5Nzj1PEIvb+GQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 1/6] arm64: head: Move all finalise_el2 calls to after __enable_mmu
Date:   Wed, 11 Jan 2023 11:22:31 +0100
Message-Id: <20230111102236.1430401-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
References: <20230111102236.1430401-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=ardb@kernel.org; h=from:subject; bh=lVzL4u7fbFytqZHkA+bhDd+RiaDuxY4ERcF5wmkoAQU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvo3kOZUmyhmGEAzzZbXeZoGW54M8VPLCpKqN6hpB 8njarXeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY76N5AAKCRDDTyI5ktmPJORNDA CGoLbdCcGsraeabZSNUoMIT80SG3cqt5/WHJW3loxv1IkKtAQNJeupjonQCv+8mhckwXVUaJaBrqFE /1w44iJVECAMsV+xV6rFDBSnhaJ0IWbwSPuvpRIoxqpbUr/ormBUmMZ2ufZnVbRh+Em+Yvk29ooFs0 9VhklOTD7oqkJmRiGqfv01mc1b0zt0dhTwN3X2AqxF0fvPRUQ59ZLnrQGtFJuJnYX8IZInK9zu/Ix7 2KGk7eqnjnfJRp+3O3LTDWoyzeGwiM+K5nQRFHJMlBTwUGaqYjD3OkuVyxDMxV+QYoWYpLrd+Z5tcF 6gpj18hsYMg/eKoC70/T8RqOi5th8u9K+6AX8qWPaD7KbymNotfxkTraD74xYmwXT0RkZ0x60d7xLO q0MaSA6+NpK4Jn+bRcEitqQnDnwgry1dzkYftGbAlx2m4gaa+gBnYfLOPuenGdvHQPGWZcLCGc/fzJ kUWBEDCBqB2zuQSE2TfjQJceKx2E1Xi5UPJPjb5BWq30c=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the primary boot path, finalise_el2() is called much later than on
the secondary boot or resume-from-suspend paths, and this does not
appear to be intentional.

Since we aim to do as little as possible before enabling the MMU and
caches, align secondary and resume with primary boot, and defer the call
to after the MMU is turned on. This also removes the need to clean
finalise_el2() to the PoC once we enable support for booting with the
MMU on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 5 ++++-
 arch/arm64/kernel/sleep.S | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 952e17bd1c0b4f91..c4e12d466a5f35f0 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -587,7 +587,6 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	 * Common entry point for secondary CPUs.
 	 */
 	mov	x20, x0				// preserve boot mode
-	bl	finalise_el2
 	bl	__cpu_secondary_check52bitva
 #if VA_BITS > 48
 	ldr_l	x0, vabits_actual
@@ -603,6 +602,10 @@ SYM_FUNC_END(secondary_startup)
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
+
+	mov	x0, x20
+	bl	finalise_el2
+
 	str_l	xzr, __early_cpu_boot_status, x3
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 97c9de57725dfddb..7b7c56e048346e97 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -100,7 +100,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
 	bl	init_kernel_el
-	bl	finalise_el2
+	mov	x19, x0			// preserve boot mode
 #if VA_BITS > 48
 	ldr_l	x0, vabits_actual
 #endif
@@ -116,6 +116,9 @@ SYM_CODE_END(cpu_resume)
 	.popsection
 
 SYM_FUNC_START(_cpu_resume)
+	mov	x0, x19
+	bl	finalise_el2
+
 	mrs	x1, mpidr_el1
 	adr_l	x8, mpidr_hash		// x8 = struct mpidr_hash virt address
 
-- 
2.39.0

