Return-Path: <linux-efi+bounces-3092-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97A8A70E3C
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 01:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5384E189B099
	for <lists+linux-efi@lfdr.de>; Wed, 26 Mar 2025 00:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828717597;
	Wed, 26 Mar 2025 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmOL0bL9"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB818035;
	Wed, 26 Mar 2025 00:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949188; cv=none; b=TjKSkRx0iqT7cfGbPxDOrmG/xRbEOFGLmR/M1HKFEsPu/Dm8X89N2/5olldmXvCaTIfDfuveiOBGAoTDvqvXn3MjG+iY0w4oEijAbIkKAWgL7X8KC5KR1eDKSQ1m6/iyxFWBadCPqmgOYlWaWgAySgBibK9E8e9jEmdVlRNvSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949188; c=relaxed/simple;
	bh=Pp6Sv1svN0R+5ALGT58L3atxeP++biFN0Qd6UhpdUwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT8ZP8WglGiPE/wGx8TsvHiq4VPdwdbC4wcIH78fa+o7UB83kyCL+NJg8i0Uk/f+pr0tcnQNRqtNGse5uthviMI6PyP/ebIO2Vx8tYw4A756CufjLIsBZlh9tBIgjKC0Sd5ldK8M2sW3dyxqhq/1tZMPGtEfY+CM28Crzxj+inI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmOL0bL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C56C4CEE4;
	Wed, 26 Mar 2025 00:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742949188;
	bh=Pp6Sv1svN0R+5ALGT58L3atxeP++biFN0Qd6UhpdUwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmOL0bL9dyQGD3ksmImeJ7yNFrkhfxtvZjm3qZdlfSLpW/wPnnYbeaCoaSTYaAEWB
	 2bHokC+5jNqL2J8aFT4b/2AxHvP/qhRPX1B7WNeZxp2CVIkCyxoQ+lwYzsSRzRFYgr
	 1sd7dsGMUdcNxLbD0/B5j928pXelikVH8gWVwZkfFhl2pxZmoLTKboV0yja3iIz6rn
	 BpRcbo5TiN4Cc/ORDAeGiLIOvo7REHEaGx5LkkDQi0XCrOPHOCkFoiFhVW/XewfU/I
	 AvffqEky0rIJMWTn6T9YLQeyoD6ITuxPfNRF5279Lz3SpO/WOPTv5XQzwavGywNs5n
	 sPhMxAlAPtq2Q==
Date: Tue, 25 Mar 2025 17:33:03 -0700
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
Message-ID: <20250326003303.GA2394@ax162>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
 <20250325-string-add-wcslen-for-llvm-opt-v1-2-b8f1e2c17888@kernel.org>
 <Z-LXHssrcpdtFqqn@smile.fi.intel.com>
 <20250325165847.GA2603000@ax162>
 <Z-LiWDbrEvVaTLZU@smile.fi.intel.com>
 <20250325214516.GA672870@ax162>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325214516.GA672870@ax162>

On Tue, Mar 25, 2025 at 02:45:21PM -0700, Nathan Chancellor wrote:
> Okay, sounds reasonable to me. This is what I ended up with for that
> change, which will become patch one of the series.
...
> diff --git a/drivers/firmware/efi/libstub/printk.c b/drivers/firmware/efi/libstub/printk.c
> index 3a67a2cea7bd..334f7e89845c 100644
> --- a/drivers/firmware/efi/libstub/printk.c
> +++ b/drivers/firmware/efi/libstub/printk.c
> @@ -24,7 +24,7 @@ void efi_char16_puts(efi_char16_t *str)
>  }
>  
>  static
> -u32 utf8_to_utf32(const u8 **s8)
> +u32 efi_utf8_to_utf32(const u8 **s8)
>  {
>  	u32 c32;
>  	u8 c0, cx;
> @@ -82,7 +82,7 @@ void efi_puts(const char *str)
>  	while (*s8) {
>  		if (*s8 == '\n')
>  			buf[pos++] = L'\r';
> -		c32 = utf8_to_utf32(&s8);
> +		c32 = efi_utf8_to_utf32(&s8);
>  		if (c32 < 0x10000) {
>  			/* Characters in plane 0 use a single word. */
>  			buf[pos++] = c32;
> -- 
> 2.49.0
> 
> Then the first patch (which becomes the second) becomes:
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 0403a4ca4c11..45e01cf3434c 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -7,6 +7,7 @@
>  #include <linux/cleanup.h>	/* for DEFINE_FREE() */
>  #include <linux/compiler.h>	/* for inline */
>  #include <linux/types.h>	/* for size_t */
> +#include <linux/nls.h>		/* for wchar_t */

Good thing I waited :) This include makes s390 unhappy:

https://lore.kernel.org/202503260611.MDurOUhF-lkp@intel.com/

It is possible that should be fixed by adding -Wno-pointer-sign to
KBUILD_CFLAGS_DECOMPRESSOR so that arch/s390/boot matches the rest of
the kernel but...

> diff --git a/lib/string.c b/lib/string.c
> index eb4486ed40d2..1aa09925254b 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -21,6 +21,7 @@
>  #include <linux/errno.h>
>  #include <linux/limits.h>
>  #include <linux/linkage.h>
> +#include <linux/nls.h>
>  #include <linux/stddef.h>
>  #include <linux/string.h>
>  #include <linux/types.h>

I wonder if would be better to do something like the below patch in lieu
of the EFI change above (since there is no chance for a collision) then
change both of the includes for wchar_t in this diff to nls_types.h? I
have no strong opinion but this seems like it would be cleaner for the
sake of backports while not being a bad solution upstream?

Subject: [PATCH] include: Move typedefs in nls.h to their own header

In order to allow commonly included headers such as string.h to access
typedefs such as wchar_t without running into issues with the rest of
the NLS library, refactor the typedefs out into their own header that
can be included in a much safer manner.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/nls.h       | 19 +------------------
 include/linux/nls_types.h | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/nls_types.h

diff --git a/include/linux/nls.h b/include/linux/nls.h
index e0bf8367b274..3d416d1f60b6 100644
--- a/include/linux/nls.h
+++ b/include/linux/nls.h
@@ -3,24 +3,7 @@
 #define _LINUX_NLS_H
 
 #include <linux/init.h>
-
-/* Unicode has changed over the years.  Unicode code points no longer
- * fit into 16 bits; as of Unicode 5 valid code points range from 0
- * to 0x10ffff (17 planes, where each plane holds 65536 code points).
- *
- * The original decision to represent Unicode characters as 16-bit
- * wchar_t values is now outdated.  But plane 0 still includes the
- * most commonly used characters, so we will retain it.  The newer
- * 32-bit unicode_t type can be used when it is necessary to
- * represent the full Unicode character set.
- */
-
-/* Plane-0 Unicode character */
-typedef u16 wchar_t;
-#define MAX_WCHAR_T	0xffff
-
-/* Arbitrary Unicode character */
-typedef u32 unicode_t;
+#include <linux/nls_types.h>
 
 struct nls_table {
 	const char *charset;
diff --git a/include/linux/nls_types.h b/include/linux/nls_types.h
new file mode 100644
index 000000000000..8caefdba19b1
--- /dev/null
+++ b/include/linux/nls_types.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NLS_TYPES_H
+#define _LINUX_NLS_TYPES_H
+
+#include <linux/types.h>
+
+/* Unicode has changed over the years.  Unicode code points no longer
+ * fit into 16 bits; as of Unicode 5 valid code points range from 0
+ * to 0x10ffff (17 planes, where each plane holds 65536 code points).
+ *
+ * The original decision to represent Unicode characters as 16-bit
+ * wchar_t values is now outdated.  But plane 0 still includes the
+ * most commonly used characters, so we will retain it.  The newer
+ * 32-bit unicode_t type can be used when it is necessary to
+ * represent the full Unicode character set.
+ */
+
+/* Plane-0 Unicode character */
+typedef u16 wchar_t;
+#define MAX_WCHAR_T	0xffff
+
+/* Arbitrary Unicode character */
+typedef u32 unicode_t;
+
+#endif /* _LINUX_NLS_TYPES_H */
-- 
2.49.0

diff --git a/include/linux/string.h b/include/linux/string.h
index 45e01cf3434c..4a48f8eac301 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -7,7 +7,7 @@
 #include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
-#include <linux/nls.h>		/* for wchar_t */
+#include <linux/nls_types.h>	/* for wchar_t */
 #include <linux/stddef.h>	/* for NULL */
 #include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
diff --git a/lib/string.c b/lib/string.c
index 1aa09925254b..2c6f8c8f4159 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -21,7 +21,7 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
-#include <linux/nls.h>
+#include <linux/nls_types.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>

