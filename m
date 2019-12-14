Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D22A211F33F
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 18:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLNR5z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 12:57:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNR5y (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 14 Dec 2019 12:57:54 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D45A92465B;
        Sat, 14 Dec 2019 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576346274;
        bh=Y8U6vZSTY5xgPKIL//n5JDGGzZAR2HBk04QzLvELJA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sosVgaA0JpCj7rsmSQqpKpKYuFltNT5h3hysqGGGvx2CU7ClC7qezfH2vYUzDOmBt
         rdzSQDrPPxsvscg14Gur90obNAfxOnXRD1fZ1bNiNNsRgxwyCJz6t7uN49nkGE+EOK
         Mn+rXkEDzFfXJUBN+pG8se7kCHzbUlg9XGy5J3IA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 05/10] efi/libstub: distinguish between native/mixed not 32/64 bit
Date:   Sat, 14 Dec 2019 18:57:30 +0100
Message-Id: <20191214175735.22518-6-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191214175735.22518-1-ardb@kernel.org>
References: <20191214175735.22518-1-ardb@kernel.org>
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
 arch/arm/include/asm/efi.h                     |  2 +-
 arch/arm64/include/asm/efi.h                   |  2 +-
 arch/x86/include/asm/efi.h                     | 31 +++++++++++----
 drivers/firmware/efi/libstub/efi-stub-helper.c | 41 +++++++-------------
 include/linux/efi.h                            | 10 ++---
 5 files changed, 44 insertions(+), 42 deletions(-)

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
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 6094e7f49a99..37364c43296e 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -222,21 +222,38 @@ static inline bool efi_is_64bit(void)
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
+#define efi_table_attr(table, attr, instance) ({			\
+	__typeof__(((table##_t *)0)->attr) __ret;			\
+	if (efi_is_native()) {						\
+		__ret = ((table##_t *)instance)->attr;			\
+	} else {							\
+		__typeof__(((table##_32_t *)0)->attr) at;		\
+		at = (((table##_32_t *)(unsigned long)instance)->attr);	\
+		__ret = (__typeof__(__ret))(unsigned long)at;		\
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
index 7e39f443ca30..ff3266b9f673 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -981,33 +981,20 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
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
index 735388ea7012..7d7ea32a9990 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -49,13 +49,11 @@ typedef u64 efi_physical_addr_t;
 typedef void *efi_handle_t;
 
 #define for_each_efi_handle(handle, array, size, i)			\
-	for (i = 1, handle = efi_is_64bit()				\
-		? (efi_handle_t)(unsigned long)((u64 *)(array))[0]	\
+	for (i = 1, handle = efi_is_native() ? (array)[0]		\
 		: (efi_handle_t)(unsigned long)((u32 *)(array))[0];	\
-	    i++ <= (size) / (efi_is_64bit() ? sizeof(efi_handle_t)	\
+	    i++ <= (size) / (efi_is_native() ? sizeof(efi_handle_t)	\
 					     : sizeof(u32));		\
-	    handle = efi_is_64bit()					\
-		? (efi_handle_t)(unsigned long)((u64 *)(array))[i]	\
+	    handle = efi_is_native() ? (array)[i]			\
 		: (efi_handle_t)(unsigned long)((u32 *)(array))[i])
 
 /*
@@ -753,7 +751,7 @@ typedef struct {
 
 typedef struct {
 	efi_guid_t guid;
-	unsigned long table;
+	void *table;
 } efi_config_table_t;
 
 typedef struct {
-- 
2.17.1

