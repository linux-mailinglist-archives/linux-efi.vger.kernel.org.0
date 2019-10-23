Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93EECE21D0
	for <lists+linux-efi@lfdr.de>; Wed, 23 Oct 2019 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfJWRcU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 23 Oct 2019 13:32:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbfJWRcK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 23 Oct 2019 13:32:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so14306873wrv.4
        for <linux-efi@vger.kernel.org>; Wed, 23 Oct 2019 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hsspblqELrHacRAKlAsCml5p6cq229Pl951HlC0nXnY=;
        b=Ly3KR86kv1OaearP5GU4+t2oco1osmydkYQVlyufCS/z/qfdUhZXs8NFBT0ivxs9P9
         6xv+pKaCrNBchEAfTT+SegnLSq25ep7C+MMN35GR/Wn4ky+5mEuaFrDybLL3HbjV1cQP
         99JJHDvwFD0jMqtFjLskdUSMA3XvDn0HCyOiesRMDrj52xQ3+iyNR+CiT/cReIpJBdR3
         sqas2HjHhKcMrJC61ycS6oxNwo/gi0v9UhAzwtxAzEuuq5dvK9U1RAOQtQnDFv+D2BFn
         6r92xzHUQzdwDBQIoxa/eLT/1dBVyp1IyOtbP01BzjlyMTyi3iqMfYRfzRkyb8D/zY/Y
         /baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hsspblqELrHacRAKlAsCml5p6cq229Pl951HlC0nXnY=;
        b=NllhpwSIkhBLYm0ELZ0zZlO5hw9FyLttEedloUPav+f6XjyzmrrXx524VkIfVmke2F
         qxxGh6QJrgblhZ7gEQ+KBsOw/L2JdF5aJ3HDtyj+VQtY1YqYY6JmMoWXS9A9aUwLUC8x
         Mk5BXk11ZFiUIyXh4SBTeb0JfO/K/aFnpbjFZ/IALzI2xiidI8vGk+Gl+iA4RSqEio8a
         EgODnH9C7863U8pe+/+f+beqWstpPwai/NTK8A0UKuIQCWxfftrNMVgD0iEZ7QKs0vDM
         pSAw4ZIxWrVLgNUGjRFiTni7tHZcX3NvFm1vTvhFPLO3tF8txmhZGa94/ddfkl7Hn/0u
         pN/Q==
X-Gm-Message-State: APjAAAUcuazNQmK66RR3yQeNi+92UOv3kY+L6LH35B3AnDrn/c//pei4
        NFc3aBWZ1h9q5y2pUwquBjrF3XUzwY4lBjz8
X-Google-Smtp-Source: APXvYqzBva38eXIkziX3rGTFctUPyfyoGbAyVq1vcmBTKX8zojO7RnDpjPCX8MEBVYzo65FQyKl28Q==
X-Received: by 2002:a5d:6250:: with SMTP id m16mr9468896wrv.322.1571851926789;
        Wed, 23 Oct 2019 10:32:06 -0700 (PDT)
Received: from e123331-lin.home (lfbn-mar-1-643-104.w90-118.abo.wanadoo.fr. [90.118.215.104])
        by smtp.gmail.com with ESMTPSA id f7sm14900374wre.68.2019.10.23.10.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:32:06 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] efi: libstub/arm: account for firmware reserved memory at the base of RAM
Date:   Wed, 23 Oct 2019 19:32:00 +0200
Message-Id: <20191023173201.6607-5-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
References: <20191023173201.6607-1-ard.biesheuvel@linaro.org>
X-ARM-No-Footer: FoSSMail
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

