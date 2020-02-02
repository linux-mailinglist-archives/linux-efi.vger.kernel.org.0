Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C8314FE7F
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgBBROC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:14:02 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38002 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgBBROB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:14:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so11930106qki.5;
        Sun, 02 Feb 2020 09:14:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HcYQGMS15rgUb2VdVKCHPTVuNlNarSVxa0yC99KH22M=;
        b=J6j1OrYZIb9sMb4zFRKvtz9yI62J2RrrghbeVtx2RE971JkwO7/iVs/33MJ7AoXOCU
         U3WYPE6sBduGtZVedPhGYJ3Oqv4N7r2jxdLyqXXdeF6Sb0S3MsVYacCB9M5v6XdMXZbk
         4b+t72s+Bf+yEgs4HLcgC8DqQmzmS0ZO8R+Weh46gWIJPuiHf9Do8zy29FT23CSxjZLf
         Ziqr5GJMvaVXhf13HcrOyVlEVgS+zp+wBwykKk2GH/qNlcubNmHRZj0/eRkguXg+UeD6
         XLC7TV1Et5z1vV1NxVvNgWyaqVzxcycgL/awCCtfk8fx/BWKp6Wq7nFVzgB5B1fNYejb
         CGSg==
X-Gm-Message-State: APjAAAVFKUW4ZT5yWzGVrE1bwJlLE6z13iybEXgGbwEjNzQCZiu7iQ5K
        RQWfvP+OSlN1JkzXdvmP3XY=
X-Google-Smtp-Source: APXvYqyvRrY/N9Jouc2Rdgtrw8FedJsQRnpQuQKBo4q+miiQAaFMHlNQK+4NjrhRkjby8CSjCAGPGw==
X-Received: by 2002:a05:620a:1477:: with SMTP id j23mr20724320qkl.63.1580663640447;
        Sun, 02 Feb 2020 09:14:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:14:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] x86/boot: Micro-optimize GDT loading instructions
Date:   Sun,  2 Feb 2020 12:13:53 -0500
Message-Id: <20200202171353.3736319-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202171353.3736319-1-nivedita@alum.mit.edu>
References: <20200130200440.1796058-1-nivedita@alum.mit.edu>
 <20200202171353.3736319-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rearrange the instructions a bit to use a 32-bit displacement once
instead of 2/3 times. This saves 8 bytes of machine code.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c36e6156b6a3..a4f5561c1c0e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -69,8 +69,9 @@ SYM_FUNC_START(startup_32)
 	subl	$1b, %ebp
 
 	/* Load new GDT with the 64bit segments using 32bit descriptor */
-	addl	%ebp, gdt+2(%ebp)
-	lgdt	gdt(%ebp)
+	leal	gdt(%ebp), %eax
+	movl	%eax, 2(%eax)
+	lgdt	(%eax)
 
 	/* Load segment registers with our descriptors */
 	movl	$__BOOT_DS, %eax
@@ -355,9 +356,9 @@ SYM_CODE_START(startup_64)
 	 */
 
 	/* Make sure we have GDT with 32-bit code segment */
-	leaq	gdt(%rip), %rax
-	movq	%rax, gdt64+2(%rip)
-	lgdt	gdt64(%rip)
+	leaq	gdt64(%rip), %rax
+	addq	%rax, 2(%rax)
+	lgdt	(%rax)
 
 	/*
 	 * paging_prepare() sets up the trampoline and checks if we need to
@@ -625,12 +626,12 @@ SYM_FUNC_END(.Lno_longmode)
 	.data
 SYM_DATA_START_LOCAL(gdt64)
 	.word	gdt_end - gdt - 1
-	.quad   0
+	.quad   gdt - gdt64
 SYM_DATA_END(gdt64)
 	.balign	8
 SYM_DATA_START_LOCAL(gdt)
 	.word	gdt_end - gdt - 1
-	.long	gdt
+	.long	0
 	.word	0
 	.quad	0x00cf9a000000ffff	/* __KERNEL32_CS */
 	.quad	0x00af9a000000ffff	/* __KERNEL_CS */
-- 
2.24.1

