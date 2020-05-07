Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EDD1C995D
	for <lists+linux-efi@lfdr.de>; Thu,  7 May 2020 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEGSdj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 May 2020 14:33:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSdi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 May 2020 14:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588876417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=pkfkngglHMgB29Wih8/yDRJONw7zEpxS+kgwQBqouk8=;
        b=JWa9rZzxvaTrWZ1CB/vHm5ZI650jfwlMzZQhrYm1D7p8pN/Gu7sePv5n6BG1CcpCkwOaz6
        bBvu9/t0TE/D7Q3bXXrYxeNqVlwit4Gie5l06ithZ3wUJVrT4u6mP58WKfnxtARj6jcFan
        0p58km0tVSYtGMYuRojP7IAmVW/ofYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-eAJ9gQinPA-a9yzqSu712Q-1; Thu, 07 May 2020 14:33:35 -0400
X-MC-Unique: eAJ9gQinPA-a9yzqSu712Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E792B107ACCD;
        Thu,  7 May 2020 18:33:33 +0000 (UTC)
Received: from lszubowi.redhat.com (unknown [10.10.110.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDF585C1B0;
        Thu,  7 May 2020 18:33:32 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     ardb@kernel.org, eric.snowberg@oracle.com, mingo@kernel.org,
        nivedita@alum.mit.edu, tglx@linutronix.de,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()
Date:   Thu,  7 May 2020 14:33:32 -0400
Message-Id: <20200507183332.6153-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In allocate_e820(), call the EFI get_memory_map() service directly
instead of indirectly via efi_get_memory_map(). This avoids allocation
of a buffer and return of the full EFI memory map, which is not needed
here and would otherwise need to be freed.

Routine allocate_e820() only needs to know how many EFI memory
descriptors there are in the map to allocate an adequately sized
e820ext buffer, if it's needed. Note that since efi_get_memory_map()
returns a memory map buffer sized with extra headroom, allocate_e820()
now needs to explicitly factor that into the e820ext size calculation.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
--
v3:
  - Move define of EFI_MMAP_NR_SLACK_SLOTS to efistub.h instead
    of providing a helper function to get it.

v2:
  - Instead of freeing the EFI memory map buffer allocated by
    efi_get_memory_map(), avoid the allocation in the first place.

  - Changed the title of the patch because the v1 title no longer
    applies. v1 ref:
    https://lore.kernel.org/lkml/20200505190016.4350-1-lszubowi@redhat.com/
--
---
 drivers/firmware/efi/libstub/efistub.h  | 13 +++++++++++++
 drivers/firmware/efi/libstub/mem.c      |  2 --
 drivers/firmware/efi/libstub/x86-stub.c | 22 ++++++++--------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d26949fd26..62943992f02f 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -92,6 +92,19 @@ extern __pure efi_system_table_t  *efi_system_table(void);
 #define EFI_LOCATE_BY_REGISTER_NOTIFY		1
 #define EFI_LOCATE_BY_PROTOCOL			2
 
+/*
+ * An efi_boot_memmap is used by efi_get_memory_map() to return the
+ * EFI memory map in a dynamically allocated buffer.
+ *
+ * The buffer allocated for the EFI memory map includes extra room for
+ * a minimum of EFI_MMAP_NR_SLACK_SLOTS additional EFI memory descriptors.
+ * This facilitates the reuse of the EFI memory map buffer when a second
+ * call to ExitBootServices() is needed because of intervening changes to
+ * the EFI memory map. Other related structures, e.g. x86 e820ext, need
+ * to factor in this headroom requirement as well.
+ */
+#define EFI_MMAP_NR_SLACK_SLOTS	8
+
 struct efi_boot_memmap {
 	efi_memory_desc_t	**map;
 	unsigned long		*map_size;
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 869a79c8946f..09f4fa01914e 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -5,8 +5,6 @@
 
 #include "efistub.h"
 
-#define EFI_MMAP_NR_SLACK_SLOTS	8
-
 static inline bool mmap_has_headroom(unsigned long buff_size,
 				     unsigned long map_size,
 				     unsigned long desc_size)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ccb229fb45..a0aeb1cda8e3 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -606,24 +606,18 @@ static efi_status_t allocate_e820(struct boot_params *params,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	unsigned long map_size, desc_size, buff_size;
-	struct efi_boot_memmap boot_map;
-	efi_memory_desc_t *map;
+	unsigned long map_size, desc_size;
 	efi_status_t status;
 	__u32 nr_desc;
 
-	boot_map.map		= &map;
-	boot_map.map_size	= &map_size;
-	boot_map.desc_size	= &desc_size;
-	boot_map.desc_ver	= NULL;
-	boot_map.key_ptr	= NULL;
-	boot_map.buff_size	= &buff_size;
+	/* Only need the size of the mem map and size of each mem descriptor */
+	map_size = 0;
+	status = efi_bs_call(get_memory_map, &map_size, NULL, NULL,
+			     &desc_size, NULL);
+	if (status != EFI_BUFFER_TOO_SMALL)
+		return (status != EFI_SUCCESS) ? status : EFI_UNSUPPORTED;
 
-	status = efi_get_memory_map(&boot_map);
-	if (status != EFI_SUCCESS)
-		return status;
-
-	nr_desc = buff_size / desc_size;
+	nr_desc = map_size / desc_size + EFI_MMAP_NR_SLACK_SLOTS;
 
 	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
 		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
-- 
2.18.4

