Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4112A2D9
	for <lists+linux-efi@lfdr.de>; Tue, 24 Dec 2019 16:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfLXPLB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Dec 2019 10:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfLXPLA (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Dec 2019 10:11:00 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-6.w90-88.abo.wanadoo.fr [90.88.129.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27232077B;
        Tue, 24 Dec 2019 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577200259;
        bh=01J+UFJQPmzYegscI8xCiv9UII4FidnRVcQ3vxllDlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYv0khgJAuIA7cJdPQcBClObBWFKosbnFFIAEMnPPivEOsGdrjg3UFx4qFQUnRMj6
         T0W9YPjcOV9NLTs8Jzv66u9wQWoQ+c7Yvo65l23dEOVFwXzM49yF48XIstazv7plXB
         1TasP1FEPylFsVNbK5oyUFDN4WAsfa2lAW3ULxtg=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 09/25] efi/libstub: distinguish between native/mixed not 32/64 bit
Date:   Tue, 24 Dec 2019 16:10:09 +0100
Message-Id: <20191224151025.32482-10-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224151025.32482-1-ardb@kernel.org>
References: <20191224151025.32482-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, we support mixed mode by casting all boot time firmware
calls to 64-bit explicitly on native 64-bit systems, and to 32-bit
on 32-bit systems or 64-bit systems running with 32-bit firmware.

Due to this explicit awareness of the bitness in the code, we do a
lot of casting even on generic code that is shared with other
architectures, where mixed mode does not even exist. This casting
leads to loss of coverage of type checking by the compiler, which
we should try to avoid.

So instead of distinguishing between 32-bit vs 64-bit, distinguish
between native vs mixed, and limit all the nasty casting and
pointer mangling to the code that actually deals with mixed mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h                    |  2 +-
 arch/arm64/include/asm/efi.h                  |  2 +-
 arch/x86/boot/compressed/eboot.c              |  3 +-
 arch/x86/include/asm/efi.h                    | 35 ++++++++++++---
 .../firmware/efi/libstub/efi-stub-helper.c    | 45 +++++++------------
 include/linux/efi.h                           |  6 +--
 6 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 2306ed783ceb..9b0c64c28bff 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -52,7 +52,7 @@ void efi_virtmap_unload(void);
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
-#define efi_is_64bit()			(false)
+#define efi_is_native()			(true)
 
 #define efi_table_attr(table, attr, instance)				\
 	((table##_t *)instance)->attr
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7cfac5e0e310..189082c44c28 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -95,7 +95,7 @@ static inline unsigned long efi_get_max_initrd_addr(unsigned long dram_base,
 
 #define efi_call_early(f, ...)		sys_table_arg->boottime->f(__VA_ARGS__)
 #define efi_call_runtime(f, ...)	sys_table_arg->runtime->f(__VA_ARGS__)
-#define efi_is_64bit()			(true)
+#define efi_is_native()			(true)
 
 #define efi_table_attr(table, attr, instance)				\
 	((table##_t *)instance)->attr
diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index 959bcdd8c1fe..990b93379965 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -63,8 +63,7 @@ preserve_pci_rom_image(efi_pci_io_protocol_t *pci, struct pci_setup_rom **__rom)
 	 * large romsize. The UEFI spec limits the size of option ROMs to 16
 	 * MiB so we reject any ROMs over 16 MiB in size to catch this.
 	 */
-	romimage = (void *)(unsigned long)efi_table_attr(efi_pci_io_protocol,
-							 romimage, pci);
+	romimage = efi_table_attr(efi_pci_io_protocol, romimage, pci);
 	romsize = efi_table_attr(efi_pci_io_protocol, romsize, pci);
 	if (!romimage || !romsize || romsize > SZ_16M)
 		return EFI_INVALID_PARAMETER;
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 6094e7f49a99..c27323cb49e5 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -222,21 +222,42 @@ static inline bool efi_is_64bit(void)
 	return __efi_early()->is64;
 }
 
-#define efi_table_attr(table, attr, instance)				\
-	(efi_is_64bit() ?						\
-		((table##_64_t *)(unsigned long)instance)->attr :	\
-		((table##_32_t *)(unsigned long)instance)->attr)
+static inline bool efi_is_native(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return true;
+	return efi_is_64bit();
+}
+
+#define efi_mixed_mode_cast(attr)					\
+	__builtin_choose_expr(						\
+		__builtin_types_compatible_p(u32, __typeof__(attr)),	\
+			(unsigned long)(attr), (attr))
+
+#define efi_table_attr(table, attr, instance) ({			\
+	__typeof__(((table##_t *)0)->attr) __ret;			\
+	if (efi_is_native()) {						\
+		__ret = ((table##_t *)(unsigned long)instance)->attr;	\
+	} else {							\
+		__ret = (__typeof__(__ret))efi_mixed_mode_cast(		\
+		((table##_t *)(unsigned long)instance)->mixed_mode.attr);\
+	}								\
+	__ret;								\
+})
 
 #define efi_call_proto(protocol, f, instance, ...)			\
-	__efi_early()->call(efi_table_attr(protocol, f, instance),	\
+	__efi_early()->call((unsigned long)				\
+				efi_table_attr(protocol, f, instance),	\
 		instance, ##__VA_ARGS__)
 
 #define efi_call_early(f, ...)						\
-	__efi_early()->call(efi_table_attr(efi_boot_services, f,	\
+	__efi_early()->call((unsigned long)				\
+				efi_table_attr(efi_boot_services, f,	\
 		__efi_early()->boot_services), __VA_ARGS__)
 
 #define efi_call_runtime(f, ...)					\
-	__efi_early()->call(efi_table_attr(efi_runtime_services, f,	\
+	__efi_early()->call((unsigned long)				\
+				efi_table_attr(efi_runtime_services, f,	\
 		__efi_early()->runtime_services), __VA_ARGS__)
 
 extern bool efi_reboot_required(void);
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index e02579907f2e..1a814dc235ba 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -431,9 +431,7 @@ static efi_status_t efi_open_volume(efi_system_table_t *sys_table_arg,
 	efi_file_handle_t *fh;
 	efi_guid_t fs_proto = EFI_FILE_SYSTEM_GUID;
 	efi_status_t status;
-	void *handle = (void *)(unsigned long)efi_table_attr(efi_loaded_image,
-							     device_handle,
-							     image);
+	void *handle = efi_table_attr(efi_loaded_image, device_handle, image);
 
 	status = efi_call_early(handle_protocol, handle,
 				&fs_proto, (void **)&io);
@@ -942,33 +940,20 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
-#define GET_EFI_CONFIG_TABLE(bits)					\
-static void *get_efi_config_table##bits(efi_system_table_t *_sys_table,	\
-					efi_guid_t guid)		\
-{									\
-	efi_system_table_##bits##_t *sys_table;				\
-	efi_config_table_##bits##_t *tables;				\
-	int i;								\
-									\
-	sys_table = (typeof(sys_table))_sys_table;			\
-	tables = (typeof(tables))(unsigned long)sys_table->tables;	\
-									\
-	for (i = 0; i < sys_table->nr_tables; i++) {			\
-		if (efi_guidcmp(tables[i].guid, guid) != 0)		\
-			continue;					\
-									\
-		return (void *)(unsigned long)tables[i].table;		\
-	}								\
-									\
-	return NULL;							\
-}
-GET_EFI_CONFIG_TABLE(32)
-GET_EFI_CONFIG_TABLE(64)
-
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 {
-	if (efi_is_64bit())
-		return get_efi_config_table64(sys_table, guid);
-	else
-		return get_efi_config_table32(sys_table, guid);
+	unsigned long tables = efi_table_attr(efi_system_table, tables, sys_table);
+	int nr_tables = efi_table_attr(efi_system_table, nr_tables, sys_table);
+	int i;
+
+	for (i = 0; i < nr_tables; i++) {
+		efi_config_table_t *t = (void *)tables;
+
+		if (efi_guidcmp(t->guid, guid) == 0)
+			return efi_table_attr(efi_config_table, table, t);
+
+		tables += efi_is_native() ? sizeof(efi_config_table_t)
+					  : sizeof(efi_config_table_32_t);
+	}
+	return NULL;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 5a220af263b1..e9d74e9667c0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -49,11 +49,11 @@ typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
 #define efi_get_handle_at(array, idx)					\
-	(efi_is_64bit() ? (efi_handle_t)(unsigned long)((u64 *)(array))[idx] \
+	(efi_is_native() ? (array)[idx] 				\
 		: (efi_handle_t)(unsigned long)((u32 *)(array))[idx])
 
 #define efi_get_handle_num(size)					\
-	((size) / (efi_is_64bit() ? sizeof(u64) : sizeof(u32)))
+	((size) / (efi_is_native() ? sizeof(efi_handle_t) : sizeof(u32)))
 
 #define for_each_efi_handle(handle, array, size, i)			\
 	for (i = 0;							\
@@ -805,7 +805,7 @@ typedef struct {
 typedef union {
 	struct {
 		efi_guid_t guid;
-		unsigned long table;
+		void *table;
 	};
 	efi_config_table_32_t mixed_mode;
 } efi_config_table_t;
-- 
2.20.1

