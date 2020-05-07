Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF361C8C7F
	for <lists+linux-efi@lfdr.de>; Thu,  7 May 2020 15:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGNhP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 May 2020 09:37:15 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGNhO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 May 2020 09:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588858633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc; bh=O3AKRuRPzjJT+CpU5kRHKo5Cn8muPZpj6Vd3OBhKeIM=;
        b=Ojt3fQHlIoT+zlf/ctSOBsGt2Hcqh4U8f8g+vs0OXAay2bafc3VlkbjYi9J+joKt8SFtNI
        th0cDiaLQWpDXnsz9l6i7wBtr7fOsz6Y+fV9oWvy5BOrIATkbQveCpyrmc0Gt3Uokcyb8x
        esZWRDQ/iqQY4X9h+2p+IWb8z3sT8HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-E11N9G6-PR-QtmuWiG1amA-1; Thu, 07 May 2020 09:37:10 -0400
X-MC-Unique: E11N9G6-PR-QtmuWiG1amA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC7F1005510;
        Thu,  7 May 2020 13:37:09 +0000 (UTC)
Received: from lszubowi.redhat.com (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 575CC649A9;
        Thu,  7 May 2020 13:37:08 +0000 (UTC)
From:   Lenny Szubowicz <lszubowi@redhat.com>
To:     ardb@kernel.org, eric.snowberg@oracle.com, mingo@kernel.org,
        nivedita@alum.mit.edu, tglx@linutronix.de,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()
Date:   Thu,  7 May 2020 09:37:07 -0400
Message-Id: <20200507133707.7123-1-lszubowi@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
v2:
  - Instead of freeing the EFI memory map buffer allocated by
    efi_get_memory_map(), avoid the allocation in the first place.

  - Changed the title of the patch because the v1 title no longer
    applies. v1 ref:
    https://lore.kernel.org/lkml/20200505190016.4350-1-lszubowi@redhat.com/
--
---
 drivers/firmware/efi/libstub/efistub.h  |  2 ++
 drivers/firmware/efi/libstub/mem.c      |  5 +++++
 drivers/firmware/efi/libstub/x86-stub.c | 22 ++++++++--------------
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 67d26949fd26..191468b771b6 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -616,6 +616,8 @@ void efi_printk(char *str);
 
 void efi_free(unsigned long size, unsigned long addr);
 
+unsigned int efi_get_mmap_nr_slack_slots(void);
+
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len,
 			  unsigned long max_addr);
 
diff --git a/drivers/firmware/efi/libstub/mem.c b/drivers/firmware/efi/libstub/mem.c
index 869a79c8946f..fc8b4fb08505 100644
--- a/drivers/firmware/efi/libstub/mem.c
+++ b/drivers/firmware/efi/libstub/mem.c
@@ -7,6 +7,11 @@
 
 #define EFI_MMAP_NR_SLACK_SLOTS	8
 
+unsigned int efi_get_mmap_nr_slack_slots(void)
+{
+	return EFI_MMAP_NR_SLACK_SLOTS;
+}
+
 static inline bool mmap_has_headroom(unsigned long buff_size,
 				     unsigned long map_size,
 				     unsigned long desc_size)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 05ccb229fb45..9a5ee0678434 100644
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
+	nr_desc = map_size / desc_size + efi_get_mmap_nr_slack_slots();
 
 	if (nr_desc > ARRAY_SIZE(params->e820_table)) {
 		u32 nr_e820ext = nr_desc - ARRAY_SIZE(params->e820_table);
-- 
2.18.4

