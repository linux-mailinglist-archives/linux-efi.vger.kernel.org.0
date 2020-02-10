Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6D1157F60
	for <lists+linux-efi@lfdr.de>; Mon, 10 Feb 2020 17:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJQDP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Feb 2020 11:03:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgBJQDP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 10 Feb 2020 11:03:15 -0500
Received: from e123331-lin.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CB7E24672;
        Mon, 10 Feb 2020 16:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581350595;
        bh=jJVBKL7lntvFlL8LsqMn0f5UtRLN7n1jP0gxeK9VfPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rc8KSYg8VuRX97o5UX7/dvVhyUjocG+m4DcEtJKGT3ivjiKj5+9ci7cQbJ7pY04wK
         OT6cIk7RZO2je/M0XLN3pQhLxQBX32Td9JZz+MaO26L3u/EZco/wN8OB2OFVWmVb+j
         6rpJPebDtSJ6UMAYhlymesfptPwxPZ9t+yPjEyAA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, nivedita@alum.mit.edu,
        mingo@kernel.org, lukas@wunner.de, atish.patra@wdc.com
Subject: [PATCH 10/19] efi/libstub/x86: Permit bootparams struct to be allocated above 4 GB
Date:   Mon, 10 Feb 2020 17:02:39 +0100
Message-Id: <20200210160248.4889-11-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210160248.4889-1-ardb@kernel.org>
References: <20200210160248.4889-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

We now support bootparams structures that are located in memory that
is not 32-bit addressable, so relax the allocation limit on systems
where this feature is enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 7e7c50883cce..9d60352baa0f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -363,6 +363,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	char *cmdline_ptr;
 	unsigned long ramdisk_addr;
 	unsigned long ramdisk_size;
+	bool above4g;
 
 	sys_table = sys_table_arg;
 
@@ -376,7 +377,11 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		return status;
 	}
 
-	status = efi_low_alloc(0x4000, 1, (unsigned long *)&boot_params);
+	hdr = &((struct boot_params *)image->image_base)->hdr;
+	above4g = hdr->xloadflags & XLF_CAN_BE_LOADED_ABOVE_4G;
+
+	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params,
+				    above4g ? ULONG_MAX : UINT_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
 		return status;
-- 
2.17.1

