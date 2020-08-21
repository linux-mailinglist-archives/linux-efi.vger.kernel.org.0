Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585C024E0F7
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHUTp1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgHUTpI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:45:08 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F76C061797
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:37 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id kr4so1263535pjb.2
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnzDApNoxwO5pBe0Rw0QWzekBEKvTuf/gsd4zpzC+NU=;
        b=UoERYCO24yjxw/nfIGuRfWgjYp/IIpMBbAVGy1Wh0MBis2sB6JQnzFux8I34fXIfzL
         XiTwAIwqPF4tOCBbtkjo2duqIpNp4WHF09n3SLEANmWxObkZKlAhR7FwKcJlzhd+gQgM
         C1S+79RksYz2j/ZELEmvpwtea99u0tMD9V+xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnzDApNoxwO5pBe0Rw0QWzekBEKvTuf/gsd4zpzC+NU=;
        b=hbW1DhpCgfL0pEtB7QWzw9sEovT+ZyWVvoefoipOI/dewUFm0yW87HlqJG0CPd9aKX
         9hdvvgA4uaq/1wAzi829cpvE4I+9DNaCtslWO5dFMUu+yKX2l19QuwidIqBWobVNowvW
         saJFWRC4MT8WbAQegJd+HnVw6r7pPd1n+b4GD3cwRPC96ZD24qLAomy8sizGvrwGBBmQ
         yhoqvJrlBJ01eICUra9uYlVkUjVNaQopKvODPa8d4K2DIeVPQ3O6ndPAYew+ZJQYqM3t
         1b/X7OnT1A5aYkouGKD7IFSHaSvyDeqP01dYiDG/tDKMRbJjrRHKR2k47M4pzCIwYASz
         N5jw==
X-Gm-Message-State: AOAM531efI/ZFtg5JWLaHL40zoyW0P5M3czi5Pia45gzRFnTmdCWRgel
        8uGSyicQR9zbb384EDyTDmOTyQ==
X-Google-Smtp-Source: ABdhPJyu0JBnryH7c2ygqsir+GpNNDwC3kcAJ7djAIPlnuSXRNo65MZU7eflxCCpW8/XD/Xeo3NXaw==
X-Received: by 2002:a17:902:ac84:: with SMTP id h4mr3560513plr.334.1598039073450;
        Fri, 21 Aug 2020 12:44:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o7sm2570901pjl.48.2020.08.21.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:32 -0700 (PDT)
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
Subject: [PATCH v6 24/29] x86/build: Assert for unwanted sections
Date:   Fri, 21 Aug 2020 12:43:05 -0700
Message-Id: <20200821194310.3089815-25-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for warning on orphan sections, enforce other
expected-to-be-zero-sized sections (since discarding them might hide
problems with them suddenly gaining unexpected entries).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4b1b936a6e7d..45d72447df84 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -427,6 +427,30 @@ SECTIONS
 	       SIZEOF(.got.plt) == 0xc,
 #endif
 	       "Unexpected GOT/PLT entries detected!")
+
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got : {
+		*(.got) *(.igot.*)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+
+	.plt : {
+		*(.plt) *(.plt.*) *(.iplt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
+	.rel.dyn : {
+		*(.rel.*) *(.rel_*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
+
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
 #ifdef CONFIG_X86_32
-- 
2.25.1

