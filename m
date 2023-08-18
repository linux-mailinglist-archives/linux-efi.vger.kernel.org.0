Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B996780B3C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376709AbjHRLiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376710AbjHRLiM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:38:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4F2112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 585AF63FB9
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED03CC433C8;
        Fri, 18 Aug 2023 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358690;
        bh=u2Qe/DFQYFdROgabTymAKmhbaOyvbe9/hjLZEwEHzOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAbm6Jo/ESvka3uLylNsmVQoyUrwgTT2OoHXiucAtOgm1aeilJtoKX2ZrGiEpRizU
         0mHs+CPBX9iel8JWZRIlUrYI7QdEwl7y3UUCygYJ9TUOlQnUtlx8eESRdxtb1NGTPH
         dyuRGSfUCOAzLX9pn1SWkC2SD8Bk2Sjx0rDNbYbguLV7Im4SnX/d0P4SyBoxWPIcEx
         rxXl4S/+qQZO0AyQn7WdVvJ95JM0G72rUQGJZgGBXXQbGNpejaBfxSpnja2q6fpk6o
         xy3REHqp0tr1PgGuOj3gLPH/Qm99pHBWtUCmFolTmoV42cF1620INgQ6wqhDQ7dX4i
         5vxnp3UtlxdXQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [RFC PATCH v2 11/11] efi/x86: Rely on compiler to emit MS ABI calls
Date:   Fri, 18 Aug 2023 13:37:24 +0200
Message-Id: <20230818113724.368492-12-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=ardb@kernel.org; h=from:subject; bh=u2Qe/DFQYFdROgabTymAKmhbaOyvbe9/hjLZEwEHzOA=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++Jd/oToLY3XPr5ZgPLVzcoWNVNO7+UwqAr9zpqUfd ttSazupo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExE1Ybhv4N5Wtb6eSabFWZ+ OVHo+NHwcOwnrnaHVXmSUi/TRSN1+hj+x8494HRhusez14asjN5/HnldeuB05tFfpdk8bS39r0r W8QIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

When EFI support was added to the x86_64 port originally, GCC did not
implement support for emitting procedure calls using the MS calling
convention, which deviates from the SysV one used in Linux.

However, this support has been added a long time ago, and the EFI stub
(which runs in a different execution context) has already been updated
to simply rely on the __attribute__((ms_abi)) annotations of the EFI
function pointers, resulting in both GCC and Clang doing the right
thing, as long as the correct stack alignment is being used.

The EFI stub runs on the stack provided by the firmware, and maintains
16 byte alignment internally, but the core x86_64 code does not, so
explicit stack realignment is needed, and this has been dealt with in
a previous patch. So the asm wrapper has become redundant, and can be
dropped.

Note that one of the EFI runtime services returns void so a trick is
needed to make the compiler ignore the return value in that case, or an
error will be triggered.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h          | 11 +++-----
 arch/x86/platform/efi/Makefile      |  4 +--
 arch/x86/platform/efi/efi_stub_64.S | 27 --------------------
 3 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c47f2d49e6bc6a09..f5ac4dbecafe7f37 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -94,19 +94,14 @@ static inline void efi_fpu_end(void)
 #else /* !CONFIG_X86_32 */
 #define EFI_X86_KERNEL_ALLOC_LIMIT		EFI_ALLOC_LIMIT
 
-extern asmlinkage u64 __efi_call(void *fp, ...);
-
 extern bool efi_disable_ibt_for_runtime;
 
-#define efi_call(...) ({						\
-	__efi_nargs_check(efi_call, 7, __VA_ARGS__);			\
-	__efi_call(__VA_ARGS__);					\
-})
-
 #undef arch_efi_call_virt
 #define arch_efi_call_virt(p, f, args...) ({				\
 	u64 ret, ibt = ibt_save(efi_disable_ibt_for_runtime);		\
-	ret = efi_call((void *)p->f, args);				\
+	ret = __builtin_choose_expr(					\
+		__builtin_types_compatible_p(typeof((p)->f(args)),void),\
+			((p)->f(args), EFI_ABORTED), (p)->f(args));	\
 	ibt_restore(ibt);						\
 	ret;								\
 })
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 684ac27cdf7cabfe..6dbd9533c4ce088c 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -2,8 +2,8 @@
 KASAN_SANITIZE := n
 GCOV_PROFILE := n
 
-obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
-				   efi_stub_$(BITS).o
+obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o
+obj-$(CONFIG_X86_32)		+= efi_stub_32.o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
 obj-$(CONFIG_EFI_FAKE_MEMMAP)	+= fake_mem.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)	+= runtime-map.o
diff --git a/arch/x86/platform/efi/efi_stub_64.S b/arch/x86/platform/efi/efi_stub_64.S
deleted file mode 100644
index 2206b8bc47b8a757..0000000000000000
--- a/arch/x86/platform/efi/efi_stub_64.S
+++ /dev/null
@@ -1,27 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Function calling ABI conversion from Linux to EFI for x86_64
- *
- * Copyright (C) 2007 Intel Corp
- *	Bibo Mao <bibo.mao@intel.com>
- *	Huang Ying <ying.huang@intel.com>
- */
-
-#include <linux/linkage.h>
-#include <asm/nospec-branch.h>
-
-SYM_FUNC_START(__efi_call)
-	pushq %rbp
-	movq %rsp, %rbp
-	and $~0xf, %rsp
-	mov 16(%rbp), %rax
-	subq $48, %rsp
-	mov %r9, 32(%rsp)
-	mov %rax, 40(%rsp)
-	mov %r8, %r9
-	mov %rcx, %r8
-	mov %rsi, %rcx
-	CALL_NOSPEC rdi
-	leave
-	RET
-SYM_FUNC_END(__efi_call)
-- 
2.39.2

