Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C61520A959
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFYXp3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4086 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgFYXp2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128727; x=1624664727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBy5J4GUHkZ0slWQ+5rpmDzLOi4g2OFkey3S0ni3vEo=;
  b=BTZiBGmkQ94jPO+XVt45oz6t9i7R+w5X1Mhkb66OL6W4bj5quq0FlNAZ
   rsO9+r7CWji+wl5mtx/leiDuhPDqmO8Nv7oKMIwRSf7XxoEAQlpYZhtTu
   9aWY2lP6TMTZG7v4Lh01LXMMoWZ4Eer+iKknmNf51O4y4NjfEewS0BTmx
   0wjTk2RbNo2lWkF7kYldMsTfhqwPX/qS5nHFglJSB1t8JZoKcCAtAlrix
   Cip3RMF0mC31Mj2OIqTHE75v1lyTZJz/uf/TOuAf+p950dPs6SGjr+L9k
   K9bs7wCwtYhrDKpVCJp2wann57BrUyLSNOTau8rhHvwvfMg9ZOkGAM2sS
   g==;
IronPort-SDR: dEoQcvSX9taPkXp3+MU8iyUISvauAmtrrhYl+WuRbvkwJVyw4KPrmEvcWM3Imp6vaURyn3rZnK
 rSslBWbewJgaJ9yuEMjOsFj5kNUDrD4+2QIzSjNTqRFRTZfn6pwcz3k6zc2fPRv/RQwfxbhrCb
 EGepgHBrCZ5AvS8/9R971KcCuMTLsV+RdVVUS0PfES580rkIuaC74b4pXmqamBqTJVLxljkt8B
 5ozRyFgAN4vTdDRpaapgq951Ilu272mZWjLQDHvJ/CRlXaoUv7Bc6PgA98fCOjG4H/MLeMGcfe
 GHE=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953462"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:26 +0800
IronPort-SDR: Yzri6BT2XllofHLQXlVfX6AnpCw2JkeLrQrjeQYik9w2GxTzy42rN8BiX7XGU20fMyfrCyQZ1i
 IsDs9K00DcXk7zByn932TJ7632x4+ARrk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:26 -0700
IronPort-SDR: omPnXbB+TYLoTkN1Npd9t1nvmQHGX5tG5Znu8goYNz213K5CBAQXt/9Te3XTTQppRyp0s8My2s
 L3qp9Y90whDQ==
WDCIronportException: Internal
Received: from 2349pbt5e4f.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.78])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Jun 2020 16:45:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 06/11] riscv: Parse all memory blocks to remove unusable memory
Date:   Thu, 25 Jun 2020 16:45:11 -0700
Message-Id: <20200625234516.31406-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, maximum physical memory allowed is equal to -PAGE_OFFSET.
That's why we remove any memory blocks spanning beyond that size. However,
it is done only for memblock containing linux kernel which will not work
if there are multiple memblocks.

Process all memory blocks to figure out how much memory needs to be removed
and remove at the end instead of updating the memblock list in place.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4021706aef81..c5268fe6e6de 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -123,26 +123,29 @@ void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
 	phys_addr_t mem_size = 0;
+	phys_addr_t total_mem = 0;
+	phys_addr_t mem_start, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
-		phys_addr_t end = reg->base + reg->size;
-
-		if (reg->base <= vmlinux_start && vmlinux_end <= end) {
-			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
-
-			/*
-			 * Remove memblock from the end of usable area to the
-			 * end of region
-			 */
-			if (reg->base + mem_size < end)
-				memblock_remove(reg->base + mem_size,
-						end - reg->base - mem_size);
-		}
+		end = reg->base + reg->size;
+		if (!total_mem)
+			mem_start = reg->base;
+		if (reg->base <= vmlinux_start && vmlinux_end <= end)
+			BUG_ON(reg->size == 0);
+		total_mem = total_mem + reg->size;
 	}
-	BUG_ON(mem_size == 0);
+
+	/*
+	 * Remove memblock from the end of usable area to the
+	 * end of region
+	 */
+	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
+	if (mem_start + mem_size < end)
+		memblock_remove(mem_start + mem_size,
+				end - mem_start - mem_size);
 
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
-- 
2.24.0

