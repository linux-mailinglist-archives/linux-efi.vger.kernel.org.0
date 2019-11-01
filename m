Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A15EC817
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2019 18:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfKARnG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Nov 2019 13:43:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56039 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfKARnG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Nov 2019 13:43:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id m17so817570wmi.5;
        Fri, 01 Nov 2019 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=K37huXBPmO7/r46/XgyRhkUfWqoeS8ZXDvDkS6Jqwx8=;
        b=GGOFJw6xQODUzZFmDmzLlYCiuaxu12rd/csMQxvyg5qIg1bdj/HkpH1uqo2GbiYn3m
         UMxPE9esNu3zFKNr1f/FjLERfiRVNPTMZq42I+FUlhMV8pBvZNGy2FE20To8k4+Ktnp3
         ELI9dtWXaHY59E9oS/YvhL+lNZIELstTxMupJ+ko1pCeIFgtM5gTehe5AIiOtdXc5o/x
         EWJYVu1uz18yQuVtK5RJJ+sv852P8l6cu3nwMRmQVFVK138oFdY3Fw/uE075Vq3x5WNp
         ZompiWfUWydmWSCyA6GzcGV9HcsK7UeONcfA+rXHXpZKWLm9x5dQbSoIiHUZA4xjQ8bT
         XzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=K37huXBPmO7/r46/XgyRhkUfWqoeS8ZXDvDkS6Jqwx8=;
        b=nMvQ4BTKZVUzQuwZvCAqSXk0BzFsmvLqjpyAmFDzPPoxMer53ldKUPAubGZaDcNeA5
         +zeYqFyGbeWzUzPbiiiJY7/XAF4bjAjJthyyt0K5jlhWg8TGV1CtyorL+PDlCgpGW5Bu
         q77KZ5yUozutql0r26G1ltOBZG9WYfvVdojYZM28irdGVqILy6yZtkp3Oa0rAn8SiqHE
         B8O2in93RyOqCSd10eJboLWBy/wGrMuOp+liDaQVZEQo1tlVa67NjUtgQP2nRvVaLKcr
         SZ8FwS7h4zZtReRrRK6solyFF9OTPQNxjy/9KDlMLUUnDNfrycUoQT3z0rYmlZeNvM4W
         YVHg==
X-Gm-Message-State: APjAAAXSOD1AhlWiyp79j4e9gZx6fy0VIhEyDiV+GH5pdhfZo64nuFmZ
        Y0LtVLrYBBvou23Rew+QFIw=
X-Google-Smtp-Source: APXvYqwl/SLarU9lhp4jKPCe84MpPs8CdUL/nzvkH7ajQas761aqdxAj9cM7g62ReP6gPqeyp5cNqA==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr11916890wma.81.1572630183382;
        Fri, 01 Nov 2019 10:43:03 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d4sm12173797wrc.54.2019.11.01.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 10:43:02 -0700 (PDT)
Date:   Fri, 1 Nov 2019 18:43:00 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>, linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20191101174300.GA33878@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-for-linus

   # HEAD: 359efcc2c910117d2faf704ce154e91fc976d37f efi/efi_test: Lock down /dev/efi_test and require CAP_SYS_ADMIN

Various fixes all over the map: prevent boot crashes on HyperV, classify 
UEFI randomness as bootloader randomness, fix EFI boot for the Raspberry 
Pi2, fix efi_test permissions, etc.


 Thanks,

	Ingo

------------------>
Ard Biesheuvel (1):
      efi: libstub/arm: Account for firmware reserved memory at the base of RAM

Dominik Brodowski (1):
      efi/random: Treat EFI_RNG_PROTOCOL output as bootloader randomness

Javier Martinez Canillas (1):
      efi/efi_test: Lock down /dev/efi_test and require CAP_SYS_ADMIN

Jerry Snitselaar (1):
      efi/tpm: Return -EINVAL when determining tpm final events log size fails

Kairui Song (1):
      x86, efi: Never relocate kernel below lowest acceptable address

Narendra K (1):
      efi: Make CONFIG_EFI_RCI2_TABLE selectable on x86 only


 arch/x86/boot/compressed/eboot.c               |  4 +++-
 drivers/firmware/efi/Kconfig                   |  1 +
 drivers/firmware/efi/efi.c                     |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  1 +
 drivers/firmware/efi/libstub/arm32-stub.c      | 16 +++++++++++++---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 24 ++++++++++--------------
 drivers/firmware/efi/test/efi_test.c           |  8 ++++++++
 drivers/firmware/efi/tpm.c                     |  1 +
 include/linux/efi.h                            | 18 ++++++++++++++++--
 include/linux/security.h                       |  1 +
 security/lockdown/lockdown.c                   |  1 +
 11 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index d6662fdef300..82bc60c8acb2 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -13,6 +13,7 @@
 #include <asm/e820/types.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/boot.h>
 
 #include "../string.h"
 #include "eboot.h"
@@ -813,7 +814,8 @@ efi_main(struct efi_config *c, struct boot_params *boot_params)
 		status = efi_relocate_kernel(sys_table, &bzimage_addr,
 					     hdr->init_size, hdr->init_size,
 					     hdr->pref_address,
-					     hdr->kernel_alignment);
+					     hdr->kernel_alignment,
+					     LOAD_PHYSICAL_ADDR);
 		if (status != EFI_SUCCESS) {
 			efi_printk(sys_table, "efi_relocate_kernel() failed!\n");
 			goto fail;
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 178ee8106828..b248870a9806 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -182,6 +182,7 @@ config RESET_ATTACK_MITIGATION
 
 config EFI_RCI2_TABLE
 	bool "EFI Runtime Configuration Interface Table Version 2 Support"
+	depends on X86 || COMPILE_TEST
 	help
 	  Displays the content of the Runtime Configuration Interface
 	  Table version 2 on Dell EMC PowerEdge systems as a binary
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69f00f7453a3..e98bbf8e56d9 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -554,7 +554,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 					      sizeof(*seed) + size);
 			if (seed != NULL) {
 				pr_notice("seeding entropy pool\n");
-				add_device_randomness(seed->bits, seed->size);
+				add_bootloader_randomness(seed->bits, seed->size);
 				early_memunmap(seed, sizeof(*seed) + size);
 			} else {
 				pr_err("Could not map UEFI random seed!\n");
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..ee0661ddb25b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o random.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
+CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 #
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..41213bf5fcf5 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -195,6 +195,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 				 unsigned long dram_base,
 				 efi_loaded_image_t *image)
 {
+	unsigned long kernel_base;
 	efi_status_t status;
 
 	/*
@@ -204,9 +205,18 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 * loaded. These assumptions are made by the decompressor,
 	 * before any memory map is available.
 	 */
-	dram_base = round_up(dram_base, SZ_128M);
+	kernel_base = round_up(dram_base, SZ_128M);
 
-	status = reserve_kernel_base(sys_table, dram_base, reserve_addr,
+	/*
+	 * Note that some platforms (notably, the Raspberry Pi 2) put
+	 * spin-tables and other pieces of firmware at the base of RAM,
+	 * abusing the fact that the window of TEXT_OFFSET bytes at the
+	 * base of the kernel image is only partially used at the moment.
+	 * (Up to 5 pages are used for the swapper page tables)
+	 */
+	kernel_base += TEXT_OFFSET - 5 * PAGE_SIZE;
+
+	status = reserve_kernel_base(sys_table, kernel_base, reserve_addr,
 				     reserve_size);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Unable to allocate memory for uncompressed kernel.\n");
@@ -220,7 +230,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	*image_size = image->image_size;
 	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
 				     *image_size,
-				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
+				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 3caae7f2cf56..35dbc2791c97 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -260,11 +260,11 @@ efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 }
 
 /*
- * Allocate at the lowest possible address.
+ * Allocate at the lowest possible address that is not below 'min'.
  */
-efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
-			   unsigned long size, unsigned long align,
-			   unsigned long *addr)
+efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
+				 unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min)
 {
 	unsigned long map_size, desc_size, buff_size;
 	efi_memory_desc_t *map;
@@ -311,13 +311,8 @@ efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 		start = desc->phys_addr;
 		end = start + desc->num_pages * EFI_PAGE_SIZE;
 
-		/*
-		 * Don't allocate at 0x0. It will confuse code that
-		 * checks pointers against NULL. Skip the first 8
-		 * bytes so we start at a nice even number.
-		 */
-		if (start == 0x0)
-			start += 8;
+		if (start < min)
+			start = min;
 
 		start = round_up(start, align);
 		if ((start + size) > end)
@@ -698,7 +693,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment)
+				 unsigned long alignment,
+				 unsigned long min_addr)
 {
 	unsigned long cur_image_addr;
 	unsigned long new_addr = 0;
@@ -731,8 +727,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 	 * possible.
 	 */
 	if (status != EFI_SUCCESS) {
-		status = efi_low_alloc(sys_table_arg, alloc_size, alignment,
-				       &new_addr);
+		status = efi_low_alloc_above(sys_table_arg, alloc_size,
+					     alignment, &new_addr, min_addr);
 	}
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table_arg, "Failed to allocate usable memory for kernel.\n");
diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index 877745c3aaf2..7baf48c01e72 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/efi.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -717,6 +718,13 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 
 static int efi_test_open(struct inode *inode, struct file *file)
 {
+	int ret = security_locked_down(LOCKDOWN_EFI_TEST);
+
+	if (ret)
+		return ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
 	/*
 	 * nothing special to do here
 	 * We do accept multiple open files at the same time as we
diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index ebd7977653a8..31f9f0e369b9 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -88,6 +88,7 @@ int __init efi_tpm_eventlog_init(void)
 
 	if (tbl_size < 0) {
 		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
+		ret = -EINVAL;
 		goto out_calc;
 	}
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd3837022307..d87acf62958e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1579,9 +1579,22 @@ char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
 efi_status_t efi_get_memory_map(efi_system_table_t *sys_table_arg,
 				struct efi_boot_memmap *map);
 
+efi_status_t efi_low_alloc_above(efi_system_table_t *sys_table_arg,
+				 unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min);
+
+static inline
 efi_status_t efi_low_alloc(efi_system_table_t *sys_table_arg,
 			   unsigned long size, unsigned long align,
-			   unsigned long *addr);
+			   unsigned long *addr)
+{
+	/*
+	 * Don't allocate at 0x0. It will confuse code that
+	 * checks pointers against NULL. Skip the first 8
+	 * bytes so we start at a nice even number.
+	 */
+	return efi_low_alloc_above(sys_table_arg, size, align, addr, 0x8);
+}
 
 efi_status_t efi_high_alloc(efi_system_table_t *sys_table_arg,
 			    unsigned long size, unsigned long align,
@@ -1592,7 +1605,8 @@ efi_status_t efi_relocate_kernel(efi_system_table_t *sys_table_arg,
 				 unsigned long image_size,
 				 unsigned long alloc_size,
 				 unsigned long preferred_addr,
-				 unsigned long alignment);
+				 unsigned long alignment,
+				 unsigned long min_addr);
 
 efi_status_t handle_cmdline_files(efi_system_table_t *sys_table_arg,
 				  efi_loaded_image_t *image,
diff --git a/include/linux/security.h b/include/linux/security.h
index a8d59d612d27..9df7547afc0c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -105,6 +105,7 @@ enum lockdown_reason {
 	LOCKDOWN_NONE,
 	LOCKDOWN_MODULE_SIGNATURE,
 	LOCKDOWN_DEV_MEM,
+	LOCKDOWN_EFI_TEST,
 	LOCKDOWN_KEXEC,
 	LOCKDOWN_HIBERNATION,
 	LOCKDOWN_PCI_ACCESS,
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 8a10b43daf74..40b790536def 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -20,6 +20,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_NONE] = "none",
 	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
 	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
+	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
 	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
 	[LOCKDOWN_HIBERNATION] = "hibernation",
 	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
