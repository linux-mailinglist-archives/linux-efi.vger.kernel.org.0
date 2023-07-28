Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B329766870
	for <lists+linux-efi@lfdr.de>; Fri, 28 Jul 2023 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjG1JNX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 28 Jul 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjG1JMo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 28 Jul 2023 05:12:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9B3AAF;
        Fri, 28 Jul 2023 02:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9BF362086;
        Fri, 28 Jul 2023 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B85C433CB;
        Fri, 28 Jul 2023 09:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690535472;
        bh=zBQnolwjGWOFrzM6wjiy++8kSbbyRGDO2Rsd3pLzB7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L1aLycPW7CvFhFTw5MZP8oN9kg9Uv+8u0C/1+9rljlD3FXtiwhokexo/7V97Kenwh
         ns+2xFfJNd1xPY1ZT4e9/A7ix6oHUv6j23bkNSi18sROGv+yNjpbKZi8ahLW5lWP6V
         hQU/JaFX7oXsb8I5pPAqTOGYGugiouIlBIQhb4/CbS2Gy68pTVlEIH62I+UHlzb7Fu
         3sKT663jMxwSWDa/5TyUpe0GA5FvPq3mIX4vNZEXp/QVEoGPms+8ZgEtNuIY3pc1qS
         9b8z8wZclf9J65cec/hNOCOmUReSIRq9J6DlJPgJMvuf9i0B5sCCWggzaRtDO/ruoE
         NXkBsabfnV+7w==
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
Subject: [PATCH v7 07/22] x86/decompressor: Use proper sequence to take the address of the GOT
Date:   Fri, 28 Jul 2023 11:09:01 +0200
Message-Id: <20230728090916.1538550-8-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230728090916.1538550-1-ardb@kernel.org>
References: <20230728090916.1538550-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=ardb@kernel.org; h=from:subject; bh=zBQnolwjGWOFrzM6wjiy++8kSbbyRGDO2Rsd3pLzB7M=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeVw68prT2YcUdzpPvnZl6dGzcfCTMuutpabHf4u2b2F+ XuCx8tFHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiDY4M/12udfY1iKo9U9Xe 9EODS0hn+vQkU7X/yxP2v31XIWO+yYuR4cGpmmVeuU88L4onhDP39PP/qy/e3f3q74TWlDn+F6a 0MgMA
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

The 32-bit decompressor does not actually use a global offset table
(GOT), but as is common for 32-bit position independent code, it uses
the magic symbol _GLOBAL_OFFSET_TABLE_ as an anchor from which to derive
the actual runtime addresses of other symbols, using special @GOTOFF
symbol references that are resolved at link time, and populated with the
distance between the address of the magic _GLOBAL_OFFSET_TABLE_ anchor
and the address of the symbol in question.

This means _GLOBAL_OFFSET_TABLE_ is the only symbol whose actual runtime
address needs to be determined explicitly, which is one of the first
things that happens in startup_32. However, it does so by taking the
absolute address via the immediate field of an ADD instruction (plus a
small offset), which seems to defeat the point.

Fortunately, the assembler knows that _GLOBAL_OFFSET_TABLE_ is magic,
and emits a special relative R_386_GOTPC relocation instead, and so the
resulting code works as expected. However, this is not obvious for
someone reading the code, and the use of LEA with an explicit relative
addend is more idiomatic so use that instead.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 8876ffe30e9a4819..3530465b5b85ccf3 100644
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

