Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6824EC899
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbiC3PoM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348355AbiC3PoL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAFD34B93
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1556D61727
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA79C340EC;
        Wed, 30 Mar 2022 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654945;
        bh=p0HM6bJ2W5zi0lRXz9RkRFCa7ovecepIMCIRdegPyDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwB3vR9M9dLln9Bn3y2BvesfGczvQnvwZDNPU2lq9sg9xRz0mNB+/L1VCyg2LHpbN
         w/a4phw0D2HzCWtCh/jrEeiD77b+C4nqnNZtml8+RjPE26zRnK8tlD3YE1RHbs0icU
         Hj5BNlF9fFjk883MIqd2Wmc3Tj108FeQW2hTemUIzJEU7ImR8r/EfvfGl10uKHG+R7
         VFP6vNyCtB1TVsSgn+fSR5nEfwPsfVPbV3vtWuODsIO/ycIa339KIx8kdRpAZYnv8A
         KADJWTkE7Q6ZeEEw5VNLVhJqbCfkxbwxkX+kP/5JN34283QFHrB4RBtZeteRGpiKsw
         dqcK2Gl+OwEYw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 07/18] arm64: kaslr: deal with init called with VA randomization enabled
Date:   Wed, 30 Mar 2022 17:41:54 +0200
Message-Id: <20220330154205.2483167-8-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118; h=from:subject; bh=p0HM6bJ2W5zi0lRXz9RkRFCa7ovecepIMCIRdegPyDw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHo6lLpgYuYd8m7Cituz9DWVDd29GEV96RwqmEfh 2lFiCsuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6OgAKCRDDTyI5ktmPJIU2C/ 4ulB1H8LZGg3ksctnUZjEIy+NsHuPsUZkdFN0qzriUDi9C03ZDOMnQ9LpS59wPUz6bPeaLCu5nGFiG cbMEPo8TVSlFB2UPlYHjnV8Sjus+lnoNQyzaBDK843iph4a0i++V/65Zjf4Wz2ZkKu/kOyWhwHB+z3 xZ3H9t0AyzEyJLaQAItgfkonnVd0GOjvXyy/rARubhCbKlOqawmmxr/2aD+0GP3Qhp8rWR4uzhLmZO G+Ri7leX9yBgOhagkuB7e7uODY9kDMcBUSzGOJACp/88MA3MrRxt4ZWPKp+xbi7Y4vUW+afXRrwAYo eTMhw1UFLMHdL/3w1U9iwdc3+wG8qs2Li/80/18rCVeTSGXYJvKrPb2/95rfwZOuBuL+i+PvcRaMxp RTZMSHUBvPMDx+jEHLMT23Zd6zcSQVcVDZPfBjQFeU1/EUhpXnx5DK8jsTCvLco6o1HwBty+o4l04E rDhJ9lg/qlwMLGNq7dDiRb5DUxJFgAhKhymzGVyf+dbxc=
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

