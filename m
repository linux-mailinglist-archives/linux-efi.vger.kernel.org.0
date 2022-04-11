Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0F4FB843
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbiDKJwP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344820AbiDKJwC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D5419BA
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F05CEB80F97
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1886C385AC;
        Mon, 11 Apr 2022 09:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670558;
        bh=O1r2IiWLwP2lKrF/aCfJ2B+0w6PbipWxiDGaVVY2Mw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8xOBj62cDHSDh68r9NzNmWSDDyKiBmzl5Q8287izZwwm1YT5S8gIKkeOKdF8TrGq
         Xe1iGzsl9BI41zT8Fnp0ihPGkspzNvghuj0uT6bmYWRwt0uYCpZaNxeFKRcDW8HfnE
         3RC2x4eKI/CAQdw3jXfRwnKe2hKNoLyPtNoUgFDD+sacWV4p0N8zpzcHzJcGcd78Bb
         eUC5PXrt448+mX0GhL8s/62aXyN1ck6vOga409CQSQS4EJ2gHgZtgnUGzWk4GHR6jN
         aMvAlq56rwUtnfTZWFfe/S4k6LlLuyhoPVTa7vjAMCc9rqsmbGyug9piyGIruotkQK
         +EpfZAAo0zIog==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 15/30] arm64: idreg-override: use early FDT mapping in ID map
Date:   Mon, 11 Apr 2022 11:48:09 +0200
Message-Id: <20220411094824.4176877-16-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638; h=from:subject; bh=O1r2IiWLwP2lKrF/aCfJ2B+0w6PbipWxiDGaVVY2Mw4=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lOmbAezGtgD+Q+3AsS4gfsGcUHYqihpwQH2LdG Ylm7TnCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5TgAKCRDDTyI5ktmPJKrlC/ 4maa/z3WiiLpAoKax6pd6HSHh4iwqwfzHGw4rMp8K2seUZwVBljjaTRhAkQDllZbAWJ6jo1d1C+MjC 1+hSCAQhdYNuWdQ4EFTuiKJhbu357YQcd4LH1dJt1X266mAIUAu8qZINGZkMQdPtG9Oz/jjO8HRlDm oGhVRKTOi13lHqMAVV6NcWp/Y14XVobSKDrmx3EQ3U2vmIzuNsrIjQGZomwxHHV6mJrOtHFB7Qhp/S pFK1Nkv6BoSlsTqSOgB4WxacYDXY6psOQGlBQr0zXjiNDdJRmond0A/23oXwLnEuNcuMiNnV/GNjhw cjJGsU5lQ/tOeKhNV2cgl1YH9LFGJiDH3eLeB4bRCuCReoKfXydPo14qyUJxsom7MzA9/Q1e/VnvhP zEZDqNet11qeKkXZawLZ8FBdCudJEmoOym6tK9j7eEUYE3+qmUitBoAbis8uPuyCBQleckOQVulGrO MngyLxQfeuwCTBbVgqvoUEj0r63KqY4RtwC1lZo8eLSFk=
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

Instead of calling into the kernel to map the FDT into the kernel page
tables before even calling start_kernel(), let's switch to the initial,
temporary mapping of the device tree that has been added to the ID map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S           |  3 +--
 arch/arm64/kernel/idreg-override.c | 17 ++++++-----------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index bec3805c941c..eae147fabbee 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -468,8 +468,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
 #endif
-	mov	x0, x21				// pass FDT address in x0
-	bl	early_fdt_map			// Try mapping the FDT early
+	mov	x0, x19				// pass FDT address in x0
 	bl	init_feature_override		// Parse cpu feature overrides
 #ifdef CONFIG_RANDOMIZE_BASE
 	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
index 8a2ceb591686..f92836e196e5 100644
--- a/arch/arm64/kernel/idreg-override.c
+++ b/arch/arm64/kernel/idreg-override.c
@@ -201,16 +201,11 @@ static __init void __parse_cmdline(const char *cmdline, bool parse_aliases)
 	} while (1);
 }
 
-static __init const u8 *get_bootargs_cmdline(void)
+static __init const u8 *get_bootargs_cmdline(const void *fdt)
 {
 	const u8 *prop;
-	void *fdt;
 	int node;
 
-	fdt = get_early_fdt_ptr();
-	if (!fdt)
-		return NULL;
-
 	node = fdt_path_offset(fdt, "/chosen");
 	if (node < 0)
 		return NULL;
@@ -222,9 +217,9 @@ static __init const u8 *get_bootargs_cmdline(void)
 	return strlen(prop) ? prop : NULL;
 }
 
-static __init void parse_cmdline(void)
+static __init void parse_cmdline(const void *fdt)
 {
-	const u8 *prop = get_bootargs_cmdline();
+	const u8 *prop = get_bootargs_cmdline(fdt);
 
 	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !prop)
 		__parse_cmdline(CONFIG_CMDLINE, true);
@@ -234,9 +229,9 @@ static __init void parse_cmdline(void)
 }
 
 /* Keep checkers quiet */
-void init_feature_override(void);
+void init_feature_override(const void *fdt);
 
-asmlinkage void __init init_feature_override(void)
+asmlinkage void __init init_feature_override(const void *fdt)
 {
 	int i;
 
@@ -247,7 +242,7 @@ asmlinkage void __init init_feature_override(void)
 		}
 	}
 
-	parse_cmdline();
+	parse_cmdline(fdt);
 
 	for (i = 0; i < ARRAY_SIZE(regs); i++) {
 		if (regs[i]->override)
-- 
2.30.2

