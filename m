Return-Path: <linux-efi+bounces-4588-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC34EB3019F
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 20:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F96EAC3D81
	for <lists+linux-efi@lfdr.de>; Thu, 21 Aug 2025 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061323431FC;
	Thu, 21 Aug 2025 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="FMJDIcw4"
X-Original-To: linux-efi@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B95F342CBB;
	Thu, 21 Aug 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799268; cv=none; b=TUa3vkpQBexzX3y97djrwniFqUSzuIv2rfV5Arzo8hvx3bFnZpOYl8Zuogqy0oQZh54iSsWomxrTuQhp3U09+739udWmOj39+KuYuRorPfaYsaK/njXLONAg87T5ctlL6QCIUljUqPYnd25D/LEmrSVxMDZAJTKiUfSLia9Ash4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799268; c=relaxed/simple;
	bh=rEtxinEc1D9MarngEsf9lbcJy0xhF9k7LLDE09YZ6F4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTiuefm5opQcgaRvvXiqI5McU9HPDtVmAw4fyzEJZm9TB+A9amOAaG02IYC3E3enEPHo06/PRU3Wf1dZfapYZzH8Nwa44aT2AO58hgD2eDwsW/mCvMCDAXfhfX+CDXAfepBx6mKsGgRqPTbSAZHxjXtlroz42Ku7iK+oXU4tkA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=FMJDIcw4; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1755799267; x=1787335267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAejoY8V8yKY210FgQYVrnGosOJpV+P2BaPXX7POKoM=;
  b=FMJDIcw4Em/6twJf89D2wKv03UvdxEQv2hQqG9KnnsvrvNtGGODyEGXE
   X1QodcdtTMDvxb/nwHTiCoKwjucyHdzIk/2MdVknTd2eb69OqeTH3+9ll
   phCxpn45MGmvvioXRKQBXm2NAkwb68gT2UpUMEVAV+uxEuIiNQwdu9lv8
   4xmh2xplKQ8mjBFWSVax3d8k8AiAB2VVgRdYiLGTiH2aE/GPNCumaC92Q
   Za7KE3DAjEB4NxvzNLfpLbQIemxsEzmI8QdO4twav0OQzl+W2BQnMncHN
   kuMovCiTuqtwDGRhFflgHAfiPb7nb/udlCjJnwk6J+S6uqyRo0BQh4Gr1
   A==;
X-CSE-ConnectionGUID: YrrezCWoR5CjuQvlqk0NUg==
X-CSE-MsgGUID: vpO2okg8Q9eLRPjnNyfjuA==
X-IronPort-AV: E=Sophos;i="6.17,309,1747699200"; 
   d="scan'208";a="1451197"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 17:59:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:61839]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.67:2525] with esmtp (Farcaster)
 id 107f8fd8-d666-4959-a00a-c9bafbb3e9e6; Thu, 21 Aug 2025 17:59:57 +0000 (UTC)
X-Farcaster-Flow-ID: 107f8fd8-d666-4959-a00a-c9bafbb3e9e6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Thu, 21 Aug 2025 17:59:56 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17; Thu, 21 Aug 2025
 17:59:54 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@kernel.org>
CC: Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf
	<graf@amazon.com>, Changyuan Lyu <changyuanl@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	<kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nh-open-source@amazon.com>
Subject: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
Date: Thu, 21 Aug 2025 17:59:00 +0000
Message-ID: <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1755721529.git.epetron@amazon.de>
References: <cover.1755721529.git.epetron@amazon.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
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

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
---
Changes in v3:
	- Improve the code comments, by stating that the scratch regions are
	good known memory

Changes in v2:
	- Replace the for loop with for_each_mem_region
	- Fix comment indentation
	- Amend commit message to specify that scratch regions
	are known good regions

 drivers/firmware/efi/efi-init.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index a00e07b853f2..a65c2d5b9e7b 100644
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
@@ -164,12 +165,32 @@ static __init void reserve_regions(void)
 		pr_info("Processing EFI memory map:\n");
 
 	/*
-	 * Discard memblocks discovered so far: if there are any at this
-	 * point, they originate from memory nodes in the DT, and UEFI
-	 * uses its own memory map instead.
+	 * Discard memblocks discovered so far except for KHO scratch
+	 * regions. Most memblocks at this point originate from memory nodes
+	 * in the DT and UEFI uses its own memory map instead. However, if
+	 * KHO is enabled, scratch regions, which are good known memory
+	 * must be preserved.
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


