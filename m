Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C43E20E064
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgF2Upz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbgF2TN5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:13:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0C2C08EAFF
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 67so3379242pfg.5
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0c7XOOnQF00ZfjeTQGIw9PaJthVip/aX3zS1dRtJoE=;
        b=M9ZSb4qoWIq549nkDC9nITi2Y+iOVB3dYWRDDV3WRmfzVjtQks65kDEF7l1+ij9SlB
         Ohi65fuChmNNYze5qrvJVk6IOjVJ/rxa8jvdv0qO+qmBCzMBaCbtUOo4//H/OjguzP5R
         T/UGeSUbVaM1bo/CG0rdGvwUKCmIM2bIikow4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0c7XOOnQF00ZfjeTQGIw9PaJthVip/aX3zS1dRtJoE=;
        b=O9YXWscC75/D/vsy6XeRBxz4XH52dJYV8VgMF8Ad2EXhNZRqUrcOyR1ia4mTpUQu/G
         r4mL13ptTtTiCybbXioDUlAS8nQZiiQzpkSlbnyeXnypwLS4K9DKonBN0kzJLN9hJDEN
         XWNHzoZ9Rby7tNMc1LqrimWDUKYDTmleC0Kd0/R74FbeM1yAfF5UstKSaVRP9QEJqmHm
         zTHGL7ICnwlbeVyMc6oF1S9NwYV1l6EHqANg/MO4CjBbLQ3ir7eYp+hOk1C6nSsk6d5X
         4wMTDFkNuPpNAir32g1mBqw+lfpmJOd7BVgsORG36wlz9rPRKsnUswI5yXUapdxDcE/P
         Ib5w==
X-Gm-Message-State: AOAM533LKf7Xjryw7a4qULyuEBGdBGCvMV8x6DaP+FRORMNMz8d4klg4
        uZ3qZ3Rh24I86VDHdtH5tEUflQ==
X-Google-Smtp-Source: ABdhPJw58QIF5f/Yv5c9CUFM9Nx42xHsS2ePKHv+mXeT2M6dXWhB9Q/p3SvpYavVwb4WSrkztjUiRQ==
X-Received: by 2002:a63:4419:: with SMTP id r25mr2949678pga.198.1593411530134;
        Sun, 28 Jun 2020 23:18:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm34391423pfk.86.2020.06.28.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v4 07/17] arm64/build: Use common DISCARDS in linker script
Date:   Sun, 28 Jun 2020 23:18:30 -0700
Message-Id: <20200629061840.4065483-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the common DISCARDS rule for the linker script in an effort to
regularize the linker script to prepare for warning on orphaned
sections. Additionally clean up left-over no-op macros.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 55ae731b6368..b5a94ec1eada 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -89,10 +90,8 @@ SECTIONS
 	 * matching the same input section name.  There is no documented
 	 * order of matching.
 	 */
+	DISCARDS
 	/DISCARD/ : {
-		EXIT_CALL
-		*(.discard)
-		*(.discard.*)
 		*(.interp .dynamic)
 		*(.dynsym .dynstr .hash .gnu.hash)
 		*(.eh_frame)
-- 
2.25.1

