Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0E24E0F3
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHUTp2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgHUTpH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:45:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A967DC061349
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o5so1477919pgb.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bq/BqxHywJ//unZ/FFsOI/I3RLFn1Ht881hz0pa/nMs=;
        b=nMHBYCD9syPtJ/9CNgyFfuEGCZA0qp6OIY3dAoZSUWHpHc+Q3Ev747cyfJWrxPqTaN
         9e2MrjpkqhQ+CCitsRw/dNMuQKUwexmgZUVqIjnoSQr9FtrpZ8sf1wqr3WXSo/B/W8Fk
         h225U7BBpzt+8zMUaIT5V8sZTmMP3VxgJIx3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bq/BqxHywJ//unZ/FFsOI/I3RLFn1Ht881hz0pa/nMs=;
        b=uHFlasgiIZvF8uTgK1i0Nz6HwdBg42Y9n80wZ+7BS17c2h2ZL7Fiyw2jTNiRwZdStb
         fdljC/5EftW/I2cN1/Bzig6Fee1yprDMcUmJ1tECO1G2nDN6mYGKW/DPNAGzNEjeu2Vf
         VvKO6D00O69jFjgdtx9M6be3+D7fk+cHsoeH2UfJixBSNjNucDmSWcU7TkwDOi3O/pAI
         3uvFwJVkXUrIvwFXmPuYjrTKddcahE5Kyj0Px6kJV3KDDrTpXdhP6Tu2LuVmTdLBS8wV
         +CKMXBMD+Zu0WFjETwXkG/51/88GlPHVH037yjP8N657GVXVbCOjJnvluzftIorl/jMX
         Snbg==
X-Gm-Message-State: AOAM531i56QBCDB8cJ5caK+OdXMcNyVRcD2Yb/CwO4DqcQZVun8m0OG0
        u1MwkqtyUR7u9CWQoJI35RKwXg==
X-Google-Smtp-Source: ABdhPJzLO9YcG4hPsntq7zaWUP4F+rgb2wZDPHFQhZoPhtEJ9GVket/dTKmqcPm1ABYBQRpoMUWFDw==
X-Received: by 2002:a63:2324:: with SMTP id j36mr3471607pgj.221.1598039074103;
        Fri, 21 Aug 2020 12:44:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 132sm3025142pgg.83.2020.08.21.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 23/29] x86/build: Enforce an empty .got.plt section
Date:   Fri, 21 Aug 2020 12:43:04 -0700
Message-Id: <20200821194310.3089815-24-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The .got.plt section should always be zero (or filled only with the
linker-generated lazy dispatch entry). Enforce this with an assert and
mark the section as INFO. This is more sensitive than just blindly
discarding the section.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0cc035cb15f1..4b1b936a6e7d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -414,8 +414,20 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (INFO) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 ||
+#ifdef CONFIG_X86_64
+	       SIZEOF(.got.plt) == 0x18,
+#else
+	       SIZEOF(.got.plt) == 0xc,
+#endif
+	       "Unexpected GOT/PLT entries detected!")
+}
 
 #ifdef CONFIG_X86_32
 /*
-- 
2.25.1

