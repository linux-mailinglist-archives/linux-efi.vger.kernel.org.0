Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D112F786
	for <lists+linux-efi@lfdr.de>; Fri,  3 Jan 2020 12:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgACLks (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 3 Jan 2020 06:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgACLkr (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 3 Jan 2020 06:40:47 -0500
Received: from localhost.localdomain (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477BC24655;
        Fri,  3 Jan 2020 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578051646;
        bh=Lz3g1HD3Aatv1rI/ib8wH2Clkm6CnbIojyw9mtMeti4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6z0GCcVk2Vv6RGIoMQRWBW/RMkR4arL3K5ql1kLHMVXzbYbyDc7tO7WfV6DADQ8n
         H4XTTHl/iK8ECE48KlecGzv77+BzxhbqLgQmE5UVrjnin8CyRI+6QwHHfR27nRFJEY
         8wJC2NPumB+10o/6ZojCc4InSREVuW2XOoLY/YGk=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Subject: [PATCH 15/20] efi/x86: Check number of arguments to variadic functions
Date:   Fri,  3 Jan 2020 12:39:48 +0100
Message-Id: <20200103113953.9571-16-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103113953.9571-1-ardb@kernel.org>
References: <20200103113953.9571-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

On x86 we need to thunk through assembler stubs to call the EFI services
for mixed mode, and for runtime services in 64-bit mode. The assembler
stubs have limits on how many arguments it handles. Introduce a few
macros to check that we do not try to pass too many arguments to the
stubs.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
2.20.1

