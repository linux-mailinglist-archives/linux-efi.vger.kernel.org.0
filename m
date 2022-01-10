Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A465D48A17C
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbiAJVI7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:08:59 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:44432 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343809AbiAJVI7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 16:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1641848940; x=1673384940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXSIRuBHoh28PI4X24VkzI5Tw/8El6+B/ZMgWJ8og94=;
  b=g7PTGI0Q6YKJzb4LqoB2PbgMUvywG4X+9q8Y0yjfquaZGt8EbqrNwaJg
   Gcu/B6X4JES0xZOFIdloBY6514iUvkkryiNobVGjWw4zwbXRbqwQkI4hW
   fx/Uz4NAHS6g2LOIBCKaXCz+/oIQxYYQkiggK3kanR0kD4FcAvg/DAyJj
   Q=;
X-IronPort-AV: E=Sophos;i="5.88,278,1635206400"; 
   d="scan'208";a="169221590"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 10 Jan 2022 21:08:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-e823fbde.us-east-1.amazon.com (Postfix) with ESMTPS id 6C4FFC08AB;
        Mon, 10 Jan 2022 21:08:57 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:27 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.26 via Frontend Transport; Mon, 10 Jan 2022 21:08:27
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 7B3F9A1; Mon, 10 Jan 2022 21:08:27 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-arm-kernel@lists.infradead.org>, <rppt@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <ardb@kernel.org>,
        <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <geert+renesas@glider.be>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 1/3] memblock: define functions to set the usable memory range
Date:   Mon, 10 Jan 2022 21:08:07 +0000
Message-ID: <20220110210809.3528-2-fllinden@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220110210809.3528-1-fllinden@amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Some architectures might limit the usable memory range based
on a firmware property, like "linux,usable-memory-range"
for ARM crash kernels. This limit needs to be enforced after
firmware memory map processing has been done, which might be
e.g. FDT or EFI, or both.

Define an interface for it that is firmware type agnostic.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 include/linux/memblock.h |  2 ++
 mm/memblock.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 34de69b3b8ba..6128efa50d33 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -481,6 +481,8 @@ phys_addr_t memblock_reserved_size(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
+void memblock_set_usable_range(phys_addr_t base, phys_addr_t size);
+void memblock_enforce_usable_range(void);
 void memblock_cap_memory_range(phys_addr_t base, phys_addr_t size);
 void memblock_mem_limit_remove_map(phys_addr_t limit);
 bool memblock_is_memory(phys_addr_t addr);
diff --git a/mm/memblock.c b/mm/memblock.c
index 5096500b2647..cb961965f3ad 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -101,6 +101,7 @@ unsigned long max_low_pfn;
 unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
+phys_addr_t usable_start, usable_size;
 
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
@@ -1715,6 +1716,42 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
 			base + size, PHYS_ADDR_MAX);
 }
 
+/**
+ * memblock_set_usable_range - set usable memory range
+ * @base: physical address that is the start of the range
+ * @size: size of the range.
+ *
+ * Used when a firmware property limits the range of usable
+ * memory, like for the linux,usable-memory-range property
+ * used by ARM crash kernels.
+ */
+void __init memblock_set_usable_range(phys_addr_t base, phys_addr_t size)
+{
+	usable_start = base;
+	usable_size = size;
+}
+
+/**
+ * memblock_enforce_usable_range - cap memory ranges to usable range
+ *
+ * Some architectures call this during boot after firmware memory ranges
+ * have been scanned, to make sure they fall within the usable range
+ * set by memblock_set_usable_range.
+ *
+ * This may be called more than once if there are multiple firmware sources
+ * for memory ranges.
+ *
+ * Avoid "no memory registered" warning - the warning itself is
+ * useful, but we know this can be called with no registered
+ * memory (e.g. when the synthetic DT for the crash kernel has
+ * been parsed on EFI arm64 systems).
+ */
+void __init memblock_enforce_usable_range(void)
+{
+	if (memblock_memory->total_size)
+		memblock_cap_memory_range(usable_start, usable_size);
+}
+
 void __init memblock_mem_limit_remove_map(phys_addr_t limit)
 {
 	phys_addr_t max_addr;
-- 
2.32.0

