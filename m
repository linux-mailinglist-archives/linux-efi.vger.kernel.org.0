Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B772234E7F
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgGaXSu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgGaXSN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:18:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3906C061756
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so4689473pjr.0
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DcAsy2Kya2vQqvsN7ZPWA8EbcQkwVEcJexXEETLKJik=;
        b=Acdhtx1taL3cJ0UonSyJvk6bfFnzMNMb/OtYeoW8WVgIkiBmz9TPNPTuYBMmsdYmlO
         sAcW9XztYuDymTfimZLg8+HmpaYdTmmT8tF/BpBGfhsLUyvDHTtHASScwa7qJiTP1nko
         Qv/5rrTmKuRHOM+nwd77xCgRKODhxuUNBL7Ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DcAsy2Kya2vQqvsN7ZPWA8EbcQkwVEcJexXEETLKJik=;
        b=IVUi9SoYhqYi59BOOhvaKYq+q4mdHLyRKvvnuLK/CZiCgoOc52VNTTSuFObTElU5sg
         yxj7BnX2Emb+ptkF/cSols6C+1+1W8VeaKv/XGi0mpunUkWxlJGWq3c71YBFyZYH/dwu
         6j9yvNXu4Uo7HQRgKV3Px7nrNSX1F3epiqaxVtPiuimyKpkmDn2j6vjynQCzBBvmwGem
         DiWF8qJNbcx8hi0rSM/4U76V66+6nV+cr9dNXKoUaZi9Q0/ehP4Tanis+95/E5ORs2iP
         MZjOt4K7zGR0mVfPWHV5Gb0VhpEMtuBXp7hR9mc7kFvtHT/+uhBh/4KSeRiGpQuB/ui1
         8NDw==
X-Gm-Message-State: AOAM532APFEof80e5qdMDYUJmzC9nqvg3edgP4fDZKswohpWviOYOK+w
        FadUByK0r+p6LIN3AlcRYcM35g==
X-Google-Smtp-Source: ABdhPJyzzUS6jU3nY40Z2QdxjoOaZJ0MXEzHC7GLhL52i5IAnjsxzb7V9wPgftjtuphwT5Pu7c20Lw==
X-Received: by 2002:a17:90a:8d06:: with SMTP id c6mr6370143pjo.137.1596237493405;
        Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b21sm11163353pfp.172.2020.07.31.16.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:11 -0700 (PDT)
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
Subject: [PATCH v5 29/36] x86/build: Enforce an empty .got.plt section
Date:   Fri, 31 Jul 2020 16:08:13 -0700
Message-Id: <20200731230820.1742553-30-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The .got.plt section should always be zero (or filled only with the
linker-generated lazy dispatch entry). Enforce this with an assert and
mark the section as NOLOAD. This is more sensitive than just blindly
discarding the section.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 0cc035cb15f1..7faffe7414d6 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -414,8 +414,20 @@ SECTIONS
 	ELF_DETAILS
 
 	DISCARDS
-}
 
+	/*
+	 * Make sure that the .got.plt is either completely empty or it
+	 * contains only the lazy dispatch entries.
+	 */
+	.got.plt (NOLOAD) : { *(.got.plt) }
+	ASSERT(SIZEOF(.got.plt) == 0 ||
+#ifdef CONFIG_X86_64
+	       SIZEOF(.got.plt) == 0x18,
+#else
+	       SIZEOF(.got.plt) == 0xc,
+#endif
+	       "Unexpected GOT/PLT entries detected!")
+}
 
 #ifdef CONFIG_X86_32
 /*
-- 
2.25.1

