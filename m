Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2C752F40C
	for <lists+linux-efi@lfdr.de>; Fri, 20 May 2022 21:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353316AbiETTwf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 May 2022 15:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353342AbiETTwd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 May 2022 15:52:33 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841519C38A;
        Fri, 20 May 2022 12:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sN/LpPLdT2mbsP7DF3PDcCREB6oSMVQAq5zqlYlmSbg=; b=jkPDL8A4W/pvGUu0xaZAVxejzh
        rwNPL/9VrA1vhD5VyCfsIbOG+DQhTNF8A90elI7Qkp0XkK9VmorpU7gxvAnHbQKjcGIfrklkj5zEl
        ID7zK9z4VhTn/P+dbjGNQZaSrsE2l1M2cZG7iaCCc/cGjWpmdEdN2Gkr8hroisd1vaIpuMRPH+blg
        QJfkh6mQu71Il4vr7Ydq8HgS6gs0qQ1YNUMgnMXWZ1IPbg/YVlz5yB5a5Yhnhl9G2cDWaDr18kE7q
        KSQ9vE5/5BQO2DUbeIQ1uUKfD+1nrSUWYL9cq1Ujyb80oOCd7IdS6ipvqEjT0yLqWOiDGd8doERdy
        Hcf8QoQg==;
Received: from 200-161-159-120.dsl.telesp.net.br ([200.161.159.120] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1ns8fm-00D3rs-3e; Fri, 20 May 2022 21:52:30 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        matthew.garrett@nebula.com, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 2/2] efi-panic: Introduce the UEFI panic notification module
Date:   Fri, 20 May 2022 16:50:28 -0300
Message-Id: <20220520195028.1347426-3-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520195028.1347426-1-gpiccoli@igalia.com>
References: <20220520195028.1347426-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Despite we have pstore, kdump and other panic-time  mechanisms,
there's no generic way to let the firmware know a panic event
happened. Some hypervisors might have special code for that, but
that's not generic.

The UEFI panic notification module hereby proposed aims to fill
this need: once we face a panic, through the panic notifier
infrastructure we set a UEFI variable named PanicWarn with a
value - default is 0xFF, but it's adjustable via module parameter.
The firmware is then enabled to take a proper action.

The module also let the users know that last execution likely
panicked if the UEFI variable is present on module load - then
it clears that to avoid confusing users, only the last panic
event is recorded.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 drivers/firmware/efi/Kconfig     | 10 ++++
 drivers/firmware/efi/Makefile    |  1 +
 drivers/firmware/efi/efi-panic.c | 97 ++++++++++++++++++++++++++++++++
 include/linux/efi.h              |  1 +
 4 files changed, 109 insertions(+)
 create mode 100644 drivers/firmware/efi/efi-panic.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 2c3dac5ecb36..12f2d963333e 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -145,6 +145,16 @@ config EFI_BOOTLOADER_CONTROL
 	  bootloader reads this reboot reason and takes particular
 	  action according to its policy.
 
+config EFI_PANIC_NOTIFIER
+	tristate "UEFI Panic Notifier"
+	depends on EFI
+	default n
+	help
+	  With this module, kernel creates the UEFI variable "PanicWarn" if
+	  the system faces a panic event. With that, the firmware is entitled
+	  to take an action if the last kernel panicked; it also shows a
+	  message during boot time if last run faced a panic event.
+
 config EFI_CAPSULE_LOADER
 	tristate "EFI capsule loader"
 	depends on EFI && !IA64
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index c02ff25dd477..abbc7d9af2da 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
 obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
+obj-$(CONFIG_EFI_PANIC_NOTIFIER)	+= efi-panic.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
diff --git a/drivers/firmware/efi/efi-panic.c b/drivers/firmware/efi/efi-panic.c
new file mode 100644
index 000000000000..c59655e22fc7
--- /dev/null
+++ b/drivers/firmware/efi/efi-panic.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * efi-panic: UEFI panic notification mechanism
+ */
+
+#define pr_fmt(fmt) "efi-panic: " fmt
+
+#include <linux/efi.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/panic_notifier.h>
+
+#define EFI_PANIC_ATTR		(EFI_VARIABLE_NON_VOLATILE |\
+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |\
+				 EFI_VARIABLE_RUNTIME_ACCESS)
+
+#define EFI_DATA_SIZE		(2 * sizeof(efi_char16_t))
+
+static struct efivar_entry *entry;
+
+static u8 panic_warn_val = 0xFF;
+module_param(panic_warn_val, byte, 0644);
+MODULE_PARM_DESC(panic_warn_val,
+		 "Value written to PanicWarn efivar on panic event [default=0xFF]");
+
+static int efi_panic_cb(struct notifier_block *nb, unsigned long ev,
+			void *unused)
+{
+	int ret;
+
+	efi_str8_to_str16((efi_char16_t *)entry->var.Data, &panic_warn_val, 1);
+	ret = efivar_entry_set_safe(entry->var.VariableName,
+				    entry->var.VendorGuid,
+				    EFI_PANIC_ATTR, false, EFI_DATA_SIZE,
+				    entry->var.Data);
+	if (ret)
+		pr_err("failed to notify panic to UEFI\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block efi_panic_notifier = {
+	.notifier_call = efi_panic_cb,
+};
+
+static int __init efi_panic_init(void)
+{
+	efi_guid_t guid = LINUX_EFI_PANIC_WARN_GUID;
+	unsigned long sz = EFI_DATA_SIZE;
+	const char *name = "PanicWarn";
+	u8 data[EFI_DATA_SIZE];
+	int err;
+
+	if (!efivars_kobject() || !efivar_supports_writes()) {
+		pr_err("UEFI vars not available (or not writable)\n");
+		return -ENODEV;
+	}
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(&entry->var.VendorGuid, &guid, sizeof(guid));
+	efi_str8_to_str16(entry->var.VariableName, name, strlen(name));
+
+	err = efivar_entry_get(entry, NULL, &sz, (void *)data);
+
+	if (!err) {
+		pr_info("previous kernel (likely) had a panic\n");
+
+		if (__efivar_entry_delete(entry))
+			pr_err("cannot delete %s UEFI variable\n", name);
+
+		memset(entry->var.Data, 0, EFI_DATA_SIZE);
+	} else {
+		if (err != -ENOENT)
+			pr_err("can't read the UEFI variables (err=%d)\n", err);
+	}
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &efi_panic_notifier);
+
+	return 0;
+}
+module_init(efi_panic_init);
+
+static void __exit efi_panic_exit(void)
+{
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &efi_panic_notifier);
+	kfree(entry);
+}
+module_exit(efi_panic_exit);
+
+MODULE_AUTHOR("Guilherme G. Piccoli <gpiccoli@igalia.com>");
+MODULE_DESCRIPTION("UEFI Panic Notification Mechanism");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 066ebc5bcb2a..4219f3d44183 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -365,6 +365,7 @@ void efi_native_runtime_setup(void);
 #define EFI_GLOBAL_VARIABLE_GUID		EFI_GUID(0x8be4df61, 0x93ca, 0x11d2,  0xaa, 0x0d, 0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
 #define UV_SYSTEM_TABLE_GUID			EFI_GUID(0x3b13a7d4, 0x633e, 0x11dd,  0x93, 0xec, 0xda, 0x25, 0x56, 0xd8, 0x95, 0x93)
 #define LINUX_EFI_CRASH_GUID			EFI_GUID(0xcfc8fc79, 0xbe2e, 0x4ddc,  0x97, 0xf0, 0x9f, 0x98, 0xbf, 0xe2, 0x98, 0xa0)
+#define LINUX_EFI_PANIC_WARN_GUID		EFI_GUID(0x9e85b665, 0x08d4, 0x42c9,  0x83, 0x24, 0x47, 0xed, 0x5f, 0xe5, 0x0b, 0xf3)
 #define LOADED_IMAGE_PROTOCOL_GUID		EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID	EFI_GUID(0x9042a9de, 0x23dc, 0x4a38,  0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a)
 #define EFI_UGA_PROTOCOL_GUID			EFI_GUID(0x982c298b, 0xf4fa, 0x41cb,  0xb8, 0x38, 0x77, 0xaa, 0x68, 0x8f, 0xb8, 0x39)
-- 
2.36.0

