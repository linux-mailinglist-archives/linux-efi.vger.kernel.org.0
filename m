Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7461F4EC89F
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348352AbiC3PoZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Mar 2022 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbiC3PoY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 30 Mar 2022 11:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EF36B50
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 08:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 234C86171D
        for <linux-efi@vger.kernel.org>; Wed, 30 Mar 2022 15:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB97C3410F;
        Wed, 30 Mar 2022 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648654958;
        bh=z2EEihueXqWQnKubnMCy/H2MNFhOqik2plKlNjQa2t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6Ls0/O0zcOVxqn5rVk1Qf5ExrFXQoiDjih9YeXvdHGqHv2M5yd0k6v0qBQx3evsx
         mFVDfdirCQJG3AQpwA6lajAcFdsddFFGv99WaamDLG+QkbkRHHn8HkStfCZVHnJDoT
         d+isLIQSEqD2usd2sleaQTLXO3QWwufmqkgKHHHPXm9WJyDIoXr/j6nqCYjvUIb7C4
         hjASIjx9wSySBFnv+vbUbMKcYt53oqt0zRrzvQifbe9GlK3mB84GDZDrpmnyokxH+j
         ZBb2nXQ4Cy0jvgOewrZZwErqv+wnHeUJmpgs6cMrU4dLDQIBYn0IsFQnw/VQRXzaV7
         MRl7hlhCtEC0A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, keescook@chromium.org,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [RFC PATCH v2 14/18] arm64: head: clean the ID map page to the PoC
Date:   Wed, 30 Mar 2022 17:42:01 +0200
Message-Id: <20220330154205.2483167-15-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330154205.2483167-1-ardb@kernel.org>
References: <20220330154205.2483167-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; h=from:subject; bh=z2EEihueXqWQnKubnMCy/H2MNFhOqik2plKlNjQa2t0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiRHpFIN68im7lXqsmgzMNBtRef/blT8WIX1vjAXlL 1E+XaeiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYkR6RQAKCRDDTyI5ktmPJKEqDA CxvCDfbTBWBJwLdNYSXLyPbRU6LTg7TvbvWnRW0XsSZa2AR15so8kB+JZgi8O9ZA1N4B/NirqtedeP H9FFrcHhY2GoWAYOWg5TRMC2+5POwnIQZX2UGJmQBuzsyHsOkUSijOxbPGBsfpvh13b5PrX3e/wXwx wAEqiSIpy86dBZQK/M44xZfSsNJzg8wXJzPfgEWkJuLjoTJ3RJOgg6gaaS2cXnfjfc2dqRnXTPIQ+4 3jpqxT0MSnBLo6i9JZIhEH7RbR1/mSGJddw6pON+M3EfVdqlmXHznyB0VTAGDFaS7DwZnmMhUK2ppG d7gfg4EIniZo8NBQUKOjbw9Gm4g8jBY3QY3qxiATXTcIMiQicRoQ1jJdE7ZyFeN8sxsIUkhElEzplb dIvGR51JV/DbIIRGm9xg4R5FY/0QmuP73f41wCL8naOedGPAU10o9HihAJWQ8Q/PU1fY/uWUMWfbSv 8SIbx04sagJDUo3auIx78obYovXt9pxGXcCkzuH0fmPG0=
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

If we enter with the MMU and caches enabled, the caller may not have
performed any cache maintenance. So clean the ID mapped page to the PoC,
and invalidate the I-cache so we can safely execute from it after
disabling the MMU and caches.

Note that this means primary_entry() itself needs to be moved into the
ID map as well, as we will return from init_kernel_el() with the MMU and
caches off.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index ec57a29f3f43..2f1dcc0c7594 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -75,7 +75,7 @@
 
 	__EFI_PE_HEADER
 
-	__INIT
+	.section ".idmap.text","awx"
 
 	/*
 	 * The following callee saved general purpose registers are used on the
@@ -91,6 +91,19 @@ SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
 	bl	create_idmap
+
+	/*
+	 * If we entered with the MMU and caches on, clean the ID mapped part
+	 * of the primary boot code to the PoC and invalidate it from the
+	 * I-cache so we can safely turn them off.
+	 */
+	cbz	x22, 0f
+	adrp	x0, __idmap_text_start
+	adr_l	x1, __idmap_text_end
+	sub	x1, x1, x0
+	bl	dcache_clean_poc
+	ic	ialluis
+0:
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
 
@@ -104,6 +117,7 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+	__INIT
 SYM_CODE_START_LOCAL(record_mmu_state)
 	mrs	x22, CurrentEL
 	cmp	x22, #CurrentEL_EL2
-- 
2.30.2

