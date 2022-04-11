Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F34FB86C
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbiDKJwX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344776AbiDKJwE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D3FEA7
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C49FA611B3
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46926C385AF;
        Mon, 11 Apr 2022 09:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670568;
        bh=p0HM6bJ2W5zi0lRXz9RkRFCa7ovecepIMCIRdegPyDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SBvb2MHe5VVkg+UBXHLC7juXlD6aiuUwLnyzwwqZ44gxE7ojvYZL1ToBDS3g1jzJS
         52EgSUvcz7l5s0VoKqSHGM1b7BEZGQins/KGgWxv0NsFo4wP04sjoSPSPUeONF6uTD
         VNolwzcpmPGRWJSqnTlss+ZXjAR5WpYiBRlorDEKeiNJFdgfYFys2+NqzIt63HASAZ
         JmOvKnsbxal1Vv0i/1g+n7jhXaO5ZxB1Eln/xeRUZaDwGnBdFRdjQHHI7ibO472Z7R
         yeAq8hewZXbHmHZFZYpviAjUWJELDTUJ4Hqb+gKzJGj6AWFQNayzTEqel9WTZmmhya
         37pKGuw50GL3w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 19/30] arm64: kaslr: deal with init called with VA randomization enabled
Date:   Mon, 11 Apr 2022 11:48:13 +0200
Message-Id: <20220411094824.4176877-20-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118; h=from:subject; bh=p0HM6bJ2W5zi0lRXz9RkRFCa7ovecepIMCIRdegPyDw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lUlLpgYuYd8m7Cituz9DWVDd29GEV96RwqmEfh 2lFiCsuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5VAAKCRDDTyI5ktmPJECKC/ 9GnbFIfvmXhg2KARoQsvFqlt63XFKF9d/aWERxIFvnLtrQsQLeqf/OLJdFL6wAJlFAHrV2W1iAJxQh GEUT1pHP677KDVLRYwOeSdYlDL/kOMm3k2Esr4q0AZ0UqQ0NQUdf5g7GxLvELN+GSY32rW3vda4SXw vKZ6WDc8KZ3UEaQAS5Va2zv4e7NYC8W7zBvud0ggMtw8s05EkzDjxbvFRWdh6aUFXvCJlaqbn62nqQ OyXo1m5Y+p/0W9+Ob1eBo0+GhCN44i2hsUMC1dGPLVTbEln/v6fV3iMRxIbLB+c4JNICJD9923x3dn Z8Q89V7eREGfv+C+dx6HOolM02k0O/6TozbRvqKORlUauZqJ6risIz2Plgf3mKZBGW8Cz1ImRq2SGn v3CZxOwPO6n6Ke5COipWf1gaB+itOgimspc01+52kE03uWj49ZOnga/Uuzp0LHPJXnulBFUWAUHxxC Pq9ybiPLmaOpnGkO2TuJZKYa6sRAUyAm0kqjB3Hf4yQwU=
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

We will be entering kaslr_init() fully randomized, and so any addresses
taken by this code already take the randomization into account.

This means that taking the address of _end or _etext and adding offset
to it produces the wrong value, given that _end and _etext references
will have been fixed up already, and therefore already incorporate
offset.

So instead of referring to these symbols directly, use their offsets
relative to _text, which should produce values that depend on the size
and layout of the Image only. Then, add KIMAGE_VADDR to obtain the
unrandomized values.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/kaslr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index d5542666182f..3b12715642ce 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -141,6 +141,8 @@ u64 __init kaslr_early_init(void)
 		return offset % SZ_2G;
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_MODULE_REGION_FULL)) {
+		u64 end = (u64)_end - (u64)_text + KIMAGE_VADDR;
+
 		/*
 		 * Randomize the module region over a 2 GB window covering the
 		 * kernel. This reduces the risk of modules leaking information
@@ -150,9 +152,11 @@ u64 __init kaslr_early_init(void)
 		 * resolved normally.)
 		 */
 		module_range = SZ_2G - (u64)(_end - _stext);
-		module_alloc_base = max((u64)_end + offset - SZ_2G,
+		module_alloc_base = max(end + offset - SZ_2G,
 					(u64)MODULES_VADDR);
 	} else {
+		u64 end = (u64)_etext - (u64)_text + KIMAGE_VADDR;
+
 		/*
 		 * Randomize the module region by setting module_alloc_base to
 		 * a PAGE_SIZE multiple in the range [_etext - MODULES_VSIZE,
@@ -163,7 +167,7 @@ u64 __init kaslr_early_init(void)
 		 * when ARM64_MODULE_PLTS is enabled.
 		 */
 		module_range = MODULES_VSIZE - (u64)(_etext - _stext);
-		module_alloc_base = (u64)_etext + offset - MODULES_VSIZE;
+		module_alloc_base = end + offset - MODULES_VSIZE;
 	}
 
 	/* use the lower 21 bits to randomize the base of the module region */
-- 
2.30.2

