Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E00780B3D
	for <lists+linux-efi@lfdr.de>; Fri, 18 Aug 2023 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376708AbjHRLiV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 18 Aug 2023 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376709AbjHRLiK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 18 Aug 2023 07:38:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC172112
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 04:38:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B0C564074
        for <linux-efi@vger.kernel.org>; Fri, 18 Aug 2023 11:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5001C433CD;
        Fri, 18 Aug 2023 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692358687;
        bh=F5N2BWCw5LXSqWAwGduHWB8UYKK7GwBQ9TfTdKH2KyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uinUEGFQ7AN0uE+14o0o0c4NeUBqlN91QNkD/YqOxz+bTjZ5YdqE49VbAKMVuDvuK
         es1iYXTVBvxVQjDHgpOoknY1HpX0whrUcdObPPwvmB6XXW5/JxFvpj/x3Hc1O8p3CG
         RccY7I8t9sC5X0gk1WxuKzyACYxuXFUcKtTuGLtgi0vM2O1xqs2nagOIzpiiIl/25C
         IH1BgG8tdQy7VluYao0FFA082aMjn9zDwXKuW2nLFezqUvYPGGA7iFCMYpjvD13Ppw
         xuC2vlnuPoNYxhBg4w0jXN5y8dyhlL8G2L9NtJb3c7TK1FmBbRX5GIiYevLh2o5kEh
         OnRZHPhZdLTBA==
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
Subject: [RFC PATCH v2 10/11] efi/x86: Realign EFI runtime stack
Date:   Fri, 18 Aug 2023 13:37:23 +0200
Message-Id: <20230818113724.368492-11-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818113724.368492-1-ardb@kernel.org>
References: <20230818113724.368492-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6508; i=ardb@kernel.org; h=from:subject; bh=F5N2BWCw5LXSqWAwGduHWB8UYKK7GwBQ9TfTdKH2KyQ=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeV++Gd7h/AZwmJd8/t0VKzlgxM2Zl/g2cTk91z7av61T 1K1oZ4dpSwMYhwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCKhBxn+iqourWHP3PVEo/C6 kV2G1DaJcxVnjt0r3uAoxnBGW3dhOCPD5oKGuKuPX7We7VSok1p4a//xnCO/b3c+uWPLfZPHcFk JAwA=
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

Instruct the compiler to realign the stack to 16 bytes, as required by
the UEFI specification for x86_64. This will allow us to drop the asm
helper that converts between MS and SysV calling conventions in a future
patch.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                       |  3 +++
 arch/x86/include/asm/efi.h              |  2 ++
 arch/x86/platform/efi/Makefile          |  2 ++
 arch/x86/platform/efi/efi_64.c          |  2 +-
 arch/x86/platform/uv/Makefile           |  1 +
 arch/x86/platform/uv/bios_uv.c          |  4 ++--
 drivers/firmware/efi/Makefile           |  1 +
 drivers/firmware/efi/runtime-wrappers.c | 17 ++++++++++-------
 8 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index fdc2e3abd6152f53..debc43fb9a2e6d36 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -36,10 +36,13 @@ export RETPOLINE_VDSO_CFLAGS
 ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
       cc_stack_align4 := -mpreferred-stack-boundary=2
       cc_stack_align8 := -mpreferred-stack-boundary=3
+      EFI_STACK_ALIGN := -mpreferred-stack-boundary=4
 else ifneq ($(call cc-option, -mstack-alignment=16),)
       cc_stack_align4 := -mstack-alignment=4
       cc_stack_align8 := -mstack-alignment=8
+      EFI_STACK_ALIGN := -mstack-alignment=16
 endif
+export EFI_STACK_ALIGN
 
 # How to compile the 16-bit code.  Note we always compile for -march=i386;
 # that way we can complain to the user if the CPU is insufficient.
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c4555b269a1b2474..c47f2d49e6bc6a09 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -111,6 +111,8 @@ extern bool efi_disable_ibt_for_runtime;
 	ret;								\
 })
 
+#define __efi_realign_stack	__attribute__((force_align_arg_pointer))
+
 #ifdef CONFIG_KASAN
 /*
  * CONFIG_KASAN may redefine memset to __memset.  __memset function is present
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 543df9a1379d121c..684ac27cdf7cabfe 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_EFI) 		+= memmap.o quirks.o efi.o efi_$(BITS).o \
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
 obj-$(CONFIG_EFI_FAKE_MEMMAP)	+= fake_mem.o
 obj-$(CONFIG_EFI_RUNTIME_MAP)	+= runtime-map.o
+
+CFLAGS_efi_64.o			:= $(EFI_STACK_ALIGN)
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 91d31ac422d6cde7..8033b4a338c4b431 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -846,7 +846,7 @@ void __init efi_thunk_runtime_setup(void)
 	efi.query_capsule_caps = efi_thunk_query_capsule_caps;
 }
 
-efi_status_t __init __no_sanitize_address
+efi_status_t __init __no_sanitize_address __efi_realign_stack
 efi_set_virtual_address_map(unsigned long memory_map_size,
 			    unsigned long descriptor_size,
 			    u32 descriptor_version,
diff --git a/arch/x86/platform/uv/Makefile b/arch/x86/platform/uv/Makefile
index 1441dda8edf76879..cb4807ba4ef50f02 100644
--- a/arch/x86/platform/uv/Makefile
+++ b/arch/x86/platform/uv/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_X86_UV)		+= bios_uv.o uv_irq.o uv_time.o uv_nmi.o
+CFLAGS_bios_uv.o		:= $(EFI_STACK_ALIGN)
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index bf31af3d32d69cbc..d6b69f363aa1f2a9 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -20,8 +20,8 @@ unsigned long uv_systab_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
 
 struct uv_systab *uv_systab;
 
-static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
-			u64 a4, u64 a5)
+static s64 __efi_realign_stack
+__uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
 {
 	struct uv_systab *tab = uv_systab;
 	s64 ret;
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index e489fefd23dae0bc..db3f8c1fbc1d8a54 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -9,6 +9,7 @@
 # in efi_call_virt() will cause crash if this code instrumented.
 #
 KASAN_SANITIZE_runtime-wrappers.o	:= n
+CFLAGS_runtime-wrappers.o		:= $(EFI_STACK_ALIGN)
 
 obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index dfec5969dbaba417..2db9e0b3c2842e50 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -35,6 +35,10 @@
 
 #include <asm/efi.h>
 
+#ifndef __efi_realign_stack
+#define __efi_realign_stack
+#endif
+
 /*
  * Wrap around the new efi_call_virt_generic() macros so that the
  * code doesn't get too cluttered:
@@ -213,7 +217,7 @@ extern struct semaphore __efi_uv_runtime_lock __alias(efi_runtime_lock);
  * Calls the appropriate efi_runtime_service() with the appropriate
  * arguments.
  */
-static void efi_call_rts(struct work_struct *work)
+static void __efi_realign_stack efi_call_rts(struct work_struct *work)
 {
 	const union efi_rts_args *args = efi_rts_work.args;
 	efi_status_t status = EFI_NOT_FOUND;
@@ -436,7 +440,7 @@ static efi_status_t virt_efi_set_variable(efi_char16_t *name,
 	return status;
 }
 
-static efi_status_t
+static efi_status_t __efi_realign_stack
 virt_efi_set_variable_nb(efi_char16_t *name, efi_guid_t *vendor, u32 attr,
 			 unsigned long data_size, void *data)
 {
@@ -470,7 +474,7 @@ static efi_status_t virt_efi_query_variable_info(u32 attr,
 	return status;
 }
 
-static efi_status_t
+static efi_status_t __efi_realign_stack
 virt_efi_query_variable_info_nb(u32 attr, u64 *storage_space,
 				u64 *remaining_space, u64 *max_variable_size)
 {
@@ -500,10 +504,9 @@ static efi_status_t virt_efi_get_next_high_mono_count(u32 *count)
 	return status;
 }
 
-static void virt_efi_reset_system(int reset_type,
-				  efi_status_t status,
-				  unsigned long data_size,
-				  efi_char16_t *data)
+static void __efi_realign_stack
+virt_efi_reset_system(int reset_type, efi_status_t status,
+		      unsigned long data_size, efi_char16_t *data)
 {
 	if (down_trylock(&efi_runtime_lock)) {
 		pr_warn("failed to invoke the reset_system() runtime service:\n"
-- 
2.39.2

