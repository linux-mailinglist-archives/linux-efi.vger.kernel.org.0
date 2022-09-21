Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A325C0073
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiIUOzv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiIUOzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043D2A24E;
        Wed, 21 Sep 2022 07:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BDCCB82FFB;
        Wed, 21 Sep 2022 14:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8407EC433C1;
        Wed, 21 Sep 2022 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772089;
        bh=Mx/PIkv+IJsR2kRCaN1LFYMt4suxqTqn0Z2DZ65HT2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KI1HIH1B3UIqqKYDe2y8/OfovTvzY7qeU2FFb5KcN+X8PvcimVrS0kTTGB5eI2UGw
         CeDeUYAbpRpDnw7TiAPnxu72bL94URrRZGlXB+nfCb7qCby2X72EC8ztgZWaSdczJl
         +VfUPtOZ11pwpnWIhUsEXgiH41GYqK/0TYfFgNy0qfo9s7bBjAy8iLMEq02Bk9bdrm
         9Q94LCEuKHXMhyy5YLa4YZhEjp1ip5YpXvi7Ss1MJ5Cppc5QU9SwFxV2OWonQwRK0v
         dVZnYVWq9iMUR1BXGYG8MxSrtWR28D/vCT/ZshUUZYA2S/n6nUsQ87EWj3WDHuypz1
         IMe1XRh38ytBA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 09/16] x86/compressed: avoid touching ECX in startup32_set_idt_entry()
Date:   Wed, 21 Sep 2022 16:54:15 +0200
Message-Id: <20220921145422.437618-10-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1564; i=ardb@kernel.org; h=from:subject; bh=Mx/PIkv+IJsR2kRCaN1LFYMt4suxqTqn0Z2DZ65HT2g=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWSszwdIxgcgQI2r3csojaetczLgrN62zrr6DKI jolMsPaJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslkgAKCRDDTyI5ktmPJOUNDA C1mFPmt8GXzx8NbyDpyg3eF/l2Rp4krkOTg0xRjZFmKFihtuBDVnSiP5M80Oq3+tav6OuvW2aZCTa9 YWd0gbwmi8bR/vRfnHQBXWXWRy06nbsbIom7m8c0eJNPsFSuBiKJF06WVyIz2VsyY5AjsIz8ofAnGs 9KJ2B1VMVTBTm7gc49G2HT9PI0kPsLXd8V9P3e93B8z6Vf1pLFvueDvqc+SCX5XtaDHsA6aN8kpO7/ pEG91f2GMvCsgFMtdzzbFe3yhc5rvtjkri3gOSWTlHCGVaZNDVI3W6r7bphh4JTKLD5oc33YkRBpLJ OEqZVy/MZdr8lMKpYy7SXgo15phvT40w9+7Bwta79cGFOIK5E7UzrJPt5/FIFw3yf9cf7LkZ55LAHy z3Rj3/QlL1VhgOZCJslmqNIOuGXujd4SLTHyrGAfl4isUwxSZnTeEk1KfEFCy8Oa5q1mV5TYjMon5f M3Ry2j/GlKXlzzqh/b3j0qWid7vGgshFU1YN8a0ebJNxc=
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
index 90b119fbef58..3db7e4a634b0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -733,7 +733,6 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
  */
 SYM_FUNC_START(startup32_set_idt_entry)
 	push    %ebx
-	push    %ecx
 
 	/* IDT entry address to %ebx */
 	leal    rva(boot32_idt)(%ebp), %ebx
@@ -742,10 +741,8 @@ SYM_FUNC_START(startup32_set_idt_entry)
 
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
@@ -758,7 +755,6 @@ SYM_FUNC_START(startup32_set_idt_entry)
 	/* Store upper 4 bytes to IDT */
 	movl    %edx, 4(%ebx)
 
-	pop     %ecx
 	pop     %ebx
 	RET
 SYM_FUNC_END(startup32_set_idt_entry)
-- 
2.35.1

