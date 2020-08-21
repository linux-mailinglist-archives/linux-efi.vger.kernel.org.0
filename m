Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C387324E0E7
	for <lists+linux-efi@lfdr.de>; Fri, 21 Aug 2020 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHUTo6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Aug 2020 15:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgHUToh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Aug 2020 15:44:37 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBCBC0617B1
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y206so1554463pfb.10
        for <linux-efi@vger.kernel.org>; Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y6H7F3yYvyF+nG4ZythWO1q4A4EGexkc0hsQxsFmb9Y=;
        b=bzEVhilQDoNZ88CqeMIylY5czHrj5mvx3pyI0KZHCOwCCad75pWPogmJocbzqDIa4M
         jCL7LMBOWN3BWIkvwxCZD0INBFknxTPTqmEyLqGKlmZvjvzASSQMjNtetIJK/36sGUfc
         tpPl9PGejZzGddLdSQuM8jUBTC9zPIENj4PdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y6H7F3yYvyF+nG4ZythWO1q4A4EGexkc0hsQxsFmb9Y=;
        b=SoJ+zyq1SYrbVLjPG3KGBlpkaUTDS4f50xLlw2frSnCVAswSORmzt2XMAyOu6CSpzd
         Yt/YnO7GFJ+QWu0ExqLTmz1hp1Kd1p6fpu/iDMy2gxH7bOTFwSvRdmfVU4ZT2NvioxgY
         q0u0qvmY+74KmTodLqciKMQn4kXAFlzht0cwSbJGQ7aj6YNpAth4Ug+j8xKIE2jnXOcp
         2veTRlnTxFnPVY8kjVyJfcjfjWktJQmDVn4aZR5vW9UYfkge8+t817aauPhpVTODHTus
         oLhee8t/+A5YaPZhiyD3irWNt8yMsxdkrmPNVMqMPxcNmVuDmiv0xSPkkPxaSsEvwdbe
         UbhQ==
X-Gm-Message-State: AOAM533AiYzq+7BQhMkXN+8v5hQwnuaaQuW7ZhGx7bBukuZjXD/Fjmyg
        bkYekFqSSgZEgNqJDUaFnMb6Tg==
X-Google-Smtp-Source: ABdhPJzovlQLohuyGck2L97aDvFQQrVLNN8WGQiiMLGQhFilz17skLPcq8rq1acZQatUKm4A+V3zJQ==
X-Received: by 2002:a63:9c1:: with SMTP id 184mr171258pgj.265.1598039067233;
        Fri, 21 Aug 2020 12:44:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g23sm3243141pfo.95.2020.08.21.12.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:44:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v6 09/29] arm64/kernel: Remove needless Call Frame Information annotations
Date:   Fri, 21 Aug 2020 12:42:50 -0700
Message-Id: <20200821194310.3089815-10-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821194310.3089815-1-keescook@chromium.org>
References: <20200821194310.3089815-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Remove last instance of an .eh_frame section by removing the needless Call
Frame Information annotations which were likely leftovers from 32-bit arm.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/smccc-call.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809528a4..d62447964ed9 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>
 
 	.macro SMCCC instr
-	.cfi_startproc
 	\instr	#0
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:	ret
-	.cfi_endproc
 	.endm
 
 /*
-- 
2.25.1

