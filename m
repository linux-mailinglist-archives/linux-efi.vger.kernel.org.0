Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB2C5A388E
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiH0P7Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiH0P7P (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B5629CBD
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF73660DE5
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09F2C433B5;
        Sat, 27 Aug 2022 15:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615953;
        bh=u6RnojkdSyuN3TFN0U+5RPR4Ta1CABc7iAB02cEFAMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUqQtvLkER8nQswrHYpatGyK71AmimiyYzJd2tPq1BB2F9afjxO23Z4Ty48uWkYpi
         8yXfB0vXG4Jl5xSm9C8QGhGqxbcD/cj7+fK4I2r+EMzOItT7j7O5ekGCOYdQTUkofD
         2JFLlpPBTzF/wKGHYWGHvMM8Ce2RFdUwb6uWd0imW32XWHZa7B9j5c07IImyMbGbCy
         qHigdKVLLfgLBsqlTu4ryL0av3bQCOI1SfgkYQkGLrJ8e+iEo35ShWAefhB8oJzoCp
         bu+pOwfMkFfPt4K3gJn/DQD1/JBx959uvijrJiuViGlFg8P13JhbHCJKIPQCVmQRHv
         r6uB+nBtfANew==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 5/7] arm64: head: clean the ID map page to the PoC
Date:   Sat, 27 Aug 2022 17:58:50 +0200
Message-Id: <20220827155852.3338551-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=ardb@kernel.org; h=from:subject; bh=u6RnojkdSyuN3TFN0U+5RPR4Ta1CABc7iAB02cEFAMw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj84FE3+/GEw5E1rDZD1CjUWauY7HYNl6xDdC7Vp 8Xvx47aJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/OAAKCRDDTyI5ktmPJNewDA CdLdHMVeIhSVFol6jn8/I0Qb0ImgSKF3Cu7Dq5FAWVAmqoSAAV2s/GGDQJtPHHyKnLbnKEskUd2eSr 5bdSGRhDYrM0VSZL1HVLTiDXVzKAvL1DchKZ3iPOtnbx/BLuTWsPc5mWlcyKFT5hUzbmd4ojszyU+U RgOwk22+9aqWfPlMsv6GoaNDobzjE5s1bL0qtKW25AJV2daNcKUJgSzvNrcQgDa9fLBIWt36Fx4GEc v3MX1N7W1Lx0jliTDrbQhK8exp5VenHZVoLwlxkDVNxvBFVztcYYHvhTnudMjbvhMBsp7x+6w27Td5 S1/2wjZshuGQ4SRp9U2MsRm5FLvkT0oRydLAX6tuJZagOBheq3NlUjaOQd/tCHsLYMKCKcEeVma3nv pIWmfjsxysoLpg5RaSVBIM8J8qfqzId/NOHoiWv83xbRC+HjUjFl36Uuyn3TtmWkGwRo0Lx7RYN/5m WtBqiSjHIyjjELINT5n81t2MFXLBqBEYuyyWui1oUp3pg=
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

If we enter with the MMU and caches enabled, the caller may not have
performed any cache maintenance. So clean the ID mapped page to the PoC,
to ensure that instruction and data accesses with the MMU off see the
correct data.

Note that this means primary_entry() itself needs to be moved into the
ID map as well, as we will return from init_kernel_el() with the MMU and
caches off.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4c5a5692c1e4..c8862e4bc45e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -70,7 +70,7 @@
 
 	__EFI_PE_HEADER
 
-	__INIT
+	.section ".idmap.text","awx"
 
 	/*
 	 * The following callee saved general purpose registers are used on the
@@ -90,6 +90,17 @@ SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	create_idmap
+
+	/*
+	 * If we entered with the MMU and caches on, clean the ID mapped part
+	 * of the primary boot code to the PoC so we can safely execute it with
+	 * the MMU off.
+	 */
+	cbz	x19, 0f
+	adrp	x0, __idmap_text_start
+	adr_l	x1, __idmap_text_end
+	bl	dcache_clean_poc
+0:
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
 
@@ -111,6 +122,7 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+	__INIT
 SYM_CODE_START_LOCAL(record_mmu_state)
 	mrs	x19, CurrentEL
 	cmp	x19, #CurrentEL_EL2
-- 
2.35.1

