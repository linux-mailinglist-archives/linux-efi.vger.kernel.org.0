Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E634724E100
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgHUTpt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgHUTol (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:44:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ABCC0613ED
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so1329346plb.12
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/rE8jJuXRc1airAle0+onivAY85nE0+tqDHT+XyY88=;
        b=JT4pVb10IceVeDm1adcHLxdY4EdYIPEWA3KjTJabgl0d0VA5WUnoX/ushJfgCok6Ho
         4B3EVm8AF4NzrvER3XCq7eZ+7m4BIvPPR9geOnruF42EwoVDjqeHzLgmffnFdRS+y+Bg
         5UlsXllprv18ipGiriocq+G9bM7cQTotoNyOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/rE8jJuXRc1airAle0+onivAY85nE0+tqDHT+XyY88=;
        b=IHoG1MYQuB9iKNT0ZdvOKu4mDy2ymLmRF8CVdDPeZqJOekuQdEf5c0FgFo/yFMJqhh
         n9l3otuI/0ZQ75uHL/AbNKLukkVS4rP94xDCNYmS3mBkvVNkSSABcZbJowuOYRVEPSie
         Nu4JOTq2RFCMxXq5B6FDmlwggOSfp8ytNZVycdfGS7d0c/m6lFvcgRnmDxxOkEl96EBE
         QMyKc5s7eHpSBG0rgzE4SRxre+PCQT1M6a7p/fAwIZR/rAJygkCVIW9DIeO8Zc9Pgpzs
         5/ywpvSVnaUpMyaI81Oy5LL3ZYWjzwDkmKWg6NE8DOu47ztEqcVxsB+GREPx3HYs5Umu
         Cwiw==
X-Gm-Message-State: AOAM532maQ+IvDFDBIg7Q3xLadn42UibKOUqIr+ro7/lRGh1kGfhfE3O
        UkYleg4t+u0HEnPWgSYstNkQsA==
X-Google-Smtp-Source: ABdhPJyuGIVQ0b+PhpdQKCs1+OXOtpRIrOjbVmWZxwlIoSAwv7AnBEr84ug+NmvksNd2aTZqqIZrEg==
X-Received: by 2002:a17:902:ac84:: with SMTP id h4mr3560297plr.334.1598039068646;
        Fri, 21 Aug 2020 12:44:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e125sm3411364pfh.69.2020.08.21.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/29] efi/libstub: Disable -mbranch-protection
Date:   Fri, 21 Aug 2020 12:42:48 -0700
Message-Id: <20200821194310.3089815-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for adding --orphan-handling=warn to more architectures,
disable -mbranch-protection, as EFI does not yet support it[1].  This was
noticed due to it producing unwanted .note.gnu.property sections (prefixed
with .init due to the objcopy build step).

However, we must also work around a bug in Clang where the section is
still emitted for code-less object files[2], so also remove the section
during the objcopy.

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
[2] https://bugs.llvm.org/show_bug.cgi?id=46480

Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: linux-efi@vger.kernel.org
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 5eefd60917df..0c911e391d75 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -18,7 +18,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
@@ -66,6 +67,12 @@ lib-$(CONFIG_X86)		+= x86-stub.o
 CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
+# Even when -mbranch-protection=none is set, Clang will generate a
+# .note.gnu.property for code-less object files (like lib/ctype.c),
+# so work around this by explicitly removing the unwanted section.
+# https://bugs.llvm.org/show_bug.cgi?id=46480
+STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
+
 #
 # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
 # .bss section, so the .bss section of the EFI stub needs to be included in the
-- 
2.25.1

