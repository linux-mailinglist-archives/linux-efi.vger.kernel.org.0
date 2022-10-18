Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEBF6029D1
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJRLFJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJRLFF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:05:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A2B3B461
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A93AB81D4C
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332CC43150;
        Tue, 18 Oct 2022 11:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091097;
        bh=1QTkaT4iHMGgddft3nM2F14cfzLMiHsK/itOeD3mJxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JF1jxCToj6+Ejp1PGlriyLvKJ6WX2APs4H1HQ+/CDc59zCq7KrVf90yxVWv9eEjmQ
         RDM6qnzcBWBXKSO5MIFYnVONwLvFQYKHrb/CpqALJh/8cCkypEujSf+A9rUpyDp8w5
         3zpjYdeEmm1RKiyGjJQkegOO/UAXMXLiz4yRGhnQt8MiKM1Df26i8kQ42Njl149ZRR
         irt+LAH0hm1nPbniFX6H26g9l+vNx3OHtBexsLiRIYhR/IaV+1RvyDG9gsukZfVzC4
         Fxr+F0kpj7/EOmESltIK2sA4ljyDn41yW/yqNf98FFsZO8MyeI6z03kO6pEju6fsBm
         HYRXufmmXfSLA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 3/6] arm64: head: record the MMU state at primary entry
Date:   Tue, 18 Oct 2022 13:04:38 +0200
Message-Id: <20221018110441.3855148-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2430; i=ardb@kernel.org; h=from:subject; bh=1QTkaT4iHMGgddft3nM2F14cfzLMiHsK/itOeD3mJxI=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTohDgqXMMD4mKkQSjAgLNYwoP57fkVrc7w4Ft/Gp ZphNEoyJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06IQwAKCRDDTyI5ktmPJFKTC/ wOWqe/dRAf/kQER4xUM8QKLKEG0aM1mkAslFsVmDxCwJU6xuWIcEagW8STn/2auhyJDTFqxYZEE6QZ AW3WtSKTHqzCNt0+NMoKPEyFRWkbvjvp7almBkmLFWJ2M4KkhRdYZ+fIfIKjWBiOQJygKTc/xMz/FX Z63UcvhuiOQxw/jmd4ohEm+CAiohxDKUIyyOoIsdvbQYjJuQ13KAa0bMTjJOwqtqSRog1bfhnJFCHw ln3rQ6zhDqCnDRHpaairVWBet7/L/t6nU7z5+JyDZLfkIDIo6Rmhht1wBiCbQH4Cp4u28Ms590mBoC RngYas8/PEqwElIvpPrPtSc1kRJTKil+48S+nFv0B798nXUn0LhasEYKOzynuPfbJj+Hmgglplwk0g w/Ko9o7FcK7OOe19LIL/N42BrI9n6l+D0vqz/wek2JljrBOh2lZWdNdCE1P7U+0eti77MXIrikb2uE Alr2sJaZNO3wQPPFfvjm0nOq6D+VcPHUYhcXPxNxUl9qw=
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

Prepare for being able to deal with primary entry with the MMU and
caches enabled, by recording whether or not we entered with the MMU on
in register x19.

While at it, add disable_mmu_workaround macro invocations to
init_kernel_el, as its manipulation of SCTLR_ELx may amount to disabling
of the MMU after subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 25a84ce1700c..643797b21a1c 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -77,6 +77,7 @@
 	 * primary lowlevel boot path:
 	 *
 	 *  Register   Scope                      Purpose
+	 *  x19        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
 	 *  x22        create_idmap() .. start_kernel()         ID map VA of the DT blob
@@ -86,6 +87,7 @@
 	 *  x28        create_idmap()                           callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
+	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
@@ -109,6 +111,19 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+SYM_CODE_START_LOCAL(record_mmu_state)
+	mrs	x19, CurrentEL
+	cmp	x19, #CurrentEL_EL2
+	mrs	x19, sctlr_el1
+	b.ne	0f
+	mrs	x19, sctlr_el2
+0:	tst	x19, #SCTLR_ELx_C		// Z := (C == 0)
+	and	x19, x19, #SCTLR_ELx_M		// isolate M bit
+	ccmp	x19, xzr, #4, ne		// Z |= (M == 0)
+	cset	x19, ne				// set x19 if !Z
+	ret
+SYM_CODE_END(record_mmu_state)
+
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
@@ -497,6 +512,7 @@ SYM_FUNC_START(init_kernel_el)
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
@@ -529,11 +545,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 	cbz	x0, 1f
 
 	/* Set a sane SCTLR_EL1, the VHE way */
+	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x1
 	mov	x2, #BOOT_CPU_FLAG_E2H
 	b	2f
 
 1:
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x1
 	mov	x2, xzr
 2:
-- 
2.35.1

