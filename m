Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609BC108C86
	for <lists+linux-efi@lfdr.de>; Mon, 25 Nov 2019 12:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKYLEV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Nov 2019 06:04:21 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35319 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKYLEV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Nov 2019 06:04:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id s5so17429445wrw.2;
        Mon, 25 Nov 2019 03:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AVEMkvsWR/sNvjapu9tKVgZN4ymp03OcRz2rDBcgLY8=;
        b=XhMJ6SaPMJ+fUnMGc9Im0xze++K4ygCU7+hViZ7Z342n6P3Kxv0W/7zY8w6CEbogwn
         wwlOwUCi32+3xeiC51n4lrt9/Fj/+WiCNxfaDI/+h4KeunYZB9IbRq6ghsuLKH/7nucI
         YAYGVI7T78BT6ifukbOrzDQlR7WKkW/D2vkWGbZH5QfTwizFPBsfkELsYcj+MIiGpHSj
         XBAGY4Trnxi6ZwtL4azadn7tXGdKIJHM7cGDMAOLSRH+MUDQ8p3YKpzSAIarHUH7JcXs
         C1oN/4ZINBiqRV/227u41Hhd2DKffuTrrjGcqiZ6NOTM9hM0GoDw3qz1wxElrXRQDCwU
         PC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=AVEMkvsWR/sNvjapu9tKVgZN4ymp03OcRz2rDBcgLY8=;
        b=G4SsejW8+Gp/aTOi0DX16uZKeaf37BinbaH9TYP0zocCDO6UK5vunG4HMG9LntcwhL
         GdpZJp+144d5NoM3DWg0rQLXkTaGeB8IDOAJo9WIiZV/6r/kRVe0I+CKUQPGt+pkAg/h
         oL15+vtUXQgJ+iOgr4qVDGUjTKZnP4kNPaIgHVYa5/s5wS27vqYQBmh/4hs+QWsZlXzV
         CsSOR1krYPbm7BhwI/bVnAy9RHev0ZEVgwwql/t1s/53xSYMkScM8mQZ1PZLiD3CFbHK
         eX4+80hPcfC9qAgjEOl4Ra/fQWXSSWMyBuANHTovgrv7kfAIa8gRT2uAKtjdhaoH+ASr
         JTHw==
X-Gm-Message-State: APjAAAW26eyHA6EeI5iDPGLvpRJmo4WZHnNWERHp9fboVyo7DvL9REXw
        +YCMOX//JEG8ELa7wsc0LUs=
X-Google-Smtp-Source: APXvYqxe+RNnGEXSbykk+2ojm4G8kbvwCDdrHrZeRwzN13/SAIU4b/OoAZLr1ByVaNFwhc9soQwhRg==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr31082487wro.343.1574679857995;
        Mon, 25 Nov 2019 03:04:17 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id b2sm10321905wrr.76.2019.11.25.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 03:04:17 -0800 (PST)
Date:   Mon, 25 Nov 2019 12:04:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        James Morse <james.morse@arm.com>
Subject: [GIT PULL] EFI updates for v5.5
Message-ID: <20191125110415.GA37886@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-core-for-linus

   # HEAD: 2278f452a12d5b5b01f96441a7a4336710365022 Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

The main changes in this cycle were:

  - Wire up the EFI RNG code for x86. This enables an additional source of
    entropy during early boot.
    
  - Enable the TPM event log code on ARM platforms.

  - Update Ard's email address.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      MAINTAINERS: update Ard's email address to @kernel.org

Dominik Brodowski (2):
      efi/random: use arch-independent efi_call_proto()
      x86: efi/random: Invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table

Xinwei Kong (1):
      efi: libstub/tpm: enable tpm eventlog function for ARM platforms


 .mailmap                                |  1 +
 MAINTAINERS                             |  8 ++++----
 arch/x86/boot/compressed/eboot.c        |  3 +++
 drivers/firmware/efi/libstub/Makefile   |  5 +++--
 drivers/firmware/efi/libstub/arm-stub.c |  2 ++
 drivers/firmware/efi/libstub/efistub.h  |  2 --
 drivers/firmware/efi/libstub/random.c   | 23 ++++++++++++++++++-----
 include/linux/efi.h                     |  2 ++
 8 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/.mailmap b/.mailmap
index 83d7e750c2fc..5d3b741a3f95 100644
--- a/.mailmap
+++ b/.mailmap
@@ -32,6 +32,7 @@ Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <antoine.tenart@free-electrons.com>
 Antonio Ospite <ao2@ao2.it> <ao2@amarulasolutions.com>
 Archit Taneja <archit@ti.com>
+Ard Biesheuvel <ardb@kernel.org> <ard.biesheuvel@linaro.org>
 Arnaud Patard <arnaud.patard@rtp-net.org>
 Arnd Bergmann <arnd@arndb.de>
 Axel Dyks <xl@xlsigned.net>
diff --git a/MAINTAINERS b/MAINTAINERS
index cba1095547fd..cc9f02ab9316 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6003,14 +6003,14 @@ F:	sound/usb/misc/ua101.c
 EFI TEST DRIVER
 L:	linux-efi@vger.kernel.org
 M:	Ivan Hu <ivan.hu@canonical.com>
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 S:	Maintained
 F:	drivers/firmware/efi/test/
 
 EFI VARIABLE FILESYSTEM
 M:	Matthew Garrett <matthew.garrett@nebula.com>
 M:	Jeremy Kerr <jk@ozlabs.org>
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 L:	linux-efi@vger.kernel.org
 S:	Maintained
@@ -6189,7 +6189,7 @@ S:	Supported
 F:	security/integrity/evm/
 
 EXTENSIBLE FIRMWARE INTERFACE (EFI)
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-efi@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git
 S:	Maintained
@@ -15006,7 +15006,7 @@ F:	include/media/soc_camera.h
 F:	drivers/staging/media/soc_camera/
 
 SOCIONEXT SYNQUACER I2C DRIVER
-M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+M:	Ard Biesheuvel <ardb@kernel.org>
 L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	drivers/i2c/busses/i2c-synquacer.c
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
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index c382a48c6678..817237ce2420 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -189,6 +189,8 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table,
 		goto fail_free_cmdline;
 	}
 
+	efi_retrieve_tpm2_eventlog(sys_table);
+
 	/* Ask the firmware to clear memory on unclean shutdown */
 	efi_enable_reset_attack_mitigation(sys_table);
 
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
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index b4b1d1dcb5fd..53f1466f7de6 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -9,6 +9,18 @@
 
 #include "efistub.h"
 
+typedef struct efi_rng_protocol efi_rng_protocol_t;
+
+typedef struct {
+	u32 get_info;
+	u32 get_rng;
+} efi_rng_protocol_32_t;
+
+typedef struct {
+	u64 get_info;
+	u64 get_rng;
+} efi_rng_protocol_64_t;
+
 struct efi_rng_protocol {
 	efi_status_t (*get_info)(struct efi_rng_protocol *,
 				 unsigned long *, efi_guid_t *);
@@ -28,7 +40,7 @@ efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
 	if (status != EFI_SUCCESS)
 		return status;
 
-	return rng->get_rng(rng, NULL, size, out);
+	return efi_call_proto(efi_rng_protocol, get_rng, rng, NULL, size, out);
 }
 
 /*
@@ -161,15 +173,16 @@ efi_status_t efi_random_get_seed(efi_system_table_t *sys_table_arg)
 	if (status != EFI_SUCCESS)
 		return status;
 
-	status = rng->get_rng(rng, &rng_algo_raw, EFI_RANDOM_SEED_SIZE,
-			      seed->bits);
+	status = efi_call_proto(efi_rng_protocol, get_rng, rng, &rng_algo_raw,
+				 EFI_RANDOM_SEED_SIZE, seed->bits);
+
 	if (status == EFI_UNSUPPORTED)
 		/*
 		 * Use whatever algorithm we have available if the raw algorithm
 		 * is not implemented.
 		 */
-		status = rng->get_rng(rng, NULL, EFI_RANDOM_SEED_SIZE,
-				      seed->bits);
+		status = efi_call_proto(efi_rng_protocol, get_rng, rng, NULL,
+					 EFI_RANDOM_SEED_SIZE, seed->bits);
 
 	if (status != EFI_SUCCESS)
 		goto err_freepool;
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
