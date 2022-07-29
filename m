Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690195855B7
	for <lists+linux-efi@lfdr.de>; Fri, 29 Jul 2022 21:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiG2Tsq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 29 Jul 2022 15:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237998AbiG2Tsp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 29 Jul 2022 15:48:45 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915E88E0B;
        Fri, 29 Jul 2022 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IIBd4JO9tjHfeGjjy6pkVi9dYz0wqG2cJ6lj/g2SiG4=; b=I2VaxXyS7tS1t2SfreP/xJuVJj
        JxJEHs03tnPSZE1E95bh2aCH+zc9XrgSn0MEeImpRw8+c6+JcTShDDQG2roisqt++Syksty+QD3/E
        KQ6SWESD2WgE0c+BYj3u1RJgD6i+E6i9I695AZNGeuj6l0rNw5+BbPyUDgLpdyPVtrEuUrjiKW5Jp
        EHdgPfijK76ETsB5nmACeG+wPVHIwK7wmN/R4G6OEQEESJtYwxbRMEiAB22AHLp67SgtbbuR8Gs+A
        /BePOTUv7QVLBZ1EAcSXzblhhldizDiMNUFCFUJRvE13nRDabzp+dJ1+dix6/KrkFjMJZQHRz7W5B
        4DYpcLew==;
Received: from [177.83.209.223] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oHVyS-00BML8-D5; Fri, 29 Jul 2022 21:48:42 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     ardb@kernel.org, linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        keescook@chromium.org, matt@codeblueprint.co.uk,
        mjg59@srcf.ucam.org, tony.luck@intel.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v2 3/3] efi-panic: Introduce the UEFI panic notification mechanism
Date:   Fri, 29 Jul 2022 16:45:32 -0300
Message-Id: <20220729194532.228403-4-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729194532.228403-1-gpiccoli@igalia.com>
References: <20220729194532.228403-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Despite we have pstore, kdump and other panic-time mechanisms,
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
 drivers/firmware/efi/efi-panic.c | 89 ++++++++++++++++++++++++++++++++
 include/linux/efi.h              |  1 +
 4 files changed, 101 insertions(+)
 create mode 100644 drivers/firmware/efi/efi-panic.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 6cb7384ad2ac..f1ed6128d623 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -147,6 +147,16 @@ config EFI_BOOTLOADER_CONTROL
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
index 8d151e332584..c7cf3dcb284e 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_EFI_RUNTIME_WRAPPERS)	+= runtime-wrappers.o
 subdir-$(CONFIG_EFI_STUB)		+= libstub
 obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_map.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
+obj-$(CONFIG_EFI_PANIC_NOTIFIER)	+= efi-panic.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
diff --git a/drivers/firmware/efi/efi-panic.c b/drivers/firmware/efi/efi-panic.c
new file mode 100644
index 000000000000..02ffa4930039
--- /dev/null
+++ b/drivers/firmware/efi/efi-panic.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * efi-panic: UEFI panic notification mechanism
+ */
+
+#define pr_fmt(fmt) "efi-panic: " fmt
+
+#include <linux/efi.h>
+#include <linux/module.h>
+#include <linux/panic_notifier.h>
+
+#define EFI_PANIC_ATTR		(EFI_VARIABLE_NON_VOLATILE |\
+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |\
+				 EFI_VARIABLE_RUNTIME_ACCESS)
+
+#define EFI_DATA_SIZE		(2 * sizeof(efi_char16_t))
+
+static efi_char16_t *panic_warn_name = L"PanicWarn";
+
+static u8 panic_warn_val = 0xFF;
+module_param(panic_warn_val, byte, 0644);
+MODULE_PARM_DESC(panic_warn_val,
+		 "Value written to PanicWarn efivar on panic event [default=0xFF]");
+
+static int efi_panic_cb(struct notifier_block *nb, unsigned long ev,
+			void *unused)
+{
+	efi_char16_t val[2];
+	efi_status_t ret;
+
+	efi_str8_to_str16(val, &panic_warn_val, 1);
+	ret = efi.set_variable_nonblocking(panic_warn_name,
+					      &LINUX_EFI_PANIC_WARN_GUID,
+					      EFI_PANIC_ATTR, EFI_DATA_SIZE,
+					      val);
+
+	if (ret != EFI_SUCCESS)
+		pr_err("failed notifying UEFI about the panic (0x%lx)\n", ret);
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
+	unsigned long sz = EFI_DATA_SIZE;
+	u8 data[EFI_DATA_SIZE];
+	efi_status_t ret;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
+		return -ENODEV;
+
+	ret = efi.get_variable(panic_warn_name, &LINUX_EFI_PANIC_WARN_GUID,
+			       NULL, &sz, data);
+
+	if (ret == EFI_SUCCESS) {
+		pr_info("previous kernel (likely) had a panic\n");
+
+		ret = efi.set_variable(panic_warn_name,
+				       &LINUX_EFI_PANIC_WARN_GUID,
+				       EFI_PANIC_ATTR, 0, NULL);
+		if (ret != EFI_SUCCESS)
+			pr_warn("cannot delete the UEFI variable\n");
+
+	} else {
+		if (ret != EFI_NOT_FOUND)
+			pr_err("can't read the UEFI variable (err=%lx)\n", ret);
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
+}
+module_exit(efi_panic_exit);
+
+MODULE_AUTHOR("Guilherme G. Piccoli <gpiccoli@igalia.com>");
+MODULE_DESCRIPTION("UEFI Panic Notification Mechanism");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/efi.h b/include/linux/efi.h
index c0ea01be3772..38a5056cc72a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -367,6 +367,7 @@ void efi_native_runtime_setup(void);
 #define EFI_GLOBAL_VARIABLE_GUID		EFI_GUID(0x8be4df61, 0x93ca, 0x11d2,  0xaa, 0x0d, 0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
 #define UV_SYSTEM_TABLE_GUID			EFI_GUID(0x3b13a7d4, 0x633e, 0x11dd,  0x93, 0xec, 0xda, 0x25, 0x56, 0xd8, 0x95, 0x93)
 #define LINUX_EFI_CRASH_GUID			EFI_GUID(0xcfc8fc79, 0xbe2e, 0x4ddc,  0x97, 0xf0, 0x9f, 0x98, 0xbf, 0xe2, 0x98, 0xa0)
+#define LINUX_EFI_PANIC_WARN_GUID		EFI_GUID(0x9e85b665, 0x08d4, 0x42c9,  0x83, 0x24, 0x47, 0xed, 0x5f, 0xe5, 0x0b, 0xf3)
 #define LOADED_IMAGE_PROTOCOL_GUID		EFI_GUID(0x5b1b31a1, 0x9562, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_GRAPHICS_OUTPUT_PROTOCOL_GUID	EFI_GUID(0x9042a9de, 0x23dc, 0x4a38,  0x96, 0xfb, 0x7a, 0xde, 0xd0, 0x80, 0x51, 0x6a)
 #define EFI_UGA_PROTOCOL_GUID			EFI_GUID(0x982c298b, 0xf4fa, 0x41cb,  0xb8, 0x38, 0x77, 0xaa, 0x68, 0x8f, 0xb8, 0x39)
-- 
2.37.1

