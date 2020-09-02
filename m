Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057E625A331
	for <lists+linux-efi@lfdr.de>; Wed,  2 Sep 2020 04:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBCyA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Sep 2020 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIBCxy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 1 Sep 2020 22:53:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B75C061246
        for <linux-efi@vger.kernel.org>; Tue,  1 Sep 2020 19:53:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so1585521plr.5
        for <linux-efi@vger.kernel.org>; Tue, 01 Sep 2020 19:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gClGbep+iV5WfCNFybEdnpd2yOKBqRu+dgKC1E3FLqg=;
        b=etH6NKPqvQ0E/BEfK1vGJeNK5TqdvKBju+PVw+Mb41Om+kz+V3liIydjrFcRux4SkU
         v05mxqn5MJF8kH9X94XWKQG2jM7AFeMLaNS02HEIB7YHiurUIEtkT+i/BFHv0qdgbId+
         JfK1I292Rf3BQCyWOqL6J7XZBXjo/fSJ76OhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gClGbep+iV5WfCNFybEdnpd2yOKBqRu+dgKC1E3FLqg=;
        b=SB8+p60+QNppve2OtbHLcmsFz9tqjyz5lGkX+fkTT+ZYs1L25+vgg8rb/lHv4KZfeH
         1ld6+chuRXd/FSZlid8uz5leIJAykLaHhtDh9uEDdStl9FCbDhww1xvzQzLDpCOiBLlV
         /ISx4PWuOTGy8J74oKejy46IwDOSz53YLoR9+zV2Rfvzrew/eDnlXPnchmGHWxqpJq97
         0izd8jTT1ESmUniDvPAPkI8csT/Ct1L16NZsuyOXGF0/GYPYd1RJyAkB4Qn9Ihh6ZNjs
         u/iyPdxFSLTQgRPgzCjheuhgA/pNX9/b78EE3RESCLaZ1hlZywi7B3/EXivndurPNOFO
         6New==
X-Gm-Message-State: AOAM533keJDHjlHIsZWP3Uc8Kv7Zo1V2vGS5DiDmfph/sLkQnhXdGcRk
        QZutzl/+Bnv0dyg7I18O/ccX1g==
X-Google-Smtp-Source: ABdhPJzgc+AwMOXYevHKlYRL3a9Gq1SPcptqwTmA/q6SZkJHgbLxcLNKxPWoUeQVwVN+9q7tAZgD6w==
X-Received: by 2002:a17:90b:4d0f:: with SMTP id mw15mr256915pjb.174.1599015231590;
        Tue, 01 Sep 2020 19:53:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm3597155pfr.46.2020.09.01.19.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 19:53:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] arm/build: Warn on orphan section placement
Date:   Tue,  1 Sep 2020 19:53:44 -0700
Message-Id: <20200902025347.2504702-3-keescook@chromium.org>
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

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

With all sections handled, enable orphan section warning.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4e877354515f..e589da3c8949 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += $(call ld-option, --orphan-handling=warn)
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
-- 
2.25.1

