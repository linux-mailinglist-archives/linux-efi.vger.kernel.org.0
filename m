Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6CC234E18
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGaXJU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgGaXIq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:08:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76AC0617AA
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so8528070pjb.1
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nwDvJc+EBCTytPh4qqWJPqBQ1Pj/7rvDlMkI2+6l3fI=;
        b=JOAqMVCWrPdajqN1Taychqd0iPhCdsc/6VYR99HVk3JsgeEiGpgjg2Z9E7W4gFUUmF
         ee4C8x8jOufyDVX5njp8VPjBuIasRahkVmjaxpNMFWb6v49ohzPS9pBDXECueYvkiEJ/
         W9bbijKixILXX2dC5o0Yg3bGNPJac4Scw7dkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nwDvJc+EBCTytPh4qqWJPqBQ1Pj/7rvDlMkI2+6l3fI=;
        b=LscKRF839yix+BG2gjJtA68R1tF9bL8HkC7p04sWFiRLqrJ6PwzhgcXyNGW0MrolP+
         qOg2maEhqt8IitbfJ+t+k05oYFqto3OHSUfG3nuaeUTQZk2hw/irhqsSySU6YkQJ+9qs
         usaE5da8hMrwK3vBjwahTMHPt6lJijYbRASvgOhjfiHH8cVWM1m/joiIsvKv86h2MkCN
         6RilI+izt4DlznY6RW+Kn1X+K+msO0ZHdhABWzUBv6nBm5ZhQLT+D19rufbVrPtEOIma
         nfF5bv6Vn3YB/8jO5GDWf204jS648wPyJv/HYPAvkJ7kaWakwDPtFScjGBWL4lfLMLu0
         xsjQ==
X-Gm-Message-State: AOAM5322RAO36re1D+nqEyDvGwf3OCyUQbK0q7i4EQbXavHYldJdlNAO
        QWi40zz4NpfWVd4pshQFbEOh5w==
X-Google-Smtp-Source: ABdhPJyd3PIVImTfcm8vqmhCuvx32RaOUUUS9YkPvP10EV/gwv2je3TLyVou0UCk4tW9MggDonnqiA==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr6354230pjz.82.1596236926030;
        Fri, 31 Jul 2020 16:08:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12sm7292673pfr.143.2020.07.31.16.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:08:44 -0700 (PDT)
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
Subject: [PATCH v5 30/36] x86/build: Assert for unwanted sections
Date:   Fri, 31 Jul 2020 16:08:14 -0700
Message-Id: <20200731230820.1742553-31-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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
index 7faffe7414d6..d8792f9c536f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -415,6 +415,15 @@ SECTIONS
 
 	DISCARDS
 
+	/*
+	 * Sections that should stay zero sized, which is safer to
+	 * explicitly check instead of blindly discarding.
+	 */
+	.got (NOLOAD) : {
+		*(.got) *(.igot.*)
+	}
+	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+
 	/*
 	 * Make sure that the .got.plt is either completely empty or it
 	 * contains only the lazy dispatch entries.
@@ -427,6 +436,21 @@ SECTIONS
 	       SIZEOF(.got.plt) == 0xc,
 #endif
 	       "Unexpected GOT/PLT entries detected!")
+
+	.plt (NOLOAD) : {
+		*(.plt) *(.plt.*) *(.iplt)
+	}
+	ASSERT(SIZEOF(.plt) == 0, "Unexpected run-time procedure linkages detected!")
+
+	/* ld.lld does not like .rel* sections being made "NOLOAD". */
+	.rel.dyn : {
+		*(.rel.*) *(.rel_*)
+	}
+	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
+	.rela.dyn : {
+		*(.rela.*) *(.rela_*)
+	}
+	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
 #ifdef CONFIG_X86_32
-- 
2.25.1

