Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5774EA06
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjGKJQE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjGKJPi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:15:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6781724;
        Tue, 11 Jul 2023 02:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 279046142F;
        Tue, 11 Jul 2023 09:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD977C433C8;
        Tue, 11 Jul 2023 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066924;
        bh=1uUURGYHh6gp1uj1SgOD55SOPPzPsQeMQl9hTqhNVG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSYasv6iUpezIDK1jpK4/5jDKxqU4m6t6ZCC4BXaRh56rAessJ44VEHMZnl47Sx81
         FIOIsZg+sUtgHMBeUzpNG2e53qSXX0AQ3SxgOfbPr9+tEnaXhl0/3JdqY9vdwAdhvJ
         wQEsoim0KXxz3JYjsrUKhHv1S+5Fbmv9wMb7xvIblLRLWmlq+JGaGR2c7ueC9uObpW
         GLVvVpkV/fkO6OQehrT6q5uIaCaYz9aIROYq2oVfs9J/uZ9AbNJf33yZ7yHKVR/y1S
         r7zjlG1uCK2KctDyJEICZJnKD+vZEb0IrrP5DlzQtB/JUwPsuae9GgmL5tpqo1Phjb
         DiM8GpfWitvkg==
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
Subject: [PATCH v6 05/21] x86/efistub: Clear BSS in EFI handover protocol entrypoint
Date:   Tue, 11 Jul 2023 11:14:37 +0200
Message-Id: <20230711091453.2543622-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=ardb@kernel.org; h=from:subject; bh=1uUURGYHh6gp1uj1SgOD55SOPPzPsQeMQl9hTqhNVG8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbLWtfPizFecn1P77pt9uKcQZtNbiQEiBUjcHl1Dws SDR5fc6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwET6TzP8d/DLVNcuPSO9pDSs 9u7N9l3fr83Oijmz/Yeqy82sGjaudIb/RSeSzz5Z/WeuxGSnJC5lzcps1zT+CZ6bXri+bjoyqfU jNwA=
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

The so-called EFI handover protocol is value-add from the distros that
permits a loader to simply copy a PE kernel image into memory and call
an alternative entrypoint that is described by an embedded boot_params
structure.

Most implementations of this protocol do not bother to check the PE
header for minimum alignment, section placement, etc, and therefore also
don't clear the image's BSS, or even allocate enough memory for it.

Allocating more memory on the fly is rather difficult, but at least
clear the BSS region explicitly when entering in this manner, so that
the EFI stub code does not get confused by global variables that were
not zero-initialized correctly.

When booting in mixed mode, this BSS clearing must occur before any
global state is created, so clear it in the 32-bit asm entry point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S    | 14 +++++++++++++-
 drivers/firmware/efi/libstub/x86-stub.c | 13 +++++++++++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 9308b595f6f0a5de..8a02a151806df14c 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -142,6 +142,18 @@ SYM_FUNC_END(__efi64_thunk)
 	.code32
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
 SYM_FUNC_START(efi32_stub_entry)
+	call	1f
+1:	popl	%ecx
+
+	/* Clear BSS */
+	xorl	%eax, %eax
+	leal	(_bss - 1b)(%ecx), %edi
+	leal	(_ebss - 1b)(%ecx), %ecx
+	subl	%edi, %ecx
+	shrl	$2, %ecx
+	cld
+	rep	stosl
+
 	add	$0x4, %esp		/* Discard return address */
 	popl	%ecx
 	popl	%edx
@@ -334,7 +346,7 @@ SYM_FUNC_END(efi32_pe_entry)
 	.org	efi32_stub_entry + 0x200
 	.code64
 SYM_FUNC_START_NOALIGN(efi64_stub_entry)
-	jmp	efi_stub_entry
+	jmp	efi_handover_entry
 SYM_FUNC_END(efi64_stub_entry)
 #endif
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1180ccd3cd426918..9e1994c6afc672ca 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -970,12 +970,21 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 }
 
 #ifdef CONFIG_EFI_HANDOVER_PROTOCOL
+void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
+			struct boot_params *boot_params)
+{
+	extern char _bss[], _ebss[];
+
+	memset(_bss, 0, _ebss - _bss);
+	efi_stub_entry(handle, sys_table_arg, boot_params);
+}
+
 #ifndef CONFIG_EFI_MIXED
-extern __alias(efi_stub_entry)
+extern __alias(efi_handover_entry)
 void efi32_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 		      struct boot_params *boot_params);
 
-extern __alias(efi_stub_entry)
+extern __alias(efi_handover_entry)
 void efi64_stub_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 		      struct boot_params *boot_params);
 #endif
-- 
2.39.2

