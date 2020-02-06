Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC671545B6
	for <lists+linux-efi@lfdr.de>; Thu,  6 Feb 2020 15:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgBFOE7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Feb 2020 09:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBFOE7 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 6 Feb 2020 09:04:59 -0500
Received: from e123331-lin.cambridge.arm.com (fw-tnat-cam2.arm.com [217.140.106.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20249218AC;
        Thu,  6 Feb 2020 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580997898;
        bh=q0JI0zXZla7FJIrPzqb0hXndLmprkLvRuDCVXUyLtgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AipGko20jUBcbNpRbsWBPPR7d0LWajD/6BfCRMnW54KToOgTl3GR5UUozmFUu+iLf
         1o0sbGUO8kGG+bhGR79BQNs7mEvGqu9kOSzZhl18gA6OcP2lhsDInWp5iOHCphIR9j
         c/mTDrjm2j9YzUjau4x1e4qWyhZzAj5n6ApYigd0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>, lersek@redhat.com,
        leif@nuviainc.com, pjones@redhat.com, mjg59@google.com,
        agraf@csgraf.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
        daniel.kiper@oracle.com
Subject: [PATCH 1/2] efi/libstub: add support for loading the initrd from a device path
Date:   Thu,  6 Feb 2020 14:03:51 +0000
Message-Id: <20200206140352.6300-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206140352.6300-1-ardb@kernel.org>
References: <20200206140352.6300-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

There are currently two ways to specify the initrd to be passed to the
Linux kernel when booting via the EFI stub:
- it can be passed as a initrd= command line option when doing a pure PE
  boot (as opposed to the EFI handover protocol that exists for x86)
- otherwise, the bootloader or firmware can load the initrd into memory,
  and pass the address and size via the bootparams struct (x86) or
  device tree (ARM)

In the first case, we are limited to loading from the same file system
that the kernel was loaded from, and it is also problematic in a trusted
boot context, given that we cannot easily protect the command line from
tampering without either adding complicated white/blacklisting of boot
arguments or locking down the command line altogether.

In the second case, we force the bootloader to duplicate knowledge about
the boot protocol which is already encoded in the stub, and which may be
subject to change over time, e.g., bootparams struct definitions, memory
allocation/alignment requirements for the placement of the initrd etc etc.
In the ARM case, it also requires the bootloader to modify the hardware
description provided by the firmware, as it is passed in the same file.
On systems where the initrd is measured after loading, it creates a time
window where the initrd contents might be manipulated in memory before
handing over to the kernel.

Address these concerns by adding support for loading the initrd into
memory by invoking the EFI LoadFile2 protocol installed on a vendor
GUIDed device path that specifically designates a Linux initrd.
This addresses the above concerns, by putting the EFI stub in charge of
placement in memory and of passing the base and size to the kernel proper
(via whatever means it desires) while still leaving it up to the firmware
or bootloader to obtain the file contents, potentially from other file
systems than the one the kernel itself was loaded from. On platforms that
implement measured boot, it permits the firmware to take the measurement
right before the kernel actually consumes the contents.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/arm-stub.c        | 16 +++--
 drivers/firmware/efi/libstub/efi-stub-helper.c | 65 ++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h         | 12 ++++
 drivers/firmware/efi/libstub/x86-stub.c        | 36 ++++++++++-
 include/linux/efi.h                            |  1 +
 5 files changed, 123 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index c7b091f50e55..1db943c1ba2b 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -157,6 +157,7 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	enum efi_secureboot_mode secure_boot;
 	struct screen_info *si;
 	efi_properties_table_t *prop_tbl;
+	unsigned long max_addr;
 
 	sys_table = sys_table_arg;
 
@@ -255,11 +256,18 @@ unsigned long efi_entry(void *handle, efi_system_table_t *sys_table_arg,
 	if (!fdt_addr)
 		pr_efi("Generating empty DTB\n");
 
-	status = efi_load_initrd(image, ULONG_MAX,
-				 efi_get_max_initrd_addr(dram_base, *image_addr),
-				 &initrd_addr, &initrd_size);
+	max_addr = efi_get_max_initrd_addr(dram_base, *image_addr);
+	status = efi_load_initrd_devpath(&initrd_addr, &initrd_size, max_addr);
+	if (status == EFI_SUCCESS)
+		pr_efi("Loaded initrd from LINUX_EFI_INITRD_MEDIA_GUID device path\n");
+	else if (status == EFI_NOT_FOUND) {
+		status = efi_load_initrd(image, ULONG_MAX, max_addr,
+					 &initrd_addr, &initrd_size);
+		if (status == EFI_SUCCESS)
+			pr_efi("Loaded initrd from command line option\n");
+	}
 	if (status != EFI_SUCCESS)
-		pr_efi_err("Failed initrd from command line!\n");
+		pr_efi_err("Failed to load initrd!\n");
 
 	efi_random_get_seed();
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 8e60a39df3c5..eaf45ea749b3 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -323,3 +323,68 @@ void efi_char16_printk(efi_char16_t *str)
 	efi_call_proto(efi_table_attr(efi_system_table(), con_out),
 		       output_string, str);
 }
+
+static const struct {
+	struct efi_vendor_dev_path	vendor;
+	struct efi_generic_dev_path	end;
+} __packed initrd_devpath = {
+	{
+		EFI_DEV_MEDIA,
+		EFI_DEV_MEDIA_VENDOR,
+		sizeof(struct efi_vendor_dev_path),
+		LINUX_EFI_INITRD_MEDIA_GUID
+	}, {
+		EFI_DEV_END_PATH,
+		EFI_DEV_END_ENTIRE,
+		sizeof(struct efi_generic_dev_path)
+	}
+};
+
+efi_status_t efi_load_initrd_devpath(unsigned long *load_addr,
+				     unsigned long *load_size,
+				     unsigned long max)
+{
+	efi_guid_t lf2_proto_guid = EFI_LOAD_FILE2_PROTOCOL_GUID;
+	efi_device_path_protocol_t *dp;
+	efi_load_file2_protocol_t *lf2;
+	unsigned long initrd_addr;
+	unsigned long initrd_size;
+	efi_handle_t handle;
+	efi_status_t status;
+
+	if (!load_addr || !load_size)
+		return EFI_INVALID_PARAMETER;
+
+	dp = (efi_device_path_protocol_t *)&initrd_devpath;
+	status = efi_bs_call(locate_device_path, &lf2_proto_guid, &dp, &handle);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	status = efi_bs_call(handle_protocol, handle, &lf2_proto_guid,
+			     (void **)&lf2);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	initrd_size = 0;
+	status = efi_call_proto(lf2, load_file,
+				(efi_device_path_protocol_t *)&initrd_devpath,
+				false, &initrd_size, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return EFI_LOAD_ERROR;
+
+	status = efi_allocate_pages(initrd_size, &initrd_addr, max);
+	if (status != EFI_SUCCESS)
+		return status;
+
+	status = efi_call_proto(lf2, load_file,
+				(efi_device_path_protocol_t *)&initrd_devpath,
+				false, &initrd_size, (void *)initrd_addr);
+	if (status != EFI_SUCCESS) {
+		efi_free(initrd_size, initrd_addr);
+		return status;
+	}
+
+	*load_addr = initrd_addr;
+	*load_size = initrd_size;
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 99e93fd76ec5..fbf9f9442eed 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -566,6 +566,14 @@ union efi_load_file_protocol {
 	} mixed_mode;
 };
 
+struct efi_vendor_dev_path {
+	u8		type;
+	u8		sub_type;
+	u16		length;
+	efi_guid_t	vendorguid;
+	u8		vendordata[];
+} __packed;
+
 void efi_pci_disable_bridge_busmaster(void);
 
 typedef efi_status_t (*efi_exit_boot_map_processing)(
@@ -651,4 +659,8 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 			     unsigned long *load_addr,
 			     unsigned long *load_size);
 
+efi_status_t efi_load_initrd_devpath(unsigned long *load_addr,
+				     unsigned long *load_size,
+				     unsigned long max);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index f3e2ff31b624..7f38f95676dd 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -419,9 +419,20 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (status != EFI_SUCCESS)
 		goto fail2;
 
-	status = efi_load_initrd(image, hdr->initrd_addr_max,
-				 above4g ? ULONG_MAX : hdr->initrd_addr_max,
-				 &ramdisk_addr, &ramdisk_size);
+	/*
+	 * The initrd loaded from the Linux initrd vendor device
+	 * path should take precedence, as we don't want the
+	 * [unverified] command line to override the initrd
+	 * supplied by the [potentially verified] firmware.
+	 */
+	status = efi_load_initrd_devpath(&ramdisk_addr, &ramdisk_size,
+					 above4g ? ULONG_MAX
+						 : hdr->initrd_addr_max);
+	if (status == EFI_NOT_FOUND)
+		status = efi_load_initrd(image, hdr->initrd_addr_max,
+					 above4g ? ULONG_MAX
+						 : hdr->initrd_addr_max,
+					 &ramdisk_addr, &ramdisk_size);
 	if (status != EFI_SUCCESS)
 		goto fail2;
 	hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
@@ -732,6 +743,25 @@ struct boot_params *efi_main(efi_handle_t handle,
 			 ((u64)boot_params->ext_cmd_line_ptr << 32));
 	efi_parse_options((char *)cmdline_paddr);
 
+	if (!hdr->ramdisk_size && !boot_params->ext_ramdisk_size) {
+		unsigned long max = hdr->initrd_addr_max;
+		unsigned long addr, size;
+
+		if (hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G)
+			max = ULONG_MAX;
+
+		status = efi_load_initrd_devpath(&addr, &size, max);
+		if (status == EFI_SUCCESS) {
+			hdr->ramdisk_image		= (u32)addr;
+			hdr->ramdisk_size 		= (u32)size;
+			boot_params->ext_ramdisk_image	= (u64)addr >> 32;
+			boot_params->ext_ramdisk_size 	= (u64)size >> 32;
+		} else if (status != EFI_NOT_FOUND) {
+			efi_printk("efi_load_initrd_devpath() failed!\n");
+			goto fail;
+		}
+	}
+
 	/*
 	 * If the boot loader gave us a value for secure_boot then we use that,
 	 * otherwise we ask the BIOS.
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9ccf313fe9de..75c83c322c40 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -353,6 +353,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_TPM_EVENT_LOG_GUID		EFI_GUID(0xb7799cb0, 0xeca2, 0x4943,  0x96, 0x67, 0x1f, 0xae, 0x07, 0xb7, 0x47, 0xfa)
 #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
+#define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
-- 
2.17.1

