Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B92D5C005B
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiIUOyk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiIUOyi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:54:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33113AE6E;
        Wed, 21 Sep 2022 07:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADAFFB83028;
        Wed, 21 Sep 2022 14:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86383C433B5;
        Wed, 21 Sep 2022 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772073;
        bh=5V76Xsth0euhhz1QsgMDnrfFoaPcgyyzA5zjmBHSST0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGZREX0JzehUBdZFbLHBuO+8ZumcoyIPaEJjKhgSfqr5KC6P6Jb91+2EyjX+H/2zj
         REqs9iOkkS/b7NhxfKoe0SgQFLJhancGTMD2E6oWNY2KHJPDDtpM7qwzyawcRveOjb
         HopCH44DDZxFkDLAWHntcheLQuLJuu6ocEw4BYQTlYDJ/3RvUQQCYcARaFrMCiz57O
         A4tAOiHKduk7ykULICr3nphkeWQHyqUTwooi6Xgr1VSD51SAdTtJSF6BgV47UfoyW6
         x+Qdvgfk1lvioLA7ahO0RPCaBemTW7Gg+Xl0AdYk2/LMu8P1IdAcF2RR+pjw6Auf9W
         gRf5YOMq2z72w==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 02/16] x86/compressed: efi-mixed: move 32-bit entrypoint code into .text section
Date:   Wed, 21 Sep 2022 16:54:08 +0200
Message-Id: <20220921145422.437618-3-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=ardb@kernel.org; h=from:subject; bh=5V76Xsth0euhhz1QsgMDnrfFoaPcgyyzA5zjmBHSST0=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWGnPukk4waMSCu0HVqcFUn8kLOxKo4Gy9c8qZx ydwjOiiJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslhgAKCRDDTyI5ktmPJKmUC/ 0QiVgehXCkiHIq44VgWErny0BR4Q0khljnRiqzWqAJOGiyWsDSlEHAtB+8uDc+IlFelxvTHi+JtOp3 3iqafseDNfQsyqfhnvQHQQ/kCR8iC5Dm/4nRHiZHq0iDEceUGi4rVzCkQb61UTUy4sy3cc+aZvXJ42 y7tqRCO6LHu1NMhETQfGw4jXtypMId2UNfckHGwwlhJ8lROl/Ibh23aw7kQ1uLQtH6L636jpBE6e9f 3vwnLG1MkcYFbhqstBZUmWX809AGsHVryr+hoBt00sHBgjh0RZCyYQoxCjJ4DZUg9Ynk6931u0ChPD A9iKMno/g0QOumoBrhcOnA9ZuWn76cFvL9KvPN4r2yPZ80J9VaiLguzGBJhdQ91W4fQJX233mH/KlZ KCXmnGUjpacZOnVISgMbrMuHEEHQ4aEOjQzRBhAYqEfCh3gN+FUCSqUXaIrbLBK5Ij1yJPQiG1dUN3 jRYa4LvppmzoHy62OvqgFmSRLTsjEwljXgwtCWwDnTydE=
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

Move the code that stores the arguments passed to the EFI entrypoint
into the .text section, so that it can be moved into a separate
compilation unit in a subsequent patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/head_64.S | 34 ++++++++++++--------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..1ba2fc2357e6 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -303,24 +303,28 @@ SYM_FUNC_START(efi32_stub_entry)
 	popl	%ecx
 	popl	%edx
 	popl	%esi
+	jmp	efi32_entry
+SYM_FUNC_END(efi32_stub_entry)
 
+	.text
+SYM_FUNC_START_LOCAL(efi32_entry)
 	call	1f
-1:	pop	%ebp
-	subl	$ rva(1b), %ebp
-
-	movl	%esi, rva(efi32_boot_args+8)(%ebp)
-SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
-	movl	%ecx, rva(efi32_boot_args)(%ebp)
-	movl	%edx, rva(efi32_boot_args+4)(%ebp)
-	movb	$0, rva(efi_is64)(%ebp)
+1:	pop	%ebx
 
 	/* Save firmware GDTR and code/data selectors */
-	sgdtl	rva(efi32_boot_gdt)(%ebp)
-	movw	%cs, rva(efi32_boot_cs)(%ebp)
-	movw	%ds, rva(efi32_boot_ds)(%ebp)
+	sgdtl	(efi32_boot_gdt - 1b)(%ebx)
+	movw	%cs, (efi32_boot_cs - 1b)(%ebx)
+	movw	%ds, (efi32_boot_ds - 1b)(%ebx)
 
 	/* Store firmware IDT descriptor */
-	sidtl	rva(efi32_boot_idt)(%ebp)
+	sidtl	(efi32_boot_idt - 1b)(%ebx)
+
+	/* Store boot arguments */
+	leal	(efi32_boot_args - 1b)(%ebx), %ebx
+	movl	%ecx, 0(%ebx)
+	movl	%edx, 4(%ebx)
+	movl	%esi, 8(%ebx)
+	movb	$0x0, 12(%ebx)          // efi_is64
 
 	/* Disable paging */
 	movl	%cr0, %eax
@@ -328,7 +332,8 @@ SYM_INNER_LABEL(efi32_pe_stub_entry, SYM_L_LOCAL)
 	movl	%eax, %cr0
 
 	jmp	startup_32
-SYM_FUNC_END(efi32_stub_entry)
+SYM_FUNC_END(efi32_entry)
+	__HEAD
 #endif
 
 	.code64
@@ -831,7 +836,8 @@ SYM_FUNC_START(efi32_pe_entry)
 	 */
 	subl	%esi, %ebx
 	movl	%ebx, rva(image_offset)(%ebp)	// save image_offset
-	jmp	efi32_pe_stub_entry
+	xorl	%esi, %esi
+	jmp	efi32_entry
 
 2:	popl	%edi				// restore callee-save registers
 	popl	%ebx
-- 
2.35.1

