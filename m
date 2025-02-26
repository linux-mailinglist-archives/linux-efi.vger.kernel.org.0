Return-Path: <linux-efi+bounces-2831-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35390A46C30
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 21:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33A713AA4EC
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2025 20:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C01527B4;
	Wed, 26 Feb 2025 20:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjX6udSE"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10C2755F8
	for <linux-efi@vger.kernel.org>; Wed, 26 Feb 2025 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601130; cv=none; b=tJ4UOarfKEXu5FCjP/O342+B484+gn+YZhrLp6c4zpJbor1JupLxx49KOBVZDsU3GDVu51ZraS/BScF1Nzde2di38i1mhn6r4G4CSlKuzbBfjTaIckAGRBd35jSmf23GaUHhKwTBdkN9qm0idQx1G7zm8VWcQVu/opEeepiYdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601130; c=relaxed/simple;
	bh=a6Gr2fGBsSIxKNBsdnR8AcB356TYiEQ2ev9BeMjs/7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZfIMi6lw0dXsOlqicCHRN1C00QpSy12zGYsb9fsrpf/mGW4oUO0tYFps5PO2mTjrnrzdnT3Jt12acP9TaJLSBbFuCtKGz3CnoRvgBwPzs8SgR1tKjSt3Y0YPBYxVZv03iP9T70TNEDiyGFErIGOpQhpfxRm5RZzx8y7oPBL8rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QjX6udSE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740601128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DnRnPXT+HxB6Fa3LnjUopL2yefmMufyBefSBY059ozY=;
	b=QjX6udSEOwEndUyPp6W+p6B/B5lB8Xf5uRKaRCalmxiMMrSlHQawxbjQwRaDE5s7J3Vdlf
	e2Hm1wNoPoWsoBC//f6+Z4Zg1Zud3PTiD8CBDwiQO8pDM/JAHgxFOkF/IEUsVoHE/Aofhk
	NOQ4+ANca+YgBuHcqwDc4YOo1mDThpY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-DoOsbRtPN8qMr5OBIIobMA-1; Wed,
 26 Feb 2025 15:18:45 -0500
X-MC-Unique: DoOsbRtPN8qMr5OBIIobMA-1
X-Mimecast-MFC-AGG-ID: DoOsbRtPN8qMr5OBIIobMA_1740601124
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B20A418009A5;
	Wed, 26 Feb 2025 20:18:42 +0000 (UTC)
Received: from random.internal.datastacks.com (unknown [10.22.82.64])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C5B7180035E;
	Wed, 26 Feb 2025 20:18:41 +0000 (UTC)
From: Peter Jones <pjones@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Lenny Szubowicz <lszubowi@redhat.com>,
	Peter Jones <pjones@redhat.com>
Subject: [PATCH] efi: don't map the entire mokvar table to determine its size
Date: Wed, 26 Feb 2025 15:18:39 -0500
Message-ID: <20250226201839.2374631-1-pjones@redhat.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently when validating the mokvar table, we (re)map the entire table
on each iteration of the loop, adding space as we discover new entries.
If the table grows over a certain size, this fails due to limitations of
early_memmap(), and we get a failure and traceback:

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 0 at mm/early_ioremap.c:139 __early_ioremap+0xef/0x220
  Modules linked in:
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.12.15-200.fc41.x86_64 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20250221-6.copr8698600 02/21/2025
  RIP: 0010:__early_ioremap+0xef/0x220
  Code: e5 00 f0 ff ff 48 81 e5 00 f0 ff ff 4c 89 6c 24 08 41 81 e4 ff 0f 00 00 4c 29 ed 48 89 e8 48 c1 e8 0c 41 89 c7 83 f8 40 76 04 <0f> 0b eb 82 45 6b ee c0 41 81 c5 ff 05 00 00 45 85 ff 74 36 83 3d
  RSP: 0000:ffffffff96803dd8 EFLAGS: 00010002 ORIG_RAX: 0000000000000000
  RAX: 0000000000000041 RBX: 0000000000000001 RCX: ffffffff97768250
  RDX: 8000000000000163 RSI: 0000000000000001 RDI: 000000007c4c3000
  RBP: 0000000000041000 R08: ffffffffff201630 R09: 0000000000000030
  R10: 000000007c4c3000 R11: ffffffff96803e20 R12: 0000000000000000
  R13: 000000007c4c3000 R14: 0000000000000001 R15: 0000000000000041
  FS:  0000000000000000(0000) GS:ffffffff97291000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff9f1d8000040e CR3: 00000000653a4000 CR4: 00000000000000f0
  Call Trace:
   <TASK>
   ? __early_ioremap+0xef/0x220
   ? __warn.cold+0x93/0xfa
   ? __early_ioremap+0xef/0x220
   ? report_bug+0xff/0x140
   ? early_fixup_exception+0x5d/0xb0
   ? early_idt_handler_common+0x2f/0x3a
   ? __early_ioremap+0xef/0x220
   ? efi_mokvar_table_init+0xce/0x1d0
   ? setup_arch+0x864/0xc10
   ? start_kernel+0x6b/0xa10
   ? x86_64_start_reservations+0x24/0x30
   ? x86_64_start_kernel+0xed/0xf0
   ? common_startup_64+0x13e/0x141
   </TASK>
  ---[ end trace 0000000000000000 ]---
  mokvar: Failed to map EFI MOKvar config table pa=0x7c4c3000, size=265187.

Mapping the entire structure isn't actually necessary, as we don't ever
need more than one entry header mapped at once.

This patch changes efi_mokvar_table_init() to only map each entry
header, not the entire table, when determining the table size.  Since
we're not mapping any data past the variable name, it also changes the
code to enforce that each variable name is NUL terminated, rather than
attempting to verify it in place.

Signed-off-by: Peter Jones <pjones@redhat.com>
---
 drivers/firmware/efi/mokvar-table.c | 41 +++++++++--------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
index 5ed0602c2f7..66eb83a0f12 100644
--- a/drivers/firmware/efi/mokvar-table.c
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -103,7 +103,6 @@ void __init efi_mokvar_table_init(void)
 	void *va = NULL;
 	unsigned long cur_offset = 0;
 	unsigned long offset_limit;
-	unsigned long map_size = 0;
 	unsigned long map_size_needed = 0;
 	unsigned long size;
 	struct efi_mokvar_table_entry *mokvar_entry;
@@ -134,48 +133,34 @@ void __init efi_mokvar_table_init(void)
 	 */
 	err = -EINVAL;
 	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
-		mokvar_entry = va + cur_offset;
-		map_size_needed = cur_offset + sizeof(*mokvar_entry);
-		if (map_size_needed > map_size) {
-			if (va)
-				early_memunmap(va, map_size);
-			/*
-			 * Map a little more than the fixed size entry
-			 * header, anticipating some data. It's safe to
-			 * do so as long as we stay within current memory
-			 * descriptor.
-			 */
-			map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
-				       offset_limit);
-			va = early_memremap(efi.mokvar_table, map_size);
-			if (!va) {
-				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%lu.\n",
-				       efi.mokvar_table, map_size);
-				return;
-			}
-			mokvar_entry = va + cur_offset;
+		if (va)
+			early_memunmap(va, sizeof(*mokvar_entry));
+		va = early_memremap(efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
+		if (!va) {
+			pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
+			       efi.mokvar_table + cur_offset, sizeof(*mokvar_entry));
+			return;
 		}
+		mokvar_entry = va;
 
 		/* Check for last sentinel entry */
 		if (mokvar_entry->name[0] == '\0') {
 			if (mokvar_entry->data_size != 0)
 				break;
 			err = 0;
+			map_size_needed = cur_offset + sizeof(*mokvar_entry);
 			break;
 		}
 
-		/* Sanity check that the name is null terminated */
-		size = strnlen(mokvar_entry->name,
-			       sizeof(mokvar_entry->name));
-		if (size >= sizeof(mokvar_entry->name))
-			break;
+		/* Enforce that the name is null terminated */
+		mokvar_entry->name[sizeof(mokvar_entry->name)-1] = '\0';
 
 		/* Advance to the next entry */
-		cur_offset = map_size_needed + mokvar_entry->data_size;
+		cur_offset += sizeof(*mokvar_entry) + mokvar_entry->data_size;
 	}
 
 	if (va)
-		early_memunmap(va, map_size);
+		early_memunmap(va, sizeof(*mokvar_entry));
 	if (err) {
 		pr_err("EFI MOKvar config table is not valid\n");
 		return;
-- 
2.48.1


