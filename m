Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A00920E0F4
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbgF2UvU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgF2TNb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:13:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F70C08EACF
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so7455368pfe.4
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYEfxa7OKW4v9GzIhRwTOUIFBqV9srsfVDhYF/BxOH4=;
        b=UGuj7q/WS0KExRsg2CLBONUZs7T3XsjCMG/yvyLhtdKaUxcYROcvoBOHpNAFhy3W6X
         hRSrOBP/yNeMA7/dIhR3oCJW8Q2Ny4KVxmm6Vjh8bZXH5/6i5EtAUXUY8d0+u7DSSe3D
         eLJOO3rK0lYMIO5dti5mWzX97ev2/r072VzHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYEfxa7OKW4v9GzIhRwTOUIFBqV9srsfVDhYF/BxOH4=;
        b=SiMVlhlOulzbGb/icw/PSpqqnloVvQK5/U/OeDXkHPcrYZSN9j14KbR2m4ViLHyiBr
         f65enD2nCqQcFjY4vTJWq/f2uqqVkOXWYpaHwhm2V3cb5LcDashDrmKIQjjLt0hhyMjB
         LpspjROUhWLeNQKD3t+xsFGCYzEXN15JJPs2j1wKpjtbLVNx5CV/u+PkSE1NHX01uhkd
         Ty7T/SZPCR0uiY0nZoDLDE/BcqHkPgvEwHTTaFdgCjwoNFnIZhVbXvlwVePZvPrlqcTt
         yIbr90lRZMWpXYLtsoMKcMNyIMy3cFxujBA0YQ9q8a/rKe2vOAxGbqa+eWd+r3VBRu6i
         WqGg==
X-Gm-Message-State: AOAM533pxJBAMWGv5JcqRGUs+fBUhSquQJnwtL51S37jpotXqUq2Q9oT
        /sdfVFgy/nMKyZGMBDbIEXA9+g==
X-Google-Smtp-Source: ABdhPJw01U8lgdzVeHYlSAg3jRburoo7yEiQmP++SKqH4gvPoLztfxnPJpbsXaeAqVpc8BiwbFDEkg==
X-Received: by 2002:a05:6a00:148c:: with SMTP id v12mr12987122pfu.171.1593411524779;
        Sun, 28 Jun 2020 23:18:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o207sm33243245pfd.56.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:43 -0700 (PDT)
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
Subject: [PATCH v4 02/17] vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
Date:   Sun, 28 Jun 2020 23:18:25 -0700
Message-Id: <20200629061840.4065483-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

KASAN (-fsanitize=kernel-address) and KCSAN (-fsanitize=thread) produce
unwanted[1] .eh_frame and .init_array.* sections. Add them to DISCARDS,
except with CONFIG_CONSTRUCTORS, which wants to keep .init_array.*
sections.

[1] https://bugs.llvm.org/show_bug.cgi?id=46478

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1248a206be8d..e53a2d4f47f6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -927,10 +927,30 @@
 	EXIT_DATA
 #endif
 
+/*
+ * Clang's -fsanitize=kernel-address and -fsanitize=thread produce
+ * unwanted sections (.eh_frame and .init_array.*), but
+ * CONFIG_CONSTRUCTORS wants to keep any .init_array.* sections.
+ * https://bugs.llvm.org/show_bug.cgi?id=46478
+ */
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KCSAN)
+# ifdef CONFIG_CONSTRUCTORS
+#  define KASAN_DISCARDS						\
+	*(.eh_frame)
+# else
+#  define KASAN_DISCARDS						\
+	*(.init_array) *(.init_array.*)					\
+	*(.eh_frame)
+# endif
+#else
+# define KASAN_DISCARDS
+#endif
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
+	KASAN_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\
-- 
2.25.1

