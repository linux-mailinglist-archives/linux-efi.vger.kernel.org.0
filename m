Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F290E592FB4
	for <lists+linux-efi@lfdr.de>; Mon, 15 Aug 2022 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiHONVC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 Aug 2022 09:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242883AbiHONUi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 Aug 2022 09:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A46554
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 06:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C25760C92
        for <linux-efi@vger.kernel.org>; Mon, 15 Aug 2022 13:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7928C433C1;
        Mon, 15 Aug 2022 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660569636;
        bh=zHcDZpGro5ien4WbBB/cBXcQm1HTF+dN1mAejFmpNs0=;
        h=From:To:Cc:Subject:Date:From;
        b=m9YoqVvrzzjeaLQob8/CYdmIz0+loH/Jq0xkkR4FSpdgPy7ABVIUKbi4sdQU4c3xw
         RF89eG1WQn7bWt8lcR8c0UonTOBD5o3OtBL+OoM5Vr2y6GoIeSbz+WE8RRffGtqui3
         v3Cs1Z6sKIKRzoicqoG3eKh60NeJobDppMPB1px9jFy9KrRPp1VM+rvN/MxS3dwYrV
         oJaziaQo6WumGxG52+B7uLcbu+xET20XNxuTysq4toSrEUKa705x1NpTpZTABmI5PK
         /1m6h5qRXD1cBYPkX32Jz2qsBBuagclRWN8Px2LU26JDnrMOLikxFeBbQGuE9GyOHJ
         2XEo3kjVLKvsw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     bp@alien8.de, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] efi/x86-mixed: move unmitigated RET into .rodata
Date:   Mon, 15 Aug 2022 15:20:28 +0200
Message-Id: <20220815132028.732531-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3126; i=ardb@kernel.org; h=from:subject; bh=zHcDZpGro5ien4WbBB/cBXcQm1HTF+dN1mAejFmpNs0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBi+kgaxgmE2qbTlnwQOkX3ho1iCmccjU9qsWoLGCFH q0Y6vWiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYvpIGgAKCRDDTyI5ktmPJFz4C/ 49Lq3KNj5t/u1m3f2jDsSQgJEp6nK39dJKu58+4uLK5mbaCDSuzC3rrQ+oGOidUwHO1Fk5m4vq5MEU JWip3IoazeuAtymHNQgNS3w+68FJAE6v2ch4oe0JauZjWlHdASGvdQRuCuEBf4EsCq7cNhjwV4+11M RSMke1hVffUg0wfWpYq5ba9IGx8c2fHij+rIELCvRdeSxWWfhHYl3eNRa6ELQ6+MDuo5AGDdtAQJQF JXCnfJt1iObYr9QzY6qMg4FGT0ujYdvkGfDVr/gH4nyhrLL6tFGEndNjQlx+cU61SuCtTvtSDmtOdZ /35r0G5PhbtikKlEp7A2FVZilIwi7fjmA5FRgibzym0PTGjGOKh3je1NlUHk/wzJK8qUt6LL7d9g1F 73u2bMe+Mhwr27+fqkLA1ZIkgXg/+HUjunTWv38m03pegyEbgIp9f+DQ5MSZMnC4+l89mlsaaJzHG7 nnEoTV98qiuTg522IUmhI5ymbHZ2HUFh8HykoRWk/Dcak=
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

Move the EFI mixed mode return trampoline RET into .rodata, so it is
normally mapped without executable permissions.  And given that this
snippet of code is really the only kernel code that we ever execute via
this 1:1 mapping, let's unmap the 1:1 mapping of the kernel .text, and
only map the page that covers the return trampoline with executable
permissions.

Note that the remainder of .rodata needs to remain mapped into the 1:1
mapping with RO/NX permissions, as literal GUIDs and strings may be
passed to the variable routines.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/platform/efi/efi_64.c       | 18 +++++++++++++-----
 arch/x86/platform/efi/efi_thunk_64.S |  8 +++++---
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 1f3675453a57..b36596bf0fc3 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -176,7 +176,8 @@ virt_to_phys_or_null_size(void *va, unsigned long size)
 
 int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 {
-	unsigned long pfn, text, pf, rodata;
+	extern const u8 __efi64_thunk_ret_tramp[];
+	unsigned long pfn, text, pf, rodata, tramp;
 	struct page *page;
 	unsigned npages;
 	pgd_t *pgd = efi_mm.pgd;
@@ -238,11 +239,9 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 
 	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
-	pfn = text >> PAGE_SHIFT;
 
-	pf = _PAGE_ENC;
-	if (kernel_map_pages_in_pgd(pgd, pfn, text, npages, pf)) {
-		pr_err("Failed to map kernel text 1:1\n");
+	if (kernel_unmap_pages_in_pgd(pgd, text, npages)) {
+		pr_err("Failed to unmap kernel text 1:1 mapping\n");
 		return 1;
 	}
 
@@ -256,6 +255,15 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 1;
 	}
 
+	tramp = __pa(__efi64_thunk_ret_tramp);
+	pfn = tramp >> PAGE_SHIFT;
+
+	pf = _PAGE_ENC;
+	if (kernel_map_pages_in_pgd(pgd, pfn, tramp, 1, pf)) {
+		pr_err("Failed to map mixed mode return trampoline\n");
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 4e5257a4811b..e436ce03741e 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -23,7 +23,6 @@
 #include <linux/objtool.h>
 #include <asm/page_types.h>
 #include <asm/segment.h>
-#include <asm/nospec-branch.h>
 
 	.text
 	.code64
@@ -72,11 +71,14 @@ STACK_FRAME_NON_STANDARD __efi64_thunk
 	pushq	$__KERNEL32_CS
 	pushq	%rdi			/* EFI runtime service address */
 	lretq
+SYM_FUNC_END(__efi64_thunk)
 
+	.section ".rodata", "a", @progbits
+	.balign	16
+SYM_DATA_START(__efi64_thunk_ret_tramp)
 1:	movq	0x20(%rsp), %rsp
 	pop	%rbx
 	pop	%rbp
-	ANNOTATE_UNRET_SAFE
 	ret
 	int3
 
@@ -84,7 +86,7 @@ STACK_FRAME_NON_STANDARD __efi64_thunk
 2:	pushl	$__KERNEL_CS
 	pushl	%ebp
 	lret
-SYM_FUNC_END(__efi64_thunk)
+SYM_DATA_END(__efi64_thunk_ret_tramp)
 
 	.bss
 	.balign 8
-- 
2.35.1

