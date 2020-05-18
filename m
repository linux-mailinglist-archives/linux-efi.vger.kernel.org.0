Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81241D87E9
	for <lists+linux-efi@lfdr.de>; Mon, 18 May 2020 21:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgERTHh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 18 May 2020 15:07:37 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37383 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgERTHe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 18 May 2020 15:07:34 -0400
Received: by mail-qt1-f194.google.com with SMTP id 4so9073800qtb.4
        for <linux-efi@vger.kernel.org>; Mon, 18 May 2020 12:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jjsRn5Ic2cl9ALC9ehOJo16WqzTbbWnMwVP2PnkDiRg=;
        b=Q+42BJJWC29ewy0u3ptdBd80UB2V7Td9hpYjN1174I8hu7M9VY6ywRtqzsp0z9nCKU
         kVi3pA5+nyaulPjyckxSdix9JIUe+6ftFfoaoY9363YABkgH+CXc5Vp0RUEai0MwvF3B
         gaXyek7Zw/7J+RQJQBK9xzgPyDtrx2J5GgKcJRxKWoyVLsoN2oZXDnKMPgx0tkFnXVgx
         8u8xQFwG/brK4rEfFK5qOoBsP28vLXaC684q7hjF7Ntd+yj0IdhEDAoqDmsA9oFDvAGr
         BiwVQmU8Lg8QuxjZwrrH1+4RNlB5T1VQ4F3OqgGqM35zR6/f0+G5B1NmMHAAb8i2EU8b
         9N7A==
X-Gm-Message-State: AOAM532bIgQjTPsAGU3fmh1XWmYWTfGROBv/6LRipiB9avvS8K8bpOUt
        F/jOdmJ4oazudYbQEURW8Nz8tdR8YaM=
X-Google-Smtp-Source: ABdhPJwMNCpxkEpSViPxJNPQC8H6W2RnL7l7ZPgX4Y0IX4gfRud/P3YGxng6lizXGd5mKi2kUQK2yw==
X-Received: by 2002:aed:3ff7:: with SMTP id w52mr18490896qth.148.1589828851619;
        Mon, 18 May 2020 12:07:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a1sm9862811qtj.65.2020.05.18.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 12:07:31 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: [PATCH 18/24] efi/libstub: Add definitions for console input and events
Date:   Mon, 18 May 2020 15:07:10 -0400
Message-Id: <20200518190716.751506-19-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518190716.751506-1-nivedita@alum.mit.edu>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Add the required typedefs etc for using con_in's simple text input
protocol, and for using the boottime event services.

Also add the prototype for the "stall" boot service.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/efi.h             | 10 ++++
 arch/x86/xen/efi.c                     |  2 +-
 drivers/firmware/efi/libstub/efistub.h | 77 ++++++++++++++++++++++++--
 include/linux/efi.h                    |  3 +-
 4 files changed, 85 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 6b9ab0d8b2a7..89dcc7aa7e2c 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -9,6 +9,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/mmu_context.h>
 #include <linux/build_bug.h>
+#include <linux/kernel.h>
 
 extern unsigned long efi_fw_vendor, efi_config_table;
 
@@ -293,6 +294,15 @@ static inline u32 efi64_convert_status(efi_status_t status)
 #define __efi64_argmap_allocate_pool(type, size, buffer)		\
 	((type), (size), efi64_zero_upper(buffer))
 
+#define __efi64_argmap_create_event(type, tpl, f, c, event)		\
+	((type), (tpl), (f), (c), efi64_zero_upper(event))
+
+#define __efi64_argmap_set_timer(event, type, time)			\
+	((event), (type), lower_32_bits(time), upper_32_bits(time))
+
+#define __efi64_argmap_wait_for_event(num, event, index)		\
+	((num), (event), efi64_zero_upper(index))
+
 #define __efi64_argmap_handle_protocol(handle, protocol, interface)	\
 	((handle), (protocol), efi64_zero_upper(interface))
 
diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 1abe455d926a..205a9bc981b0 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -29,7 +29,7 @@ static efi_system_table_t efi_systab_xen __initdata = {
 	.fw_vendor	= EFI_INVALID_TABLE_ADDR, /* Initialized later. */
 	.fw_revision	= 0,			  /* Initialized later. */
 	.con_in_handle	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
-	.con_in		= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
+	.con_in		= NULL,			  /* Not used under Xen. */
 	.con_out_handle	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
 	.con_out	= NULL, 		  /* Not used under Xen. */
 	.stderr_handle	= EFI_INVALID_TABLE_ADDR, /* Not used under Xen. */
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 3a323a009836..c7c03099367f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -111,6 +111,16 @@ void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
 #define EFI_LOCATE_BY_REGISTER_NOTIFY		1
 #define EFI_LOCATE_BY_PROTOCOL			2
 
+/*
+ * boottime->stall takes the time period in microseconds
+ */
+#define EFI_USEC_PER_SEC		1000000
+
+/*
+ * boottime->set_timer takes the time in 100ns units
+ */
+#define EFI_100NSEC_PER_USEC	((u64)10)
+
 struct efi_boot_memmap {
 	efi_memory_desc_t	**map;
 	unsigned long		*map_size;
@@ -122,6 +132,39 @@ struct efi_boot_memmap {
 
 typedef struct efi_generic_dev_path efi_device_path_protocol_t;
 
+typedef void *efi_event_t;
+/* Note that notifications won't work in mixed mode */
+typedef void (__efiapi *efi_event_notify_t)(efi_event_t, void *);
+
+#define EFI_EVT_TIMER		0x80000000U
+#define EFI_EVT_RUNTIME		0x40000000U
+#define EFI_EVT_NOTIFY_WAIT	0x00000100U
+#define EFI_EVT_NOTIFY_SIGNAL	0x00000200U
+
+/*
+ * boottime->wait_for_event takes an array of events as input.
+ * Provide a helper to set it up correctly for mixed mode.
+ */
+static inline
+void efi_set_event_at(efi_event_t *events, size_t idx, efi_event_t event)
+{
+	if (efi_is_native())
+		events[idx] = event;
+	else
+		((u32 *)events)[idx] = (u32)(unsigned long)event;
+}
+
+#define EFI_TPL_APPLICATION	4
+#define EFI_TPL_CALLBACK	8
+#define EFI_TPL_NOTIFY		16
+#define EFI_TPL_HIGH_LEVEL	31
+
+typedef enum {
+	EfiTimerCancel,
+	EfiTimerPeriodic,
+	EfiTimerRelative
+} EFI_TIMER_DELAY;
+
 /*
  * EFI Boot Services table
  */
@@ -140,11 +183,16 @@ union efi_boot_services {
 		efi_status_t (__efiapi *allocate_pool)(int, unsigned long,
 						       void **);
 		efi_status_t (__efiapi *free_pool)(void *);
-		void *create_event;
-		void *set_timer;
-		void *wait_for_event;
+		efi_status_t (__efiapi *create_event)(u32, unsigned long,
+						      efi_event_notify_t, void *,
+						      efi_event_t *);
+		efi_status_t (__efiapi *set_timer)(efi_event_t,
+						  EFI_TIMER_DELAY, u64);
+		efi_status_t (__efiapi *wait_for_event)(unsigned long,
+							efi_event_t *,
+							unsigned long *);
 		void *signal_event;
-		void *close_event;
+		efi_status_t (__efiapi *close_event)(efi_event_t);
 		void *check_event;
 		void *install_protocol_interface;
 		void *reinstall_protocol_interface;
@@ -171,7 +219,7 @@ union efi_boot_services {
 		efi_status_t (__efiapi *exit_boot_services)(efi_handle_t,
 							    unsigned long);
 		void *get_next_monotonic_count;
-		void *stall;
+		efi_status_t (__efiapi *stall)(unsigned long);
 		void *set_watchdog_timer;
 		void *connect_controller;
 		efi_status_t (__efiapi *disconnect_controller)(efi_handle_t,
@@ -256,6 +304,25 @@ union efi_uga_draw_protocol {
 	} mixed_mode;
 };
 
+typedef struct {
+	u16 scan_code;
+	efi_char16_t unicode_char;
+} efi_input_key_t;
+
+union efi_simple_text_input_protocol {
+	struct {
+		void *reset;
+		efi_status_t (__efiapi *read_keystroke)(efi_simple_text_input_protocol_t *,
+							efi_input_key_t *);
+		efi_event_t wait_for_key;
+	};
+	struct {
+		u32 reset;
+		u32 read_keystroke;
+		u32 wait_for_key;
+	} mixed_mode;
+};
+
 union efi_simple_text_output_protocol {
 	struct {
 		void *reset;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 9b7c7ec319ac..974648db0c68 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -426,6 +426,7 @@ typedef struct {
 	u32 tables;
 } efi_system_table_32_t;
 
+typedef union efi_simple_text_input_protocol efi_simple_text_input_protocol_t;
 typedef union efi_simple_text_output_protocol efi_simple_text_output_protocol_t;
 
 typedef union {
@@ -434,7 +435,7 @@ typedef union {
 		unsigned long fw_vendor;	/* physical addr of CHAR16 vendor string */
 		u32 fw_revision;
 		unsigned long con_in_handle;
-		unsigned long con_in;
+		efi_simple_text_input_protocol_t *con_in;
 		unsigned long con_out_handle;
 		efi_simple_text_output_protocol_t *con_out;
 		unsigned long stderr_handle;
-- 
2.26.2

