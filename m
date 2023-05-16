Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACA0705882
	for <lists+linux-efi@lfdr.de>; Tue, 16 May 2023 22:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjEPUQr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 May 2023 16:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjEPUQq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 May 2023 16:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3C783D7;
        Tue, 16 May 2023 13:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 889B963392;
        Tue, 16 May 2023 20:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A333CC433EF;
        Tue, 16 May 2023 20:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684268171;
        bh=N+1VABhJvTi16EIISsnGXu9W13DA9iY+3UrCLsFbrYY=;
        h=From:To:Cc:Subject:Date:From;
        b=t19K1nVXAx9OpeFXlSmZsQDdECWADsocz3wrgG8N9x6Wz0NAMiB7fzeURdmRxqiVC
         FE07TPRZZcZAPdvPFhoTWSzINBENNhKzBzB6Xq7FKG8jIaFY6g3hy4tL5oLOfdeTHT
         7z8CANiro6EyUa/5l116M79aITVKsu59d8uRuPY4LU42GnbOsuFeh7zo6K7b6seC/L
         GMZxjfUZoUNcRnj3VvN811MURLbXR/EK+lXIRxmhYJspg5W8LM9Y3imPIQVelufs4w
         cQIjA6Bkdsi6bkRjcf7xerYlb95bhphxg0UsRIAlbbqHYisiiuK8M7FkvxSnyRuieu
         jfLdta26ci6tw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] efi: fix missing prototype warnings
Date:   Tue, 16 May 2023 22:15:43 +0200
Message-Id: <20230516201606.557548-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The cper.c file needs to include an extra header, and
efi_zboot_entry needs an extern declaration to avoid these
'make W=1' warnings:

drivers/firmware/efi/libstub/zboot.c:65:1: error: no previous prototype for 'efi_zboot_entry' [-Werror=missing-prototypes]
drivers/firmware/efi/efi.c:176:16: error: no previous prototype for 'efi_attr_is_visible' [-Werror=missing-prototypes]
drivers/firmware/efi/cper.c:626:6: error: no previous prototype for 'cper_estatus_print' [-Werror=missing-prototypes]
drivers/firmware/efi/cper.c:649:5: error: no previous prototype for 'cper_estatus_check_header' [-Werror=missing-prototypes]
drivers/firmware/efi/cper.c:662:5: error: no previous prototype for 'cper_estatus_check' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/efi/cper.c            | 1 +
 drivers/firmware/efi/libstub/efistub.h | 3 +++
 include/linux/efi.h                    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 35c37f667781..75715c7be34a 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -25,6 +25,7 @@
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
 #include "cper_cxl.h"
+#include "../../acpi/apei/apei-internal.h"
 
 /*
  * CPER record ID need to be unique even after reboot, because record
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
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7aa62c92185f..571d1a6e1b74 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1338,4 +1338,6 @@ bool efi_config_table_is_usable(const efi_guid_t *guid, unsigned long table)
 	return xen_efi_config_table_is_usable(guid, table);
 }
 
+umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n);
+
 #endif /* _LINUX_EFI_H */
-- 
2.39.2

