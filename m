Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9A42069CE
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 03:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbgFXBuH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388594AbgFXBt4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Jun 2020 21:49:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E5C0617BA
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so322432plb.11
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXUgLosNUEP93cpEKoNn7oauK0Oksg2zT1r8iNc2N3M=;
        b=ckmxDB65sTOYu6rx9OIJTqHdVaF3Rq0JK7kAA6vc5D+eoog4QFJCUkaQ7pr9Dbdqt8
         TtXjq1UpX+tQQMj1dqLxz4cB6MRk2G2LEF5f5B4Oh7F/T4fCQlQiO3iYpi7PtQCLvvql
         oPHshW80+ZhzYGTcFezjfbhx/X9l9btanp8ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXUgLosNUEP93cpEKoNn7oauK0Oksg2zT1r8iNc2N3M=;
        b=JJo5/Qp77NCUynOzaOO6jNDtj037sfZ9dxgJnw7sZsRZ6cgYZiH/S4OQgSrC0QyPiX
         7ysv/fAy5TSy7+7BjfuVShsXwEtDU94ue+7QyepzoEFRKwjK6mgde/RF4ETotxAQG+MB
         t5gemh18jn6FzcEX+lxHCDek2IaiugmyzF586B5exeUvlWc2AvqJsOJm3EjC/sjwRlvy
         eoE5Qd6VmpV6WV3yot4hlss8D0fZqxaPYiMNIa7SY8e4i+CRQcRJzQnTf86PT3oOl/ev
         lRTwDAQB8XhXXP0Q/ZYj0TDAcU9stwfDZ149deI0E6RwVjX78AEOSMiVAXnOA/iCp5RU
         bYlA==
X-Gm-Message-State: AOAM532kZvg3Q6igopB5fQbkO27+z4L3BlQQp3PKAsGxwYfqqIHZWypz
        ZWjZ3Km5V+y8wyn+6TcsnhfkfQ==
X-Google-Smtp-Source: ABdhPJwdum6Og6TIMupJ78tyY9GEfwXuR/37zHl5lfG7CPnDCX7KdCztzVd+hqJLR+uQSWvHTMGz/w==
X-Received: by 2002:a17:90a:1117:: with SMTP id d23mr26427976pja.136.1592963395150;
        Tue, 23 Jun 2020 18:49:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mp15sm3525013pjb.45.2020.06.23.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] arm64/build: Warn on orphan section placement
Date:   Tue, 23 Jun 2020 18:49:40 -0700
Message-Id: <20200624014940.1204448-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Avoid .eh_frame* by making sure both -fno-asychronous-unwind-tables and
-fno-unwind-tables are present in both CFLAGS and AFLAGS. Remove one
last instance of .eh_frame by removing the needless Call Frame Information
annotations from arch/arm64/kernel/smccc-call.S.

Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
actually used. While .got.plt is also not used, it must be included
otherwise ld.bfd will fail to link with the error:

    aarch64-linux-gnu-ld: discarded output section: `.got.plt'

However, as it'd be better to validate that it stays effectively empty,
add an assert.

Explicitly include debug sections when they're present.

Fix a case of needless quotes in __section(), which Clang doesn't like.

Finally, enable orphan section warnings.

Thanks to Ard Biesheuvel for many hints on correct ways to handle
mysterious sections. :)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             |  9 ++++++++-
 arch/arm64/kernel/smccc-call.S  |  2 --
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++++++-
 arch/arm64/mm/mmu.c             |  2 +-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..fb3aa2d7de4d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
@@ -47,13 +51,16 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+# Avoid generating .eh_frame* sections.
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
 stack_protector_prepare: prepare0
diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809528a4..d62447964ed9 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>
 
 	.macro SMCCC instr
-	.cfi_startproc
 	\instr	#0
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:	ret
-	.cfi_endproc
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5427f502c3a6..f6c781768f83 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -94,7 +94,8 @@ SECTIONS
 	/DISCARD/ : {
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
+		*(.plt) *(.data.rel.ro)
+		*(.igot.*) *(.iplt)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
@@ -244,8 +245,16 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 
 	HEAD_SYMBOLS
+
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (INFO) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, ".got.plt not empty")
 }
 
 #include "image-vars.h"
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 1df25f26571d..dce024ea6084 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -42,7 +42,7 @@
 u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
-u64 __section(".mmuoff.data.write") vabits_actual;
+u64 __section(.mmuoff.data.write) vabits_actual;
 EXPORT_SYMBOL(vabits_actual);
 
 u64 kimage_voffset __ro_after_init;
-- 
2.25.1

