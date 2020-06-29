Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD0820DFCB
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgF2Uj4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731716AbgF2TON (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:14:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C372C08EB0C
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so6699395ple.0
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UIGzgreIfTFOxxrVnfdOtVBSBIsQ6xr6g7mQ/APcJYs=;
        b=eIyxYRftnOui04V4XDgcCKRZPnSL1iLVTOLK21hciuVaKMrlO/me6I6zabNcmW51hm
         sEP0n59JEFsgLPSQ4aRAQ2lJpdfBlUFjFZ+BQZG9PBaB8aynL14Bhv8xALE7JNi7Dg0C
         QWW2xnjqIifsayeGW/Ay6Sbs+HR/6nZ4+JWWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UIGzgreIfTFOxxrVnfdOtVBSBIsQ6xr6g7mQ/APcJYs=;
        b=ZwfskgbL7H59cMB4JGsZUZj4G00a5LdEI7q2tqloC6ujxbXuJOsiUWkWlYvMjNRwA6
         4WxUqJshm82iX5Ov09PdgMdYLqBi70VxNE6bJ6Ws5//jvzzqd/Uda26DUt4w5bJFI57r
         vBZ9j91y3BQXPxtb0ElIMN7BwHLhW26jIZbvQGaYNW8sAhH3155fz12rCrbGZCAmZoQU
         o1VdUxuz4XPeKAry8r/bll/auMv5uLQgxLm8Lnqye4fvWQlFksvXqV1hNM/eITqyYg9K
         GuLL6vw9TOk9uN0e/OatTXptUS2d8OUI8QNI2z4+iNYfDD1w+JvhZxyLJWtWXtZntcPe
         e1gg==
X-Gm-Message-State: AOAM533O3+jQ+9xbQWJBHAoCU4e9eduKnrjKymTiPi5pcxZgrIrJA4V7
        wcEMB970EROZEkJ4X6RLDjOLLA==
X-Google-Smtp-Source: ABdhPJzz69mu7O4q6VbFBjTvIO71CEyN6mZuFliZ3G3JlPVzh4yITRE6mx9hV24nwgpSONTnA4Ny3g==
X-Received: by 2002:a17:90a:1781:: with SMTP id q1mr15164767pja.24.1593411532684;
        Sun, 28 Jun 2020 23:18:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm7737172pjv.25.2020.06.28.23.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
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
Subject: [PATCH v4 11/17] arm64/build: Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:34 -0700
Message-Id: <20200629061840.4065483-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
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

Remove .eh_frame, since there are none left.

Add .plt, .data.rel.ro, .igot.*, and .iplt to discards as they are not
actually used. While .got.plt is also not used, it must be included
otherwise ld.bfd will fail to link with the error:

    aarch64-linux-gnu-ld: discarded output section: `.got.plt'

However, as it'd be better to validate that it stays effectively empty,
add an assert, as suggested by Ard Biesheuvel.

Explicitly include debug sections when they're present.

Finally, enable orphan section warnings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             |  4 ++++
 arch/arm64/kernel/vmlinux.lds.S | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 895486606f74..fb3aa2d7de4d 100644
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
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index b5a94ec1eada..320ba5ec2adc 100644
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
@@ -244,9 +245,17 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
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
-- 
2.25.1

