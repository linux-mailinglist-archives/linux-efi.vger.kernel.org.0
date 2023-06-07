Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A7725585
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jun 2023 09:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbjFGHZ0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Jun 2023 03:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbjFGHY5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Jun 2023 03:24:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1493B2684;
        Wed,  7 Jun 2023 00:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2714C63B61;
        Wed,  7 Jun 2023 07:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4AAC4339E;
        Wed,  7 Jun 2023 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686122657;
        bh=ygI81p6SqewQoIn6tCgoZLUH2Qo5tPVgo3BNvwGSS3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+XySU4GwLNBlMd01swdW/4ofacMcN3PCM0wAMFxZJIQZtyqzm3dyafUMPMzwfPPR
         rXW4w0ECIdYGnEmh9EbLWCs5nyRrjKi3oBOUlg6nb3Z3//UDTpCFYbE3/Ukn6FS7l1
         ROYcWld6wrG3koLGVRx0jdCFi7ozGFcsU8xxn+n2WD/hLk5VWJCvBCV4wILQhQp4Fw
         VT99ZoRnXtt7wQBxBCLRfx4DKeO1iunxTuOIHJ5FwDnYpsVH7d9ZVHsGNTqJhFnHER
         sf+bFE1zJjlZHkJFkiyynFh6hp7LyePiPNJq8R4tsYVU1VSMFL48nq17hcRXeIaS8+
         16919uac1tTFw==
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
Subject: [PATCH v5 05/20] x86/decompressor: Use proper sequence to take the address of the GOT
Date:   Wed,  7 Jun 2023 09:23:27 +0200
Message-Id: <20230607072342.4054036-6-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607072342.4054036-1-ardb@kernel.org>
References: <20230607072342.4054036-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=ardb@kernel.org; h=from:subject; bh=ygI81p6SqewQoIn6tCgoZLUH2Qo5tPVgo3BNvwGSS3U=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaXBIGtfjGz12WInw7ydqfPDJ7Ukb5i9b7FGVn2Z7oyqH cdfVGp0lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIksucPI8Ik7Pn35zuQ7Hp/C nC9+dF6mGnKjPzXqmjWPa6XbHPVffxgZ5mVe+BW5tCnk+YZFLF9Fe2IW7xSvsf+7r1S15+fH5q4 ZzAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
and emits a special relative relocation instead, and so the resulting
code works as expected. However, this is not obvious for someone reading
the code, and the use of LEA with an explicit relative addend is more
idiomatic so use that instead.

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

