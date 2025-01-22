Return-Path: <linux-efi+bounces-2704-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E0A18961
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 02:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB67188B62D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 01:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9F354764;
	Wed, 22 Jan 2025 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egnlJT1B"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F454782;
	Wed, 22 Jan 2025 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737508325; cv=none; b=CsCZCguTht8BBlsa/dU15oAok6WAXgegftjpUA7ZlIJNzLTbwrjyrXU3+A29p/PTYFfDru7KLMiNUVa+wlDMSncNuE03e1Xoui4PgsF1TH2P73y3GNHpATZrJh8lGwOWWAY17kJfLJDtF8IlBAj7jaZBC2GBgdPncjXstdCl608=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737508325; c=relaxed/simple;
	bh=f75caqCaHGl+e/mO6F5TcZDbAKcwq1MdXOvaRQs9H0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=engvhulttg2CVebey3/+UlWpTdIAjg6PZkKZswBPRiZeGjhXpmIsq7mGlSM2Jvcrh9h/CqqO7zwv4O6a09YaApefTVBEEDDy4C/LZo4qqdCYGGmvMJ+0jVCHpxF/UBsK34AKybfUMRSF6jRX+USBrfFgP1SX2WDy48Dp5phDM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egnlJT1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B607AC4CEE4;
	Wed, 22 Jan 2025 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737508325;
	bh=f75caqCaHGl+e/mO6F5TcZDbAKcwq1MdXOvaRQs9H0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=egnlJT1BGQw1tSq7egebFD0UUj1eV7CArUAZZ0B8vpKSdZBlwWcQdpZx1BDWxJk15
	 nZN8UABfa79ftRYArxfInLLsS2YdlTqoZAyrLKG5u8F5YbbR2imDjG+GJgD12QeuRA
	 Ae6QWp8MFSTilDMXe3DBX4WWvu10YTQAFmsnQ9QO31YIN/yp5elXVjYUDzkIPlgK5F
	 o7c2Fv/m19zqJqOsnCekEUFD7FjS5I9A0QgmAdXGMVRFHQxn18puwdZLxfFbddHvvH
	 nIpDzWzkp9EVTsb9YF4xpoHqagp7YKEtnmFMlwMkzzg8ym1/CTs54QsgwojY62/mMc
	 VOg9wuoGGDYvw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 21 Jan 2025 18:11:33 -0700
Subject: [PATCH 1/2] x86/boot: Use '-std=gnu11' to fix build with GCC 15
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250121-x86-use-std-consistently-gcc-15-v1-1-8ab0acf645cb@kernel.org>
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
In-Reply-To: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Sam James <sam@gentoo.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
 stable@vger.kernel.org, 
 Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, 
 Jakub Jelinek <jakub@redhat.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947; i=nathan@kernel.org;
 h=from:subject:message-id; bh=f75caqCaHGl+e/mO6F5TcZDbAKcwq1MdXOvaRQs9H0Q=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkTXO+t/uwkfNaAx9x1Ir+CirHO9t1G3GkMUdo/38smu
 Ob0qizqKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABN5oMTI8P75vJed5e7umW7q
 PyMk1vgIPlaLEs77GP82zOaKlvvHJkaGtQ6zbin9L9bhyzFZkCEgbJJ0a/3DQot7jRpffwX8j+f
 nAQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

GCC 15 changed the default C standard version to C23, which should not
have impacted the kernel because it requests the gnu11 standard via
'-std=' in the main Makefile. However, the x86 compressed boot Makefile
uses its own set of KBUILD_CFLAGS without a '-std=' value (i.e., using
the default), resulting in errors from the kernel's definitions of bool,
true, and false in stddef.h, which are reserved keywords under C23.

  ./include/linux/stddef.h:11:9: error: expected identifier before ‘false’
     11 |         false   = 0,
  ./include/linux/types.h:35:33: error: two or more data types in declaration specifiers
     35 | typedef _Bool                   bool;

Set '-std=gnu11' in the x86 compressed boot Makefile to resolve the
error and consistently use the same C standard version for the entire
kernel.

Cc: stable@vger.kernel.org
Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com/
Reported-by: Jakub Jelinek <jakub@redhat.com>
Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index f2051644de94..606c74f27459 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -25,6 +25,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 # avoid errors with '-march=i386', and future flags may depend on the target to
 # be valid.
 KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
+KBUILD_CFLAGS += -std=gnu11
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING

-- 
2.48.1


