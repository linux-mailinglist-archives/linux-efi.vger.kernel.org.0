Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907BA205818
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jun 2020 18:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgFWQ7v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 23 Jun 2020 12:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgFWQ7v (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 23 Jun 2020 12:59:51 -0400
Received: from localhost.localdomain (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7D320774;
        Tue, 23 Jun 2020 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592931591;
        bh=054NJXoCj+/U4eISzRwYFSeZuhyUtPP0UYISH/TSM9k=;
        h=From:To:Cc:Subject:Date:From;
        b=JIHakkphArdX3LBSEuYIF+cO1j3HQ54zHNAFazI6knYpSwEYqMTLambCvUDKKKyPO
         6/ojrnBTVVBxekRg85K2s/tDvb0ONtZCDAFWEut9FZFBU2KrkDNZ0pnZhnLjtNvpmO
         6HgmW9CEhpbigfa6qtFDUrpWOogfYMBFeryiAk0E=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        rppt@linux.ibm.com, m.szyprowski@samsung.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] ARM: mmu: fix crash in EFI calls due to p4d typo in create_mapping_late()
Date:   Tue, 23 Jun 2020 18:59:36 +0200
Message-Id: <20200623165936.1545211-1-ardb@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Commit

  84e6ffb2c49c7901 ("arm: add support for folded p4d page tables")

updated create_mapping_late() to take folded P4Ds into account when
creating mappings, but inverted the p4d_alloc() failure test, resulting
in no mapping to be created at all.

When the EFI rtc driver subsequently tries to invoke the EFI GetTime()
service, the memory regions covering the EFI data structures are missing
from the page tables, resulting in a crash like

  Unable to handle kernel paging request at virtual address 5ae0cf28
  pgd = (ptrval)
  [5ae0cf28] *pgd=80000040205003, *pmd=00000000
  Internal error: Oops: 207 [#1] SMP THUMB2
  Modules linked in:
  CPU: 0 PID: 7 Comm: kworker/u32:0 Not tainted 5.7.0+ #92
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  Workqueue: efi_rts_wq efi_call_rts
  PC is at efi_call_rts+0x94/0x294
  LR is at efi_call_rts+0x83/0x294
  pc : [<c0b4f098>]    lr : [<c0b4f087>]    psr: 30000033
  sp : e6219ef0  ip : 00000000  fp : ffffe000
  r10: 00000000  r9 : 00000000  r8 : 30000013
  r7 : e6201dd0  r6 : e6201ddc  r5 : 00000000  r4 : c181f264
  r3 : 5ae0cf10  r2 : 00000001  r1 : e6201dd0  r0 : e6201ddc
  Flags: nzCV  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
  Control: 70c5383d  Table: 661cc840  DAC: 00000001
  Process kworker/u32:0 (pid: 7, stack limit = 0x(ptrval))
  ...
  [<c0b4f098>] (efi_call_rts) from [<c0448219>] (process_one_work+0x16d/0x3d8)
  [<c0448219>] (process_one_work) from [<c0448581>] (worker_thread+0xfd/0x408)
  [<c0448581>] (worker_thread) from [<c044ca7b>] (kthread+0x103/0x104)
  ...

Fixes: 84e6ffb2c49c7901 ("arm: add support for folded p4d page tables")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 628028bfbb92..bcd82614c25d 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -966,7 +966,7 @@ void __init create_mapping_late(struct mm_struct *mm, struct map_desc *md,
 	pud_t *pud;
 
 	p4d = p4d_alloc(mm, pgd_offset(mm, md->virtual), md->virtual);
-	if (!WARN_ON(!p4d))
+	if (WARN_ON(!p4d))
 		return;
 	pud = pud_alloc(mm, p4d, md->virtual);
 	if (WARN_ON(!pud))
-- 
2.27.0

