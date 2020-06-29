Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF820E1E7
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbgF2VAu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 17:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbgF2TM6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:12:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BC7C08EAF3
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b184so1042424pfa.6
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpUogxOiAtRCZJbpj/Xg6f5qeGiNnaYs3fJRPX/karM=;
        b=DI7brhSnHEPnBP9EF9Z149tETyybTm/vRuuRi3kQWF9laFLVbRO/B6ZFFy2PkayzvX
         qgx3F8e8SkuKXWe2A3IX2ProSRkfDVOaK8mA4F+DyfAsVYLwYcBEByyEiOgr1O2AbpW0
         znz0jgmgOzhpF8f9lW/RNJGa3YYwNNvYQnG4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpUogxOiAtRCZJbpj/Xg6f5qeGiNnaYs3fJRPX/karM=;
        b=UnuatADkVyoRS0rscww7wCJvNfCvxPC/d6g+wUKy3FH4R+fxdF5lSc4WkD+HGZVtic
         IMVf7T3RkAjrEzAUd4yvV7JcUEdrM3Bx/7/1l3qw6FsAEzl9A1gIT56VzCeLPMo9px2D
         +VNMtopiMvpAzdOOPRM0ysvUv8Rii6Cr+3SAXDt9f5Aqp8qsOSMEEhr/x/B4P2e9Kgzc
         4/YfyywhGfbhl23BHo0qoJIiaiOTQd/UyA9A89IXd/F1v5OFQCEqCABN7gYuN2FvvyD3
         iLNXWAPTUXyuZVUGil6i4LQLlPj/l7JT8IEY8EBeQlcUxgcG0YGILEPhdsU+hFBIAqL8
         5dRA==
X-Gm-Message-State: AOAM532AMXZ7Mfs+cJC47CZSqeo/a8m1sJV/WNpa8GJtzQIevabe/Gg2
        eVcg7QZJChmp6UftQiBOV7fubg==
X-Google-Smtp-Source: ABdhPJyNl9M0hTPrxGqQML+GMiPdMMkdmcUuHH+RPVHgnToWI0RwZQKETihD6gi3OjkvTsW/Fi4SHQ==
X-Received: by 2002:a63:fc1f:: with SMTP id j31mr9226331pgi.104.1593411526749;
        Sun, 28 Jun 2020 23:18:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nv9sm19380828pjb.6.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:44 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
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
Subject: [PATCH v4 04/17] vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
Date:   Sun, 28 Jun 2020 23:18:27 -0700
Message-Id: <20200629061840.4065483-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
and .shstrtab are listed as orphaned. Add them to the ELF_DETAILS section
so there will be no warnings when --orphan-handling=warn is used more
widely. (They are added above comment as it is the more common
order[1].)

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

[1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/

Reported-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c5d10bc53996..9477359278a2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -796,7 +796,10 @@
 
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
-		.comment 0 : { *(.comment) }
+		.comment 0 : { *(.comment) }				\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
-- 
2.25.1

