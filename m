Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8389725593
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbjFGH0Y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjFGHZx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:25:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B891FED;
        Wed,  7 Jun 2023 00:24:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A0ED63542;
        Wed,  7 Jun 2023 07:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE859C433A0;
        Wed,  7 Jun 2023 07:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122640;
        bh=0wgPR8cosROASbxhizaWEh3zQ4j+H/DEB9t5hilAPDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWwvL1E8pkq/VHu7SKqTWzB5IsBgx4UbU58H2oaGOtkSndAPzouOdgkZ46eMTGO8L
         gekBQ9RF8fjOVy+m7hXAmWVgYCLKNQyFbVaddTwSCU5Iaw78exac+o0Fxrngck8VEc
         ikpqE/Jx6aG9KdVljqYBO3V6TQm5FPF23NdVe/IpMZup1d7Ce1xg267r9l4UuhH1ve
         JOk8S+A0T/E87x2VpzCaDSSvkKaJ0UE9KIbtkoN29JU27f2wOxKpkaa+FK/0zdfSwT
         OFsElmTqK0gQOdinmyHj8imQUwnxS4YL8LGxYnmZX2cbT+5mZFO2boaudaPomPzhfY
         gaDmlKOTzxHwg==
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
Subject: [PATCH v5 01/20] x86/efistub: Branch straight to kernel entry point from C code
Date:   Wed,  7 Jun 2023 09:23:23 +0200
Message-Id: <20230607072342.4054036-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=ardb@kernel.org; h=from:subject; bh=0wgPR8cosROASbxhizaWEh3zQ4j+H/DEB9t5hilAPDo=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBILVkwumLTU3H5j/cIH/66+vkV6UeBj/PLN5wZM6TP 89vcTMLdpSyMIhxMMiKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJ3GRi+B+p8rz94KHqOPOD idd2cLMx/C6+sVndsE9l34VujQ92byMZ/inqvZv5UkxSInIp75QN//crGk/65nbjcTpnhXpMZYS cITcA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
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
 drivers/firmware/efi/libstub/x86-stub.c | 21 ++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 220be75a5cdc1f4c..d4a730f053bdcbfa 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
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
@@ -950,7 +959,11 @@ asmlinkage unsigned long efi_main(efi_handle_t handle,
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

