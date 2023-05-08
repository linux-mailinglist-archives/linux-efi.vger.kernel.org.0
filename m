Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA56FA06E
	for <lists+linux-efi@lfdr.de>; Mon,  8 May 2023 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjEHHD4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 8 May 2023 03:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjEHHDs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 8 May 2023 03:03:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4951729;
        Mon,  8 May 2023 00:03:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BDF361F85;
        Mon,  8 May 2023 07:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD105C4339B;
        Mon,  8 May 2023 07:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683529424;
        bh=9BDwSgqeJ0SjBYTlcw8Hj/TbZ+wo730AVxbO98qoyM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ly4rZSXwCDf9rrQihuUSa1Bj+hNk31Ta6bmJEg9Dszga718CieEWys2FjTBX2HtCr
         eip1iHqzg4eIKgESfYPGUt6hwVSWYDcccrdfhzwGFZJdncOskRK5UUovPkJA6U8gEe
         iFWOqIMLkQw3cUKrioQwkDgWo5hdn56voCqLeLbHGMRjfHpwDq1BwneqrtQKpDNTJQ
         WHiP9meopiMUy6pVeDRppdn+xSHQ3/Sci9cKRXHfqr2/dREbsDXZT+Wa5aK0P5/7TP
         fYdmI/Ri0RgjKlWwRoW+HQDqbfaTIxrVVL8LzZZPPehTgXzCUx6a+Fpafi2q//a8Xz
         Dl+HriO/cuepg==
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
Subject: [PATCH v2 01/20] x86: decompressor: Use proper sequence to take the address of the GOT
Date:   Mon,  8 May 2023 09:03:11 +0200
Message-Id: <20230508070330.582131-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508070330.582131-1-ardb@kernel.org>
References: <20230508070330.582131-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=ardb@kernel.org; h=from:subject; bh=9BDwSgqeJ0SjBYTlcw8Hj/TbZ+wo730AVxbO98qoyM4=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVi3qrPbM1OE/6eqf17dOH1jBe/cuIE1l3daLzc0URiV +nDcw43O0pZGMQ4GGTFFFkEZv99t/P0RKla51myMHNYmUCGMHBxCsBEzC8y/NNiPTxr97RTmUdL Li+ayXv/2YMQ7/25cXN3eX1hqst3upHHyDBBRu/AHOUzyWsT3zHyTti1p+fNDd/rzgefpjW+z2z /HM4LAA==
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We don't actually use a global offset table (GOT) in the 32-bit
decompressor, but as is common for 32-bit position independent code, we
use the magic symbol _GLOBAL_OFFSET_TABLE_ as an anchor from which to
derive the actual runtime addresses of other symbols, using special
@GOTOFF symbol references that are resolved at link time, and populated
with the distance between the address of the magic _GLOBAL_OFFSET_TABLE_
anchor and the address of the symbol in question.

This means _GLOBAL_OFFSET_TABLE_ is the only symbol whose actual runtime
address we have to determine explicitly, which is one of the first
things we do in startup_32. However, we do so by taking the absolute
address via the immediate field of an ADD instruction (plus a small
offset), and taking absolute addresses that need to be resolved at link
time is what we are trying to avoid.

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
index 987ae727cf9f0d04..53cbee1e2a93efce 100644
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

