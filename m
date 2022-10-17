Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA1C601487
	for <lists+linux-efi@lfdr.de>; Mon, 17 Oct 2022 19:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiJQRR3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Oct 2022 13:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJQRR2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Oct 2022 13:17:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB96E2D5
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 10:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00018B816B3
        for <linux-efi@vger.kernel.org>; Mon, 17 Oct 2022 17:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A1CC433D6;
        Mon, 17 Oct 2022 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666027044;
        bh=3EA59Qwvhu2UAbj/TE7AFwnJSijZZfQad+VrEt1zgnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0rH2sxKrpKwpWUfF1BM0V2kbIzdxLMt+xHMHo3/4E7mogNzBJ1mWQq0eMh3bAbRF
         gXuF66CXBalnXQzJM5fx9bY4QC+6BGtEVSjr0RxWSvu7R5Sio25eeJMm6UYWS8qw4T
         +dd8Vl5U9h+nGmk+PbFZGNygpjxRBeIfIwo44QLCMDxasQicYxweZgVgMWaEPasOFm
         qBpr1uAw3NSTFoTt7l0SJX69f0kIZ3eJTmoOZtHJ4p1+8G4ddXoCrS2PlNWRa9whMS
         MtT3mQDKeHg1JjM+OaqaGtrJVSNJubGI6DCsrCFdZMvW0ZZrtawj7kifvQCO8WoiUt
         l99SVeOujF+yw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>,
        Lennart Poettering <lennart@poettering.net>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 02/21] arm64: efi: Avoid dcache_clean_poc() altogether in efi_enter_kernel()
Date:   Mon, 17 Oct 2022 19:16:41 +0200
Message-Id: <20221017171700.3736890-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171700.3736890-1-ardb@kernel.org>
References: <20221017171700.3736890-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=ardb@kernel.org; h=from:subject; bh=3EA59Qwvhu2UAbj/TE7AFwnJSijZZfQad+VrEt1zgnE=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjTY3rP+VTVP0N2eQViHHWmRKmoXfdsGCBa94juNjG e9rLZ6OJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY02N6wAKCRDDTyI5ktmPJAbMC/ 4qEWPUP36jZo3Y+P2kUX/csiTcXeDQvxseVPV+SUixmY+0VJGyNvMVvK9Z2DAB/dT/zMAuwguCGtDg Inij69dZewOZ+gqXM2FQ+/qNVz1tY14tSh0NE2TApEA16e3Bzq3QohXZeI6L81qn+nNOg9j2cza9wg qOFon7hWoaY53FCFgjT84/hJzJrvM39Vvx1/zjQtXqDdboFwrRaCiBvChChF+PDHdTcnx7wpMUu9vo RN7gCBOCXv0sQCubwXh9J/tCf3ovXG8/SRPpnaGNo3T4ATXcqY51VgEtiPfi3tEYdRCW6WDMpxeGSM MMuBA6B36BW0ClGIfVd3dC4SZ1R+GNJgcYVSaDkBRbmAuC4SBTZSQvaekXpBQ8UVJFPe++MwanyBvm n+ME/SSQ2rfD/UsWrbTqifUgPN83r1vD2OoZBQQH+XD536Cw/A+5Pj3++4kNNbxiJRvB1FCdqF7dl+ maiGwoo6XKhQlZ4QavgjgrX1bvYx22+QgeWFcZmeHePAE=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To allow efi_enter_kernel() to be shared with the EFI zboot decompressor
build, drop another reference to dcache_clean_poc() and replace it with
a single DC CVAC instruction. To ensure that it covers the remainder of
efi_enter_kernel() as intended, reorganize the code a bit so it fits in
a 32-byte cacheline, and align it to 32 bytes. (Even though the
architecture defines 16 as the minimum D-cache line size, even the
chosen value of 32 is highly unlikely to ever be encountered on real
hardware, and this works with any line size >= 32)

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/efi-entry.S | 57 ++++++++++----------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 1c1be004a271..8bce13356e29 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -21,40 +21,41 @@ SYM_CODE_START(efi_enter_kernel)
 	 */
 	ldr	w2, =primary_entry_offset
 	add	x19, x0, x2		// relocated Image entrypoint
-	mov	x20, x1			// DTB address
+
+	mov	x0, x1			// DTB address
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
 
 	/*
 	 * Clean the remainder of this routine to the PoC
 	 * so that we can safely disable the MMU and caches.
 	 */
-	adr	x0, 0f
-	adr	x1, 3f
-	bl	dcache_clean_poc
-0:
+	adr	x4, 1f
+	dc	civac, x4
+	dsb	sy
+
 	/* Turn off Dcache and MMU */
-	mrs	x0, CurrentEL
-	cmp	x0, #CurrentEL_EL2
-	b.ne	1f
-	mrs	x0, sctlr_el2
-	bic	x0, x0, #1 << 0	// clear SCTLR.M
-	bic	x0, x0, #1 << 2	// clear SCTLR.C
-	pre_disable_mmu_workaround
-	msr	sctlr_el2, x0
-	isb
+	mrs	x4, CurrentEL
+	cmp	x4, #CurrentEL_EL2
+	mrs	x4, sctlr_el1
+	b.ne	0f
+	mrs	x4, sctlr_el2
+0:	bic	x4, x4, #SCTLR_ELx_M
+	bic	x4, x4, #SCTLR_ELx_C
+	b.eq	1f
 	b	2f
-1:
-	mrs	x0, sctlr_el1
-	bic	x0, x0, #1 << 0	// clear SCTLR.M
-	bic	x0, x0, #1 << 2	// clear SCTLR.C
-	pre_disable_mmu_workaround
-	msr	sctlr_el1, x0
+
+	.balign	32
+1:	pre_disable_mmu_workaround
+	msr	sctlr_el2, x4
 	isb
-2:
-	/* Jump to kernel entry point */
-	mov	x0, x20
-	mov	x1, xzr
-	mov	x2, xzr
-	mov	x3, xzr
-	br	x19
-3:
+	br	x19		// jump to kernel entrypoint
+
+2:	pre_disable_mmu_workaround
+	msr	sctlr_el1, x4
+	isb
+	br	x19		// jump to kernel entrypoint
+
+	.org	1b + 32
 SYM_CODE_END(efi_enter_kernel)
-- 
2.35.1

