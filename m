Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C5F324F
	for <lists+linux-efi@lfdr.de>; Thu,  7 Nov 2019 16:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfKGPLE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Nov 2019 10:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388215AbfKGPLD (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 7 Nov 2019 10:11:03 -0500
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC0021D7E;
        Thu,  7 Nov 2019 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573139462;
        bh=QGlx/0lTtlPo1pPUoK2v4agM2ZMHLbvfThCaSQNT1rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbUPcnFgfHg6IARJNAoUITp5eEc9iWFTqdyX4iFMQ4gpiIfNb/BcOFZ/BPYJC4La/
         Xx1OEaE+YRVqHn1e2uqqE7iI6IXXHj5hmvTDHblXWB0VTHIzdiLYl7jHFdT5up990t
         RdJW/rkzs4iFqbU7e9sW43WfwQn+2buzNMN/wvv4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Zou Cao <zoucao@linux.alibaba.com>
Subject: [PATCH 3/4] x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table
Date:   Thu,  7 Nov 2019 16:10:35 +0100
Message-Id: <20191107151036.5586-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107151036.5586-1-ardb@kernel.org>
References: <20191107151036.5586-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>

Invoke the EFI_RNG_PROTOCOL protocol in the context of the x86 EFI stub,
same as is done on arm/arm64 since commit 568bc4e87033 ("efi/arm*/libstub:
Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table"). Within the stub,
a Linux-specific RNG seed UEFI config table will be seeded. The EFI routines
in the core kernel will pick that up later, yet still early during boot,
to seed the kernel entropy pool. If CONFIG_RANDOM_TRUST_BOOTLOADER, entropy
is credited for this seed.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
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
2.17.1

