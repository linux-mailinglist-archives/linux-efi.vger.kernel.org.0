Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1044EC8A2
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiC3PoW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiC3PoU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B774533E9E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C9BEB81D69
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C4CC3410F;
        Wed, 30 Mar 2022 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654951;
        bh=VnakrP68jMnJ7VVKYfr1DkuBhjm1zYhf09fUkYU6tZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdgtQYJqkSbJnuPBFalasAzfOTUx1wAITPJ+pY/7TjyD3WxqwT8NKr4Yj8UilIgi9
         lcq0SADqc60yQgYXXlo0dDOjowsJzRya1V+zFhjOfaMOYp19/Rdj7UhcsODSceMZm1
         HGxJlU/etR1o3MddqJxs9Soq0bRxvUJBmoGD5/ew+tRhItA2t+EOwGL6V4BVLK7dmF
         Fu/rH/za9+DB+nMEfVNSDSzeq46knU8nBfQ8yc4b82Xdz+dWDp//WelDDu3dmA28DF
         9IHyIVyi3c0AcmWAgQAwKIIrAGYuN8WybUByqJAsHKr6RrLVvaU3KFAOLwFBwiVHOX
         g7fJAEDqDGKaw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 10/18] arm64: head: record the MMU state at primary entry
Date:   Wed, 30 Mar 2022 17:41:57 +0200
Message-Id: <20220330154205.2483167-11-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220; h=from:subject; bh=VnakrP68jMnJ7VVKYfr1DkuBhjm1zYhf09fUkYU6tZU=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo/CuCO1CDC3F1jfOi5U0g6OytEgCjUpRq73M4e itcfC8+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6PwAKCRDDTyI5ktmPJOhGC/ wLFqlyboSaMzIoukbL6OLiJ3OnHkaSboDffWF0+ubx9bTG+iFNXqYQBxNzf3yhQtTFwJxtc8LhsXG6 9ZlmIqPDh+G9/mxpBLNQ3ZqCA0h3t/nw4EXPBYxVOD+n1lkgTl2umjU6T8kgTqB5uOYjFLgPDBBO0a npXhBQ93uGI1oyGERO/CTulm6qIOm12P8QSi6t7KY891PVNWfYDD+7mz72ILJIkFHt+BINs6MzUmIq 38yKERoUjE051YcDAnE7wJO6agxlyGrv5kp+HXF+FQQuVEDoWoalGKdjtyzpeLKrGFb+nxTWpeRTs6 cx+GwH9bZj2TBp+xTjM7bNOkD9KyGW/IYdJn/A0+kCgunQGOJTfUr5fBQJ2A7VtJiPfSZ5AVKRH8Eh 2lJ93E0cdyn8owuQWclmXDFuUd5We1Mc/lO80HfFDXX6wwNFByoiRhkS6KhfByHceMspO5VLr+nJ2l mwwihh0Sjyk8tu9V0yB10BwYIPZ/1LXBW6GXLIPJmuZTw=
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
index f3b096daf1c5..44e2e39046a9 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -83,9 +83,11 @@
 	 *
 	 *  Register   Scope                      Purpose
 	 *  x21        primary_entry() .. start_kernel()        FDT pointer passed at boot in x0
+	 *  x22        primary_entry() .. start_kernel()        whether we entered with the MMU on
 	 *  x23        __primary_switch() .. relocate_kernel()  physical misalignment/KASLR offset
 	 */
 SYM_CODE_START(primary_entry)
+	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	bl	set_cpu_boot_mode_flag
@@ -101,6 +103,17 @@ SYM_CODE_START(primary_entry)
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
@@ -485,6 +498,7 @@ SYM_FUNC_START(init_kernel_el)
 
 SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 	mov_q	x0, INIT_PSTATE_EL1
@@ -516,6 +530,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 	/* Switching to VHE requires a sane SCTLR_EL1 as a start */
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr_s	SYS_SCTLR_EL12, x0
 
 	/*
@@ -531,6 +546,7 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
 
 1:
 	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 
 	msr	elr_el2, lr
-- 
2.30.2

