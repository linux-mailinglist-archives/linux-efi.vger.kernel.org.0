Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B393EAF78
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2019 12:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfJaL4L (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Oct 2019 07:56:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55509 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfJaLzh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Oct 2019 07:55:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ931-0003BQ-BA; Thu, 31 Oct 2019 12:55:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8AD231C0673;
        Thu, 31 Oct 2019 12:55:14 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:14 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: libstub/arm: Account for firmware reserved
 memory at the base of RAM
Cc:     Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Chester Lin <clin@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191029173755.27149-5-ardb@kernel.org>
References: <20191029173755.27149-5-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157252291426.29376.475960355315678836.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     41cd96fa149b29684ebd38759fefb07f9c7d5276
Gitweb:        https://git.kernel.org/tip/41cd96fa149b29684ebd38759fefb07f9c7d5276
Author:        Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate:    Tue, 29 Oct 2019 18:37:53 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 31 Oct 2019 09:40:19 +01:00

efi: libstub/arm: Account for firmware reserved memory at the base of RAM

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

Tested-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Chester Lin <clin@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Link: https://lkml.kernel.org/r/20191029173755.27149-5-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile     |  1 +
 drivers/firmware/efi/libstub/arm32-stub.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0460c75..ee0661d 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -52,6 +52,7 @@ lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o string.o random.o \
 
 lib-$(CONFIG_ARM)		+= arm32-stub.o
 lib-$(CONFIG_ARM64)		+= arm64-stub.o
+CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 
 #
diff --git a/drivers/firmware/efi/libstub/arm32-stub.c b/drivers/firmware/efi/libstub/arm32-stub.c
index e8f7aef..ffa242a 100644
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
