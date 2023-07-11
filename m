Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91A574E9FE
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jul 2023 11:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGKJPS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 11 Jul 2023 05:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjGKJPO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 11 Jul 2023 05:15:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0E41A2;
        Tue, 11 Jul 2023 02:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5D06142F;
        Tue, 11 Jul 2023 09:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2947C433C7;
        Tue, 11 Jul 2023 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689066911;
        bh=cnIFjVPlRuij4fslmOFx/et3lCiQLNIXYxYzvqFRV/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tg7P6XXqAo3OD5VPM3L/ijB4LZPLLmlzswPo1ncJPXuhrqmjjE83AwRrDf9sdCEIU
         6LAJrByQh7fPb0nQ6E4P7i+VQF767Tu5QIRvaqQUmu6i5RtuBWqbyfGuSLFnTpfly8
         n4iSGRQyDh2DAfF5/DOhybLEX037LLgI6bjd65j/jRtHgvwyoMd+stUPZY/xSigxbg
         EUAXojHu9CN1gIuSBu8GZzK+UT7dpC35XMRvMYpN4yZBLq2bTCINu10prn0M+Y4aR9
         cvXMh/LFVeE88CDdt1OO+8T+Ho5bvpTlSg+OuQr9xvYk97OSyK/2+0i6xxaRTWfian
         Gzdw4+xUjrWEQ==
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
Subject: [PATCH v6 02/21] x86/efistub: Branch straight to kernel entry point from C code
Date:   Tue, 11 Jul 2023 11:14:34 +0200
Message-Id: <20230711091453.2543622-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230711091453.2543622-1-ardb@kernel.org>
References: <20230711091453.2543622-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2316; i=ardb@kernel.org; h=from:subject; bh=cnIFjVPlRuij4fslmOFx/et3lCiQLNIXYxYzvqFRV/o=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIWWtbIWZyGKdmzu++c2/ZL039TDzNKOV2bqcH41/7ZO1t /XkC+DqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZysXI0L1Em+WSRbbuSfnH 2QsSxfhEvyTw1DxZnL/AsmqSW+KKeoa/oso3xE+WeVTP3H/4edGyXawWF/Y+byj7Vps87fCBTv4 wPgA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 220be75a5cdc1f4c..09c4210e4ef33864 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -290,7 +290,7 @@ adjust_memory_range_protection(unsigned long start, unsigned long size)
 #define TRAMPOLINE_PLACEMENT_BASE ((128 - 8)*1024)
 #define TRAMPOLINE_PLACEMENT_SIZE (640*1024 - (128 - 8)*1024)
 
-void startup_32(struct boot_params *boot_params);
+extern const char startup_32[], startup_64[];
 
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

