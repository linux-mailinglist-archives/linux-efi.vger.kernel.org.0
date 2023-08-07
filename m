Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE9772AB9
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjHGQ2U (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjHGQ17 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:27:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3748E172D;
        Mon,  7 Aug 2023 09:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAF0D61F1F;
        Mon,  7 Aug 2023 16:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EB2C433C8;
        Mon,  7 Aug 2023 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425674;
        bh=usQB03nvoiZEOQomH9z1zpnfhZCXgY7eC83YRzvcdlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn8BIJ0d+9krhWq2KpSnVjIPOS9kgIQTte9yZPzGQeIMDB+lszT+dAaA2B/rAmTKn
         Ab1AnXVwQSiyxp0XkoQuywk7xcZoU/TNHPQPO5hCiMi9eK8IfDyJjIx66Znl0LuBym
         /tiqhkQuSpDcBkOwnRFff/mujgq3fB4YxIAhGwvomxU7XFeyiRJANq1V2zdEJQcDO1
         7gEgzRS1lJW4C1Hct3ruf6lyzHAXp+wiJnuDljDWXVLla67DbOqwSie9pHjdVJ8tx9
         XR8B95nafoskoueX10nxtCOs6T4m8JgVrQqUyVPl3AU7NCSSTMWMryu9BdA3G+0Bh1
         ms8M346wWys3A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 06/23] x86/efistub: Clear BSS in EFI handover protocol entrypoint
Date:   Mon,  7 Aug 2023 18:27:03 +0200
Message-Id: <20230807162720.545787-7-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2971; i=ardb@kernel.org; h=from:subject; bh=usQB03nvoiZEOQomH9z1zpnfhZCXgY7eC83YRzvcdlw=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWidFCT0N6j88sMEla93JvuMOncrp0FO/IZtW3EV4mUv L4cHcjbUcLCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYydTfDjx1ZtS0l4sk+tvt8 ZlfPyPZZWXzvxuWtztEbnoWESGx+zchw7X1r5uSD/obXEn8rrJl6dsbzruzsF2XM+isf/k5Jsop gAAA=
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
index 3f3b3edf7a387d7c..9247dbc7dbbd12ef 100644
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

