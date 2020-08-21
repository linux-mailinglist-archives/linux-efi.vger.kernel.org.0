Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43F924E0E2
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHUToo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUTo3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:44:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EF5C0617A0
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id n3so1152154pjq.1
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQO/PcZpzZoe4IDChCWVkIxZf7tzI4XyeCxPmxC8FNI=;
        b=NugASbhHSLh4kJaKioodD/JRBqxUb7xOPm32oHVQ+brGiQkrNwDazPLYjk/bxUb9bc
         /X3UF/vMGgpmdxRlcpCXroq0TzwIcsJIZZtD6ra9JycErhlpr22IdOIR9+9MRF/J7oq1
         4bN0HYcBhFQjhXKHHlOrjY2hDTe3dCGXNj624=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQO/PcZpzZoe4IDChCWVkIxZf7tzI4XyeCxPmxC8FNI=;
        b=tD20AR/6XsU8JceBkr1FI/GvBvHmyvfEDgrJ8oGl9+kAnulRaCursPOyAHsaW2pE3q
         k9jOcaeySY+ytHeWIMT1dX9H+hYDoNBr4V5E+JVXhAh+hW7ZPIm5dWGqf5naBCTmK4xa
         BqnxKLNFlqXn2qMgmHD1R0NgPm9YelNaR++ohfnvqh5AN3zqufRuSdOMRZ7aG4nXM8Xn
         d7AWcXyINbDlA+fF/gskLLRqcIB0QCK+35UFBqW6LHGKHB/TdzqtUJ2UVg4hOshwgTTo
         0EzPv9fsl8ASVg/wwJq1N6F0mLyKsdyLwkJoGCfJ78zF4V2yeu29IaYh3NSOoeiozZTF
         Jpww==
X-Gm-Message-State: AOAM5324svxeSH6TEuFkVjXcBSLxzSDYw+MmTWYgJug8l/I/zJBgjlRW
        dW3cRvk4VR4MzPaM1Fix3vbEHg==
X-Google-Smtp-Source: ABdhPJythyZxt12n8sEiGPQ9Kw/ofMF58pYY/nnVTG21TWExivmj/nZzvR/4NL1gss2+7xdDPHTiAQ==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr3642315plo.324.1598039064310;
        Fri, 21 Aug 2020 12:44:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1sm3563798pfu.2.2020.08.21.12.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
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
Subject: [PATCH v6 05/29] vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
Date:   Fri, 21 Aug 2020 12:42:46 -0700
Message-Id: <20200821194310.3089815-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
and .shstrtab are listed as orphaned. Add them to the ELF_DETAILS section
so there will be no warnings when --orphan-handling=warn is used more
widely. (They are added above comment as it is the more common
order[1].)

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

[1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/

Reported-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cadcbc3cdabd..98d013dcc11a 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -823,7 +823,10 @@
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.comment 0 : { *(.comment) }
+		.comment 0 : { *(.comment) }				\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
-- 
2.25.1

