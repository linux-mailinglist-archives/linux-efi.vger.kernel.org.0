Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9914E395
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jan 2020 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgA3UEt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Jan 2020 15:04:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35836 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgA3UEs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Jan 2020 15:04:48 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so4258218qki.2;
        Thu, 30 Jan 2020 12:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8BP/JiwAZN6O4Lde1kGKfrHDvXG0oGuxGIKrR3hEGM=;
        b=Xv3CrKhCYW9wKCrCbycs/OuGsaqqts6YyDoTGVYJyqW4rpwyPF++Vo0VoQ1zFq1CBa
         me8WKyDeT7x+EWaDFNwcmngcsgFRYyuNnR4BznLKU6+iXLGxFASrQP3gkAXcpfMenXeC
         1tZlgJH2kVeefr8QaO+Drpmpydwesno6vZ5Bsh6VBq7/kF9yC0WvjStEAofknh/B+wQS
         aPfWT+7QGlV9kOA2J/nmAfvoMgO8AtOQAe2kHwqCNEi+U/Zb1iNA75G4A5/IuNiYfORU
         6sNYoj0E9qGlIUmNQZaAop+VT2GxwGlmNBEIZpeU/P9dpsky3DDUy5o/zq0Uy4qALF1L
         DBsA==
X-Gm-Message-State: APjAAAXvGElNqvgVc15DWcmSQzEQwpYaI4KBkXSdibr7KC0v5D1pIyvH
        g4hEBVXtEovwA+nlu8qEENE=
X-Google-Smtp-Source: APXvYqwEcuXsmqslm6b+p2kjeL8fzqPRZWoKVtBq3qumQLXdD8610hSz+pizhY0XF5Hcdigd18FH5A==
X-Received: by 2002:a05:620a:2013:: with SMTP id c19mr6957988qka.496.1580414687699;
        Thu, 30 Jan 2020 12:04:47 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k15sm3262865qkk.103.2020.01.30.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:04:47 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 6/8] efi/x86: Change __KERNEL_{CS,DS} to __BOOT_{CS,DS}
Date:   Thu, 30 Jan 2020 15:04:38 -0500
Message-Id: <20200130200440.1796058-7-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200130200440.1796058-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Although these are the same values, the 32-bit GDT was the one saved on
entry from the bootloader, and it is more accurate to refer to
__BOOT_{CS,DS} descriptors, rather than __KERNEL_{CS,DS} which are the
descriptors in the 64-bit GDT.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 8fb7f6799c52..4f32f05cbac6 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -58,7 +58,7 @@ SYM_FUNC_START(__efi64_thunk)
 	leaq	efi32_boot_gdt(%rip), %rax
 	lgdt	(%rax)
 
-	pushq	$__KERNEL_CS
+	pushq	$__BOOT_CS
 	leaq	efi_enter32(%rip), %rax
 	pushq	%rax
 	lretq
@@ -92,7 +92,7 @@ SYM_FUNC_END(__efi64_thunk)
  * The stack should represent the 32-bit calling convention.
  */
 SYM_FUNC_START_LOCAL(efi_enter32)
-	movl	$__KERNEL_DS, %eax
+	movl	$__BOOT_DS, %eax
 	movl	%eax, %ds
 	movl	%eax, %es
 	movl	%eax, %ss
-- 
2.24.1

