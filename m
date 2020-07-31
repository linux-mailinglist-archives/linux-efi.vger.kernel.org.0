Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC24D234E08
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGaXI5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgGaXIv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:08:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4782C0611E0
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so8517386pjq.5
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84268jPgmFqAzbh6kvNmngGGyveZ3rMo3Gva+KPIY/c=;
        b=Lr9or3Hp0DSvQYElAg+xki465Vdb1uAtDe85PRDbs1d8wZ08VYB9OlhllbtENPVieR
         V70iE3+WoadE5MGnu8i8GLUrfRA1t5+LbrYMwG75g0Vr4sqB1S8u5be8NrKejxdMS7gm
         byUy6rMjO1J+JL4A2Xwyw8hGAHymoJEGFEhIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84268jPgmFqAzbh6kvNmngGGyveZ3rMo3Gva+KPIY/c=;
        b=rXIiLjqewclGtAOMb1AlO7lrk0dF5wlYLbG5+LjvbsthvDoRIa5A8gamP+TVwNtiWA
         tSnxGmtFahJTv/yAzx/rUXEvKvGjmu4ESDVRPiNPBDFlLy6hiKNDe2431iW0m7smAd7f
         quLUpGfyb1/xAkpXasZcjp5n7H/BMtvdxBKsDY22uY8lwgrn3AYGUtpqCqgdJE9elQNK
         u2F5D/hnFIbcwu3YjiMfHKBy3XljkPb2yNnC83eZne6xvYvzOMBpSaf6Xx7njArMxrmC
         bOWUliojS7PVWIQd4P5fWayMgb8yvlx+wnIrb0WkJzIMVSxo9diLTwvwbhutGR09vHsW
         PivA==
X-Gm-Message-State: AOAM5331dxfRgNOJQoEajrouyoAordOV6gTKPpooPjSEijIqZyASh+z5
        5cF3PFPYAlI8DFxIUItIvtSSdg==
X-Google-Smtp-Source: ABdhPJwhHCIH/rXPbloue7Ao7LwdLWcpC7pKCtwRdsLSguHj3gdxjmuhn4CNI2OYzSlwA+KLPraTmQ==
X-Received: by 2002:a17:90a:d252:: with SMTP id o18mr3631713pjw.146.1596236931297;
        Fri, 31 Jul 2020 16:08:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y18sm11218113pff.10.2020.07.31.16.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
Subject: [PATCH v5 35/36] x86/boot/compressed: Warn on orphan section placement
Date:   Fri, 31 Jul 2020 16:08:19 -0700
Message-Id: <20200731230820.1742553-36-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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
index 43b49e1f5b6d..f8270d924858 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -53,6 +53,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
 # Compressed kernel should be built as PIE since it may be loaded at any
 # address by the bootloader.
 LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
+LDFLAGS_vmlinux += --orphan-handling=warn
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
-- 
2.25.1

