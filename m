Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C056682328
	for <lists+linux-efi@lfdr.de>; Tue, 31 Jan 2023 05:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjAaEEM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Jan 2023 23:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAaEEL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Jan 2023 23:04:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 830573801E;
        Mon, 30 Jan 2023 20:04:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 503882F4;
        Mon, 30 Jan 2023 20:04:52 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 206E83F64C;
        Mon, 30 Jan 2023 20:04:07 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [PATCH 2/2] efi: Introduce efi_get_supported_rt_services() to get the runtime services mask
Date:   Tue, 31 Jan 2023 04:03:55 +0000
Message-Id: <20230131040355.3116-3-justin.he@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131040355.3116-1-justin.he@arm.com>
References: <20230131040355.3116-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Previously, efi.runtime_supported_mask will always be the initial value
EFI_RT_SUPPORTED_ALL and can't be retrieved in efi_config_parse_tables()
if rt_prop is EFI_INVALID_TABLE_ADDR. Thus this can cause the wrong
return value of efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)
on the Ampere Emag server.

Besides, abstract the runtime services retrieving into a new exported
helper efi_get_supported_rt_services() to set or clear the runtime service
bit of efi.flags.

Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/firmware/efi/arm-runtime.c |  5 ++++-
 drivers/firmware/efi/efi.c         | 28 +++++++++++++++++++---------
 include/linux/efi.h                |  1 +
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83f5bb57fa4c..ce93133f9abc 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -146,7 +146,10 @@ static int __init arm_enable_runtime_services(void)
 
 	/* Set up runtime services function pointers */
 	efi_native_runtime_setup();
-	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+	if (efi_get_supported_rt_services())
+		set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+	else
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 
 	return 0;
 }
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index a2b0cbc8741c..96475cb8088e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -595,6 +595,24 @@ static __init int match_config_table(const efi_guid_t *guid,
 	return 0;
 }
 
+unsigned int __init efi_get_supported_rt_services(void)
+{
+	unsigned int runtime_supported_mask = EFI_RT_SUPPORTED_ALL;
+
+	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
+		efi_rt_properties_table_t *tbl;
+
+		tbl = early_memremap(rt_prop, sizeof(*tbl));
+		if (tbl) {
+			runtime_supported_mask &= tbl->runtime_services_supported;
+			early_memunmap(tbl, sizeof(*tbl));
+		}
+	} else
+		runtime_supported_mask = 0;
+
+	return runtime_supported_mask;
+}
+
 int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 				   int count,
 				   const efi_config_table_type_t *arch_tables)
@@ -695,15 +713,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
-	if (rt_prop != EFI_INVALID_TABLE_ADDR) {
-		efi_rt_properties_table_t *tbl;
-
-		tbl = early_memremap(rt_prop, sizeof(*tbl));
-		if (tbl) {
-			efi.runtime_supported_mask &= tbl->runtime_services_supported;
-			early_memunmap(tbl, sizeof(*tbl));
-		}
-	}
+	efi.runtime_supported_mask &= efi_get_supported_rt_services();
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
 	    initrd != EFI_INVALID_TABLE_ADDR && phys_initrd_size == 0) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4b27519143f5..fcaf0d7fc07e 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -717,6 +717,7 @@ extern void __init efi_esrt_init(void);
 #else
 static inline void efi_esrt_init(void) { }
 #endif
+extern unsigned int efi_get_supported_rt_services(void);
 extern int efi_config_parse_tables(const efi_config_table_t *config_tables,
 				   int count,
 				   const efi_config_table_type_t *arch_tables);
-- 
2.25.1

