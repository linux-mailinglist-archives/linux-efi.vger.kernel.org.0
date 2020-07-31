Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9537234E6B
	for <lists+linux-efi@lfdr.de>; Sat,  1 Aug 2020 01:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGaXS0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 31 Jul 2020 19:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgGaXST (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 31 Jul 2020 19:18:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACACC0617A2
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so4899854pfb.10
        for <linux-efi@vger.kernel.org>; Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j7Lys61YjFpfMX3OTBjlFH6rsXYj3ZGDYGY4DwTK5Rs=;
        b=d1nsCRiVeR5V7xSyyra8TUXkzVGGZyVGicIMpvsBxz4UYBltmv2pChbuD9HAWx1JRZ
         nTzgrAEI4ydMYR6/86qDA5RBERE0C3DwH6MGQ/ocUxKfyvRkYDsOGgPU8V7aUbsGFQfr
         K/ypLFr1ufBcI2TdFJYN71D2tSdiicMgRSswc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j7Lys61YjFpfMX3OTBjlFH6rsXYj3ZGDYGY4DwTK5Rs=;
        b=E7jhZ0ZYW4uDtKRdp4FKJJyq5SmQWltnpBbN3a7q/aewkMJ+HJ2I5eyX3C7RwYN2E8
         qc0TgFdPfLgQggPz7kK/qSQeuDmRLlhGRdTmLsVEJJHaz+TA5Ieo7xPvgpMeaGpQQzbO
         tQiFIGUGrdDhunjSNovpveTRFnGkfetPlpVM/xiOSEQiJ9O+kBBF6Cp/mGvRX2N4Vorh
         LA1jvrpoq2YcWewt6ZvcHNiC+vpbzA1qZu4zqDekU99PDaQNiAN2oC1YVciK5/+MvalC
         CMFafOAlMAch9vnI53/rL2Ac0Q4j3LO2Kl8tfbd4Uh/Qo2kk4cR3P881Nh274uyDwEsI
         fIzw==
X-Gm-Message-State: AOAM531R8kw1tuZ26aQWSo+LSOu+XMNqcFLbDaWMxHr2JXhJABJSerYq
        xz3GLlEipA8TT2LMDvYfYFfWVw==
X-Google-Smtp-Source: ABdhPJylqiQpL9f/Meacfle4u2dUrOQCvbKxNn7AAVKGg1HE/JSZSV2cXWPDWp4nKgsIRycs40SrKA==
X-Received: by 2002:a62:2546:: with SMTP id l67mr5959404pfl.154.1596237499260;
        Fri, 31 Jul 2020 16:18:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c2sm11380501pgb.52.2020.07.31.16.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 16:18:15 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>
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
Subject: [PATCH v5 24/36] arm/build: Add missing sections
Date:   Fri, 31 Jul 2020 16:08:08 -0700
Message-Id: <20200731230820.1742553-25-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200731230820.1742553-1-keescook@chromium.org>
References: <20200731230820.1742553-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add missing text stub sections .vfp11_veneer and .v4_bx, as well as
missing DWARF sections, when present in the build.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/include/asm/vmlinux.lds.h | 4 +++-
 arch/arm/kernel/vmlinux-xip.lds.S  | 1 +
 arch/arm/kernel/vmlinux.lds.S      | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
index c4af5182ab48..6624dd97475c 100644
--- a/arch/arm/include/asm/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -59,7 +59,9 @@
 #define ARM_STUBS_TEXT							\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
-		*(.glue_7t)
+		*(.glue_7t)						\
+		*(.vfp11_veneer)                                        \
+		*(.v4_bx)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 57fcbf55f913..11ffa79751da 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -150,6 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ARM_DETAILS
 }
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1d3d3b599635..dc672fe35de3 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,6 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 	ARM_DETAILS
 }
 
-- 
2.25.1

