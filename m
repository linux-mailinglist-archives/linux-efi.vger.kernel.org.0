Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4312DC30
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 23:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfLaWr6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 17:47:58 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44616 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfLaWr6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 17:47:58 -0500
Received: by mail-qt1-f196.google.com with SMTP id t3so32330840qtr.11
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 14:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+8eLklmC71Y5xsUz72hjG1WQb8Sh7q4m1b306fCucc=;
        b=eiqEnFgaUM8V7VWfmK7jW27Qz0D7TytmYqnMeqlrQ2wjr3mMOI2cSqNaJqD+7B1GDH
         je0G+j8HMUpxjZ2FDnnZUhsBtzxczIYcq4QNaiYDSY3CKB4Z0p4nCgc6Kpr6wttSOVf2
         v0xjVt/fwOu4+6N23EC2jWxuo7Sg3ebURajlnpMIfinGcnOYpJS2EqWnmUqz9CoJRKWi
         LXwMM3L4wb+GmMjnVOUYa5ttKgw0J2lFBllzuHe2nm1iCYPhNIh5wXP1t3HWj3auDQF4
         0QDTfHbBPr2wPCB5NRSra6S4yg11oZNqNTPO2NF09UhcNq4U5OiW0KWWDPQQpa5jXLhg
         gGxw==
X-Gm-Message-State: APjAAAXl1y++7yig6hiaMbmiPOYVcDHjBpFRN+M8twn6tkOFfvPGm3fa
        L9VMBMOo0y08waUjgAnhDtc=
X-Google-Smtp-Source: APXvYqyJDru0YyaGMOEiC0BfweHYXctjt8CQ+CTnrIb63y/5F67pxDQMzotDtn84HF6zS4W1MF6IxQ==
X-Received: by 2002:ac8:187b:: with SMTP id n56mr40936925qtk.173.1577832476889;
        Tue, 31 Dec 2019 14:47:56 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o7sm13746085qkd.119.2019.12.31.14.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 14:47:56 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 1/2] efi/x86: Check number of arguments to variadic functions
Date:   Tue, 31 Dec 2019 17:47:54 -0500
Message-Id: <20191231224755.77310-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAKv+Gu_7KxS2--Zy7vky7zZ4bQchLJ6Vv+kceKDwjAvYVeXL9A@mail.gmail.com>
References: <CAKv+Gu_7KxS2--Zy7vky7zZ4bQchLJ6Vv+kceKDwjAvYVeXL9A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On x86 we need to thunk through assembler stubs to call the EFI services
for mixed mode, and for runtime services in 64-bit mode. The assembler
stubs have limits on how many arguments it handles. Introduce a few
macros to check that we do not try to pass too many arguments to the
stubs.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/efi_thunk_64.S |  4 +-
 arch/x86/include/asm/efi.h              | 54 ++++++++++++++++++++++++-
 arch/x86/platform/efi/efi_stub_64.S     |  4 +-
 arch/x86/platform/efi/efi_thunk_64.S    |  4 +-
 4 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index 6d95eb6b8912..d040ff5458e5 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -23,7 +23,7 @@
 
 	.code64
 	.text
-SYM_FUNC_START(efi64_thunk)
+SYM_FUNC_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
@@ -95,7 +95,7 @@ SYM_FUNC_START(efi64_thunk)
 	pop	%rbx
 	pop	%rbp
 	ret
-SYM_FUNC_END(efi64_thunk)
+SYM_FUNC_END(__efi64_thunk)
 
 	.code32
 /*
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index e7e9c6e057f9..cfc450085584 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -8,6 +8,7 @@
 #include <asm/tlb.h>
 #include <asm/nospec-branch.h>
 #include <asm/mmu_context.h>
+#include <linux/build_bug.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -34,6 +35,45 @@
 
 #define ARCH_EFI_IRQ_FLAGS_MASK	X86_EFLAGS_IF
 
+/*
+ * The EFI services are called through variadic functions in many cases. These
+ * functions are implemented in assembler and support only a fixed number of
+ * arguments. The macros below allows us to check at build time that we don't
+ * try to call them with too many arguments.
+ *
+ * __efi_nargs() will return the number of arguments if it is 7 or less, and
+ * cause a BUILD_BUG otherwise. The limitations of the C preprocessor make it
+ * impossible to calculate the exact number of arguments beyond some
+ * pre-defined limit. The maximum number of arguments currently supported by
+ * any of the thunks is 7, so this is good enough for now and can be extended
+ * in the obvious way if we ever need more.
+ */
+
+#define __efi_nargs(...) __efi_nargs_(__VA_ARGS__)
+#define __efi_nargs_(...) __efi_nargs__(0, ##__VA_ARGS__,	\
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
+#define __efi_nargs_check(f, n, ...)					\
+	__efi_nargs_check_(f, __efi_nargs(__VA_ARGS__), n)
+#define __efi_nargs_check_(f, p, n) __efi_nargs_check__(f, p, n)
+#define __efi_nargs_check__(f, p, n) ({					\
+	BUILD_BUG_ON_MSG(						\
+		(p) > (n),						\
+		#f " called with too many arguments (" #p ">" #n ")");	\
+})
+
 #ifdef CONFIG_X86_32
 #define arch_efi_call_virt_setup()					\
 ({									\
@@ -56,7 +96,12 @@
 
 #define EFI_LOADER_SIGNATURE	"EL64"
 
-extern asmlinkage u64 efi_call(void *fp, ...);
+extern asmlinkage u64 __efi_call(void *fp, ...);
+
+#define efi_call(...) ({						\
+	__efi_nargs_check(efi_call, 7, __VA_ARGS__);			\
+	__efi_call(__VA_ARGS__);					\
+})
 
 /*
  * struct efi_scratch - Scratch space used while switching to/from efi_mm
@@ -139,7 +184,12 @@ struct efi_setup_data {
 extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
-extern efi_status_t efi64_thunk(u32, ...);
+extern efi_status_t __efi64_thunk(u32, ...);
+
+#define efi64_thunk(...) ({						\
+	__efi_nargs_check(efi64_thunk, 6, __VA_ARGS__);			\
+	__efi64_thunk(__VA_ARGS__);					\
+})
 
 static inline bool efi_is_mixed(void)
 {
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
index e7e1020f4ccb..15da118f04f0 100644
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ b/arch/x86/platform/efi/efi_stub_64.S
@@ -10,7 +10,7 @@
 #include <linux/linkage.h>
 #include <asm/nospec-branch.h>
 
-SYM_FUNC_START(efi_call)
+SYM_FUNC_START(__efi_call)
 	pushq %rbp
 	movq %rsp, %rbp
 	and $~0xf, %rsp
@@ -24,4 +24,4 @@ SYM_FUNC_START(efi_call)
 	CALL_NOSPEC %rdi
 	leave
 	ret
-SYM_FUNC_END(efi_call)
+SYM_FUNC_END(__efi_call)
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 162b35729633..26f0da238c1c 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -25,7 +25,7 @@
 
 	.text
 	.code64
-SYM_CODE_START(efi64_thunk)
+SYM_CODE_START(__efi64_thunk)
 	push	%rbp
 	push	%rbx
 
@@ -69,4 +69,4 @@ SYM_CODE_START(efi64_thunk)
 2:	pushl	$__KERNEL_CS
 	pushl	%ebp
 	lret
-SYM_CODE_END(efi64_thunk)
+SYM_CODE_END(__efi64_thunk)
-- 
2.24.1

