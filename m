Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153214FB857
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiDKJx5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiDKJwI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D811541F9B
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F280CE16CF
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2A5C385A5;
        Mon, 11 Apr 2022 09:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670575;
        bh=C3gzrQFKHEBqXaiW/FwDmIgNpF8Lr01RJwVGYMDades=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rib0l+9AlaQL6qeKlSC3vVu0fDnVyLu72JMQJvGHv9gkZ2ZTq2E+WTn9N4JmaYgG6
         eSVvqS2YcaTQIs3FARMIMdqisYWbMiImYwgehP4ro+Y15OMQlZCwug2lImzvJRC2y4
         0NiHiWChqwOVVBxMu+M47L6medsNbqgI1c2cAuJgxp016wnSR9gObPkNbpwoPFefAD
         SOdGlyLK/41Aj+eBENeHRWQA2VDdfvaS2hkCH2L2B2+yBgQV0HE2Gu+MsQoD2l3XDY
         21Vja8g4mLuvCw2BX7AVYBEbymJ90tyX9MkeOLCX6X9gvfiPW9Eur/j8YYc1G13v3Z
         XbfTnd/Rf4CjQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 22/30] arm64: setup: drop early FDT pointer helpers
Date:   Mon, 11 Apr 2022 11:48:16 +0200
Message-Id: <20220411094824.4176877-23-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; h=from:subject; bh=C3gzrQFKHEBqXaiW/FwDmIgNpF8Lr01RJwVGYMDades=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lZ/JZBZHxahP+H14buByBaeMzElzK5xRHx+6vG TspgKXiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5WQAKCRDDTyI5ktmPJI5NDA CpB1e4GUGYANOsleQ/LwIz8k3N/zQ3F8dJFj/c5zmCRkFsjmsfUwIY8F+ri9KKtYeOsZsaGzvV4uSn bbHoDOM92MMggMgJg20aqogqBkz/+N+FhGc8pnEdeoW9tYq1nRt5rtLq8hYKD92UQMdL1EoMcMcE6W gce/eefASl6j6AtnUqjDLkP6meF4Aq8Rwm6WO7cXhwS8MNtaxqzZYC+rTzS8E3Erk8BcqOMcbY1Bt3 1hKFjtJRH9Tk0tkEEAvONsF9r2JwYcniXIiNBm14oNtc776bEnzc1jWyyl3rXBzyIPs1FxWVS5C+TB ybqcqzT5bfgJvkaprtmU8pYDAwtAFh64rTOvp0D/yyvcWxu3UQgyuD2orCyrSUzk7eiTVUU9gXOphG tAhpm6VOT+QkyIqG+llBgSG8U96t0guR8wjcSDYUyBc4KsWUKALy72BtGc5ibySjyVn3Zhj2ea/x3e zSYRs34zE85YLlquvdtJbHhopsUZy9buOo38kUn+sSgtg=
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

We no longer need to call into the kernel to map the FDT before calling
into the kernel so let's drop the helpers we added for this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/setup.h |  3 ---
 arch/arm64/kernel/setup.c      | 15 ---------------
 2 files changed, 18 deletions(-)

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
index 6437df661700..5f147a418281 100644
--- a/arch/arm64/include/asm/setup.h
+++ b/arch/arm64/include/asm/setup.h
@@ -5,9 +5,6 @@
 
 #include <uapi/asm/setup.h>
 
-void *get_early_fdt_ptr(void);
-void early_fdt_map(u64 dt_phys);
-
 /*
  * These two variables are used in the head.S file.
  */
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index de546c8d543b..2ca8d4a509e5 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -163,21 +163,6 @@ static void __init smp_build_mpidr_hash(void)
 		pr_warn("Large number of MPIDR hash buckets detected\n");
 }
 
-static void *early_fdt_ptr __initdata;
-
-void __init *get_early_fdt_ptr(void)
-{
-	return early_fdt_ptr;
-}
-
-asmlinkage void __init early_fdt_map(u64 dt_phys)
-{
-	int fdt_size;
-
-	early_fixmap_init();
-	early_fdt_ptr = fixmap_remap_fdt(dt_phys, &fdt_size, PAGE_KERNEL);
-}
-
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	int size;
-- 
2.30.2

