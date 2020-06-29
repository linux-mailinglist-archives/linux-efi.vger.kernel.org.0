Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB20D4EC
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 21:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgF2TMp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731084AbgF2TMn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:12:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF746C08EAFE
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so7569362pjf.1
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx4qtxhnzkaAUuvKla0BBnxBLtInQMeed/tdFBRnaf0=;
        b=SPivvXbhkz1HNs4hv3hB3lAGf7mxY7QzuyuiHLUvE2NTzUDgKcMtvoCr5OvTnpEGNI
         BKEe727LLu354Czz0UrLwsb8Oq9z1awx0ZhcCb/nUDxWPW65pd8mBz8whR+nh3hBfift
         6e7dxeB4Nqxb9mSsbs5XD4usOXZc+u6wbNETc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx4qtxhnzkaAUuvKla0BBnxBLtInQMeed/tdFBRnaf0=;
        b=LmNlxu8pfEhc+7Qc1qUL8ykWHkHfT5DRO3wG2hzOxVk3+bVCaD/bo2RAvBiFgGzANs
         WdrM0LAxA0kAH7xYMGe7l+Q5UZ4lM1D12VOgu+ZE9dVZjO+GrX5TFm5WRZ+09/WiNUaY
         zLR/1UVkBrlEvCwKo7KYAm4DpAiG7GNP6o8wL7+uu3GquNoqkFFRc4YcvV7JZNtf9Mow
         8LZkn8fGWngtfg8kprSh9w/dxaFNigaR1kIJ5zi72x8FvTP8Bg3onK/3X5ai92voe/cW
         iMOWoAyWGYOUVvNra9HuiE9AiidMtmG2pBzLtmsC/KDkGb5r6TjCMlKzkuxgu582IoaJ
         W0Bg==
X-Gm-Message-State: AOAM532nk9aNfXzGLTPRD1DqoWjPhYO02ATDBZ6FjpeAX50o6XQdl0P8
        GexIJsj8YAcI027nbDeAW9Zj5A==
X-Google-Smtp-Source: ABdhPJwNi3xJzPNT7Gdq2Pw3b3VdTrLvNjNwn9RzBwTGL5D87SEILQ2r1+XLJOB0Z/PotUqW7oYIyg==
X-Received: by 2002:a17:902:6945:: with SMTP id k5mr11956092plt.336.1593411529540;
        Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n65sm32225037pfn.17.2020.06.28.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>, linux-efi@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/17] efi/libstub: Disable -mbranch-protection
Date:   Sun, 28 Jun 2020 23:18:29 -0700
Message-Id: <20200629061840.4065483-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for adding --orphan-handling=warn to more architectures,
this disables -mbranch-protection, as EFI does not yet support it[1].
This was noticed due to it producing unwanted .note.gnu.property sections
(prefixed with .init due to the objcopy build step).

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: linux-efi@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..10fa342ef40c 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -18,7 +18,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
 cflags-$(CONFIG_ARM64)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
-				   -fpie $(DISABLE_STACKLEAK_PLUGIN)
+				   -fpie $(DISABLE_STACKLEAK_PLUGIN) \
+				   $(call cc-option,-mbranch-protection=none)
 cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-- 
2.25.1

