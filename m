Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883726029D2
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJRLFK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJRLFG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:05:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E9B3B949
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ABD961522
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03C0C433D6;
        Tue, 18 Oct 2022 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091099;
        bh=XyJL/8SEF32qYGNUVw1eQPMZ3OctMavcgBrjB2KO9Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drHA4IKwrRO/yg42Rr+HJDZB5FhJHBzm4Yl/1inBn+YGl8WafkIB3yGPVcUX73y5H
         bY39w39IvRY4dkWTEU3zA68cWrId5E3wETGVMD14g15sYLezxUhRiQTy/1HaY02ALM
         OIsyu9K3UV/UFDeoVxezyBkWjhzwEahTGA3fUHNH0iZ2B6uihnXna5gGQxn7Yf+RQZ
         CTFf7u7kKfLsVppXSZYIAThV4NEqvF7fru2U9pFXABqLTI4MXoMMzjfEUIX2vGmd6G
         QblFIzyCv8x8CgiKkZi1VlkwqMxNs6GPmqDfH38lRLfdQ6IpRVOV4/anKjbZb5zf+5
         8UuSPWflP4Dvg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 4/6] arm64: head: avoid cache invalidation when entering with the MMU on
Date:   Tue, 18 Oct 2022 13:04:39 +0200
Message-Id: <20221018110441.3855148-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=ardb@kernel.org; h=from:subject; bh=XyJL/8SEF32qYGNUVw1eQPMZ3OctMavcgBrjB2KO9Fw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTohF5kWHwyv/QI5b27eYUOy19fcWWtdWHZdU2aUQ R7bmEyqJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06IRQAKCRDDTyI5ktmPJAxOC/ 0cT2Sj7Y9pvPUeeCLm4X+r7iMyGxhGtcUTjlruFJR/cPWBaCIYM5DICNFPFzznQOTsjozpSG3jd7Bp c9lD/woQ724tptXFWBaxQlCBOllqrwE7ndgMxO5OgfkA9pK4xJFer0exBk3hgdGGULdegnQ1hnHztz ALmab4kiINJf8N/mjjm6PFNYdGCl1s52lMhk6N8oW+9OFhjHWN3SGwuXrNAA5sqwwEG2bac8NYHMSR lbqBabpx64PWZ8BrTX/UTp1sBenuVLNvdReHOwMq0HV4kGHY5m5LQgkHGW6NF0lBJDL6KhTReNhIic h7vy+xJYfp3vngb+VKp/zZeVW7lSTTKZTZrYfqTG11sANrBtLPtRRBhuBu0SnnsuGLqNNm5MRGw9KF Huyew7mEiq4iIKY+OD20z0DsOgnjR0bz2iMmmFcdj7HdeNWKRgusOZ/sGhdE7TUS/4AOm4bE3Ogklb S8VFjP+DXyXOWSkPBXh8P7KL1KaaVyaHfJMHempQ4SbcU=
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
index 643797b21a1c..5de2ba3539a8 100644
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
@@ -134,11 +134,13 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
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
@@ -375,12 +377,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
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

