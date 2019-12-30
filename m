Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9933B12D43B
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 21:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfL3UAN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 15:00:13 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37769 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfL3UAN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 15:00:13 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so27043894qky.4
        for <linux-efi@vger.kernel.org>; Mon, 30 Dec 2019 12:00:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe07ZCehM3769XL2X3799NFp2AgKvDGdC/EONV29CPA=;
        b=rSwU/RsFOO0KV83Dxr6vrUcBtGj5q06daE9FeRY4Mj4/lNl/XXHNPz72+eyHo88zi0
         +knBY2O+JCRb8YLBccj/7sEHLvr4RS08IMEhe41psviS8vr3+VDBVP6DxpuHQJz8WkzC
         uh4SfRT7l77fXXk95grAf+lHssBoc5CwCDiELMKGkveSlUIEZHs/1/TfPIO04wGF7pxL
         RtQPcNavoIWOrz1IxmnsjIywjLaKBgsjqenL9UPP9KvILa8Ls4+VlbrmxA6b/XA8n7Fe
         CuIhBDZakwKBlsgGN32e/IT9Fm6KYiZZeLIt2njTwRj3CE+koOvSawxmC2Q2DRLyttM2
         910A==
X-Gm-Message-State: APjAAAVUW+fed0bitE6fw8/EFd15sFpBNYMXLU5MXuvUfNFy+crQU6Fu
        pum0EzhSDl7RnOeUqJ18sDa4QakM
X-Google-Smtp-Source: APXvYqy1/ZZYsyB6lwXRIkkrjrY5MYwnI/t0q8lrwT7pNrXdmlQudXqRG76u2mhm8PVUXEgNRbdwww==
X-Received: by 2002:a37:bcc7:: with SMTP id m190mr21881207qkf.103.1577736012633;
        Mon, 30 Dec 2019 12:00:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z141sm12701168qkb.63.2019.12.30.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 12:00:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [RFC PATCH 1/2] efi/x86: Check number of arguments to variadic functions
Date:   Mon, 30 Dec 2019 15:00:10 -0500
Message-Id: <20191230200011.2589934-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On x86 we need to thunk through assembler stubs to call the EFI services
in many cases. The assembler stub has limits on how many arguments it
handles. Introduce a few macros to check that we do not try to pass too
many arguments to the stubs.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/efi.h | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c49619a28be8..c9800802894f 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -8,6 +8,7 @@
 #include <asm/tlb.h>
 #include <asm/nospec-branch.h>
 #include <asm/mmu_context.h>
+#include <linux/build_bug.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -34,6 +35,47 @@
 
 #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
 
+/*
+ * The EFI services are called through variadic functions in many cases. These
+ * functions are implemented in assembler and support only a fixed number of
+ * arguments. The macros below allows us to check at build time that we don't
+ * try to call them with too many arguments.
+ */
+
+/*
+ * __efi_nargs() will return the number of arguments if it is 7 or less, and
+ * cause a BUILD_BUG otherwise. The limitations of the C preprocessor make it
+ * impossible to calculate the exact number of arguments beyond some
+ * pre-defined limit. The maximum number of arguments currently supported by
+ * any of the thunks is 7, so this is good enough for now and can be extended
+ * in the obvious way if we ever need more.
+ */
+
+#define __efi_nargs(...) __efi_nargs_(0, ##__VA_ARGS__)
+#define __efi_nargs_(...) __efi_nargs__(__VA_ARGS__,		\
+	__efi_arg_sentinel(7), __efi_arg_sentinel(6),		\
+	__efi_arg_sentinel(5), __efi_arg_sentinel(4),		\
+	__efi_arg_sentinel(3), __efi_arg_sentinel(2),		\
+	__efi_arg_sentinel(1), __efi_arg_sentinel(0))
+#define __efi_nargs__(_0, _1, _2, _3, _4, _5, _6, _7, n, ...)	\
+	__take_second_arg(n,					\
+		({ BUILD_BUG_ON_MSG(1, "__efi_nargs limit exceeded"); 8; }))
+#define __efi_arg_sentinel(n) , n
+
+/*
+ * __efi_nargs_check(f, n, ...) will cause a BUILD_BUG if the ellipsis
+ * represents more than n arguments.
+ */
+
+#define __efi_nargs_check(f, n, ...) \
+	__efi_nargs_check_(f, __efi_nargs(__VA_ARGS__), n, ##__VA_ARGS__)
+#define __efi_nargs_check_(...) __efi_nargs_check__(__VA_ARGS__)
+#define __efi_nargs_check__(f, p, n, ...) ({				\
+	BUILD_BUG_ON_MSG(						\
+		(p) > (n),						\
+		#f " called with too many arguments (" #p ">" #n ")");	\
+})
+
 #ifdef CONFIG_X86_32
 
 extern asmlinkage
@@ -62,6 +104,11 @@ unsigned long efi_call_phys(void *, unsigned long, unsigned long, u32, void *);
 
 extern asmlinkage u64 efi_call(void *fp, ...);
 
+#define efi_call(...) ({						\
+	__efi_nargs_check(efi_call, 7, __VA_ARGS__);			\
+	efi_call(__VA_ARGS__);						\
+})
+
 #define efi_call_phys(f, args...)		efi_call((f), args)
 
 /*
@@ -149,6 +196,11 @@ extern u64 efi_setup;
 #ifdef CONFIG_EFI
 extern efi_status_t efi64_thunk(u32, ...);
 
+#define efi64_thunk(...) ({						\
+	__efi_nargs_check(efi64_thunk, 6, __VA_ARGS__);			\
+	efi64_thunk(__VA_ARGS__);					\
+})
+
 static inline bool efi_is_mixed(void)
 {
 	if (!IS_ENABLED(CONFIG_EFI_MIXED))
-- 
2.24.1

