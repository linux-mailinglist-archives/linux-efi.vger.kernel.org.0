Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28F9CE8E4B
	for <lists+linux-efi@lfdr.de>; Tue, 29 Oct 2019 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfJ2RjL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Oct 2019 13:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbfJ2RjL (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Oct 2019 13:39:11 -0400
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr [90.118.215.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CECF421721;
        Tue, 29 Oct 2019 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572370750;
        bh=5JAEhpTmrGeng4o8SZlsF0+eWo/frFdlcFrUqJ8GBk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vv0PYDMraLkh4sDr3+6X1vwPIopcRMaMBnkph91GAN+rMrEgqREA5hPDq/t/fv360
         MZNSQVT1uHv+5LbQNbe/3ejZgIPtM+fm3gWHW6lCR5dmYEFrdWtcixAdrnmnKd+RSb
         bGmOXLWSU4/h0fmfwGd1F9sTC05aj4LAcsiZnGaA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] efi: libstub/arm: account for firmware reserved memory at the base of RAM
Date:   Tue, 29 Oct 2019 18:37:53 +0100
Message-Id: <20191029173755.27149-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029173755.27149-1-ardb@kernel.org>
References: <20191029173755.27149-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

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

Acked-by: Chester Lin <clin@suse.com>
Tested-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
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
index e8f7aefb6813..ffa242ad0a82 100644
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
+	 * (Up to 5 pages are used for the swapper page tables)
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
2.17.1

