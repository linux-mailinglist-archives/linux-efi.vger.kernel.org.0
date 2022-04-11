Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0684FB83D
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344894AbiDKJwM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 05:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344738AbiDKJwA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 05:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4233B419AD
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 02:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73AA161164
        for <linux-efi@vger.kernel.org>; Mon, 11 Apr 2022 09:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61F4C385A6;
        Mon, 11 Apr 2022 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649670553;
        bh=9AVu6mHMPoK5oK6gxu8iTn6r/yGLVCYbNn1BWuZoPiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ciI3qJjxsec5kGKKsw1xjchaR3pY2jznjRb0fUmRRRVJLvHEViho+WNqu7pb+lCaA
         3J/pJAZW9lwBMVQ4xC986ITcDWc4R4owMezkl95lgSv2Ps5DL5xmGgyAIByGKznpBr
         K+sOw3AyEKOPSkdczlUAVGcTb1mLUuRwwboRHtKYzpn1XkVp3ahv4jnJ+mq+tCUPdb
         WJYzWAZdeOrm8VaLEnd/zlizdLFVz7M7IW4oBouP9kdfBOuaFQV00DPOSKv1pCAHlc
         E1RzM425RmqknXPw6/dxu5nnZy1NfNdrym0+4oPu5hYTLt3+4zrKJhR2jHnpFbt28G
         OXjSOlNFwcQpw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 13/30] arm64: head: use relative references to the RELA and RELR tables
Date:   Mon, 11 Apr 2022 11:48:07 +0200
Message-Id: <20220411094824.4176877-14-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2627; h=from:subject; bh=9AVu6mHMPoK5oK6gxu8iTn6r/yGLVCYbNn1BWuZoPiE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBiU/lKS9UO+vDmp3VZscy4lffXl6hh9vn47/4m4jxm q5vW/eCJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYlP5SgAKCRDDTyI5ktmPJIVnDA CimfPlPaFYAo0iN/LnxYQG3BmsRvLvSt+6H64/MD/ykF0PW0CNiJLyg21qrZrsR/pDUS4syQDslo9+ 2AirEU10zMRc3A2SokvJB1tmiC6Zk0qK5IWTndiNHZ4J3WwMEzOmv6iexGjbYqkoO/Lg7pwU1VuUrZ 4oNrCWHNzXuAbeEh6UAGCZpctR4TRTEEH7YDsWoCiHzlREa9JQALq7oBFMnEeyDwyW01PPzKBsp2xj ymn0357ZnrArJNJ1tHgklE6CLlqxD7xfNezf/dK3TRiaZptv04i3y+3Id0Sm43PklmsuoQd4nUYRbZ qxmRWewzl+tI3RGekm3JXiBFA1IlGVk3bGzGDDmkiTYz3eNdPeAph4edjM/5kRjIm+RkOt4JMpveWZ dXBB+xtVz4/l74osHnxBfPE70Tfi0q9jRHxlEAYEvY8OkYIXF5TJ3dUn4zv3SbB9tO0AeiydDSQYg9 i0TUtic+ZMIM3fUKJgVi9HBXyyiY6NFpusIHoNI5dKCgs=
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

Formerly, we had to access the RELA and RELR tables via the kernel
mapping that was being relocated, and so deriving the start and end
addresses using ADRP/ADD references was not possible, as the relocation
code runs from the ID map.

Now that we map the entire kernel image via the ID map, we can simplify
this, and just load the entries via the ID map as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S        | 13 ++++---------
 arch/arm64/kernel/vmlinux.lds.S | 12 ++++--------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4ef12bcdfe6a..2c491cac4871 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -755,13 +755,10 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 * Iterate over each entry in the relocation table, and apply the
 	 * relocations in place.
 	 */
-	ldr	w9, =__rela_offset		// offset to reloc table
-	ldr	w10, =__rela_size		// size of reloc table
-
+	adr_l	x9, __rela_start
+	adr_l	x10, __rela_end
 	mov_q	x11, KIMAGE_VADDR		// default virtual offset
 	add	x11, x11, x23			// actual virtual offset
-	add	x9, x9, x11			// __va(.rela)
-	add	x10, x9, x10			// __va(.rela) + sizeof(.rela)
 
 0:	cmp	x9, x10
 	b.hs	1f
@@ -811,10 +808,8 @@ SYM_FUNC_START_LOCAL(__relocate_kernel)
 	 * __relocate_kernel is called twice with non-zero displacements (i.e.
 	 * if there is both a physical misalignment and a KASLR displacement).
 	 */
-	ldr	w9, =__relr_offset		// offset to reloc table
-	ldr	w10, =__relr_size		// size of reloc table
-	add	x9, x9, x11			// __va(.relr)
-	add	x10, x9, x10			// __va(.relr) + sizeof(.relr)
+	adr_l	x9, __relr_start
+	adr_l	x10, __relr_end
 
 	sub	x15, x23, x24			// delta from previous offset
 	cbz	x15, 7f				// nothing to do if unchanged
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7030b5a57d23..21ca72e7ad22 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -253,21 +253,17 @@ SECTIONS
 	HYPERVISOR_RELOC_SECTION
 
 	.rela.dyn : ALIGN(8) {
+		__rela_start = .;
 		*(.rela .rela*)
+		__rela_end = .;
 	}
 
-	__rela_offset	= ABSOLUTE(ADDR(.rela.dyn) - KIMAGE_VADDR);
-	__rela_size	= SIZEOF(.rela.dyn);
-
-#ifdef CONFIG_RELR
 	.relr.dyn : ALIGN(8) {
+		__relr_start = .;
 		*(.relr.dyn)
+		__relr_end = .;
 	}
 
-	__relr_offset	= ABSOLUTE(ADDR(.relr.dyn) - KIMAGE_VADDR);
-	__relr_size	= SIZEOF(.relr.dyn);
-#endif
-
 	. = ALIGN(SEGMENT_ALIGN);
 	__initdata_end = .;
 	__init_end = .;
-- 
2.30.2

