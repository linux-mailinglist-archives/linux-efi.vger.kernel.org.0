Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9881709F9
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 21:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBZUpT (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Feb 2020 15:45:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41544 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbgBZUpS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Feb 2020 15:45:18 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so574279qtr.8;
        Wed, 26 Feb 2020 12:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzShkJtnyIf+SHrtUdVXXyo8uuVvUhx7/kmHbI9SwSg=;
        b=i+a+d3HCgax6Bu00dAjuaBfr1Ot+zdAKV0hNW3rSUt2SsAXKckS9BEles6wyssgRXD
         YEOpZxqoFcWZFncUegy6txmhQTUwjL+nsXTmKsEpv8vR8+kQ+ke1/l5/RuBf+m7TUbSe
         3ldahMe2Uo8RVZ+QyG1tzRVYxcmd8WV9CWu8viWLgXUv5Dbkm0cgksBA+ogbSupOqsOl
         /LkM7U2XilWsGEk5ppHfrXnulZSq+9t2O0HR3gObOqTcmV68tyu/CNEJvroBP4heclot
         TugLYEOX3qDdOwGHfP9mN6l5FAmH7RnD38e30qNrgTPonSf/xXWbzX+1biqWl01rEVdV
         ZKwQ==
X-Gm-Message-State: APjAAAXQgenoyPYdd4GC/2LH4sMig7IKkJpJa3QrRIOzGsuqvtSci02V
        W12oLCZbQZMubBFQuQ0CATc=
X-Google-Smtp-Source: APXvYqynbCOGvAYcg8lS9ckg8xbs2hHroICLoNo9zlara5eesVg52BAnnrkrhVysywedoDcYP0z5zg==
X-Received: by 2002:aed:2a05:: with SMTP id c5mr724563qtd.361.1582749917618;
        Wed, 26 Feb 2020 12:45:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f26sm1651452qtv.77.2020.02.26.12.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:45:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/boot/compressed/32: Fix reloading of GDTR post-relocation
Date:   Wed, 26 Feb 2020 15:45:15 -0500
Message-Id: <20200226204515.2752095-2-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200226142713.GB3100@gmail.com>
References: <20200226142713.GB3100@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
introduced GDT setup into startup_32, and reloads the GDTR after
relocating the kernel for paranoia's sake.

The GDTR is adjusted by init_size - _end, however this may not be the
correct offset to apply if the kernel was loaded at a misaligned address
or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
has an additional offset from the original load address.

This should never happen for a conformant bootloader, but we're being
paranoid anyway, so just store the new GDT address in there instead of
adding any offsets, which is simpler as well.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
---
 arch/x86/boot/compressed/head_32.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

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
-- 
2.24.1

