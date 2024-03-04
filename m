Return-Path: <linux-efi+bounces-708-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1015D87004F
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 12:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BB4B24573
	for <lists+linux-efi@lfdr.de>; Mon,  4 Mar 2024 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F8383AF;
	Mon,  4 Mar 2024 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Faz4RMQ6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF2B39AC2
	for <linux-efi@vger.kernel.org>; Mon,  4 Mar 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551259; cv=none; b=hFhPHdh99tc7P+DEesLdYkxMxILbm6xYrSUOQLxgyxpfSdIgis4XhFWmGwXvCBdg6MUs+OZiD8CkegQe6lXQoPKBECrW2TnnypzUtulv7XAhD8/Hl22HPH2MQ4XEAofXBtp3K9MkWzjxDqMjYfBmKAp9g9RCxJjpC1zMYYTJgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551259; c=relaxed/simple;
	bh=Jz67+JEiKEReNjWXBgcarIUERet82pRma4C4oDy0ujc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pnNUtjwD/AaSVYoxMu79aBBQhpVWj2VbIESpKwTKDrbVqcwcXSbWDkdWbOe/ZWClZTXmAM/OikXlIsllhjkUFX1X6CpGo7h4MfmueYbSmCNnt9MrJJR6a7KB3Da5BFUz7aq68PWnOFc7npxNMsXt/i67DemJvfLbizNzO7q5zEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Faz4RMQ6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608ab197437so67124417b3.1
        for <linux-efi@vger.kernel.org>; Mon, 04 Mar 2024 03:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709551255; x=1710156055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mbyma8/KP5wEZaCDaEOQxoiD8I4arAwr0LaDUz/Co4=;
        b=Faz4RMQ6NcvYbkgSyYevuQHBnUK8ImDaKLsvt9Pgo7rPvsFPo1YBVMg2Pk1LkoC6KU
         Q5kn6JDgEtamNzx5xEqtJsmois0lAiC10c+wbYh5rdE6dWR0aEzY9gE/Mnue9U/IB/0/
         ZO0UkZCX2wLtkDeoiVhYbzWotiwlMIsZpIK7+1r6KBQUS/n/dif53l3yKCEDxeMd7SAh
         6paw1J1XB5FH3sUIS7sI/0SKmPXWsi8P7arwNsk0pUygUixD98NJnSOi+PAOegXhUQA8
         8CGLgRzzSZluYPJwgjj8ky++BscFeAhdT5MJx4SZDeSAKqAnJjwFwg6FAAPVtfoZiYfG
         TbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709551255; x=1710156055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mbyma8/KP5wEZaCDaEOQxoiD8I4arAwr0LaDUz/Co4=;
        b=B3GhudrQ1HujyAvUVuvRJAHDO1pfm+l2d+S1jJ16XXRJ2sd38XcoI/ag2HhZA487w3
         0Q494r1T/gE3jwtphuVET8DFV18d+/MuKisSdabtXEgd4fjRpZaUPSW/0w2eXkdlCKX8
         D1DTUzRxwwB4g/ZYySzJCgVG24sQhF2ZCsPmX4sIQ7SF3Zu8XMYYHYJ+p+rOWrTNfI4E
         F7vtEJiDooOXrFm0uP6rlDBKgPqqfxQ9n1B7EWnhjyST8VtZOWrxUMU7w6HGAZkXqEYz
         7ZjmXT4PZZE8wvxy/aTWMHw0qltWZAe8T4hdSS19BvpEBOTwV8nVi9qSvpBfd33Oc6BG
         mPDw==
X-Gm-Message-State: AOJu0Yyu37PjoY6VYxnXoSAGwfPMqx9x4ujicnfJdMQJHAwiSheO3ETS
	1ovMzcBq6da71ukGF3nm3BZsQ6g/LCOAljt4QCLSZekVhFb7SoL4EqMNbtQOdIj/NGZo6A==
X-Google-Smtp-Source: AGHT+IH0LRo3dJbNlVcHL2OZ5In7Mp0oVIvo0CNJULXlsylwV7KPJYyYmtbPzWJXYRLyrukKklyVogpA
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:690c:e18:b0:609:247a:bdc5 with SMTP id
 cp24-20020a05690c0e1800b00609247abdc5mr2551289ywb.4.1709551255803; Mon, 04
 Mar 2024 03:20:55 -0800 (PST)
Date: Mon,  4 Mar 2024 12:19:54 +0100
In-Reply-To: <20240304111937.2556102-20-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304111937.2556102-20-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=15046; i=ardb@kernel.org;
 h=from:subject; bh=60gR4FFIIa0N29jT7BBoE3saS/ywlXcpD4PmOLhcPHo=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXpuuj+m99dLmlFcEzo2ek1+6LDY96Q5PJVc3YtyORW9
 d0sUpvRUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACaSupORYfuVbSXRN2Y4f2d3
 dD1yLoG11eNJ9QLN+/FeO1uL2SqFchkZWieeOBIbo3t7tmuby7HuW573BTZwGZxjXhU+uftJ8Cl ZVgA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240304111937.2556102-36-ardb+git@google.com>
Subject: [PATCH stable-v6.1 16/18] x86/boot: Rename conflicting 'boot_params'
 pointer to 'boot_params_ptr'
From: Ard Biesheuvel <ardb+git@google.com>
To: stable@vger.kernel.org
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

[ Commit b9e909f78e7e4b826f318cfe7bedf3ce229920e6 upstream ]

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
scope is limited) to boot_params_ptr.

[ mingo: Renamed 'boot_params_p' to 'boot_params_ptr' for clarity ]

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/acpi.c         | 14 +++++------
 arch/x86/boot/compressed/cmdline.c      |  4 +--
 arch/x86/boot/compressed/ident_map_64.c |  7 +++---
 arch/x86/boot/compressed/kaslr.c        | 26 ++++++++++----------
 arch/x86/boot/compressed/misc.c         | 24 +++++++++---------
 arch/x86/boot/compressed/misc.h         |  1 -
 arch/x86/boot/compressed/pgtable_64.c   |  9 +++----
 arch/x86/boot/compressed/sev.c          |  2 +-
 arch/x86/include/asm/boot.h             |  2 ++
 9 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 9caf89063e77..55c98fdd67d2 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -30,13 +30,13 @@ __efi_get_rsdp_addr(unsigned long cfg_tbl_pa, unsigned int cfg_tbl_len)
 	 * Search EFI system tables for RSDP. Preferred is ACPI_20_TABLE_GUID to
 	 * ACPI_TABLE_GUID because it has more features.
 	 */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_ptr, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_20_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
 
 	/* No ACPI_20_TABLE_GUID found, fallback to ACPI_TABLE_GUID. */
-	rsdp_addr = efi_find_vendor_table(boot_params, cfg_tbl_pa, cfg_tbl_len,
+	rsdp_addr = efi_find_vendor_table(boot_params_ptr, cfg_tbl_pa, cfg_tbl_len,
 					  ACPI_TABLE_GUID);
 	if (rsdp_addr)
 		return (acpi_physical_address)rsdp_addr;
@@ -56,15 +56,15 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 	enum efi_type et;
 	int ret;
 
-	et = efi_get_type(boot_params);
+	et = efi_get_type(boot_params_ptr);
 	if (et == EFI_TYPE_NONE)
 		return 0;
 
-	systab_pa = efi_get_system_table(boot_params);
+	systab_pa = efi_get_system_table(boot_params_ptr);
 	if (!systab_pa)
 		error("EFI support advertised, but unable to locate system table.");
 
-	ret = efi_get_conf_table(boot_params, &cfg_tbl_pa, &cfg_tbl_len);
+	ret = efi_get_conf_table(boot_params_ptr, &cfg_tbl_pa, &cfg_tbl_len);
 	if (ret || !cfg_tbl_pa)
 		error("EFI config table not found.");
 
@@ -156,7 +156,7 @@ acpi_physical_address get_rsdp_addr(void)
 {
 	acpi_physical_address pa;
 
-	pa = boot_params->acpi_rsdp_addr;
+	pa = boot_params_ptr->acpi_rsdp_addr;
 
 	if (!pa)
 		pa = efi_get_rsdp_addr();
@@ -210,7 +210,7 @@ static unsigned long get_acpi_srat_table(void)
 	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
 	if (!rsdp)
 		rsdp = (struct acpi_table_rsdp *)(long)
-			boot_params->acpi_rsdp_addr;
+			boot_params_ptr->acpi_rsdp_addr;
 
 	if (!rsdp)
 		return 0;
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..c1bb180973ea 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -14,9 +14,9 @@ static inline char rdfs8(addr_t addr)
 #include "../cmdline.c"
 unsigned long get_cmd_line_ptr(void)
 {
-	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
+	unsigned long cmd_line_ptr = boot_params_ptr->hdr.cmd_line_ptr;
 
-	cmd_line_ptr |= (u64)boot_params->ext_cmd_line_ptr << 32;
+	cmd_line_ptr |= (u64)boot_params_ptr->ext_cmd_line_ptr << 32;
 
 	return cmd_line_ptr;
 }
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index d34222816c9f..b8c42339bc35 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -167,8 +167,9 @@ void initialize_identity_maps(void *rmode)
 	 * or does not touch all the pages covering them.
 	 */
 	kernel_add_identity_map((unsigned long)_head, (unsigned long)_end);
-	boot_params = rmode;
-	kernel_add_identity_map((unsigned long)boot_params, (unsigned long)(boot_params + 1));
+	boot_params_ptr = rmode;
+	kernel_add_identity_map((unsigned long)boot_params_ptr,
+				(unsigned long)(boot_params_ptr + 1));
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
@@ -176,7 +177,7 @@ void initialize_identity_maps(void *rmode)
 	 * Also map the setup_data entries passed via boot_params in case they
 	 * need to be accessed by uncompressed kernel via the identity mapping.
 	 */
-	sd = (struct setup_data *)boot_params->hdr.setup_data;
+	sd = (struct setup_data *)boot_params_ptr->hdr.setup_data;
 	while (sd) {
 		unsigned long sd_addr = (unsigned long)sd;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index e476bcbd9b42..9794d9174795 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -63,7 +63,7 @@ static unsigned long get_boot_seed(void)
 	unsigned long hash = 0;
 
 	hash = rotate_xor(hash, build_str, sizeof(build_str));
-	hash = rotate_xor(hash, boot_params, sizeof(*boot_params));
+	hash = rotate_xor(hash, boot_params_ptr, sizeof(*boot_params_ptr));
 
 	return hash;
 }
@@ -383,7 +383,7 @@ static void handle_mem_options(void)
 static void mem_avoid_init(unsigned long input, unsigned long input_size,
 			   unsigned long output)
 {
-	unsigned long init_size = boot_params->hdr.init_size;
+	unsigned long init_size = boot_params_ptr->hdr.init_size;
 	u64 initrd_start, initrd_size;
 	unsigned long cmd_line, cmd_line_size;
 
@@ -395,10 +395,10 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	mem_avoid[MEM_AVOID_ZO_RANGE].size = (output + init_size) - input;
 
 	/* Avoid initrd. */
-	initrd_start  = (u64)boot_params->ext_ramdisk_image << 32;
-	initrd_start |= boot_params->hdr.ramdisk_image;
-	initrd_size  = (u64)boot_params->ext_ramdisk_size << 32;
-	initrd_size |= boot_params->hdr.ramdisk_size;
+	initrd_start  = (u64)boot_params_ptr->ext_ramdisk_image << 32;
+	initrd_start |= boot_params_ptr->hdr.ramdisk_image;
+	initrd_size  = (u64)boot_params_ptr->ext_ramdisk_size << 32;
+	initrd_size |= boot_params_ptr->hdr.ramdisk_size;
 	mem_avoid[MEM_AVOID_INITRD].start = initrd_start;
 	mem_avoid[MEM_AVOID_INITRD].size = initrd_size;
 	/* No need to set mapping for initrd, it will be handled in VO. */
@@ -413,8 +413,8 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 	}
 
 	/* Avoid boot parameters. */
-	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params;
-	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params);
+	mem_avoid[MEM_AVOID_BOOTPARAMS].start = (unsigned long)boot_params_ptr;
+	mem_avoid[MEM_AVOID_BOOTPARAMS].size = sizeof(*boot_params_ptr);
 
 	/* We don't need to set a mapping for setup_data. */
 
@@ -447,7 +447,7 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 	}
 
 	/* Avoid all entries in the setup_data linked list. */
-	ptr = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
+	ptr = (struct setup_data *)(unsigned long)boot_params_ptr->hdr.setup_data;
 	while (ptr) {
 		struct mem_vector avoid;
 
@@ -679,7 +679,7 @@ static bool process_mem_region(struct mem_vector *region,
 static bool
 process_efi_entries(unsigned long minimum, unsigned long image_size)
 {
-	struct efi_info *e = &boot_params->efi_info;
+	struct efi_info *e = &boot_params_ptr->efi_info;
 	bool efi_mirror_found = false;
 	struct mem_vector region;
 	efi_memory_desc_t *md;
@@ -761,8 +761,8 @@ static void process_e820_entries(unsigned long minimum,
 	struct boot_e820_entry *entry;
 
 	/* Verify potential e820 positions, appending to slots list. */
-	for (i = 0; i < boot_params->e820_entries; i++) {
-		entry = &boot_params->e820_table[i];
+	for (i = 0; i < boot_params_ptr->e820_entries; i++) {
+		entry = &boot_params_ptr->e820_table[i];
 		/* Skip non-RAM entries. */
 		if (entry->type != E820_TYPE_RAM)
 			continue;
@@ -836,7 +836,7 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
-	boot_params->hdr.loadflags |= KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
 
 	if (IS_ENABLED(CONFIG_X86_32))
 		mem_limit = KERNEL_IMAGE_SIZE;
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index fb55ac18af6f..8ae7893d712f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -46,7 +46,7 @@ void *memmove(void *dest, const void *src, size_t n);
 /*
  * This is set up by the setup-routine at boot-time
  */
-struct boot_params *boot_params;
+struct boot_params *boot_params_ptr;
 
 struct port_io_ops pio_ops;
 
@@ -132,8 +132,8 @@ void __putstr(const char *s)
 	if (lines == 0 || cols == 0)
 		return;
 
-	x = boot_params->screen_info.orig_x;
-	y = boot_params->screen_info.orig_y;
+	x = boot_params_ptr->screen_info.orig_x;
+	y = boot_params_ptr->screen_info.orig_y;
 
 	while ((c = *s++) != '\0') {
 		if (c == '\n') {
@@ -154,8 +154,8 @@ void __putstr(const char *s)
 		}
 	}
 
-	boot_params->screen_info.orig_x = x;
-	boot_params->screen_info.orig_y = y;
+	boot_params_ptr->screen_info.orig_x = x;
+	boot_params_ptr->screen_info.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
 	outb(14, vidport);
@@ -382,14 +382,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	size_t entry_offset;
 
 	/* Retain x86 boot parameters pointer passed from startup_32/64. */
-	boot_params = rmode;
+	boot_params_ptr = rmode;
 
 	/* Clear flags intended for solely in-kernel use. */
-	boot_params->hdr.loadflags &= ~KASLR_FLAG;
+	boot_params_ptr->hdr.loadflags &= ~KASLR_FLAG;
 
-	sanitize_boot_params(boot_params);
+	sanitize_boot_params(boot_params_ptr);
 
-	if (boot_params->screen_info.orig_video_mode == 7) {
+	if (boot_params_ptr->screen_info.orig_video_mode == 7) {
 		vidmem = (char *) 0xb0000;
 		vidport = 0x3b4;
 	} else {
@@ -397,8 +397,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params->screen_info.orig_video_lines;
-	cols = boot_params->screen_info.orig_video_cols;
+	lines = boot_params_ptr->screen_info.orig_video_lines;
+	cols = boot_params_ptr->screen_info.orig_video_cols;
 
 	init_default_io_ops();
 
@@ -417,7 +417,7 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 	 * so that early debugging output from the RSDP parsing code can be
 	 * collected.
 	 */
-	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+	boot_params_ptr->acpi_rsdp_addr = get_rsdp_addr();
 
 	debug_putstr("early console in extract_kernel\n");
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b6e46435b90b..254acd76efde 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -52,7 +52,6 @@ extern memptr free_mem_ptr;
 extern memptr free_mem_end_ptr;
 void *malloc(int size);
 void free(void *where);
-extern struct boot_params *boot_params;
 void __putstr(const char *s);
 void __puthex(unsigned long value);
 #define error_putstr(__x)  __putstr(__x)
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 7939eb6e6ce9..51f957b24ba7 100644
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
+	signature = (char *)&boot_params_ptr->efi_info.efi_loader_signature;
 	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
 	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
 		ebda_start = *(unsigned short *)0x40e << 4;
@@ -65,10 +64,10 @@ static unsigned long find_trampoline_placement(void)
 	bios_start = round_down(bios_start, PAGE_SIZE);
 
 	/* Find the first usable memory region under bios_start. */
-	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+	for (i = boot_params_ptr->e820_entries - 1; i >= 0; i--) {
 		unsigned long new = bios_start;
 
-		entry = &boot_params->e820_table[i];
+		entry = &boot_params_ptr->e820_table[i];
 
 		/* Skip all entries above bios_start. */
 		if (bios_start <= entry->addr)
@@ -107,7 +106,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
-	boot_params = bp;
+	boot_params_ptr = bp;
 
 	/*
 	 * Check if LA57 is desired and supported.
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 8b21c57bc470..d07e665bb265 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -565,7 +565,7 @@ void sev_prep_identity_maps(unsigned long top_level_pgt)
 	 * accessed after switchover.
 	 */
 	if (sev_snp_enabled()) {
-		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		unsigned long cc_info_pa = boot_params_ptr->cc_blob_address;
 		struct cc_blob_sev_info *cc_info;
 
 		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index b3a7cfb0d99e..a38cc0afc90a 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -85,6 +85,8 @@ extern const unsigned long kernel_total_size;
 
 unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 				void (*error)(char *x));
+
+extern struct boot_params *boot_params_ptr;
 #endif
 
 #endif /* _ASM_X86_BOOT_H */
-- 
2.44.0.278.ge034bb2e1d-goog


