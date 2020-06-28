Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0ED520C98C
	for <lists+linux-efi@lfdr.de>; Sun, 28 Jun 2020 20:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgF1S0H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 28 Jun 2020 14:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgF1S0F (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 28 Jun 2020 14:26:05 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E6C03E979;
        Sun, 28 Jun 2020 11:26:05 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so14413292ejj.5;
        Sun, 28 Jun 2020 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+kQuBfGsCQvfLxLoNQc8KiMzTqhHor8T8SNqkwNBFE4=;
        b=Qdjhv1kdJuRJtZL377wwta3UAq0M5S2ADzs4dLwyai2RASX5lGUIknDw6Ih0fX3hT+
         xs5gS6q2Hez/lrxVqEG7HTxWVOnyS1kXTKJecUVYM5abk/JITX3d8IgFDoXy+ZlBuUrg
         SOeofpNJKCboh1YnQfGs9neFyulx6nuFEkk5N+3Mx4GN7VrDXz1ph95VAqWeEqQR5W3U
         PlgY7q/O3oW/Y0snYbNnyzvxEpaX2gPE1o9Opz9EzfSxECJJ+ZBy7vxRdt3zjCCZ+yMG
         8K0cViPGGfsZA/u7PgYjyy+5rZo8zGeDxTLqUckHEnMvorgeQzzxp8AE01asMCJUhntx
         XKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+kQuBfGsCQvfLxLoNQc8KiMzTqhHor8T8SNqkwNBFE4=;
        b=iTLmp6kohw4N7nyf5pPb5JAaWXxLJNba4vAp7mnfb/wIKQJi06GzDRTq2MfPhrajrt
         xPp/bdx66lkUqnJ58h/11bOG9+fbHq/OzMHc7ZOwGggGuvooLhxjr717JcnqM8K/9kbI
         sgyk+bY+03Ya0/G+17aqI8+X4GDE62ye7D4hxsKTSludbZ/emuEVn8rNL+TGWe4AGkdk
         wnU2KGzHtm04HMW3ftSsR9Ew8+4VJqrNyxyorBzxiHV41QWmkHUEHv6J9AAqFg0ZxPSo
         KWA4WQjJ6wTcrUmo2PJnsyNZCxOR5B8lXojqif18qNNeXyVbr049ptNtS9Ap/l+BL3x3
         h+Vg==
X-Gm-Message-State: AOAM530D7QVmPXmZ3uCcWr2iNwChXL+xrwdu1WRP0TcjJQdE3VIQh/kb
        j9eK5ACfWTYCvqfqLjfLXvE=
X-Google-Smtp-Source: ABdhPJxBB7HjIQ7FM15D35JNPS6kA1L4hjjM6TbAh3T6rz5xufPvaRnU27ti1LscGvx9zMGGQ2FXAg==
X-Received: by 2002:a17:906:4c42:: with SMTP id d2mr10312025ejw.345.1593368763923;
        Sun, 28 Jun 2020 11:26:03 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u17sm22602796eje.74.2020.06.28.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 11:26:03 -0700 (PDT)
Date:   Sun, 28 Jun 2020 20:26:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        linux-efi@vger.kernel.org
Subject: [GIT PULL] EFI fixes
Message-ID: <20200628182601.GA84577@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Linus,

Please pull the latest efi/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi-urgent-2020-06-28

   # HEAD: 2a55280a3675203496d302463b941834228b9875 efi/libstub: arm: Print CPU boot mode and MMU state at boot

- Fix build regression on v4.8 and older
- Robustness fix for TPM log parsing code
- kobject refcount fix for the ESRT parsing code
- Two efivarfs fixes to make it behave more like an ordinary file system
- Style fixup for zero length arrays
- Fix a regression in path separator handling in the initrd loader
- Fix a missing prototype warning
- Add some kerneldoc headers for newly introduced stub routines
- Allow support for SSDT overrides via EFI variables to be disabled
- Report CPU mode and MMU state upon entry for 32-bit ARM
- Use the correct stack pointer alignment when entering from mixed mode

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (3):
      efi/libstub: Fix missing-prototype warning for skip_spaces()
      efi/libstub: arm: Omit arch specific config table matching array on arm64
      efi/libstub: arm: Print CPU boot mode and MMU state at boot

Arvind Sankar (2):
      efi/x86: Fix build with gcc 4
      efi/x86: Setup stack correctly for efi_pe_entry

Fabian Vogt (1):
      efi/tpm: Verify event log header before parsing

Gustavo A. R. Silva (1):
      efi: Replace zero-length array and use struct_size() helper

Heinrich Schuchardt (1):
      efi/libstub: Descriptions for stub helper functions

Peter Jones (1):
      efi: Make it possible to disable efivar_ssdt entirely

Philipp Fent (1):
      efi/libstub: Fix path separator regression

Qiushi Wu (1):
      efi/esrt: Fix reference count leak in esre_create_sysfs_entry.

Tony Luck (2):
      efivarfs: Update inode modification time for successful writes
      efivarfs: Don't return -EINTR when rate-limiting reads


 arch/arm/include/asm/efi.h                     |  7 +++
 arch/x86/boot/compressed/head_64.S             | 11 +++-
 drivers/firmware/efi/Kconfig                   | 11 ++++
 drivers/firmware/efi/arm-init.c                | 40 +++++++++++--
 drivers/firmware/efi/efi.c                     |  5 +-
 drivers/firmware/efi/esrt.c                    |  2 +-
 drivers/firmware/efi/libstub/Makefile          |  3 +-
 drivers/firmware/efi/libstub/arm32-stub.c      | 54 +++++++++++++++++-
 drivers/firmware/efi/libstub/efi-stub-helper.c | 78 ++++++++++++++++++++++----
 drivers/firmware/efi/libstub/efi-stub.c        |  3 +
 drivers/firmware/efi/libstub/efistub.h         | 12 +++-
 drivers/firmware/efi/libstub/file.c            | 16 ++++--
 drivers/firmware/efi/libstub/skip_spaces.c     |  1 +
 fs/efivarfs/file.c                             |  7 +--
 include/linux/efi.h                            |  8 +--
 include/linux/tpm_eventlog.h                   | 14 ++++-
 16 files changed, 235 insertions(+), 37 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 84dc0ba822f5..5dcf3c6011b7 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -87,4 +87,11 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 	return dram_base + SZ_512M;
 }
 
+struct efi_arm_entry_state {
+	u32	cpsr_before_ebs;
+	u32	sctlr_before_ebs;
+	u32	cpsr_after_ebs;
+	u32	sctlr_after_ebs;
+};
+
 #endif /* _ASM_ARM_EFI_H */
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e821a7d7d5c4..97d37f0a34f5 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -213,7 +213,6 @@ SYM_FUNC_START(startup_32)
 	 * We place all of the values on our mini stack so lret can
 	 * used to perform that far jump.
 	 */
-	pushl	$__KERNEL_CS
 	leal	startup_64(%ebp), %eax
 #ifdef CONFIG_EFI_MIXED
 	movl	efi32_boot_args(%ebp), %edi
@@ -224,11 +223,20 @@ SYM_FUNC_START(startup_32)
 	movl	efi32_boot_args+8(%ebp), %edx	// saved bootparams pointer
 	cmpl	$0, %edx
 	jnz	1f
+	/*
+	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
+	 * shadow space on the stack even if all arguments are passed in
+	 * registers. We also need an additional 8 bytes for the space that
+	 * would be occupied by the return address, and this also results in
+	 * the correct stack alignment for entry.
+	 */
+	subl	$40, %esp
 	leal	efi_pe_entry(%ebp), %eax
 	movl	%edi, %ecx			// MS calling convention
 	movl	%esi, %edx
 1:
 #endif
+	pushl	$__KERNEL_CS
 	pushl	%eax
 
 	/* Enter paged protected Mode, activating Long Mode */
@@ -784,6 +792,7 @@ SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
 
 SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
+	.balign 16
 SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 
 /*
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index e6fc022bc87e..3939699e62fe 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -278,3 +278,14 @@ config EFI_EARLYCON
 	depends on SERIAL_EARLYCON && !ARM && !IA64
 	select FONT_SUPPORT
 	select ARCH_USE_MEMREMAP_PROT
+
+config EFI_CUSTOM_SSDT_OVERLAYS
+	bool "Load custom ACPI SSDT overlay from an EFI variable"
+	depends on EFI_VARS && ACPI
+	default ACPI_TABLE_UPGRADE
+	help
+	  Allow loading of an ACPI SSDT overlay from an EFI variable specified
+	  by a kernel command line option.
+
+	  See Documentation/admin-guide/acpi/ssdt-overlays.rst for more
+	  information.
diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index c697e70ca7e7..71c445d20258 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -52,9 +52,11 @@ static phys_addr_t __init efi_to_phys(unsigned long addr)
 }
 
 static __initdata unsigned long screen_info_table = EFI_INVALID_TABLE_ADDR;
+static __initdata unsigned long cpu_state_table = EFI_INVALID_TABLE_ADDR;
 
 static const efi_config_table_type_t arch_tables[] __initconst = {
 	{LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID, &screen_info_table},
+	{LINUX_EFI_ARM_CPU_STATE_TABLE_GUID, &cpu_state_table},
 	{}
 };
 
@@ -62,7 +64,8 @@ static void __init init_screen_info(void)
 {
 	struct screen_info *si;
 
-	if (screen_info_table != EFI_INVALID_TABLE_ADDR) {
+	if (IS_ENABLED(CONFIG_ARM) &&
+	    screen_info_table != EFI_INVALID_TABLE_ADDR) {
 		si = early_memremap_ro(screen_info_table, sizeof(*si));
 		if (!si) {
 			pr_err("Could not map screen_info config table\n");
@@ -116,7 +119,8 @@ static int __init uefi_init(u64 efi_system_table)
 		goto out;
 	}
 	retval = efi_config_parse_tables(config_tables, systab->nr_tables,
-					 arch_tables);
+					 IS_ENABLED(CONFIG_ARM) ? arch_tables
+								: NULL);
 
 	early_memunmap(config_tables, table_size);
 out:
@@ -238,9 +242,37 @@ void __init efi_init(void)
 
 	init_screen_info();
 
+#ifdef CONFIG_ARM
 	/* ARM does not permit early mappings to persist across paging_init() */
-	if (IS_ENABLED(CONFIG_ARM))
-		efi_memmap_unmap();
+	efi_memmap_unmap();
+
+	if (cpu_state_table != EFI_INVALID_TABLE_ADDR) {
+		struct efi_arm_entry_state *state;
+		bool dump_state = true;
+
+		state = early_memremap_ro(cpu_state_table,
+					  sizeof(struct efi_arm_entry_state));
+		if (state == NULL) {
+			pr_warn("Unable to map CPU entry state table.\n");
+			return;
+		}
+
+		if ((state->sctlr_before_ebs & 1) == 0)
+			pr_warn(FW_BUG "EFI stub was entered with MMU and Dcache disabled, please fix your firmware!\n");
+		else if ((state->sctlr_after_ebs & 1) == 0)
+			pr_warn(FW_BUG "ExitBootServices() returned with MMU and Dcache disabled, please fix your firmware!\n");
+		else
+			dump_state = false;
+
+		if (dump_state || efi_enabled(EFI_DBG)) {
+			pr_info("CPSR at EFI stub entry        : 0x%08x\n", state->cpsr_before_ebs);
+			pr_info("SCTLR at EFI stub entry       : 0x%08x\n", state->sctlr_before_ebs);
+			pr_info("CPSR after ExitBootServices() : 0x%08x\n", state->cpsr_after_ebs);
+			pr_info("SCTLR after ExitBootServices(): 0x%08x\n", state->sctlr_after_ebs);
+		}
+		early_memunmap(state, sizeof(struct efi_arm_entry_state));
+	}
+#endif
 }
 
 static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7f1657b6c30d..5114cae4ec97 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -189,7 +189,7 @@ static void generic_ops_unregister(void)
 	efivars_unregister(&generic_efivars);
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
+#ifdef CONFIG_EFI_CUSTOM_SSDT_OVERLAYS
 #define EFIVAR_SSDT_NAME_MAX	16
 static char efivar_ssdt[EFIVAR_SSDT_NAME_MAX] __initdata;
 static int __init efivar_ssdt_setup(char *str)
@@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			rsv = (void *)(p + prsv % PAGE_SIZE);
 
 			/* reserve the entry itself */
-			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
+			memblock_reserve(prsv,
+					 struct_size(rsv, entry, rsv->size));
 
 			for (i = 0; i < atomic_read(&rsv->count); i++) {
 				memblock_reserve(rsv->entry[i].base,
diff --git a/drivers/firmware/efi/esrt.c b/drivers/firmware/efi/esrt.c
index e3d692696583..d5915272141f 100644
--- a/drivers/firmware/efi/esrt.c
+++ b/drivers/firmware/efi/esrt.c
@@ -181,7 +181,7 @@ static int esre_create_sysfs_entry(void *esre, int entry_num)
 		rc = kobject_init_and_add(&entry->kobj, &esre1_ktype, NULL,
 					  "entry%d", entry_num);
 		if (rc) {
-			kfree(entry);
+			kobject_put(&entry->kobj);
 			return rc;
 		}
 	}
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 75daaf20374e..4cce372edaf4 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -6,7 +6,8 @@
 # enabled, even if doing so doesn't break the build.
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
-cflags-$(CONFIG_X86_64)		:= -mcmodel=small
+cflags-$(CONFIG_X86_64)		:= -mcmodel=small \
+				   $(call cc-option,-maccumulate-outgoing-args)
 cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index 40243f524556..d08e5d55838c 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -7,10 +7,49 @@
 
 #include "efistub.h"
 
+static efi_guid_t cpu_state_guid = LINUX_EFI_ARM_CPU_STATE_TABLE_GUID;
+
+struct efi_arm_entry_state *efi_entry_state;
+
+static void get_cpu_state(u32 *cpsr, u32 *sctlr)
+{
+	asm("mrs %0, cpsr" : "=r"(*cpsr));
+	if ((*cpsr & MODE_MASK) == HYP_MODE)
+		asm("mrc p15, 4, %0, c1, c0, 0" : "=r"(*sctlr));
+	else
+		asm("mrc p15, 0, %0, c1, c0, 0" : "=r"(*sctlr));
+}
+
 efi_status_t check_platform_features(void)
 {
+	efi_status_t status;
+	u32 cpsr, sctlr;
 	int block;
 
+	get_cpu_state(&cpsr, &sctlr);
+
+	efi_info("Entering in %s mode with MMU %sabled\n",
+		 ((cpsr & MODE_MASK) == HYP_MODE) ? "HYP" : "SVC",
+		 (sctlr & 1) ? "en" : "dis");
+
+	status = efi_bs_call(allocate_pool, EFI_LOADER_DATA,
+			     sizeof(*efi_entry_state),
+			     (void **)&efi_entry_state);
+	if (status != EFI_SUCCESS) {
+		efi_err("allocate_pool() failed\n");
+		return status;
+	}
+
+	efi_entry_state->cpsr_before_ebs = cpsr;
+	efi_entry_state->sctlr_before_ebs = sctlr;
+
+	status = efi_bs_call(install_configuration_table, &cpu_state_guid,
+			     efi_entry_state);
+	if (status != EFI_SUCCESS) {
+		efi_err("install_configuration_table() failed\n");
+		goto free_state;
+	}
+
 	/* non-LPAE kernels can run anywhere */
 	if (!IS_ENABLED(CONFIG_ARM_LPAE))
 		return EFI_SUCCESS;
@@ -19,9 +58,22 @@ efi_status_t check_platform_features(void)
 	block = cpuid_feature_extract(CPUID_EXT_MMFR0, 0);
 	if (block < 5) {
 		efi_err("This LPAE kernel is not supported by your CPU\n");
-		return EFI_UNSUPPORTED;
+		status = EFI_UNSUPPORTED;
+		goto drop_table;
 	}
 	return EFI_SUCCESS;
+
+drop_table:
+	efi_bs_call(install_configuration_table, &cpu_state_guid, NULL);
+free_state:
+	efi_bs_call(free_pool, efi_entry_state);
+	return status;
+}
+
+void efi_handle_post_ebs_state(void)
+{
+	get_cpu_state(&efi_entry_state->cpsr_after_ebs,
+		      &efi_entry_state->sctlr_after_ebs);
 }
 
 static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 89f075275300..d40fd68c6bb2 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -32,6 +32,10 @@ bool __pure __efi_soft_reserve_enabled(void)
 	return !efi_nosoftreserve;
 }
 
+/**
+ * efi_char16_puts() - Write a UCS-2 encoded string to the console
+ * @str:	UCS-2 encoded string
+ */
 void efi_char16_puts(efi_char16_t *str)
 {
 	efi_call_proto(efi_table_attr(efi_system_table, con_out),
@@ -83,6 +87,10 @@ u32 utf8_to_utf32(const u8 **s8)
 	return c32;
 }
 
+/**
+ * efi_puts() - Write a UTF-8 encoded string to the console
+ * @str:	UTF-8 encoded string
+ */
 void efi_puts(const char *str)
 {
 	efi_char16_t buf[128];
@@ -113,6 +121,16 @@ void efi_puts(const char *str)
 	}
 }
 
+/**
+ * efi_printk() - Print a kernel message
+ * @fmt:	format string
+ *
+ * The first letter of the format string is used to determine the logging level
+ * of the message. If the level is less then the current EFI logging level, the
+ * message is suppressed. The message will be truncated to 255 bytes.
+ *
+ * Return:	number of printed characters
+ */
 int efi_printk(const char *fmt, ...)
 {
 	char printf_buf[256];
@@ -154,13 +172,18 @@ int efi_printk(const char *fmt, ...)
 	return printed;
 }
 
-/*
- * Parse the ASCII string 'cmdline' for EFI options, denoted by the efi=
+/**
+ * efi_parse_options() - Parse EFI command line options
+ * @cmdline:	kernel command line
+ *
+ * Parse the ASCII string @cmdline for EFI options, denoted by the efi=
  * option, e.g. efi=nochunk.
  *
  * It should be noted that efi= is parsed in two very different
  * environments, first in the early boot environment of the EFI boot
  * stub, and subsequently during the kernel boot.
+ *
+ * Return:	status code
  */
 efi_status_t efi_parse_options(char const *cmdline)
 {
@@ -286,13 +309,21 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 	return (char *)cmdline_addr;
 }
 
-/*
+/**
+ * efi_exit_boot_services() - Exit boot services
+ * @handle:	handle of the exiting image
+ * @map:	pointer to receive the memory map
+ * @priv:	argument to be passed to @priv_func
+ * @priv_func:	function to process the memory map before exiting boot services
+ *
  * Handle calling ExitBootServices according to the requirements set out by the
  * spec.  Obtains the current memory map, and returns that info after calling
  * ExitBootServices.  The client must specify a function to perform any
  * processing of the memory map data prior to ExitBootServices.  A client
  * specific structure may be passed to the function via priv.  The client
  * function may be called multiple times.
+ *
+ * Return:	status code
  */
 efi_status_t efi_exit_boot_services(void *handle,
 				    struct efi_boot_memmap *map,
@@ -361,6 +392,11 @@ efi_status_t efi_exit_boot_services(void *handle,
 	return status;
 }
 
+/**
+ * get_efi_config_table() - retrieve UEFI configuration table
+ * @guid:	GUID of the configuration table to be retrieved
+ * Return:	pointer to the configuration table or NULL
+ */
 void *get_efi_config_table(efi_guid_t guid)
 {
 	unsigned long tables = efi_table_attr(efi_system_table, tables);
@@ -408,17 +444,18 @@ static const struct {
 };
 
 /**
- * efi_load_initrd_dev_path - load the initrd from the Linux initrd device path
+ * efi_load_initrd_dev_path() - load the initrd from the Linux initrd device path
  * @load_addr:	pointer to store the address where the initrd was loaded
  * @load_size:	pointer to store the size of the loaded initrd
  * @max:	upper limit for the initrd memory allocation
- * @return:	%EFI_SUCCESS if the initrd was loaded successfully, in which
- *		case @load_addr and @load_size are assigned accordingly
- *		%EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd
- *		device path
- *		%EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
- *		%EFI_OUT_OF_RESOURCES if memory allocation failed
- *		%EFI_LOAD_ERROR in all other cases
+ *
+ * Return:
+ * * %EFI_SUCCESS if the initrd was loaded successfully, in which
+ *   case @load_addr and @load_size are assigned accordingly
+ * * %EFI_NOT_FOUND if no LoadFile2 protocol exists on the initrd device path
+ * * %EFI_INVALID_PARAMETER if load_addr == NULL or load_size == NULL
+ * * %EFI_OUT_OF_RESOURCES if memory allocation failed
+ * * %EFI_LOAD_ERROR in all other cases
  */
 static
 efi_status_t efi_load_initrd_dev_path(unsigned long *load_addr,
@@ -481,6 +518,16 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
 				    load_addr, load_size);
 }
 
+/**
+ * efi_load_initrd() - Load initial RAM disk
+ * @image:	EFI loaded image protocol
+ * @load_addr:	pointer to loaded initrd
+ * @load_size:	size of loaded initrd
+ * @soft_limit:	preferred size of allocated memory for loading the initrd
+ * @hard_limit:	minimum size of allocated memory
+ *
+ * Return:	status code
+ */
 efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size,
@@ -505,6 +552,15 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	return status;
 }
 
+/**
+ * efi_wait_for_key() - Wait for key stroke
+ * @usec:	number of microseconds to wait for key stroke
+ * @key:	key entered
+ *
+ * Wait for up to @usec microseconds for a key stroke.
+ *
+ * Return:	status code, EFI_SUCCESS if key received
+ */
 efi_status_t efi_wait_for_key(unsigned long usec, efi_input_key_t *key)
 {
 	efi_event_t events[2], timer;
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index e97370bdfdb0..3318ec3f8e5b 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -329,6 +329,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (status != EFI_SUCCESS)
 		goto fail_free_initrd;
 
+	if (IS_ENABLED(CONFIG_ARM))
+		efi_handle_post_ebs_state();
+
 	efi_enter_kernel(image_addr, fdt_addr, fdt_totalsize((void *)fdt_addr));
 	/* not reached */
 
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index bcd8c0a785f0..2c9d42264c29 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -157,8 +157,14 @@ typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
 #define EFI_EVT_NOTIFY_WAIT	0x00000100U
 #define EFI_EVT_NOTIFY_SIGNAL	0x00000200U
 
-/*
- * boottime->wait_for_event takes an array of events as input.
+/**
+ * efi_set_event_at() - add event to events array
+ *
+ * @events:	array of UEFI events
+ * @ids:	index where to put the event in the array
+ * @event:	event to add to the aray
+ *
+ * boottime->wait_for_event() takes an array of events as input.
  * Provide a helper to set it up correctly for mixed mode.
  */
 static inline
@@ -771,4 +777,6 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long soft_limit,
 			     unsigned long hard_limit);
 
+void efi_handle_post_ebs_state(void);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 2005e33b33d5..630caa6b1f4c 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -102,12 +102,20 @@ static int find_file_option(const efi_char16_t *cmdline, int cmdline_len,
 	if (!found)
 		return 0;
 
+	/* Skip any leading slashes */
+	while (cmdline[i] == L'/' || cmdline[i] == L'\\')
+		i++;
+
 	while (--result_len > 0 && i < cmdline_len) {
-		if (cmdline[i] == L'\0' ||
-		    cmdline[i] == L'\n' ||
-		    cmdline[i] == L' ')
+		efi_char16_t c = cmdline[i++];
+
+		if (c == L'\0' || c == L'\n' || c == L' ')
 			break;
-		*result++ = cmdline[i++];
+		else if (c == L'/')
+			/* Replace UNIX dir separators with EFI standard ones */
+			*result++ = L'\\';
+		else
+			*result++ = c;
 	}
 	*result = L'\0';
 	return i;
diff --git a/drivers/firmware/efi/libstub/skip_spaces.c b/drivers/firmware/efi/libstub/skip_spaces.c
index a700b3c7f7d0..159fb4e456c6 100644
--- a/drivers/firmware/efi/libstub/skip_spaces.c
+++ b/drivers/firmware/efi/libstub/skip_spaces.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/ctype.h>
+#include <linux/string.h>
 #include <linux/types.h>
 
 char *skip_spaces(const char *str)
diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index e9e27a271af0..feaa5e182b7b 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -51,6 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
 	} else {
 		inode_lock(inode);
 		i_size_write(inode, datasize + sizeof(attributes));
+		inode->i_mtime = current_time(inode);
 		inode_unlock(inode);
 	}
 
@@ -72,10 +73,8 @@ static ssize_t efivarfs_file_read(struct file *file, char __user *userbuf,
 	ssize_t size = 0;
 	int err;
 
-	while (!__ratelimit(&file->f_cred->user->ratelimit)) {
-		if (!msleep_interruptible(50))
-			return -EINTR;
-	}
+	while (!__ratelimit(&file->f_cred->user->ratelimit))
+		msleep(50);
 
 	err = efivar_entry_size(var, &datasize);
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2c6495f72f79..bb35f3305e55 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -350,6 +350,7 @@ void efi_native_runtime_setup(void);
  * associated with ConOut
  */
 #define LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID	EFI_GUID(0xe03fc20a, 0x85dc, 0x406e,  0xb9, 0x0e, 0x4a, 0xb5, 0x02, 0x37, 0x1d, 0x95)
+#define LINUX_EFI_ARM_CPU_STATE_TABLE_GUID	EFI_GUID(0xef79e4aa, 0x3c3d, 0x4989,  0xb9, 0x02, 0x07, 0xa9, 0x43, 0xe5, 0x50, 0xd2)
 #define LINUX_EFI_LOADER_ENTRY_GUID		EFI_GUID(0x4a67b082, 0x0a4c, 0x41cf,  0xb6, 0xc7, 0x44, 0x0b, 0x29, 0xbb, 0x8c, 0x4f)
 #define LINUX_EFI_RANDOM_SEED_TABLE_GUID	EFI_GUID(0x1ce1e5bc, 0x7ceb, 0x42f2,  0x81, 0xe5, 0x8a, 0xad, 0xf1, 0x80, 0xf5, 0x7b)
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
@@ -1236,14 +1237,11 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t	base;
 		phys_addr_t	size;
-	} entry[0];
+	} entry[];
 };
 
-#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
-	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
-
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
-	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 4f8c90c93c29..64356b199e94 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -81,6 +81,8 @@ struct tcg_efi_specid_event_algs {
 	u16 digest_size;
 } __packed;
 
+#define TCG_SPECID_SIG "Spec ID Event03"
+
 struct tcg_efi_specid_event_head {
 	u8 signature[16];
 	u32 platform_class;
@@ -171,6 +173,7 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	int i;
 	int j;
 	u32 count, event_type;
+	const u8 zero_digest[sizeof(event_header->digest)] = {0};
 
 	marker = event;
 	marker_start = marker;
@@ -198,10 +201,19 @@ static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
 	count = READ_ONCE(event->count);
 	event_type = READ_ONCE(event->event_type);
 
+	/* Verify that it's the log header */
+	if (event_header->pcr_idx != 0 ||
+	    event_header->event_type != NO_ACTION ||
+	    memcmp(event_header->digest, zero_digest, sizeof(zero_digest))) {
+		size = 0;
+		goto out;
+	}
+
 	efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
 
 	/* Check if event is malformed. */
-	if (count > efispecid->num_algs) {
+	if (memcmp(efispecid->signature, TCG_SPECID_SIG,
+		   sizeof(TCG_SPECID_SIG)) || count > efispecid->num_algs) {
 		size = 0;
 		goto out;
 	}
