Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC11E4FB842
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbiDKJwQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbiDKJwC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3841F96
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63464B80F52
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C949C385A3;
        Mon, 11 Apr 2022 09:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670561;
        bh=NfYHb8uRiznV0/lqv/eaEk57pNDFEjEWBlGAGII44ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IytDfc6GfDj2yUd0gEVJqefXH+eKRx1bbQDZVG0gTGP/+Tzml+HsVy7cXDJZSeG00
         2cJ1p+pPqVAX/eiXoEjxzcs2M2wAGstZQQU3+zz8C+74QGgGHrdFE6ISjgeU5NZnLH
         gHtZZRKfDYywL+o3udfnHZL4+7OBqJm+UwkqWJTaOE0V76jOvo/qLCruhnlM3D6PYz
         ESGDbnFTT7q3JI9ysePhde0Ad4WTOGPxKfHfqJdrjoKDIAJ7W3igmHsrresvi6xJJm
         5+9y4mPasV4eCqzCYJEkp4TV47OQ3+7SJnITQI4tdqmEdE4IYOGd1veCc5vqyaIeAp
         WNDIDNQ7zxcjg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 16/30] arm64: head: factor out TTBR1 assignment into a macro
Date:   Mon, 11 Apr 2022 11:48:10 +0200
Message-Id: <20220411094824.4176877-17-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; h=from:subject; bh=NfYHb8uRiznV0/lqv/eaEk57pNDFEjEWBlGAGII44ng=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lPIa2f8ZRyBJCObdKzMYXRfUIFoFzIcKkYCYAJ sOzR5ziJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5TwAKCRDDTyI5ktmPJBYfC/ 918YcRhxMBTDNXqgCUk+7/E6r7rGOSDBYOf37EEfYj0e+vlR+uXaX3Hu5PWOZ7NHp+HOWQI7whcRcC KwjJWibfjeyD7EW4GhFHLr1qi8e7TgiJbgFNC5GqIy7mP8kmWmeGeF/Oc6OojPpjdSTuvD0qyLT6++ TrabAFW+dcohAmNwGdgU3QHnYE9KUDuOIsKDf/h2GvS/EvBXYNmOhsS9oTPqewIQBnubcfkLX5fTpq fVhJlHe24OsNsEtCP5cBq2Bdyx1NnVo3N+jY04/eCFofE/SM8aIWxkjHdd9Ot6IyXtU6f9vatR3H9L NUDVURkaJi3cGpt7aTPMFtqLVNqSZd0DqfQZg2I0KcMx5NbOMB/OTGMpqumLF0659FwMHrHrgqh//a epiCQUztnsrktDkGwXAun6/S6oz+Q5cP4ilJBLhlMK1PTQGDiFvGt2Tud5nH7rnoQWRkb99RyIwG2I xYv7X1aT97xJDy3MgjVMi0Aexwie49Ot2qo5+nH2njQtk=
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

Create a macro load_ttbr1 to avoid having to repeat the same instruction
sequence 3 times in a subsequent patch. No functional change intended.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index eae147fabbee..e52429f9a135 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -697,6 +697,13 @@ SYM_FUNC_END(__secondary_too_slow)
 	dc	ivac, \tmp1			// Invalidate potentially stale cache line
 	.endm
 
+	.macro		load_ttbr1, reg, tmp
+	phys_to_ttbr	\reg, \reg
+	offset_ttbr1 	\reg, \tmp
+	msr		ttbr1_el1, \reg
+	isb
+	.endm
+
 /*
  * Enable the MMU.
  *
@@ -718,12 +725,9 @@ SYM_FUNC_START(__enable_mmu)
 	cmp     x3, #ID_AA64MMFR0_TGRAN_SUPPORTED_MAX
 	b.gt    __no_granule_support
 	update_early_cpu_boot_status 0, x3, x4
-	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
 	msr	ttbr0_el1, x2			// load TTBR0
-	offset_ttbr1 x1, x3
-	msr	ttbr1_el1, x1			// load TTBR1
-	isb
+	load_ttbr1 x1, x3
 
 	set_sctlr_el1	x0
 
-- 
2.30.2

