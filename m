Return-Path: <linux-efi+bounces-3084-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8CBA70569
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 16:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F70D188A9FC
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 15:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5292571A8;
	Tue, 25 Mar 2025 15:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8Pgyj5e"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC76256C89;
	Tue, 25 Mar 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917545; cv=none; b=hJLkCbkWpEJ0t+0Ccyy9HsyHgAUD739mvvUoEjk4MeyL3KP1n7YEDkUHMfFYDGZAcqvFAvBQk8wameZ/9NzN3oRhweCSO4bM5EgWWWsrO771FOpsl3rSi5I/tPHv3RtJ2MtKAPjh0CSEpVh2XMNSYnsATz76yfG23NHARlYQSE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917545; c=relaxed/simple;
	bh=DLMLURxBlPuCtMwT7e06KXHAr/xm9CeEmbZfX3sYIWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFOVMLsze0EB4OWRI08f5nUlFFZ/wBxmkxufUFxaVaKvwBoEf/Nir7iPj8gwqwKwG8kcl+7gI3qRt5mZE4LwgW7/9/hZxQSxjGBcP2rcicsHeoUSO3y2RTKhqadPQ54fEE9a78Q8z+6tSsJvKE9zbwBY40AikGY31C6unlC94Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8Pgyj5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A61C4CEE4;
	Tue, 25 Mar 2025 15:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917543;
	bh=DLMLURxBlPuCtMwT7e06KXHAr/xm9CeEmbZfX3sYIWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O8Pgyj5es0qxPPH/Pof5lLue/nCSGdaYB9WadlRwBPyni7CSTLeo0MSuZqb+ZuUOY
	 WnZJBk63hNEfYAnHILuPZ6/4oWwj3G5zXS0K8HSGu/7cYJt6dhbZ3+EEj1Fo5hnA0z
	 yEpI5/+0cJotj8VAOUUjgaFhx9HFMb3KdH+pkgsWIuKbzNJ8blOnwf+IMy/LyAiQIt
	 sK6qksY7m7cc6qxqu9hw04K77ghEmJkqO3RBoHtEHz2hcskhXDA1plLOp1oMHOQAHa
	 2l0zoEGxZQt8yvsqjc7m3RP5mwKWfJhVsrunEmXZRIsjOcRfAHvcbayrtodcNtweGf
	 r3WP89swdLY2Q==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 25 Mar 2025 08:45:18 -0700
Subject: [PATCH 1/2] lib/string.c: Add wcslen()
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-string-add-wcslen-for-llvm-opt-v1-1-b8f1e2c17888@kernel.org>
References: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
In-Reply-To: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 linux-efi@vger.kernel.org, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=nathan@kernel.org;
 h=from:subject:message-id; bh=DLMLURxBlPuCtMwT7e06KXHAr/xm9CeEmbZfX3sYIWc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmPzi8y3Fg7/e2W+e9Ys26u8Xub1ZMjoTb5N5/k5C3nu
 BK3/szT6yhlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQAT8TRkZLjGmT/znJts5u8S
 9qhJ7ufsj+e6Tt6hwsLhF1e7cPcb6cmMDLNSj91301a7d/jAFeaSeb+jSpwWyf6tLb2/3LjJ2+B
 ELAsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

A recent optimization change in LLVM [1] aims to transform certain loop
idioms into calls to strlen() or wcslen(). This change transforms the
first while loop in UniStrcat() into a call to wcslen(), breaking the
build when UniStrcat() gets inlined into alloc_path_with_tree_prefix():

  ld.lld: error: undefined symbol: wcslen
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)
  >>> referenced by nls_ucs2_utils.h:54 (fs/smb/client/../../nls/nls_ucs2_utils.h:54)
  >>>               vmlinux.o:(alloc_path_with_tree_prefix)

The kernel does not build with '-ffreestanding' (which would avoid this
transformation) because it does want libcall optimizations in general
and turning on '-ffreestanding' disables the majority of them. While
'-fno-builtin-wcslen' would be more targeted at the problem, it does not
work with LTO.

Add a basic wcslen() to avoid this linkage failure. While no
architecture or FORTIFY_SOURCE overrides this, add it to string.c
instead of string_helpers.c so that it is built with '-ffreestanding',
otherwise the compiler might transform it into a call to itself. Give
wcslen() an internal prototype to avoid -Wmissing-prototypes (a global
prototype needs a little extra work and it is not currently needed).

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/string.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d2..bbee8a9e4d83 100644
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
@@ -429,6 +430,17 @@ size_t strnlen(const char *s, size_t count)
 EXPORT_SYMBOL(strnlen);
 #endif
 
+size_t wcslen(const wchar_t *s);
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

-- 
2.49.0


