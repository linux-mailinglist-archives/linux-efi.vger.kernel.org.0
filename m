Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9C1772AB0
	for <lists+linux-efi@lfdr.de>; Mon,  7 Aug 2023 18:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjHGQ2P (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Aug 2023 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjHGQ1u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Aug 2023 12:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581CD100;
        Mon,  7 Aug 2023 09:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F4A61EDB;
        Mon,  7 Aug 2023 16:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA225C433C8;
        Mon,  7 Aug 2023 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691425668;
        bh=rZ4dagtCLM4Dd3aSWI/Kh+e/QUOV/FZ3MiPjfd5ziT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpTz8LQNGrHo8uBSp/y4FC08ohdbzFusdoGs0IUbWK8E76h7WUsmMgmakcJwxb5vW
         YnryQKrUKtX+9A8yV2LIg0tNEHOhnwQfpBy8HW9ozC+bcKR/78fCLLBoH1FkkYvWaE
         uMb0CWjp5rpwvsZx/P1eIiV6xCvClnbggHVhuSeHeanGvAuUsAZmswxp5BGB+DalbA
         Suwx2t4v6v3VHygkjj2FyWNkkVdhGgQk+ch4t6l9PYekEsyTu4VM3dxjcTtHJ40lI6
         3WoBxIu3kiz9pyI74jb5mj9EOCFsSL9BryzQH+fttEPmcp02QTiiqpoLoiXexf0/vt
         2rgBrLYyeY66w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v9 03/23] x86/efistub: Branch straight to kernel entry point from C code
Date:   Mon,  7 Aug 2023 18:27:00 +0200
Message-Id: <20230807162720.545787-4-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807162720.545787-1-ardb@kernel.org>
References: <20230807162720.545787-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314; i=ardb@kernel.org; h=from:subject; bh=rZ4dagtCLM4Dd3aSWI/Kh+e/QUOV/FZ3MiPjfd5ziT8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWitJ8K17FjYUl3J6zaKBFfPW+pmv80l6sqQimN0sdnz EzTMzvYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyQZ3hn9Jm9aeTVu++HtP7 cKeiz9wPixNj9O3Wi/kve7mFpdVbU5Xhr1Ch/24vDaejW7g3JoUXhBh0LSl+xMMSp+at/M/3WuN 7TgA=
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

Instead of returning to the calling code in assembler that does nothing
more than perform an indirect call with the boot_params pointer in
register ESI/RSI, perform the jump directly from the EFI stub C code.
This will allow the asm entrypoint code to be dropped entirely in
subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 22 +++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 220be75a5cdc1f4c..40a10db2d85e7942 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -290,7 +290,7 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 #define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
 #define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
 
-void startup_32(struct boot_params *boot_params);
+extern const u8 startup_32[], startup_64[];
 
 static void
 setup_memory_protection(unsigned long image_base, unsigned long image_size)
@@ -803,10 +803,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
+static void __noreturn enter_kernel(unsigned long kernel_addr,
+				    struct boot_params *boot_params)
+{
+	/* enter decompressed kernel with boot_params pointer in RSI/ESI */
+	asm("jmp *%0"::"r"(kernel_addr), "S"(boot_params));
+
+	unreachable();
+}
+
 /*
- * On success, we return the address of startup_32, which has potentially been
- * relocated by efi_relocate_kernel.
- * On failure, we exit to the firmware via efi_exit instead of returning.
+ * On success, this routine will jump to the relocated image directly and never
+ * return.  On failure, it will exit to the firmware via efi_exit() instead of
+ * returning.
  */
 asmlinkage unsigned long efi_main(efi_handle_t handle,
 				  efi_system_table_t *sys_table_arg,
@@ -950,7 +959,10 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
-	return bzimage_addr;
+	if (IS_ENABLED(CONFIG_X86_64))
+		bzimage_addr += startup_64 - startup_32;
+
+	enter_kernel(bzimage_addr, boot_params);
 fail:
 	efi_err("efi_main() failed!\n");
 
-- 
2.39.2

