Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0D16F4AE
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 02:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgBZBKu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 20:10:50 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57148 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729170AbgBZBKu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Feb 2020 20:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582679450; x=1614215450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bpfOWeCDP3qbnbScpAF1BlT5s86+7Hl4XNmrh2YhN1Y=;
  b=Bt1I3Fe4M2f/kWPpK72m3Cy5FpiwMrK/2nXwb8UvhQxJpiGow/udyNx1
   DQCi/WmGPSlNluco+JKQaIrpGQH3wARsP8yQd34xEyl9fFUgvdnf3dQfb
   eyVK1zgJqZPtFRUFBSd4js5Gr2Pf66p4pqx2Q96ekCCEShNEGWBF8MiIK
   TrtEi6kHTP/2ZviimQKZRaQFl/Y2/4A6rPIWZanLqZXf27Fritm2z5Hb3
   2bz4pi8HB0Kpi6iI+6S7Wdv4CPq7OPtUg9EbkvfWV8KVOKNhihcWX2E/W
   dihHi3iFx+Eq2CfuJxUUUV3ZwR7Muy0RpyJZKPo+cx5HeOpSeaoVNSmZG
   Q==;
IronPort-SDR: bRi4BGtX/utCv7WcTWW4Z5pRnFgcz6YliGyvcjxTfFXWE44sLU1tgtgGAKNRjO5wbHiM7DuDme
 u0YV8muX+wn1IwjmDSoXdgNl7WxxcELuJoWY8BqPbthl8lxhqSC/YDn1XvxjPdzGyKVjThizNm
 0932pGPQtkc2b24IqHhIidKpk4MK7z0Qso/RWVwgh3tVESuK5Ni9VPzUPBoH/XQy/3qzmkGNu7
 PJaGqvCuSJUMFBS4GMS1fWasoaM1K4bmcmTTAly9c/U0blk1KP7/RtmfvLrKB0qwlxfr8NIMWB
 RgA=
X-IronPort-AV: E=Sophos;i="5.70,486,1574092800"; 
   d="scan'208";a="131266498"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2020 09:10:49 +0800
IronPort-SDR: 7+j3amOod8YdN21IREgwZ5iSIsxHMhMv/aFUlDS8NDLTHxG4vk//fkrauf7aNdA0IU+StWryCA
 +WJOhxG4QTRW18gxr1SH+xl1e/OdFP6MgOn2+VKeFc/+rWJd50srIreOSr4l9e1W2IScoZo5bf
 dI7jmxHu4urfDkCJxBikjyrbNEsqyX/ZGBcf9WLgqvwQAPc/T1uABPIqdnVPbZVk2mOdntXTxl
 T7NkuecZKbMZgJpeZqQjmLKwcdogpBA6OU8dkQsDu0uxG5Ml1+3CknyGtni+mQNmC0Iw1GwpDv
 ECY4NW4sOO4PpIOOu+0tRYCy
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:03:15 -0800
IronPort-SDR: S3s5fU4WRnyhz3CFMegfsbMTVbTiYo7e+DJDkRNBhGN+af39g/4653NJ55fbwl3ZwLTEzxeGQ6
 0y7u6IZK+LHZkkSvPjJnRkL1yQqHW/4zI49n1HCZC7R4N3Fc/NayLWAwkerOQ42NACl7mypfNH
 ZOyi4Vbm8bSpydzxyBVBp5DQaeBB1MMoLtc1FZ0G1R5UeXfaxKMlmpFEXxw1C8kyajrZSPdg8C
 GkY1aoNnADAN4NWnsJcQ0zgtxF1aPzxDBs1DMosaiomiu4NU1qr3nOAsuYJlcVuxgw9vvf7gO3
 OlM=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Feb 2020 17:10:47 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        daniel.schaefer@hpe.com
Subject: [RFC PATCH 1/5] efi: Move arm-stub to a common file
Date:   Tue, 25 Feb 2020 17:10:33 -0800
Message-Id: <20200226011037.7179-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200226011037.7179-1-atish.patra@wdc.com>
References: <20200226011037.7179-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Most of the arm-stub code is written in an architecture independent manner.
As a result, RISC-V can reuse most of the arm-stub code.

Rename the arm-stub.c to efi-stub.c so that ARM, ARM64 and RISC-V can use it.
This patch doesn't introduce any functional changes.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/arm/Kconfig                                     |  2 +-
 arch/arm64/Kconfig                                   |  2 +-
 drivers/firmware/efi/Kconfig                         |  6 +++---
 drivers/firmware/efi/libstub/Makefile                | 12 ++++++------
 .../firmware/efi/libstub/{arm-stub.c => efi-stub.c}  |  7 ++++++-
 5 files changed, 17 insertions(+), 12 deletions(-)
 rename drivers/firmware/efi/libstub/{arm-stub.c => efi-stub.c} (98%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97864aabc2a6..9931fea06076 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1955,7 +1955,7 @@ config EFI
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
 	select EFI_STUB
-	select EFI_ARMSTUB
+	select EFI_GENERIC_ARCH_STUB
 	select EFI_RUNTIME_WRAPPERS
 	---help---
 	  This option provides support for runtime services provided
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0b30e884e088..ae776d8ef2f9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1720,7 +1720,7 @@ config EFI
 	select EFI_PARAMS_FROM_FDT
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
-	select EFI_ARMSTUB
+	select EFI_GENERIC_ARCH_STUB
 	default y
 	help
 	  This option provides support for runtime services provided
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index ecc83e2f032c..1bcedb7812da 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -106,12 +106,12 @@ config EFI_PARAMS_FROM_FDT
 config EFI_RUNTIME_WRAPPERS
 	bool
 
-config EFI_ARMSTUB
+config EFI_GENERIC_ARCH_STUB
 	bool
 
-config EFI_ARMSTUB_DTB_LOADER
+config EFI_STUB_DTB_LOADER
 	bool "Enable the DTB loader"
-	depends on EFI_ARMSTUB
+	depends on EFI_GENERIC_ARCH_STUB
 	default y
 	help
 	  Select this config option to add support for the dtb= command
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 4d6246c6f651..2c5b76787126 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -22,7 +22,7 @@ cflags-$(CONFIG_ARM)		:= $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
 				   -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
 
-cflags-$(CONFIG_EFI_ARMSTUB)	+= -I$(srctree)/scripts/dtc/libfdt
+cflags-$(CONFIG_EFI_GENERIC_ARCH_STUB)	+= -I$(srctree)/scripts/dtc/libfdt
 
 KBUILD_CFLAGS			:= $(cflags-y) -DDISABLE_BRANCH_PROFILING \
 				   -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
@@ -44,13 +44,13 @@ lib-y				:= efi-stub-helper.o gop.o secureboot.o tpm.o \
 				   skip_spaces.o lib-cmdline.o lib-ctype.o
 
 # include the stub's generic dependencies from lib/ when building for ARM/arm64
-arm-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
+efi-deps-y := fdt_rw.c fdt_ro.c fdt_wip.c fdt.c fdt_empty_tree.c fdt_sw.c
 
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o \
-				   $(patsubst %.c,lib-%.o,$(arm-deps-y))
+lib-$(CONFIG_EFI_GENERIC_ARCH_STUB)		+= efi-stub.o fdt.o string.o \
+				   $(patsubst %.c,lib-%.o,$(efi-deps-y))
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
@@ -72,8 +72,8 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
-extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
-lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
+extra-$(CONFIG_EFI_GENERIC_ARCH_STUB)	:= $(lib-y)
+lib-$(CONFIG_EFI_GENERIC_ARCH_STUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
similarity index 98%
rename from drivers/firmware/efi/libstub/arm-stub.c
rename to drivers/firmware/efi/libstub/efi-stub.c
index 13559c7e6643..b87c3f70430c 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -15,6 +15,7 @@
 
 #include "efistub.h"
 
+#if IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)
 /*
  * This is the base address at which to start allocating virtual memory ranges
  * for UEFI Runtime Services. This is in the low TTBR0 range so that we can use
@@ -27,6 +28,10 @@
  * entire footprint of the UEFI runtime services memory regions)
  */
 #define EFI_RT_VIRTUAL_BASE	SZ_512M
+#else
+#define EFI_RT_VIRTUAL_BASE	SZ_2G
+#endif
+
 #define EFI_RT_VIRTUAL_SIZE	SZ_512M
 
 #ifdef CONFIG_ARM64
@@ -243,7 +248,7 @@ efi_status_t efi_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg)
 	 * 'dtb=' unless UEFI Secure Boot is disabled.  We assume that secure
 	 * boot is enabled if we can't determine its state.
 	 */
-	if (!IS_ENABLED(CONFIG_EFI_ARMSTUB_DTB_LOADER) ||
+	if (!IS_ENABLED(CONFIG_EFI_STUB_DTB_LOADER) ||
 	     secure_boot != efi_secureboot_mode_disabled) {
 		if (strstr(cmdline_ptr, "dtb="))
 			pr_efi("Ignoring DTB from command line.\n");
-- 
2.24.0

