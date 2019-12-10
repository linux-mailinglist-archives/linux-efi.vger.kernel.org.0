Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D34E11831B
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 10:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfLJJKI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 04:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbfLJJKE (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 10 Dec 2019 04:10:04 -0500
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5112077B;
        Tue, 10 Dec 2019 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575969004;
        bh=I36588TTIo0cK+5GnknvOkgilqWUQvL68z6gF6Pj/Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlaplHcinfoZpk4Z1LoXQWgM9WK5F8Kzg+N5/yoiXxCLzS2/u6JQM98DeF9iOGa6R
         hzEN6nl3LH5BoQhpPx3e/nPzn6cgTrr/VFO88GVlCJHDp9W1pxmi4k9TAQ5b7wvODc
         mYwfS28G3Os1daBKloSWjW41tfmIyux6axGHgrUA=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Richard Narron <comet.berkeley@gmail.com>
Subject: [PATCH 1/1] efi: don't attempt to map RCI2 config table if it doesn't exist
Date:   Tue, 10 Dec 2019 10:09:45 +0100
Message-Id: <20191210090945.11501-2-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210090945.11501-1-ardb@kernel.org>
References: <20191210090945.11501-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit 1c5fecb61255aa12

  "efi: Export Runtime Configuration Interface table to sysfs"

added support for a Dell specific UEFI configuration table, but
failed to take into account that mapping the table should not be
attempted unless the table actually exists. If it doesn't exist,
the code usually fails silently unless pr_debug() prints are
enabled. However, on 32-bit PAE x86, the splat below is produced due
to the attempt to map the placeholder value EFI_INVALID_TABLE_ADDR
which we use for non-existing UEFI configuration tables, and which
equals ULONG_MAX.

  [    2.852491] memremap attempted on mixed range 0x00000000ffffffff size: 0x1e
  [    2.852501] WARNING: CPU: 1 PID: 1 at kernel/iomem.c:81 memremap+0x1a3/0x1c0
  [    2.852501] Modules linked in:
  [    2.852503] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.2-smp-mine #1
  [    2.852504] Hardware name: Hewlett-Packard HP Z400 Workstation/0B4Ch, BIOS 786G3 v03.61 03/05/2018
  [    2.852505] EIP: memremap+0x1a3/0x1c0
  ...
  [    2.852507] EAX: 0000003f EBX: 0000001e ECX: c5225bc0 EDX: 00000001
  [    2.852507] ESI: 01000200 EDI: 00000000 EBP: ee551f0c ESP: ee551eec
  [    2.852508] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010296
  [    2.852509] CR0: 80050033 CR2: 00000000 CR3: 0520c000 CR4: 000006f0
  [    2.852509] Call Trace:
  [    2.852513]  ? map_properties+0x473/0x473
  [    2.852515]  ? efi_rci2_sysfs_init+0x2c/0x154
  [    2.852516]  ? map_properties+0x473/0x473
  [    2.852517]  ? do_one_initcall+0x49/0x1d4
  [    2.852519]  ? parse_args+0x1e8/0x2a0
  [    2.852521]  ? do_early_param+0x7a/0x7a
  [    2.852522]  ? kernel_init_freeable+0x139/0x1c2
  [    2.852525]  ? rest_init+0x8e/0x8e
  [    2.852526]  ? kernel_init+0xd/0xf2
  [    2.852529]  ? ret_from_fork+0x2e/0x38
  [    2.852530] ---[ end trace 5c4c3f26439c3728 ]---

Fix this by checking whether the table exists before attempting to map it.

Fixes: 1c5fecb61255aa12 ("efi: Export Runtime Configuration Interface table to sysfs")
Reported-by: Richard Narron <comet.berkeley@gmail.com>
Tested-by: Richard Narron <comet.berkeley@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/rci2-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 76b0c354a027..de1a9a1f9f14 100644
--- a/drivers/firmware/efi/rci2-table.c
+++ b/drivers/firmware/efi/rci2-table.c
@@ -81,6 +81,9 @@ static int __init efi_rci2_sysfs_init(void)
 	struct kobject *tables_kobj;
 	int ret = -ENOMEM;
 
+	if (rci2_table_phys == EFI_INVALID_TABLE_ADDR)
+		return 0;
+
 	rci2_base = memremap(rci2_table_phys,
 			     sizeof(struct rci2_table_global_hdr),
 			     MEMREMAP_WB);
-- 
2.17.1

