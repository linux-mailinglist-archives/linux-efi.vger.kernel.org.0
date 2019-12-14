Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78EED11F347
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfLNR6H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:58:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727239AbfLNR6G (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:58:06 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9179B20724;
        Sat, 14 Dec 2019 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346284;
        bh=3eY62KpMIBrv3HiyDwlRgBzqvFm5i9UgfCkZ8WbtDQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4kBuLK370RvjDXPILLQUFGPRZh9qqgflffFxL4cvlTxpR6axnYJ7pNYO4uol965B
         tF8gmyJp75uj6Uw+ODiA4j87ZdP7Pb0JBINch8xi5zjwrmZupzHbFco1A1OChQ2g5e
         cOKjbJwhwU8Y2L9llgamgDYi+mzwU9UI/EfA3S7I=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 09/10] efi/libstub: annotate firmware routines as __efiapi
Date:   Sat, 14 Dec 2019 18:57:34 +0100
Message-Id: <20191214175735.22518-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
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
 arch/x86/Kconfig                      |   1 +
 arch/x86/boot/compressed/eboot.h      |   4 +-
 drivers/firmware/efi/libstub/random.c |   8 +-
 include/linux/efi.h                   | 130 +++++++++++---------
 4 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5e8949953660..8ba81036a7ef 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1993,6 +1993,7 @@ config EFI
 config EFI_STUB
        bool "EFI stub support"
        depends on EFI && !X86_USE_3DNOW
+       depends on $(cc-option,-mabi=ms)
        select RELOCATABLE
        ---help---
           This kernel feature allows a bzImage to be loaded directly
diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
index 318531f128c2..512d2143a94f 100644
--- a/arch/x86/boot/compressed/eboot.h
+++ b/arch/x86/boot/compressed/eboot.h
@@ -19,8 +19,8 @@ typedef struct {
 } efi_uga_draw_protocol_32_t;
 
 typedef struct efi_uga_draw_protocol {
-	efi_status_t (*get_mode)(struct efi_uga_draw_protocol *,
-				 u32*, u32*, u32*, u32*);
+	efi_status_t (__efiapi *get_mode)(struct efi_uga_draw_protocol *,
+					  u32*, u32*, u32*, u32*);
 	void *set_mode;
 	void *blt;
 } efi_uga_draw_protocol_t;
diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/libstub/random.c
index 3b85883fb312..872d2de3eaaf 100644
--- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -17,10 +17,10 @@ typedef struct {
 } efi_rng_protocol_32_t;
 
 struct efi_rng_protocol {
-	efi_status_t (*get_info)(struct efi_rng_protocol *,
-				 unsigned long *, efi_guid_t *);
-	efi_status_t (*get_rng)(struct efi_rng_protocol *,
-				efi_guid_t *, unsigned long, u8 *out);
+	efi_status_t (__efiapi *get_info)(struct efi_rng_protocol *,
+					  unsigned long *, efi_guid_t *);
+	efi_status_t (__efiapi *get_rng)(struct efi_rng_protocol *,
+					 efi_guid_t *, unsigned long, u8 *out);
 };
 
 efi_status_t efi_get_random_bytes(efi_system_table_t *sys_table_arg,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7f1a99bd2c05..2ba13d901055 100644
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
 #define for_each_efi_handle(handle, array, size, i)			\
 	for (i = 1, handle = efi_is_native() ? (array)[0]		\
 		: (efi_handle_t)(unsigned long)((u32 *)(array))[0];	\
@@ -266,13 +272,14 @@ typedef struct {
 	efi_table_hdr_t hdr;
 	void *raise_tpl;
 	void *restore_tpl;
-	efi_status_t (*allocate_pages)(int, int, unsigned long,
-				       efi_physical_addr_t *);
-	efi_status_t (*free_pages)(efi_physical_addr_t, unsigned long);
-	efi_status_t (*get_memory_map)(unsigned long *, void *, unsigned long *,
-				       unsigned long *, u32 *);
-	efi_status_t (*allocate_pool)(int, unsigned long, void **);
-	efi_status_t (*free_pool)(void *);
+	efi_status_t (__efiapi *allocate_pages)(int, int, unsigned long,
+						efi_physical_addr_t *);
+	efi_status_t (__efiapi *free_pages)(efi_physical_addr_t, unsigned long);
+	efi_status_t (__efiapi *get_memory_map)(unsigned long *, void *,
+						unsigned long *,
+						unsigned long *, u32 *);
+	efi_status_t (__efiapi *allocate_pool)(int, unsigned long, void **);
+	efi_status_t (__efiapi *free_pool)(void *);
 	void *create_event;
 	void *set_timer;
 	void *wait_for_event;
@@ -282,18 +289,21 @@ typedef struct {
 	void *install_protocol_interface;
 	void *reinstall_protocol_interface;
 	void *uninstall_protocol_interface;
-	efi_status_t (*handle_protocol)(efi_handle_t, efi_guid_t *, void **);
+	efi_status_t (__efiapi *handle_protocol)(efi_handle_t, efi_guid_t *,
+						 void **);
 	void *__reserved;
 	void *register_protocol_notify;
-	efi_status_t (*locate_handle)(int, efi_guid_t *, void *,
+	efi_status_t (__efiapi *locate_handle)(int, efi_guid_t *, void *,
 				      unsigned long *, efi_handle_t *);
 	void *locate_device_path;
-	efi_status_t (*install_configuration_table)(efi_guid_t *, void *);
+	efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
+							     void *);
 	void *load_image;
 	void *start_image;
 	void *exit;
 	void *unload_image;
-	efi_status_t (*exit_boot_services)(efi_handle_t, unsigned long);
+	efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
+						    unsigned long);
 	void *get_next_monotonic_count;
 	void *stall;
 	void *set_watchdog_timer;
@@ -304,7 +314,7 @@ typedef struct {
 	void *open_protocol_information;
 	void *protocols_per_handle;
 	void *locate_handle_buffer;
-	efi_status_t (*locate_protocol)(efi_guid_t *, void *, void **);
+	efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *, void **);
 	void *install_multiple_protocol_interfaces;
 	void *uninstall_multiple_protocol_interfaces;
 	void *calculate_crc32;
@@ -346,13 +356,13 @@ typedef struct {
 typedef struct efi_pci_io_protocol efi_pci_io_protocol_t;
 
 typedef
-efi_status_t (*efi_pci_io_protocol_mem_t)(struct efi_pci_io_protocol *,
+efi_status_t (__efiapi *efi_pci_io_protocol_mem_t)(struct efi_pci_io_protocol *,
 					  EFI_PCI_IO_PROTOCOL_WIDTH,
 					  u8 bar_index, u64 offset,
 					  unsigned long count, void *buffer);
 
 typedef
-efi_status_t (*efi_pci_io_protocol_cfg_t)(struct efi_pci_io_protocol *,
+efi_status_t (__efiapi *efi_pci_io_protocol_cfg_t)(struct efi_pci_io_protocol *,
 					  EFI_PCI_IO_PROTOCOL_WIDTH,
 					  u32 offset, unsigned long count,
 					  void *buffer);
@@ -399,11 +409,11 @@ struct efi_pci_io_protocol {
 	void *allocate_buffer;
 	void *free_buffer;
 	void *flush;
-	efi_status_t (*get_location)(struct efi_pci_io_protocol *,
-				     unsigned long *segment_nr,
-				     unsigned long *bus_nr,
-				     unsigned long *device_nr,
-				     unsigned long *function_nr);
+	efi_status_t (__efiapi *get_location)(struct efi_pci_io_protocol *,
+					      unsigned long *segment_nr,
+					      unsigned long *bus_nr,
+					      unsigned long *device_nr,
+					      unsigned long *function_nr);
 	void *attributes;
 	void *get_bar_attributes;
 	void *set_bar_attributes;
@@ -443,16 +453,16 @@ struct efi_dev_path;
 
 typedef struct apple_properties_protocol {
 	unsigned long version;
-	efi_status_t (*get)(struct apple_properties_protocol *,
-			    struct efi_dev_path *, efi_char16_t *,
-			    void *, u32 *);
-	efi_status_t (*set)(struct apple_properties_protocol *,
-			    struct efi_dev_path *, efi_char16_t *,
-			    void *, u32);
-	efi_status_t (*del)(struct apple_properties_protocol *,
-			    struct efi_dev_path *, efi_char16_t *);
-	efi_status_t (*get_all)(struct apple_properties_protocol *,
-				void *buffer, u32 *);
+	efi_status_t (__efiapi *get)(struct apple_properties_protocol *,
+				     struct efi_dev_path *, efi_char16_t *,
+				     void *, u32 *);
+	efi_status_t (__efiapi *set)(struct apple_properties_protocol *,
+				     struct efi_dev_path *, efi_char16_t *,
+				     void *, u32);
+	efi_status_t (__efiapi *del)(struct apple_properties_protocol *,
+				     struct efi_dev_path *, efi_char16_t *);
+	efi_status_t (__efiapi *get_all)(struct apple_properties_protocol *,
+					 void *buffer, u32 *);
 } apple_properties_protocol_t;
 
 typedef struct {
@@ -469,8 +479,11 @@ typedef u32 efi_tcg2_event_log_format;
 
 typedef struct {
 	void *get_capability;
-	efi_status_t (*get_event_log)(efi_handle_t, efi_tcg2_event_log_format,
-		efi_physical_addr_t *, efi_physical_addr_t *, efi_bool_t *);
+	efi_status_t (__efiapi *get_event_log)(efi_handle_t,
+					       efi_tcg2_event_log_format,
+					       efi_physical_addr_t *,
+					       efi_physical_addr_t *,
+					       efi_bool_t *);
 	void *hash_log_extend_event;
 	void *submit_command;
 	void *get_active_pcr_banks;
@@ -562,21 +575,21 @@ typedef efi_status_t efi_query_variable_store_t(u32 attributes,
 						bool nonblocking);
 
 typedef struct {
-	efi_table_hdr_t			hdr;
-	efi_get_time_t			*get_time;
-	efi_set_time_t			*set_time;
-	efi_get_wakeup_time_t		*get_wakeup_time;
-	efi_set_wakeup_time_t		*set_wakeup_time;
-	efi_set_virtual_address_map_t	*set_virtual_address_map;
-	void				*convert_pointer;
-	efi_get_variable_t		*get_variable;
-	efi_get_next_variable_t		*get_next_variable;
-	efi_set_variable_t		*set_variable;
-	efi_get_next_high_mono_count_t	*get_next_high_mono_count;
-	efi_reset_system_t		*reset_system;
-	efi_update_capsule_t		*update_capsule;
-	efi_query_capsule_caps_t	*query_capsule_caps;
-	efi_query_variable_info_t	*query_variable_info;
+	efi_table_hdr_t				hdr;
+	efi_get_time_t __efiapi 		*get_time;
+	efi_set_time_t __efiapi			*set_time;
+	efi_get_wakeup_time_t __efiapi		*get_wakeup_time;
+	efi_set_wakeup_time_t __efiapi		*set_wakeup_time;
+	efi_set_virtual_address_map_t __efiapi	*set_virtual_address_map;
+	void					*convert_pointer;
+	efi_get_variable_t __efiapi		*get_variable;
+	efi_get_next_variable_t __efiapi	*get_next_variable;
+	efi_set_variable_t __efiapi		*set_variable;
+	efi_get_next_high_mono_count_t __efiapi	*get_next_high_mono_count;
+	efi_reset_system_t __efiapi		*reset_system;
+	efi_update_capsule_t __efiapi		*update_capsule;
+	efi_query_capsule_caps_t __efiapi	*query_capsule_caps;
+	efi_query_variable_info_t __efiapi	*query_variable_info;
 } efi_runtime_services_t;
 
 void efi_native_runtime_setup(void);
@@ -796,7 +809,7 @@ typedef struct {
 	__aligned_u64 image_size;
 	unsigned int image_code_type;
 	unsigned int image_data_type;
-	efi_status_t (*unload)(efi_handle_t image_handle);
+	efi_status_t (__efiapi *unload)(efi_handle_t image_handle);
 } efi_loaded_image_t;
 
 
@@ -827,18 +840,19 @@ typedef struct {
 
 typedef struct _efi_file_handle {
 	u64 revision;
-	efi_status_t (*open)(struct _efi_file_handle *,
-			     struct _efi_file_handle **,
-			     efi_char16_t *, u64, u64);
-	efi_status_t (*close)(struct _efi_file_handle *);
+	efi_status_t (__efiapi *open)(struct _efi_file_handle *,
+				      struct _efi_file_handle **,
+				      efi_char16_t *, u64, u64);
+	efi_status_t (__efiapi *close)(struct _efi_file_handle *);
 	void *delete;
-	efi_status_t (*read)(struct _efi_file_handle *, unsigned long *,
-			     void *);
+	efi_status_t (__efiapi *read)(struct _efi_file_handle *,
+				      unsigned long *, void *);
 	void *write;
 	void *get_position;
 	void *set_position;
-	efi_status_t (*get_info)(struct _efi_file_handle *, efi_guid_t *,
-			unsigned long *, void *);
+	efi_status_t (__efiapi *get_info)(struct _efi_file_handle *,
+					  efi_guid_t *, unsigned long *,
+					  void *);
 	void *set_info;
 	void *flush;
 } efi_file_handle_t;
@@ -850,8 +864,8 @@ typedef struct {
 
 typedef struct _efi_file_io_interface {
 	u64 revision;
-	int (*open_volume)(struct _efi_file_io_interface *,
-			   efi_file_handle_t **);
+	int (__efiapi *open_volume)(struct _efi_file_io_interface *,
+				    efi_file_handle_t **);
 } efi_file_io_interface_t;
 
 #define EFI_FILE_MODE_READ	0x0000000000000001
@@ -1325,7 +1339,7 @@ typedef struct {
 
 typedef struct efi_simple_text_output_protocol {
 	void *reset;
-	efi_status_t (*output_string)(void *, void *);
+	efi_status_t (__efiapi *output_string)(void *, void *);
 	void *test_string;
 } efi_simple_text_output_protocol_t;
 
-- 
2.17.1

