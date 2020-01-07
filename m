Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF513282E
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 14:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgAGNzE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 08:55:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34642 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgAGNzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 08:55:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id j9so43073970qkk.1
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 05:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eEdhvqqtbIEdCjPrLHBVq1s26D1JC0+naL1HgMgDiME=;
        b=UP9rNRGRgJBUU0gYLRDM++kr0wV0f/3W3k0t73xzxf5Q1xJF7xuFvHZCJRPd6nISfd
         fFgEl84I5zvXmKFuLanUQGBTqEpzLzlGisvNl8ZMUkJKCE4wwlst/BppPDjL2vo7YdsU
         1S/c9NH/X270x863Ly4/Izp7J3gyel/ZQ83NWrRkWQvhqOOW35BRj4MCOygcKycJ2UV6
         YCZiHT8IcHHoq0YTjtPXTAQSkItj2kl3TbsQGnkcfdYKRR5rxVEAyiK5wkbZLj2KdWP8
         p6wVgIC71X39M606tZs1X8/KsRE5zh1kMP0h+D9jKJBkepypW2tw8asWwKBhum4V/pCW
         HWIw==
X-Gm-Message-State: APjAAAW9JuyB6ahNjFFImXhee0Q2G+5cK0KTI8RxCZWOEGOb2qOqJkrk
        YK9tfNyprO7TrAHHfAkzxQ8=
X-Google-Smtp-Source: APXvYqwxbh5c4d1sq6Jmy6VQ7RLidbAdt04ud2Z7xkgjDWx/6M7HlbrgCEkxtCO3R03snxopwOZdxw==
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr85347835qkg.43.1578405302893;
        Tue, 07 Jan 2020 05:55:02 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v24sm25080627qtq.14.2020.01.07.05.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:55:02 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 2/3] x86/boot/compressed/32: Allow adjust_got to be called repeatedly
Date:   Tue,  7 Jan 2020 08:54:59 -0500
Message-Id: <20200107135500.644618-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107135500.644618-1-nivedita@alum.mit.edu>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Save the new relocation address so that this function can be called
safely multiple times.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/head_32.S | 42 +++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index e43ac17cb9fb..973ac0b51af5 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -173,15 +173,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 /*
  * Adjust our own GOT
  */
-	leal	_got(%ebx), %edx
-	leal	_egot(%ebx), %ecx
-1:
-	cmpl	%ecx, %edx
-	jae	2f
-	addl	%ebx, (%edx)
-	addl	$4, %edx
-	jmp	1b
-2:
+	call	.Ladjust_got
 
 /*
  * Do the extraction, and jump to the new kernel..
@@ -211,6 +203,38 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
 	jmp	*%eax
 SYM_FUNC_END(.Lrelocated)
 
+/*
+ * Adjust the global offset table
+ *
+ * The relocation base address is passed in EBX. If the kernel is being
+ * relocated to a new address, this function must be called after the kernel
+ * has been copied to the new location. We keep track of the relocation address
+ * so that it can be backed out if this function is called repeatedly.
+ */
+
+SYM_FUNC_START_LOCAL(.Ladjust_got)
+	/* Get the new relocation base address */
+	movl	%ebx, %eax
+	/* Backout the previous relocation address if any */
+	subl	got_relocation_base(%ebx), %eax
+	/* Store the relocation base address for future reference */
+	addl	%eax, got_relocation_base(%ebx)
+
+	leal	_got(%ebx), %edx
+	leal	_egot(%ebx), %ecx
+1:
+	cmpl	%ecx, %edx
+	jae	2f
+	addl	%eax, (%edx)
+	addl	$4, %edx
+	jmp	1b
+2:
+	ret
+SYM_FUNC_END(.Ladjust_got)
+
+	.data
+SYM_DATA_LOCAL(got_relocation_base, .long 0)
+
 /*
  * Stack and heap for uncompression
  */
-- 
2.24.1

