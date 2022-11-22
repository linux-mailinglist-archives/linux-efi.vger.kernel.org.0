Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB1634108
	for <lists+linux-efi@lfdr.de>; Tue, 22 Nov 2022 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiKVQLi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Nov 2022 11:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiKVQLI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Nov 2022 11:11:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3C742EF;
        Tue, 22 Nov 2022 08:10:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A425861791;
        Tue, 22 Nov 2022 16:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48367C433B5;
        Tue, 22 Nov 2022 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669133455;
        bh=ZGYYMFhXkrZn+e+cVgRjzokBYpzkxMdbl7BhlbBHuq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGRVsVzu72nJRrh0T5N78o3GOA+eT5mhSHei+3/rUxm1yaxZE+poMMlUdq6ZactgT
         AeOgWuHY6np+zLuLXpVRsyq0dF41Iab+ADu0YLEoAytpWqOPLygFWND/Gp1N+SrVNp
         ujh2x4K7XY41ddIiU8X19SX4odzbLvagQlWSBTsirmKILfnF6hQ8vpf54Z0YB+buis
         sMeETGVJqHbeYQOlQtpe7/0TErZ5av7oajrF8I9AVp4N1wbh7VFiKpY8LWlfHWHJGf
         0+P4679VcYhSojADDfVxwou+CNpBt+apUVaV9G48YSO4xZVJd24GS6wkj2FT93p8/L
         4bp5pQVas2ivw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v3 10/17] x86/compressed: pull global variable ref up into startup32_load_idt()
Date:   Tue, 22 Nov 2022 17:10:10 +0100
Message-Id: <20221122161017.2426828-11-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221122161017.2426828-1-ardb@kernel.org>
References: <20221122161017.2426828-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=ardb@kernel.org; h=from:subject; bh=ZGYYMFhXkrZn+e+cVgRjzokBYpzkxMdbl7BhlbBHuq8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjfPRdh332hSmcyhnd6dWI3Fifx3u18Y9Dg3Bb6nFH 9BBqP/uJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY3z0XQAKCRDDTyI5ktmPJNm3C/ 9t+i6/g+lskjGTDa4HQhq9OhoxKARAIBnekDSTufrRwq7UaYLrC70H2L/MCGzmVfYLB1mMfe+8fs05 4xAtilR1uWESgx3d9uCVVJSZ+ZPKJwirreG5+QYLr3UYwmIGnrQI9b4Q7xAHqqA9DvlXx0Snde9WSV SXk4/5AU6FQ55APrINmR9NgGPypvZhypy1CCyKxTUwRfynt7D8CSukxQpWtniES9Pe3XAMtrAxDYsm H0rQjMgT/XW7BaBFCx/GLHxJh13msz4Ye06DuT8MPnT46e5M9e8JPTtftw+cKfkarb7gSN5zvmNw/U FcCCDilzI5Rki3EDNGlCa/KP4+qoABbC1HepzwlDmJirE5PwVSQ7ug1FcnyWHHq2BhpM76O6uPxMiL aUqYchuPuatfBFGeZfVLu88K5atAk8p63BOFjF5hxJwV1vb4W+MmwW1D0OXMzjCEf+eccGmGzyspD7 PrLCXG0boJOGtG614NiQODtGnvpyZPvcOQ1p0mNEa0IHE=
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

In preparation for moving startup32_load_idt() out of head_64.S and
turning it into an ordinary function using the ordinary 32-bit calling
convention, pull the global variable reference to boot32_idt up into
startup32_load_idt() so that startup32_set_idt_entry() does not need to
discover its own runtime physical address, which will no longer be
correlated with startup_32 once this code is moved into .text.

While at it, give startup32_set_idt_entry() static linkage.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f31277f455e63f5f..82d7fab99422129f 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -736,16 +736,11 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
  *
  * %eax:	Handler address
  * %edx:	Vector number
- *
- * Physical offset is expected in %ebp
+ * %ecx:	IDT address
  */
-SYM_FUNC_START(startup32_set_idt_entry)
-	push    %ebx
-
-	/* IDT entry address to %ebx */
-	leal    rva(boot32_idt)(%ebp), %ebx
-	shl	$3, %edx
-	addl    %edx, %ebx
+SYM_FUNC_START_LOCAL(startup32_set_idt_entry)
+	/* IDT entry address to %ecx */
+	leal	(%ecx, %edx, 8), %ecx
 
 	/* Build IDT entry, lower 4 bytes */
 	movl    %eax, %edx
@@ -753,7 +748,7 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
 
 	/* Store lower 4 bytes to IDT */
-	movl    %edx, (%ebx)
+	movl    %edx, (%ecx)
 
 	/* Build IDT entry, upper 4 bytes */
 	movl    %eax, %edx
@@ -761,15 +756,16 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	orl     $0x00008e00, %edx	# Present, Type 32-bit Interrupt Gate
 
 	/* Store upper 4 bytes to IDT */
-	movl    %edx, 4(%ebx)
+	movl    %edx, 4(%ecx)
 
-	pop     %ebx
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
 #endif
 
 SYM_FUNC_START(startup32_load_idt)
 #ifdef CONFIG_AMD_MEM_ENCRYPT
+	leal    rva(boot32_idt)(%ebp), %ecx
+
 	/* #VC handler */
 	leal    rva(startup32_vc_handler)(%ebp), %eax
 	movl    $X86_TRAP_VC, %edx
-- 
2.35.1

