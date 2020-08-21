Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552E024E15B
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHUTzX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgHUTyD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:54:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC470C061795
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 74so1561088pfx.13
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKGWDIrBEs2dh6Vx6JHQWt/T3ziuaJ6+D++qA+lLK7w=;
        b=MOtH6g06WVQoxhMiwvjXdIDUiCnhNQLZstpkLeL0aigF1WIuztgjF/SOV6mc40YW8E
         wDHh058AHq5ePmSwdD2DjlRGgSmRaxVSd4mi0Zx9sor/UExqSvQ8V/L8d0p9DL/TQe7y
         p5lo8dxel2Zghjrb75dYwEndSMILJRoFoM+74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKGWDIrBEs2dh6Vx6JHQWt/T3ziuaJ6+D++qA+lLK7w=;
        b=M+NGiWuSqEjBxI80BnnFVy4uGKM2+sgFZMmi4qMzSvTf48zqDDz6UdT6jCKzLiK4ry
         CoV/8fBQwJKv/Bz3vzXncuv6ms/XaiJ5wWdNxAFI5QMRmucAQKWr/7708K06Tk3RwHv/
         nT82qsPltF+s6rmUGAdNV5XtXvL7qGhiDMaiy5F6GeGjhDmhxKPqkr+ERqknrw+my35T
         6cq8cUO8QZ38Bz5bjA8ajpEOMO1bktss/5wUF4lFIJPMaxlBv8gSHvbS28PhMIoILYa0
         4V8m5IA7Oh5S1CSwaGp0dRPCwzJ3NDbxMl631QoTd60rP5pC8wvlzBO4zR4lMAMlJAoU
         lSug==
X-Gm-Message-State: AOAM5324au7UCdhhZvXzviBNUyzJQtTiwb1s11GRCi0wl0Rv3Ur5UoND
        0nCHULb737IPMRkSmFntKRQJzg==
X-Google-Smtp-Source: ABdhPJxjgtmoBh+TjhY4jwZBRLmOO/t4+4cu+yIFtjbg4mFY0zXTI5TZCcanxWTLjoIsmfezhzbI5w==
X-Received: by 2002:aa7:968b:: with SMTP id f11mr3724767pfk.63.1598039640596;
        Fri, 21 Aug 2020 12:54:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k29sm3378601pfp.142.2020.08.21.12.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:53:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/29] arm/build: Warn on orphan section placement
Date:   Fri, 21 Aug 2020 12:43:00 -0700
Message-Id: <20200821194310.3089815-20-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly handled in the linker
script.

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

With all sections handled, enable orphan section warning.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 4e877354515f..0aa133c4ddec 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
-- 
2.25.1

