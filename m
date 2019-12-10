Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7874E118605
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfLJLPD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 06:15:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40738 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLPD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 06:15:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iedTm-0007vW-SC; Tue, 10 Dec 2019 12:14:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6D9A41C2908;
        Tue, 10 Dec 2019 12:14:58 +0100 (CET)
Date:   Tue, 10 Dec 2019 11:14:58 -0000
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Don't attempt to map RCI2 config table if it
 doesn't exist
Cc:     Richard Narron <comet.berkeley@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191210090945.11501-2-ardb@kernel.org>
References: <20191210090945.11501-2-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <157597649826.30329.15341912018397300617.tip-bot2@tip-bot2>
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

Commit-ID:     a470552ee8965da0fe6fd4df0aa39c4cda652c7c
Gitweb:        https://git.kernel.org/tip/a470552ee8965da0fe6fd4df0aa39c4cda652c7c
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 10 Dec 2019 10:09:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Dec 2019 12:13:02 +01:00

efi: Don't attempt to map RCI2 config table if it doesn't exist

Commit:

  1c5fecb61255aa12 ("efi: Export Runtime Configuration Interface table to sysfs")

... added support for a Dell specific UEFI configuration table, but
failed to take into account that mapping the table should not be
attempted unless the table actually exists. If it doesn't exist,
the code usually fails silently unless pr_debug() prints are
enabled. However, on 32-bit PAE x86, the splat below is produced due
to the attempt to map the placeholder value EFI_INVALID_TABLE_ADDR
which we use for non-existing UEFI configuration tables, and which
equals ULONG_MAX.

   memremap attempted on mixed range 0x00000000ffffffff size: 0x1e
   WARNING: CPU: 1 PID: 1 at kernel/iomem.c:81 memremap+0x1a3/0x1c0
   Modules linked in:
   CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.2-smp-mine #1
   Hardware name: Hewlett-Packard HP Z400 Workstation/0B4Ch, BIOS 786G3 v03.61 03/05/2018
   EIP: memremap+0x1a3/0x1c0
  ...
   Call Trace:
    ? map_properties+0x473/0x473
    ? efi_rci2_sysfs_init+0x2c/0x154
    ? map_properties+0x473/0x473
    ? do_one_initcall+0x49/0x1d4
    ? parse_args+0x1e8/0x2a0
    ? do_early_param+0x7a/0x7a
    ? kernel_init_freeable+0x139/0x1c2
    ? rest_init+0x8e/0x8e
    ? kernel_init+0xd/0xf2
    ? ret_from_fork+0x2e/0x38

Fix this by checking whether the table exists before attempting to map it.

Reported-by: Richard Narron <comet.berkeley@gmail.com>
Tested-by: Richard Narron <comet.berkeley@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Fixes: 1c5fecb61255aa12 ("efi: Export Runtime Configuration Interface table to sysfs")
Link: https://lkml.kernel.org/r/20191210090945.11501-2-ardb@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/firmware/efi/rci2-table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
index 76b0c35..de1a9a1 100644
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
