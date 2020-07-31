Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB78234E81
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGaXS5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgGaXSN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:18:13 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10277C06174A
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r4so7475786pls.2
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OztuNRy+U3SEjaM8AjX3NHKuvNzCSaFSb4g4nlKxjN8=;
        b=mhl2cYQ2YEfGFzqu0lUm7PTEdf3xYEpybnJ2cfLPuY6LR4v/YBY5dJ0ivTK2K5UAQM
         0k9arXuQB4cv1bpNG0r3VncPs3HFypojskLqEB3mHI/LVxckqJONf2cBzIIP4It97oIL
         ccOz8l1eiz5ARWhIbuGZYnApCYc1UDxK86u0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OztuNRy+U3SEjaM8AjX3NHKuvNzCSaFSb4g4nlKxjN8=;
        b=nQDo+odCbG3+XYBfQ01kmPM3+nk2Vd67hyoTJ1Yrq9imobPP8nAUsLAZ6l6xqRV2a2
         EaI4o7ZUq3rMqETL1Fi+5cGSNq3Ph86gIhR/yVC4UmPi/3VxQbRjI+m31sD6B6XPnUtT
         HHFdydtfFHilZL+YZ4nK1q6lvjlM63jGH+dPX69nejFRFBNkOUvdnRKQKmg/WRH8U/N6
         lHieImMymJCmDwh8uRt0nzhK1+OwniBInU+JeaXQjUcbkmEPjPcgcOwhRg2lFtt6Ov8o
         a+rBGZe2aY+wtJ1mD1KzMTSzC9Opge6VjjN2t/5pz3iLRQXf5FvzlJVPZwYyUw8m8WzF
         uFKQ==
X-Gm-Message-State: AOAM531B6S9ufZvxNXtC1qJEySSY+0gQnRr0LWONTgmXZnCXW4OYmEao
        YZxt77luaAhaRWjmq2lgEsLPCw==
X-Google-Smtp-Source: ABdhPJy7boJ2rVpqxGdhrmjmUcJo5jNiV0bmJoTaMG0L5+Tg8lheY4n/pMplx9rYVCtqWI1ZntGMZg==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr6284010pjj.28.1596237492647;
        Fri, 31 Jul 2020 16:18:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm11932082pgh.94.2020.07.31.16.18.11
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
Subject: [PATCH v5 19/36] arm64/build: Add missing DWARF sections
Date:   Fri, 31 Jul 2020 16:08:03 -0700
Message-Id: <20200731230820.1742553-20-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Explicitly include DWARF sections when they're present in the build.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5c1960406b08..4cf825301c3a 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -240,6 +240,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
-- 
2.25.1

