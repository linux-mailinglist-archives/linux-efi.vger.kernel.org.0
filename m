Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A0634105
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiKVQLg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiKVQLG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7A742FA;
        Tue, 22 Nov 2022 08:10:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69CDE61740;
        Tue, 22 Nov 2022 16:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13562C4347C;
        Tue, 22 Nov 2022 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133452;
        bh=ZQv9+X1iJK9wCaH0UdAvPwmkreYOyHzQ5yoM8JDBf4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rP8QYEhs/Yv0vTP+DydzJhp++6EoqkR+xXkXY9SUY5zVuPKW1OBmTPtU0HKQx9RfQ
         l8QCamavVEscgs9v9wyLMTuoMUeqMnoayuFBcYlKI15qaAyZD15DJlYJJxqlTmRr7N
         1N2iMl0xAskzGmrLhzq7+E3uyNBBy9aP6jve3ps7wf3SB1xOHQDIBLrxAlQ8bKSd9+
         Ggt/pt5ISA0QROeCTn4ygrZ8dAs1BNJlchPnuhJsFVAPD6fsUSLnpOGBgV5wMT0thI
         WD/d367a/gVrSUGleowaH3aEm3ohjc2xSP/Hkagm+Fh2D/AR+Obbvtrj9EFve4I9Xv
         DXcMAPhz2tPiQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 09/17] x86/compressed: avoid touching ECX in startup32_set_idt_entry()
Date:   Tue, 22 Nov 2022 17:10:09 +0100
Message-Id: <20221122161017.2426828-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=ardb@kernel.org; h=from:subject; bh=ZQv9+X1iJK9wCaH0UdAvPwmkreYOyHzQ5yoM8JDBf4A=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRbNOEMtTo47vx2jAN2Z59KRsBmjvCYdb205ac7 Cv/CzdaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0WwAKCRDDTyI5ktmPJMBhC/ 9YvZjPjTtVifhaj3PVkOErn74GJ54+p0Yk1QiI2OSd+mr6sNcibNqgldEtqhOUXOpWxoNUld2Na7sx TbCsuvenJqmE6G3NX3B/qpnikHYnLm9vjgoZPxIgGFkBA5iIf9WF3wY3kl/31Pw7XkGoFFGyXODjs0 tWeAVgmWJE5S0RQodZ6fQUuESapXpwcobXuJUslwDqhgtUMKm8o9itj+FCEb1XuWU98LzzMJFLa48D Yek7l/df2rVTYUcybGjCVVBqqUMoAeoU6/5oQRTW9k7OmccRfXY1KimPLtujCGYwdD4mVjGHyWxnZP o3szwaE70Fp6vDbxvjLslV4Z0yadrsVJu/O9EdMLpSwuT3AFi3T505Vv0EcN97T59J2rRWDnKUr/AC L9EvMhOsePPNQo7NdixlnvUVCjR1D9gdTQ+tyejktKrDnL2pX41YPpeq6f8Zu7yJ1mX+efsXDluYz8 cbNV+G80miTg9qaZX2m3WE9CTqQsGRBr2xpwCkI0d8Mf0=
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

Avoid touching register %ecx in startup32_set_idt_entry(), by folding
the MOV, SHL and ORL instructions into a single ORL which no longer
requires a temp register.

This permits ECX to be used as a function argument in a subsequent
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 66ad3ab802ca9d0c..f31277f455e63f5f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -741,7 +741,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
  */
 SYM_FUNC_START(startup32_set_idt_entry)
 	push    %ebx
-	push    %ecx
 
 	/* IDT entry address to %ebx */
 	leal    rva(boot32_idt)(%ebp), %ebx
@@ -750,10 +749,8 @@ SYM_FUNC_START(startup32_set_idt_entry)
 
 	/* Build IDT entry, lower 4 bytes */
 	movl    %eax, %edx
-	andl    $0x0000ffff, %edx	# Target code segment offset [15:0]
-	movl    $__KERNEL32_CS, %ecx	# Target code segment selector
-	shl     $16, %ecx
-	orl     %ecx, %edx
+	andl    $0x0000ffff, %edx		# Target code segment offset [15:0]
+	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
 
 	/* Store lower 4 bytes to IDT */
 	movl    %edx, (%ebx)
@@ -766,7 +763,6 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	/* Store upper 4 bytes to IDT */
 	movl    %edx, 4(%ebx)
 
-	pop     %ecx
 	pop     %ebx
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
-- 
2.35.1

