Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086428557D
	for <lists+linux-efi@lfdr.de>; Wed,  7 Aug 2019 23:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfHGV7H (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Aug 2019 17:59:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbfHGV7H (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 7 Aug 2019 17:59:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A8EBB4E92A;
        Wed,  7 Aug 2019 21:59:06 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-64.ams2.redhat.com [10.36.116.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19CBE5D9E1;
        Wed,  7 Aug 2019 21:59:04 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.3 regression fix] efi-stub: Fix get_efi_config_table on mixed-mode setups
Date:   Wed,  7 Aug 2019 23:59:03 +0200
Message-Id: <20190807215903.24990-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 07 Aug 2019 21:59:06 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Fix get_efi_config_table using the wrong structs when booting a
64 bit kernel on 32 bit firmware.

Cc: Matthew Garrett <mjg59@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Fixes: 82d736ac56d7 ("Abstract out support for locating an EFI config table")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../firmware/efi/libstub/efi-stub-helper.c    | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1db780c0f07b..3caae7f2cf56 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -927,17 +927,33 @@ efi_status_t efi_exit_boot_services(efi_system_table_t *sys_table_arg,
 	return status;
 }
 
+#define GET_EFI_CONFIG_TABLE(bits)					\
+static void *get_efi_config_table##bits(efi_system_table_t *_sys_table,	\
+					efi_guid_t guid)		\
+{									\
+	efi_system_table_##bits##_t *sys_table;				\
+	efi_config_table_##bits##_t *tables;				\
+	int i;								\
+									\
+	sys_table = (typeof(sys_table))_sys_table;			\
+	tables = (typeof(tables))(unsigned long)sys_table->tables;	\
+									\
+	for (i = 0; i < sys_table->nr_tables; i++) {			\
+		if (efi_guidcmp(tables[i].guid, guid) != 0)		\
+			continue;					\
+									\
+		return (void *)(unsigned long)tables[i].table;		\
+	}								\
+									\
+	return NULL;							\
+}
+GET_EFI_CONFIG_TABLE(32)
+GET_EFI_CONFIG_TABLE(64)
+
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 {
-	efi_config_table_t *tables = (efi_config_table_t *)sys_table->tables;
-	int i;
-
-	for (i = 0; i < sys_table->nr_tables; i++) {
-		if (efi_guidcmp(tables[i].guid, guid) != 0)
-			continue;
-
-		return (void *)tables[i].table;
-	}
-
-	return NULL;
+	if (efi_is_64bit())
+		return get_efi_config_table64(sys_table, guid);
+	else
+		return get_efi_config_table32(sys_table, guid);
 }
-- 
2.22.0

