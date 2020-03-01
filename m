Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39AD41750D3
	for <lists+linux-efi@lfdr.de>; Mon,  2 Mar 2020 00:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgCAXF6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 1 Mar 2020 18:05:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33863 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCAXFk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 1 Mar 2020 18:05:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id 11so8456409qkd.1;
        Sun, 01 Mar 2020 15:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJcab2Z86Z2lgsisTBZYLUumTJXRFX+hPbTFTN+EtjA=;
        b=Rs4z30ZgjJPvbC3TwmWQbvEbGClwTF2TJGG5BSx4icFBb7KsEZjl9R4D9GcCm9+3KS
         JM2eofKYTExzBYPdIP2vZXSPebYEXguKVV8tQ4hsxJSntgAbUfbZdobTevPmZkaF8dKp
         n3D5gA7xB5W36enNMLAR3kj4w/x4u32l8/TvQXccyrcDlTDu1NM2Zxp23ccuvsXoV5oK
         7dfA+tfkDMvJBGufwpXR6U++n5RzRBHfufH8Zio7zTjmmb9GJFGyvF95qNaumpCAyrF5
         C6+3tg0VzFXDTbY3EaHlhEuVjMrBKl4SLxqj/18vXoDo9FtNsv5t00f4nZ/MHbADO0n6
         fXuQ==
X-Gm-Message-State: APjAAAW4RAF4KtPRlvqfEOSu80jqsKYKAEfSBJljkWZMVUSIeLP5nqn4
        Ab30aZp4xChKuxiNh8d+aAQ=
X-Google-Smtp-Source: APXvYqw8m4R8I7q72XSmYoSyS2q3J0vW0vMDD+d+f8KMyiPoUBKjQPmJwAOinAqurt94OFGyMZZNig==
X-Received: by 2002:a37:a705:: with SMTP id q5mr13292661qke.344.1583103939140;
        Sun, 01 Mar 2020 15:05:39 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x131sm8923906qka.1.2020.03.01.15.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 15:05:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] x86/boot/compressed/32: Save the output address instead of recalculating it
Date:   Sun,  1 Mar 2020 18:05:33 -0500
Message-Id: <20200301230537.2247550-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200301230537.2247550-1-nivedita@alum.mit.edu>
References: <20200301230537.2247550-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for being able to decompress starting at a different
address than startup_32, save the calculated output address instead of
recalculating it later.

We now keep track of three addresses:
	%edx: startup_32 as we were loaded by bootloader
	%ebx: new location of compressed kernel
	%ebp: start of decompression buffer

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 46bbe7ab4adf..894182500606 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -75,11 +75,11 @@ SYM_FUNC_START(startup_32)
  */
 	leal	(BP_scratch+4)(%esi), %esp
 	call	1f
-1:	popl	%ebp
-	subl	$1b, %ebp
+1:	popl	%edx
+	subl	$1b, %edx
 
 	/* Load new GDT */
-	leal	gdt(%ebp), %eax
+	leal	gdt(%edx), %eax
 	movl	%eax, 2(%eax)
 	lgdt	(%eax)
 
@@ -92,13 +92,14 @@ SYM_FUNC_START(startup_32)
 	movl	%eax, %ss
 
 /*
- * %ebp contains the address we are loaded at by the boot loader and %ebx
+ * %edx contains the address we are loaded at by the boot loader and %ebx
  * contains the address where we should move the kernel image temporarily
- * for safe in-place decompression.
+ * for safe in-place decompression. %ebp contains the address that the kernel
+ * will be decompressed to.
  */
 
 #ifdef CONFIG_RELOCATABLE
-	movl	%ebp, %ebx
+	movl	%edx, %ebx
 	movl	BP_kernel_alignment(%esi), %eax
 	decl	%eax
 	addl    %eax, %ebx
@@ -110,10 +111,10 @@ SYM_FUNC_START(startup_32)
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
 
+	movl	%ebx, %ebp	// Save the output address for later
 	/* Target address to relocate to for decompression */
-	movl    BP_init_size(%esi), %eax
-	subl    $_end, %eax
-	addl    %eax, %ebx
+	addl    BP_init_size(%esi), %ebx
+	subl    $_end, %ebx
 
 	/* Set up the stack */
 	leal	boot_stack_end(%ebx), %esp
@@ -127,7 +128,7 @@ SYM_FUNC_START(startup_32)
  * where decompression in place becomes safe.
  */
 	pushl	%esi
-	leal	(_bss-4)(%ebp), %esi
+	leal	(_bss-4)(%edx), %esi
 	leal	(_bss-4)(%ebx), %edi
 	movl	$(_bss - startup_32), %ecx
 	shrl	$2, %ecx
@@ -196,9 +197,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 				/* push arguments for extract_kernel: */
 	pushl	$z_output_len	/* decompressed length, end of relocs */
 
-	leal	_end(%ebx), %eax
-	subl    BP_init_size(%esi), %eax
-	pushl	%eax		/* output address */
+	pushl	%ebp		/* output address */
 
 	pushl	$z_input_len	/* input_len */
 	leal	input_data(%ebx), %eax
-- 
2.24.1

