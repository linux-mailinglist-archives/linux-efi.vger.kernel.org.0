Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99545F0FEF
	for <lists+linux-efi@lfdr.de>; Wed,  6 Nov 2019 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfKFHJU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Nov 2019 02:09:20 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:58744 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729734AbfKFHJT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Nov 2019 02:09:19 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E264120099E;
        Wed,  6 Nov 2019 07:09:16 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id E038580464; Wed,  6 Nov 2019 08:06:43 +0100 (CET)
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-efi@vger.kernel.org,
        Mario Limonciello <Mario.Limonciello@dell.com>
Subject: [PATCH 2/2] x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table
Date:   Wed,  6 Nov 2019 08:06:13 +0100
Message-Id: <20191106070613.227833-3-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106070613.227833-1-linux@dominikbrodowski.net>
References: <20191106070613.227833-1-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Invoke the EFI_RNG_PROTOCOL protocol in the context of the x86 EFI stub,
same as is done on arm/arm64 since commit 568bc4e87033 ("efi/arm*/libstub:
Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table"). Within the stub,
a Linux-specific RNG seed UEFI config table will be seeded. The EFI routines
in the core kernel will pick that up later, yet still early during boot,
to seed the kernel entropy pool. If CONFIG_RANDOM_TRUST_BOOTLOADER, entropy
is credited for this seed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>
Cc: <linux-efi@vger.kernel.org>
---
 arch/x86/boot/compressed/eboot.c       | 3 +++
 drivers/firmware/efi/libstub/Makefile  | 5 +++--
 drivers/firmware/efi/libstub/efistub.h | 2 --
 include/linux/efi.h                    | 2 ++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 82bc60c8acb2..68945c5700bf 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -782,6 +782,9 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation(sys_table);
+
+	efi_random_get_seed(sys_table);
+
 	efi_retrieve_tpm2_eventlog(sys_table);
 
 	setup_graphics(boot_params);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ee0661ddb25b..c35f893897e1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -38,7 +38,8 @@ OBJECT_FILES_NON_STANDARD	:= y
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
 KCOV_INSTRUMENT			:= n
 
-lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o
+lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
+				   random.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
 arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
@@ -47,7 +48,7 @@ arm-deps-$(CONFIG_ARM64) += sort.c
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o random.o \
+lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
 				   $(patsubst %.c,lib-%.o,$(arm-deps-y))
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 7f1556fd867d..05739ae013c8 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -63,8 +63,6 @@ efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
 
 efi_status_t check_platform_features(efi_system_table_t *sys_table_arg);
 
-efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
-
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid);
 
 /* Helper macros for the usual case of using simple C variables: */
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d87acf62958e..028efa7a9f3b 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1645,6 +1645,8 @@ static inline void
 efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
 #endif
 
+efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
+
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
 /*
-- 
2.24.0

