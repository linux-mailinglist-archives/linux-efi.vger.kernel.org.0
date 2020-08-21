Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73F24E0ED
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHUTpM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHUTox (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:44:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF8AC061388
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so1255888pjx.5
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iyu1hqfWZF/Rprc+orVpuMlUtMs4mrBdsJ6TcxbP7dg=;
        b=cEhj/1dXziGzNz3rzCPAyy+0VKr4B6ufAh5DgKVx30rzDGb14ve/eXfOAOHLNwWMoJ
         CdTN2XCZlucbNHybqLceeWOXF09o+ktLiVPykM1lpIJxxYeBbq0GUTQ6Y8QnLr5f8mJp
         2Oh+xOILfK2AkARlkRq0fbM9ZA6auqArJxZb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iyu1hqfWZF/Rprc+orVpuMlUtMs4mrBdsJ6TcxbP7dg=;
        b=erC5L6psFdC8qbuWbggYP37510tw67LGpGrFLvTamGSsHBOJUGxZlvIO3Q1yqDUBfa
         NpHyBUoRM8LG1Q0alLhJHy3JIoLzXlyCQKgcIqWYqaqFr4dloqceeGaruibghvMZIGXr
         vinaA/mmeSIdwyTD1DXmy6OLiQJI5vNhmNKuyloUOaLGb41yBrhYaj/kZ5+dsXiDbvk/
         iW1f1IkCetbj8zZB0Y+mwlNcysZfRHSboQVHuh0EmDNaxKZirY8W1LMULE+UVzupSrTs
         ++KI73JrpfRYwUTBbmErsE/0vWuHh0AZfsaJKpUkA9dp14PJ4NbyqW5Ed6C72x/WbWsO
         hx0A==
X-Gm-Message-State: AOAM533KGmqYlYYeOmtqygO97pEfW7OvKmpDzSTs1zjetE6ow9V/fnA4
        HkZM8vDASPjmEC8jVTruytSDAQ==
X-Google-Smtp-Source: ABdhPJzpIJZx9fWtR3JYrT9Hz00IB8Bbc5lbvCNlSB2U5AhmKzx1WV+9QjdpbeHcGVcZ/7aFyUdG+g==
X-Received: by 2002:a17:90a:9d83:: with SMTP id k3mr3788859pjp.19.1598039070005;
        Fri, 21 Aug 2020 12:44:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z9sm3224171pfn.59.2020.08.21.12.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
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
Subject: [PATCH v6 12/29] arm64/build: Add missing DWARF sections
Date:   Fri, 21 Aug 2020 12:42:53 -0700
Message-Id: <20200821194310.3089815-13-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
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
index 082e9efa2b43..16eb2ef806cd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -239,6 +239,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ELF_DETAILS
 
 	HEAD_SYMBOLS
-- 
2.25.1

