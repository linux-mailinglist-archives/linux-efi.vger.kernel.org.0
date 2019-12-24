Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6136F12A2DB
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLXPLG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfLXPLF (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:05 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BBFF2073B;
        Tue, 24 Dec 2019 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200264;
        bh=+bUik0sZfIG+6G5TvjG9lbRP14k9CpdsGJLdjB1/7GA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+qd5ZSbuOJ+PjeP+KKwxOMqkbk7BAB73BfMM0TE96hGdpirWvLE88DPJlg3sy4Zz
         KTWg3n+cipQ+TMCtd41Kk1e6nFSY+C8Kkhar+4ERs5bjyUrBz/asMJ7MAKWzlpg3G5
         RpkO2PW+a6Mr0IN5i43wxkkBNx/y1tl+on+MG5KQ=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 12/25] efi/libstub: annotate firmware routines as __efiapi
Date:   Tue, 24 Dec 2019 16:10:12 +0100
Message-Id: <20191224151025.32482-13-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Annotate all the firmware routines (boot services, runtime services and
protocol methods) called in the boot context as __efiapi, and make
it expand to __attribute__((ms_abi)) on 64-bit x86. This allows us
to use the compiler to generate the calls into firmware that use the
MS calling convention instead of the SysV one.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Kconfig                      |  11 +-
 arch/x86/boot/compressed/eboot.h      |   4 +-
 drivers/firmware/efi/libstub/random.c |  10 +-
 include/linux/efi.h                   | 147 ++++++++++++++------------
 4 files changed, 96 insertions(+), 76 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..ded73bb5c0dd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1991,11 +1991,12 @@ config EFI
 	  platforms.
 
 config EFI_STUB
-       bool "EFI stub support"
-       depends on EFI && !X86_USE_3DNOW
-       select RELOCATABLE
-       ---help---
-          This kernel feature allows a bzImage to be loaded directly
+	bool "EFI stub support"
+	depends on EFI && !X86_USE_3DNOW
+	depends on $(cc-option,-mabi=ms) || X86_32
+	select RELOCATABLE
+	---help---
+	  This kernel feature allows a bzImage to be loaded directly
 	  by EFI firmware without the use of a bootloader.
 
 	  See Documentation/admin-guide/efi-stub.rst for more information.
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index b8d11928f528..99f35343d443 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -16,8 +16,8 @@ typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
 
 union efi_uga_draw_protocol {
 	struct {
-		efi_status_t (*get_mode)(efi_uga_draw_protocol_t *,
-					 u32*, u32*, u32*, u32*);
+		efi_status_t (__efiapi *get_mode)(efi_uga_draw_protocol_t *,
+						  u32*, u32*, u32*, u32*);
 		void *set_mode;
 		void *blt;
 	};
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 1a5a4a9db2a7..4f5c249c62dc 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -13,10 +13,12 @@ typedef union efi_rng_protocol efi_rng_protocol_t;
 
 union efi_rng_protocol {
 	struct {
-		efi_status_t (*get_info)(efi_rng_protocol_t *,
-					 unsigned long *, efi_guid_t *);
-		efi_status_t (*get_rng)(efi_rng_protocol_t *,
-					efi_guid_t *, unsigned long, u8 *out);
+		efi_status_t (__efiapi *get_info)(efi_rng_protocol_t *,
+						  unsigned long *,
+						  efi_guid_t *);
+		efi_status_t (__efiapi *get_rng)(efi_rng_protocol_t *,
+						 efi_guid_t *, unsigned long,
+						 u8 *out);
 	};
 	struct {
 		u32 get_info;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 880077639113..2074b737aa17 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -48,6 +48,12 @@ typedef u16 efi_char16_t;		/* UNICODE character */
 typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
+#ifdef CONFIG_X86_64
+#define __efiapi __attribute__((ms_abi))
+#else
+#define __efiapi
+#endif
+
 #define efi_get_handle_at(array, idx)					\
 	(efi_is_native() ? (array)[idx] 				\
 		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
@@ -272,13 +278,16 @@ typedef union {
 		efi_table_hdr_t hdr;
 		void *raise_tpl;
 		void *restore_tpl;
-		efi_status_t (*allocate_pages)(int, int, unsigned long,
-					       efi_physical_addr_t *);
-		efi_status_t (*free_pages)(efi_physical_addr_t, unsigned long);
-		efi_status_t (*get_memory_map)(unsigned long *, void *, unsigned long *,
-					       unsigned long *, u32 *);
-		efi_status_t (*allocate_pool)(int, unsigned long, void **);
-		efi_status_t (*free_pool)(void *);
+		efi_status_t (__efiapi *allocate_pages)(int, int, unsigned long,
+							efi_physical_addr_t *);
+		efi_status_t (__efiapi *free_pages)(efi_physical_addr_t,
+						    unsigned long);
+		efi_status_t (__efiapi *get_memory_map)(unsigned long *, void *,
+							unsigned long *,
+							unsigned long *, u32 *);
+		efi_status_t (__efiapi *allocate_pool)(int, unsigned long,
+						       void **);
+		efi_status_t (__efiapi *free_pool)(void *);
 		void *create_event;
 		void *set_timer;
 		void *wait_for_event;
@@ -288,18 +297,22 @@ typedef union {
 		void *install_protocol_interface;
 		void *reinstall_protocol_interface;
 		void *uninstall_protocol_interface;
-		efi_status_t (*handle_protocol)(efi_handle_t, efi_guid_t *, void **);
+		efi_status_t (__efiapi *handle_protocol)(efi_handle_t,
+							 efi_guid_t *, void **);
 		void *__reserved;
 		void *register_protocol_notify;
-		efi_status_t (*locate_handle)(int, efi_guid_t *, void *,
-					      unsigned long *, efi_handle_t *);
+		efi_status_t (__efiapi *locate_handle)(int, efi_guid_t *,
+						       void *, unsigned long *,
+						       efi_handle_t *);
 		void *locate_device_path;
-		efi_status_t (*install_configuration_table)(efi_guid_t *, void *);
+		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
+								     void *);
 		void *load_image;
 		void *start_image;
 		void *exit;
 		void *unload_image;
-		efi_status_t (*exit_boot_services)(efi_handle_t, unsigned long);
+		efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
+							    unsigned long);
 		void *get_next_monotonic_count;
 		void *stall;
 		void *set_watchdog_timer;
@@ -310,7 +323,8 @@ typedef union {
 		void *open_protocol_information;
 		void *protocols_per_handle;
 		void *locate_handle_buffer;
-		efi_status_t (*locate_protocol)(efi_guid_t *, void *, void **);
+		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
+							 void **);
 		void *install_multiple_protocol_interfaces;
 		void *uninstall_multiple_protocol_interfaces;
 		void *calculate_crc32;
@@ -354,10 +368,11 @@ typedef struct {
 typedef union efi_pci_io_protocol efi_pci_io_protocol_t;
 
 typedef
-efi_status_t (*efi_pci_io_protocol_cfg_t)(efi_pci_io_protocol_t *,
-					  EFI_PCI_IO_PROTOCOL_WIDTH,
-					  u32 offset, unsigned long count,
-					  void *buffer);
+efi_status_t (__efiapi *efi_pci_io_protocol_cfg_t)(efi_pci_io_protocol_t *,
+						   EFI_PCI_IO_PROTOCOL_WIDTH,
+						   u32 offset,
+						   unsigned long count,
+						   void *buffer);
 
 typedef struct {
 	void *read;
@@ -382,11 +397,11 @@ union efi_pci_io_protocol {
 		void *allocate_buffer;
 		void *free_buffer;
 		void *flush;
-		efi_status_t (*get_location)(efi_pci_io_protocol_t *,
-					     unsigned long *segment_nr,
-					     unsigned long *bus_nr,
-					     unsigned long *device_nr,
-					     unsigned long *function_nr);
+		efi_status_t (__efiapi *get_location)(efi_pci_io_protocol_t *,
+						      unsigned long *segment_nr,
+						      unsigned long *bus_nr,
+						      unsigned long *device_nr,
+						      unsigned long *func_nr);
 		void *attributes;
 		void *get_bar_attributes;
 		void *set_bar_attributes;
@@ -441,16 +456,17 @@ typedef union apple_properties_protocol apple_properties_protocol_t;
 union apple_properties_protocol {
 	struct {
 		unsigned long version;
-		efi_status_t (*get)(apple_properties_protocol_t *,
-				    struct efi_dev_path *, efi_char16_t *,
-				    void *, u32 *);
-		efi_status_t (*set)(apple_properties_protocol_t *,
-				    struct efi_dev_path *, efi_char16_t *,
-				    void *, u32);
-		efi_status_t (*del)(apple_properties_protocol_t *,
-				    struct efi_dev_path *, efi_char16_t *);
-		efi_status_t (*get_all)(apple_properties_protocol_t *,
-					void *buffer, u32 *);
+		efi_status_t (__efiapi *get)(apple_properties_protocol_t *,
+					     struct efi_dev_path *,
+					     efi_char16_t *, void *, u32 *);
+		efi_status_t (__efiapi *set)(apple_properties_protocol_t *,
+					     struct efi_dev_path *,
+					     efi_char16_t *, void *, u32);
+		efi_status_t (__efiapi *del)(apple_properties_protocol_t *,
+					     struct efi_dev_path *,
+					     efi_char16_t *);
+		efi_status_t (__efiapi *get_all)(apple_properties_protocol_t *,
+						 void *buffer, u32 *);
 	};
 	struct {
 		u32 version;
@@ -468,11 +484,11 @@ typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
 union efi_tcg2_protocol {
 	struct {
 		void *get_capability;
-		efi_status_t (*get_event_log)(efi_handle_t,
-					      efi_tcg2_event_log_format,
-					      efi_physical_addr_t *,
-					      efi_physical_addr_t *,
-					      efi_bool_t *);
+		efi_status_t (__efiapi *get_event_log)(efi_handle_t,
+						       efi_tcg2_event_log_format,
+						       efi_physical_addr_t *,
+						       efi_physical_addr_t *,
+						       efi_bool_t *);
 		void *hash_log_extend_event;
 		void *submit_command;
 		void *get_active_pcr_banks;
@@ -575,21 +591,21 @@ typedef efi_status_t efi_query_variable_store_t(u32 attributes,
 
 typedef union {
 	struct {
-		efi_table_hdr_t			hdr;
-		efi_get_time_t			*get_time;
-		efi_set_time_t			*set_time;
-		efi_get_wakeup_time_t		*get_wakeup_time;
-		efi_set_wakeup_time_t		*set_wakeup_time;
-		efi_set_virtual_address_map_t	*set_virtual_address_map;
-		void				*convert_pointer;
-		efi_get_variable_t		*get_variable;
-		efi_get_next_variable_t		*get_next_variable;
-		efi_set_variable_t		*set_variable;
-		efi_get_next_high_mono_count_t	*get_next_high_mono_count;
-		efi_reset_system_t		*reset_system;
-		efi_update_capsule_t		*update_capsule;
-		efi_query_capsule_caps_t	*query_capsule_caps;
-		efi_query_variable_info_t	*query_variable_info;
+		efi_table_hdr_t				hdr;
+		efi_get_time_t __efiapi			*get_time;
+		efi_set_time_t __efiapi			*set_time;
+		efi_get_wakeup_time_t __efiapi		*get_wakeup_time;
+		efi_set_wakeup_time_t __efiapi		*set_wakeup_time;
+		efi_set_virtual_address_map_t __efiapi	*set_virtual_address_map;
+		void					*convert_pointer;
+		efi_get_variable_t __efiapi		*get_variable;
+		efi_get_next_variable_t __efiapi	*get_next_variable;
+		efi_set_variable_t __efiapi		*set_variable;
+		efi_get_next_high_mono_count_t __efiapi	*get_next_high_mono_count;
+		efi_reset_system_t __efiapi		*reset_system;
+		efi_update_capsule_t __efiapi		*update_capsule;
+		efi_query_capsule_caps_t __efiapi	*query_capsule_caps;
+		efi_query_variable_info_t __efiapi	*query_variable_info;
 	};
 	efi_runtime_services_32_t mixed_mode;
 } efi_runtime_services_t;
@@ -806,7 +822,7 @@ union efi_loaded_image {
 		__aligned_u64 image_size;
 		unsigned int image_code_type;
 		unsigned int image_data_type;
-		efi_status_t (*unload)(efi_handle_t image_handle);
+		efi_status_t ( __efiapi *unload)(efi_handle_t image_handle);
 	};
 	struct {
 		u32 revision;
@@ -841,18 +857,19 @@ typedef union efi_file_handle efi_file_handle_t;
 union efi_file_handle {
 	struct {
 		u64 revision;
-		efi_status_t (*open)(efi_file_handle_t *,
-				     efi_file_handle_t **,
-				     efi_char16_t *, u64, u64);
-		efi_status_t (*close)(efi_file_handle_t *);
+		efi_status_t (__efiapi *open)(efi_file_handle_t *,
+					      efi_file_handle_t **,
+					      efi_char16_t *, u64, u64);
+		efi_status_t (__efiapi *close)(efi_file_handle_t *);
 		void *delete;
-		efi_status_t (*read)(efi_file_handle_t *, unsigned long *,
-				     void *);
+		efi_status_t (__efiapi *read)(efi_file_handle_t *,
+					      unsigned long *, void *);
 		void *write;
 		void *get_position;
 		void *set_position;
-		efi_status_t (*get_info)(efi_file_handle_t *, efi_guid_t *,
-				unsigned long *, void *);
+		efi_status_t (__efiapi *get_info)(efi_file_handle_t *,
+						  efi_guid_t *, unsigned long *,
+						  void *);
 		void *set_info;
 		void *flush;
 	};
@@ -876,8 +893,8 @@ typedef union efi_file_io_interface efi_file_io_interface_t;
 union efi_file_io_interface {
 	struct {
 		u64 revision;
-		int (*open_volume)(efi_file_io_interface_t *,
-				   efi_file_handle_t **);
+		int (__efiapi *open_volume)(efi_file_io_interface_t *,
+					    efi_file_handle_t **);
 	};
 	struct {
 		u64 revision;
@@ -1346,8 +1363,8 @@ struct efivar_entry {
 union efi_simple_text_output_protocol {
 	struct {
 		void *reset;
-		efi_status_t (*output_string)(efi_simple_text_output_protocol_t *,
-					      efi_char16_t *);
+		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
+						       efi_char16_t *);
 		void *test_string;
 	};
 	struct {
-- 
2.20.1

