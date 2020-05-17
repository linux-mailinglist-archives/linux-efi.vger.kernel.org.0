Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2254B1D6815
	for <lists+linux-efi@lfdr.de>; Sun, 17 May 2020 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgEQM6p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 May 2020 08:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgEQM6p (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 17 May 2020 08:58:45 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4359D204EC;
        Sun, 17 May 2020 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589720323;
        bh=5tXL+YjtmxVs2yaNSEFQ3R9gk1JxmZK5tELvxsPiRaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WKOE2jgf3mmUgNcnc03VCWp0QnSJ3zH4qHJXG7/KwC8HQi0nBluxZ0LDnfVw1Xfak
         tgkQYmt0yoWOvOeG2rzjt+BfpUo/89IVTH07R4qkw1ZVOfGcacS8NF5jzYTxohJin2
         H6AUm8BeylyWB5mZkdEm1iS3VKNb1s/L6FTjta34=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        linux-acpi@vger.kernel.org, Loic Yhuel <loic.yhuel@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 3/7] efi/libstub/x86: Avoid EFI map buffer alloc in allocate_e820()
Date:   Sun, 17 May 2020 14:57:50 +0200
Message-Id: <20200517125754.8934-4-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517125754.8934-1-ardb@kernel.org>
References: <20200517125754.8934-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Lenny Szubowicz <lszubowi@redhat.com>

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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h  | 13 +++++++++++++
 drivers/firmware/efi/libstub/mem.c      |  2 --
 drivers/firmware/efi/libstub/x86-stub.c | 24 +++++++++---------------
 3 files changed, 22 insertions(+), 17 deletions(-)

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
index 05ccb229fb45..f0339b5d3658 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -606,24 +606,18 @@ static efi_status_t allocate_e820(struct boot_params *params,
 				  struct setup_data **e820ext,
 				  u32 *e820ext_size)
 {
-	unsigned long map_size, desc_size, buff_size;
-	struct efi_boot_memmap boot_map;
-	efi_memory_desc_t *map;
+	unsigned long map_size, desc_size, map_key;
 	efi_status_t status;
-	__u32 nr_desc;
+	__u32 nr_desc, desc_version;
 
-	boot_map.map		= &map;
-	boot_map.map_size	= &map_size;
-	boot_map.desc_size	= &desc_size;
-	boot_map.desc_ver	= NULL;
-	boot_map.key_ptr	= NULL;
-	boot_map.buff_size	= &buff_size;
+	/* Only need the size of the mem map and size of each mem descriptor */
+	map_size = 0;
+	status = efi_bs_call(get_memory_map, &map_size, NULL, &map_key,
+			     &desc_size, &desc_version);
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
2.17.1

