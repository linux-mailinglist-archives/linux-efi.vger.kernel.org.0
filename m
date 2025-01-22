Return-Path: <linux-efi+bounces-2705-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE5A18964
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 02:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61111167EC9
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 01:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A7C54782;
	Wed, 22 Jan 2025 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5KaTiyH"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4343AA8;
	Wed, 22 Jan 2025 01:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737508330; cv=none; b=FMNL1s3Mp9obuO8LfPAXAdrncMRbzZIlSU+i8GphuzoA2nf4OkzwsbGlQPPHw937jgrVoPRR+A/pmZpnMb13FV/jfpXL2ZKGRWoGU6xaBXNeoQO+QTUp6alRhgIBsogtM5LpdRgQCiHgAG1MW4fm40RqC8smAGxUWQYFFqqfJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737508330; c=relaxed/simple;
	bh=amNFqf4Iac0JkG22BINQ0+1MqzNibyQ+GHQtfdlCxR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xf0tnhL0uSDmA/vH5n/j2r1/K8FIRv0SdM7LVe8ZsMPT79QkEUKltdYwVWJCnCLHsFHQ7p+yNPo+wVP7wzAi/06au2VWo+JwCUSNRFIavttIAonY1vNbK/hRkitQ4kP39dZc5mQrSMb5PtSwN402CtVz9e1xE+PqaXkl2GJSBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5KaTiyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDAEC4CEDF;
	Wed, 22 Jan 2025 01:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737508329;
	bh=amNFqf4Iac0JkG22BINQ0+1MqzNibyQ+GHQtfdlCxR0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5KaTiyHfb24eiV0U8zG9osgNv2aDDdc0wNkPxxEy7M1r02BapSYlqrJXlnRLadWJ
	 e1nCuz+OMlxt45Thebtypyf6OEATGnlo02ujNUiLkgsCAhd7wMHrOu4MpNWF2CcrVC
	 HvAox1vzR0YB4Vj0DaHrHOiNwurWvsGlg8ABCb3qbdN/3RauVAdpBTZ5TnJk0kXhZo
	 yGF14nr9dqh35j6nraYdqy5HT7up56kfrbYp82ayu1RLYFCxV4FjRMm79dK98VVXKg
	 FhrNffjqlU0dSkCKecKxMAA4onl1XoUZW01m7NZUy7CtdNkIEUFwstlV4tj0gpaMXh
	 9lujn5y8IXxPA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 21 Jan 2025 18:11:34 -0700
Subject: [PATCH 2/2] efi: libstub: Use '-std=gnu11' to fix build with GCC
 15
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250121-x86-use-std-consistently-gcc-15-v1-2-8ab0acf645cb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=nathan@kernel.org;
 h=from:subject:message-id; bh=amNFqf4Iac0JkG22BINQ0+1MqzNibyQ+GHQtfdlCxR0=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOkTXO/JPfqQIpT9UPbM53eaTTJKxYf/PZ9e1shet07fp
 ZpRU9Sro5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEzkzAJGhjXih5295z2I0P0c
 ZXEmXWrrgcs19jdEd867KfMjeH3m1TyGX8yBn/Kyb7pt2HpfdcbNlWsTL63yinzW/HNxOUszQ4D
 WFD4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

GCC 15 changed the default C standard version to C23, which should not
have impacted the kernel because it requests the gnu11 standard via
'-std=' in the main Makefile. However, the EFI libstub Makefile uses its
own set of KBUILD_CFLAGS for x86 without a '-std=' value (i.e., using
the default), resulting in errors from the kernel's definitions of bool,
true, and false in stddef.h, which are reserved keywords under C23.

  ./include/linux/stddef.h:11:9: error: expected identifier before ‘false’
     11 |         false   = 0,
  ./include/linux/types.h:35:33: error: two or more data types in declaration specifiers
     35 | typedef _Bool                   bool;

Set '-std=gnu11' in the x86 cflags to resolve the error and consistently
use the same C standard version for the entire kernel. All other
architectures reuse KBUILD_CFLAGS from the rest of the kernel, so this
issue is not visible for them.

Cc: stable@vger.kernel.org
Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com/
Reported-by: Jakub Jelinek <jakub@redhat.com>
Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ed4e8ddbe76a..1141cd06011f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -11,7 +11,7 @@ cflags-y			:= $(KBUILD_CFLAGS)
 
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -std=gnu11 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \

-- 
2.48.1


