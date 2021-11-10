Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3423E44BF4C
	for <lists+linux-efi@lfdr.de>; Wed, 10 Nov 2021 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKJK7l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 Nov 2021 05:59:41 -0500
Received: from mail.ispras.ru ([83.149.199.84]:53950 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231478AbhKJK7k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 10 Nov 2021 05:59:40 -0500
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id BE4DF40D3BFF;
        Wed, 10 Nov 2021 10:47:00 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 1/5] efi/x86: Disable paging when booting via efistub
Date:   Wed, 10 Nov 2021 13:46:09 +0300
Message-Id: <20211110104613.23881-2-baskov@ispras.ru>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110104613.23881-1-baskov@ispras.ru>
References: <20211110104613.23881-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some UEFI implementations protect lower 1M memory regions and memory
regions allocated by libstub from being executable, which prevents
Linux kernel from booting.

Disable paging after returning from efi_main() before jumping
to potentially relocated code to prevent page fault from happening.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>
---
 arch/x86/boot/compressed/head_32.S | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 659fad53ca82..c66fccaa90a2 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -156,6 +156,18 @@ SYM_FUNC_START_ALIAS(efi_stub_entry)
 	add	$0x4, %esp
 	movl	8(%esp), %esi	/* save boot_params pointer */
 	call	efi_main
+
+#ifdef CONFIG_EFI_STRICT_PGTABLE
+	/*
+	 * Disable paging before jumping to relocated address to prevent
+	 * page faulting on EFI firmware versions that enforces restricted
+	 * permissions on identity page tables
+	 */
+	movl	%cr0, %ecx
+	btrl	$31, %ecx
+	movl	%ecx, %cr0
+#endif
+
 	/* efi_main returns the possibly relocated address of startup_32 */
 	jmp	*%eax
 SYM_FUNC_END(efi32_stub_entry)
-- 
2.33.1

