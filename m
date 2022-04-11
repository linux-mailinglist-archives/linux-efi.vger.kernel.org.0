Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472784FB855
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbiDKJyC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344794AbiDKJwN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4BA4132E
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD8C1B80F52
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF55C385A5;
        Mon, 11 Apr 2022 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670587;
        bh=JHj7u1pCVmjQgf7UUyl1sriCy1PcVUp8548Yf0Nq4Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s337dd9Scc5aWIF/9ibEo/1RYCYU9/fL2SMFnpUmDPQiv3/FQlNiz722BvwnoL/D+
         z7NiL/2LzovJF6VikgHx6BdXk+0mgKoY2CZTS4Blm8JBk8KR0H8SfI9PQ/fYbdsM4L
         lFeQHTZKFJWF73P0OeN+FALQ2iW6Ga6uZl6yHWIwLXCR/jzzjn2SEuYgQ9dAZsunJd
         VJGPbD0Qh85rZFuzUWeUqXVxMocYA1LnIe9PnRn1Ys9mg1+KudeV7ZabmFWuSfB8KJ
         6n1Z1Roh2v5wKD5Y84Ro24MSzLgWpjgcV0QoKj7vRwvX50U/JzvsYYsPEBzKWB6Fob
         x+mvHJBh7ZRlg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 27/30] arm64: head: clean the ID map page to the PoC
Date:   Mon, 11 Apr 2022 11:48:21 +0200
Message-Id: <20220411094824.4176877-28-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; h=from:subject; bh=JHj7u1pCVmjQgf7UUyl1sriCy1PcVUp8548Yf0Nq4Vc=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lixBBUpdndZHZMtjN5PEMOPQCzaF7c29q/nJJN aRtDQ4CJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5YgAKCRDDTyI5ktmPJCZsDA ClIqRzc7T3wbRvV2q/kYv0k+jWoZ7xbk4p3aOV6V1sedjJlyo/CgagzF/Foac8/wPU719mrHUH9QiC 5RMf0znu3y7eGb0ZJv4g1/nNwiPHumAm2D+lHC7hFIEkjqSG0F1ETYDaNZgsRiFEfLWOuS5V7DLtBz QKa2Vomr9Mn+K4DSJmnb1l7qv4dXrkXrXrodaIr7Jjo7erFNCl+4J9CTr8ccU56DGncENird+G2gm/ OfePCPGyonKRn3JMTeoQlHGcNdBiVROsGVmDy5rQse8Z+hNNJFHTDibhIz4rmZ8/obKtHkPvgUXPy/ d/KQLwwOot3dn+fcr0VGTdP1hZo6zWRDzWl1VHgZqcA0heGC7n0NK1URpzDXHdv3XAPwmUEmF9hlF2 LpCn8SrS7TIIjJTTI94naIf/bqY1VPKJEeMb9FSnhAE6YaFVVErWeLppLM64CpdQRbq9YeQcZFitbx zs+kHOgHCXSzdoxKNLDXOmpGg2uQccxIXH68L8KsAtunw=
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
 arch/arm64/kernel/head.S | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4a05f4480207..0987d59ae333 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -75,7 +75,7 @@
 
 	__EFI_PE_HEADER
 
-	__INIT
+	.section ".idmap.text","awx"
 
 	/*
 	 * The following callee saved general purpose registers are used on the
@@ -93,6 +93,18 @@ SYM_CODE_START(primary_entry)
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
+	bl	dcache_clean_poc
+	ic	ialluis
+0:
 	bl	init_kernel_el			// w0=cpu_boot_mode
 	mov	x20, x0
 
@@ -106,6 +118,7 @@ SYM_CODE_START(primary_entry)
 	b	__primary_switch
 SYM_CODE_END(primary_entry)
 
+	__INIT
 SYM_CODE_START_LOCAL(record_mmu_state)
 	mrs	x22, CurrentEL
 	cmp	x22, #CurrentEL_EL2
-- 
2.30.2

