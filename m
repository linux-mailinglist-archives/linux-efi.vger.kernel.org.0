Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E6C234E04
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGaXIw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgGaXIr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:08:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E34C061756
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:47 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d1so18093774plr.8
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fvfmv1pkeySd5rhFrbyIXZ4JfyCoyCYJFNM80B3DKYE=;
        b=aAYyzLqRht0RjACUdgP4u4orVtT1N+9rM+6wDYOhAO8J3OrIgLuULyOqBdQF2jB9u9
         3UO2dmOZtBDJjKgmNGFBoyyWmY1ZZ+KzUszzWaodH4ILF4Yam9LnrhKqQtFufR2rFdXK
         mwdnqkVbzqxdoZYqTw/yCO05qmIRW7P9N7lvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fvfmv1pkeySd5rhFrbyIXZ4JfyCoyCYJFNM80B3DKYE=;
        b=EeTzTdqsbMn1V75Jgk6OqLAgoC5veVgNGKcFeGxVSCbhbmnAieNCIONNVK5pKTVG1C
         KX2qOXBbn4Fcy8BTgAti1ZRLLx3C96vIKULywvNTo2Cht4dnt9mPlnI7EiGfx0dIP/Sk
         48vbp0TAnu3wd3a6l5WNN90s2LuSoB5FHHPD6OgQNqVOd2A45hC5ul7wObKrpnZZUiYw
         nO6UlLz0K/8JF+CKWCS/thWI5ZN3opGVlMHji/Va3Qwd5OayzpEFHICSMrHgYnbmH7q3
         KWYcbJ9dkdRbh/HeyzzoHPOh2KXLF178HsSaN6ZwPpIjqgvGelvGR/yRqFWmYrm3f57h
         K3nQ==
X-Gm-Message-State: AOAM532JvbxV2iIXMcxx0a460s8JmoFE/p6lcgf52H9v1Aoy/8S4ojed
        11Se0KVtXMtfzG8NpuEo7rRIEQ==
X-Google-Smtp-Source: ABdhPJyTbjxU6udMes1jYiYIIX7MKKjWY1Mw3PPzC4UzPfsmw/m6MU0LN/hYrEpFJNIw2rm417Cx7g==
X-Received: by 2002:a17:90a:e96:: with SMTP id 22mr6250841pjx.135.1596236926893;
        Fri, 31 Jul 2020 16:08:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f89sm10357189pje.11.2020.07.31.16.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
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
Subject: [PATCH v5 20/36] arm64/build: Assert for unwanted sections
Date:   Fri, 31 Jul 2020 16:08:04 -0700
Message-Id: <20200731230820.1742553-21-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for warning on orphan sections, discard
unwanted non-zero-sized generated sections, and enforce other
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4cf825301c3a..01485941ed35 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -122,6 +122,14 @@ SECTIONS
 		*(.got)			/* Global offset table		*/
 	}
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18,
+	       "Unexpected GOT/PLT entries detected!")
+
 	. = ALIGN(SEGMENT_ALIGN);
 	_etext = .;			/* End of text section */
 
@@ -244,6 +252,18 @@ SECTIONS
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.plt (NOLOAD) : {
+		*(.plt) *(.plt.*) *(.iplt) *(.igot)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
+	.data.rel.ro (NOLOAD) : { *(.data.rel.ro) }
+	ASSERT(SIZEOF(.data.rel.ro) == 0, "Unexpected RELRO detected!")
 }
 
 #include "image-vars.h"
-- 
2.25.1

