Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBFB313282D
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 14:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgAGNzD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 08:55:03 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44864 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgAGNzD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 08:55:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id t3so45305589qtr.11
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 05:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8DIlTol7VfvqPXPJ+MmSCXSz7MiPOkqmGWsZfDKmVY=;
        b=A2iZ2dff3Dq45T7nZlJC+vSNzJpAHCxnM+qg3OXpMuqqjFCI7Ah06PuND89Ufp6IEU
         cqHZ4s/cD9Myjljj9kkwnrCPXIpbiNWsgSryNUMFyyrTI2/UgnnmMZWwTKaZ9w+Jjm+i
         eLOhMmnHlQwfvqS9v8muUHQ3OBZN8auK3lhu/mQzDXZr3kP4YD2Rwtmid8ji0+vx+Vgr
         vlMnyLPMX+LSADYUYb6fZJxBYQwqhAqmPoJCm16YYUkDvKLDLSTm+NVAldeiRUvOPDdC
         Fo8GSmImN/+D14W43tDNFv8/+UShsVPae6hnsdGj8ztN33PzxFGFHIM2Hg8z6OQ4yRsv
         18cQ==
X-Gm-Message-State: APjAAAUBaTzt83F9pGV0hoGMGSfF/xaDEE58PbCpYlMjBeByx3cH3VcB
        MHSKNSWvgBicTYmalvPT2xE=
X-Google-Smtp-Source: APXvYqw8C55/C1C2Cc0NSTkKw7BtX1LuZLC5XHyWSIk1h2eZ0KrwD3ZCJ8P/TMdnIuNbY6YvSTxBqQ==
X-Received: by 2002:ac8:3703:: with SMTP id o3mr78978487qtb.208.1578405302177;
        Tue, 07 Jan 2020 05:55:02 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v24sm25080627qtq.14.2020.01.07.05.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:55:01 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 1/3] x86/boot/compressed/64: Make adjust_got easier to use repeatedly
Date:   Tue,  7 Jan 2020 08:54:58 -0500
Message-Id: <20200107135500.644618-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107135500.644618-1-nivedita@alum.mit.edu>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Get the new relocation base address inside adjust_got, and save it so
that the caller doesn't have to figure it out.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_64.S | 58 +++++++++++++-----------------
 1 file changed, 24 insertions(+), 34 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1f1f6c8139b3..1464d8d0ec66 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -312,20 +312,7 @@ SYM_CODE_START(startup_64)
 	/*
 	 * paging_prepare() and cleanup_trampoline() below can have GOT
 	 * references. Adjust the table with address we are running at.
-	 *
-	 * Zero RAX for adjust_got: the GOT was not adjusted before;
-	 * there's no adjustment to undo.
 	 */
-	xorq	%rax, %rax
-
-	/*
-	 * Calculate the address the binary is loaded at and use it as
-	 * a GOT adjustment.
-	 */
-	call	1f
-1:	popq	%rdi
-	subq	$1b, %rdi
-
 	call	.Ladjust_got
 
 	/*
@@ -412,21 +399,6 @@ trampoline_return:
 	pushq	$0
 	popfq
 
-	/*
-	 * Previously we've adjusted the GOT with address the binary was
-	 * loaded at. Now we need to re-adjust for relocation address.
-	 *
-	 * Calculate the address the binary is loaded at, so that we can
-	 * undo the previous GOT adjustment.
-	 */
-	call	1f
-1:	popq	%rax
-	subq	$1b, %rax
-
-	/* The new adjustment is the relocation address */
-	movq	%rbx, %rdi
-	call	.Ladjust_got
-
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -475,6 +447,12 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	shrq	$3, %rcx
 	rep	stosq
 
+/*
+ * Previously we've adjusted the GOT with address the binary was
+ * loaded at. Now we need to re-adjust for relocation address.
+ */
+	call	.Ladjust_got
+
 /*
  * Do the extraction, and jump to the new kernel..
  */
@@ -497,23 +475,33 @@ SYM_FUNC_END(.Lrelocated)
 /*
  * Adjust the global offset table
  *
- * RAX is the previous adjustment of the table to undo (use 0 if it's the
- * first time we touch GOT).
- * RDI is the new adjustment to apply.
+ * The relocation base address calculation uses RIP-relative addressing, so if
+ * the kernel is being relocated to a new address, this function must be called
+ * after execution has been passed to the new location. We keep track of the
+ * relocation address so that it can be backed out if this function is called
+ * repeatedly.
  */
-.Ladjust_got:
+
+SYM_FUNC_START_LOCAL(.Ladjust_got)
+	/* Get the new relocation base address */
+	leaq	startup_32(%rip), %rax
+	/* Backout the previous relocation address if any */
+	subq	got_relocation_base(%rip), %rax
+	/* Store the relocation base address for future reference */
+	addq	%rax, got_relocation_base(%rip)
+
 	/* Walk through the GOT adding the address to the entries */
 	leaq	_got(%rip), %rdx
 	leaq	_egot(%rip), %rcx
 1:
 	cmpq	%rcx, %rdx
 	jae	2f
-	subq	%rax, (%rdx)	/* Undo previous adjustment */
-	addq	%rdi, (%rdx)	/* Apply the new adjustment */
+	addq	%rax, (%rdx)	/* Apply the incremental adjustment */
 	addq	$8, %rdx
 	jmp	1b
 2:
 	ret
+SYM_FUNC_END(.Ladjust_got)
 
 	.code32
 /*
@@ -628,6 +616,8 @@ SYM_DATA_START_LOCAL(gdt)
 	.quad   0x0000000000000000	/* TS continued */
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
+SYM_DATA_LOCAL(got_relocation_base, .quad 0)
+
 #ifdef CONFIG_EFI_MIXED
 SYM_DATA_LOCAL(efi32_boot_args, .long 0, 0)
 SYM_DATA(efi_is64, .byte 1)
-- 
2.24.1

