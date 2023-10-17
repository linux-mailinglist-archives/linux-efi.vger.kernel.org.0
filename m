Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE307CC4B7
	for <lists+linux-efi@lfdr.de>; Tue, 17 Oct 2023 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJQNZ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Oct 2023 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjJQNZ1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Oct 2023 09:25:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D5F2
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:25:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d815354ea7fso7621377276.1
        for <linux-efi@vger.kernel.org>; Tue, 17 Oct 2023 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697549122; x=1698153922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DB5ajJH0OC+PnkPODAPDWFCoxSXTJevt39kmkorNHEk=;
        b=vH6VPPCkvvHVk3IKALTg3U1H6OvQbsMsTJIok1vALKZhogl5zwIruvMbObAJJ4rKsQ
         ab9EhOsnIWhlUurRFOk3WPDmajJls30KvNr2V2q9SssrWs4JKfu9JElkv8+2LNjeoMli
         TxmS8Hv4jgBJ5I61FjMtmrSFxbZJf/shwZ3EY1UoIrE4Heanh6nUahki4BqcL9hv/8Cr
         qQwZMADlSeopDbcHCp8h8LpQQt3hg38TpQGIxORpX9RNy/Ti+HkA/iY3S5AlzuPOQgjA
         K2+KEqExB4G3tLvAiumsjchK8LUpbhChd0hratSc62FVuw8qoAJKy6zCEs0fFzKQDvTy
         oH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697549122; x=1698153922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DB5ajJH0OC+PnkPODAPDWFCoxSXTJevt39kmkorNHEk=;
        b=N7GhZ+il87paJx90ilbY6YQhiGwKinjfshS+DxA9kj0bC5nbvsq5nt320hxOPn84jZ
         ib77WJdyeM0dlCCefsYhrKGpZdztzQw4I5vugcmNDSY6CiiqJKCdUUhRTFOpras1V4iV
         bWjJzocuuWbRcMqXez7vqrAUA5LFi4ckdkW+3bOIdie57fEHSzj5210LFmJ9xN/w7lR7
         WcdxowASqrMy/UQkyz9EhtSDdmaD1NEk27CYuAGaYo7X2gE5mFtQ163uuooVNA0JsfTt
         g2rgVovVwKLNoPE6IHr7U5VzdW3WHmRw3hCEqyYDZYm/B3iE1whC7+APXEx4SrbdBcCW
         2H/A==
X-Gm-Message-State: AOJu0Yzl63wBi9z+NS77hbRsmGyUX0+TqB9msClJkULPRHvH6TlcIwSJ
        dcRf4KYLw9oR7HZwpC3DMHunbVQWbIqJaaPqb4erKq3Xnc9/EJr9NO3cU+J05BsHIPmFhdqawPv
        h0D6876zVhaZXy7lJGHyMPioLOaMwD31+uOHRxNSWGDyQ1jXQwQunR0Ue+yxi
X-Google-Smtp-Source: AGHT+IH6U4xUIpODOQih9nXnrlogkZQu+Nu5tFEDE848O6XL3ge6xQ4aWABFQ4+hsnt5mUcf2POG4/Gm
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1788:b0:d9a:634d:4400 with SMTP id
 ca8-20020a056902178800b00d9a634d4400mr39898ybb.5.1697549122674; Tue, 17 Oct
 2023 06:25:22 -0700 (PDT)
Date:   Tue, 17 Oct 2023 15:25:12 +0200
In-Reply-To: <20231017132510.3845531-4-ardb@google.com>
Mime-Version: 1.0
References: <20231017132510.3845531-4-ardb@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=15623; i=ardb@kernel.org;
 h=from:subject; bh=Ei99ZTbJuujaSAdNlwKM/4XIimIDTHfiP3jvZeHRDMQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIVWv26J6SdK9S1uLEv8XBz67zrhjV73wXR/XW00l0zp0j
 wpef3iqo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExEp4fhf0oKS8HhR5apkUcE
 HphtfJemzrSmblPerbI6+dLdC9P5ExgZjmlLnHCW6zC69Opc8LwiuwY7Nbtak0DefQ6Pr23O2ji DCwA=
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017132510.3845531-5-ardb@google.com>
Subject: [PATCH v2 1/2] x86/boot: Rename conflicting boot_params pointer to boot_params_p
From:   Ard Biesheuvel <ardb@google.com>
To:     linux-efi@vger.kernel.org, mingo@kernel.org
Cc:     x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The x86 decompressor is built and linked as a separate executable, but
it shares components with the kernel proper, which are either #include'd
as C files, or linked into the decompresor as a static library (e.g, the
EFI stub)

Both the kernel itself and the decompressor define a global symbol
'boot_params' to refer to the boot_params struct, but in the former
case, it refers to the struct directly, whereas in the decompressor, it
refers to a global pointer variable referring to the struct boot_params
passed by the bootloader or constructed from scratch.

This ambiguity is unfortunate, and makes it impossible to assign this
decompressor variable from the x86 EFI stub, given that declaring it as
extern results in a clash. So rename the decompressor version (whose
scope is limited) to boot_params_p.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/acpi.c         | 14 +++++------
 arch/x86/boot/compressed/cmdline.c      |  4 +--
 arch/x86/boot/compressed/ident_map_64.c |  7 +++---
 arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
 arch/x86/boot/compressed/mem.c          |  6 ++---
 arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
 arch/x86/boot/compressed/misc.h         |  1 -
 arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/boot.h             |  2 ++
 10 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..55a2b8e90a59 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -30,13 +30,13 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
 	 * ACPI_TABLE_GUID because it has more features.
 	 */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_p, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_20_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
 
 	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_p, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
@@ -56,15 +56,15 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_p);
 	if (et == EFI_TYPE_NONE)
 		return 0;
 
-	systab_pa = efi_get_system_table(boot_params);
+	systab_pa = efi_get_system_table(boot_params_p);
 	if (!systab_pa)
 		error("EFI support advertised, but unable to locate system table.");
 
-	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len);
+	ret = efi_get_conf_table(boot_params_p, &cfg_tbl_pa, &cfg_tbl_len);
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
@@ -156,7 +156,7 @@ acpi_physical_address get_rsdp_addr(void)
 {
 	acpi_physical_address pa;
 
-	pa = boot_params->acpi_rsdp_addr;
+	pa = boot_params_p->acpi_rsdp_addr;
 
 	if (!pa)
 		pa = efi_get_rsdp_addr();
@@ -210,7 +210,7 @@ static unsigned long get_acpi_srat_table(void)
 	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
 	if (!rsdp)
 		rsdp = (struct acpi_table_rsdp *)(long)
-			boot_params->acpi_rsdp_addr;
+			boot_params_p->acpi_rsdp_addr;
 
 	if (!rsdp)
 		return 0;
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..ccb53c4094df 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -14,9 +14,9 @@ static inline char rdfs8(addr_t addr)
 #include "../cmdline.c"
 unsigned long get_cmd_line_ptr(void)
 {
-	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+	unsigned long cmd_line_ptr = boot_params_p->hdr.cmd_line_ptr;
 
-	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+	cmd_line_ptr |= (u64)boot_params_p->ext_cmd_line_ptr << 32;
 
 	return cmd_line_ptr;
 }
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index bcc956c17872..194e32e5048d 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -151,8 +151,9 @@ void initialize_identity_maps(void *rmode)
 	 * or does not touch all the pages covering them.
 	 */
 	kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
-	boot_params = rmode;
-	kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	boot_params_p = rmode;
+	kernel_add_identity_map((unsigned long)boot_params_p,
+				(unsigned long)(boot_params_p + 1));
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
@@ -160,7 +161,7 @@ void initialize_identity_maps(void *rmode)
 	 * Also map the setup_data entries passed via boot_params in case they
 	 * need to be accessed by uncompressed kernel via the identity mapping.
 	 */
-	sd = (struct setup_data *)boot_params->hdr.setup_data;
+	sd = (struct setup_data *)boot_params_p->hdr.setup_data;
 	while (sd) {
 		unsigned long sd_addr = (unsigned long)sd;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9193acf0e9cd..99c5f715b0d7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -63,7 +63,7 @@ static unsigned long get_boot_seed(void)
 	unsigned long hash = 0;
 
 	hash = rotate_xor(hash, build_str, sizeof(build_str));
-	hash = rotate_xor(hash, boot_params, sizeof(*boot_params));
+	hash = rotate_xor(hash, boot_params_p, sizeof(*boot_params_p));
 
 	return hash;
 }
@@ -383,7 +383,7 @@ static void handle_mem_options(void)
 static void mem_avoid_init(unsigned long input, unsigned long input_size,
 			   unsigned long output)
 {
-	unsigned long init_size = boot_params->hdr.init_size;
+	unsigned long init_size = boot_params_p->hdr.init_size;
 	u64 initrd_start, initrd_size;
 	unsigned long cmd_line, cmd_line_size;
 
@@ -395,10 +395,10 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	mem_avoid[MEM_AVOID_ZO_RANGE].size = (output + init_size) - input;
 
 	/* Avoid initrd. */
-	initrd_start  = (u64)boot_params->ext_ramdisk_image << 32;
-	initrd_start |= boot_params->hdr.ramdisk_image;
-	initrd_size  = (u64)boot_params->ext_ramdisk_size << 32;
-	initrd_size |= boot_params->hdr.ramdisk_size;
+	initrd_start  = (u64)boot_params_p->ext_ramdisk_image << 32;
+	initrd_start |= boot_params_p->hdr.ramdisk_image;
+	initrd_size  = (u64)boot_params_p->ext_ramdisk_size << 32;
+	initrd_size |= boot_params_p->hdr.ramdisk_size;
 	mem_avoid[MEM_AVOID_INITRD].start = initrd_start;
 	mem_avoid[MEM_AVOID_INITRD].size = initrd_size;
 	/* No need to set mapping for initrd, it will be handled in VO. */
@@ -413,8 +413,8 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	}
 
 	/* Avoid boot parameters. */
-	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
-	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params);
+	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params_p;
+	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params_p);
 
 	/* We don't need to set a mapping for setup_data. */
 
@@ -447,7 +447,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	}
 
 	/* Avoid all entries in the setup_data linked list. */
-	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
+	ptr = (struct setup_data *)(unsigned long)boot_params_p->hdr.setup_data;
 	while (ptr) {
 		struct mem_vector avoid;
 
@@ -706,7 +706,7 @@ static inline bool memory_type_is_free(efi_memory_desc_t *md)
 static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
 {
-	struct efi_info *e = &boot_params->efi_info;
+	struct efi_info *e = &boot_params_p->efi_info;
 	bool efi_mirror_found = false;
 	struct mem_vector region;
 	efi_memory_desc_t *md;
@@ -777,8 +777,8 @@ static void process_e820_entries(unsigned long minimum,
 	struct boot_e820_entry *entry;
 
 	/* Verify potential e820 positions, appending to slots list. */
-	for (i = 0; i < boot_params->e820_entries; i++) {
-		entry = &boot_params->e820_table[i];
+	for (i = 0; i < boot_params_p->e820_entries; i++) {
+		entry = &boot_params_p->e820_table[i];
 		/* Skip non-RAM entries. */
 		if (entry->type != E820_TYPE_RAM)
 			continue;
@@ -852,7 +852,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-	boot_params->hdr.loadflags |= KASLR_FLAG;
+	boot_params_p->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		mem_limit = KERNEL_IMAGE_SIZE;
diff --git a/arch/x86/boot/compressed/mem.c b/arch/x86/boot/compressed/mem.c
index 3c1609245f2a..7cbce163beb1 100644
--- a/arch/x86/boot/compressed/mem.c
+++ b/arch/x86/boot/compressed/mem.c
@@ -54,17 +54,17 @@ bool init_unaccepted_memory(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_p);
 	if (et == EFI_TYPE_NONE)
 		return false;
 
-	ret = efi_get_conf_table(boot_params, &cfg_table_pa, &cfg_table_len);
+	ret = efi_get_conf_table(boot_params_p, &cfg_table_pa, &cfg_table_len);
 	if (ret) {
 		warn("EFI config table not found.");
 		return false;
 	}
 
-	table = (void *)efi_find_vendor_table(boot_params, cfg_table_pa,
+	table = (void *)efi_find_vendor_table(boot_params_p, cfg_table_pa,
 					      cfg_table_len, guid);
 	if (!table)
 		return false;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index f711f2a85862..ba130072fa19 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_p;
 
 struct port_io_ops pio_ops;
 
@@ -132,8 +132,8 @@ void __putstr(const char *s)
 	if (lines == 0 || cols == 0)
 		return;
 
-	x = boot_params->screen_info.orig_x;
-	y = boot_params->screen_info.orig_y;
+	x = boot_params_p->screen_info.orig_x;
+	y = boot_params_p->screen_info.orig_y;
 
 	while ((c = *s++) != '\0') {
 		if (c == '\n') {
@@ -154,8 +154,8 @@ void __putstr(const char *s)
 		}
 	}
 
-	boot_params->screen_info.orig_x = x;
-	boot_params->screen_info.orig_y = y;
+	boot_params_p->screen_info.orig_x = x;
+	boot_params_p->screen_info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb(14, vidport);
@@ -382,14 +382,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	size_t entry_offset;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
-	boot_params = rmode;
+	boot_params_p = rmode;
 
 	/* Clear flags intended for solely in-kernel use. */
-	boot_params->hdr.loadflags &= ~KASLR_FLAG;
+	boot_params_p->hdr.loadflags &= ~KASLR_FLAG;
 
-	sanitize_boot_params(boot_params);
+	sanitize_boot_params(boot_params_p);
 
-	if (boot_params->screen_info.orig_video_mode == 7) {
+	if (boot_params_p->screen_info.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -397,8 +397,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params->screen_info.orig_video_lines;
-	cols = boot_params->screen_info.orig_video_cols;
+	lines = boot_params_p->screen_info.orig_video_lines;
+	cols = boot_params_p->screen_info.orig_video_cols;
 
 	init_default_io_ops();
 
@@ -417,7 +417,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 * so that early debugging output from the RSDP parsing code can be
 	 * collected.
 	 */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	boot_params_p->acpi_rsdp_addr = get_rsdp_addr();
 
 	debug_putstr("early console in extract_kernel\n");
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index cc70d3fb9049..c0d502bd8716 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -61,7 +61,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 7939eb6e6ce9..685c67ad54f2 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -28,7 +28,6 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
  */
 unsigned long *trampoline_32bit __section(".data");
 
-extern struct boot_params *boot_params;
 int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
@@ -49,7 +48,7 @@ static unsigned long find_trampoline_placement(void)
 	 *
 	 * Only look for values in the legacy ROM for non-EFI system.
 	 */
-	signature = (char *)&boot_params->efi_info.efi_loader_signature;
+	signature = (char *)&boot_params_p->efi_info.efi_loader_signature;
 	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
 	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
 		ebda_start = *(unsigned short *)0x40e << 4;
@@ -65,10 +64,10 @@ static unsigned long find_trampoline_placement(void)
 	bios_start = round_down(bios_start, PAGE_SIZE);
 
 	/* Find the first usable memory region under bios_start. */
-	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+	for (i = boot_params_p->e820_entries - 1; i >= 0; i--) {
 		unsigned long new = bios_start;
 
-		entry = &boot_params->e820_table[i];
+		entry = &boot_params_p->e820_table[i];
 
 		/* Skip all entries above bios_start. */
 		if (bios_start <= entry->addr)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_p = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index dc8c876fbd8f..9660b8041c4a 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -605,7 +605,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_p->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index 4ae14339cb8c..23f41be50379 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -68,6 +68,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_p;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
-- 
2.42.0.655.g421f12c284-goog

