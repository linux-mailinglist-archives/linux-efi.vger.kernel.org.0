Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0090E634101
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiKVQLV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbiKVQLF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEED742DA;
        Tue, 22 Nov 2022 08:10:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 988C5B81C10;
        Tue, 22 Nov 2022 16:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C880C433B5;
        Tue, 22 Nov 2022 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133448;
        bh=tOdWUuW+7rgqllOBTMdmkxOryu+AGCsLR6dgpWQteso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BiufXI+mj44YUUusTzdntIlg0lRmgwZYJPkPpwLrUsCR8FBC+urQixAow657MZ5QW
         CefK9ug9CnRFw8SbUFp+/CII3Zge+H426s8CUgwsJoEJ2WDM5xfERDkex3DknWnJXE
         gcx85eg+sh9YXyyRTcOy+yAf+GjtKhu7kJ1JCe5Bttfb8F18WaSr8nENWtPKqepLLj
         ykaqG7c8+06m2HVtvxEdHHhKdM3XgitW1YRsswnVjrwHw7n8r6af9kVH3bfkn89KOO
         TE+3/6tvztwMbs0DycWr500DEizlVVgMpz1rh5csu5nasd2MscRDD/MPeLlbomsj2g
         /QL8HHe7ziJbg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 07/17] x86/compressed: efi: merge multiple definitions of image_offset into one
Date:   Tue, 22 Nov 2022 17:10:07 +0100
Message-Id: <20221122161017.2426828-8-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=ardb@kernel.org; h=from:subject; bh=tOdWUuW+7rgqllOBTMdmkxOryu+AGCsLR6dgpWQteso=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRYC6Q2FjOROO3g/kYMKd+j9GKGxB5vZLG55iXf a8HbgceJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0WAAKCRDDTyI5ktmPJMJoC/ 9tRpz6EuotfivDhIcQDtygpLQicCtE3UjIExGFiK0FyZ9yappBSj+HZXMRE7UK2j9VvkxNB+6fubLx HPXGIWaFPass4WDoo+RPCJjtrMhyQ8o+Tvaf9BglY981Bikni+FdPVomUa2FVTmWeitHLY2EjyldVb HM+gMQFyFwbssI85/Hhm7RiLr6BF6Qo47Dj2rvrOfzVgnMYy4q44RZJ9lGfNIzZhkRB9lndQC7ksb+ 6u5UbObuRQh20g+49oLscw8CybFdLj7T8k1AHX5Wv3W7/rFl5z1qU1hT61bwXglm82elPDhxqvekXM PzK0lnEWOBzXn1jCC6T77I64FUQPiP6DGyaWJ3TJ82VACxjBoBTOK8dw+CeYdA2KGRC6rOkX/SaXaQ pkq9Cg00EY8HinC+0SWf3PJgOnTVEXQ/az5HRkUhbFNhdV/Jx5WxKPOFkHjlk3v0GjGfNS2anD++Rc XukCkruMnp+ffXQlSPydA036uiPwNKmvXkPKMax5kjc7A=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There is no need for head_32.S and head_64.S both declaring a copy of
the globale 'image_offset' variable, so drop those and make the extern C
declaration the definition.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S      | 4 ----
 arch/x86/boot/compressed/head_64.S      | 4 ----
 drivers/firmware/efi/libstub/x86-stub.c | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 3b354eb9516df416..6589ddd4cfaf2cb6 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -208,10 +208,6 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 /*
  * Stack and heap for uncompression
  */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 987f0a3c284fad43..66ad3ab802ca9d0c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -726,10 +726,6 @@ SYM_DATA_START(boot32_idt)
 SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 #endif
 
-#ifdef CONFIG_EFI_STUB
-SYM_DATA(image_offset, .long 0)
-#endif
-
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	__HEAD
 	.code32
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 33a7811e12c65642..cb5f0befee57d2ec 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -23,7 +23,7 @@
 
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
-extern u32 image_offset;
+u32 image_offset;
 static efi_loaded_image_t *image = NULL;
 
 static efi_status_t
-- 
2.35.1

