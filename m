Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEB370B61C
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjEVHPI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjEVHO4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:14:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7113BA;
        Mon, 22 May 2023 00:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61DBF61DDD;
        Mon, 22 May 2023 07:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3BFC4339C;
        Mon, 22 May 2023 07:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739694;
        bh=ygI81p6SqewQoIn6tCgoZLUH2Qo5tPVgo3BNvwGSS3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ahdZuLYw1TmYdmQL7lxGHEBiiBSANf79+lkAs61O4z58clTFkmUWH58Fsbdo33R3z
         f1fMye2kQbMk8gjq+efFzOBdtG5qIi9Ea8qvj08KORTxU9WKJePL9KJleO948dlGdd
         1Q2JtizxxQVY0RkrEFWjyvwxepYUgaEaWVEH5w+BwdLHBpLNBkCSAGQ3YOS9BBBXND
         t1aep4slelOSfi3wf6U0TVJzig67BQfHew9FDQm0MMUJENIwTpNCZq9ILKsv1tu+7O
         bmRmAg52hOVvDqquTz9yxja6QwMK8OKV/WL0VdvLNQOEFNTWlhyGyXccFgxOoALZpG
         IlAcnhCBhUjBg==
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
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v3 05/21] x86/decompressor: Use proper sequence to take the address of the GOT
Date:   Mon, 22 May 2023 09:13:59 +0200
Message-Id: <20230522071415.501717-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=ardb@kernel.org; h=from:subject; bh=ygI81p6SqewQoIn6tCgoZLUH2Qo5tPVgo3BNvwGSS3U=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzHhfjGz12WInw7ydqfPDJ7Ukb5i9b7FGVn2Z7oyqH cdfVGp0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIm0KTIyrF17+9OtoPo3ZXV+ 0yM+ap06MX1Rjqd/vtzOzMsersb9IYwMX2Pv6k44LDOnZ8bi5ZeDUs/EP/19p29RxDaZCRYi8/q LmAE=
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

The 32-bit decompressor does not actually use a global offset table
(GOT), but as is common for 32-bit position independent code, it uses
the magic symbol _GLOBAL_OFFSET_TABLE_ as an anchor from which to derive
the actual runtime addresses of other symbols, using special @GOTOFF
symbol references that are resolved at link time, and populated with the
distance between the address of the magic _GLOBAL_OFFSET_TABLE_ anchor
and the address of the symbol in question.

This means _GLOBAL_OFFSET_TABLE_ is the only symbol whose actual runtime
address needs to be determined explicitly, which is one of the first
things that happens in startup_32. However, it does so by taking the
absolute address via the immediate field of an ADD instruction (plus a
small offset), which seems to defeat the point.

Fortunately, the assembler knows that _GLOBAL_OFFSET_TABLE_ is magic,
and emits a special relative relocation instead, and so the resulting
code works as expected. However, this is not obvious for someone reading
the code, and the use of LEA with an explicit relative addend is more
idiomatic so use that instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 8876ffe30e9a4819..3530465b5b85ccf3 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -58,7 +58,7 @@ SYM_FUNC_START(startup_32)
 	leal	(BP_scratch+4)(%esi), %esp
 	call	1f
 1:	popl	%edx
-	addl	$_GLOBAL_OFFSET_TABLE_+(.-1b), %edx
+	leal	(_GLOBAL_OFFSET_TABLE_ - 1b)(%edx), %edx
 
 	/* Load new GDT */
 	leal	gdt@GOTOFF(%edx), %eax
-- 
2.39.2

