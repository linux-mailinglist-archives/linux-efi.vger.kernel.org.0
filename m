Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6B179602
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgCDQ7p (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 11:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgCDQ7X (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:23 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B41022B48;
        Wed,  4 Mar 2020 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583341163;
        bh=k8cs1jt4PQAsLsLxEf6Zcc6sAC4oegXFCCpyPO54AW4=;
        h=From:To:Cc:Subject:Date:From;
        b=xqwY+9aPdFvXM9VDOix6q2yZElJBSVx6/ArDUe8w+CXcQ+oI7hwMbvECrW2gy2HBq
         gd7rscQi6mTn7ET8jh93VM63UMViXDtRmR6VSc0jacCG3+bkcZ2YWew7swYIS+5Cyb
         5lnkQW4NCU7tGPdB8JH43eHuG+i7dVqcjvjcC6YU=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     nivedita@alum.mit.edu, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH efi-next] efi/x86: ignore memory attributes table on i386
Date:   Wed,  4 Mar 2020 17:59:17 +0100
Message-Id: <20200304165917.5893-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 3a6b6c6fb23667fa ("efi: Make EFI_MEMORY_ATTRIBUTES_TABLE
initialization common across all architectures") moved the call to
efi_memattr_init() from ARM specific to generic EFI init code, in
order to be able to apply the restricted permissions described in
that table on x86 as well.

We never enabled this feature fully on i386, and so mapping and
reserving this table is pointless. However, due to the early call to
memblock_reserve(), the memory bookkeeping gets confused to the point
where it produces the splat below when we try to map the memory later
on:

  ------------[ cut here ]------------
  ioremap on RAM at 0x3f251000 - 0x3fa1afff
  WARNING: CPU: 0 PID: 0 at arch/x86/mm/ioremap.c:166 __ioremap_caller ...
  Modules linked in:
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0 #48
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
  EIP: __ioremap_caller.constprop.0+0x249/0x260
  Code: 90 0f b7 05 4e 38 40 de 09 45 e0 e9 09 ff ff ff 90 8d 45 ec c6 05 ...
  EAX: 00000029 EBX: 00000000 ECX: de59c228 EDX: 00000001
  ESI: 3f250fff EDI: 00000000 EBP: de3edf20 ESP: de3edee0
  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00200296
  CR0: 80050033 CR2: ffd17000 CR3: 1e58c000 CR4: 00040690
  Call Trace:
   ioremap_cache+0xd/0x10
   ? old_map_region+0x72/0x9d
   old_map_region+0x72/0x9d
   efi_map_region+0x8/0xa
   efi_enter_virtual_mode+0x260/0x43b
   start_kernel+0x329/0x3aa
   i386_start_kernel+0xa7/0xab
   startup_32_smp+0x164/0x168
  ---[ end trace e15ccf6b9f356833 ]---

Let's work around this by disregarding the memory attributes table
altogether on i386, which does not result in a loss of functionality
or protection, given that we never consumed the contents.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index d1746a579c99..34bca039fca0 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -543,7 +543,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
-	if (efi_enabled(EFI_MEMMAP))
+	if (!IS_ENABLED(CONFIG_X86_32) && efi_enabled(EFI_MEMMAP))
 		efi_memattr_init();
 
 	efi_tpm_eventlog_init();
-- 
2.17.1

