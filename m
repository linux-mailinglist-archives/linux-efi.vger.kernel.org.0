Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E41FCE44
	for <lists+linux-efi@lfdr.de>; Wed, 17 Jun 2020 15:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQNUA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Jun 2020 09:20:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40592 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQNUA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Jun 2020 09:20:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id c185so1909854qke.7
        for <linux-efi@vger.kernel.org>; Wed, 17 Jun 2020 06:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mr1OOkW9j1Kuqw0/ZXa+pA0NfmtcJPrqi32X37SEysY=;
        b=rzl+io5ta5bGLb5ynlgb8oXES2KGr1Zf5aebpH7DiOowKd3LQpH3nKkSiTBRjgo5PV
         zxlUUsMJ93kj7g8QbgBhvG+EGJt8QU1W7rxsr7fxcz4xKfwtOaldKWB1ZwQLYjhiygbt
         qrmJIai4S5WsxlSw7Qe8L8gDUaiDNAiO/kHsu9x7+nrNjRri4P0xjuQHUpWg5Bg0x9A9
         Nz9TQq+fM53RYt5+dy3JC2HifEvpuJN4fiddKdgSzk5JAKh3cbVKAclQo3n6ux7kY/lW
         4MQbJjEu/nVIlBUc+awFzbMfwEtRToG8rS+1pKNMd1Ug1MeCljUYOqE2dY/NtokqJ065
         0dgg==
X-Gm-Message-State: AOAM533utCZrXi9wiYhDnBU+WVVHP6f4CAEwxuI5CgH2Q14qH3nOsBfa
        FhCYJpvrxNiM5ufyBVBaHMc=
X-Google-Smtp-Source: ABdhPJzbsqUSg0Uf4Ym9g8sdQIefEPyv50Qn6ZIt+9TMPAsq9UnsDaY98EeZkawdbeihWImgHp673g==
X-Received: by 2002:a37:b14:: with SMTP id 20mr25731870qkl.401.1592399998825;
        Wed, 17 Jun 2020 06:19:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a126sm1806507qkc.82.2020.06.17.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 06:19:58 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: [PATCH v2] efi/x86: Setup stack correctly for efi_pe_entry
Date:   Wed, 17 Jun 2020 09:19:57 -0400
Message-Id: <20200617131957.2507632-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAMj1kXGovNeVTm3sSwpk6Lqk=JkBq_gV0t3WKd1=kJ11+C2e5g@mail.gmail.com>
References: <CAMj1kXGovNeVTm3sSwpk6Lqk=JkBq_gV0t3WKd1=kJ11+C2e5g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit
  17054f492dfd ("efi/x86: Implement mixed mode boot without the handover protocol")
introduced a new entry point for the EFI stub to be booted in mixed mode
on 32-bit firmware.

When entered via efi32_pe_entry, control is first transferred to
startup_32 to setup for the switch to long mode, and then the EFI stub
proper is entered via efi_pe_entry. efi_pe_entry is an MS ABI function,
and the ABI requires 32 bytes of shadow stack space to be allocated by
the caller, as well as the stack being aligned to 8 mod 16 on entry.

Allocate 40 bytes on the stack before switching to 64-bit mode when
calling efi_pe_entry to account for this.

For robustness, explicitly align boot_stack_end to 16 bytes. It is
currently implicitly aligned since .bss is cacheline-size aligned,
head_64.o is the first object file with a .bss section, and the heap and
boot sizes are aligned.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e821a7d7d5c4..97d37f0a34f5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -213,7 +213,6 @@ SYM_FUNC_START(startup_32)
 	 * We place all of the values on our mini stack so lret can
 	 * used to perform that far jump.
 	 */
-	pushl	$__KERNEL_CS
 	leal	startup_64(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
 	movl	efi32_boot_args(%ebp), %edi
@@ -224,11 +223,20 @@ SYM_FUNC_START(startup_32)
 	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
 	cmpl	$0, %edx
 	jnz	1f
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	subl	$40, %esp
 	leal	efi_pe_entry(%ebp), %eax
 	movl	%edi, %ecx			// MS calling convention
 	movl	%esi, %edx
 1:
 #endif
+	pushl	$__KERNEL_CS
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
@@ -784,6 +792,7 @@ SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
 
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
+	.balign 16
 SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 
 /*
-- 
2.26.2

