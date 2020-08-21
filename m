Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B60A24E143
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHUTy2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHUTyG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:54:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F48AC061574
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:54:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so1358603pls.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1pLED4dOZHjJehTtWdStx3hbiXOC8sBHN8PPW1XfeE=;
        b=PH6uKvVhsYajnUeu9WI2S5GhMXGTVSnkPRxAIXL2PQfyslzAd+tUmyU2hUVqyaQiNq
         R753MmTdw4LGV1AeWW4YF/PEX9V5Kij7VQwCWXLgHNxh+7mIIWrxJDxeVUGxkMY13cGg
         ETS7WkMSrGy3ull8otZSIbk81u4Ez6PoMkmzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1pLED4dOZHjJehTtWdStx3hbiXOC8sBHN8PPW1XfeE=;
        b=I5/g7C+2iMXkeTmmLxJ1ThVu2cPKicLCK1yrkyxk6S4l/BoHtrgpWYRO45yCP972HP
         bz3iXrAUh/sauSPci0V6L+bBzbMQAReGbscfaqs/4DVv2lpbVzWNnw6VwPea8jf5RYpQ
         pEm1SuyISTYKAp6j1xf73U4BLpKoY2qCFeiTTctgljlKBeoR4d5WiigI8DJ/zbS7NpGi
         RKtLDILNQ0C9sXyV5j8JeW5H8dqD+soQ+8rmhUHqvxS2TP2kxeIlumwQW6BlJfWuVmzS
         0Zurfl4D2pQdT041NWiKfU2q2ZFIv1CqRaGn7zpj+ZVEkDeITdPcovpgJK6DiQVRY1fQ
         YfnA==
X-Gm-Message-State: AOAM531F4sgoypUf8q5t3oIOlo66ieIz0BWvTM3BRvnVjBRffExIEjX3
        m+6PAEWPP44s4U7dTwj+S0vjlQ==
X-Google-Smtp-Source: ABdhPJz0nuBd9Wk5RpEnkrKlLdMQ6PcV+wFlYs/rvYLJ53wHdBdXbAoFW0IM+5VNqofeAUl0Piyg0Q==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr2567999plq.239.1598039644162;
        Fri, 21 Aug 2020 12:54:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18sm3442336pfo.21.2020.08.21.12.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:02 -0700 (PDT)
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
Subject: [PATCH v6 29/29] x86/boot/compressed: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:10 -0700
Message-Id: <20200821194310.3089815-30-keescook@chromium.org>
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
versions. All sections need to be explicitly handled in the linker
script.

Now that all sections are explicitly handled, enable orphan section
warnings.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5b7f6e175b03..647e15837a28 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -54,6 +54,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += --orphan-handling=warn
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
-- 
2.25.1

