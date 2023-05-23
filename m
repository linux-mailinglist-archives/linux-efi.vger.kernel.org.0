Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC9A70E510
	for <lists+linux-efi@lfdr.de>; Tue, 23 May 2023 21:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjEWTCh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 May 2023 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjEWTCf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 23 May 2023 15:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B591;
        Tue, 23 May 2023 12:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED976635CA;
        Tue, 23 May 2023 19:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEF6C433EF;
        Tue, 23 May 2023 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684868553;
        bh=VxVQh9QC5yaIKfdgFury2Apw+pRWi/bYlcBOunKON8s=;
        h=From:To:Cc:Subject:Date:From;
        b=DVqiDHSfDMHWS7TpBbz+AwzsPVBqse6T/LUXjEIn9wRormIgmZc5/MbEEid8lKrQl
         WA2UfA8AG1vgln980RdoJSGT03Cczc5CzNb9SxvfoKR/RpJLorigTWGBX7urwL/H7F
         Z2ymhX1I8Ht1UkzfX9FnGs2wLD83pnjp5d85R6ks/Zcg4EULDoAS8Z6Dz4IYVKP6+G
         ULZZQWas/UrGxSM9TnOpcLGWpl5aOPmfN5yqnTRYeBLxZcztbi17nq2eOaSGXIqSaD
         u7fD0w8Q+hgFa+MC5Xm/mlrIAjdjMclGJg33Bq+TBsiqLl5nsRQsJHJofTFIhzysiy
         HlkhmJAfd5jKw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH] [v2] efi: fix missing prototype warnings
Date:   Tue, 23 May 2023 21:01:30 +0200
Message-Id: <20230523190226.3860727-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The cper.c file needs to include an extra header, and efi_zboot_entry
needs an extern declaration to avoid these 'make W=1' warnings:

drivers/firmware/efi/libstub/zboot.c:65:1: error: no previous prototype for 'efi_zboot_entry' [-Werror=missing-prototypes]
drivers/firmware/efi/efi.c:176:16: error: no previous prototype for 'efi_attr_is_visible' [-Werror=missing-prototypes]
drivers/firmware/efi/cper.c:626:6: error: no previous prototype for 'cper_estatus_print' [-Werror=missing-prototypes]
drivers/firmware/efi/cper.c:649:5: error: no previous prototype for 'cper_estatus_check_header' [-Werror=missing-prototypes]
drivers/firmware/efi/cper.c:662:5: error: no previous prototype for 'cper_estatus_check' [-Werror=missing-prototypes]

To make this easier, move the cper specific declarations to
include/linux/cper.h.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: move the prototypes rather than including a file in a different
subdir
---
 drivers/acpi/apei/apei-internal.h      | 6 ------
 drivers/acpi/apei/bert.c               | 1 +
 drivers/firmware/efi/libstub/efistub.h | 3 +++
 include/linux/cper.h                   | 6 ++++++
 include/linux/efi.h                    | 2 ++
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 1d6ef9654725..67c2c3b959e1 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -7,7 +7,6 @@
 #ifndef APEI_INTERNAL_H
 #define APEI_INTERNAL_H
 
-#include <linux/cper.h>
 #include <linux/acpi.h>
 
 struct apei_exec_context;
@@ -130,10 +129,5 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 		return sizeof(*estatus) + estatus->data_length;
 }
 
-void cper_estatus_print(const char *pfx,
-			const struct acpi_hest_generic_status *estatus);
-int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
-int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
-
 int apei_osc_setup(void);
 #endif
diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index c23eb75866d0..7514e38d5640 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/cper.h>
 #include <linux/io.h>
 
 #include "apei-internal.h"
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d5a20802e0..54a2822cae77 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -1133,4 +1133,7 @@ const u8 *__efi_get_smbios_string(const struct efi_smbios_record *record,
 void efi_remap_image(unsigned long image_base, unsigned alloc_size,
 		     unsigned long code_size);
 
+asmlinkage efi_status_t __efiapi
+efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab);
+
 #endif
diff --git a/include/linux/cper.h b/include/linux/cper.h
index eacb7dd7b3af..c1a7dc325121 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -572,4 +572,10 @@ void cper_print_proc_ia(const char *pfx,
 int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
 int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg);
 
+struct acpi_hest_generic_status;
+void cper_estatus_print(const char *pfx,
+			const struct acpi_hest_generic_status *estatus);
+int cper_estatus_check_header(const struct acpi_hest_generic_status *estatus);
+int cper_estatus_check(const struct acpi_hest_generic_status *estatus);
+
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index bed3c92cbc31..120af31a5136 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1349,4 +1349,6 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
+
 #endif /* _LINUX_EFI_H */
-- 
2.39.2

