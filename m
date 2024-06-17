Return-Path: <linux-efi+bounces-1224-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F32FA90A2C6
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 05:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665AB1F218D7
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jun 2024 03:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16074176AB2;
	Mon, 17 Jun 2024 03:11:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A7A367;
	Mon, 17 Jun 2024 03:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593865; cv=none; b=bV3JrDfrjWNqtcwJKaP+0IO42BUHwbK6PM9l645C/NnZ6v40HVrFIOjiF40pBV0Gnabx1TIBD07ga6bj6rg+Ngwv3dR85aj41MuceyYn99hb2f1bteahVzwdTjIa4oLYnAHvScJcCGxh9X9zXFzGtvfcedZp0B8QWY+CZZnFeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593865; c=relaxed/simple;
	bh=0GXxmdVYWuMb/0ixNQuVCXsh6rU/NqGKXC2zemoFesY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T4fb3QtBNlHhF0Oo8tazh3NYysDHoyLPuRRk8THaiQ/y9GyhY5iYl4ct8QMvxL9997ATrtbbHd66/qSGYLScMVuWKQfsna3y7o5DJExqBnDm80Otnjiifx97m8eEtRKF6mOSDE39B3ze+rVtZIJ4KXwryqSf3ZO/6tAyxMzUUwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W2ZYQ2mtBz3560M;
	Mon, 17 Jun 2024 11:07:06 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id E488D1400D6;
	Mon, 17 Jun 2024 11:10:57 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Jun 2024 11:10:57 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ardb@kernel.org>, <bhe@redhat.com>, <dyoung@redhat.com>,
	<chenhaixiang3@huawei.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<yeweihua4@huawei.com>, <kexec@lists.infradead.org>, <x86@kernel.org>
Subject: [RFC PATCH] x86: efi: Reserve all boot services regions to avoid memory reservation conflicts
Date: Mon, 17 Jun 2024 19:11:53 +0800
Message-ID: <20240617111153.1945652-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)

We encountered a conflict between kdump crashkernel reserved memory and
bgrt reserved image_address memory:

  # cat /proc/iomem
  ...
  2d4fd058-60efefff : System RAM
    2d4fd058-58ffffff : System RAM
      49000000-58ffffff : Crash kernel
        53cbd000-53ccffff : Reserved <== Rrserved by bgrt
  ...

This resulted in the kexec tool generating incorrect e820 tables and the
kdump kernel failed to boot. After analysis, the reason for the memory
reservation conflict is that the mem_attr_table memory falls into an
EFI_BOOT_SERVICES_DATA region, and efi_memattr_init() reserved some of
the memory in this region, efi_reserve_boot_services() not fully
reserving this memory region. The bgrt image_address memory happens to
be in this region as well, thus the memory for bgrt image_address fails
to be reserved in advance. Full details are in [1].

To resolve conflicts, we may need to reserve all EFI_BOOT_SERVICES_DATA
memory in efi_reserve_boot_services(), even if there is an overlap with
other reserved areas.

[1] https://lore.kernel.org/all/ZfjshNK7Nbdz1de3@MiWiFi-R3L-srv/T/#me0e8a206833d1e6caf962b9e2c0c204bf966c769

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 arch/x86/platform/efi/quirks.c | 35 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..02863f0305db 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -337,10 +337,26 @@ void __init efi_reserve_boot_services(void)
 		    md->type != EFI_BOOT_SERVICES_DATA)
 			continue;
 
+		/*
+		 * Checks if the current region has been partially or fully
+		 * reserved by someone else.
+		 */
 		already_reserved = memblock_is_region_reserved(start, size);
 
 		/*
-		 * Because the following memblock_reserve() is paired
+		 * If someone else has already reserved part of the EFI Boot
+		 * Data region (e.g. efi_memattr_init()), we should also
+		 * reserve the remaining part. This is because some efi drivers
+		 * rely on reserving EFI Boot Data here in advance, such as
+		 * bgrt (see efi_bgrt_init()), otherwise the memory reserved
+		 * by bgrt via efi_mem_reserve() will conflict with the memory
+		 * reserved by others via memblock_reserve(). So here
+		 * unconditionally reserve the whole EFI Boot Data region.
+		 */
+		memblock_reserve(start, size);
+
+		/*
+		 * Because the above memblock_reserve() is paired
 		 * with memblock_free_late() for this region in
 		 * efi_free_boot_services(), we must be extremely
 		 * careful not to reserve, and subsequently free,
@@ -352,18 +368,13 @@ void __init efi_reserve_boot_services(void)
 		 * freed is page zero (first 4Kb of memory), which may
 		 * contain boot services code/data but is marked
 		 * E820_TYPE_RESERVED by trim_bios_range().
+		 *
+		 * If we are the first to reserve the region, no
+		 * one else cares about it. We own it and can
+		 * free it later.
 		 */
-		if (!already_reserved) {
-			memblock_reserve(start, size);
-
-			/*
-			 * If we are the first to reserve the region, no
-			 * one else cares about it. We own it and can
-			 * free it later.
-			 */
-			if (can_free_region(start, size))
-				continue;
-		}
+		if (!already_reserved && can_free_region(start, size))
+			continue;
 
 		/*
 		 * We don't own the region. We must not free it.
-- 
2.25.1


