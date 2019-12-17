Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4E12298B
	for <lists+linux-efi@lfdr.de>; Tue, 17 Dec 2019 12:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLQLJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 17 Dec 2019 06:09:49 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35227 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfLQLJt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 17 Dec 2019 06:09:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so10844788wro.2;
        Tue, 17 Dec 2019 03:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=IZy24CqGX0WMddAX8y5CYypv2I0aQqvEHGc/9n8byVQ=;
        b=KpEMzR58bBn6WaCTzT7mHJQOhz+7PZyBw9U5KdAaPtqCTb9o4MMi2RZxV1hI4HVDPE
         c1ZZBknoEBzBEZOW/a+7FtbCbJxTG9cls+WXX/a/2XgQ6XX3AEEk5M6itGKmeuH6eYSw
         uedYgmQtoiLCUmFoQ6VMdhV0BV2Dmn3aMGPKH+WuuekVstekdG1nDqr9Axoi8dgblGXv
         X2Kh896numH1k6vkXeaDiW4WhiJQEQHcaBD9SB7Du8eNlQAYK/NPPOjfEst1Uo+Gl7A9
         h5znHZ3tXgEF8FJm68Pwx3Vo2pl0DXB3l/IKe9R8QJgpfLeXI/FUY3J7d2DSraEgS85/
         YQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=IZy24CqGX0WMddAX8y5CYypv2I0aQqvEHGc/9n8byVQ=;
        b=njWbpBu/++RxQQbvucSbRxvKhMbkQgPVO61F6GEIaWNBVy31fz5wk3JIbfLtpGReXk
         9rQUgaK3GrKxh506AQDGm0+TUF8XCUruSAud504zITa1J1DlM/F0dUOG0+OOJlYz5ReX
         +E0Eu1iHlkJb1ViMejNElldf9bX1YS2DCXpwfUeDzt72I8boE/Dd6Yk9hVulpWsbB6HO
         JJSA/ES/clI8gEyjb8AnPHFFSBhQzjGT5BCkIDW+KNlCgopUWWncpIHfCBHM9YyFY4k3
         I6mH8DlRI4lwsswSp7wvDl9Nx/+j2KfcWPG223c3R5hKCGTrluhI+qUDH87e54GiF/Uq
         Pr5w==
X-Gm-Message-State: APjAAAXvvV3yednlDlvrOI4qXkmNAktZ18GlRs3bfXfXRa9VIyoRCb3W
        rOzVCsCI/8kGEJgdnhsK55Y=
X-Google-Smtp-Source: APXvYqw33jcfl5ulq6q2sp9zwiomL7o04fPFsk+LzZVCsPXPQYvUend5CNlljXT2p7kpk1LCCoPCuA==
X-Received: by 2002:adf:a308:: with SMTP id c8mr35440877wrb.240.1576580985676;
        Tue, 17 Dec 2019 03:09:45 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v14sm25214225wrm.28.2019.12.17.03.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:09:44 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:09:42 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] EFI fixes
Message-ID: <20191217110942.GA55641@gmail.com>
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

   # HEAD: a470552ee8965da0fe6fd4df0aa39c4cda652c7c efi: Don't attempt to map RCI2 config table if it doesn't exist

Protect presistent EFI memory reservations from kexec, fix EFIFB early 
console, EFI stub graphics output fixes and other misc fixes.

 Thanks,

	Ingo

------------------>
Andy Shevchenko (1):
      efi/earlycon: Remap entire framebuffer after page initialization

Ard Biesheuvel (2):
      efi/memreserve: Register reservations as 'reserved' in /proc/iomem
      efi: Don't attempt to map RCI2 config table if it doesn't exist

Arvind Sankar (4):
      efi/gop: Return EFI_NOT_FOUND if there are no usable GOPs
      efi/gop: Return EFI_SUCCESS if a usable GOP was found
      efi/gop: Fix memory leak in __gop_query32/64()
      efi: Fix efi_loaded_image_t::unload type


 drivers/firmware/efi/earlycon.c    | 40 +++++++++++++++++++
 drivers/firmware/efi/efi.c         | 28 ++++++++++++-
 drivers/firmware/efi/libstub/gop.c | 80 +++++++++-----------------------------
 drivers/firmware/efi/rci2-table.c  |  3 ++
 include/linux/efi.h                | 10 ++---
 5 files changed, 93 insertions(+), 68 deletions(-)

diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index c9a0efca17b0..d4077db6dc97 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -13,18 +13,57 @@
 
 #include <asm/early_ioremap.h>
 
+static const struct console *earlycon_console __initdata;
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static u64 fb_base;
 static pgprot_t fb_prot;
+static void *efi_fb;
+
+/*
+ * EFI earlycon needs to use early_memremap() to map the framebuffer.
+ * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
+ * memremap() should be used instead. memremap() will be available after
+ * paging_init() which is earlier than initcall callbacks. Thus adding this
+ * early initcall function early_efi_map_fb() to map the whole EFI framebuffer.
+ */
+static int __init efi_earlycon_remap_fb(void)
+{
+	/* bail if there is no bootconsole or it has been disabled already */
+	if (!earlycon_console || !(earlycon_console->flags & CON_ENABLED))
+		return 0;
+
+	if (pgprot_val(fb_prot) == pgprot_val(PAGE_KERNEL))
+		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WB);
+	else
+		efi_fb = memremap(fb_base, screen_info.lfb_size, MEMREMAP_WC);
+
+	return efi_fb ? 0 : -ENOMEM;
+}
+early_initcall(efi_earlycon_remap_fb);
+
+static int __init efi_earlycon_unmap_fb(void)
+{
+	/* unmap the bootconsole fb unless keep_bootcon has left it enabled */
+	if (efi_fb && !(earlycon_console->flags & CON_ENABLED))
+		memunmap(efi_fb);
+	return 0;
+}
+late_initcall(efi_earlycon_unmap_fb);
 
 static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
+	if (efi_fb)
+		return efi_fb + start;
+
 	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
 static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
 {
+	if (efi_fb)
+		return;
+
 	early_memunmap(addr, len);
 }
 
@@ -201,6 +240,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 		efi_earlycon_scroll_up();
 
 	device->con->write = efi_earlycon_write;
+	earlycon_console = device->con;
 	return 0;
 }
 EARLYCON_DECLARE(efifb, efi_earlycon_setup);
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d101f072c8f8..b0961950d918 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -979,6 +979,24 @@ static int __init efi_memreserve_map_root(void)
 	return 0;
 }
 
+static int efi_mem_reserve_iomem(phys_addr_t addr, u64 size)
+{
+	struct resource *res, *parent;
+
+	res = kzalloc(sizeof(struct resource), GFP_ATOMIC);
+	if (!res)
+		return -ENOMEM;
+
+	res->name	= "reserved";
+	res->flags	= IORESOURCE_MEM;
+	res->start	= addr;
+	res->end	= addr + size - 1;
+
+	/* we expect a conflict with a 'System RAM' region */
+	parent = request_resource_conflict(&iomem_resource, res);
+	return parent ? request_resource(parent, res) : 0;
+}
+
 int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 {
 	struct linux_efi_memreserve *rsv;
@@ -1003,7 +1021,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 			rsv->entry[index].size = size;
 
 			memunmap(rsv);
-			return 0;
+			return efi_mem_reserve_iomem(addr, size);
 		}
 		memunmap(rsv);
 	}
@@ -1013,6 +1031,12 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	if (!rsv)
 		return -ENOMEM;
 
+	rc = efi_mem_reserve_iomem(__pa(rsv), SZ_4K);
+	if (rc) {
+		free_page((unsigned long)rsv);
+		return rc;
+	}
+
 	/*
 	 * The memremap() call above assumes that a linux_efi_memreserve entry
 	 * never crosses a page boundary, so let's ensure that this remains true
@@ -1029,7 +1053,7 @@ int __ref efi_mem_reserve_persistent(phys_addr_t addr, u64 size)
 	efi_memreserve_root->next = __pa(rsv);
 	spin_unlock(&efi_mem_reserve_persistent_lock);
 
-	return 0;
+	return efi_mem_reserve_iomem(addr, size);
 }
 
 static int __init efi_memreserve_root_init(void)
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 0101ca4c13b1..b7bf1e993b8b 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -83,30 +83,6 @@ setup_pixel_info(struct screen_info *si, u32 pixels_per_scan_line,
 	}
 }
 
-static efi_status_t
-__gop_query32(efi_system_table_t *sys_table_arg,
-	      struct efi_graphics_output_protocol_32 *gop32,
-	      struct efi_graphics_output_mode_info **info,
-	      unsigned long *size, u64 *fb_base)
-{
-	struct efi_graphics_output_protocol_mode_32 *mode;
-	efi_graphics_output_protocol_query_mode query_mode;
-	efi_status_t status;
-	unsigned long m;
-
-	m = gop32->mode;
-	mode = (struct efi_graphics_output_protocol_mode_32 *)m;
-	query_mode = (void *)(unsigned long)gop32->query_mode;
-
-	status = __efi_call_early(query_mode, (void *)gop32, mode->mode, size,
-				  info);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	*fb_base = mode->frame_buffer_base;
-	return status;
-}
-
 static efi_status_t
 setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
             efi_guid_t *proto, unsigned long size, void **gop_handle)
@@ -119,7 +95,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	u64 fb_base;
 	struct efi_pixel_bitmask pixel_info;
 	int pixel_format;
-	efi_status_t status = EFI_NOT_FOUND;
+	efi_status_t status;
 	u32 *handles = (u32 *)(unsigned long)gop_handle;
 	int i;
 
@@ -128,6 +104,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u32);
 	for (i = 0; i < nr_gops; i++) {
+		struct efi_graphics_output_protocol_mode_32 *mode;
 		struct efi_graphics_output_mode_info *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
@@ -145,9 +122,11 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		status = __gop_query32(sys_table_arg, gop32, &info, &size,
-				       &current_fb_base);
-		if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
+		mode = (void *)(unsigned long)gop32->mode;
+		info = (void *)(unsigned long)mode->info;
+		current_fb_base = mode->frame_buffer_base;
+
+		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
@@ -175,7 +154,7 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -197,32 +176,8 @@ setup_gop32(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
-	return status;
-}
-
-static efi_status_t
-__gop_query64(efi_system_table_t *sys_table_arg,
-	      struct efi_graphics_output_protocol_64 *gop64,
-	      struct efi_graphics_output_mode_info **info,
-	      unsigned long *size, u64 *fb_base)
-{
-	struct efi_graphics_output_protocol_mode_64 *mode;
-	efi_graphics_output_protocol_query_mode query_mode;
-	efi_status_t status;
-	unsigned long m;
-
-	m = gop64->mode;
-	mode = (struct efi_graphics_output_protocol_mode_64 *)m;
-	query_mode = (void *)(unsigned long)gop64->query_mode;
-
-	status = __efi_call_early(query_mode, (void *)gop64, mode->mode, size,
-				  info);
-	if (status != EFI_SUCCESS)
-		return status;
 
-	*fb_base = mode->frame_buffer_base;
-	return status;
+	return EFI_SUCCESS;
 }
 
 static efi_status_t
@@ -237,7 +192,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	u64 fb_base;
 	struct efi_pixel_bitmask pixel_info;
 	int pixel_format;
-	efi_status_t status = EFI_NOT_FOUND;
+	efi_status_t status;
 	u64 *handles = (u64 *)(unsigned long)gop_handle;
 	int i;
 
@@ -246,6 +201,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	nr_gops = size / sizeof(u64);
 	for (i = 0; i < nr_gops; i++) {
+		struct efi_graphics_output_protocol_mode_64 *mode;
 		struct efi_graphics_output_mode_info *info = NULL;
 		efi_guid_t conout_proto = EFI_CONSOLE_OUT_DEVICE_GUID;
 		bool conout_found = false;
@@ -263,9 +219,11 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 		if (status == EFI_SUCCESS)
 			conout_found = true;
 
-		status = __gop_query64(sys_table_arg, gop64, &info, &size,
-				       &current_fb_base);
-		if (status == EFI_SUCCESS && (!first_gop || conout_found) &&
+		mode = (void *)(unsigned long)gop64->mode;
+		info = (void *)(unsigned long)mode->info;
+		current_fb_base = mode->frame_buffer_base;
+
+		if ((!first_gop || conout_found) &&
 		    info->pixel_format != PIXEL_BLT_ONLY) {
 			/*
 			 * Systems that use the UEFI Console Splitter may
@@ -293,7 +251,7 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 
 	/* Did we find any GOPs? */
 	if (!first_gop)
-		goto out;
+		return EFI_NOT_FOUND;
 
 	/* EFI framebuffer */
 	si->orig_video_isVGA = VIDEO_TYPE_EFI;
@@ -315,8 +273,8 @@ setup_gop64(efi_system_table_t *sys_table_arg, struct screen_info *si,
 	si->lfb_size = si->lfb_linelength * si->lfb_height;
 
 	si->capabilities |= VIDEO_CAPABILITY_SKIP_QUIRKS;
-out:
-	return status;
+
+	return EFI_SUCCESS;
 }
 
 /*
diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 76b0c354a027..de1a9a1f9f14 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -81,6 +81,9 @@ static int __init efi_rci2_sysfs_init(void)
 	struct kobject *tables_kobj;
 	int ret = -ENOMEM;
 
+	if (rci2_table_phys == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
 	rci2_base = memremap(rci2_table_phys,
 			     sizeof(struct rci2_table_global_hdr),
 			     MEMREMAP_WB);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 99dfea595c8c..aa54586db7a5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -824,7 +824,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	u32 unload;
 } efi_loaded_image_32_t;
 
 typedef struct {
@@ -840,14 +840,14 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	u64 unload;
 } efi_loaded_image_64_t;
 
 typedef struct {
 	u32 revision;
-	void *parent_handle;
+	efi_handle_t parent_handle;
 	efi_system_table_t *system_table;
-	void *device_handle;
+	efi_handle_t device_handle;
 	void *file_path;
 	void *reserved;
 	u32 load_options_size;
@@ -856,7 +856,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	unsigned long unload;
+	efi_status_t (*unload)(efi_handle_t image_handle);
 } efi_loaded_image_t;
 
 
