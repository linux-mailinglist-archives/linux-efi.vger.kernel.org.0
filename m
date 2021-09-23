Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1158141595A
	for <lists+linux-efi@lfdr.de>; Thu, 23 Sep 2021 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbhIWHpl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 23 Sep 2021 03:45:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239729AbhIWHpW (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 23 Sep 2021 03:45:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E807D61038;
        Thu, 23 Sep 2021 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632383031;
        bh=ISUQEAeabD8TFuzFwCipkjqJm558AV8oII+raBjMcR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qp4PlSy1I2qLdHfiL+6LZq+DtUAW0BZNW8wWana91BkCU23YNyluYXPn3qRTLPtZv
         nKeiyUiksdKxzzSpxVSgam85AgBf4/Oi9IBa05SDCS8Vhd7zIdAhFgm+m6hDjh46y+
         zgSAUfDAyTkvZojIS/HqTJ8bHsBPWFPJqCUkPfRiYtndeE5czEFfrL7O0vHSE7G8ps
         raokz57MNdzvGevCOJ7eHnUIMwrQwINX3LVGYRMX+O8ir8PikcZnvpGJvgoQZnchBJ
         rPqRejbi67XM5nP4AeGEbzjUVLZdJqRjdH9jyG3N+kSrB2M0hOUOUOmwRt0L5pnKJd
         hgPAAvvP+k1Gw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        kasan-dev@googlegroups.com, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/3] arch_numa: simplify numa_distance allocation
Date:   Thu, 23 Sep 2021 10:43:33 +0300
Message-Id: <20210923074335.12583-2-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210923074335.12583-1-rppt@kernel.org>
References: <20210923074335.12583-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Memory allocation of numa_distance uses memblock_phys_alloc_range() without
actual range limits, converts the returned physical address to virtual and
then only uses the virtual address for further initialization.

Simplify this by replacing memblock_phys_alloc_range() with
memblock_alloc().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/base/arch_numa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 00fb4120a5b3..f6d0efd01188 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -275,15 +275,13 @@ void __init numa_free_distance(void)
 static int __init numa_alloc_distance(void)
 {
 	size_t size;
-	u64 phys;
 	int i, j;
 
 	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
-	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0, PFN_PHYS(max_pfn));
-	if (WARN_ON(!phys))
+	numa_distance = memblock_alloc(size, PAGE_SIZE);
+	if (WARN_ON(!numa_distance))
 		return -ENOMEM;
 
-	numa_distance = __va(phys);
 	numa_distance_cnt = nr_node_ids;
 
 	/* fill with the default distances */
-- 
2.28.0

