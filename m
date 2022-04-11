Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6EE4FB851
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344689AbiDKJyD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344892AbiDKJwL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C12141322
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6F9ECE16CA
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A23C385AD;
        Mon, 11 Apr 2022 09:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670585;
        bh=XxI2AF5xD7GY4EBoXrk7Kfh7spE/Yd2cWMa8RrYU8ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMfDo/w27ac+Zmx7u5TbY0enbL1V8QgtgQu+POfQSNfvCHJc8OVsdhHz0DzwwIigg
         hSRAGiHKg12uKIyyoaPgjJGnnrEjTcfcEkhrq33KmexE08/m5AGIb8F04gP+ne4MjX
         kWt3zJKKrJuFdjKs9Eg2UjKEGhixu6YjCX/sYokHJ4XCcWtT1XnyHCmdiq8aBiCEE9
         +sDaejeZR3KGrYdFe//bZjHoWLQtGJx1jNBsP7MPuRatFsUTFlnnvfAy3TGxU9O2xQ
         vdsUGlwIq2HwDH+krwa3r++rjznpOQAaoBx35E6FsQEPXg5l67lxBEw4d5XXJchTUu
         J+drsu1wRy3lw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 26/30] arm64: head: avoid cache invalidation when entering with the MMU on
Date:   Mon, 11 Apr 2022 11:48:20 +0200
Message-Id: <20220411094824.4176877-27-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; h=from:subject; bh=XxI2AF5xD7GY4EBoXrk7Kfh7spE/Yd2cWMa8RrYU8ig=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lgbxCxfVzMmOVUpp7oJCq0arLzzk6ZpS/U7ovI vsF/ammJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5YAAKCRDDTyI5ktmPJMdhC/ 9scjqLQCdqy+vMsxBUhfgC/i7tIgDvfjYGcXusyIZIdzZAuTAsf0tbxBpZ+gXtq9jGISpEDXzp18n2 duSpaEYNBlRjxHwtk4oFpgC9Hmgs+hjy7w2j4N/uuT+XCFJH4zwNBb7x+mhPzUBOzZ+hPPrYut6+df O+337jwEvIS4SjnMvtFcZmUdZV1vTyykvpiRESyWjduFibIkfKMdCvyv5+8Xs9ScZAb2ChtsMNhJ4w 3N8vwSWSf4yekXBAKyIe29StocbdT2hy5AEVwHIZCJ/l3aeaj7yr1ah7nn1PRmegaNSSunbroQgVFX AtdBy+BvWUNjaUupfprEdoPPS3HMUTg9No8qYiF1e2aGEeViBs5NCY02ibhXyL0A49KXnasSJNJF4M g+1bpoDIY7HxlC9TthsgBcQJYS+8nfNdBkAa7OPrUUEsUk0Om5XyOYpGrGF43QQgOCqvh/Tg1SzYNj 6yEHv9uBgVvVN7NMr53s2bRmDHl9L3vRu+lLopHnCxLa0=
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

If we enter with the MMU on, there is no need for explicit cache
invalidation for stores to memory, as they will be coherent with the
caches.

Let's take advantage of this, and create the ID map with the MMU still
enabled if that is how we entered, and avoid any cache invalidation
calls in that case.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 1ff474701e99..4a05f4480207 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -92,9 +92,9 @@
 SYM_CODE_START(primary_entry)
 	bl	record_mmu_state
 	bl	preserve_boot_args
+	bl	create_idmap
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
-	bl	create_idmap
 
 	/*
 	 * The following calls CPU setup code, see arch/arm64/mm/proc.S for
@@ -127,11 +127,13 @@ SYM_CODE_START_LOCAL(preserve_boot_args)
 	stp	x21, x1, [x0]			// x0 .. x3 at kernel entry
 	stp	x2, x3, [x0, #16]
 
+	cbnz	x22, 0f				// skip cache invalidation if MMU is on
 	dmb	sy				// needed before dc ivac with
 						// MMU off
 
 	add	x1, x0, #0x20			// 4 x 8 bytes
 	b	dcache_inval_poc		// tail call
+0:	ret
 SYM_CODE_END(preserve_boot_args)
 
 SYM_FUNC_START_LOCAL(clear_page_tables)
@@ -366,12 +368,13 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	 * accesses (MMU disabled), invalidate those tables again to
 	 * remove any speculatively loaded cache lines.
 	 */
+	cbnz	x22, 0f				// skip cache invalidation if MMU is on
 	dmb	sy
 
 	adrp	x0, init_idmap_pg_dir
 	adrp	x1, init_idmap_pg_end
 	bl	dcache_inval_poc
-	ret	x28
+0:	ret	x28
 SYM_FUNC_END(create_idmap)
 
 SYM_FUNC_START_LOCAL(create_kernel_mapping)
-- 
2.30.2

