Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50B611F343
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfLNR6A (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:44470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfLNR6A (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:58:00 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3966124658;
        Sat, 14 Dec 2019 17:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346279;
        bh=6awMQrnn/YcG7l5/azaUfXfvGt+NWeRcwn9GxvDrhyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1VOI/DNOow7/rCYBCzgXR1G1SsGADYwfEl152X6AgOWSGSHwDyrWI760WdGx22FNQ
         02CM8MRViFL0ZRNi9IqsdmoK6E49DebsG/yM/BgstmEScY7TkG/p8L1A6AkqgtsORJ
         hTj07KIDq2NzPDQgih7GT73FpzESXvOxQTsqHZJQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 07/10] efi/libstub: drop explicit 64-bit protocol definitions
Date:   Sat, 14 Dec 2019 18:57:32 +0100
Message-Id: <20191214175735.22518-8-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Mixed mode involves casting 64-bit native calls to 32-bit EFI calls,
which requires explicit 32-bit protocol definitions. Native calls
are always done using the protocol definitions that use native types,
and so the explicit 64-bit ones are redundant. Remove them.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/eboot.h      |   6 -
 drivers/firmware/efi/libstub/random.c |   5 -
 include/linux/efi.h                   | 142 --------------------
 3 files changed, 153 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index 8297387c4676..1cf384ba1b0e 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -18,12 +18,6 @@ typedef struct {
 	u32 blt;
 } efi_uga_draw_protocol_32_t;
 
-typedef struct {
-	u64 get_mode;
-	u64 set_mode;
-	u64 blt;
-} efi_uga_draw_protocol_64_t;
-
 typedef struct {
 	void *get_mode;
 	void *set_mode;
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 97378cf96a2e..3b85883fb312 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -16,11 +16,6 @@ typedef struct {
 	u32 get_rng;
 } efi_rng_protocol_32_t;
 
-typedef struct {
-	u64 get_info;
-	u64 get_rng;
-} efi_rng_protocol_64_t;
-
 struct efi_rng_protocol {
 	efi_status_t (*get_info)(struct efi_rng_protocol *,
 				 unsigned long *, efi_guid_t *);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index e17c16d8d523..87c2537b4543 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -259,54 +259,6 @@ typedef struct {
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
@@ -391,11 +343,6 @@ typedef struct {
 	u32 write;
 } efi_pci_io_protocol_access_32_t;
 
-typedef struct {
-	u64 read;
-	u64 write;
-} efi_pci_io_protocol_access_64_t;
-
 typedef struct efi_pci_io_protocol efi_pci_io_protocol_t;
 
 typedef
@@ -440,26 +387,6 @@ typedef struct {
 	u32 romimage;
 } efi_pci_io_protocol_32_t;
 
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
 struct efi_pci_io_protocol {
 	void *poll_mem;
 	void *poll_io;
@@ -508,14 +435,6 @@ typedef struct {
 	u32 get_all;
 } apple_properties_protocol_32_t;
 
-typedef struct {
-	u64 version;
-	u64 get;
-	u64 set;
-	u64 del;
-	u64 get_all;
-} apple_properties_protocol_64_t;
-
 struct efi_dev_path;
 
 typedef struct apple_properties_protocol {
@@ -542,16 +461,6 @@ typedef struct {
 	u32 get_result_of_set_active_pcr_banks;
 } efi_tcg2_protocol_32_t;
 
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
 
 typedef struct {
@@ -870,22 +779,6 @@ typedef struct {
 	u32 unload;
 } efi_loaded_image_32_t;
 
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
 typedef struct {
 	u32 revision;
 	efi_handle_t parent_handle;
@@ -928,20 +821,6 @@ typedef struct {
 	u32 flush;
 } efi_file_handle_32_t;
 
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
 typedef struct _efi_file_handle {
 	u64 revision;
 	efi_status_t (*open)(struct _efi_file_handle *,
@@ -965,11 +844,6 @@ typedef struct {
 	u32 open_volume;
 } efi_file_io_interface_32_t;
 
-typedef struct {
-	u64 revision;
-	u64 open_volume;
-} efi_file_io_interface_64_t;
-
 typedef struct _efi_file_io_interface {
 	u64 revision;
 	int (*open_volume)(struct _efi_file_io_interface *,
@@ -1482,15 +1356,6 @@ typedef struct {
 	u32 frame_buffer_size;
 } efi_graphics_output_protocol_mode_32_t;
 
-typedef struct {
-	u32 max_mode;
-	u32 mode;
-	u64 info;
-	u64 size_of_info;
-	u64 frame_buffer_base;
-	u64 frame_buffer_size;
-} efi_graphics_output_protocol_mode_64_t;
-
 typedef struct {
 	u32 max_mode;
 	u32 mode;
@@ -1507,13 +1372,6 @@ typedef struct {
 	u32 mode;
 } efi_graphics_output_protocol_32_t;
 
-typedef struct {
-	u64 query_mode;
-	u64 set_mode;
-	u64 blt;
-	u64 mode;
-} efi_graphics_output_protocol_64_t;
-
 typedef struct {
 	void *query_mode;
 	void *set_mode;
-- 
2.17.1

