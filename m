Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDC5A388D
	for <lists+linux-efi@lfdr.de>; Sat, 27 Aug 2022 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232887AbiH0P7N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 27 Aug 2022 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiH0P7M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 27 Aug 2022 11:59:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D42C29CBD
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 08:59:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB7DB60DED
        for <linux-efi@vger.kernel.org>; Sat, 27 Aug 2022 15:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87074C4347C;
        Sat, 27 Aug 2022 15:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661615951;
        bh=rduofxKv06cjLI775l5wG9qfruh5afXftQCd8hJnRpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBnMsf305e96EibBb7MqOJmdqTgJs+79l/VLq9kQIMnJOQr/b2pzI1PrvsM03oEHc
         PyvyfS7CqYvwCgAOnxN0ZzJc3O2ozZVS3DgG76xsuB0EBrdDh5u20zLajvO8Z4SLOn
         tWK0HkzaDB334DXVX98iu2eC165TVUY1sT/+Sl3RVK2Rc7Yje/aoUTsr5iN+B0cbnN
         UVr+WRanhQGM1WSFBJhbTrmcLE+Xr0oFOQJHN+U7k/xGMKw05imRjisE4YvXdxQR+j
         1fmdLidlHAeMZq6OT6EfpWrBRvw4mYHfx6ji6qklL67+Y1XUSKErGupUNCuuHTCbQC
         09JQLG8Zjixaw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     will@kernel.org, catalin.marinas@arm.com, maz@kernel.org,
        mark.rutland@arm.com, linux-efi@vger.kernel.org,
        keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 4/7] arm64: head: avoid cache invalidation when entering with the MMU on
Date:   Sat, 27 Aug 2022 17:58:49 +0200
Message-Id: <20220827155852.3338551-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220827155852.3338551-1-ardb@kernel.org>
References: <20220827155852.3338551-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=ardb@kernel.org; h=from:subject; bh=rduofxKv06cjLI775l5wG9qfruh5afXftQCd8hJnRpA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjCj81T3FObq5Tunuz9GbT4RppS6Hs19oKsFHKEq/c JNCiTomJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYwo/NQAKCRDDTyI5ktmPJFjVC/ 9/RUDvV+gb7ZZFRsSJG2OI7+D1DeKpRGa/19kufY5DIHXtbhENCW3RHCnzvotUz7/q68u7SMwro0sY uaUmI+Yqd1eh4RLpX93IC2BbagXvxlD9dI2c8nu6eodia2jpk3omBrWQPWbH9s+llYkowOuMzLvPG/ gFQ4jlgZRM+wz7t3MixevoDZK15EOfqCOB6ry50XXcbqp78P1mQr0Kf7mbphYNzEuW/w1BjTfLROqI MT2MV2/6d8QEAUrff0f22zkimID+0IVBRaaTTJ9iu1oQm7viBb4HryHt4ocTZhkVRHo/DfuAfd56JQ 9kcRsVO9gkRv9E3OUrn+hoNoTGQ8XYMp25sj+OHqfvBCy0dhZie9M2zffTbeYLG+uOF6W5waWaXu9h hywv6Zg3l6n9e6MUMhejMQZnU14h9FZa3rnHsOcienVO04k2TSbLopC3yAVe6kdLhXqXfDFcitaIGk GEmEDv2tgZiaTBSf2v2VScMTtYA46gpx6WIuHOzy0dj+M=
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
 arch/arm64/kernel/head.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 8e26f2deb78b..4c5a5692c1e4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -89,9 +89,9 @@
 SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
+	bl	create_idmap
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
-	bl	create_idmap
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -133,11 +133,13 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
 	stp	x2, x3, [x0, #16]
 
+	cbnz	x19, 0f				// skip cache invalidation if MMU is on
 	dmb	sy				// needed before dc ivac with
 						// MMU off
 
 	add	x1, x0, #0x20			// 4 x 8 bytes
 	b	dcache_inval_poc		// tail call
+0:	ret
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
@@ -374,12 +376,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * accesses (MMU disabled), invalidate those tables again to
 	 * remove any speculatively loaded cache lines.
 	 */
+	cbnz	x19, 0f				// skip cache invalidation if MMU is on
 	dmb	sy
 
 	adrp	x0, init_idmap_pg_dir
 	adrp	x1, init_idmap_pg_end
 	bl	dcache_inval_poc
-	ret	x28
+0:	ret	x28
 SYM_FUNC_END(create_idmap)
 
 SYM_FUNC_START_LOCAL(create_kernel_mapping)
-- 
2.35.1

