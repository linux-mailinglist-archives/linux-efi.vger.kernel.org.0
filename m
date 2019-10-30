Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907BCE9D4F
	for <lists+linux-efi@lfdr.de>; Wed, 30 Oct 2019 15:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfJ3OSR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 30 Oct 2019 10:18:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54266 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfJ3OSR (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 30 Oct 2019 10:18:17 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D611781F18
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 14:18:15 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id m189so2189590qkc.7
        for <linux-efi@vger.kernel.org>; Wed, 30 Oct 2019 07:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rc+hqg4QNM/xF/NXGDnBB3/7yn+0eIIBqMg6gfG1Ddk=;
        b=ThURYlr5mBsgHAOvIhxFYoPQJlFgkPDQUE/SLdmWM3vaBO61Z9Vw9E6S8hJh3BhfZ3
         KhbsuvZk5z5IojuiuJTHM+BXZH8/4OxQpKSoSJ7w5t79pPoz1n/WOnUAlvxGss5102yT
         w3OeXiP7wdpftN6vLOSl/FEc0DQu9Rl15/iDOQ1TrW7+6ztli0p4b+TLGOZL/fDlRDWL
         IQpFK5safWCPRdXfJbIGCR87/1e8tITbezUFZ/YQhykiFkDMvHbz3B90Uih17IFIHOnH
         8aOh978LNQiuzKumAItn2uWTEQEIip0wKwGKek23/xjAMNRDIcGmpoaQSpgAskatyz6V
         ujxA==
X-Gm-Message-State: APjAAAXwypsP+2nK3tNMCPLNChpKvEW64P0pWGkOy3Ju1w+dP5ueONYr
        a3j3JYuCTx7Phayf9+PFmKvPKTnbKyjjYrF1iSUiNK+ZbTgu/6sM34ykmN1G4TJHMh4vazoujgI
        TH1d5Bj0BdNw3VMzxihkS
X-Received: by 2002:a05:620a:1038:: with SMTP id a24mr99450qkk.384.1572445094982;
        Wed, 30 Oct 2019 07:18:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydPWle3pBnSBlNZtoDCpwa6qFtvVveymN7IvYOkvPp9QSHZ3mTgHr1EmQxsD6FYr+vILeB2Q==
X-Received: by 2002:a05:620a:1038:: with SMTP id a24mr99416qkk.384.1572445094620;
        Wed, 30 Oct 2019 07:18:14 -0700 (PDT)
Received: from builder.jcline.org.com ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id s123sm112317qke.31.2019.10.30.07.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 07:18:14 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     rhkernel-list@redhat.com
Cc:     Laura Abbott <labbott@redhat.com>, Don Zickus <dzickus@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Philipp Rudo <prudo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [ARK INTERNAL PATCHv2 2/5] efi: Add an EFI_SECURE_BOOT flag to indicate secure boot mode
Date:   Wed, 30 Oct 2019 14:17:14 +0000
Message-Id: <20191030141717.3134-3-jcline@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191030141717.3134-1-jcline@redhat.com>
References: <20191007190042.17934-1-jcline@redhat.com>
 <20191030141717.3134-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: David Howells <dhowells@redhat.com>

UEFI machines can be booted in Secure Boot mode.  Add an EFI_SECURE_BOOT
flag that can be passed to efi_enabled() to find out whether secure boot is
enabled.

Move the switch-statement in x86's setup_arch() that inteprets the
secure_boot boot parameter to generic code and set the bit there.

Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc: linux-efi@vger.kernel.org
[Rebased for context; efi_is_table_address was moved to arch/x86]
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 arch/x86/kernel/setup.c           | 14 +-----------
 drivers/firmware/efi/Makefile     |  1 +
 drivers/firmware/efi/secureboot.c | 38 +++++++++++++++++++++++++++++++
 include/linux/efi.h               | 18 ++++++++++-----
 4 files changed, 52 insertions(+), 19 deletions(-)
 create mode 100644 drivers/firmware/efi/secureboot.c

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 77ea96b794bd..d10f42770190 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1179,19 +1179,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Allocate bigger log buffer */
 	setup_log_buf(1);
 
-	if (efi_enabled(EFI_BOOT)) {
-		switch (boot_params.secure_boot) {
-		case efi_secureboot_mode_disabled:
-			pr_info("Secure boot disabled\n");
-			break;
-		case efi_secureboot_mode_enabled:
-			pr_info("Secure boot enabled\n");
-			break;
-		default:
-			pr_info("Secure boot could not be determined\n");
-			break;
-		}
-	}
+	efi_set_secure_boot(boot_params.secure_boot);
 
 	reserve_initrd();
 
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 4ac2de4dfa72..195b078a423c 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_EFI_FAKE_MEMMAP)		+= fake_mem.o
 obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
+obj-$(CONFIG_EFI)			+= secureboot.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 
diff --git a/drivers/firmware/efi/secureboot.c b/drivers/firmware/efi/secureboot.c
new file mode 100644
index 000000000000..9070055de0a1
--- /dev/null
+++ b/drivers/firmware/efi/secureboot.c
@@ -0,0 +1,38 @@
+/* Core kernel secure boot support.
+ *
+ * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/efi.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+
+/*
+ * Decide what to do when UEFI secure boot mode is enabled.
+ */
+void __init efi_set_secure_boot(enum efi_secureboot_mode mode)
+{
+	if (efi_enabled(EFI_BOOT)) {
+		switch (mode) {
+		case efi_secureboot_mode_disabled:
+			pr_info("Secure boot disabled\n");
+			break;
+		case efi_secureboot_mode_enabled:
+			set_bit(EFI_SECURE_BOOT, &efi.flags);
+			pr_info("Secure boot enabled\n");
+			break;
+		default:
+			pr_warning("Secure boot could not be determined (mode %u)\n",
+				   mode);
+			break;
+		}
+	}
+}
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bd3837022307..b3b2a8107949 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1202,6 +1202,14 @@ extern int __init efi_setup_pcdp_console(char *);
 #define EFI_DBG			8	/* Print additional debug info at runtime */
 #define EFI_NX_PE_DATA		9	/* Can runtime data regions be mapped non-executable? */
 #define EFI_MEM_ATTR		10	/* Did firmware publish an EFI_MEMORY_ATTRIBUTES table? */
+#define EFI_SECURE_BOOT		11	/* Are we in Secure Boot mode? */
+
+enum efi_secureboot_mode {
+	efi_secureboot_mode_unset,
+	efi_secureboot_mode_unknown,
+	efi_secureboot_mode_disabled,
+	efi_secureboot_mode_enabled,
+};
 
 #ifdef CONFIG_EFI
 /*
@@ -1212,6 +1220,8 @@ static inline bool efi_enabled(int feature)
 	return test_bit(feature, &efi.flags) != 0;
 }
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
+
+extern void __init efi_set_secure_boot(enum efi_secureboot_mode mode);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1225,6 +1235,8 @@ efi_capsule_pending(int *reset_type)
 {
 	return false;
 }
+
+static inline void efi_set_secure_boot(enum efi_secureboot_mode mode) {}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
@@ -1616,12 +1628,6 @@ static inline bool efi_runtime_disabled(void) { return true; }
 extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
 extern unsigned long efi_call_virt_save_flags(void);
 
-enum efi_secureboot_mode {
-	efi_secureboot_mode_unset,
-	efi_secureboot_mode_unknown,
-	efi_secureboot_mode_disabled,
-	efi_secureboot_mode_enabled,
-};
 enum efi_secureboot_mode efi_get_secureboot(efi_system_table_t *sys_table);
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
-- 
2.21.0

