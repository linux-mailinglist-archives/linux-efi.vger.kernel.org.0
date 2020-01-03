Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9730B12F771
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgACLk3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgACLk1 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:27 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C66B22314;
        Fri,  3 Jan 2020 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051626;
        bh=Yy+0Y26bNsBKW5pM0oJe/s001o5+q6lON5VgSvebl0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2Eexyl5EQImX/YyREv+qTf2pRTcYk0EFNNc1DA+7PteX+s0KvoQH67gnjo1iHzg7
         FW+BvYzccW/tnp8/QhqycRdjVam3n8H8op4qpNl8OLrMY4WxNfD79yBdoxP+LeucSg
         q3ehJSBPeI1vZiSvpB0qOTooI+09HIJ8yGRUEx9U=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 05/20] efi/x86: avoid redundant cast of EFI firmware service pointer
Date:   Fri,  3 Jan 2020 12:39:38 +0100
Message-Id: <20200103113953.9571-6-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

All EFI firmware call prototypes have been annotated as __efiapi,
permitting us to attach attributes regarding the calling convention
by overriding __efiapi to an architecture specific value.

On 32-bit x86, EFI firmware calls use the plain calling convention
where all arguments are passed via the stack, and cleaned up by the
caller. Let's add this to the __efiapi definition so we no longer
need to cast the function pointers before invoking them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h | 8 +-------
 include/linux/efi.h        | 4 +++-
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index b35b5d423e9d..09c3fc468793 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -51,13 +51,7 @@ extern asmlinkage unsigned long efi_call_phys(void *, ...);
 })
 
 
-/*
- * Wrap all the virtual calls in a way that forces the parameters on the stack.
- */
-#define arch_efi_call_virt(p, f, args...)				\
-({									\
-	((efi_##f##_t __attribute__((regparm(0)))*) p->f)(args);	\
-})
+#define arch_efi_call_virt(p, f, args...)	p->f(args)
 
 #define efi_ioremap(addr, size, type, attr)	ioremap_cache(addr, size)
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 726673e98990..952c1659dfd9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,8 +48,10 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64)
 #define __efiapi __attribute__((ms_abi))
+#elif defined(CONFIG_X86_32)
+#define __efiapi __attribute__((regparm(0)))
 #else
 #define __efiapi
 #endif
-- 
2.20.1

