Return-Path: <linux-efi+bounces-3091-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6725A70C54
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 22:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92BE7A351C
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951971DD0F6;
	Tue, 25 Mar 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLIa4DHk"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625F219F422;
	Tue, 25 Mar 2025 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742939121; cv=none; b=ekzG9GeEWpWwHEOVFFaGpfqjrHepwyDeHn6U6OYkz1mAeB4ZxwJ7h3gspnaDXZf2SF43C5bP7xvCFFO/uymPxRL/Um1R0X8/v/GvcGT2VstSoc6gyDVybir5s+zjUu3H367wnWv/vAj7YqZvonyL+N7T9aYXaq/v+K/TBIwYPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742939121; c=relaxed/simple;
	bh=rDdLVVOB1kS1Rur+co5d17dcdxdeV+fdRJuaWwVbsuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCGLrwOcAhuW7BqiZYFj4IJyJ7nQ5lmEDC7MwdNsnWeZVFPqmIH8cc25t6iDZxkFBL6AkJAchlcI1Ryb5jjWDL9UBdLRGUk8FM7ETpyRrDy7jHuHrNWOGZkQoOKRyCv6I+kNf6H3I9b9HvG9pTKm+a1DuInwwhhyM/TBfOfbwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLIa4DHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB043C4CEE9;
	Tue, 25 Mar 2025 21:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742939120;
	bh=rDdLVVOB1kS1Rur+co5d17dcdxdeV+fdRJuaWwVbsuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLIa4DHkHu6DZUzJ7CVPddiUkvWsIOiF5FxQZabr9XLtulzdbDbAcTzYSk4t3bwff
	 fL16Cj00rxs5iw/B3tlh+4c+lX+8qBz9ZIu8yto0AvURVKOdZdweCpRcmPRS+UTgMt
	 Vnsmaj2R4ykyNtr6dHqLJtkkunoPGZcXVkBrXySAjNmqWxSTgMfD/TtbtmLTlqs4SC
	 ar/TtJ9JnjHpNxNQ9AByKrCO6gSpujk4AkQ9LypD8CP1wgBZRZ5giznshuO0bWdnyf
	 2qnDR1rhwwG54j1Yqt6y8t9aiVN9tOZpZmjZCBLbexmYOHm6woI5N/CtzXTBIazeX7
	 nxlz8s0mckJ+w==
Date: Tue, 25 Mar 2025 14:45:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andy@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] wcslen() prototype in string.h
Message-ID: <20250325214516.GA672870@ax162>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
 <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>

On Tue, Mar 25, 2025 at 07:05:28PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 25, 2025 at 09:58:47AM -0700, Nathan Chancellor wrote:
> > On Tue, Mar 25, 2025 at 06:17:34PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 25, 2025 at 08:45:19AM -0700, Nathan Chancellor wrote:
> 
> ...
> 
> > > > Rename the efi function to avoid the conflict.
> > > 
> > > Hmm... Why not split this to two, rename patch as a standalone makes sense to
> > > me even outside of this series.
> > 
> > How so? If nls.h is not included in printk.c via string.h, which does
> > not happen without this series, what value does the rename have? I do
> > not mind splitting it up that way to keep things cleaner, I am just
> > wondering what would be the justification in the changelog (I guess just
> > that nls.h may get included in the future for some reason)?
> 
> Inside this series the justification is obvious (a.k.a. the same), outside
> yes something like "Put EFI specific function to the respective namespace
> to avoid potential clash in the future when including another header."

Okay, sounds reasonable to me. This is what I ended up with for that
change, which will become patch one of the series.

From f79267c05d2853c034e2c490f171aed064b85dd6 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 25 Mar 2025 14:31:25 -0700
Subject: [PATCH] efi: libstub: Rename utf8_to_utf32() to avoid collision with
 NLS version

A future change will add nls.h to string.h, which will break the libstub
build because NLS includes its own version of utf8_to_utf32():

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

Rename the libstub version since it is static to avoid the conflict.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/efi/libstub/printk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.49.0

Then the first patch (which becomes the second) becomes:

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
index eb4486ed40d2..1aa09925254b 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
+#include <linux/nls.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -429,6 +430,16 @@ size_t strnlen(const char *s, size_t count)
 EXPORT_SYMBOL(strnlen);
 #endif
 
+size_t wcslen(const wchar_t *s)
+{
+	const wchar_t *sc;
+
+	for (sc = s; *sc != '\0'; ++sc)
+		/* nothing */;
+	return sc - s;
+}
+EXPORT_SYMBOL(wcslen);
+
 #ifndef __HAVE_ARCH_STRSPN
 /**
  * strspn - Calculate the length of the initial substring of @s which only contain letters in @accept
---

with basically the same changelog.

I will send v2 either tomorrow afternoon or Thursday morning to give a
little more time for initial review/comments.

Thanks for the quick feedback!

Cheers,
Nathan

