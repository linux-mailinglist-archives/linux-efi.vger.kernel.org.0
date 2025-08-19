Return-Path: <linux-efi+bounces-4573-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB9B2CFE0
	for <lists+linux-efi@lfdr.de>; Wed, 20 Aug 2025 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FE62A1006
	for <lists+linux-efi@lfdr.de>; Tue, 19 Aug 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69D248F51;
	Tue, 19 Aug 2025 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="KnpbVD6f"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5A921885A;
	Tue, 19 Aug 2025 23:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.77.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645971; cv=none; b=iEN5+oX1X92Zr+8yRZiO+bkdW/ujboy4mJ3+l2doaJF9RhIEqD+kh4m69VebFsZbzkAn9DKcS6KzVt3AaHi1fytPBV4PZ9ZDKiK6tpdTUSbiDNtl8Y6T8khR+RwNbh/hTy6IVjWlrY2V93Ge5h89sOdjQBE9eVFTn5VtO4TonZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645971; c=relaxed/simple;
	bh=0ECDqm7JCQ6QeKFXSeUl3cVeFXW3SXURQRlso2w+a7g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pd3QPFwrKxjHh5JaweRaEov8zw2tN9NaZyivWRd57WOhvx5HLlM3pncQ/Eo6ZK96PLl/vYLmS5YRdXypvj5dRytlz8tehEU/VBVK+CzNYYc1Xq18Ht+zxm9nTpRGQD5xw6zz/Jj8Vf5v6lNA5e2H7L/E881I3OE4oEoUP5tAXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=KnpbVD6f; arc=none smtp.client-ip=44.246.77.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755645970; x=1787181970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cd20LjcxPOsEg21zYy/cmh2I9QA1AIBt6CLKTzRjH7g=;
  b=KnpbVD6fOmEb3c4Q++WgGYpalpbQNfLt2KP3eB6dkv1VCYEed7bVE22f
   nK62bNOl8TmvNNt9gKu0eRckdBOWKRETsfeDC/TT2hACWb15bmWPuCg8u
   2izG2Jn/6DOJvn6jCWK1vaTJ830FNqW4zexp/VmvdEvWqrgpXVoARG4sz
   qmQBfuWGt5CtheUisrfN1P8lLr9u4w+As210ncUuylN9xPmz4Nyx2Gme1
   V6/3Kiz1QA/iKbhgWUkHN9neX6BMBdn5owXE3xfaM8SBfyji9A6hmoOCS
   vGBhW0X5Dy8Hw3RMvUyBZFGb2MOtObGspFCwcg2mUsdef7ytnevzEuwSC
   w==;
X-CSE-ConnectionGUID: vgDJ3wGLRkyBdDWeMGCc+w==
X-CSE-MsgGUID: znqb36LARvCDQs2S0Xz73Q==
X-IronPort-AV: E=Sophos;i="6.17,302,1747699200"; 
   d="scan'208";a="1403455"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 23:26:08 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:8848]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.170:2525] with esmtp (Farcaster)
 id 1f517b9c-a5d9-4ed2-9cc8-20113cac2a08; Tue, 19 Aug 2025 23:26:07 +0000 (UTC)
X-Farcaster-Flow-ID: 1f517b9c-a5d9-4ed2-9cc8-20113cac2a08
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 19 Aug 2025 23:26:07 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Tue, 19 Aug 2025
 23:26:05 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v2 2/2] efi: Support booting with kexec handover (KHO)
Date: Tue, 19 Aug 2025 23:22:46 +0000
Message-ID: <9e80381d4fafc71d6e0c64d69a8b3ac9c8949865.1755643201.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755643201.git.epetron@amazon.de>
References: <cover.1755643201.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
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
remove non-KHO ones. This preserves KHO scratch regions, which are
good known memory, while still allowing EFI to rebuild its memory map.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
Changes in v2:
	- Replaced the for loop with for_each_mem_region
	- Fixed comment indentation
	- Amended commit message to specify that scratch regions
	are known good regions

 drivers/firmware/efi/efi-init.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f2..99f7eecc320f 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/fwnode.h>
 #include <linux/init.h>
+#include <linux/kexec_handover.h>
 #include <linux/memblock.h>
 #include <linux/mm_types.h>
 #include <linux/of.h>
@@ -164,12 +165,31 @@ static __init void reserve_regions(void)
 		pr_info("Processing EFI memory map:\n");
 
 	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
+	 * Discard memblocks discovered so far except for KHO scratch
+	 * regions. Most memblocks at this point originate from memory nodes
+	 * in the DT and UEFI uses its own memory map instead. However, if
+	 * KHO is enabled, scratch regions must be preserved.
 	 */
 	memblock_dump_all();
-	memblock_remove(0, PHYS_ADDR_MAX);
+
+	if (is_kho_boot()) {
+		struct memblock_region *r;
+
+		/* Remove all non-KHO regions */
+		for_each_mem_region(r) {
+			if (!memblock_is_kho_scratch(r)) {
+				memblock_remove(r->base, r->size);
+				r--;
+			}
+		}
+	} else {
+		/*
+		 * KHO is disabled. Discard memblocks discovered so far:
+		 * if there are any at this point, they originate from memory
+		 * nodes in the DT, and UEFI uses its own memory map instead.
+		 */
+		memblock_remove(0, PHYS_ADDR_MAX);
+	}
 
 	for_each_efi_memory_desc(md) {
 		paddr = md->phys_addr;
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


