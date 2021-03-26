Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34D349D39
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCZAFe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 20:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229631AbhCZAFF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 20:05:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 995C261A0A;
        Fri, 26 Mar 2021 00:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616717105;
        bh=wK/BFrBTE/0tBXGMmuGyDcFbZJG2Gsid1VRthtJvonc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeGYgk1XDEILPxorhA3iIVOF9HnzT+TEjpYcjpbwI7twldA4T0jU3SED2npzBIDem
         fzgPMI+3s5OPIj2jRkkctakVjbfwyW87TLa+P8KBfayXrui20WDjiRMfmGRmCiblec
         6IhLRgF/XhD62Ua1REDHkqogfIRwmEkgBJ8Rz1feIy8rM2iPuRZ4raqHtl5c2HfSbw
         mcFNjzDD7poz5tdSSkXy4bLVWWbsTFp1Z667x+jBEsOiI5tAuSi3YBQPc33TeMuZqE
         2xZeAvQB7bP3MzFVs/JtvjO3KBI1awX2vK+xYMj13zu7+izYxFIioK6KDmaiKTOMnM
         fgUvgzMvUhQag==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 3/3] efi/libstub: Add $(CLANG_FLAGS) to x86 flags
Date:   Thu, 25 Mar 2021 17:04:35 -0700
Message-Id: <20210326000435.4785-4-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326000435.4785-1-nathan@kernel.org>
References: <20210326000435.4785-1-nathan@kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When cross compiling x86 on an ARM machine with clang, there are several
errors along the lines of:

arch/x86/include/asm/page_64.h:52:7: error: invalid output constraint
'=D' in asm

This happens because the x86 flags in the EFI stub are not derived from
KBUILD_CFLAGS like the other architectures are and the clang flags that
set the target architecture ('--target=') and the path to the GNU cross
tools ('--prefix=') are not present, meaning that the host architecture
is targeted.

These flags are available as $(CLANG_FLAGS) from the main Makefile so
add them to the cflags for x86 so that cross compiling works as
expected.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index c23466e05e60..d0537573501e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -13,7 +13,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -Wno-pointer-sign \
 				   $(call cc-disable-warning, address-of-packed-member) \
 				   $(call cc-disable-warning, gnu) \
-				   -fno-asynchronous-unwind-tables
+				   -fno-asynchronous-unwind-tables \
+				   $(CLANG_FLAGS)
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-- 
2.31.0

