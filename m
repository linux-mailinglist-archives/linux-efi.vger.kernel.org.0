Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FC6029D3
	for <lists+linux-efi@lfdr.de>; Tue, 18 Oct 2022 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJRLFN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 18 Oct 2022 07:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJRLFJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 18 Oct 2022 07:05:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F20E27B23
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 04:05:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01145B81E87
        for <linux-efi@vger.kernel.org>; Tue, 18 Oct 2022 11:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0957CC4347C;
        Tue, 18 Oct 2022 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666091101;
        bh=Y4hjTTjb2Eqy7jU72ay8krSE7XbZyj+VAYhAE2r2cFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmbA85qU8MKRkAoqWGnAAkHhJekpys4NZeX3ee36b6KcC424IMxb9dfUdajocgeri
         2Dr4dVBs3T2yXfctf045k4L6Gwwn13lSeTgA+x17fy/DaV9Sm2lKI3OdVJWpX9fyYJ
         c399UQKMIknEwhLnFl6bwrf9HUjgLBhgcopXCxW2Xbpnuu1xyUeMZXNNUN4rViY9uq
         M8UqO1ii/x+zk+39dxuC9y8kQs3pHrLLtENbnR1PwKHCASmAZPCSFEpVnGu+TO98Dw
         OLRHJtEbcJ9Bz0ZNwQlVP3AiO5ncOOfE7UX8wyy5X47/ca5APkrgU+qCSDmKmKXYJH
         bUJ7P3As0oNEQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 5/6] arm64: head: clean the ID map page to the PoC
Date:   Tue, 18 Oct 2022 13:04:40 +0200
Message-Id: <20221018110441.3855148-6-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221018110441.3855148-1-ardb@kernel.org>
References: <20221018110441.3855148-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=ardb@kernel.org; h=from:subject; bh=Y4hjTTjb2Eqy7jU72ay8krSE7XbZyj+VAYhAE2r2cFA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTohHVkL7JW14y8qKMeV5U+XdPVHM6T5CMZ5c5gl4 Wc39K6qJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY06IRwAKCRDDTyI5ktmPJMNtC/ 9hg0J4BHdgyXhsetzPiK5Sh/Ccq1qIsTokdsq7EreoMAhoDNTCxhvaFnC/KBssLR+doXlzjs2Bof7a R6R0IjCzfAZN+DKpwKwGLaqsgX/q8k8rQdkzgSZVkGe84otGxMFbkvFnsQ+rBfwsHGNRT+IQ7GKSzZ DKzCZoJuj6L8xWhATue97hitmd+GCpjLNIuWXGeGt99BO8tqYtdElAFZrQvVq8LMvWRc02FOcGkVkS FfbB6iv1618jvXVkdfbvPIuKT7fn+INMfbm5VlaGiYt2MMZfbw/31H2423LO8suWFhD0bJz7ZQpkXX Vwx45Jyl/Ol6+NLT1R8Y0zYrvsV439WiugY/R4eX8aixrWW8AcuSt6mdbXRsdDHgflFfG+TblYbs45 xgrPaQ7GPOwloHluT4Bms2Bne2EcwJ5gWngbmmgOB/0USUsLWqi8a1oYrei0qfAvCX1L5FUDoRjl+O CUflkuUYiY8mX/svV3QDkbazOILSOjZR5Ks8/I3d0tAOQ=
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
index 5de2ba3539a8..c8b8ed8477c1 100644
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

