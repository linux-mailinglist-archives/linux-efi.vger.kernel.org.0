Return-Path: <linux-efi+bounces-4521-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C6B1ED12
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 18:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782851C2530E
	for <lists+linux-efi@lfdr.de>; Fri,  8 Aug 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1353286D6B;
	Fri,  8 Aug 2025 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="QE4jaMU3"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6C725228C;
	Fri,  8 Aug 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754671034; cv=none; b=KctjphZyIbo+FFX3jHt8XWGuU7AZ0D01AMSNl4PYX+PCrMB9u6tc6R3I2LXnZ0acfQFxLb3YJJ0f1CbuAdy0VhHjNuoVcvkPI2jpBt5Y2RuPRIMbJVe1NkJnxk0ADXWuQwr7sprLNMzxCWHOeZ2U0MCAoaHG3Cl53HunEqhhF4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754671034; c=relaxed/simple;
	bh=3Dl6MJPx/URR6SAPv81/CgcJ3/9AtJtJXM6jyyAUvQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SUlUhSp2wDf7mYlX6BS0aE8vXXnH2QaWPMEyc1Q+8qidosLeogIpPxfbGX8y04KtBwlnhBLvi6/AGYEMGI2uihDdhEIZ56XWmUncMDEb5/SrG1ZtmAW3Jt4Hygin6VshQOPHERqyAMOREQ2OxAFkkNJRvABkjUofJpcWPoF0LWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=QE4jaMU3; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1754671033; x=1786207033;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VQqGKx8yCcMPM3OfBvB/9sDgA5FM7b1V6O0IxKuT2Ng=;
  b=QE4jaMU3WQJu27dJJ70cW2zPbIeL8lW6v0pWaPO1rGO9ENfVXdecolw6
   wPbDLSZb8LknYKmc/s3nNQxeRllxvNi9HRSZpyJo7+7GHYiQ2cv+YTDzx
   jLXkykwuwJc+5FE5sL7u7AjJbXClF38tMV0yOX1H0ipFaXLRuYoJq/cnF
   eUzzV4vqZukkXyFuysVrXQwn+AnVKyQsJL7eVOY8MkN+tepKl1hfxo2UN
   2d0LPFRXB3/ZQFLz2xyVlKRbGEsH8nl8zxPf4CV3VuOwZY5yp6ZZz0K3D
   cnpxrfH4QGtNnP/8lKpl0qpTscwdN6g8XAQYMGYFegpO+LO27xukbgVt/
   g==;
X-IronPort-AV: E=Sophos;i="6.17,274,1747699200"; 
   d="scan'208";a="746124479"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 16:37:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:41049]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.11:2525] with esmtp (Farcaster)
 id d1a47885-9ae3-49af-a06a-0b2fb4acfb5c; Fri, 8 Aug 2025 16:37:09 +0000 (UTC)
X-Farcaster-Flow-ID: d1a47885-9ae3-49af-a06a-0b2fb4acfb5c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 8 Aug 2025 16:37:08 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Fri, 8 Aug 2025
 16:37:06 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: <ardb@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu
	<changyuanl@google.com>, <kexec@lists.infradead.org>,
	<nh-open-source@amazon.com>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] efi: Support booting with kexec handover (KHO)
Date: Fri, 8 Aug 2025 16:36:51 +0000
Message-ID: <20250808163651.25279-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When KHO (Kexec HandOver) is enabled, it sets up scratch memory regions
early during device tree scanning. After kexec, the new kernel
exclusively uses this region for memory allocations during boot up to
the initialization of the page allocator

However, when booting with EFI, EFI's reserve_regions() uses
memblock_remove(0, PHYS_ADDR_MAX) to clear all memory regions before
rebuilding them from EFI data. This destroys KHO scratch regions and
their flags, thus causing a kernel panic, as there are no scratch
memory regions.

Instead of wholesale removal, iterate through memory regions and only
remove non-KHO ones. This preserves KHO scratch regions while still
allowing EFI to rebuild its memory map.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---

Reproduction/Verification Steps
The issue and the fix can be reproduced/verified by booting a VM with
EFI and attempting to perform a KHO enabled kexec. The fix
was developed/tested on arm64.

 drivers/firmware/efi/efi-init.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f22..2f08b1ab764f6 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -164,12 +164,35 @@ static __init void reserve_regions(void)
 		pr_info("Processing EFI memory map:\n");
 
 	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
+	 * Discard memblocks discovered so far except for KHO scratch regions.
+	 * Most memblocks at this point originate from memory nodes in the DT,
+	 * and UEFI uses its own memory map instead. However, if KHO is enabled,
+	 * scratch regions must be preserved.
 	 */
 	memblock_dump_all();
-	memblock_remove(0, PHYS_ADDR_MAX);
+
+	if (IS_ENABLED(CONFIG_MEMBLOCK_KHO_SCRATCH)) {
+		struct memblock_region *reg;
+		phys_addr_t start, size;
+		int i;
+
+		/* Remove all non-KHO regions */
+		for (i = memblock.memory.cnt - 1; i >= 0; i--) {
+			reg = &memblock.memory.regions[i];
+			if (!memblock_is_kho_scratch(reg)) {
+				start = reg->base;
+				size = reg->size;
+				memblock_remove(start, size);
+			}
+		}
+	} else {
+	/*
+	 * KHO is disabled. Discard memblocks discovered so far: if there
+	 * are any at this point, they originate from memory nodes in the
+	 * DT, and UEFI uses its own memory map instead.
+	 */
+		memblock_remove(0, PHYS_ADDR_MAX);
+	}
 
 	for_each_efi_memory_desc(md) {
 		paddr = md->phys_addr;
-- 
2.43.0




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


