Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6724E0E0
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgHUTob (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgHUToW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:44:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D7C061575
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g15so1336850plj.6
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KJKUmMIwELFiu+Jhx3PR/flYgx4mAaM57h538oQIMM=;
        b=i/HEp8a1E4h+pDbbs57HZpbPpxh1OsfRH2Yd/8W3bgSphxcIhvxHJMoOUFbJ6b/Lo5
         9aJS4qOv+ZRLhprPhhQyVLMufErKaJZg4b7i1PWzbmYDeM8hm39fYJLK/IT+cxpFTdWz
         TuXn2CWgQSDT0wuxFJZoOlwQ2qTgwxpZ9CNOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KJKUmMIwELFiu+Jhx3PR/flYgx4mAaM57h538oQIMM=;
        b=ij/JRRr2phYt/rpYrmtE7rB98/Jo3bLmz8LJzeGdY/yaAeC76pkyezTL91AANPTpIr
         r3aMZSZ4Tos75GRL8460BppDOPRCLK/5qt45iXMRDedH3zxgSMqCL92M7UgrZDtttI8d
         2hgaBqVJjxUGYFVmQq7gu0oc5sQRMuUYScGMyu9s0y2M3g9VPX/RbSyWHTscZaK3RUBr
         E/Z7wzZnH3807JceueyQm756cmVsZZtsiW4FjVtL3qDXskgmlsViil7rtJD6Bd0RCM6J
         LJJQogpALvs3/HsQzxiPn9QJtDc23Hw/VlvSvRq2atP78uhkTh5ZihL9D54P9Y6WICBN
         A4BQ==
X-Gm-Message-State: AOAM5301n8/YBWP3JXaPKQhU60o46sElGRyH8umFSvyE0PsG4YY4jb+5
        qe3JSKsn2QKncklegqqQqSsw9Q==
X-Google-Smtp-Source: ABdhPJxhYfHQFi07yXAb+83c2N6Go68l40rd8GM9whIQP8616kjUIICp3ghwUq5gOnKTYPsXxrBOoA==
X-Received: by 2002:a17:90a:4f45:: with SMTP id w5mr3754850pjl.11.1598039062148;
        Fri, 21 Aug 2020 12:44:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b9sm3354866pft.98.2020.08.21.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:21 -0700 (PDT)
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
Subject: [PATCH v6 01/29] vmlinux.lds.h: Create COMMON_DISCARDS
Date:   Fri, 21 Aug 2020 12:42:42 -0700
Message-Id: <20200821194310.3089815-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Collect the common DISCARD sections for architectures that need more
specialized discard control than what the standard DISCARDS section
provides.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 7616ff0b96ec..184b23d62784 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -954,13 +954,16 @@
 	EXIT_DATA
 #endif
 
+#define COMMON_DISCARDS							\
+	*(.discard)							\
+	*(.discard.*)							\
+	*(.modinfo)
+
 #define DISCARDS							\
 	/DISCARD/ : {							\
 	EXIT_DISCARDS							\
 	EXIT_CALL							\
-	*(.discard)							\
-	*(.discard.*)							\
-	*(.modinfo)							\
+	COMMON_DISCARDS							\
 	}
 
 /**
-- 
2.25.1

