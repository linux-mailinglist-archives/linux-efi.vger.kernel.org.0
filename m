Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01EA5CC9A7
	for <lists+linux-efi@lfdr.de>; Sat,  5 Oct 2019 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfJELiF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 5 Oct 2019 07:38:05 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54898 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfJELiF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 5 Oct 2019 07:38:05 -0400
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
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A23B020070A;
        Sat,  5 Oct 2019 11:38:02 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 515AB207FA; Sat,  5 Oct 2019 13:37:53 +0200 (CEST)
Date:   Sat, 5 Oct 2019 13:37:53 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [RFC PATCH] arch/x86: efistub: Invoke EFI_RNG_PROTOCOL to seed the
 UEFI RNG table
Message-ID: <20191005113753.GA77634@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Implement the same mechanism for x86 efistub as introduced by commit
568bc4e87033 ("efi/arm*/libstub: Invoke EFI_RNG_PROTOCOL to seed the
UEFI RNG table") for efi/arm*/libstub, and best described here and there
as:

    Invoke the EFI_RNG_PROTOCOL protocol in the context of the stub and
    install the Linux-specific RNG seed UEFI config table. This will be
    picked up by the EFI routines in the core kernel to seed the kernel
    entropy pool.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: <x86@kernel.org>

---

As far as I can see, we do not yet make use of the UEFI RNG on x86 at all,
but only on arm. Note that this works only when Linux is booted as an EFI
stub, and that the EFI-provided randomness is not credited as entropy
unless RANDOM_TRUST_BOOTLOADER is set _and_ another patch (on its way
upstream; thanks Ard!) is applied, see
	https://lore.kernel.org/lkml/20190928101428.GA222453@light.dominikbrodowski.net/

Further note that this patch is untested, as the firmware on my old x86
laptop only has UEFI v2.31. If you want to test it, you may wish to apply
	https://lore.kernel.org/lkml/20191005113632.GA74715@light.dominikbrodowski.net/T/#u
first to get a clear indication in dmesg.

Thanks,
	Dominik


diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fdef300..4b909e5ab857 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -781,6 +781,9 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation(sys_table);
+
+	efi_random_get_seed(sys_table);
+
 	efi_retrieve_tpm2_eventlog(sys_table);
 
 	setup_graphics(boot_params);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..ece24c60fc2c 100644
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
index bd3837022307..a17cc5841668 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1631,6 +1631,8 @@ static inline void
 efi_enable_reset_attack_mitigation(efi_system_table_t *sys_table_arg) { }
 #endif
 
+efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg);
+
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
 /*
