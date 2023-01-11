Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98A06658EF
	for <lists+linux-efi@lfdr.de>; Wed, 11 Jan 2023 11:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjAKKXp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 11 Jan 2023 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbjAKKXU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 11 Jan 2023 05:23:20 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564331706E
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 02:23:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4129CE1B27
        for <linux-efi@vger.kernel.org>; Wed, 11 Jan 2023 10:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DAFC433F0;
        Wed, 11 Jan 2023 10:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673432588;
        bh=gHObniuOxNHTAroo4Q9eW2BQ31mqU1jn6IHWAhEPJO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2T3GP0kdrUOejzZ6Rw9dKSmjs6oCA4K31twbR5eHEU6fTcIbYY1e73wnUs47IfH/
         fOTAfVLhjDlRV3XO/3Nx6ffUCgrMO+kiByfTk0aYqh3Ndo20bnZfn08jBstrmLIKQj
         KFNQ19k1eUfjVMWJ+dQe1qI24fmxNVmFhmWZdnWn/VVatzneH1JlHbsN06iIPnrRWK
         LSYC8BceKkWxLj0paWpBTomNArJ64K1AWoVFVtKpGpxsAo55FwK7d0zPNy3Pt+VU1s
         6YX1d5r8eAB8aei6DwrH/pxJcOSifsTt2hlfVTgl1WlXYdDjSrET3XO5ZvIXfCw+Wa
         kdIAmLzgkGOjg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v7 4/6] arm64: head: avoid cache invalidation when entering with the MMU on
Date:   Wed, 11 Jan 2023 11:22:34 +0100
Message-Id: <20230111102236.1430401-5-ardb@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111102236.1430401-1-ardb@kernel.org>
References: <20230111102236.1430401-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=ardb@kernel.org; h=from:subject; bh=gHObniuOxNHTAroo4Q9eW2BQ31mqU1jn6IHWAhEPJO4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjvo3oq/GwOjCdOMkP3gzv7fJ4nXBKTAGCeax1eg/T OafiT/OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY76N6AAKCRDDTyI5ktmPJJT4DA DIhUCCSPUhAfdUmZLkKmUK4uxiTEC7gAAz+p49jCcl2rNkS6tBQLbwPOCAyt1oCPW+ccXyZZ/IrlWA DsjndoORpkrpPn7+16ZOU034eBEocejFANuzCuPiIZ3j7ZYiW9KrjylFaHXGYq+W+veYvLD0EaYeK2 5WOaZ18gqr5tq1Qd8sE0YXZiHuKhzXFM/QeWhPp8hyAj0MYwfYMy5pBQb5xJEgXsCG1mtqUYE40iVJ 1gKTPxen16zyidI/YEkrekj+hmgllEIHSzDDnM6laIliJaKrWqtDx9AXtxvtOf1Hg5QmQKu0GCdF/c qes/wjZggseoIu11f7PRucv04md0tiuAJirNsTsAgqYs+QlndFsW8rr9eYZ542mOF1TcT3V9n3Bqpn a4XRJembfXsB1xR83cS+qSte0LpovrO+XA3jM0jKpNlOAxuBnJfdgcLCJJVXpczOAc2GoP063gx5p0 dp+M4uLMzmDlmB0hoExAltsL+7mu6PN97kwJlfEZdMQmo=
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

If we enter with the MMU on, there is no need for explicit cache
invalidation for stores to memory, as they will be coherent with the
caches.

Let's take advantage of this, and create the ID map with the MMU still
enabled if that is how we entered, and avoid any cache invalidation
calls in that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c3b898efd3b5288d..d75f419206451d07 100644
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
@@ -377,12 +377,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
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
2.39.0

