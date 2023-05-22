Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8006670B61E
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjEVHPK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjEVHOv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:14:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109EB6;
        Mon, 22 May 2023 00:14:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 126D561DC7;
        Mon, 22 May 2023 07:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30D7C4339C;
        Mon, 22 May 2023 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739686;
        bh=+pOeFG4I2M0NxWTqt2DlFeFWBXmc5I0TflwHlC5RHXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/eg7yFJCmf7fVb6NYCJcBPl5QfJKS98YfDdyW+b37Bjqr4u27h1NZswcE1+lpjtZ
         98Q8gXYSnUv0T90Qg7a67k9AjBjASBXdjmLuEZXlLENvJ9dhKNwXEJqJGKFXiq5fdO
         bfNk6AWEEv8jkTmLgSkFfINHyiJaD9QpZ3WQ64V5cPga2DTxoMIItrxlDjrCG8kdB/
         VojqEKIm64AAJQMR+bJXVjSIVXoPWeq/OryHTSFlScwPRB3rIZaMIf3L+pn5ALC1ee
         a5QJRsAAGhgv4dIaXf0qfKUrmlcHxxdi0yoeuJhJ7YUmRK5D9mmWaKKRVE1BX0Jzkl
         wl6eQ8NCMgJzA==
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
Subject: [PATCH v3 03/21] x86/decompressor: Avoid magic offsets for EFI handover entrypoint
Date:   Mon, 22 May 2023 09:13:57 +0200
Message-Id: <20230522071415.501717-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3376; i=ardb@kernel.org; h=from:subject; bh=+pOeFG4I2M0NxWTqt2DlFeFWBXmc5I0TflwHlC5RHXA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbzPBNh4/k5gqHKBtjoxNfX9xeE5N2szXBxHFW0OH12 3TCd2h2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgInwlTP8Yjp4qHd1YnzF+dYc n7YfoUfqrkVsTHGoEBbKf8ayLn23KSPDpchH6dy2bvxPMv8f1vp8QkxnXlL0ulWX2Re4Py9dF7a dDwA=
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

