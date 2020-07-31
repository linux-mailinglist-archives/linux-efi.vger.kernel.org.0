Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5754F234E7A
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGaXSn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgGaXSR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:18:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE3C0617A0
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so8536500pjb.1
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rx9BNhtOHihN4cC/yR211OAq+faeKI6Zes69oCeQM6w=;
        b=d74fEfH+AJT4QLl/pweek9M8JQU04VeKWDA6U2gixgr/mciheG5Ezlv7MgN6Rb1HWY
         2OBg7xnc3sUVIMCFnR1Y+igiUqbxr8jaR2zt1f0TV1ldOv8LhbyjysXpqao6LAEOouE3
         Rwi1z6MIeG7fXDb29GK8Dc5L/EDvqKHqNhytQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rx9BNhtOHihN4cC/yR211OAq+faeKI6Zes69oCeQM6w=;
        b=bxG73cw5SQCq6QIUXIgLE2UvsGCbciRnOuR0xrlBpQQUqguUoTYBIjiyk/PgZWtEl7
         NX/tayBCDW+wn5kDpm5ADqCr6KgCTDlzYfj6fMUFcTBFUjBU7oR45ylywXMZJ2g5TmMP
         s4j9JR8WMApoNWXRriQkOi+qiZYzREGXnpBx/HJ8ZKHwNIhaHP8XrP+9vunncbr61NiV
         jisWMMWb0LqnP0yGaiqiYRRMOmM79wv0NiaJ9h4S8WTzFlIFITu4337mQT6pJ68NCApj
         ugxfRGt9uFlrmzUM43O+Qya8SNKLoKBxqY4SD83J0oPdFaEdMzQz+noFTAGQPBStzXKg
         Nr4w==
X-Gm-Message-State: AOAM533D16Ea/3gb3HHfpWZn+T2Bx0v7CTwgVMFnrWAMf8q0xV+NNKeQ
        81TE+T15LEz+TetdN19b2gelWw==
X-Google-Smtp-Source: ABdhPJy/UWkqz0kX/iI9reViU3q1mzpCLU62ykzIRw2Fvekz5tfwEf5puBHtXUakR6EdYyybPNSt/w==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr5482552plr.136.1596237494096;
        Fri, 31 Jul 2020 16:18:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z19sm11621350pfa.9.2020.07.31.16.18.11
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
Subject: [PATCH v5 18/36] arm64/build: Use common DISCARDS in linker script
Date:   Fri, 31 Jul 2020 16:08:02 -0700
Message-Id: <20200731230820.1742553-19-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
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
index b29081d16a70..5c1960406b08 100644
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
 	}
-- 
2.25.1

