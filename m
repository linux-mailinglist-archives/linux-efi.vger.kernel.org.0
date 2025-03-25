Return-Path: <linux-efi+bounces-3085-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2C3A7057A
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 16:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110973BB7FF
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9B25BAD6;
	Tue, 25 Mar 2025 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3+mul1B"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA4E25BABA;
	Tue, 25 Mar 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917547; cv=none; b=N8FQVJNHicYvfdJcu/wYre5m6OvAPKT593mOMAhKGIK3MEOG6hGnAdzlPKAgeOYGV8xBzVdW/OINa6SRxRxAXRSVb7Guv+H2aY+eZC+ui6FDGkC77hQfapIkpfgN71o94VVXJFVtyA7LQHsoqS1Bl75b3qDJOuzzuf/5uk7Pp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917547; c=relaxed/simple;
	bh=xVCx2kciP/eq/LO5hKJChVYRZx47bjD2BczzGnahD9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzuhl83J5Nlcmbi7sLtoMQ7IildwGXChxJbUsWCZqolYorbUYHEjZ5BVIRmQyHp087tOkbgSYPhI5wAVHntHIOtKYZ9CrZlQjXWQRGbTKD95P6b84kW0J2d1H61sOOVai4HkUS4evcajIwMMhrqZhh0eN/pA0PLSKVUqmiOxrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3+mul1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049A0C4CEF1;
	Tue, 25 Mar 2025 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917546;
	bh=xVCx2kciP/eq/LO5hKJChVYRZx47bjD2BczzGnahD9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j3+mul1B2B616Ow0fu3XYA8oZCiKaJB13Q8/KHhLIGGTVhfu3WhYy4d6YFfY+Upo6
	 8I1YXzSXD7tKrMEOQdJB2Wl3NSq1OhZ8JXp9hXJ8cRgx3sqInJ58J9VGRSITJP3NgZ
	 Vg7WZ66uCvuA0mBfmXMjSJjdpKoScY5H/kBaypQdHyTqOKlTH+gkzRaGIjzv/kRBWM
	 BNfR9eHh3t+vkLygqOwrOLBGPSDSsFBVXEl7rkeCRAW20TGN5X51z3abNij8eONKXk
	 7KRku3GVkCkKpDbEyooIdi+0DZK7RG1Tju0K7kjiFZ5P5VjInhuLq8yj5P/ciRNU2i
	 nga+c5cHXDRsw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 25 Mar 2025 08:45:19 -0700
Subject: [PATCH RFC 2/2] wcslen() prototype in string.h
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
In-Reply-To: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 linux-efi@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3349; i=nathan@kernel.org;
 h=from:subject:message-id; bh=xVCx2kciP/eq/LO5hKJChVYRZx47bjD2BczzGnahD9o=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmPzi/6svQ4k8Dxq/xirT+S42+WK99wP7JxJ6PDo6Un9
 596Zysp0lHKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAm4uvP8D/CZ6PjhDlGi/0m
 LdGR/f54W+qPkifaP8XZKtQfrv767psTI8N6949nvwo+/d92LvZhbtbF3zqvWpQqj81deu9W4em
 Yu/wMAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

If this is desired, it should be squashed into the previous change. I
wrote it separately because it is slightly more invasive.

In order to export wcslen() to the rest of the kernel (should it ever be
necessary elsewhere), it needs to be added to string.h, along with nls.h
for the typedef of wchar_t. However, dragging in nls.h into string.h
causes an error in the efistub due to a conflicting function name:

  drivers/firmware/efi/libstub/printk.c:27:5: error: static declaration of 'utf8_to_utf32' follows non-static declaration
     27 | u32 utf8_to_utf32(const u8 **s8)
        |     ^
  include/linux/nls.h:55:12: note: previous declaration is here
     55 | extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
        |            ^
  drivers/firmware/efi/libstub/printk.c:85:26: error: too few arguments to function call, expected 3, have 1
     85 |                 c32 = utf8_to_utf32(&s8);
        |                       ~~~~~~~~~~~~~    ^
  include/linux/nls.h:55:12: note: 'utf8_to_utf32' declared here
     55 | extern int utf8_to_utf32(const u8 *s, int len, unicode_t *pu);
        |            ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  2 errors generated.

Rename the efi function to avoid the conflict.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/efi/libstub/printk.c | 4 ++--
 include/linux/string.h                | 2 ++
 lib/string.c                          | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
index 3a67a2cea7bd..334f7e89845c 100644
--- a/drivers/firmware/efi/libstub/printk.c
+++ b/drivers/firmware/efi/libstub/printk.c
@@ -24,7 +24,7 @@ void efi_char16_puts(efi_char16_t *str)
 }
 
 static
-u32 utf8_to_utf32(const u8 **s8)
+u32 efi_utf8_to_utf32(const u8 **s8)
 {
 	u32 c32;
 	u8 c0, cx;
@@ -82,7 +82,7 @@ void efi_puts(const char *str)
 	while (*s8) {
 		if (*s8 == '\n')
 			buf[pos++] = L'\r';
-		c32 = utf8_to_utf32(&s8);
+		c32 = efi_utf8_to_utf32(&s8);
 		if (c32 < 0x10000) {
 			/* Characters in plane 0 use a single word. */
 			buf[pos++] = c32;
diff --git a/include/linux/string.h b/include/linux/string.h
index 0403a4ca4c11..45e01cf3434c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -7,6 +7,7 @@
 #include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
+#include <linux/nls.h>		/* for wchar_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
@@ -203,6 +204,7 @@ extern __kernel_size_t strlen(const char *);
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
+extern __kernel_size_t wcslen(const wchar_t *s);
 #ifndef __HAVE_ARCH_STRPBRK
 extern char * strpbrk(const char *,const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index bbee8a9e4d83..1aa09925254b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -430,7 +430,6 @@ size_t strnlen(const char *s, size_t count)
 EXPORT_SYMBOL(strnlen);
 #endif
 
-size_t wcslen(const wchar_t *s);
 size_t wcslen(const wchar_t *s)
 {
 	const wchar_t *sc;

-- 
2.49.0


