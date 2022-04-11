Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399DC4FB835
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbiDKJwH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbiDKJv4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EC140E76
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82B18611E3
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00951C385AC;
        Mon, 11 Apr 2022 09:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670541;
        bh=2XVgmsF56y1icz9ml/x4C3CrLOrJjhf8ku8guxGluyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ngk8j4RxYGLWKxrKc2fZet+byMzDrhtKAFCxTXbx5HodYN3jFG0kP+cIxSXZoU6Fr
         Y9C83S9i/Kq1r+HKGsxgOrrzRjLTSkULR216PTQ/WObQjkw0TUErgF9yJCVz+zvW2K
         HXQ09cPO+x/lRZQ4NL51vMrCZe7tTmX/tJebeu/wiZIHNoV3S3cgLFEDNRe8MaYg/r
         I+9+UcHm7PwcWJlKAiHn2v/s1dlS5W6vr3mJiniXvqitUXwgcgI0nfiyJvkMyZg+PQ
         i2thcEFa0xg1OqIM4QicYnbIhNXpVE/L3uQfJbnd1eSjhM5p5rON9Xuqs3N03kCLhm
         6UU5yWncb9XiQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 08/30] arm64: kernel: drop unnecessary PoC cache clean+invalidate
Date:   Mon, 11 Apr 2022 11:48:02 +0200
Message-Id: <20220411094824.4176877-9-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; h=from:subject; bh=2XVgmsF56y1icz9ml/x4C3CrLOrJjhf8ku8guxGluyA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lC8v9i+97hjHtxztia+HkW+5AUge3p9D73EZan Mu7BTKeJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5QgAKCRDDTyI5ktmPJCxdC/ 0ROPrXD/TI1KNw24bQy4IZ0mZZeeqF4ofwfZr423kNAPNilB0ov82Hya/BlusaFwxDSj92ZvIEyCk0 bsURVyk/ZvFm46XYU/zYsodh88bXWh+URzmCg4WrZ5muvnwfGFnEJmaa+bd3zBLF3PvFa+emVDj2Ee H7ekQtRbOB8Eg2JdJxHAZLPfX7SqLMS9LC+K24815HtfT9GSkNhB/hmljXlQqNrOBe15iTy1b40mYt KxWzxVA5Uix/Wo81QdPu5hxlTGk4ryeeKgvA9V20lQPpaQGS0C8AAuXxm+qMJFk263Zy/mNKbpb4z5 TmolO8b2AchxZbKXKaslkTXZ0zV2cEHeTKYOhwhokP9WJn+6jXdd0vV1s/ajrlghBnVPC3M2xJjfuu 7mjWQ/S4bCrJTGgoACPmFcvGFC1EDUopsN31HlqR2Y2w2mohHccpQeesGJacDdHFWZxJxMxnPkNcPS BjhmQzg+vLeV78dT00GVIp7MecQD/26DyTuBWVNQu7NHM=
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

