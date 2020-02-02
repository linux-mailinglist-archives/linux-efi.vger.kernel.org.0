Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B314FE76
	for <lists+linux-efi@lfdr.de>; Sun,  2 Feb 2020 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgBBRN5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Feb 2020 12:13:57 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37652 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgBBRN4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Feb 2020 12:13:56 -0500
Received: by mail-qv1-f67.google.com with SMTP id m5so5752164qvv.4;
        Sun, 02 Feb 2020 09:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q419w+Z0eYH/xup1ze4RA454IgNGmIixnAmzVCRraRE=;
        b=e9c3RHkhNs0OSZX7qoxEjZMiQqC08RPoITaLn6fm4C4sY2YXQLYEAdjfN2DTW2t5dD
         e1V4o4ILQfvU1EdCmWGmIrWo09ibaSd9w6fb0+XOIHlwIGXCawEhq032RuYAloL+8utB
         btNco8tu45iUESPux4iHiUr+KYs84IkDzGZ3uEAMzCjKp3tfdd+U8XdMcoVJ6ibjp4eL
         ZxWYfIOXkrmj5GfwygMXMxf57iHM5LBKnN+2qu9TP8jKTQCh7o9mQk27FUxRv/xApQBJ
         mLviT5A9X/W6pXlsN8JoesrKUtJQnR936F7gRvSGwUBoTdgSEk5kpXFNpe6+iIOmzxAF
         SIdQ==
X-Gm-Message-State: APjAAAVdPnv9kal0jTeBriBCOD8zjQMfkQxLd/iSVEhyAtA8k7BThcUh
        Dvw8hQ02sZQzBFeWN61jwEWSSAIu
X-Google-Smtp-Source: APXvYqwYOYA/+EJvxQq+k3scPXXUmpEDAp+buYn1L+Sr11b809s7ctxY6xE37J08pNOJnOZHGLD8Ig==
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr20086788qvb.122.1580663635408;
        Sun, 02 Feb 2020 09:13:55 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 3sm8150081qte.59.2020.02.02.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 09:13:55 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] x86/boot: Remove KEEP_SEGMENTS support
Date:   Sun,  2 Feb 2020 12:13:47 -0500
Message-Id: <20200202171353.3736319-2-nivedita@alum.mit.edu>
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

Commit a24e785111a3 ("i386: paravirt boot sequence") added this flag for
use by paravirtualized environments such as Xen. However, Xen never made
use of this flag [1], and it was only ever used by lguest [2].

Commit ecda85e70277 ("x86/lguest: Remove lguest support") removed
lguest, so KEEP_SEGMENTS has lost its last user.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
[1] https://lore.kernel.org/lkml/4D4B097C.5050405@goop.org
[2] https://www.mail-archive.com/lguest@lists.ozlabs.org/msg00469.html
---
 Documentation/x86/boot.rst         | 8 ++------
 arch/x86/boot/compressed/head_32.S | 8 --------
 arch/x86/boot/compressed/head_64.S | 8 --------
 arch/x86/kernel/head_32.S          | 6 ------
 4 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index c9c201596c3e..fa7ddc0428c8 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -490,15 +490,11 @@ Protocol:	2.00+
 		kernel) to not write early messages that require
 		accessing the display hardware directly.
 
-  Bit 6 (write): KEEP_SEGMENTS
+  Bit 6 (obsolete): KEEP_SEGMENTS
 
 	Protocol: 2.07+
 
-	- If 0, reload the segment registers in the 32bit entry point.
-	- If 1, do not reload the segment registers in the 32bit entry point.
-
-		Assume that %cs %ds %ss %es are all set to flat segments with
-		a base of 0 (or the equivalent for their environment).
+        - This flag is obsolete.
 
   Bit 7 (write): CAN_USE_HEAP
 
diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 73f17d0544dd..cb2cb91fce45 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -63,13 +63,6 @@
 	__HEAD
 SYM_FUNC_START(startup_32)
 	cld
-	/*
-	 * Test KEEP_SEGMENTS flag to see if the bootloader is asking
-	 * us to not reload segments
-	 */
-	testb	$KEEP_SEGMENTS, BP_loadflags(%esi)
-	jnz	1f
-
 	cli
 	movl	$__BOOT_DS, %eax
 	movl	%eax, %ds
@@ -77,7 +70,6 @@ SYM_FUNC_START(startup_32)
 	movl	%eax, %fs
 	movl	%eax, %gs
 	movl	%eax, %ss
-1:
 
 /*
  * Calculate the delta between where we were compiled to run
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 1f1f6c8139b3..bd44d89540d3 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -53,19 +53,11 @@ SYM_FUNC_START(startup_32)
 	 * all need to be under the 4G limit.
 	 */
 	cld
-	/*
-	 * Test KEEP_SEGMENTS flag to see if the bootloader is asking
-	 * us to not reload segments
-	 */
-	testb $KEEP_SEGMENTS, BP_loadflags(%esi)
-	jnz 1f
-
 	cli
 	movl	$(__BOOT_DS), %eax
 	movl	%eax, %ds
 	movl	%eax, %es
 	movl	%eax, %ss
-1:
 
 /*
  * Calculate the delta between where we were compiled to run
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 3923ab4630d7..f66a6b90f954 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -67,11 +67,6 @@ __HEAD
 SYM_CODE_START(startup_32)
 	movl pa(initial_stack),%ecx
 	
-	/* test KEEP_SEGMENTS flag to see if the bootloader is asking
-		us to not reload segments */
-	testb $KEEP_SEGMENTS, BP_loadflags(%esi)
-	jnz 2f
-
 /*
  * Set segments to known values.
  */
@@ -82,7 +77,6 @@ SYM_CODE_START(startup_32)
 	movl %eax,%fs
 	movl %eax,%gs
 	movl %eax,%ss
-2:
 	leal -__PAGE_OFFSET(%ecx),%esp
 
 /*
-- 
2.24.1

