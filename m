Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4770E12D321
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 19:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfL3SJb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 13:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfL3SJa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Dec 2019 13:09:30 -0500
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net [91.167.84.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FF22071E;
        Mon, 30 Dec 2019 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577729370;
        bh=Yy+0Y26bNsBKW5pM0oJe/s001o5+q6lON5VgSvebl0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPd8E/iqxqzBwHzSx5ToR5RNKaBgU8oLITLGBs6JbEmZNEmKhPJyeG0YqBb+9NmVG
         d7YMwlSksRJicxtoAjFdD1z/ZlSDu4j0tY+eFUFldnO7Cmk1HGolqI+zQhnLJpQ7iX
         K2DgmRkmGrraXYMqLix0RK3T8swcZjMu3f7YL8gw=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 05/14] efi/x86: avoid redundant cast of EFI firmware service pointer
Date:   Mon, 30 Dec 2019 19:08:25 +0100
Message-Id: <20191230180834.75601-6-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191230180834.75601-1-ardb@kernel.org>
References: <20191230180834.75601-1-ardb@kernel.org>
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

