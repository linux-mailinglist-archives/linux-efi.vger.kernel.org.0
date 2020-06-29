Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B541120E22D
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 00:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbgF2VDF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgF2TMt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:12:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD26C08EB1C
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:27:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so7438574pfi.13
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sXG3FvFqQ5OV+ZXnRU9R+TEF3U1pZeLG1jvNfenb62s=;
        b=Dr3LTyOcepWrlYRx1KeZt7WsSGx24iQgQlE3vgItGgcuCz/Qqv46uWAW6jcWneSu/A
         9yJ4dGHFVjLf2NoUg6xQd5a/3NE5S1FrFk5DcfZiZPXYfccXmblBSblmRC0P4wvwmqBH
         ftFfk372fYI5M6GZiMGy5dJeCBhJDzsm2KTgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sXG3FvFqQ5OV+ZXnRU9R+TEF3U1pZeLG1jvNfenb62s=;
        b=VfH/BuENJggeEkFqQ6rQvc8H2x5SfKJ5SyOEzjLKn8uX6EbUr8HKoYPzd88ZXbwEuJ
         e9/kTQ8z8bZ6Y9KvPoNMYgtkK1XEf8bgIq/Lc3RjqhDBV5+s93peVkXoXg0q+mjInJhh
         ApueSmPF1+0uxehHAGy4cND98g9pekNQKjVOqLwa2zYVXn8Ix9j5sXIyyDMTEG9SYf9D
         EiFh7OHp9m35XCkzULfjlVhOx7ZI+3kVDSl1qMcuq1iMum6gx8lwVVjbIMhZxqJsJSbP
         7Hgy/Xr0TxmcPcsya/Sr+GGdGtA7UuoK32CGsXUxJI+pxsNZEgxm1AIO+UGVBp7G+ouW
         PpZA==
X-Gm-Message-State: AOAM531fN4q0djWOVgp7w6ljjXGEUdvT74Iv0bahp0OGS25Y9nk+R27R
        WKPfD734+R9ASIMKADexcHdeFg==
X-Google-Smtp-Source: ABdhPJw033T79hmEnu5HLxCntZo9NI1/QGQweu55S6/mFEtAwjTX8shGo4HSRGOPCLPo2/+Sc0ET+Q==
X-Received: by 2002:a65:410b:: with SMTP id w11mr6271531pgp.65.1593412049107;
        Sun, 28 Jun 2020 23:27:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9sm28713610pgo.22.2020.06.28.23.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:27:28 -0700 (PDT)
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
Subject: [PATCH v4 15/17] arm/boot: Warn on orphan section placement
Date:   Sun, 28 Jun 2020 23:18:38 -0700
Message-Id: <20200629061840.4065483-16-keescook@chromium.org>
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

Use common macros for debug sections, discards, and text stubs. Add
discards for unwanted .note, and .rel sections. Finally, enable orphan
section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile      |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S | 18 ++++++++----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 00602a6fba04..b8a97d81662d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -128,6 +128,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 09ac33f52814..636e9ceb79ec 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -2,6 +2,7 @@
 /*
  *  Copyright (C) 2000 Russell King
  */
+#include <asm/vmlinux.lds.h>
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
 #define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
@@ -17,8 +18,11 @@ ENTRY(_start)
 SECTIONS
 {
   /DISCARD/ : {
+    ARM_COMMON_DISCARD
     *(.ARM.exidx*)
     *(.ARM.extab*)
+    *(.note.*)
+    *(.rel.*)
     /*
      * Discard any r/w data - this produces a link error if we have any,
      * which is required for PIC decompression.  Local data generates
@@ -36,9 +40,7 @@ SECTIONS
     *(.start)
     *(.text)
     *(.text.*)
-    *(.gnu.warning)
-    *(.glue_7t)
-    *(.glue_7)
+    ARM_STUBS_TEXT
   }
   .table : ALIGN(4) {
     _table_start = .;
@@ -128,12 +130,8 @@ SECTIONS
   PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
   PROVIDE(__pecoff_end = ALIGN(512));
 
-  .stab 0		: { *(.stab) }
-  .stabstr 0		: { *(.stabstr) }
-  .stab.excl 0		: { *(.stab.excl) }
-  .stab.exclstr 0	: { *(.stab.exclstr) }
-  .stab.index 0		: { *(.stab.index) }
-  .stab.indexstr 0	: { *(.stab.indexstr) }
-  .comment 0		: { *(.comment) }
+  STABS_DEBUG
+  DWARF_DEBUG
+  ARM_DETAILS
 }
 ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
-- 
2.25.1

