Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F943772AC5
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjHGQ2s (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjHGQ2U (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666110DE;
        Mon,  7 Aug 2023 09:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6786961F13;
        Mon,  7 Aug 2023 16:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50503C433C9;
        Mon,  7 Aug 2023 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425690;
        bh=cXimVZzbiEeKDzOb+3rdwKc74jiS3qDnOSBCjuTw9HY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tjfj5rfhkZr9qGXvWOaC8k3kP17zcR22fiPhgRMFuqR0KkqrIBwc7b7Q8QzP/2RPc
         hwBOf70FqpI12eajYzZiaArwKPcdWR7oPkMRdqYXewHfHSyHp6J2eBt16hgHvKXjAT
         8CNBDVmelVUYELOhaKquOpe6vDzEX8wkFB/EMcgjN0gb1ehRDDpbpBKWMWvSzmYeJJ
         vUhskXPWnrOn4PSTFYbpTlXJGxoU1MSd2ZN5fDepPbXeeQp/aV/t9IerWRTdoeWxjZ
         9+4418ljqxpZQ6CSiNTOjx3I0EgGiB8eYIDNE909Q9OBBgp/V1zyegShCPjfsJ/KrH
         k91eRvYxUT36w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 14/23] x86/decompressor: Pass pgtable address to trampoline directly
Date:   Mon,  7 Aug 2023 18:27:11 +0200
Message-Id: <20230807162720.545787-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3817; i=ardb@kernel.org; h=from:subject; bh=cXimVZzbiEeKDzOb+3rdwKc74jiS3qDnOSBCjuTw9HY=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidMwxZlYmsdMsi7YvfSeRfHmSxRa26M72L4evR5yZY sr2YvOcjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjARkT0M/71+TupvaQ4RPBxp enJbf1IOR7CCgANLmMK84E3BKec5Cxn+R83Lk7m23WZJucJJ4+07IsxSPa4w3JzSEe6S4ZT5JPE oNwA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

