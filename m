Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156C444BF48
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 11:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhKJK7k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 05:59:40 -0500
Received: from mail.ispras.ru ([83.149.199.84]:53924 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231420AbhKJK7i (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:59:38 -0500
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 7B58740A2BBF;
        Wed, 10 Nov 2021 10:47:01 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/5] efi/x86_64: set page table if provided by libstub
Date:   Wed, 10 Nov 2021 13:46:10 +0300
Message-Id: <20211110104613.23881-3-baskov@ispras.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110104613.23881-1-baskov@ispras.ru>
References: <20211110104613.23881-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

It is desired to be able to switch pages tables before jumping
to potentially relocated code while booting via UEFI.
The easiest way to achieve that is to do it in assembly
immediately after returning from efi_main().

Add mechanism to switch page table to one provided by libstub.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
---
 arch/x86/boot/compressed/head_64.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 572c535cf45b..1e467fdefd9d 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -540,6 +540,17 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	movq	%rdx, %rbx			/* save boot_params pointer */
 	call	efi_main
 	movq	%rbx,%rsi
+
+	/*
+	 * Switch page table to the one constructed by libstub if provided
+	 * It is required to be done here because stack is not mapped
+	 * in new page table.
+	 */
+	movq	efi_temp_pgtable(%rip), %rbx
+	testq	%rbx, %rbx
+	jz	1f
+	movq	%rbx, %cr3
+1:
 	leaq	rva(startup_64)(%rax), %rax
 	jmp	*%rax
 SYM_FUNC_END(efi64_stub_entry)
@@ -736,6 +747,7 @@ SYM_DATA_END_LABEL(boot32_idt, SYM_L_GLOBAL, boot32_idt_end)
 
 #ifdef CONFIG_EFI_STUB
 SYM_DATA(image_offset, .long 0)
+SYM_DATA(efi_temp_pgtable, .quad 0)
 #endif
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0, 0)
-- 
2.33.1

