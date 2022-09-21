Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2735C0075
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiIUOzz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiIUOzJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197D2F02D;
        Wed, 21 Sep 2022 07:54:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5CA57CE16ED;
        Wed, 21 Sep 2022 14:54:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0A3C433D6;
        Wed, 21 Sep 2022 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772091;
        bh=bi7gERI8Rh2eJxvUwkTokQpvaPF1xle6ajVfQJZQAL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5fJSq2EIFbcZzRQSmb4uKZuUlZvYXZsUYjwfI5HVkx+k2onFY8GrdSgg1jhpJLXB
         dDLqKMt8z2Gurn9Kudgv5MlFsfvDNATjS5d3em+jztqFkomYTQjFL0V6kJYjp1vD25
         aC05xU43Nvgzh+KaUXsq4LrgdQMEs4TqOMvYHgakQQB62k/67pyOuzV1DW2poDDuBm
         bouzkPt02n1rCxAQglrfn8UGUWJUEDUEY3fRXEiwq3lDrhtYKwZoUTOPr5b6EH/2sL
         7Wkv4FjAfyqpGiDy7jaT3zxRZaB7Zr+ChIC1qhQSCuqMydBuz0/7Txou9cHJOwf5Ou
         fNRumZxPM5S9A==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 10/16] x86/compressed: pull global variable ref up into startup32_load_idt()
Date:   Wed, 21 Sep 2022 16:54:16 +0200
Message-Id: <20220921145422.437618-11-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=ardb@kernel.org; h=from:subject; bh=bi7gERI8Rh2eJxvUwkTokQpvaPF1xle6ajVfQJZQAL8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWTSpfnxSFRCxSL6xi4PzPwnBo4ZCR+TLZSieo1 v0Fazo+JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslkwAKCRDDTyI5ktmPJCyQC/ 0c2tKgZkrS9+xkRm2T4k5D/oy57fpIKXGKl8u2kv0fBHVFPOq17JcV+1chPVlytcBAwYZ0updumfaq NewdPtSmDONEiY3CF2iDiYnx6YbGKen7nBhDNXYY5zdPYMPPPkx1Zm+fU3Ty5XeLg03cWHvOTAQQY/ L8JokqK3/mOOlb+xadZFd7HYjXlLiY+K5ZcsFVkX/fAOWYhoraiJva+nSr23bzRqe8sWdUUBs0LJRq XCf4ii8QlYfgTnD9JPryUDNiEJlcMfRHUPKFGhayS+jtCT82lLcAXwMBdPV5U7PghYK4PXmMkn3Joz 3Ja3QY6kskSs+DICg2pm0VgT3WDy3Z95ecX3dgth4ZvmrWOW/XMsa/3GvFom1/4fJCMhqPC2ArqwSo FXWf7C5jtXyBfew4yGYrIA3S52FzyDKxc6EkopzvWuuHyjEFAaV0INASAMBgzfp+wfmtQdU9h6eHVm DaSslWF8RJ1onu1fHjRn7bK7ykzyXeACp1u+ysz2EVBuE=
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
index 3db7e4a634b0..a1f893dd5bbf 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -728,16 +728,11 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
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
@@ -745,7 +740,7 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	orl	$(__KERNEL32_CS << 16), %edx	# Target code segment selector
 
 	/* Store lower 4 bytes to IDT */
-	movl    %edx, (%ebx)
+	movl    %edx, (%ecx)
 
 	/* Build IDT entry, upper 4 bytes */
 	movl    %eax, %edx
@@ -753,15 +748,16 @@ SYM_FUNC_START(startup32_set_idt_entry)
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

