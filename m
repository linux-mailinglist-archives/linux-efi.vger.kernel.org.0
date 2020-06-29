Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8220DFAA
	for <lists+linux-efi@lfdr.de>; Mon, 29 Jun 2020 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732395AbgF2Uiy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 29 Jun 2020 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgF2TOQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 29 Jun 2020 15:14:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D7C08EB13
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so7565349pjc.4
        for <linux-efi@vger.kernel.org>; Sun, 28 Jun 2020 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRDUZAq4KUcmg3RU1pc/3G6TWWMMmiH07CaNiCk63dA=;
        b=OngKzCoBXRqpXyn8tClMjtqQlL/nJZ8uCSAc2Uyi9PLl3HjxTANENeKwIhCN2JPXoz
         FqUJVg+Y//PmO6nzCQnijna217nrwyVXepnIQ7lbRcXB/8nfXPbQWgx0YonaDZwf2N3K
         MGQhaY3XJ3eFszdo735YBZhEWggFpEUOFM+H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRDUZAq4KUcmg3RU1pc/3G6TWWMMmiH07CaNiCk63dA=;
        b=uIQ+MmZatNIzfTFuBWaCAVH9IT3BDO0ZYad2SCfV8hPiiNnqiZNRzssHsRCEJsPGTK
         4VAy0M0J3RJLXSXPsz7CyPxSoxbubwPnflTgrS348yV8yVIFlbg+lC7/67VTeeszl6lu
         RGZDBslOr9G5gXUxYlMNH4WEqOpxupdaOfobgZBSYrCcXYg3xseuhjgn1YwO0TbzKVzO
         2UWtylj3nSOU3Y9czUxGWtcQZEo7zMUyAY4rsRTJgU1apT8k2j2/84xMTykw8Uu6vUjF
         uaAwMTS03Y6nSvUAOwSdbtt15zFDe/3C6ZAWqktf1XUw/Jzpc0eBIjW+iQnICfFDgtLg
         90Jg==
X-Gm-Message-State: AOAM531FYsQ3ZyJqthJD6TXr0PMpTotpcHmpAHmIT7VfP8mzWTfvZY41
        TpX21n1rOpUucXGvFOgU9a7UgA==
X-Google-Smtp-Source: ABdhPJyTzjKhJ/zzQcZEVxeXeWaUAlazIn3+rTaLERzJPA8cqWvdjUBBdLJDKJzE0WfVi/nz5T2VDw==
X-Received: by 2002:a17:90a:d809:: with SMTP id a9mr676907pjv.74.1593411534348;
        Sun, 28 Jun 2020 23:18:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm16588148pfh.160.2020.06.28.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/17] arm/build: Explicitly keep .ARM.attributes sections
Date:   Sun, 28 Jun 2020 23:18:36 -0700
Message-Id: <20200629061840.4065483-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In preparation for adding --orphan-handling=warn, explicitly keep the
.ARM.attributes section by expanding the existing ELF_DETAILS macro into
ARM_DETAILS.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/lkml/CAKwvOdk-racgq5pxsoGS6Vtifbtrk5fmkmnoLxrQMaOvV0nPWw@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 4 ++++
 arch/arm/kernel/vmlinux-xip.lds.S  | 2 +-
 arch/arm/kernel/vmlinux.lds.S      | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index 142c038b2e97..c66b16cd8837 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -56,6 +56,10 @@
 		ARM_MMU_DISCARD(*(__ex_table))				\
 		ARM_COMMON_DISCARD
 
+#define ARM_DETAILS							\
+		ELF_DETAILS						\
+		.ARM.attributes 0 : { *(.ARM.attributes) }
+
 #define ARM_STUBS_TEXT							\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 904c31fa20ed..57fcbf55f913 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -150,7 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
-	ELF_DETAILS
+	ARM_DETAILS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index bb950c896a67..1d3d3b599635 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,7 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
-	ELF_DETAILS
+	ARM_DETAILS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1

