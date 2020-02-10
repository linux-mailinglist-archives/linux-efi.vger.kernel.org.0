Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADD157F5F
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgBJQDP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgBJQDP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:15 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3357924650;
        Mon, 10 Feb 2020 16:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350593;
        bh=tBA84jqUd9JPhq4w/iyU/aSbYVNefx2pxgv2vfXYgeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J7Dx4JVb8jJ57gFr9lDzqFt1bgiYxwraRyHfDN3iEWMibq/Fabdex1jQ1faNzZq0f
         N2pKvLeRTGnrAsEF+WElC2ekwe7z4YB6CZqRSU+zo2yZCNzuSKsj7S4alPJYIQcd/q
         Q4Fg8tPPb5wFItaHLxfdA0PfoP8fHwfJb8N4T/yA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 09/19] efi/libstub: Move stub specific declarations into efistub.h
Date:   Mon, 10 Feb 2020 17:02:38 +0100
Message-Id: <20200210160248.4889-10-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Move all the declarations that are only used in stub code from
linux/efi.h to efistub.h which is only included locally.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 507 ++++++++++++++++++--
 include/linux/efi.h                    | 456 +-----------------
 2 files changed, 479 insertions(+), 484 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 79cdb219f439..8bb46c1fd2cd 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -43,34 +43,6 @@ extern __pure efi_system_table_t  *efi_system_table(void);
 
 #define pr_efi_err(msg) efi_printk("EFI stub: ERROR: "msg)
 
-void efi_char16_printk(efi_char16_t *);
-void efi_char16_printk(efi_char16_t *);
-
-unsigned long get_dram_base(void);
-
-efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
-					    unsigned long *new_fdt_addr,
-					    unsigned long max_addr,
-					    u64 initrd_addr, u64 initrd_size,
-					    char *cmdline_ptr,
-					    unsigned long fdt_addr,
-					    unsigned long fdt_size);
-
-void *get_fdt(unsigned long *fdt_size);
-
-void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
-		     unsigned long desc_size, efi_memory_desc_t *runtime_map,
-		     int *count);
-
-efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
-
-efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
-			      unsigned long *addr, unsigned long random_seed);
-
-efi_status_t check_platform_features(void);
-
-void *get_efi_config_table(efi_guid_t guid);
-
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
 #define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
@@ -90,6 +62,156 @@ void *get_efi_config_table(efi_guid_t guid);
 	efi_rt_call(set_variable, (efi_char16_t *)(name),	\
 		    (efi_guid_t *)(vendor), __VA_ARGS__)
 
+#define efi_get_handle_at(array, idx)					\
+	(efi_is_native() ? (array)[idx] 				\
+		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
+
+#define efi_get_handle_num(size)					\
+	((size) / (efi_is_native() ? sizeof(efi_handle_t) : sizeof(u32)))
+
+#define for_each_efi_handle(handle, array, size, i)			\
+	for (i = 0;							\
+	     i < efi_get_handle_num(size) &&				\
+		((handle = efi_get_handle_at((array), i)) || true);	\
+	     i++)
+
+/*
+ * Allocation types for calls to boottime->allocate_pages.
+ */
+#define EFI_ALLOCATE_ANY_PAGES		0
+#define EFI_ALLOCATE_MAX_ADDRESS	1
+#define EFI_ALLOCATE_ADDRESS		2
+#define EFI_MAX_ALLOCATE_TYPE		3
+
+/*
+ * The type of search to perform when calling boottime->locate_handle
+ */
+#define EFI_LOCATE_ALL_HANDLES			0
+#define EFI_LOCATE_BY_REGISTER_NOTIFY		1
+#define EFI_LOCATE_BY_PROTOCOL			2
+
+struct efi_boot_memmap {
+	efi_memory_desc_t	**map;
+	unsigned long		*map_size;
+	unsigned long		*desc_size;
+	u32			*desc_ver;
+	unsigned long		*key_ptr;
+	unsigned long		*buff_size;
+};
+
+/*
+ * EFI Boot Services table
+ */
+union efi_boot_services {
+	struct {
+		efi_table_hdr_t hdr;
+		void *raise_tpl;
+		void *restore_tpl;
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
+		void *create_event;
+		void *set_timer;
+		void *wait_for_event;
+		void *signal_event;
+		void *close_event;
+		void *check_event;
+		void *install_protocol_interface;
+		void *reinstall_protocol_interface;
+		void *uninstall_protocol_interface;
+		efi_status_t (__efiapi *handle_protocol)(efi_handle_t,
+							 efi_guid_t *, void **);
+		void *__reserved;
+		void *register_protocol_notify;
+		efi_status_t (__efiapi *locate_handle)(int, efi_guid_t *,
+						       void *, unsigned long *,
+						       efi_handle_t *);
+		void *locate_device_path;
+		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
+								     void *);
+		void *load_image;
+		void *start_image;
+		void *exit;
+		void *unload_image;
+		efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
+							    unsigned long);
+		void *get_next_monotonic_count;
+		void *stall;
+		void *set_watchdog_timer;
+		void *connect_controller;
+		efi_status_t (__efiapi *disconnect_controller)(efi_handle_t,
+							       efi_handle_t,
+							       efi_handle_t);
+		void *open_protocol;
+		void *close_protocol;
+		void *open_protocol_information;
+		void *protocols_per_handle;
+		void *locate_handle_buffer;
+		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
+							 void **);
+		void *install_multiple_protocol_interfaces;
+		void *uninstall_multiple_protocol_interfaces;
+		void *calculate_crc32;
+		void *copy_mem;
+		void *set_mem;
+		void *create_event_ex;
+	};
+	struct {
+		efi_table_hdr_t hdr;
+		u32 raise_tpl;
+		u32 restore_tpl;
+		u32 allocate_pages;
+		u32 free_pages;
+		u32 get_memory_map;
+		u32 allocate_pool;
+		u32 free_pool;
+		u32 create_event;
+		u32 set_timer;
+		u32 wait_for_event;
+		u32 signal_event;
+		u32 close_event;
+		u32 check_event;
+		u32 install_protocol_interface;
+		u32 reinstall_protocol_interface;
+		u32 uninstall_protocol_interface;
+		u32 handle_protocol;
+		u32 __reserved;
+		u32 register_protocol_notify;
+		u32 locate_handle;
+		u32 locate_device_path;
+		u32 install_configuration_table;
+		u32 load_image;
+		u32 start_image;
+		u32 exit;
+		u32 unload_image;
+		u32 exit_boot_services;
+		u32 get_next_monotonic_count;
+		u32 stall;
+		u32 set_watchdog_timer;
+		u32 connect_controller;
+		u32 disconnect_controller;
+		u32 open_protocol;
+		u32 close_protocol;
+		u32 open_protocol_information;
+		u32 protocols_per_handle;
+		u32 locate_handle_buffer;
+		u32 locate_protocol;
+		u32 install_multiple_protocol_interfaces;
+		u32 uninstall_multiple_protocol_interfaces;
+		u32 calculate_crc32;
+		u32 copy_mem;
+		u32 set_mem;
+		u32 create_event_ex;
+	} mixed_mode;
+};
+
 typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
 
 union efi_uga_draw_protocol {
@@ -106,7 +228,81 @@ union efi_uga_draw_protocol {
 	} mixed_mode;
 };
 
-typedef struct efi_loaded_image {
+union efi_simple_text_output_protocol {
+	struct {
+		void *reset;
+		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
+						       efi_char16_t *);
+		void *test_string;
+	};
+	struct {
+		u32 reset;
+		u32 output_string;
+		u32 test_string;
+	} mixed_mode;
+};
+
+#define PIXEL_RGB_RESERVED_8BIT_PER_COLOR		0
+#define PIXEL_BGR_RESERVED_8BIT_PER_COLOR		1
+#define PIXEL_BIT_MASK					2
+#define PIXEL_BLT_ONLY					3
+#define PIXEL_FORMAT_MAX				4
+
+typedef struct {
+	u32 red_mask;
+	u32 green_mask;
+	u32 blue_mask;
+	u32 reserved_mask;
+} efi_pixel_bitmask_t;
+
+typedef struct {
+	u32 version;
+	u32 horizontal_resolution;
+	u32 vertical_resolution;
+	int pixel_format;
+	efi_pixel_bitmask_t pixel_information;
+	u32 pixels_per_scan_line;
+} efi_graphics_output_mode_info_t;
+
+typedef union efi_graphics_output_protocol_mode efi_graphics_output_protocol_mode_t;
+
+union efi_graphics_output_protocol_mode {
+	struct {
+		u32 max_mode;
+		u32 mode;
+		efi_graphics_output_mode_info_t *info;
+		unsigned long size_of_info;
+		efi_physical_addr_t frame_buffer_base;
+		unsigned long frame_buffer_size;
+	};
+	struct {
+		u32 max_mode;
+		u32 mode;
+		u32 info;
+		u32 size_of_info;
+		u64 frame_buffer_base;
+		u32 frame_buffer_size;
+	} mixed_mode;
+};
+
+typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
+
+union efi_graphics_output_protocol {
+	struct {
+		void *query_mode;
+		void *set_mode;
+		void *blt;
+		efi_graphics_output_protocol_mode_t *mode;
+	};
+	struct {
+		u32 query_mode;
+		u32 set_mode;
+		u32 blt;
+		u32 mode;
+	} mixed_mode;
+};
+
+typedef struct {
 	u32			revision;
 	efi_handle_t		parent_handle;
 	efi_system_table_t	*system_table;
@@ -169,4 +365,257 @@ struct efi_simple_file_system_protocol {
 #define EFI_FILE_MODE_WRITE	0x0000000000000002
 #define EFI_FILE_MODE_CREATE	0x8000000000000000
 
+typedef enum {
+	EfiPciIoWidthUint8,
+	EfiPciIoWidthUint16,
+	EfiPciIoWidthUint32,
+	EfiPciIoWidthUint64,
+	EfiPciIoWidthFifoUint8,
+	EfiPciIoWidthFifoUint16,
+	EfiPciIoWidthFifoUint32,
+	EfiPciIoWidthFifoUint64,
+	EfiPciIoWidthFillUint8,
+	EfiPciIoWidthFillUint16,
+	EfiPciIoWidthFillUint32,
+	EfiPciIoWidthFillUint64,
+	EfiPciIoWidthMaximum
+} EFI_PCI_IO_PROTOCOL_WIDTH;
+
+typedef enum {
+	EfiPciIoAttributeOperationGet,
+	EfiPciIoAttributeOperationSet,
+	EfiPciIoAttributeOperationEnable,
+	EfiPciIoAttributeOperationDisable,
+	EfiPciIoAttributeOperationSupported,
+    EfiPciIoAttributeOperationMaximum
+} EFI_PCI_IO_PROTOCOL_ATTRIBUTE_OPERATION;
+
+typedef struct {
+	u32 read;
+	u32 write;
+} efi_pci_io_protocol_access_32_t;
+
+typedef union efi_pci_io_protocol efi_pci_io_protocol_t;
+
+typedef
+efi_status_t (__efiapi *efi_pci_io_protocol_cfg_t)(efi_pci_io_protocol_t *,
+						   EFI_PCI_IO_PROTOCOL_WIDTH,
+						   u32 offset,
+						   unsigned long count,
+						   void *buffer);
+
+typedef struct {
+	void *read;
+	void *write;
+} efi_pci_io_protocol_access_t;
+
+typedef struct {
+	efi_pci_io_protocol_cfg_t read;
+	efi_pci_io_protocol_cfg_t write;
+} efi_pci_io_protocol_config_access_t;
+
+union efi_pci_io_protocol {
+	struct {
+		void *poll_mem;
+		void *poll_io;
+		efi_pci_io_protocol_access_t mem;
+		efi_pci_io_protocol_access_t io;
+		efi_pci_io_protocol_config_access_t pci;
+		void *copy_mem;
+		void *map;
+		void *unmap;
+		void *allocate_buffer;
+		void *free_buffer;
+		void *flush;
+		efi_status_t (__efiapi *get_location)(efi_pci_io_protocol_t *,
+						      unsigned long *segment_nr,
+						      unsigned long *bus_nr,
+						      unsigned long *device_nr,
+						      unsigned long *func_nr);
+		void *attributes;
+		void *get_bar_attributes;
+		void *set_bar_attributes;
+		uint64_t romsize;
+		void *romimage;
+	};
+	struct {
+		u32 poll_mem;
+		u32 poll_io;
+		efi_pci_io_protocol_access_32_t mem;
+		efi_pci_io_protocol_access_32_t io;
+		efi_pci_io_protocol_access_32_t pci;
+		u32 copy_mem;
+		u32 map;
+		u32 unmap;
+		u32 allocate_buffer;
+		u32 free_buffer;
+		u32 flush;
+		u32 get_location;
+		u32 attributes;
+		u32 get_bar_attributes;
+		u32 set_bar_attributes;
+		u64 romsize;
+		u32 romimage;
+	} mixed_mode;
+};
+
+#define EFI_PCI_IO_ATTRIBUTE_ISA_MOTHERBOARD_IO 0x0001
+#define EFI_PCI_IO_ATTRIBUTE_ISA_IO 0x0002
+#define EFI_PCI_IO_ATTRIBUTE_VGA_PALETTE_IO 0x0004
+#define EFI_PCI_IO_ATTRIBUTE_VGA_MEMORY 0x0008
+#define EFI_PCI_IO_ATTRIBUTE_VGA_IO 0x0010
+#define EFI_PCI_IO_ATTRIBUTE_IDE_PRIMARY_IO 0x0020
+#define EFI_PCI_IO_ATTRIBUTE_IDE_SECONDARY_IO 0x0040
+#define EFI_PCI_IO_ATTRIBUTE_MEMORY_WRITE_COMBINE 0x0080
+#define EFI_PCI_IO_ATTRIBUTE_IO 0x0100
+#define EFI_PCI_IO_ATTRIBUTE_MEMORY 0x0200
+#define EFI_PCI_IO_ATTRIBUTE_BUS_MASTER 0x0400
+#define EFI_PCI_IO_ATTRIBUTE_MEMORY_CACHED 0x0800
+#define EFI_PCI_IO_ATTRIBUTE_MEMORY_DISABLE 0x1000
+#define EFI_PCI_IO_ATTRIBUTE_EMBEDDED_DEVICE 0x2000
+#define EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM 0x4000
+#define EFI_PCI_IO_ATTRIBUTE_DUAL_ADDRESS_CYCLE 0x8000
+#define EFI_PCI_IO_ATTRIBUTE_ISA_IO_16 0x10000
+#define EFI_PCI_IO_ATTRIBUTE_VGA_PALETTE_IO_16 0x20000
+#define EFI_PCI_IO_ATTRIBUTE_VGA_IO_16 0x40000
+
+struct efi_dev_path;
+
+typedef union apple_properties_protocol apple_properties_protocol_t;
+
+union apple_properties_protocol {
+	struct {
+		unsigned long version;
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
+	};
+	struct {
+		u32 version;
+		u32 get;
+		u32 set;
+		u32 del;
+		u32 get_all;
+	} mixed_mode;
+};
+
+typedef u32 efi_tcg2_event_log_format;
+
+typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
+
+union efi_tcg2_protocol {
+	struct {
+		void *get_capability;
+		efi_status_t (__efiapi *get_event_log)(efi_handle_t,
+						       efi_tcg2_event_log_format,
+						       efi_physical_addr_t *,
+						       efi_physical_addr_t *,
+						       efi_bool_t *);
+		void *hash_log_extend_event;
+		void *submit_command;
+		void *get_active_pcr_banks;
+		void *set_active_pcr_banks;
+		void *get_result_of_set_active_pcr_banks;
+	};
+	struct {
+		u32 get_capability;
+		u32 get_event_log;
+		u32 hash_log_extend_event;
+		u32 submit_command;
+		u32 get_active_pcr_banks;
+		u32 set_active_pcr_banks;
+		u32 get_result_of_set_active_pcr_banks;
+	} mixed_mode;
+};
+
+void efi_pci_disable_bridge_busmaster(void);
+
+typedef efi_status_t (*efi_exit_boot_map_processing)(
+	struct efi_boot_memmap *map,
+	void *priv);
+
+efi_status_t efi_exit_boot_services(void *handle,
+				    struct efi_boot_memmap *map,
+				    void *priv,
+				    efi_exit_boot_map_processing priv_func);
+
+void efi_char16_printk(efi_char16_t *);
+
+unsigned long get_dram_base(void);
+
+efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
+					    unsigned long *new_fdt_addr,
+					    unsigned long max_addr,
+					    u64 initrd_addr, u64 initrd_size,
+					    char *cmdline_ptr,
+					    unsigned long fdt_addr,
+					    unsigned long fdt_size);
+
+void *get_fdt(unsigned long *fdt_size);
+
+void efi_get_virtmap(efi_memory_desc_t *memory_map, unsigned long map_size,
+		     unsigned long desc_size, efi_memory_desc_t *runtime_map,
+		     int *count);
+
+efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
+
+efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
+			      unsigned long *addr, unsigned long random_seed);
+
+efi_status_t check_platform_features(void);
+
+void *get_efi_config_table(efi_guid_t guid);
+
+void efi_printk(char *str);
+
+void efi_free(unsigned long size, unsigned long addr);
+
+char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
+
+efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
+
+efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
+				 unsigned long *addr, unsigned long min);
+
+static inline
+efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
+			   unsigned long *addr)
+{
+	/*
+	 * Don't allocate at 0x0. It will confuse code that
+	 * checks pointers against NULL. Skip the first 8
+	 * bytes so we start at a nice even number.
+	 */
+	return efi_low_alloc_above(size, align, addr, 0x8);
+}
+
+efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
+				unsigned long max);
+
+efi_status_t efi_relocate_kernel(unsigned long *image_addr,
+				 unsigned long image_size,
+				 unsigned long alloc_size,
+				 unsigned long preferred_addr,
+				 unsigned long alignment,
+				 unsigned long min_addr);
+
+efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
+				  char *cmd_line, char *option_string,
+				  unsigned long max_addr,
+				  unsigned long *load_addr,
+				  unsigned long *load_size);
+
+efi_status_t efi_parse_options(char const *cmdline);
+
+efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
+			   unsigned long size);
+
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2b228df18407..0e047d2738cd 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -56,19 +56,6 @@ typedef void *efi_handle_t;
 #define __efiapi
 #endif
 
-#define efi_get_handle_at(array, idx)					\
-	(efi_is_native() ? (array)[idx] 				\
-		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
-
-#define efi_get_handle_num(size)					\
-	((size) / (efi_is_native() ? sizeof(efi_handle_t) : sizeof(u32)))
-
-#define for_each_efi_handle(handle, array, size, i)			\
-	for (i = 0;							\
-	     i < efi_get_handle_num(size) &&				\
-		((handle = efi_get_handle_at((array), i)) || true);	\
-	     i++)
-
 /*
  * The UEFI spec and EDK2 reference implementation both define EFI_GUID as
  * struct { u32 a; u16; b; u16 c; u8 d[8]; }; and so the implied alignment
@@ -157,15 +144,6 @@ typedef struct {
 	u32 imagesize;
 } efi_capsule_header_t;
 
-struct efi_boot_memmap {
-	efi_memory_desc_t	**map;
-	unsigned long		*map_size;
-	unsigned long		*desc_size;
-	u32			*desc_ver;
-	unsigned long		*key_ptr;
-	unsigned long		*buff_size;
-};
-
 /*
  * EFI capsule flags
  */
@@ -187,14 +165,6 @@ struct capsule_info {
 
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
-/*
- * Allocation types for calls to boottime->allocate_pages.
- */
-#define EFI_ALLOCATE_ANY_PAGES		0
-#define EFI_ALLOCATE_MAX_ADDRESS	1
-#define EFI_ALLOCATE_ADDRESS		2
-#define EFI_MAX_ALLOCATE_TYPE		3
-
 typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
 
 /*
@@ -224,291 +194,7 @@ typedef struct {
 	u8 sets_to_zero;
 } efi_time_cap_t;
 
-typedef struct {
-	efi_table_hdr_t hdr;
-	u32 raise_tpl;
-	u32 restore_tpl;
-	u32 allocate_pages;
-	u32 free_pages;
-	u32 get_memory_map;
-	u32 allocate_pool;
-	u32 free_pool;
-	u32 create_event;
-	u32 set_timer;
-	u32 wait_for_event;
-	u32 signal_event;
-	u32 close_event;
-	u32 check_event;
-	u32 install_protocol_interface;
-	u32 reinstall_protocol_interface;
-	u32 uninstall_protocol_interface;
-	u32 handle_protocol;
-	u32 __reserved;
-	u32 register_protocol_notify;
-	u32 locate_handle;
-	u32 locate_device_path;
-	u32 install_configuration_table;
-	u32 load_image;
-	u32 start_image;
-	u32 exit;
-	u32 unload_image;
-	u32 exit_boot_services;
-	u32 get_next_monotonic_count;
-	u32 stall;
-	u32 set_watchdog_timer;
-	u32 connect_controller;
-	u32 disconnect_controller;
-	u32 open_protocol;
-	u32 close_protocol;
-	u32 open_protocol_information;
-	u32 protocols_per_handle;
-	u32 locate_handle_buffer;
-	u32 locate_protocol;
-	u32 install_multiple_protocol_interfaces;
-	u32 uninstall_multiple_protocol_interfaces;
-	u32 calculate_crc32;
-	u32 copy_mem;
-	u32 set_mem;
-	u32 create_event_ex;
-} __packed efi_boot_services_32_t;
-
-/*
- * EFI Boot Services table
- */
-typedef union {
-	struct {
-		efi_table_hdr_t hdr;
-		void *raise_tpl;
-		void *restore_tpl;
-		efi_status_t (__efiapi *allocate_pages)(int, int, unsigned long,
-							efi_physical_addr_t *);
-		efi_status_t (__efiapi *free_pages)(efi_physical_addr_t,
-						    unsigned long);
-		efi_status_t (__efiapi *get_memory_map)(unsigned long *, void *,
-							unsigned long *,
-							unsigned long *, u32 *);
-		efi_status_t (__efiapi *allocate_pool)(int, unsigned long,
-						       void **);
-		efi_status_t (__efiapi *free_pool)(void *);
-		void *create_event;
-		void *set_timer;
-		void *wait_for_event;
-		void *signal_event;
-		void *close_event;
-		void *check_event;
-		void *install_protocol_interface;
-		void *reinstall_protocol_interface;
-		void *uninstall_protocol_interface;
-		efi_status_t (__efiapi *handle_protocol)(efi_handle_t,
-							 efi_guid_t *, void **);
-		void *__reserved;
-		void *register_protocol_notify;
-		efi_status_t (__efiapi *locate_handle)(int, efi_guid_t *,
-						       void *, unsigned long *,
-						       efi_handle_t *);
-		void *locate_device_path;
-		efi_status_t (__efiapi *install_configuration_table)(efi_guid_t *,
-								     void *);
-		void *load_image;
-		void *start_image;
-		void *exit;
-		void *unload_image;
-		efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
-							    unsigned long);
-		void *get_next_monotonic_count;
-		void *stall;
-		void *set_watchdog_timer;
-		void *connect_controller;
-		efi_status_t (__efiapi *disconnect_controller)(efi_handle_t,
-							       efi_handle_t,
-							       efi_handle_t);
-		void *open_protocol;
-		void *close_protocol;
-		void *open_protocol_information;
-		void *protocols_per_handle;
-		void *locate_handle_buffer;
-		efi_status_t (__efiapi *locate_protocol)(efi_guid_t *, void *,
-							 void **);
-		void *install_multiple_protocol_interfaces;
-		void *uninstall_multiple_protocol_interfaces;
-		void *calculate_crc32;
-		void *copy_mem;
-		void *set_mem;
-		void *create_event_ex;
-	};
-	efi_boot_services_32_t mixed_mode;
-} efi_boot_services_t;
-
-typedef enum {
-	EfiPciIoWidthUint8,
-	EfiPciIoWidthUint16,
-	EfiPciIoWidthUint32,
-	EfiPciIoWidthUint64,
-	EfiPciIoWidthFifoUint8,
-	EfiPciIoWidthFifoUint16,
-	EfiPciIoWidthFifoUint32,
-	EfiPciIoWidthFifoUint64,
-	EfiPciIoWidthFillUint8,
-	EfiPciIoWidthFillUint16,
-	EfiPciIoWidthFillUint32,
-	EfiPciIoWidthFillUint64,
-	EfiPciIoWidthMaximum
-} EFI_PCI_IO_PROTOCOL_WIDTH;
-
-typedef enum {
-	EfiPciIoAttributeOperationGet,
-	EfiPciIoAttributeOperationSet,
-	EfiPciIoAttributeOperationEnable,
-	EfiPciIoAttributeOperationDisable,
-	EfiPciIoAttributeOperationSupported,
-    EfiPciIoAttributeOperationMaximum
-} EFI_PCI_IO_PROTOCOL_ATTRIBUTE_OPERATION;
-
-typedef struct {
-	u32 read;
-	u32 write;
-} efi_pci_io_protocol_access_32_t;
-
-typedef union efi_pci_io_protocol efi_pci_io_protocol_t;
-
-typedef
-efi_status_t (__efiapi *efi_pci_io_protocol_cfg_t)(efi_pci_io_protocol_t *,
-						   EFI_PCI_IO_PROTOCOL_WIDTH,
-						   u32 offset,
-						   unsigned long count,
-						   void *buffer);
-
-typedef struct {
-	void *read;
-	void *write;
-} efi_pci_io_protocol_access_t;
-
-typedef struct {
-	efi_pci_io_protocol_cfg_t read;
-	efi_pci_io_protocol_cfg_t write;
-} efi_pci_io_protocol_config_access_t;
-
-union efi_pci_io_protocol {
-	struct {
-		void *poll_mem;
-		void *poll_io;
-		efi_pci_io_protocol_access_t mem;
-		efi_pci_io_protocol_access_t io;
-		efi_pci_io_protocol_config_access_t pci;
-		void *copy_mem;
-		void *map;
-		void *unmap;
-		void *allocate_buffer;
-		void *free_buffer;
-		void *flush;
-		efi_status_t (__efiapi *get_location)(efi_pci_io_protocol_t *,
-						      unsigned long *segment_nr,
-						      unsigned long *bus_nr,
-						      unsigned long *device_nr,
-						      unsigned long *func_nr);
-		void *attributes;
-		void *get_bar_attributes;
-		void *set_bar_attributes;
-		uint64_t romsize;
-		void *romimage;
-	};
-	struct {
-		u32 poll_mem;
-		u32 poll_io;
-		efi_pci_io_protocol_access_32_t mem;
-		efi_pci_io_protocol_access_32_t io;
-		efi_pci_io_protocol_access_32_t pci;
-		u32 copy_mem;
-		u32 map;
-		u32 unmap;
-		u32 allocate_buffer;
-		u32 free_buffer;
-		u32 flush;
-		u32 get_location;
-		u32 attributes;
-		u32 get_bar_attributes;
-		u32 set_bar_attributes;
-		u64 romsize;
-		u32 romimage;
-	} mixed_mode;
-};
-
-#define EFI_PCI_IO_ATTRIBUTE_ISA_MOTHERBOARD_IO 0x0001
-#define EFI_PCI_IO_ATTRIBUTE_ISA_IO 0x0002
-#define EFI_PCI_IO_ATTRIBUTE_VGA_PALETTE_IO 0x0004
-#define EFI_PCI_IO_ATTRIBUTE_VGA_MEMORY 0x0008
-#define EFI_PCI_IO_ATTRIBUTE_VGA_IO 0x0010
-#define EFI_PCI_IO_ATTRIBUTE_IDE_PRIMARY_IO 0x0020
-#define EFI_PCI_IO_ATTRIBUTE_IDE_SECONDARY_IO 0x0040
-#define EFI_PCI_IO_ATTRIBUTE_MEMORY_WRITE_COMBINE 0x0080
-#define EFI_PCI_IO_ATTRIBUTE_IO 0x0100
-#define EFI_PCI_IO_ATTRIBUTE_MEMORY 0x0200
-#define EFI_PCI_IO_ATTRIBUTE_BUS_MASTER 0x0400
-#define EFI_PCI_IO_ATTRIBUTE_MEMORY_CACHED 0x0800
-#define EFI_PCI_IO_ATTRIBUTE_MEMORY_DISABLE 0x1000
-#define EFI_PCI_IO_ATTRIBUTE_EMBEDDED_DEVICE 0x2000
-#define EFI_PCI_IO_ATTRIBUTE_EMBEDDED_ROM 0x4000
-#define EFI_PCI_IO_ATTRIBUTE_DUAL_ADDRESS_CYCLE 0x8000
-#define EFI_PCI_IO_ATTRIBUTE_ISA_IO_16 0x10000
-#define EFI_PCI_IO_ATTRIBUTE_VGA_PALETTE_IO_16 0x20000
-#define EFI_PCI_IO_ATTRIBUTE_VGA_IO_16 0x40000
-
-struct efi_dev_path;
-
-typedef union apple_properties_protocol apple_properties_protocol_t;
-
-union apple_properties_protocol {
-	struct {
-		unsigned long version;
-		efi_status_t (__efiapi *get)(apple_properties_protocol_t *,
-					     struct efi_dev_path *,
-					     efi_char16_t *, void *, u32 *);
-		efi_status_t (__efiapi *set)(apple_properties_protocol_t *,
-					     struct efi_dev_path *,
-					     efi_char16_t *, void *, u32);
-		efi_status_t (__efiapi *del)(apple_properties_protocol_t *,
-					     struct efi_dev_path *,
-					     efi_char16_t *);
-		efi_status_t (__efiapi *get_all)(apple_properties_protocol_t *,
-						 void *buffer, u32 *);
-	};
-	struct {
-		u32 version;
-		u32 get;
-		u32 set;
-		u32 del;
-		u32 get_all;
-	} mixed_mode;
-};
-
-typedef u32 efi_tcg2_event_log_format;
-
-typedef union efi_tcg2_protocol efi_tcg2_protocol_t;
-
-union efi_tcg2_protocol {
-	struct {
-		void *get_capability;
-		efi_status_t (__efiapi *get_event_log)(efi_handle_t,
-						       efi_tcg2_event_log_format,
-						       efi_physical_addr_t *,
-						       efi_physical_addr_t *,
-						       efi_bool_t *);
-		void *hash_log_extend_event;
-		void *submit_command;
-		void *get_active_pcr_banks;
-		void *set_active_pcr_banks;
-		void *get_result_of_set_active_pcr_banks;
-	};
-	struct {
-		u32 get_capability;
-		u32 get_event_log;
-		u32 hash_log_extend_event;
-		u32 submit_command;
-		u32 get_active_pcr_banks;
-		u32 set_active_pcr_banks;
-		u32 get_result_of_set_active_pcr_banks;
-	} mixed_mode;
-};
+typedef union efi_boot_services efi_boot_services_t;
 
 /*
  * Types and defines for EFI ResetSystem
@@ -796,8 +482,6 @@ struct efi_fdt_params {
 	u32 desc_ver;
 };
 
-typedef struct efi_loaded_image efi_loaded_image_t;
-
 typedef struct {
 	u32 version;
 	u32 length;
@@ -1130,13 +814,6 @@ extern int efi_status_to_err(efi_status_t status);
  */
 #define EFI_VARIABLE_GUID_LEN	UUID_STRING_LEN
 
-/*
- * The type of search to perform when calling boottime->locate_handle
- */
-#define EFI_LOCATE_ALL_HANDLES			0
-#define EFI_LOCATE_BY_REGISTER_NOTIFY		1
-#define EFI_LOCATE_BY_PROTOCOL			2
-
 /*
  * EFI Device Path information
  */
@@ -1254,80 +931,6 @@ struct efivar_entry {
 	bool deleting;
 };
 
-union efi_simple_text_output_protocol {
-	struct {
-		void *reset;
-		efi_status_t (__efiapi *output_string)(efi_simple_text_output_protocol_t *,
-						       efi_char16_t *);
-		void *test_string;
-	};
-	struct {
-		u32 reset;
-		u32 output_string;
-		u32 test_string;
-	} mixed_mode;
-};
-
-#define PIXEL_RGB_RESERVED_8BIT_PER_COLOR		0
-#define PIXEL_BGR_RESERVED_8BIT_PER_COLOR		1
-#define PIXEL_BIT_MASK					2
-#define PIXEL_BLT_ONLY					3
-#define PIXEL_FORMAT_MAX				4
-
-typedef struct {
-	u32 red_mask;
-	u32 green_mask;
-	u32 blue_mask;
-	u32 reserved_mask;
-} efi_pixel_bitmask_t;
-
-typedef struct {
-	u32 version;
-	u32 horizontal_resolution;
-	u32 vertical_resolution;
-	int pixel_format;
-	efi_pixel_bitmask_t pixel_information;
-	u32 pixels_per_scan_line;
-} efi_graphics_output_mode_info_t;
-
-typedef union efi_graphics_output_protocol_mode efi_graphics_output_protocol_mode_t;
-
-union efi_graphics_output_protocol_mode {
-	struct {
-		u32 max_mode;
-		u32 mode;
-		efi_graphics_output_mode_info_t *info;
-		unsigned long size_of_info;
-		efi_physical_addr_t frame_buffer_base;
-		unsigned long frame_buffer_size;
-	};
-	struct {
-		u32 max_mode;
-		u32 mode;
-		u32 info;
-		u32 size_of_info;
-		u64 frame_buffer_base;
-		u32 frame_buffer_size;
-	} mixed_mode;
-};
-
-typedef union efi_graphics_output_protocol efi_graphics_output_protocol_t;
-
-union efi_graphics_output_protocol {
-	struct {
-		void *query_mode;
-		void *set_mode;
-		void *blt;
-		efi_graphics_output_protocol_mode_t *mode;
-	};
-	struct {
-		u32 query_mode;
-		u32 set_mode;
-		u32 blt;
-		u32 mode;
-	} mixed_mode;
-};
-
 extern struct list_head efivar_sysfs_list;
 
 static inline void
@@ -1425,52 +1028,6 @@ static inline int efi_runtime_map_copy(void *buf, size_t bufsz)
 
 #endif
 
-/* prototypes shared between arch specific and generic stub code */
-
-void efi_printk(char *str);
-
-void efi_free(unsigned long size, unsigned long addr);
-
-char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
-
-efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
-
-efi_status_t efi_low_alloc_above(unsigned long size, unsigned long align,
-				 unsigned long *addr, unsigned long min);
-
-static inline
-efi_status_t efi_low_alloc(unsigned long size, unsigned long align,
-			   unsigned long *addr)
-{
-	/*
-	 * Don't allocate at 0x0. It will confuse code that
-	 * checks pointers against NULL. Skip the first 8
-	 * bytes so we start at a nice even number.
-	 */
-	return efi_low_alloc_above(size, align, addr, 0x8);
-}
-
-efi_status_t efi_allocate_pages(unsigned long size, unsigned long *addr,
-				unsigned long max);
-
-efi_status_t efi_relocate_kernel(unsigned long *image_addr,
-				 unsigned long image_size,
-				 unsigned long alloc_size,
-				 unsigned long preferred_addr,
-				 unsigned long alignment,
-				 unsigned long min_addr);
-
-efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
-				  char *cmd_line, char *option_string,
-				  unsigned long max_addr,
-				  unsigned long *load_addr,
-				  unsigned long *load_size);
-
-efi_status_t efi_parse_options(char const *cmdline);
-
-efi_status_t efi_setup_gop(struct screen_info *si, efi_guid_t *proto,
-			   unsigned long size);
-
 #ifdef CONFIG_EFI
 extern bool efi_runtime_disabled(void);
 #else
@@ -1548,15 +1105,6 @@ void efi_retrieve_tpm2_eventlog(void);
 	arch_efi_call_virt_teardown();					\
 })
 
-typedef efi_status_t (*efi_exit_boot_map_processing)(
-	struct efi_boot_memmap *map,
-	void *priv);
-
-efi_status_t efi_exit_boot_services(void *handle,
-				    struct efi_boot_memmap *map,
-				    void *priv,
-				    efi_exit_boot_map_processing priv_func);
-
 #define EFI_RANDOM_SEED_SIZE		64U
 
 struct linux_efi_random_seed {
@@ -1643,6 +1191,4 @@ struct linux_efi_memreserve {
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
 	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
 
-void efi_pci_disable_bridge_busmaster(void);
-
 #endif /* _LINUX_EFI_H */
-- 
2.17.1

