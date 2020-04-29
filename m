Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695861BE584
	for <lists+linux-efi@lfdr.de>; Wed, 29 Apr 2020 19:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgD2Rl5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Apr 2020 13:41:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44135 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgD2Rl0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Apr 2020 13:41:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id c23so2558652qtp.11;
        Wed, 29 Apr 2020 10:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P15viJAU+0RM8Psz28V6qOX0pe0sVwfTgVh2E8+aZ1I=;
        b=W1lTv6GXfQd2qlyQppJZXG9l9O8AjfNisolBqNhiBd8w83xd/0/bZ1J4VbYNiMPS3p
         24N4O/dDfsftmozwMK7dErXkvQPxbotqHCfY5CubdNExO/hnUTx/3ypmttvlhCQkGAfp
         cnGJbmwRZmz7oUL6ZYkpSbsQCtZn5kneWBJUc/G6I06hDQCP3U1NycNr/EJ2fnrcFulY
         jVpUNEZA4iUaXBhUzASVL3uHTRpAEW4v7mvk6P5uLnmTtN7BcI4ati724B+V04CrVBeA
         zzgMRQFpYGDycztBj29UQFqAlfZDFIt+NAeH0aF5M495ulRQsvFEiNLdQ90TVAI5ly+d
         QxFg==
X-Gm-Message-State: AGi0PuYihttB6Mzdb4Y5x/bwH9OrL7+P3Ir9YbsXhLPaNYabCNJVPsDj
        s1AXlGdRBaZYWd2fWKJwtt3njBatjsM=
X-Google-Smtp-Source: APiQypLe+4jpQ+qS7PKJk8e2VSQm1eSPxJm5vUVmnMPPmL/uBVwecsnO45tZQkGoMUEeoekbZgJ/Bw==
X-Received: by 2002:ac8:5048:: with SMTP id h8mr35932906qtm.189.1588182084129;
        Wed, 29 Apr 2020 10:41:24 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z1sm14766448qkz.3.2020.04.29.10.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 10:41:23 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/10] efi/libstub: Add a helper function to split 64-bit values
Date:   Wed, 29 Apr 2020 13:41:12 -0400
Message-Id: <20200429174120.1497212-4-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429174120.1497212-1-nivedita@alum.mit.edu>
References: <20200429174120.1497212-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In several places 64-bit values need to be split up into two 32-bit
fields, in order to be backward-compatible with the old 32-bit ABIs.

Instead of open-coding this, add a helper function to set a 64-bit value
as two 32-bit fields.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 drivers/firmware/efi/libstub/efistub.h  |  7 ++++++
 drivers/firmware/efi/libstub/gop.c      |  6 ++---
 drivers/firmware/efi/libstub/x86-stub.c | 32 +++++++++++--------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 5ff63230a1f1..e8aa70ba08d5 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -87,6 +87,13 @@ extern const efi_system_table_t *efi_system_table;
 		((handle = efi_get_handle_at((array), i)) || true);	\
 	     i++)
 
+static inline
+void efi_set_u64_split(u64 data, u32 *lo, u32 *hi)
+{
+	*lo = lower_32_bits(data);
+	*hi = upper_32_bits(data);
+}
+
 /*
  * Allocation types for calls to boottime->allocate_pages.
  */
diff --git a/drivers/firmware/efi/libstub/gop.c b/drivers/firmware/efi/libstub/gop.c
index 216327d0b034..64cee0febae0 100644
--- a/drivers/firmware/efi/libstub/gop.c
+++ b/drivers/firmware/efi/libstub/gop.c
@@ -422,7 +422,6 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	efi_graphics_output_protocol_t *gop;
 	efi_graphics_output_protocol_mode_t *mode;
 	efi_graphics_output_mode_info_t *info;
-	efi_physical_addr_t fb_base;
 
 	gop = find_gop(proto, size, handles);
 
@@ -442,9 +441,8 @@ static efi_status_t setup_gop(struct screen_info *si, efi_guid_t *proto,
 	si->lfb_width  = info->horizontal_resolution;
 	si->lfb_height = info->vertical_resolution;
 
-	fb_base		 = efi_table_attr(mode, frame_buffer_base);
-	si->lfb_base	 = lower_32_bits(fb_base);
-	si->ext_lfb_base = upper_32_bits(fb_base);
+	efi_set_u64_split(efi_table_attr(mode, frame_buffer_base),
+			  &si->lfb_base, &si->ext_lfb_base);
 	if (si->ext_lfb_base)
 		si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
 
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index d4bafd7f6f9f..677b5a1e0543 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -408,9 +408,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!cmdline_ptr)
 		goto fail;
 
-	hdr->cmd_line_ptr = (unsigned long)cmdline_ptr;
-	/* Fill in upper bits of command line address, NOP on 32 bit  */
-	boot_params->ext_cmd_line_ptr = (u64)(unsigned long)cmdline_ptr >> 32;
+	efi_set_u64_split((u64)cmdline_ptr,
+			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
 
 	hdr->ramdisk_image = 0;
 	hdr->ramdisk_size = 0;
@@ -427,10 +426,10 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 						 ULONG_MAX);
 			if (status != EFI_SUCCESS)
 				goto fail2;
-			hdr->ramdisk_image = ramdisk_addr & 0xffffffff;
-			hdr->ramdisk_size  = ramdisk_size & 0xffffffff;
-			boot_params->ext_ramdisk_image = (u64)ramdisk_addr >> 32;
-			boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
+			efi_set_u64_split(ramdisk_addr, &hdr->ramdisk_image,
+					  &boot_params->ext_ramdisk_image);
+			efi_set_u64_split(ramdisk_size, &hdr->ramdisk_size,
+					  &boot_params->ext_ramdisk_size);
 		}
 	}
 
@@ -639,17 +638,14 @@ static efi_status_t exit_boot_func(struct efi_boot_memmap *map,
 				   : EFI32_LOADER_SIGNATURE;
 	memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
 
-	p->efi->efi_systab		= (unsigned long)efi_system_table;
+	efi_set_u64_split((u64)efi_system_table,
+			  &p->efi->efi_systab, &p->efi->efi_systab_hi);
 	p->efi->efi_memdesc_size	= *map->desc_size;
 	p->efi->efi_memdesc_version	= *map->desc_ver;
-	p->efi->efi_memmap		= (unsigned long)*map->map;
+	efi_set_u64_split((u64)*map->map,
+			  &p->efi->efi_memmap, &p->efi->efi_memmap_hi);
 	p->efi->efi_memmap_size		= *map->map_size;
 
-#ifdef CONFIG_X86_64
-	p->efi->efi_systab_hi		= (unsigned long)efi_system_table >> 32;
-	p->efi->efi_memmap_hi		= (unsigned long)*map->map >> 32;
-#endif
-
 	return EFI_SUCCESS;
 }
 
@@ -785,10 +781,10 @@ unsigned long efi_main(efi_handle_t handle,
 
 		status = efi_load_initrd_dev_path(&addr, &size, ULONG_MAX);
 		if (status == EFI_SUCCESS) {
-			hdr->ramdisk_image		= (u32)addr;
-			hdr->ramdisk_size 		= (u32)size;
-			boot_params->ext_ramdisk_image	= (u64)addr >> 32;
-			boot_params->ext_ramdisk_size 	= (u64)size >> 32;
+			efi_set_u64_split(addr, &hdr->ramdisk_image,
+					  &boot_params->ext_ramdisk_image);
+			efi_set_u64_split(size, &hdr->ramdisk_size,
+					  &boot_params->ext_ramdisk_size);
 		} else if (status != EFI_NOT_FOUND) {
 			efi_printk("efi_load_initrd_dev_path() failed!\n");
 			goto fail;
-- 
2.26.2

