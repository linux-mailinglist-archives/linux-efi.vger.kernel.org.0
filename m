Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEA85C0071
	for <lists+linux-efi@lfdr.de>; Wed, 21 Sep 2022 16:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIUOzq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 21 Sep 2022 10:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiIUOzC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 21 Sep 2022 10:55:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF5C27CC3;
        Wed, 21 Sep 2022 07:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A220B630D0;
        Wed, 21 Sep 2022 14:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F416C433B5;
        Wed, 21 Sep 2022 14:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663772087;
        bh=9QnYVj6z/B1v2rUoK+Ldcmd4eGkNmNagz5RXwwVDZGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LV5F1pc72XgMbSfBcXvFa8f798xK73hAo9+GcK7JAexOkNiWrsfxHfToYrJ1u7UK1
         2NjzhH+SRwfY7JMRNg7swmQMFTbcNd9YgxBibfHVchkuGgMpUjWemJlAFeS9WG9EnZ
         A6kt911jmqK6AK4GPdsz+EvuPOrUX11Cpz9UJ8c49iaxqszxleDNWH9fpOgbGz5NLH
         9wLCcqcAYEbIvATmuCvxkqkJSev2IT1KSrwPywyJYhbPjPU8dt/zGgfYJmE3MJeKaD
         MANuhbOem/a9v91o0hL+7ZraShb2mhFKjkZfB/CxMNoibiI7/zNLGaUyB7QuL0NcoQ
         O5OxZV0B0hEiQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>
Subject: [PATCH v2 08/16] x86/compressed: efi-mixed: simplify IDT/GDT preserve/restore
Date:   Wed, 21 Sep 2022 16:54:14 +0200
Message-Id: <20220921145422.437618-9-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220921145422.437618-1-ardb@kernel.org>
References: <20220921145422.437618-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=ardb@kernel.org; h=from:subject; bh=9QnYVj6z/B1v2rUoK+Ldcmd4eGkNmNagz5RXwwVDZGA=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjKyWQ3Ag0DM2zo9H8bBKsNY/cqI7OhW4UARHecPw4 H+NV04iJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYyslkAAKCRDDTyI5ktmPJHJoC/ 9zKUezLXemPXQfjghbahMwiJfosOLNu3nSZv4NsjAIRqUFe62kdapZjUdrHVuDuXvocNX9wG6G7W7c 88Hj8TLAbtHthl0J3JuiDA3+WU3tiK8eVSQaW3mPEBzdz4QGHKVtvwy8CjPB4QANf+LxhhBmw6H2iH oyp1erDEahDcycZ5B3eYOjRn3mg8XuIdsgRcmRcuqZVof31KRADuVyAbYlrm/7xPDk8ldwlm/35qLd s9+GLXLH06Uba5NYXJGcVufVHi/rlMhzpW5LyiqdrEJMa/JiMFXVv8fEZqHcRZvKTIU2ipwY+qgZXZ sAWm4Q89XxQZfMwwKHpEqHIfc+LoTldBYCt9rV+caF1IKRHCA2Crdc2EylqnbL1i3DgfP08kjRWK9L 5nl9aYQJfYM/K2JLC0i6xLeRcPl281OJTs6r75cNjfAN0tzWuxIfQE+kw/F9oodRILNDaLPdKlDyh8 FHTiMFUEgCGUztYjlRF745urnUP6GCeUfQgtD/1Jo9zXM=
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

Tweak the asm and remove some redundant instructions. While at it,
fix the associated comment for style and correctness.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/efi_mixed.S | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_mixed.S b/arch/x86/boot/compressed/efi_mixed.S
index 838514f7685a..e5b8f1d2310c 100644
--- a/arch/x86/boot/compressed/efi_mixed.S
+++ b/arch/x86/boot/compressed/efi_mixed.S
@@ -96,24 +96,20 @@ SYM_FUNC_START(__efi64_thunk)
 
 	leaq	0x20(%rsp), %rbx
 	sgdt	(%rbx)
-
-	addq	$16, %rbx
-	sidt	(%rbx)
+	sidt	16(%rbx)
 
 	leaq	1f(%rip), %rbp
 
 	/*
-	 * Switch to IDT and GDT with 32-bit segments. This is the firmware GDT
-	 * and IDT that was installed when the kernel started executing. The
-	 * pointers were saved by the efi32_entry() routine below.
+	 * Switch to IDT and GDT with 32-bit segments. These are the firmware
+	 * GDT and IDT that were installed when the kernel started executing.
+	 * The pointers were saved by the efi32_entry() routine below.
 	 *
 	 * Pass the saved DS selector to the 32-bit code, and use far return to
 	 * restore the saved CS selector.
 	 */
-	leaq	efi32_boot_idt(%rip), %rax
-	lidt	(%rax)
-	leaq	efi32_boot_gdt(%rip), %rax
-	lgdt	(%rax)
+	lidt	efi32_boot_idt(%rip)
+	lgdt	efi32_boot_gdt(%rip)
 
 	movzwl	efi32_boot_ds(%rip), %edx
 	movzwq	efi32_boot_cs(%rip), %rax
@@ -187,9 +183,7 @@ SYM_FUNC_START_LOCAL(efi_enter32)
 	 */
 	cli
 
-	lidtl	(%ebx)
-	subl	$16, %ebx
-
+	lidtl	16(%ebx)
 	lgdtl	(%ebx)
 
 	movl	%cr4, %eax
-- 
2.35.1

