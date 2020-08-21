Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3724E0EB
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHUTpL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgHUToo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:44:44 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B491FC061385
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so1246020pjx.5
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuU6+2YeRUFxWKjj7Z5/wAYkCT2n/Otc0iy3c5gDK6c=;
        b=GlR5zQFUZPyZN2xj2JZwbsd+nhmW4YrsAiNDspKlZSHIVFCaiwpu22zpQk8g1mPkD4
         uL0gfTyd6RZ41fhOBJ8O7qPIY2yarQAieyWySyZtzw9F84HAFF/dGTHkR8qjcoeeFhLR
         kxmlF5bkG7LX0OWEqpt9f6F/IKJimzW3fMjFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuU6+2YeRUFxWKjj7Z5/wAYkCT2n/Otc0iy3c5gDK6c=;
        b=b/amx/jQmJ/yAolUDskDGZqg69g+wzRHQ4XaAilP0wv9tjUVkkrEoTq5mPuVkC1aTc
         Mk2sBZQpycfS80FBkUx6SawDYw/k+mybY0qc+alzqo7d3I86+o+kwlOk2kUPkF2XKOlK
         SE4CS8ESWkRJEizx48abISdsgSu7g/hpmnmrWgaHOexFWuX2c7g2eQ7p9QH0RvHWlEbr
         eMCKcit1LL5Q1ius/E5lelv0pB3CZTUQKr3APcZvaenO2c4oTtv27bsm/jNhQNtVSmdJ
         9mfjMq63140Zsij7i+PHrjR/X4tA0xrnUA3kJFVjYGmgiQGbKkKP8n59x5Uv6j1e2Zq9
         /GiA==
X-Gm-Message-State: AOAM532RhHF/O31YuySE5BrCnqUYtWqEGxizPJNtrCAr6yjH4tFG7nQB
        oAQWMYBgfDikZByoCaWrSTiqww==
X-Google-Smtp-Source: ABdhPJwhqJDgxru2YIkrhKiac4wFZ7e/7/Sgw8YpVmg5RV/C1Br7xa8dVv+HqKXZX/CaKWJr+nVfqg==
X-Received: by 2002:a17:902:b686:: with SMTP id c6mr3542403pls.133.1598039069315;
        Fri, 21 Aug 2020 12:44:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm3442830pfq.146.2020.08.21.12.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
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
Subject: [PATCH v6 11/29] arm64/build: Use common DISCARDS in linker script
Date:   Fri, 21 Aug 2020 12:42:52 -0700
Message-Id: <20200821194310.3089815-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
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
index c2b8426bf4bd..082e9efa2b43 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
  */
 
 #define RO_EXCEPTION_TABLE_ALIGN	8
+#define RUNTIME_DISCARD_EXIT
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
@@ -88,10 +89,8 @@ SECTIONS
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
 	}
-- 
2.25.1

