Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701EE24E159
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHUTzX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHUTyD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:54:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8B2C061798
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ep8so1262049pjb.3
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vdQE3ckXVQaQMZctNKe7+WI4MMPWGnzLaa/Ga3pSK5c=;
        b=iZ6STMhfCfnlcIksH6lFcgl1iRc5Ipz40ciRwj5/xUiB2quTrrBfw1cgVpJYFMbyFi
         wLkm/B4u1iW579uXJIrcTAmAqLtJgXuQlTr0Jw8TE4vUm+lyJaDqm+THT2m14yyN/64A
         qOkwxIhzTLvBmqaLWYpt/YgXsfKu4Nl9ZprsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vdQE3ckXVQaQMZctNKe7+WI4MMPWGnzLaa/Ga3pSK5c=;
        b=XBjGbBlpDLHucCs72k6WZERqcX6Ekw8FXAKO4KtnCCrvJMBV+yMj+MSpGaeX8ali+y
         mK985ppZcyrnqwSsN9Fz9EtIRL0hLcf50WPMdZfODwpLpGO/tv+PM/rA/U1iQGl7YqBq
         THj78o8H26A86j6MyOSMiFTcAL9zS+bE/PYbUGF5ti66tAl30EYbmUD/r8+SVZXpT0LG
         ML0bvEjT+v8uXBQdmeND0dv+r+UTQnBc+jfQJJ6i8y929LFZ6Vg+CGxw25cAdQSlXp4q
         YxvSKBzFwqC3dazX1wzrfIgVUn9xMwyE+u4KLUvgkbx20ghnymplSoAwObDXALuBiZ8o
         Mlqg==
X-Gm-Message-State: AOAM530SON6zk9EI9uB15zUh25MwZCn5tCO05QUpu1RNzq3FAtxH2Fnw
        YoT83o8taVjW2+89aAJ4splhYA==
X-Google-Smtp-Source: ABdhPJx3+jtNnnJd5zpPHLfvhbuFAhJz5nokpNldUaNYUUJcrj2heuGLYxm1XOgYFBH0L7ukexa7gQ==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr3515645pjb.132.1598039641368;
        Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l9sm3165356pgg.29.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
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
Subject: [PATCH v6 21/29] arm/boot: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:02 -0700
Message-Id: <20200821194310.3089815-22-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker script.

With all sections now handled, enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index b1147b7f2c8d..d6cd2688ad7e 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -123,6 +123,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-- 
2.25.1

