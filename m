Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09EA1CB67D
	for <lists+linux-efi@lfdr.de>; Fri,  8 May 2020 20:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEHSCY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 8 May 2020 14:02:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbgEHSCX (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 8 May 2020 14:02:23 -0400
Received: from e123331-lin.nice.arm.com (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868FD21974;
        Fri,  8 May 2020 18:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960942;
        bh=wRjeLbXLKhR/2I6YfXWaykCUR8iD+bf6tkT6dcSUxiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3FfviNKWrm2ykw6tP7KaEv55r9SoEId1KEmExPR246TLN9YkunXuBCO8XNjet8pQ
         tFX3mukDRD2cZSLZ6AYhfjJO3WY90GKmdVKs4beHDwK3gCwMoGYiEouFaFt771g8Rg
         6D/SZ9usBHkZArNsabXyGl7a4qbM/57sKoj7PevI=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 01/15] efi/x86: Use correct size for boot_params
Date:   Fri,  8 May 2020 20:01:43 +0200
Message-Id: <20200508180157.1816-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508180157.1816-1-ardb@kernel.org>
References: <20200508180157.1816-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

struct boot_params is only 4096 bytes, not 16384. Fix this by using
sizeof(struct boot_params) instead of hardcoding the incorrect value.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200430182843.2510180-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 597793fe8d22..d4bafd7f6f9f 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -379,13 +379,14 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	image_base = efi_table_attr(image, image_base);
 	image_offset = (void *)startup_32 - image_base;
 
-	status = efi_allocate_pages(0x4000, (unsigned long *)&boot_params, ULONG_MAX);
+	status = efi_allocate_pages(sizeof(struct boot_params),
+				    (unsigned long *)&boot_params, ULONG_MAX);
 	if (status != EFI_SUCCESS) {
 		efi_printk("Failed to allocate lowmem for boot params\n");
 		efi_exit(handle, status);
 	}
 
-	memset(boot_params, 0x0, 0x4000);
+	memset(boot_params, 0x0, sizeof(struct boot_params));
 
 	hdr = &boot_params->hdr;
 
@@ -439,7 +440,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 fail2:
 	efi_free(options_size, (unsigned long)cmdline_ptr);
 fail:
-	efi_free(0x4000, (unsigned long)boot_params);
+	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
 
 	efi_exit(handle, status);
 }
-- 
2.17.1

