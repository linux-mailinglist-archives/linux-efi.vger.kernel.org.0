Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5D621BCB
	for <lists+linux-efi@lfdr.de>; Tue,  8 Nov 2022 19:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiKHSWe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Nov 2022 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiKHSWd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 8 Nov 2022 13:22:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0D1163
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 10:22:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA8D461727
        for <linux-efi@vger.kernel.org>; Tue,  8 Nov 2022 18:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D6FC43470;
        Tue,  8 Nov 2022 18:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667931752;
        bh=L5q3Hzdh1HbKLn9PVJqkB2WytTwlIIHjujoTsQXL1Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMa//HNmViFf3Zk/Dn72obg8yCz47D75F8c5Y+x9+dJxAjGJx5V23Lwy0D/BnMbu6
         +R4y8PFqrEkv38RWevx9nLo4oMdSVwRG246tsweDDWX6ONOtTbmUeQrHqQ+CZwSnW3
         HhKkMSS7dd7RwXpwOygUTz9dS18xZCZGfhiEHpCQQXnflhiIcTaYXnBq4VWjgi4hqd
         6aYGM5JN4r2KHVjasAXnFQOMo3VhuDquBH7g9vcv9soZn6rxrsTGU6CnqC16fbJNHQ
         e7FadPuT7Si97/cM9qxkfCFx9kFxikb9iFbtzGJu5Y3jefS572BzgAFT9RViY0ClWV
         UPKB3LlF/pSSg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 4/7] arm64: head: avoid cache invalidation when entering with the MMU on
Date:   Tue,  8 Nov 2022 19:22:01 +0100
Message-Id: <20221108182204.2447664-5-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221108182204.2447664-1-ardb@kernel.org>
References: <20221108182204.2447664-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=ardb@kernel.org; h=from:subject; bh=L5q3Hzdh1HbKLn9PVJqkB2WytTwlIIHjujoTsQXL1Uw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjap5Gwd1LA9GuF/9QsQ0L389fKmqeZ3BEvPyQcdV2 9eokvUGJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2qeRgAKCRDDTyI5ktmPJGxbDA DEIc4rgcoZghfL2wuCC40W+38B0i4SCAPXX3J+fCB9/w1Q8uBZDRoZAxhAaO5NmLYVLIgZZpU06Zv+ rRi6wqY+DlCGsLIvWXT9QNwYvgp67gpjj4QJa8mTrqEVdkWFlPv5cZI85FEqU0GDXHqslZ9Pxke2VP AivCF9OngqI4+tCdi0pxngDw+XBPgqCt2yMD8AMEbpPPRGXpJiHUho1CzdYOvKESOjqSQDsD/zJp0F C+NUN4TRZ1fBuLcuyHZVzCD9Gy4GGm6ltFhuZT79sygqF+wWCDcfQNYiuZvMgXE48kE74vl8+lO5tk 7BOI/80cIhSHe0yH+lhdCPXnBziODR0HBuZQsAJ18FQyWmwprdByBGjCcWtatzjfKue0YUMOj+rK4P lfDcyousyRTnUTbB6+gH1pf1CiIThTAxcZuMdBD0O4WAwQaZyvWD5xww86USyrupzFP95MQCCqLyjM Qoy2lUp/JNG1S9C2m6jukPmflj8i8AnHSpVVKamdmcwVo=
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

If we enter with the MMU on, there is no need for explicit cache
invalidation for stores to memory, as they will be coherent with the
caches.

Let's take advantage of this, and create the ID map with the MMU still
enabled if that is how we entered, and avoid any cache invalidation
calls in that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3e654e43fa115947..a7c84cde67c5c652 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -89,9 +89,9 @@
 SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
+	bl	create_idmap
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
-	bl	create_idmap
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -378,12 +378,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * accesses (MMU disabled), invalidate those tables again to
 	 * remove any speculatively loaded cache lines.
 	 */
+	cbnz	x19, 0f				// skip cache invalidation if MMU is on
 	dmb	sy
 
 	adrp	x0, init_idmap_pg_dir
 	adrp	x1, init_idmap_pg_end
 	bl	dcache_inval_poc
-	ret	x28
+0:	ret	x28
 SYM_FUNC_END(create_idmap)
 
 SYM_FUNC_START_LOCAL(create_kernel_mapping)
-- 
2.35.1

