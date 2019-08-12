Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F828A1EF
	for <lists+linux-efi@lfdr.de>; Mon, 12 Aug 2019 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfHLPFe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 12 Aug 2019 11:05:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55869 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfHLPFL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 12 Aug 2019 11:05:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so12467169wmf.5
        for <linux-efi@vger.kernel.org>; Mon, 12 Aug 2019 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8IMb6ucekZITMI3FMSd2vkVdCA6v6V+Ngebbp2VClKs=;
        b=mYkFnIPSEzOo3ELoos1JOjri2NaV+zXYbxrik8fkPrh+5rloTjwd/yVKYHjAa7pFLF
         wtktJZhupsHyFx3pDUdgJCjAwh2p9I6TMvQmya7vx9BrBdhGHagICquUhelfs60FQXNJ
         +Fmf80svglaVSoptoJFHOK/7/HQGbm06ig+PZL/IFbZPRMFZltu0iM3nG0FwkPInS1nf
         RE99EoSBVWs7/RDHUkK1hWxt0vUYdqsDFp6z6dSvIQwN8mU17cOI/uZOun2czuL3zl4P
         ijme2BGrI/TokPeVKfSslXWXAq1EO1A8iUqHlYQ4tfJsEhaWvECPEXrChIQq8+v16LoF
         zNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8IMb6ucekZITMI3FMSd2vkVdCA6v6V+Ngebbp2VClKs=;
        b=btpI6Tr27chox+r9POITVe0fEPI2TbOJKXdWmrbHEwq3Uo1dHKk/WH5s45MSeGrCIp
         rtjsNaBHcdcjgZXJPMx93uSNB3Gatb3uA1xOx3rOjn3cdt0wUkk/bmttVRVqvB8XVmJL
         xSAsbhWIevOFmUPjbFCz9LVYecG/6w6p/4FQ4b1185PklI+AI6rfrz7tkWYib4jxWirK
         eOKfVusTA+SgpCmoQ3N98Mw7YshR8sqF71e5duS1szTBEyElr5rNxixo0lx4dOSJbJJr
         AlDsnklgrjI3cES6N8F/mLKqJ/4UkAuwZTLfUThZQWl9dlXoCehk8y+VcsGg3AmNCC6J
         NgZg==
X-Gm-Message-State: APjAAAX5Na2TMj7mxEypU7TBHf9OMcDXoUzU9rQsyIU09xSlrGA3iRfb
        HaetFfhFpmlVGwbkaiqVkDhnAst0VdpaVA==
X-Google-Smtp-Source: APXvYqxP6NEQtwOppdOu3AyNA04uPlbn1EdFq9PlZqMlsslGdmQq9f0Afadj82zlntGTlJRLgljamw==
X-Received: by 2002:a1c:a008:: with SMTP id j8mr2838023wme.57.1565622308510;
        Mon, 12 Aug 2019 08:05:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:1c0e:f938:89a1:8e17])
        by smtp.gmail.com with ESMTPSA id h97sm31027269wrh.74.2019.08.12.08.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 08:05:07 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Narendra K <Narendra.K@dell.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH 1/5] efi: x86: move efi_is_table_address() into arch/x86
Date:   Mon, 12 Aug 2019 18:04:48 +0300
Message-Id: <20190812150452.27983-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
References: <20190812150452.27983-1-ard.biesheuvel@linaro.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The function efi_is_table_address() and the associated array of table
pointers is specific to x86. Since we will be adding some more x86
specific tables, let's move this code out of the generic code first.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/efi.h  |  5 +++++
 arch/x86/mm/ioremap.c       |  1 +
 arch/x86/platform/efi/efi.c | 33 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c  | 33 ---------------------------------
 include/linux/efi.h         |  7 -------
 5 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 606a4b6a9812..43a82e59c59d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -242,6 +242,7 @@ static inline bool efi_is_64bit(void)
 		__efi_early()->runtime_services), __VA_ARGS__)
 
 extern bool efi_reboot_required(void);
+extern bool efi_is_table_address(unsigned long phys_addr);
 
 #else
 static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
@@ -249,6 +250,10 @@ static inline bool efi_reboot_required(void)
 {
 	return false;
 }
+static inline  bool efi_is_table_address(unsigned long phys_addr)
+{
+	return false;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 63e99f15d7cf..a39dcdb5ae34 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -19,6 +19,7 @@
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
+#include <asm/efi.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index a7189a3b4d70..8d9be97a5607 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -64,6 +64,25 @@ static efi_config_table_type_t arch_tables[] __initdata = {
 	{NULL_GUID, NULL, NULL},
 };
 
+static const unsigned long * const efi_tables[] = {
+	&efi.mps,
+	&efi.acpi,
+	&efi.acpi20,
+	&efi.smbios,
+	&efi.smbios3,
+	&efi.sal_systab,
+	&efi.boot_info,
+	&efi.hcdp,
+	&efi.uga,
+	&efi.uv_systab,
+	&efi.fw_vendor,
+	&efi.runtime,
+	&efi.config_table,
+	&efi.esrt,
+	&efi.properties_table,
+	&efi.mem_attr_table,
+};
+
 u64 efi_setup;		/* efi setup_data physical address */
 
 static int add_efi_memmap __initdata;
@@ -1049,3 +1068,17 @@ static int __init arch_parse_efi_cmdline(char *str)
 	return 0;
 }
 early_param("efi", arch_parse_efi_cmdline);
+
+bool efi_is_table_address(unsigned long phys_addr)
+{
+	unsigned int i;
+
+	if (phys_addr == EFI_INVALID_TABLE_ADDR)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(efi_tables); i++)
+		if (*(efi_tables[i]) == phys_addr)
+			return true;
+
+	return false;
+}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..cbdbdbc8f9eb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -57,25 +57,6 @@ struct efi __read_mostly efi = {
 };
 EXPORT_SYMBOL(efi);
 
-static unsigned long *efi_tables[] = {
-	&efi.mps,
-	&efi.acpi,
-	&efi.acpi20,
-	&efi.smbios,
-	&efi.smbios3,
-	&efi.sal_systab,
-	&efi.boot_info,
-	&efi.hcdp,
-	&efi.uga,
-	&efi.uv_systab,
-	&efi.fw_vendor,
-	&efi.runtime,
-	&efi.config_table,
-	&efi.esrt,
-	&efi.properties_table,
-	&efi.mem_attr_table,
-};
-
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
@@ -964,20 +945,6 @@ int efi_status_to_err(efi_status_t status)
 	return err;
 }
 
-bool efi_is_table_address(unsigned long phys_addr)
-{
-	unsigned int i;
-
-	if (phys_addr == EFI_INVALID_TABLE_ADDR)
-		return false;
-
-	for (i = 0; i < ARRAY_SIZE(efi_tables); i++)
-		if (*(efi_tables[i]) == phys_addr)
-			return true;
-
-	return false;
-}
-
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
 static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f87fabea4a85..60a6242765d8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1211,8 +1211,6 @@ static inline bool efi_enabled(int feature)
 	return test_bit(feature, &efi.flags) != 0;
 }
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
-
-extern bool efi_is_table_address(unsigned long phys_addr);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1226,11 +1224,6 @@ efi_capsule_pending(int *reset_type)
 {
 	return false;
 }
-
-static inline bool efi_is_table_address(unsigned long phys_addr)
-{
-	return false;
-}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
-- 
2.17.1

