Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111ED25A336
	for <lists+linux-efi@lfdr.de>; Wed,  2 Sep 2020 04:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBCyU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Sep 2020 22:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgIBCx7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Sep 2020 22:53:59 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451DC061247
        for <linux-efi@vger.kernel.org>; Tue,  1 Sep 2020 19:53:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 5so1794210pgl.4
        for <linux-efi@vger.kernel.org>; Tue, 01 Sep 2020 19:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVX5iGApWsA6cOcKpocM02MsLs3Cms0hUFmAcEqMm6M=;
        b=Mmg3k909Im5tPr616qMO7eR07LAJFZClo5qultGvx7lHP5OI+oj6Z0PZ+3rp3MvDA3
         EKIdRq33UoHLNu/CJNmyG2b1rFixQhYPrXAA7dqL2iwb7efBZBRwDdWCR5SgWF4hYhHi
         lpG+N67GmcyXWCsOwQrq7S6QnuK7PbTqvLQO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVX5iGApWsA6cOcKpocM02MsLs3Cms0hUFmAcEqMm6M=;
        b=AIUrZFjuaAN6ej/xgPghLm56fVgAMyC/3S12G+odEhvBPc2zuLtx71fl6YWY/G6qKD
         tiUeLwoZ6NrgFizbKI1fpI5XoJ0qOH3rXelOSCmvHNcs9m7qa6/wECdbbWHrzgj1mqZT
         YZrict8LKajRYmW0djFFmu6bebpw8/6WEbc1PeP//Dez5Zatxdd0DCQ4YnhOIASa6L5n
         LtvsjxzhgtaU7zsX6PMywKIQtfssIMZsFhv6kKCxZlnBys8+eTCJlAbQg24npAQ/gFH9
         37DJikL0VNgcFMEurAt/NprgV9iyBj7V6NojbBW07ovCi2oeWrJlLPA27Vcau3OOkDkS
         L9/g==
X-Gm-Message-State: AOAM531mdmHfZA7k9t3bC4LwAehnA4yC0kj4TIL1N+MeXlP3JJvGY/LZ
        39b4vqGQltBN7BXCO/1HZ9Wetg==
X-Google-Smtp-Source: ABdhPJxr15UxFlZO57N08QLgROI0XgkvScTspshNJ0zdFmYYhSNaiyEAMbuocRhYqDliU1QV3ZPnLQ==
X-Received: by 2002:a63:6d41:: with SMTP id i62mr199101pgc.279.1599015233901;
        Tue, 01 Sep 2020 19:53:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7sm3438860pgg.10.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
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
Subject: [PATCH v7 1/5] arm64/build: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:43 -0700
Message-Id: <20200902025347.2504702-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902025347.2504702-1-keescook@chromium.org>
References: <20200902025347.2504702-1-keescook@chromium.org>
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

With all sections now handled, enable orphan section warnings.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6de7f551b821..081144fcc3da 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -29,6 +29,10 @@ LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
   endif
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
+
 ifeq ($(CONFIG_ARM64_USE_LSE_ATOMICS), y)
   ifneq ($(CONFIG_ARM64_LSE_ATOMICS), y)
 $(warning LSE atomics not supported by binutils)
-- 
2.25.1

