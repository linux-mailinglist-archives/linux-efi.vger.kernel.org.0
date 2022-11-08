Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C696D621BCD
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiKHSWh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiKHSWg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9AE271E
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 63DCDCE1C42
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC1B1C4347C;
        Tue,  8 Nov 2022 18:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931745;
        bh=4ivurFOMcnYVOQgldP9y6PNo1y3QrIuNCSXZfDe0wZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVtw7Hu6DUvbpKOVwV/p+CiSVKwcPVqSVk3gCi1n3Nt3wqlPfHhCVGMUwruGPS6J3
         pmEm4gikkcFP/soLswtTydF+otSWBMzi3GfXAymKY/1KMFXmuiGMQ3ZtPTWSUHAml2
         O29Byr2b/la9thOg+uUKOsz16iZSbMPQiTWqtF/Xo4gpuXcNasjgxbKm3z59LyoWIx
         0RYObraV2IpHeXP7UOB3GHch5yGblV4xRsZ2HeEFDCeAz3lTDg+QghZXR2EAu/lNeK
         5ouSIRj1wcgVfLfptMgFOOf4WMDpLWO+D3fEUxQrQ+jswYSlPBnKzPZ9wRviOZBV6I
         5EQAAFFcHNKrw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 1/7] arm64: head: Move all finalise_el2 calls to after __enable_mmu
Date:   Tue,  8 Nov 2022 19:21:58 +0100
Message-Id: <20221108182204.2447664-2-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=ardb@kernel.org; h=from:subject; bh=4ivurFOMcnYVOQgldP9y6PNo1y3QrIuNCSXZfDe0wZ0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5BO3NtnUnMpfrLBi1Z4al4QY8BVK7KA3An1EL2 0mSkueuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeQQAKCRDDTyI5ktmPJJX2C/ 42SFuWsziw4ywk1XWPY4JihPVVfjieJZmi7x7P/St0q6g22TzuRgPc1HbK5Ee3bnj369AicFRyAq61 IAJWhgphN7cRjqBIlFr+NzqDdILqzAXUrzbU/xm0/Do5JppTZGQJoYGFrm/gfeRr9jiqWKIpF12DQ0 CyxEwEMWkKMIJ4/adII34MENXO2QH37y7rPQdqFYpeoQ2/lflnu/5V+bcya4SjD4W+uTwugIFYvHqc QYbsAfNFu/w1z0ktxWEQgpJLrs7R8UTAVdIrd+yAKPzk50NeoXBqvcm2I2gDNdAqZkmzl879r1DnYi 8hB450QJySYGUQTPzNOLD+GYi0boNFZW1sQxULXSqnbpgWTajPSiFsRuOn3ba1ubY+A4/6D8qI29WC EkhQgdK9n0YPsXwtOJparTrLLv064cG2e4IXOMQGuBiAv7oZ963DgJ29l768/47rn1GLYz4g7Irx/k Vh8a2fwsny9yikkE5+xIVFDTig0Xszprw74DRE6tVZKr4=
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

In the primary boot path, finalise_el2() is called much later than on
the secondary boot or resume-from-suspend paths, and this does not
appear to be intentional.

Since we aim to do as little as possible before enabling the MMU and
caches, align secondary and resume with primary boot, and defer the call
to after the MMU is turned on. This also removes the need to clean
finalise_el2() to the PoC once we enable support for booting with the
MMU on.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 5 ++++-
 arch/arm64/kernel/sleep.S | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 2196aad7b55bcef0..c59e0d95b44d0901 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -584,7 +584,6 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	 * Common entry point for secondary CPUs.
 	 */
 	mov	x20, x0				// preserve boot mode
-	bl	finalise_el2
 	bl	__cpu_secondary_check52bitva
 #if VA_BITS > 48
 	ldr_l	x0, vabits_actual
@@ -600,6 +599,10 @@ SYM_FUNC_END(secondary_startup)
 SYM_FUNC_START_LOCAL(__secondary_switched)
 	mov	x0, x20
 	bl	set_cpu_boot_mode_flag
+
+	mov	x0, x20
+	bl	finalise_el2
+
 	str_l	xzr, __early_cpu_boot_status, x3
 	adr_l	x5, vectors
 	msr	vbar_el1, x5
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 97c9de57725dfddb..7b7c56e048346e97 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -100,7 +100,7 @@ SYM_FUNC_END(__cpu_suspend_enter)
 	.pushsection ".idmap.text", "awx"
 SYM_CODE_START(cpu_resume)
 	bl	init_kernel_el
-	bl	finalise_el2
+	mov	x19, x0			// preserve boot mode
 #if VA_BITS > 48
 	ldr_l	x0, vabits_actual
 #endif
@@ -116,6 +116,9 @@ SYM_CODE_END(cpu_resume)
 	.popsection
 
 SYM_FUNC_START(_cpu_resume)
+	mov	x0, x19
+	bl	finalise_el2
+
 	mrs	x1, mpidr_el1
 	adr_l	x8, mpidr_hash		// x8 = struct mpidr_hash virt address
 
-- 
2.35.1

