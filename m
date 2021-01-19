Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F822FBF35
	for <lists+linux-efi@lfdr.de>; Tue, 19 Jan 2021 19:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbhASSbS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Jan 2021 13:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbhASS3Q (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 19 Jan 2021 13:29:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7868F233FC;
        Tue, 19 Jan 2021 17:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611076234;
        bh=AbpYgt587ZN6eezjok7Guq7P4jVFlsriyW0N1jwGf20=;
        h=From:To:Cc:Subject:Date:From;
        b=Tgl3W7Lja6oxFAccnxImupeI5nn0iF938FpcF7HcA8fVJiGxM14p/iP7bk54bLbpD
         Rl4duk/W2jSLBGd8/SkbBwlvKdO1RBbrld/v3Du83OBB2qeJVll6QGQ9UsHDsSv0bD
         zcTf8hKZLi9DaJSCrL0EiXNk62ibM2zFt6hJ7ej05+aqaCB3T1m2kfrMLDmAfu+gt+
         f0l2+cBeGQOopLbv67Vpkw8f48QKf3etFV+y7ZguTpnILY+FYW4nOBL1TDAeQ+t2bS
         5cRrLPk8kVKknkhPDZTNxb03Lhwm/QM5KE0dBOBuf5No53Jd5csvr6jXSYXuAap53r
         omwopChx0k7rA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] efi: x86: move mixed mode stack PA variable out of 'efi_scratch'
Date:   Tue, 19 Jan 2021 18:10:20 +0100
Message-Id: <20210119171021.27974-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

As a first step to removing the awkward 'struct efi_scratch' definition
that conveniently combines the storage of the mixed mode stack pointer
with the MM pointer variable that records the task's MM pointer while it
is being replaced with the EFI MM one, move the mixed mode stack pointer
into a separate variable.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h           | 3 +--
 arch/x86/platform/efi/efi_64.c       | 2 +-
 arch/x86/platform/efi/efi_thunk_64.S | 6 +++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c98f78330b09..5e37e6d63c63 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -12,6 +12,7 @@
 #include <linux/pgtable.h>
 
 extern unsigned long efi_fw_vendor, efi_config_table;
+extern unsigned long efi_mixed_mode_stack_pa;
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -96,11 +97,9 @@ extern asmlinkage u64 __efi_call(void *fp, ...);
 
 /*
  * struct efi_scratch - Scratch space used while switching to/from efi_mm
- * @phys_stack: stack used during EFI Mixed Mode
  * @prev_mm:    store/restore stolen mm_struct while switching to/from efi_mm
  */
 struct efi_scratch {
-	u64			phys_stack;
 	struct mm_struct	*prev_mm;
 } __packed;
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index e1e8d4e3a213..1d904181e6a1 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -256,7 +256,7 @@ int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages)
 		return 1;
 	}
 
-	efi_scratch.phys_stack = page_to_phys(page + 1); /* stack grows down */
+	efi_mixed_mode_stack_pa = page_to_phys(page + 1); /* stack grows down */
 
 	npages = (_etext - _text) >> PAGE_SHIFT;
 	text = __pa(_text);
diff --git a/arch/x86/platform/efi/efi_thunk_64.S b/arch/x86/platform/efi/efi_thunk_64.S
index 26f0da238c1c..fd3dd1708eba 100644
--- a/arch/x86/platform/efi/efi_thunk_64.S
+++ b/arch/x86/platform/efi/efi_thunk_64.S
@@ -33,7 +33,7 @@ SYM_CODE_START(__efi64_thunk)
 	 * Switch to 1:1 mapped 32-bit stack pointer.
 	 */
 	movq	%rsp, %rax
-	movq	efi_scratch(%rip), %rsp
+	movq	efi_mixed_mode_stack_pa(%rip), %rsp
 	push	%rax
 
 	/*
@@ -70,3 +70,7 @@ SYM_CODE_START(__efi64_thunk)
 	pushl	%ebp
 	lret
 SYM_CODE_END(__efi64_thunk)
+
+	.bss
+	.balign 8
+SYM_DATA(efi_mixed_mode_stack_pa, .quad 0)
-- 
2.17.1

