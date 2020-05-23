Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8ED1DFB4E
	for <lists+linux-efi@lfdr.de>; Sun, 24 May 2020 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEWWPS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 May 2020 18:15:18 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41220 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgEWWPR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 May 2020 18:15:17 -0400
Received: by mail-qv1-f66.google.com with SMTP id v15so6456520qvr.8
        for <linux-efi@vger.kernel.org>; Sat, 23 May 2020 15:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bfFsWCtgSIY8jeQh47uizCNqYACDGtQiBURdhCtxaVg=;
        b=IqtUDOPfXe7rxWa3Eg09v6jIv3r3b5Av1/2Ev8PpX9XMtlZFtmTMf2cRlU5kW2QhAn
         uBLasCMUYWSoo5DbUNP5ft2Cj3PHrLFG1bNMJGKbuNwkYtAmj4MD3mTn6mzv1lnjiDCI
         LnEWgadFswn98fF14SUNOr2lyN+CTBTkwMq5wAu0nh3FIQRBGX2oMJg38Lv/kmx2c8aX
         CWiZMsV5EdLLkVLxUYXJotZg/8N+b4JRvxGfEZwExGs5OFr1SVtFvHv0Z/oI/bsezUVE
         DOu0+ulEusDk7aYNd10Jta6wqjwQhlnCU+qUfoOrQGjzbxVbQrPv/iP65J8ijixmixm5
         QSSQ==
X-Gm-Message-State: AOAM531rXpnVRPq9A8V8+dCemBQuD8ZXrvnbXg4sZgrflo6kmFzjz06d
        07glHLHirlLdzs9YULFxmW+KyAUI
X-Google-Smtp-Source: ABdhPJwSNBwoQqs+32xZeC0rSHmGC2FjolzKfqPdY5nIAvPKiWPCmRWG+zY181GBIQLXL9zw7MCn+Q==
X-Received: by 2002:a05:6214:9c8:: with SMTP id dp8mr9592176qvb.109.1590272115415;
        Sat, 23 May 2020 15:15:15 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s15sm1913049qtc.95.2020.05.23.15.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:15:14 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org
Subject: [PATCH] efi/x86: Drop the special GDT for the EFI thunk
Date:   Sat, 23 May 2020 18:15:13 -0400
Message-Id: <20200523221513.1642948-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Instead of using efi_gdt64 to switch back to 64-bit mode and then
switching to the real boot-time GDT, just switch to the boot-time GDT
directly. The two GDT's are identical other than efi_gdt64 not including
the 32-bit code segment.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/efi_thunk_64.S | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 2b2049259619..c4bb0f9363f5 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -28,8 +28,6 @@ SYM_FUNC_START(__efi64_thunk)
 	push	%rbx
 
 	leaq	1f(%rip), %rbp
-	leaq	efi_gdt64(%rip), %rbx
-	movl	%ebx, 2(%rbx)		/* Fixup the gdt base address */
 
 	movl	%ds, %eax
 	push	%rax
@@ -48,7 +46,8 @@ SYM_FUNC_START(__efi64_thunk)
 	movl	%r8d, 0xc(%rsp)
 	movl	%r9d, 0x10(%rsp)
 
-	sgdt	0x14(%rsp)
+	leaq	0x14(%rsp), %rbx
+	sgdt	(%rbx)
 
 	/*
 	 * Switch to gdt with 32-bit segments. This is the firmware GDT
@@ -68,8 +67,7 @@ SYM_FUNC_START(__efi64_thunk)
 	pushq	%rax
 	lretq
 
-1:	lgdt	0x14(%rsp)
-	addq	$32, %rsp
+1:	addq	$32, %rsp
 	movq	%rdi, %rax
 
 	pop	%rbx
@@ -175,14 +173,3 @@ SYM_DATA_END(efi32_boot_cs)
 SYM_DATA_START(efi32_boot_ds)
 	.word	0
 SYM_DATA_END(efi32_boot_ds)
-
-SYM_DATA_START(efi_gdt64)
-	.word	efi_gdt64_end - efi_gdt64
-	.long	0			/* Filled out by user */
-	.word	0
-	.quad	0x0000000000000000	/* NULL descriptor */
-	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
-	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
-	.quad	0x0080890000000000	/* TS descriptor */
-	.quad   0x0000000000000000	/* TS continued */
-SYM_DATA_END_LABEL(efi_gdt64, SYM_L_LOCAL, efi_gdt64_end)
-- 
2.26.2

