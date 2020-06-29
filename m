Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88F520E23A
	for <lists+linux-efi@lfdr.de>; Tue, 30 Jun 2020 00:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgF2VD1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 17:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731137AbgF2TMr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:12:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D0FC08EB0A
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so7455468pfe.4
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2gkWNX3d66L/hKh2STsGvUucTtZJRcz4r/ewyLA14w=;
        b=EwIeltjGnlLT7TimPFoW5tYhE4Etaftjgk0utIv1DERQIoaBLaCrzZdEMEbl2/ko2L
         EIAKTruY9wYrBxsUO8J20gzMkX43dcOFiRkqGRmfq8OMnlhw0L7j5pNYBiu1NorElQCk
         0rG1LKDuU8dxAvdd7b1IG3oEzj54pXm3LMXCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2gkWNX3d66L/hKh2STsGvUucTtZJRcz4r/ewyLA14w=;
        b=b3SztbLP+Cy6WlsyhLmYljKjAN8+R4pfk0Od38pSRZDIEd80D1BtU2CKRarV+la9JD
         Krok6P7kPUSqtMwEC/P9lhwO2S5OBDfOJ7AvKI5Xv+4tGz9uBYpIs6exqEmow4VhnQUV
         610916bDPUpQdgvUOa2uGxlaq/FZDerUalt8fnBAU1JCa3LPcERu3/p7bMGwnZP/zl+P
         borCt6y/eswZc7DpnrDIDz6fE9245Vj11L2PulXA0fNxzYJiDuCgLKdVIz4ORLVOwxsL
         u0gf/v/D2GryTZesdfIl2XK0ZyxlNNyWMkWMHl945aPAiq8CYgT1b9OSZ7O7OwyiD0Hf
         1PcA==
X-Gm-Message-State: AOAM530Z/+RHa+ZE4o66wx7Xm5f6zZGDmoyg4eFFNmKGckRAZz+7jRQA
        KH/XtOjmfacQOYPEEdIk8f45oQ==
X-Google-Smtp-Source: ABdhPJzd+VgRMDjRj70nfxA/PtEMQQFRxNgIvA3+idrGBzG3XC8iwLb7Qy3efrxK+yKVlZZEtao0mA==
X-Received: by 2002:a63:7802:: with SMTP id t2mr9139650pgc.421.1593411532102;
        Sun, 28 Jun 2020 23:18:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d25sm28162513pgn.2.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v4 09/17] arm64/build: Remove .eh_frame* sections due to unwind tables
Date:   Sun, 28 Jun 2020 23:18:32 -0700
Message-Id: <20200629061840.4065483-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Avoid .eh_frame* section generation by making sure both CFLAGS and AFLAGS
contain -fno-asychronous-unwind-tables and -fno-unwind-tables.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index a0d94d063fa8..895486606f74 100644
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
-- 
2.25.1

