Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750DB76D2E2
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbjHBPu7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjHBPue (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004A4358B;
        Wed,  2 Aug 2023 08:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C64861A33;
        Wed,  2 Aug 2023 15:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F0FC433CB;
        Wed,  2 Aug 2023 15:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991397;
        bh=sWc7DHFUuLP6QmqVwRrlrkEzojfIVsiaqVuAFFfb3sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o7VhZMvpXJVr0lWkD7rVFabDLKjK+1hiqk9of5OUQDMJj3ZNqf5wn1YcF7XJ8mghA
         8g3wqjTq+Cu3Z3aI+EUAwPEHpRGLh5xSMVBX6FTMGmZUT42LBftH8QbrcqtnxBS676
         1YujWLn9kyftTW5v+AOjgIsdS2nx34b5kKpqEnPmOro7fhpZNcDOlhmFxEOrNZWuPX
         ggRno/k78dWtqzgnkQWP5GRGfl0/O4OGYrsZ2bnfsN6tfD34RlpNCXnfhoFIHGpNM6
         Dnv1Fhd6S5Csh4xSy+zfpwTJsdVA4QTnu/2eKyLTaMxbcrH/Fw9Zxk6Bblx1yag7S9
         HPTDwFWtUwuDw==
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
Subject: [PATCH v8 15/23] x86/decompressor: Merge trampoline cleanup with switching code
Date:   Wed,  2 Aug 2023 17:48:23 +0200
Message-Id: <20230802154831.2147855-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924; i=ardb@kernel.org; h=from:subject; bh=sWc7DHFUuLP6QmqVwRrlrkEzojfIVsiaqVuAFFfb3sc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1RGXx5JLztRVf1lavKLkpM79w9Xzz5adtHrDtKLbp TlswaIdHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiUzQYGT4ckTtl8fRtbh// vv8TPEtbeq58unxvOY/L/EUspWv4HWYy/E88kFNqPln9pYLhW25B9y8SFlO2lxUXFqtIS9gs/6Z xhRsA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/boot/compressed/head_64.S    | 14 ++++----------
 arch/x86/boot/compressed/pgtable_64.c | 18 ++++--------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index afdaf8cb8bb98694..fb0e562c26f64c9c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -430,20 +430,14 @@ SYM_CODE_START(startup_64)
 	 * a trampoline in 32-bit addressable memory if the current number does
 	 * not match the desired number.
 	 *
-	 * Pass the boot_params pointer as the first argument.
+	 * Pass the boot_params pointer as the first argument. The second
+	 * argument is the relocated address of the page table to use instead
+	 * of the page table in trampoline memory (if required).
 	 */
 	movq	%r15, %rdi
+	leaq	rva(top_pgtable)(%rbx), %rsi
 	call	configure_5level_paging
 
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
index eab4e6b568ae05c4..7939eb6e6ce9bb01 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -101,7 +101,7 @@ static unsigned long find_trampoline_placement(void)
 	return bios_start - TRAMPOLINE_32BIT_SIZE;
 }
 
-asmlinkage void configure_5level_paging(struct boot_params *bp)
+asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 {
 	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
@@ -191,22 +191,12 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 	}
 
 	toggle_la57(trampoline_32bit);
-}
-
-void cleanup_trampoline(void *pgtable)
-{
-	void *trampoline_pgtable;
-
-	trampoline_pgtable = trampoline_32bit;
 
 	/*
-	 * Move the top level page table out of trampoline memory,
-	 * if it's there.
+	 * Move the top level page table out of trampoline memory.
 	 */
-	if ((void *)__native_read_cr3() == trampoline_pgtable) {
-		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
-		native_write_cr3((unsigned long)pgtable);
-	}
+	memcpy(pgtable, trampoline_32bit, PAGE_SIZE);
+	native_write_cr3((unsigned long)pgtable);
 
 	/* Restore trampoline memory */
 	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
-- 
2.39.2

