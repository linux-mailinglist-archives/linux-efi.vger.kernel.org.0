Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689F976687E
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjG1JNh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbjG1JMv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DE53C1F;
        Fri, 28 Jul 2023 02:11:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55ADA62088;
        Fri, 28 Jul 2023 09:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04494C433CA;
        Fri, 28 Jul 2023 09:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535501;
        bh=RyCASInDFX0BjQq753LAcm+uf0XadKvOwO74Z3uQu1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDPKqf9tA4kK7YqfOEkF8A+1EnTCYOJiqVXGQWKC/PU58CtpPjuZfrM1k7A4jAvDr
         Iy/wdlijulaBlO/7MwWe51t02H70L2lR1hLTIKG6RPBYoTtTltXt90tbpmfIKdu8Fp
         AAxais+23HtgDrXlwdAPIq/DEh3fEyXpDDFFWmeLb8sQfojmar7YjZaPSxP1C7NPLW
         ElthDNmLfXkK93+1MN01+WMZmqyft+1zAlkcTaA7zO5UezMo9jkkXsqZIp4slajbeu
         Thbq5RYHR8XIe6enMNVaTXNmco7/qbpqs7mVyBUqt3BFft+Hx0k+XgXncnhRr5rSlX
         Fx71/sivGAyqg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH v7 14/22] x86/decompressor: Merge trampoline cleanup with switching code
Date:   Fri, 28 Jul 2023 11:09:08 +0200
Message-Id: <20230728090916.1538550-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=ardb@kernel.org; h=from:subject; bh=RyCASInDFX0BjQq753LAcm+uf0XadKvOwO74Z3uQu1s=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw66ZDvs7vb1cv2Seu0SHxW69t8fvGzGdL/rA+VD3to dQyuSCvo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzkwEdGhrXH2J4Y1yTf637y xtFphkCj09VdMcffvbL+vCTup/9DlzOMDD1tClc/LOp3fs/WYfVE++ryO5oTZC9nPPnIodv9r+/ edyYA
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

Now that the trampoline setup code and the actual invocation of it are
all done from the C routine, the trampoline cleanup can be merged into
it as well, instead of returning to asm just to call another C function.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 13 +++------
 arch/x86/boot/compressed/pgtable_64.c | 28 ++++++++------------
 2 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 88b5e45b8ecb490b..eb33edf1e75d4b02 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -429,19 +429,14 @@ SYM_CODE_START(startup_64)
 	 * set_paging_levels() updates the number of paging levels using a
 	 * trampoline in 32-bit addressable memory if the current number does
 	 * not match the desired number.
+	 *
+	 * RSI is the relocated address of the page table to use instead of
+	 * page table in trampoline memory (if required).
 	 */
 	movq	%r15, %rdi		/* pass struct boot_params pointer */
+	leaq	rva(top_pgtable)(%rbx), %rsi
 	call	set_paging_levels
 
-	/*
-	 * cleanup_trampoline() would restore trampoline memory.
-	 *
-	 * RDI is address of the page table to use instead of page table
-	 * in trampoline memory (if required).
-	 */
-	leaq	rva(top_pgtable)(%rbx), %rdi
-	call	cleanup_trampoline
-
 	/* Zero EFLAGS */
 	pushq	$0
 	popfq
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 4016444e6788304f..4f50af23a0854f18 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -101,9 +101,10 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-asmlinkage void set_paging_levels(void *rmode)
+asmlinkage void set_paging_levels(void *rmode, void *pgtable)
 {
 	void (*toggle_la57)(void *trampoline, bool enable_5lvl);
+	void *trampoline_pgtable;
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
@@ -133,7 +134,7 @@ asmlinkage void set_paging_levels(void *rmode)
 	 * the desired one.
 	 */
 	if (l5_required == !!(native_read_cr4() & X86_CR4_LA57))
-		return;
+		goto out;
 
 	trampoline_32bit = (unsigned long *)find_trampoline_placement();
 
@@ -163,6 +164,8 @@ asmlinkage void set_paging_levels(void *rmode)
 	 * The new page table will be used by trampoline code for switching
 	 * from 4- to 5-level paging or vice versa.
 	 */
+	trampoline_pgtable = trampoline_32bit +
+			     TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
 
 	if (l5_required) {
 		/*
@@ -182,31 +185,21 @@ asmlinkage void set_paging_levels(void *rmode)
 		 * may be above 4G.
 		 */
 		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
-		       (void *)src, PAGE_SIZE);
+		memcpy(trampoline_pgtable, (void *)src, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit, l5_required);
-}
-
-void cleanup_trampoline(void *pgtable)
-{
-	void *trampoline_pgtable;
-
-	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
 
 	/*
-	 * Move the top level page table out of trampoline memory,
-	 * if it's there.
+	 * Move the top level page table out of trampoline memory.
 	 */
-	if ((void *)__native_read_cr3() == trampoline_pgtable) {
-		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
-		native_write_cr3((unsigned long)pgtable);
-	}
+	memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
+	native_write_cr3((unsigned long)pgtable);
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
 
+out:
 	/* Initialize variables for 5-level paging */
 #ifdef CONFIG_X86_5LEVEL
 	if (__read_cr4() & X86_CR4_LA57) {
@@ -215,4 +208,5 @@ void cleanup_trampoline(void *pgtable)
 		ptrs_per_p4d = 512;
 	}
 #endif
+	return;
 }
-- 
2.39.2

