Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60476D2E9
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 17:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjHBPvS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjHBPuo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 11:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA4F2D5F;
        Wed,  2 Aug 2023 08:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B865E619CB;
        Wed,  2 Aug 2023 15:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443C3C433C8;
        Wed,  2 Aug 2023 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690991393;
        bh=cXimVZzbiEeKDzOb+3rdwKc74jiS3qDnOSBCjuTw9HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6yNvnZMK2O11mTQy/73zdpQa4C+85lGVxLY6RXd99+J2Bf53xMMt1d7VE3uyxUMx
         ttcM21gQs/k432aXy4HZ55nBlonEU4VAgpRk4Fmu7oELCvnUbV+unnNoMvDiwhVTmI
         7IMnJMTTBCm2SntOXxhzNugDbEt4W4b8P9eBdEOQC9eR7qO0Ec7hEFMNaIO/Z80g27
         v/kX9xVwbUEYFDc67EKQu/Dg2hJOORnXxIYk0kfKPWB+hkJ0jFkjiQbAqe+DIzHdXI
         8LCyL1FP4g3a541Oqe4mhgdmk77IVMOhB0qCB+QyTsDKvf2zVZ04CBByhaYQiMQ/Fz
         5kwukpVodT0MA==
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
Subject: [PATCH v8 14/23] x86/decompressor: Pass pgtable address to trampoline directly
Date:   Wed,  2 Aug 2023 17:48:22 +0200
Message-Id: <20230802154831.2147855-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802154831.2147855-1-ardb@kernel.org>
References: <20230802154831.2147855-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3817; i=ardb@kernel.org; h=from:subject; bh=cXimVZzbiEeKDzOb+3rdwKc74jiS3qDnOSBCjuTw9HY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVU1eFjzKxMYqdZFm1f+k4i+fIkiy1s0Z3tXw5fjzgzx ZTtxeY5HaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAinusYGVY0r9/N//z7j8/K t+w3KKtLax5Xj+hbEtjhZ3niX6aNnRAjw9V/19PZr9c9KjIUu/Z4t6zD8vf+a7/6SVz3VFu3zFi skgEA
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

The only remaining use of the trampoline address by the trampoline
itself is deriving the page table address from it, and this involves
adding an offset of 0x0. So simplify this, and pass the new CR3 value
directly.

This makes the fact that the page table happens to be at the start of
the trampoline allocation an implementation detail of the caller.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S    | 8 ++++----
 arch/x86/boot/compressed/pgtable.h    | 2 --
 arch/x86/boot/compressed/pgtable_64.c | 9 ++++-----
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 8730b1d58e2b0825..afdaf8cb8bb98694 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -521,8 +521,9 @@ SYM_FUNC_END(.Lrelocated)
  * running in 64-bit mode.
  *
  * Return address is at the top of the stack (might be above 4G).
- * The first argument (EDI) contains the 32-bit addressable base of the
- * trampoline memory.
+ * The first argument (EDI) contains the address of the temporary PGD level
+ * page table in 32-bit addressable memory which will be programmed into
+ * register CR3.
  */
 	.section ".rodata", "a", @progbits
 SYM_CODE_START(trampoline_32bit_src)
@@ -575,8 +576,7 @@ SYM_CODE_START(trampoline_32bit_src)
 	movl	%eax, %cr0
 
 	/* Point CR3 to the trampoline's new top level page table */
-	leal	TRAMPOLINE_32BIT_PGTABLE_OFFSET(%edi), %eax
-	movl	%eax, %cr3
+	movl	%edi, %cr3
 
 	/* Set EFER.LME=1 as a precaution in case hypervsior pulls the rug */
 	movl	$MSR_EFER, %ecx
diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
index c6b0903aded05a07..6d595abe06b34d63 100644
--- a/arch/x86/boot/compressed/pgtable.h
+++ b/arch/x86/boot/compressed/pgtable.h
@@ -3,8 +3,6 @@
 
 #define TRAMPOLINE_32BIT_SIZE		(2 * PAGE_SIZE)
 
-#define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
-
 #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
 #define TRAMPOLINE_32BIT_CODE_SIZE	0xA0
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 4213473ae54883c8..eab4e6b568ae05c4 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -103,7 +103,7 @@ static unsigned long find_trampoline_placement(void)
 
 asmlinkage void configure_5level_paging(struct boot_params *bp)
 {
-	void (*toggle_la57)(void *trampoline);
+	void (*toggle_la57)(void *cr3);
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
@@ -174,7 +174,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		 * For 4- to 5-level paging transition, set up current CR3 as
 		 * the first and the only entry in a new top-level page table.
 		 */
-		trampoline_32bit[TRAMPOLINE_32BIT_PGTABLE_OFFSET] = __native_read_cr3() | _PAGE_TABLE_NOENC;
+		*trampoline_32bit = __native_read_cr3() | _PAGE_TABLE_NOENC;
 	} else {
 		unsigned long src;
 
@@ -187,8 +187,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp)
 		 * may be above 4G.
 		 */
 		src = *(unsigned long *)__native_read_cr3() & PAGE_MASK;
-		memcpy(trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long),
-		       (void *)src, PAGE_SIZE);
+		memcpy(trampoline_32bit, (void *)src, PAGE_SIZE);
 	}
 
 	toggle_la57(trampoline_32bit);
@@ -198,7 +197,7 @@ void cleanup_trampoline(void *pgtable)
 {
 	void *trampoline_pgtable;
 
-	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
+	trampoline_pgtable = trampoline_32bit;
 
 	/*
 	 * Move the top level page table out of trampoline memory,
-- 
2.39.2

