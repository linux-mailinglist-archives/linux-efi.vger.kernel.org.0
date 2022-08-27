Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E475A388F
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiH0P7N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiH0P7L (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233382A403
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1DE960DEF
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC3DC433D6;
        Sat, 27 Aug 2022 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615949;
        bh=Zm8J5/cqVtkdAMXupnDeC+5FKe4l7eT8igiM+HWg5NE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=thGwgM8EVfqVGHZFBn4Oz2eLdFO1UoC/13nxKh1WZRXpN2z41WiAtz9syd83cLnt6
         byS1fFIyScIPjNbzwiFydSCWmSXVHfzhmJe/P/BdhUy3c/RdSE/hzeZe8WCtZqiqGO
         lxdscTMzOTmaLLeyPMylgR1xfm1CHrhgGhFTyJnbLkC2TGHiIlrkWnLic5FALWmCpZ
         tFEVO0yDbrf0nMsSpd727pZERu4quOxBg8rT+1IHPIFXC2g/t7xrxOJW5v5S+5y8Ao
         JBocTRiKJYpvp7f9xEgQBGsybRoSEjMdoiT6BLJ3w+KFLD93SffOVAsAknNr0nHY7d
         InE7xlbAVi9AQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 3/7] arm64: head: record the MMU state at primary entry
Date:   Sat, 27 Aug 2022 17:58:48 +0200
Message-Id: <20220827155852.3338551-4-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2382; i=ardb@kernel.org; h=from:subject; bh=Zm8J5/cqVtkdAMXupnDeC+5FKe4l7eT8igiM+HWg5NE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj8zAZwuW9Myc6nO4ilEtMFyuXz8XDbSK93Z/j3m hTvwHJiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/MwAKCRDDTyI5ktmPJGnrC/ 9+E5WECdGU9TKope+yAgIyCSMXAA0BR9rHSw/EmHWGu7OkyItsHT8RWx8zIIuoFKWmIYp+3w6aOoO5 aSjG8isgfKDQuU1JHl2z6p+/sMIiZQwk7yHcrQTlBHvMKw5w1z2rvCS+dRMdPeuWwUwgRZ9nU+QEvR /ew3qjg9d0Zr1AZRXgJSHv0dsm4TPZqFvhqzzj5EfUps2gNib8v5Ei8JEo3bnelFHjCvtyG3Ehs60m E+DlQLa0u/6kemXK8EfH8HfyLaKkqz+DLbcPihch/4MjGBTGDpf5QYYW2TFOrZ3wAi9gV+AkRM+vEA 5o4ykJ9d7anQWFvLTuUOc1ikD21gKffpCCaEnQNRCtwaZqpjrc+2wC+f4DN2eZgld5PS+daO4rDWo2 IuZ9hvPvpbjtMzuOii6EICKvb99srexaoCiwIIKJ2DmcwoUugkCp1lwHCqxFrvKDTmpdSBZmpvAP1g NzB7jR7ehNaxnoJxtAtOM7VwkwfmZ7gy84o+I1dAcodnU=
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

Prepare for being able to deal with primary entry with the MMU and
caches enabled, by recording whether or not we entered with the MMU on
in register x19.

While at it, add disable_mmu_workaround macro invocations to
init_kernel_el, as its manipulation of SCTLR_ELx may amount to disabling
of the MMU after subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cfc7ba25bf87..8e26f2deb78b 100644
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
@@ -109,6 +111,18 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+SYM_CODE_START_LOCAL(record_mmu_state)
+	mrs	x19, CurrentEL
+	cmp	x19, #CurrentEL_EL2
+	mrs	x19, sctlr_el1
+	b.ne	0f
+	mrs	x19, sctlr_el2
+0:	and	x19, x19, x19, lsr #2		// BIT(n) &= BIT(n + 2)
+	tst	x19, #SCTLR_ELx_M		// M(0) and C(2) both set?
+	cset	w19, ne
+	ret
+SYM_CODE_END(record_mmu_state)
+
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
@@ -495,6 +509,7 @@ SYM_FUNC_START(init_kernel_el)
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
@@ -527,11 +542,13 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
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

