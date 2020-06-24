Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE092069C2
	for <lists+linux-efi@lfdr.de>; Wed, 24 Jun 2020 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388569AbgFXBty (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 21:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbgFXBtw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 Jun 2020 21:49:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B54C061799
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so418966pjb.0
        for <linux-efi@vger.kernel.org>; Tue, 23 Jun 2020 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VSVwVb1orBbLFpFmeZIdSYi3mA1O04kaneM/R6F0kQA=;
        b=jOZxT2PsX3nKe4zH42N/7mgdsHTdSxEFNsbLeqc6pGXimNBN5J3e1ZkCRvQrZu8na0
         cWve30mGcnqoMlaLMT1Ce1TpJEMtZxmmZjcsXYz1KZNH95VEN1ccmVg7kI1Df/7OKFy6
         dhDqrJzrptyGZivwT5bc3eEkH/YfH7b4ARBb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VSVwVb1orBbLFpFmeZIdSYi3mA1O04kaneM/R6F0kQA=;
        b=GUW6JQy0eEH6fv9tZ9KzuSEEqwlHahqAupwUShIN8p+Bs6Wbx4zouRLPzR8IHgWOM8
         0bc6KJ+R8WpBEVNgRe1yy03nqFzq3A7HEdcquOVOlbolqpwLu9Zz3E/r6ZMOjZZErW4+
         w08gJlxuu80FgarnJjRwId9HIvwHb/VWo7Dzva4jvyVZkbl2MBzqEcvCdH2NonnMvTo+
         p10FH7/DokbHQLYRhCB4RIrv3nj4YWu+sQA6K3KrxcTC3mg8aH5WXNqLq/BruprokHlY
         OWBhI9AZh4bjjZCiN5sxtLngVrrakfHhZhxm/G6qvK84FgQbkdkGTI6MyLFKlV3WxyKW
         UQWg==
X-Gm-Message-State: AOAM532AZ5m0vqLJczo36pzl0fUOS2Wvz5+B3HTcC+mFrd59JtH7FN5O
        BL8GdUS6EVRCkybzR0wjD0SIgg==
X-Google-Smtp-Source: ABdhPJzLaOL5AabR46i7dKIOpQgrWYhTN0r11reBT85HgNmb6nhvZaSkN85dJfkjWvQbtPthllw43w==
X-Received: by 2002:a17:902:7408:: with SMTP id g8mr24719845pll.143.1592963390847;
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y9sm17907206pfr.184.2020.06.23.18.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:46 -0700 (PDT)
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
Subject: [PATCH v3 2/9] vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to STABS_DEBUG
Date:   Tue, 23 Jun 2020 18:49:33 -0700
Message-Id: <20200624014940.1204448-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When linking vmlinux with LLD, the synthetic sections .symtab, .strtab,
and .shstrtab are listed as orphaned. Add them to the STABS_DEBUG section
so there will be no warnings when --orphan-handling=warn is used more
widely. (They are added above comment as it is the more common
order[1].)

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

[1] https://lore.kernel.org/lkml/20200622224928.o2a7jkq33guxfci4@google.com/

Reported-by: Fangrui Song <maskray@google.com>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1248a206be8d..8e71757f485b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -792,7 +792,10 @@
 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
 		.stab.index 0 : { *(.stab.index) }			\
 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
-		.comment 0 : { *(.comment) }
+		.comment 0 : { *(.comment) }				\
+		.symtab 0 : { *(.symtab) }				\
+		.strtab 0 : { *(.strtab) }				\
+		.shstrtab 0 : { *(.shstrtab) }
 
 #ifdef CONFIG_GENERIC_BUG
 #define BUG_TABLE							\
-- 
2.25.1

