Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1B76170C13
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 00:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgBZXAe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 18:00:34 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34395 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgBZXAe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 18:00:34 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so661983qvf.1;
        Wed, 26 Feb 2020 15:00:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2Z5RXhPBPSH5s6BhEsyCrcYpDZ4Af1ge3xB8VWs430=;
        b=A+fe8+cvLa4z3bup8ukiPGOS8V4ORL8iXCHgLxi2lBr5MtX+NpLBgxen7N6dk9XE41
         QjCvEIECn6AJd1DioBdE3ZNZhP6BT3g3T+lpUWJEUEhUX3LzqmbhT0YxbQV1oKrvKTpq
         Su48q9bFyvVWni6XIsQ9JqVePu/UbwTHe8WL6ytUCrXV+mMXpGOFvIJHElpWSUrF2Xcb
         Zg+/znfs6WAqt7nhEz86WHSjjGQ2f/nQjMOcIw2d2t6TLf2joyE60mERg9YMdE2JfL2N
         CiFf2+AExBZ/Wq3rd34RDctM7NE2LAinP7oRQuNxGQuC78hygOr8sjyp8gnbdMWdB/8h
         I1Hg==
X-Gm-Message-State: APjAAAXLJCK64of3eo3AiG/p4xz5BQZB1acGuTBwYgoCW9W/xnQV1kWY
        bmcSH6BvAmZmSPGKVlCeV2j8MTseoiA=
X-Google-Smtp-Source: APXvYqwQDvebgWRZcR5rgX9WQUAm6ZWjwlM4Ts/rzEDjCkMXq76uPkMByJWCZLIUBeBGn8eMUl4O/w==
X-Received: by 2002:a0c:c24f:: with SMTP id w15mr1650989qvh.66.1582758032999;
        Wed, 26 Feb 2020 15:00:32 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t2sm1965323qkc.31.2020.02.26.15.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:00:32 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR post-relocation
Date:   Wed, 26 Feb 2020 18:00:31 -0500
Message-Id: <20200226230031.3011645-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226204515.2752095-1-nivedita@alum.mit.edu>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
introduced GDT setup into the 32-bit kernel's startup_32, and reloads
the GDTR after relocating the kernel for paranoia's sake.

Commit 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of
the buffer") introduced a similar GDTR reload in the 64-bit kernel.

The GDTR is adjusted by init_size - _end, however this may not be the
correct offset to apply if the kernel was loaded at a misaligned address
or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
has an additional offset from the original load address.

This should never happen for a conformant bootloader, but we're being
paranoid anyway, so just store the new GDT address in there instead of
adding any offsets, which is simpler as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
Fixes: 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of the buffer")
---
 arch/x86/boot/compressed/head_32.S | 9 ++++-----
 arch/x86/boot/compressed/head_64.S | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 356060c5332c..2f8138b71ea9 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -139,12 +139,11 @@ SYM_FUNC_START(startup_32)
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
 	 * during extract_kernel below. To avoid any issues, repoint the GDTR
-	 * to the new copy of the GDT. EAX still contains the previously
-	 * calculated relocation offset of init_size - _end.
+	 * to the new copy of the GDT.
 	 */
-	leal	gdt(%ebx), %edx
-	addl	%eax, 2(%edx)
-	lgdt	(%edx)
+	leal	gdt(%ebx), %eax
+	movl	%eax, 2(%eax)
+	lgdt	(%eax)
 
 /*
  * Jump to the relocated address.
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index f7bacc4c1494..fcf8feaa57ea 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -456,8 +456,8 @@ trampoline_return:
 	 * to the new copy of the GDT.
 	 */
 	leaq	gdt64(%rbx), %rax
-	subq	%rbp, 2(%rax)
-	addq	%rbx, 2(%rax)
+	leaq	gdt(%rbx), %rdx
+	movq	%rdx, 2(%rax)
 	lgdt	(%rax)
 
 /*
-- 
2.24.1

