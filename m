Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052BD349D37
	for <lists+linux-efi@lfdr.de>; Fri, 26 Mar 2021 01:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCZAFC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Mar 2021 20:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhCZAE7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 25 Mar 2021 20:04:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0145561A13;
        Fri, 26 Mar 2021 00:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616717099;
        bh=cX3mQeEGrADEox7GGuslEi3aDF4L5XBwmaqXSbfj2Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ii6iPhXwoK6cz7rzV5rK9BAdkr102MSShtXptn9J+eL7UmySEkjHFGNRNOXMFslMU
         sIy84W8LVaXgui7biGhcpvUTgEENHr9ufuio2Oy1wlj2qFDXojZtlFi5+0RYJOk5ig
         Vi/7fm6hMOo/TaIlQT3GDHFbQYpR/K5eHCmxwl2+k1jVZvxMy7lUyyjIiGBOELU+Vf
         l9mjgwmyxyehwG0xvhcxCLL18nXK7rf5q/244GKVxkldwCUulX3gOX5qKtbBQigovt
         6NcUVaEJbqcArfFUsCxRJhQWJiajBvQ19un1KZFQpeg8RkR+Ez9ks6cu0q2d/4kJYg
         iYVy8OjjG1Myg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        John Millikin <john@john-millikin.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/3] x86: Propagate $(CLANG_FLAGS) to $(REALMODE_FLAGS)
Date:   Thu, 25 Mar 2021 17:04:33 -0700
Message-Id: <20210326000435.4785-2-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326000435.4785-1-nathan@kernel.org>
References: <20210326000435.4785-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: John Millikin <john@john-millikin.com>

When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
contains additional flags needed to build C and assembly sources
for the target platform. Normally this variable is automatically
included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.

The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
plain assignment and therefore drops the Clang flags. This causes
Clang to not recognize x86-specific assembler directives:

  arch/x86/realmode/rm/header.S:36:1: error: unknown directive
  .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
  ^

Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
which is inherited by real-mode make rules, fixes cross-compilation
with Clang for x86 targets.

Relevant flags:

* `--target' sets the target architecture when cross-compiling. This
  flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
  to support architecture-specific assembler directives.

* `-no-integrated-as' tells clang to assemble with GNU Assembler
  instead of its built-in LLVM assembler. This flag is set by default
  unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
  parse certain GNU extensions.

Signed-off-by: John Millikin <john@john-millikin.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 2d6d5a28c3bf..9a73e0cea19c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
 REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
+REALMODE_CFLAGS += $(CLANG_FLAGS)
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
-- 
2.31.0

