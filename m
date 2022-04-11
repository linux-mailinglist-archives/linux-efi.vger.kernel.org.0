Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C94FB861
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbiDKJyA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344739AbiDKJwJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955464132C
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1626AB811AB
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6308C385A4;
        Mon, 11 Apr 2022 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670582;
        bh=s8AKGqEFOsz31ZwapTyGV7TPt8y4sHTFiRuOdTmTALs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JYLk+RscRb7totamDe2luXxAAeBHVobMOU++kdwvx8TgXehsUGdWdTj4M0PnaBtau
         lf5eBHut23RrhtTTv24wreGdCAglbWk6+wDEEicEhcii5QR2Uu9boGHdtBpoqezlIw
         s0hum98EH1rPnMdtVSILXerwYGeI5kwzdTDaxYRCCX2+ub2teC3cbkHJCV5/ymARUM
         KuvQzHXFvcxS0hC1SKsB2ZB07yeMuLJPJneOux8wVIElCVEK63pqbrxMHCCtDOMro5
         MEYqdRaYO/3Uhd5sIuAfEbdnAPR2WnhXt5VVqCXhY38ACZ2gc6zxNUisXhxjSXNUk5
         r0TqAZdHJlmEw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 25/30] arm64: head: record the MMU state at primary entry
Date:   Mon, 11 Apr 2022 11:48:19 +0200
Message-Id: <20220411094824.4176877-26-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395; h=from:subject; bh=s8AKGqEFOsz31ZwapTyGV7TPt8y4sHTFiRuOdTmTALs=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lfVrl2ZyQV7T/5jk+VV1+yTznDo1IHIGQ5m/vC SgaZc3yJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5XwAKCRDDTyI5ktmPJKZmC/ 48B2/AmID/cWaIXQdBsoZnGmGYf11fk+MevkVFdP+qgZk2hycc2bmaYNZpOGDjj/vYpbFsb3zflqCI 20zAr4IoM4m+8ZYxuse3W4w6P9bBYWwBMdFg+jaU+0OzpGIfPjhrepnBk304twV3ZgBhxcjlDzd94F wEleYYE+HrpEztLv8yPdYl1Lrz8PIAyZbLyDIh2y8MLj7c3lSLBl3EhyqO7Bgv5jMqIknulYX5eVt7 ufnDMx+3LMEsTvY+N5yCfdctJ5n5UrP7+eo+7GYT9BtmjrbekX/Ki6gZVcjIAQQs7R3lhuReH/JJmf KHGVqD10GNgDDwjv5EO4IBRdcYJ+NR1nRH3mBIeDYWH+klJTXdcX4zRclaJ7Azb9BQ2gbpv/ZpkwLc 5qGeHN+WGoISTcX6c+eDk+HbDatErs6CvTd+D5SRLRv8sLi1KHYBmLtOS553NCfURi7lfbfL3Cxa88 MzOnrgxIIuui33URZCYWiIrRsotxOpmqPCW6FAtl+PHD8=
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
in register x22.

While at it, add disable_mmu_workaround macro invocations to
init_kernel_el, as its manipulation of SCTLR_ELx may come down to
disabling of the MMU after subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cba9a5e8abb8..1ff474701e99 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -85,10 +85,12 @@
 	 *  x19        create_idmap() .. __ start_kernel()      ID map VA of the DT blob
 	 *  x20        primary_entry() .. __primary_switch()    CPU boot mode
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
+	 *  x22        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x23        __primary_switch() .. relocate_kernel()  physical misalignment/KASLR offset
 	 *  x28        create_idmap(), remap_kernel_text()      callee preserved temp register
 	 */
 SYM_CODE_START(primary_entry)
+	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
@@ -104,6 +106,17 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+SYM_CODE_START_LOCAL(record_mmu_state)
+	mrs	x22, CurrentEL
+	cmp	x22, #CurrentEL_EL2
+	mrs	x22, sctlr_el1
+	b.ne	0f
+	mrs	x22, sctlr_el2
+0:	tst	x22, #SCTLR_ELx_M
+	cset	w22, ne
+	ret
+SYM_CODE_END(record_mmu_state)
+
 /*
  * Preserve the arguments passed by the bootloader in x0 .. x3
  */
@@ -528,6 +541,7 @@ SYM_FUNC_START(init_kernel_el)
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
@@ -559,6 +573,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 	/* Switching to VHE requires a sane SCTLR_EL1 as a start */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x0
 
 	/*
@@ -574,6 +589,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 1:
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 
 	msr	elr_el2, lr
-- 
2.30.2

