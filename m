Return-Path: <linux-efi+bounces-886-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BE588E29D
	for <lists+linux-efi@lfdr.de>; Wed, 27 Mar 2024 14:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A4D1C2AF3A
	for <lists+linux-efi@lfdr.de>; Wed, 27 Mar 2024 13:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF24173DB6;
	Wed, 27 Mar 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjLlJZ3E"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DA173DAF;
	Wed, 27 Mar 2024 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542142; cv=none; b=aRhC0vJBYnCYjJLmbVsgeRagvxqMbUemc5W+LJUhK8kbW8SuRuB/h21slRlYHgQGGIEL4PVJGzFolurLnAtp5nAy9vhA3ZAq3PoI5jSP3i2sQZZJjBBiXJahry3F19NPyJHWUN5RS25EQC+QXUI3FYUIUMMRYeUwzm9wAHYcG64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542142; c=relaxed/simple;
	bh=/lnbJ51hoif9pZoErInLHDrj3xNKLkb2imZYhXPFEJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nrk+29HWzUKZxITPI1DLeYhZ/N45ZCMHXscEmyajXjZh/o8L+F5pGNwk+j2jve0hKRcwbYFefaWQRWMQJg+xWV7rW59fi8aL6NFLOP0H6DlW2PMobL9hWlWuHT+iz0wrkovfcqbQGB/7MRCB3wN0gbVMI5ILRKW8sTWrvzdqFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjLlJZ3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B99C43394;
	Wed, 27 Mar 2024 12:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542142;
	bh=/lnbJ51hoif9pZoErInLHDrj3xNKLkb2imZYhXPFEJU=;
	h=From:To:Cc:Subject:Date:From;
	b=OjLlJZ3EoH1/s2R51/SkaeiEBvx8fKHniFxR/t67XKI2qoXyjR+tXn3AHji4ZRguQ
	 en43inULOckIK4V1w/pdrm+Yx3vIIIihf7Q79fXVEDnocqr4bkmGAszXNQghzJ92xs
	 obyjY0iYzNmA9JoL9wuaeAwZJjz0TXia9Wzqx8Ns3leYEwD6hRJceeDGu5p1pcSeZi
	 yDwr2iEqUS39b+kFamdovkNOo2XEWLg5KXnHmj3xSHNwuAbuKJWShJnHT24moqasdI
	 7bCxAoadwZdAMZnc9PcVxNEvnZ5Rm4ziK8laYiDyLaYKZE3i+OrULD+RLmZbn2W54J
	 YcuhNn4venmDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb@kernel.org
Cc: stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/efistub: Clear decompressor BSS in native EFI entrypoint" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:22:20 -0400
Message-ID: <20240327122221.2837636-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2 Mon Sep 17 00:00:00 2001
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 16:26:16 +0100
Subject: [PATCH] x86/efistub: Clear decompressor BSS in native EFI entrypoint

The EFI stub on x86 no longer invokes the decompressor as a subsequent
boot stage, but calls into the decompression code directly while running
in the context of the EFI boot services.

This means that when using the native EFI entrypoint (as opposed to the
EFI handover protocol, which clears BSS explicitly), the firmware PE
image loader is being relied upon to ensure that BSS is zeroed before
the EFI stub is entered from the firmware.

As Radek's report proves, this is a bad idea. Not all loaders do this
correctly, which means some global variables that should be statically
initialized to 0x0 may have junk in them.

So clear BSS explicitly when entering via efi_pe_entry(). Note that
zeroing BSS from C code is not generally safe, but in this case, the
following assignment and dereference of a global pointer variable
ensures that the memset() cannot be deferred or reordered.

Cc: <stable@kernel.org> # v6.1+
Reported-by: Radek Podgorny <radek@podgorny.cz>
Closes: https://lore.kernel.org/all/a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 35413c8dfc251..2096ae09438e4 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -21,6 +21,8 @@
 #include "efistub.h"
 #include "x86-stub.h"
 
+extern char _bss[], _ebss[];
+
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 static efi_loaded_image_t *image = NULL;
@@ -474,6 +476,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
+	memset(_bss, 0, _ebss - _bss);
+
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -967,8 +971,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
 {
-	extern char _bss[], _ebss[];
-
 	memset(_bss, 0, _ebss - _bss);
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 }
-- 
2.43.0





