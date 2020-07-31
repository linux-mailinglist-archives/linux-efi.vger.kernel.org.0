Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90986234E76
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGaXSm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgGaXSS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:18:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B9C0617AA
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b186so4903545pfb.9
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCXoZ6vwcRTLoMlYpWHYOqZEmN50vC99VSBByVG6tNg=;
        b=gQ2kBPm9q0b4ouhPZ6T6zt99vNNF0eP14E7gJXRtWUIvU4j82+oxEfdDO2Pf/0XU4P
         w09ztBEuvHLJCydLNM91dJEnFqfK0fQKKtDUFCjJ+figlvB7P/2cn3GD7GZ1HNX+R4jA
         H1vOnXWTO7NByBLNOYfBGd1Dt2p269tjKBwrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCXoZ6vwcRTLoMlYpWHYOqZEmN50vC99VSBByVG6tNg=;
        b=rolzuuiYJZ60qh426jyJrwYg29wud1teu6LvERY/bf+SpcifBBtMq3cCAlyIUpLvsy
         Bb+teUyVzSItkmtdlhk+hWhfZsB5G+/5KuR9qufFhVp/I3uhsP8Fk8IjeJ9f9gImBwsv
         NZfTDsXuGR2NYKnTmtHDJUxdRShnpLExzr7VhIoAt68rUrahK4WLZbOxxHY8Gp7FVh1a
         rjxNWb+aOnBbQSJzqeGikFJQQp+b+JyhKthNSo6Estc4JNoubJotmiWMdnIWupHcl3IP
         YvXAMhjHpjnwDhfAP4xkGS+VuOTapq0jih26GALOUFKE2m4DK8dXXMsfH2j4EwrTheGl
         ukug==
X-Gm-Message-State: AOAM530bswg5rKjCy7n+JGkT0kMvWsU8EZdxkz2ZIFnQd3iZnxkhTzRn
        3csmPgFYbwHJpIEsyYe36yFzxA==
X-Google-Smtp-Source: ABdhPJxykfNbyUgTzEuAmMvQ2SlDq9N1S3QBPoWqnwl2G3pY+OaKurGdTDKceGp+pjJPCmAQjYtSBA==
X-Received: by 2002:a65:5c43:: with SMTP id v3mr5559806pgr.214.1596237496666;
        Fri, 31 Jul 2020 16:18:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm10923285pfk.46.2020.07.31.16.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v5 17/36] arm64/build: Remove .eh_frame* sections due to unwind tables
Date:   Fri, 31 Jul 2020 16:08:01 -0700
Message-Id: <20200731230820.1742553-18-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Avoid .eh_frame* section generation by making sure both CFLAGS and AFLAGS
contain -fno-asychronous-unwind-tables and -fno-unwind-tables.

With all sources of .eh_frame now removed from the build, drop this
DISCARD so we can be alerted in the future if it returns unexpectedly
once orphan section warnings have been enabled.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile             | 5 ++++-
 arch/arm64/kernel/vmlinux.lds.S | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 70f5905954dd..35de43c29873 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -47,13 +47,16 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only	\
 		   $(compat_vdso) $(cc_has_k_constraint)
-KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
 
+# Avoid generating .eh_frame* sections.
+KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+KBUILD_AFLAGS	+= -fno-asynchronous-unwind-tables -fno-unwind-tables
+
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
 stack_protector_prepare: prepare0
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index df2916b25ee0..b29081d16a70 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -95,7 +95,6 @@ SECTIONS
 		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
-		*(.eh_frame)
 	}
 
 	. = KIMAGE_VADDR + TEXT_OFFSET;
-- 
2.25.1

