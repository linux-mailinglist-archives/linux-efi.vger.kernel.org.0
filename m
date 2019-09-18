Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD5B6BF1
	for <lists+linux-efi@lfdr.de>; Wed, 18 Sep 2019 21:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfIRTQg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Sep 2019 15:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfIRTQf (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 18 Sep 2019 15:16:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CAFE197BCE0;
        Wed, 18 Sep 2019 19:16:35 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-117-18.phx2.redhat.com [10.3.117.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C99DF100194E;
        Wed, 18 Sep 2019 19:16:34 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [RFC PATCH] tpm: only set efi_tpm_final_log_size after successful event log parsing
Date:   Wed, 18 Sep 2019 12:16:26 -0700
Message-Id: <20190918191626.5741-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Wed, 18 Sep 2019 19:16:35 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

If __calc_tpm2_event_size fails to parse an event it will return 0,
resulting tpm2_calc_event_log_size returning -1. Currently
there is no check of this return value, and efi_tpm_final_log_size
can end up being set to this negative value resulting
in a panic like the following:

[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc00866ad
[    0.774788] #PF: supervisor read access in kernel mode
[    0.774788] #PF: error_code(0x0000) - not-present page
[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 PTE 0
[    0.774788] Oops: 0000 [#1] SMP PTI
[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.elrdy.x86_64 #1
[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51W (1.30 ) 09/14/2018
[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.774788] Call Trace:
[    0.774788]  tpm_read_log_efi+0x156/0x1a0
[    0.774788]  tpm_bios_log_setup+0xc8/0x190
[    0.774788]  tpm_chip_register+0x50/0x1c0
[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
[    0.774788]  platform_drv_probe+0x35/0x80
[    0.774788]  really_probe+0xef/0x390
[    0.774788]  driver_probe_device+0xb4/0x100
[    0.774788]  device_driver_attach+0x4f/0x60
[    0.774788]  __driver_attach+0x86/0x140
[    0.774788]  ? device_driver_attach+0x60/0x60
[    0.774788]  bus_for_each_dev+0x76/0xc0
[    0.774788]  ? klist_add_tail+0x3b/0x70
[    0.774788]  bus_add_driver+0x14a/0x1e0
[    0.774788]  ? tpm_init+0xea/0xea
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  driver_register+0x6b/0xb0
[    0.774788]  ? tpm_init+0xea/0xea
[    0.774788]  init_tis+0x86/0xd8
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  ? driver_register+0x94/0xb0
[    0.774788]  do_one_initcall+0x46/0x1e4
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  kernel_init_freeable+0x199/0x242
[    0.774788]  ? rest_init+0xaa/0xaa
[    0.774788]  kernel_init+0xa/0x106
[    0.774788]  ret_from_fork+0x35/0x40
[    0.774788] Modules linked in:
[    0.774788] CR2: ffffbc8fc00866ad
[    0.774788] ---[ end trace 42930799f8d6eaea ]---
[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.774788] Kernel panic - not syncing: Fatal exception
[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
Cc: Matthew Garrett <mjg59@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/firmware/efi/tpm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index 1d3f5ca3eaaf..5cd00a7833c2 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -40,8 +40,7 @@ int __init efi_tpm_eventlog_init(void)
 {
 	struct linux_efi_tpm_eventlog *log_tbl;
 	struct efi_tcg2_final_events_table *final_tbl;
-	unsigned int tbl_size;
-	int ret = 0;
+	int tbl_size, ret = 0;
 
 	if (efi.tpm_log == EFI_INVALID_TABLE_ADDR) {
 		/*
@@ -80,11 +79,17 @@ int __init efi_tpm_eventlog_init(void)
 					    + sizeof(final_tbl->nr_events),
 					    final_tbl->nr_events,
 					    log_tbl->log);
+	if (tbl_size < 0) {
+		pr_err("Failed to parse event in TPM Final Event log\n");
+		goto calc_out;
+	}
+
 	memblock_reserve((unsigned long)final_tbl,
 			 tbl_size + sizeof(*final_tbl));
-	early_memunmap(final_tbl, sizeof(*final_tbl));
 	efi_tpm_final_log_size = tbl_size;
 
+calc_out:
+	early_memunmap(final_tbl, sizeof(*final_tbl));
 out:
 	early_memunmap(log_tbl, sizeof(*log_tbl));
 	return ret;
-- 
2.23.0

