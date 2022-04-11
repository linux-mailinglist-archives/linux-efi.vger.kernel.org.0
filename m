Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581704FB831
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344762AbiDKJvz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344810AbiDKJvY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2E419BD
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1D5A61164
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44832C385AC;
        Mon, 11 Apr 2022 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670525;
        bh=ezCtD03gd+BlFVjzy1QZJINfQRhaZrdS2CGkPF2JN04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Swr4L8aw2q7WvLiJoLiAkEZaHhLBYqt0vRR5dn20oEUaJvfDcqV3qABGxWOUlVWLn
         2THuserZMB+453QpIUea9WhdYc0TWvuGR+fi7Rov81n/v9rHUs9NH2T3Opqq9nSnF/
         hw7q7p0TmwBrwF7HdHKfcqf53VPHnp9lhhUVxYT1X3prrB5qbsL2r1PqSZPA/Rh9bH
         2gt4wSODIKYh+WsXnl/TbR8J25aRTdvPj/9mS+mwKrh7u4bBIyJwNuyIdD5UTSFcxu
         FRMMiZ2u7Go3sR3lT7UmGvPWF0MIHC9Yet7pUucyj3+LwKBfFlfFXRJAgdXZqQhulz
         jANstbO4phxfw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 01/30] arm64: head: move kimage_vaddr variable into C file
Date:   Mon, 11 Apr 2022 11:47:55 +0200
Message-Id: <20220411094824.4176877-2-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1306; h=from:subject; bh=ezCtD03gd+BlFVjzy1QZJINfQRhaZrdS2CGkPF2JN04=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/k3RkoJrVyON20j4c7YANGKSScRaBHFmhZh4GNE SPoopYiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5NwAKCRDDTyI5ktmPJKQoC/ 91KwS5lG9U/akIcV36XJFSdhXEY3tbQwETKNegGIlEdbDuV2/e3DXLGJn4m8R0OpiivSIWe11WBnKH qJUhlZLOHTGBsb5IUKV5Ce6AdApDqNTKWU1P85VGMZDqjVdxsP2dydlcBzEhPzJWy/wgFztlSrXBlF g78wn739mxYMsza3x8vBM12oi4Sm0zmRiQImb6RBLZSfAWoi8TvXBUxu73WGG+pfsn5VfO+v1KIBlR 9z9S5dFTvYTZ8mPTKoF65v0ryopZubEcB95X3sfnEPg/zqtykkhy3wmUna0HDc0lUvUJDrDf6R0PZQ i70+EFosBspwKvkag/NzVzi5aldslvrY2GBkyaECdNO6a5QbFbAHVKwKrY9HKD2C1PCz3GCJFlnb9s wn3oye/Tl6EpD4+HMUiPaz/z3WNuRegqtENo92rxWYZr9/S4iK+ETOFsPzGhymZndCZCeIIvV3NfG4 4w7OrcJVVacPSvcyUCnX79zjWoXYR9gaVqCHrCb8FC4hs=
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

This variable definition does not need to be in head.S so move it out.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 7 -------
 arch/arm64/mm/mmu.c      | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 6a98f1a38c29..1cdecce552bb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -469,13 +469,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	ASM_BUG()
 SYM_FUNC_END(__primary_switched)
 
-	.pushsection ".rodata", "a"
-SYM_DATA_START(kimage_vaddr)
-	.quad		_text
-SYM_DATA_END(kimage_vaddr)
-EXPORT_SYMBOL(kimage_vaddr)
-	.popsection
-
 /*
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6..fde2b326419a 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -49,6 +49,9 @@ u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 u64 __section(".mmuoff.data.write") vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
+u64 kimage_vaddr __ro_after_init = (u64)&_text;
+EXPORT_SYMBOL(kimage_vaddr);
+
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
-- 
2.30.2

