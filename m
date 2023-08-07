Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71384772ACA
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHGQ2v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjHGQ22 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A8173D;
        Mon,  7 Aug 2023 09:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C1661F1A;
        Mon,  7 Aug 2023 16:28:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483E1C433C7;
        Mon,  7 Aug 2023 16:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425693;
        bh=sWc7DHFUuLP6QmqVwRrlrkEzojfIVsiaqVuAFFfb3sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQjDxWVw0/rbXcPjW+8tukazzMMDjTVwzBXtub4M8wBI1vPjMy1UJOPxGtLxGNSDY
         FXKUX1d+kyET4PwNEE3caU11xor0tlK3qwU2Natn83DaJ0ivKJBDovcKmiQrgs91Jp
         WHslVE+sNvV+Rdl96xKKfmvu/8RYqVSDd3BAYrWpn2ZuGq3KkZ9F9tiaYzVYPEs9Iy
         ODQW5Rkv0DnFtA2HkJfvhFcZeMlvn1z1aDtxMYSLWutvrrGh3KpjEDclmGAamWp3bA
         wWnFgy3rN1DhMZwwKGfO+hkdbKYxxx64JpBKTSo9o3LlglP1i4dTtX5rEf7z/a5Gdl
         oUINUUmM22f3g==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v9 15/23] x86/decompressor: Merge trampoline cleanup with switching code
Date:   Mon,  7 Aug 2023 18:27:12 +0200
Message-Id: <20230807162720.545787-16-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2924; i=ardb@kernel.org; h=from:subject; bh=sWc7DHFUuLP6QmqVwRrlrkEzojfIVsiaqVuAFFfb3sc=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidKzLY8klZ+qqvywtXlFyUuf+4er5Z8tOWr1hWtHt0 hy2YNGOjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRj6WMDG/DQ47eFVmgu/WX D3vtpLnRbv5RBvvuC/ouVj6y6s/Hl8UM/wMz+V+FOz86w93cdKpi05cmf06m0oPySleibFeFijd OYQYA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

