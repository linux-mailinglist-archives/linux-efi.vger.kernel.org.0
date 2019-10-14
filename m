Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66154D676A
	for <lists+linux-efi@lfdr.de>; Mon, 14 Oct 2019 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfJNQdY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 14 Oct 2019 12:33:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33659 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388127AbfJNQdY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 Oct 2019 12:33:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id r17so393522wme.0
        for <linux-efi@vger.kernel.org>; Mon, 14 Oct 2019 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuEdphuMWOUGDahWSE97oqgmOlObKgpyvQgzFU8TRQU=;
        b=THTDXG/3mOeZtb6dOK6qrH1eQvV7z52+jijnE+ULOhMbPReKZiIPTLCR3+W7HnWIkL
         RFmtL80kGqOr/FynSqFtzLiwv4TaClqwXnVtULNnpITi/cHhy+AnvWVfQCDZ1THjSHSh
         pduFTV40hbsfQR4K3wm6K4LGLOnaAkS193JT28eOdR7oOcCjbZSKoQKTYCquWrAWTeIo
         oQAUnFNuy4gdBy+94VmzR0AdgNrDXTc5KPDYLaOTSBxZUJQ8+7pDFhxOxm06B6gNgPEp
         fzYcPcRV2R9hc6PtL8jxMKRNQ3PcJnas8KU2DsmaK/FJZxgtzXs97TaHydGKq33TYgst
         Mpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yuEdphuMWOUGDahWSE97oqgmOlObKgpyvQgzFU8TRQU=;
        b=MprdklcMxjePDrX6KYVZlFm2cdoBxtFFemqg4Dx/0yTkBsIy7a+SK3QI0ZuQbVNCym
         aGMjbkL29h1QzA1hTPLSg9fGcQl8CP2fu91KL/kkEC086bQ/D+Zkg8/IE+jNYIZ5PDqM
         1qW0CRezfAlcRmRaIncBtTZi2lO59krZiQ0T45gCE81u2UOdPEzL6XdmO9DWCMxIVCKh
         zf6bVInxNEHNuQJO/KvVMzpqlXu60tieU6lgGjUr9ptE7WFangU3yn4zFKS/9kAEhF0H
         deZfb3h8NmE0Rt1BP5aPw2zlszc11F4MsA/SxLqXRq12POkBGuvSnyqpZNLUHgp7lQTZ
         IwOw==
X-Gm-Message-State: APjAAAWmp6s9Z5yKvH9RUwzi4lw/O0CzAEE+LtJUC1/N85aEXeDNlGhQ
        qBUDQhjmy/rpmW1oGgryWb9DoqB8i92L6A==
X-Google-Smtp-Source: APXvYqz0XzN3uY3m31zQi76ZEDZQMtYggJ6COqe0WCePJ5GuE+rYLNtFHVBakYmvlBvQjlPYRU+lrg==
X-Received: by 2002:a1c:a516:: with SMTP id o22mr16781400wme.116.1571070801893;
        Mon, 14 Oct 2019 09:33:21 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
        by smtp.gmail.com with ESMTPSA id o70sm25785240wme.29.2019.10.14.09.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 09:33:21 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-efi@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Chester Lin <clin@suse.com>
Subject: [PATCH] efi: libstub/arm: account for firmware reserved memory at the base of RAM
Date:   Mon, 14 Oct 2019 18:33:09 +0200
Message-Id: <20191014163309.2860-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI stubloader for ARM starts out by allocating a 32 MB window
at the base of RAM, in order to ensure that the decompressor (which
blindly copies the uncompressed kernel into that window) does not
overwrite other allocations that are made while running in the context
of the EFI firmware.

In some cases, (e.g., U-Boot running on the Raspberry Pi 2), this is
causing boot failures because this initial allocation conflicts with
a page of reserved memory at the base of RAM that contains the SMP spin
tables and other pieces of firmware data and which was put there by
the bootloader under the assumption that the TEXT_OFFSET window right
below the kernel is only used partially during early boot, and will be
left alone once the memory reservations are processed and taken into
account.

So let's permit reserved memory regions to exist in the region starting
at the base of RAM, and ending at TEXT_OFFSET - 5 * PAGE_SIZE, which is
the window below the kernel that is not touched by the early boot code.

Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Chester Lin <clin@suse.com> 
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/Makefile     |  1 +
 drivers/firmware/efi/libstub/arm32-stub.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c7581220..ee0661ddb25b 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o random.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
+CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 #
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aefb6813..47aafeff3e01 100644
--- a/drivers/firmware/efi/libstub/arm32-stub.c
+++ b/drivers/firmware/efi/libstub/arm32-stub.c
@@ -195,6 +195,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 				 unsigned long dram_base,
 				 efi_loaded_image_t *image)
 {
+	unsigned long kernel_base;
 	efi_status_t status;
 
 	/*
@@ -204,9 +205,18 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	 * loaded. These assumptions are made by the decompressor,
 	 * before any memory map is available.
 	 */
-	dram_base = round_up(dram_base, SZ_128M);
+	kernel_base = round_up(dram_base, SZ_128M);
 
-	status = reserve_kernel_base(sys_table, dram_base, reserve_addr,
+	/*
+	 * Note that some platforms (notably, the Raspberry Pi 2) put
+	 * spin-tables and other pieces of firmware at the base of RAM,
+	 * abusing the fact that the window of TEXT_OFFSET bytes at the
+	 * base of the kernel image is only partially used at the moment.
+	 * (Up to 5 pages are used for the swapper page table)
+	 */
+	kernel_base += TEXT_OFFSET - 5 * PAGE_SIZE;
+
+	status = reserve_kernel_base(sys_table, kernel_base, reserve_addr,
 				     reserve_size);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Unable to allocate memory for uncompressed kernel.\n");
@@ -220,7 +230,7 @@ efi_status_t handle_kernel_image(efi_system_table_t *sys_table,
 	*image_size = image->image_size;
 	status = efi_relocate_kernel(sys_table, image_addr, *image_size,
 				     *image_size,
-				     dram_base + MAX_UNCOMP_KERNEL_SIZE, 0);
+				     kernel_base + MAX_UNCOMP_KERNEL_SIZE, 0);
 	if (status != EFI_SUCCESS) {
 		pr_efi_err(sys_table, "Failed to relocate kernel.\n");
 		efi_free(sys_table, *reserve_size, *reserve_addr);
-- 
2.20.1

