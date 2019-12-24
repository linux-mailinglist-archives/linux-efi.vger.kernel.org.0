Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2212A2DF
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLXPME (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfLXPLC (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:02 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A2F2071A;
        Tue, 24 Dec 2019 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200261;
        bh=ilvQflRQYrSiIcErm99kH1CDHHgWXDdpj8QOpDJwIXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzJu2hkrfgBtFT8GXRM/X7VIIuFcW3Ul4ifXMUaeycnKgtnAG/nGksyjNtFERs6qI
         Ef/Wal8cgRdbXMsNK8IzDkPQMZn2tIT0hlaLEwlSgabIECZsB8WjXvOH51wbZTijUo
         HPFexUzSq5Q4nup3bN+WWX1dtLezK9KXidfU41j0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 10/25] efi/libstub: drop explicit 32/64-bit protocol definitions
Date:   Tue, 24 Dec 2019 16:10:10 +0100
Message-Id: <20191224151025.32482-11-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Now that we have incorporated the mixed mode protocol definitions
into the native ones using unions, we no longer need the separate
32/64 bit struct definitions, with the exception of the EFI system
table definition and the boot services, runtime services and
configuration table definitions. So drop the unused ones.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.h      |  12 --
 drivers/firmware/efi/libstub/random.c |  10 --
 include/linux/efi.h                   | 245 +-------------------------
 3 files changed, 1 insertion(+), 266 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index 26f1f2635f64..de13865dc7d2 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -12,18 +12,6 @@
 
 #define DESC_TYPE_CODE_DATA	(1 << 0)
 
-typedef struct {
-	u32 get_mode;
-	u32 set_mode;
-	u32 blt;
-} efi_uga_draw_protocol_32_t;
-
-typedef struct {
-	u64 get_mode;
-	u64 set_mode;
-	u64 blt;
-} efi_uga_draw_protocol_64_t;
-
 typedef union {
 	struct {
 		void *get_mode;
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index d92cd640c73d..1a5a4a9db2a7 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -11,16 +11,6 @@
 
 typedef union efi_rng_protocol efi_rng_protocol_t;
 
-typedef struct {
-	u32 get_info;
-	u32 get_rng;
-} efi_rng_protocol_32_t;
-
-typedef struct {
-	u64 get_info;
-	u64 get_rng;
-} efi_rng_protocol_64_t;
-
 union efi_rng_protocol {
 	struct {
 		efi_status_t (*get_info)(efi_rng_protocol_t *,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e9d74e9667c0..d8e987910853 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -264,54 +264,6 @@ typedef struct {
 	u32 create_event_ex;
 } __packed efi_boot_services_32_t;
 
-typedef struct {
-	efi_table_hdr_t hdr;
-	u64 raise_tpl;
-	u64 restore_tpl;
-	u64 allocate_pages;
-	u64 free_pages;
-	u64 get_memory_map;
-	u64 allocate_pool;
-	u64 free_pool;
-	u64 create_event;
-	u64 set_timer;
-	u64 wait_for_event;
-	u64 signal_event;
-	u64 close_event;
-	u64 check_event;
-	u64 install_protocol_interface;
-	u64 reinstall_protocol_interface;
-	u64 uninstall_protocol_interface;
-	u64 handle_protocol;
-	u64 __reserved;
-	u64 register_protocol_notify;
-	u64 locate_handle;
-	u64 locate_device_path;
-	u64 install_configuration_table;
-	u64 load_image;
-	u64 start_image;
-	u64 exit;
-	u64 unload_image;
-	u64 exit_boot_services;
-	u64 get_next_monotonic_count;
-	u64 stall;
-	u64 set_watchdog_timer;
-	u64 connect_controller;
-	u64 disconnect_controller;
-	u64 open_protocol;
-	u64 close_protocol;
-	u64 open_protocol_information;
-	u64 protocols_per_handle;
-	u64 locate_handle_buffer;
-	u64 locate_protocol;
-	u64 install_multiple_protocol_interfaces;
-	u64 uninstall_multiple_protocol_interfaces;
-	u64 calculate_crc32;
-	u64 copy_mem;
-	u64 set_mem;
-	u64 create_event_ex;
-} __packed efi_boot_services_64_t;
-
 /*
  * EFI Boot Services table
  */
@@ -399,11 +351,6 @@ typedef struct {
 	u32 write;
 } efi_pci_io_protocol_access_32_t;
 
-typedef struct {
-	u64 read;
-	u64 write;
-} efi_pci_io_protocol_access_64_t;
-
 typedef union efi_pci_io_protocol efi_pci_io_protocol_t;
 
 typedef
@@ -422,46 +369,6 @@ typedef struct {
 	efi_pci_io_protocol_cfg_t write;
 } efi_pci_io_protocol_config_access_t;
 
-typedef struct {
-	u32 poll_mem;
-	u32 poll_io;
-	efi_pci_io_protocol_access_32_t mem;
-	efi_pci_io_protocol_access_32_t io;
-	efi_pci_io_protocol_access_32_t pci;
-	u32 copy_mem;
-	u32 map;
-	u32 unmap;
-	u32 allocate_buffer;
-	u32 free_buffer;
-	u32 flush;
-	u32 get_location;
-	u32 attributes;
-	u32 get_bar_attributes;
-	u32 set_bar_attributes;
-	u64 romsize;
-	u32 romimage;
-} efi_pci_io_protocol_32_t;
-
-typedef struct {
-	u64 poll_mem;
-	u64 poll_io;
-	efi_pci_io_protocol_access_64_t mem;
-	efi_pci_io_protocol_access_64_t io;
-	efi_pci_io_protocol_access_64_t pci;
-	u64 copy_mem;
-	u64 map;
-	u64 unmap;
-	u64 allocate_buffer;
-	u64 free_buffer;
-	u64 flush;
-	u64 get_location;
-	u64 attributes;
-	u64 get_bar_attributes;
-	u64 set_bar_attributes;
-	u64 romsize;
-	u64 romimage;
-} efi_pci_io_protocol_64_t;
-
 union efi_pci_io_protocol {
 	struct {
 		void *poll_mem;
@@ -523,22 +430,6 @@ union efi_pci_io_protocol {
 #define EFI_PCI_IO_ATTRIBUTE_VGA_PALETTE_IO_16 0x20000
 #define EFI_PCI_IO_ATTRIBUTE_VGA_IO_16 0x40000
 
-typedef struct {
-	u32 version;
-	u32 get;
-	u32 set;
-	u32 del;
-	u32 get_all;
-} apple_properties_protocol_32_t;
-
-typedef struct {
-	u64 version;
-	u64 get;
-	u64 set;
-	u64 del;
-	u64 get_all;
-} apple_properties_protocol_64_t;
-
 struct efi_dev_path;
 
 typedef union apple_properties_protocol apple_properties_protocol_t;
@@ -566,26 +457,6 @@ union apple_properties_protocol {
 	} mixed_mode;
 };
 
-typedef struct {
-	u32 get_capability;
-	u32 get_event_log;
-	u32 hash_log_extend_event;
-	u32 submit_command;
-	u32 get_active_pcr_banks;
-	u32 set_active_pcr_banks;
-	u32 get_result_of_set_active_pcr_banks;
-} efi_tcg2_protocol_32_t;
-
-typedef struct {
-	u64 get_capability;
-	u64 get_event_log;
-	u64 hash_log_extend_event;
-	u64 submit_command;
-	u64 get_active_pcr_banks;
-	u64 set_active_pcr_banks;
-	u64 get_result_of_set_active_pcr_banks;
-} efi_tcg2_protocol_64_t;
-
 typedef u32 efi_tcg2_event_log_format;
 
 typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
@@ -913,38 +784,6 @@ struct efi_fdt_params {
 	u32 desc_ver;
 };
 
-typedef struct {
-	u32 revision;
-	u32 parent_handle;
-	u32 system_table;
-	u32 device_handle;
-	u32 file_path;
-	u32 reserved;
-	u32 load_options_size;
-	u32 load_options;
-	u32 image_base;
-	__aligned_u64 image_size;
-	unsigned int image_code_type;
-	unsigned int image_data_type;
-	u32 unload;
-} efi_loaded_image_32_t;
-
-typedef struct {
-	u32 revision;
-	u64 parent_handle;
-	u64 system_table;
-	u64 device_handle;
-	u64 file_path;
-	u64 reserved;
-	u32 load_options_size;
-	u64 load_options;
-	u64 image_base;
-	__aligned_u64 image_size;
-	unsigned int image_code_type;
-	unsigned int image_data_type;
-	u64 unload;
-} efi_loaded_image_64_t;
-
 typedef union efi_loaded_image efi_loaded_image_t;
 
 union efi_loaded_image {
@@ -991,34 +830,6 @@ typedef struct {
 	efi_char16_t filename[1];
 } efi_file_info_t;
 
-typedef struct {
-	u64 revision;
-	u32 open;
-	u32 close;
-	u32 delete;
-	u32 read;
-	u32 write;
-	u32 get_position;
-	u32 set_position;
-	u32 get_info;
-	u32 set_info;
-	u32 flush;
-} efi_file_handle_32_t;
-
-typedef struct {
-	u64 revision;
-	u64 open;
-	u64 close;
-	u64 delete;
-	u64 read;
-	u64 write;
-	u64 get_position;
-	u64 set_position;
-	u64 get_info;
-	u64 set_info;
-	u64 flush;
-} efi_file_handle_64_t;
-
 typedef union efi_file_handle efi_file_handle_t;
 
 union efi_file_handle {
@@ -1054,16 +865,6 @@ union efi_file_handle {
 	} mixed_mode;
 };
 
-typedef struct {
-	u64 revision;
-	u32 open_volume;
-} efi_file_io_interface_32_t;
-
-typedef struct {
-	u64 revision;
-	u64 open_volume;
-} efi_file_io_interface_64_t;
-
 typedef union efi_file_io_interface efi_file_io_interface_t;
 
 union efi_file_io_interface {
@@ -1076,7 +877,7 @@ union efi_file_io_interface {
 		u64 revision;
 		u32 open_volume;
 	} mixed_mode;
-} ;
+};
 
 #define EFI_FILE_MODE_READ	0x0000000000000001
 #define EFI_FILE_MODE_WRITE	0x0000000000000002
@@ -1536,18 +1337,6 @@ struct efivar_entry {
 	bool deleting;
 };
 
-typedef struct {
-	u32 reset;
-	u32 output_string;
-	u32 test_string;
-} efi_simple_text_output_protocol_32_t;
-
-typedef struct {
-	u64 reset;
-	u64 output_string;
-	u64 test_string;
-} efi_simple_text_output_protocol_64_t;
-
 typedef union efi_simple_text_output_protocol efi_simple_text_output_protocol_t;
 
 union efi_simple_text_output_protocol {
@@ -1586,24 +1375,6 @@ typedef struct {
 	u32 pixels_per_scan_line;
 } efi_graphics_output_mode_info_t;
 
-typedef struct {
-	u32 max_mode;
-	u32 mode;
-	u32 info;
-	u32 size_of_info;
-	u64 frame_buffer_base;
-	u32 frame_buffer_size;
-} efi_graphics_output_protocol_mode_32_t;
-
-typedef struct {
-	u32 max_mode;
-	u32 mode;
-	u64 info;
-	u64 size_of_info;
-	u64 frame_buffer_base;
-	u64 frame_buffer_size;
-} efi_graphics_output_protocol_mode_64_t;
-
 typedef union efi_graphics_output_protocol_mode efi_graphics_output_protocol_mode_t;
 
 union efi_graphics_output_protocol_mode {
@@ -1625,20 +1396,6 @@ union efi_graphics_output_protocol_mode {
 	} mixed_mode;
 };
 
-typedef struct {
-	u32 query_mode;
-	u32 set_mode;
-	u32 blt;
-	u32 mode;
-} efi_graphics_output_protocol_32_t;
-
-typedef struct {
-	u64 query_mode;
-	u64 set_mode;
-	u64 blt;
-	u64 mode;
-} efi_graphics_output_protocol_64_t;
-
 typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
 
 union efi_graphics_output_protocol {
-- 
2.20.1

