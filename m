Return-Path: <linux-efi+bounces-887-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD988E410
	for <lists+linux-efi@lfdr.de>; Wed, 27 Mar 2024 14:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBAB29FE5A
	for <lists+linux-efi@lfdr.de>; Wed, 27 Mar 2024 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C39189A52;
	Wed, 27 Mar 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za59L1WK"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90658189A4F;
	Wed, 27 Mar 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542378; cv=none; b=TS3W3jijLGkr6P5gBCZVspICxSRXa6C6PmNnc89WCkOq0Co/rRikxlIbD+aTaKGetl481561xnjbgwFYNl9vfvaZwKbJqAUQd/PRA4AfIjs5iQhtGPbTKPPjA2d5DrX80eQKHU4z2o8KjiwAhOollw5Xay6yKpovlSaAhuQOwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542378; c=relaxed/simple;
	bh=bCv7py3lRftPtDyq/ZDX+YLBPgBiyPm374SoRXPG5fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7CWQuWiWFi333Y2eB8It6+7tGt215rDL8vaefa3Qiput+qsDtP7Ib/scdb+2qbIWhGlDx87gM4JhSpWi+JKeFxUiWL9tkeZohx0cBLwn6PLmDfnUXsQdIvzCoS3r7JKql/bqVJxitj8yhUNx7lSck6319GxlOZLf5sjtF+ZSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za59L1WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E5CC433C7;
	Wed, 27 Mar 2024 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542378;
	bh=bCv7py3lRftPtDyq/ZDX+YLBPgBiyPm374SoRXPG5fw=;
	h=From:To:Cc:Subject:Date:From;
	b=Za59L1WKRvEWIWy56qicqwXsihPDVmxJZkBMXBSADsdW5oLsmuREa0SzQ5cQfPZSw
	 Vanp70mxPFshKC6BdrNmT2/4BVSMYjyXbqO6eKXF5uOMbeP4chBxxxhCyPeQz/PgGa
	 EhDD5b517uOVe1zeEYt0mQeD8PAiLn8laCod47cFYl6rA+X6bCXcBKkkg0MKZXWJm9
	 m+y3r5r0BVnklom98wK3tW6jq7tBzbEchRwdtFQ9Fk4F6itxBzbL00K6ALykG2De62
	 ofnl73fqD+Rva4HWuvz7HfusTzYMvZlOWoukCmBohyip2dfKjk/rOmZ46zepIU+cui
	 0VmSF2/VvhAaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ardb@kernel.org
Cc: stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "x86/efistub: Clear decompressor BSS in native EFI entrypoint" failed to apply to 4.19-stable tree
Date: Wed, 27 Mar 2024 08:26:16 -0400
Message-ID: <20240327122616.2840963-1-sashal@kernel.org>
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

The patch below does not apply to the 4.19-stable tree.
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





