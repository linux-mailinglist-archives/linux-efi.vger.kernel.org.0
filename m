Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87E4EC895
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiC3PoF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348341AbiC3PoE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2261433E3E
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B12CA616D1
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B788DC34110;
        Wed, 30 Mar 2022 15:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654938;
        bh=2XVgmsF56y1icz9ml/x4C3CrLOrJjhf8ku8guxGluyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EzTtGjSSNvHI2GN6o7kSVeISyPYNXiEfA5iW4Op4l0Ak/nOLSj4irpY/hDPmDUMxB
         Zny1gPOWbZou0P24310VSW05VK0w1DTlqc1ZPU0GqOsJkrTpKe7dLX7jj/gIkbm/g8
         G25UedE/pq1buAJrAKl69SO7OUG2kJpFEE3RVrFSc3O36ObKe0c/+g2nIzVNID9CTZ
         x9oTAk7IgcFHQTpi2GBC0CS1B6oTZqqhi3hR9EhZ3d/o82Nrj+EDR+8tMBakJz4RVO
         5nVegoB8LRwE8cWdHssqV4fxQtgw+0Fm/rcyiR43f9SEc/ryinTA7pF/7JmH6RmqqF
         3K3qOQONyh7iw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 03/18] arm64: kernel: drop unnecessary PoC cache clean+invalidate
Date:   Wed, 30 Mar 2022 17:41:50 +0200
Message-Id: <20220330154205.2483167-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; h=from:subject; bh=2XVgmsF56y1icz9ml/x4C3CrLOrJjhf8ku8guxGluyA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHoz8v9i+97hjHtxztia+HkW+5AUge3p9D73EZan Mu7BTKeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6MwAKCRDDTyI5ktmPJCH8DA Crv17f82H/LBfBNhyAP7Ff0OA+mBKOavC5sA4sidYX3jSjI8V0+QsCNDuZ3S8Of2xTjmyc07KA6qlS +4AV6GDeMeubToqyZoqBlc2g85JO00uJ/zfeHEMxlVF2UgFCDsVbgzIlh2S5hfXyqntYVH2KYemYDn a8vg6r3RfST12ADhWeQt137oXcWlmnC1w9EyuR8f2HmlZT0n4dlRsqzLSngVgcggTO4K/VlK5IzNVa M/odVNT52hi7fT3KPTSp3MAJ6soW1AZ9sWGXSY4xf4tE8NwBB+8lZqe1XakXr0Ujj36TkLhNp4hpC5 q4XaWDD13Nn2/HBzv9swfkXZtMw+ePrdBimcL/0q6QO9WMXQkNbWqdjf5ThmdW1vzB2q5+qRChp+Mx 14ggKzA5lrflpQgVzen9Dpudx+/RZowOXmQdF0cQ4q0VVxGO/mPMm1aqNCvf7JLLXoRjnkROcLQy8G Dl91IBdiiAlBNTA0MnHaxYyjs5GLYbo6/ck3KGTdRGCR8=
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

Some early boot code runs before the virtual placement of the kernel is
finalized, and we used to go back to the very start and recreate the ID
map along with the page tables describing the virtual kernel mapping,
and this involved setting some global variables with the caches off.

In order to ensure that global state created by the KASLR code is not
corrupted by the cache invalidation that occurs in that case, we needed
to clean those global variables to the PoC explicitly.

This is no longer needed now that the ID map is created only once (and
the associated global variable updates are no longer repeated). So drop
the cache maintenance that is no longer necessary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/kaslr.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 418b2bba1521..d5542666182f 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -13,7 +13,6 @@
 #include <linux/pgtable.h>
 #include <linux/random.h>
 
-#include <asm/cacheflush.h>
 #include <asm/fixmap.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
@@ -72,9 +71,6 @@ u64 __init kaslr_early_init(void)
 	 * we end up running with module randomization disabled.
 	 */
 	module_alloc_base = (u64)_etext - MODULES_VSIZE;
-	dcache_clean_inval_poc((unsigned long)&module_alloc_base,
-			    (unsigned long)&module_alloc_base +
-				    sizeof(module_alloc_base));
 
 	/*
 	 * Try to map the FDT early. If this fails, we simply bail,
@@ -174,13 +170,6 @@ u64 __init kaslr_early_init(void)
 	module_alloc_base += (module_range * (seed & ((1 << 21) - 1))) >> 21;
 	module_alloc_base &= PAGE_MASK;
 
-	dcache_clean_inval_poc((unsigned long)&module_alloc_base,
-			    (unsigned long)&module_alloc_base +
-				    sizeof(module_alloc_base));
-	dcache_clean_inval_poc((unsigned long)&memstart_offset_seed,
-			    (unsigned long)&memstart_offset_seed +
-				    sizeof(memstart_offset_seed));
-
 	return offset;
 }
 
-- 
2.30.2

