Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1A70B620
	for <lists+linux-efi@lfdr.de>; Mon, 22 May 2023 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjEVHPL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 May 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjEVHOn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 May 2023 03:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6E18C;
        Mon, 22 May 2023 00:14:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE5361DD9;
        Mon, 22 May 2023 07:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E98C433A0;
        Mon, 22 May 2023 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739678;
        bh=2ugw2aI3WS8XFLpq392iX/qheNdS02iXQMzmuFjsdqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbZw27Ycs8S+dDX/2VuheOzDlMUCm1wZOt8RUWc+IP8kxfzR0U8iXHqIVeqhkLUxG
         Nc0gfiw/AyKvGwZ7GqUR5xZGagAdlZ22F1cnAEMSYtFyDHtm/v7hiiS0iN8un0pdtO
         HoBM0vU7Bm42jdFt/bhGATlwG4su4IXa1/sOpUtd6v5O1t5hCqc7Ni0dmgQoH2Jw1k
         iHKngvdziAtkRsHDHKFs8OBG6f+B5juNfs3HASC5cyc0q12eeQbqTVLnFjdgIVY2Kv
         /s5lMfZ1QfKHUDikhqjLfI5HlsxDlUIWc/nixFPhRgD20b0oiS+FucfaXTc4VLUpV5
         6WZ2RRyFlyMAg==
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
Subject: [PATCH v3 01/21] x86/efistub: Branch straight to kernel entry point from C code
Date:   Mon, 22 May 2023 09:13:55 +0200
Message-Id: <20230522071415.501717-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522071415.501717-1-ardb@kernel.org>
References: <20230522071415.501717-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=ardb@kernel.org; h=from:subject; bh=2ugw2aI3WS8XFLpq392iX/qheNdS02iXQMzmuFjsdqI=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JISVbTO+qocu11eWX0wLvqVVu3fSrSm7+6bl1WwxUFK4GT /zD8+BPRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/3ZGhq/ibDHmCYkrn+04 sDIi54ll3wfl0upKb/7r/Ld+rZgaXMfIMEH0pLX0TbWQuFm+F65WlXB2dixbmH9l1dPK2S9ZPrE Y8AAA
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

Instead of returning to the calling code in assembler that does nothing
more than perform an indirect call with the boot_params pointer in
register ESI/RSI, perform the jump directly from the EFI stub C code.
This will allow the asm entrypoint code to be dropped entirely in
subsequent patches.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 8d17cee8b98e1a63..095aaa8b0ee30fb9 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -769,9 +769,17 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
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
+ * On success, we jump to the relocated kernel directly and never return.
  * On failure, we exit to the firmware via efi_exit instead of returning.
  */
 asmlinkage unsigned long efi_main(efi_handle_t handle,
@@ -914,7 +922,11 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
 		goto fail;
 	}
 
-	return bzimage_addr;
+	if (IS_ENABLED(CONFIG_X86_64))
+		/* add offset of startup_64() */
+		bzimage_addr += 0x200;
+
+	enter_kernel(bzimage_addr, boot_params);
 fail:
 	efi_err("efi_main() failed!\n");
 
-- 
2.39.2

