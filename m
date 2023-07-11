Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B388974EA19
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGKJR2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjGKJQj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055231712;
        Tue, 11 Jul 2023 02:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A7586141D;
        Tue, 11 Jul 2023 09:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21676C433CB;
        Tue, 11 Jul 2023 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066959;
        bh=dlNFO5agdb11fPHYZEyzw/6MaYXdtrpeE6fpUrVKxxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDdmCbx719r8GNBq2luPsGW9hZsk/+thLtK3qwhQGFJHe2LPKM2652PpMrMoZALig
         eGW8OcRafU+BQsXdfxOCgFMk3jL6YXGTk2pCdTLyNIVRgqGR3xtZaZFS5Xw4V/iO46
         UdpZB83a+caaR3pXWToSOeIj5aepQMbs7uk2GwzlS6GQyMFw5M2Ex+RzcAuZRZPkiq
         Lb4osFNi/tvA1hNlsrvv9xrNSWM7qtLUvTtikvOhVcxtiozPKkwr0r8wUau98P0cJ6
         X6e/Ll9w38oXejnBU+NnxhOIqytJz8af56G5luh3B83btalu9PFJST/wsRmyNSv6M/
         VYc7z0lRd0T7w==
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
Subject: [PATCH v6 13/21] x86/decompressor: Merge trampoline cleanup with switching code
Date:   Tue, 11 Jul 2023 11:14:45 +0200
Message-Id: <20230711091453.2543622-14-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4143; i=ardb@kernel.org; h=from:subject; bh=dlNFO5agdb11fPHYZEyzw/6MaYXdtrpeE6fpUrVKxxI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbMsMCZajGX2O8TsZTj48l8bfxB8yS/m7dGi5Yuaq+ GP3Ovs7SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwEQaNjMy9F063PXxb96T3zvv fXwuufHGLLvTpsyP2bPdVu/8Pl8oyZ+RYYuJ//TG+Xemb5owb/+lw8lN29L7Bd4wxtSmfbujPvu yHzMA
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
index 577173be8ec805cd..408c7824b647ff51 100644
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

