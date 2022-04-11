Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0794FB837
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbiDKJwJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344847AbiDKJv5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4818D41324
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0BF61152
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED8DC385AD;
        Mon, 11 Apr 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670544;
        bh=D3Y+z2CgwBqoekMxwkb2ucgC0FP7HG6601DhcDR2wzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chaSpqnZZv7DlhwXB8cfXD5+B/2RHrFs8UMPOeQmRCuDOwQY21Z6Hbh69gJyqcuSP
         D0JaWkPjxmBJUDP7BlYZPGzBxsQwFm9SMmQLGLgsfrHrp9oLmmzt8IwWwDdrTR9GNr
         IPSzGbiZ9hhgtMz0CuEtqw8vRFmif/pLIafHQ8xXM+acYpCmMIfls4YnJS7J1V1ZvQ
         EQlYw5rPgWMdIdS+0L5OPjybOGgify9dUjq9z48TvnnEbFsCne70HVemc8Euv55bPZ
         VIh+yNlmhhhGw9uX8TLFFkUnD54A+19EUnuf5b0TBRGiPkNm/w3IZRWCq/FbFJjRWf
         tD5Hom75GVdGw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 09/30] arm64: head: pass ID map root table address to __enable_mmu()
Date:   Mon, 11 Apr 2022 11:48:03 +0200
Message-Id: <20220411094824.4176877-10-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427; h=from:subject; bh=D3Y+z2CgwBqoekMxwkb2ucgC0FP7HG6601DhcDR2wzo=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lEoirtDh7FaU7FC1agsn7FyZARnqEWUpzu1ICl 1mqkBjKJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5RAAKCRDDTyI5ktmPJH6CDA CYJijaGpa3Bvf+09FbcEunCfrRWVfFVPEgKQ+9TybsnVkM3evmurD1aRHu8mZBo9Ipr+J+0W/hzdzC jaXG815hk98IpuELcGRH3FK3H3aQYn/q1vxoTlx6wVwrccc0MzWfp2vKqIEjJJWqaEYqcDZxK7++jG fv184XxSdOq8cRG1eINGTdRMK7mnPIiLHeniMEBw6SH0DcAAu1BeO3geDYP5WrqX1us8Fy6cL901iu i6YIJCQHCc02ddpaXn6s7zw3MO0gDK4qW1YhWLwQvKr02wTvsacjOlZTdVhNqItQlC2M9EqQhkPwHA EvqLp5j8sBRQ5IMKCpzATIyyRDYE1e+Ml7Ium3Mi2mj2BIFyQTh0EyLPO9fvesjTTiSRiXnSD4P+tT AJyfcFRwZ9P5nbVwj16LlzdG2YXEcq9M5+i2pXSa1BRXOPhEDe9Qd/mGreiuR25HAGesIixNRFron4 WDrXT6kG3N5Ur23JUHoFdn7QH8Gq8nKfgEIykdQDqsZhk=
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

We will be adding an initial ID map that covers the entire kernel image,
so we will pass the actual ID map root table to use to __enable_mmu(),
rather than hard code it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S  | 14 ++++++++------
 arch/arm64/kernel/sleep.S |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1cbc52097bf9..70c462bbd6bf 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -595,6 +595,7 @@ SYM_FUNC_START_LOCAL(secondary_startup)
 	bl	__cpu_secondary_check52bitva
 	bl	__cpu_setup			// initialise processor
 	adrp	x1, swapper_pg_dir
+	adrp	x2, idmap_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =__secondary_switched
 	br	x8
@@ -648,6 +649,7 @@ SYM_FUNC_END(__secondary_too_slow)
  *
  *  x0  = SCTLR_EL1 value for turning on the MMU.
  *  x1  = TTBR1_EL1 value
+ *  x2  = ID map root table address
  *
  * Returns to the caller via x30/lr. This requires the caller to be covered
  * by the .idmap.text section.
@@ -656,14 +658,13 @@ SYM_FUNC_END(__secondary_too_slow)
  * If it isn't, park the CPU
  */
 SYM_FUNC_START(__enable_mmu)
-	mrs	x2, ID_AA64MMFR0_EL1
-	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
-	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
+	mrs	x3, ID_AA64MMFR0_EL1
+	ubfx	x3, x3, #ID_AA64MMFR0_TGRAN_SHIFT, 4
+	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MIN
 	b.lt    __no_granule_support
-	cmp     x2, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
+	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
 	b.gt    __no_granule_support
-	update_early_cpu_boot_status 0, x2, x3
-	adrp	x2, idmap_pg_dir
+	update_early_cpu_boot_status 0, x3, x4
 	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
@@ -819,6 +820,7 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 #endif
 
 	adrp	x1, init_pg_dir
+	adrp	x2, idmap_pg_dir
 	bl	__enable_mmu
 #ifdef CONFIG_RELOCATABLE
 #ifdef CONFIG_RELR
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 4ea9392f86e0..e36b09d942f7 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -104,6 +104,7 @@ SYM_CODE_START(cpu_resume)
 	bl	__cpu_setup
 	/* enable the MMU early - so we can access sleep_save_stash by va */
 	adrp	x1, swapper_pg_dir
+	adrp	x2, idmap_pg_dir
 	bl	__enable_mmu
 	ldr	x8, =_cpu_resume
 	br	x8
-- 
2.30.2

