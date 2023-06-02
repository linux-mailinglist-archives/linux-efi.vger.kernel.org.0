Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923271FF04
	for <lists+linux-efi@lfdr.de>; Fri,  2 Jun 2023 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbjFBKWu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 2 Jun 2023 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjFBKWX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 2 Jun 2023 06:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AD11AE;
        Fri,  2 Jun 2023 03:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05C0464E71;
        Fri,  2 Jun 2023 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A312C4339C;
        Fri,  2 Jun 2023 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685701340;
        bh=+pOeFG4I2M0NxWTqt2DlFeFWBXmc5I0TflwHlC5RHXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZHQQ8iiabB8LyufShp63/BFbUFbzOsYVWTKUi65Muc89+1LlzSmC4seQ4t5NnekYW
         q3amSyw7qDJpJgAyzuClLUQ7PNqWnsuOwFCAS6/xoEyBBmv9gb+Q5OKkmYLrUAft1m
         +RSn0pbgLQ82JlXs70oJnJXuOpa8EyTaBm5N45QdyDML95rmNZa/Rchlvv36h1n3bX
         UYMM8V/chWu+W8URIXqRvjD1ZXRVbayKKYZxOklXL/wBgc+iVr6Ayn/NIXny2SCBi3
         kQ5ypVcJWllJpClE0XKIB57ucg9ULU++xnhhQ3pRG8UnBLugQiySiwAraJCOAm78s/
         97tKMrlBS55lg==
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
Subject: [PATCH v4 03/21] x86/decompressor: Avoid magic offsets for EFI handover entrypoint
Date:   Fri,  2 Jun 2023 12:12:55 +0200
Message-Id: <20230602101313.3557775-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602101313.3557775-1-ardb@kernel.org>
References: <20230602101313.3557775-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3376; i=ardb@kernel.org; h=from:subject; bh=+pOeFG4I2M0NxWTqt2DlFeFWBXmc5I0TflwHlC5RHXA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXywOI3HT6SmyscomyMjU58fXF7TUzazdYEE8dZQYfXb 9MJ36HZUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACbyjJvhD//d1w33X2q9MVm8 xXJS1KQJbA3zJ/9Ss5v14eNruejeKZMY/tfet08tOHyzIObI+l2dwpuNLC4pM+6Z6me5JWVaT8W RN0wA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The native 32-bit or 64-bit EFI handover protocol entrypoint offset
relative to the respective startup_32/64 address is described in
boot_params as handover_offset, so that the special Linux/x86 aware EFI
loader can find it there.

When mixed mode is enabled, this single field has to describe this
offset for both the 32-bit and 64-bit entrypoints, so their respective
relative offsets have to be identical. Given that startup_32 and
startup_64 are 0x200 bytes apart, and the EFI handover entrypoint
resides at a fixed offset, the 32-bit and 64-bit versions of those
entrypoints must be exactly 0x200 bytes apart as well.

Currently, hard-coded fixed offsets are used to ensure this, but it is
sufficient to emit the 64-bit entrypoint 0x200 bytes after the 32-bit
one, wherever it happens to reside. This allows this code (which is now
EFI mixed mode specific) to be moved into efi_mixed.S and out of the
startup code in head_64.S.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++++++++++++++-
 arch/x86/boot/compressed/head_64.S   | 18 ------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index dcc562c8f7f35162..9308b595f6f0a5de 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -140,6 +140,16 @@ SYM_FUNC_START(__efi64_thunk)
 SYM_FUNC_END(__efi64_thunk)
 
 	.code32
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+SYM_FUNC_START(efi32_stub_entry)
+	add	$0x4, %esp		/* Discard return address */
+	popl	%ecx
+	popl	%edx
+	popl	%esi
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_stub_entry)
+#endif
+
 /*
  * EFI service pointer must be in %edi.
  *
@@ -220,7 +230,7 @@ SYM_FUNC_END(efi_enter32)
  * stub may still exit and return to the firmware using the Exit() EFI boot
  * service.]
  */
-SYM_FUNC_START(efi32_entry)
+SYM_FUNC_START_LOCAL(efi32_entry)
 	call	1f
 1:	pop	%ebx
 
@@ -320,6 +330,14 @@ SYM_FUNC_START(efi32_pe_entry)
 	RET
 SYM_FUNC_END(efi32_pe_entry)
 
+#ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+	.org	efi32_stub_entry + 0x200
+	.code64
+SYM_FUNC_START_NOALIGN(efi64_stub_entry)
+	jmp	efi_stub_entry
+SYM_FUNC_END(efi64_stub_entry)
+#endif
+
 	.section ".rodata"
 	/* EFI loaded image protocol GUID */
 	.balign 4
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 71c1f40a7ac067b9..9f90661744741210 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -294,17 +294,6 @@ SYM_FUNC_START(startup_32)
 	lret
 SYM_FUNC_END(startup_32)
 
-#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
-	.org 0x190
-SYM_FUNC_START(efi32_stub_entry)
-	add	$0x4, %esp		/* Discard return address */
-	popl	%ecx
-	popl	%edx
-	popl	%esi
-	jmp	efi32_entry
-SYM_FUNC_END(efi32_stub_entry)
-#endif
-
 	.code64
 	.org 0x200
 SYM_CODE_START(startup_64)
@@ -523,13 +512,6 @@ trampoline_return:
 	jmp	*%rax
 SYM_CODE_END(startup_64)
 
-#if IS_ENABLED(CONFIG_EFI_MIXED) && IS_ENABLED(CONFIG_EFI_HANDOVER_PROTOCOL)
-	.org 0x390
-SYM_FUNC_START(efi64_stub_entry)
-	jmp	efi_stub_entry
-SYM_FUNC_END(efi64_stub_entry)
-#endif
-
 	.text
 SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 
-- 
2.39.2

