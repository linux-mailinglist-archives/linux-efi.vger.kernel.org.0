Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C460C48A17F
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbiAJVJM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:09:12 -0500
Received: from smtp-fw-80007.amazon.com ([99.78.197.218]:17459 "EHLO
        smtp-fw-80007.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343830AbiAJVJD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 16:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1641848944; x=1673384944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3mAfbygsmalJDceTYZOaldGWaMo2oFy/FRm2NURPlA0=;
  b=KS8AmUNlSStP0MSt3503WDFRbsAyFiGnY08p8xL4GUhsTjrtz366prJj
   e3oav2KsGQMF96ZxCUjantfZmch8kQY7zcZzl+0hi+oNwO6xGTvYd2u4U
   T4cEd4mbjx0tqjekZ0Mib0fNBRgt6jlnDkilI24dHkvcTcrDPOpMxq5XX
   M=;
X-IronPort-AV: E=Sophos;i="5.88,278,1635206400"; 
   d="scan'208";a="54264531"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-b09d0114.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 10 Jan 2022 21:09:03 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-b09d0114.us-east-1.amazon.com (Postfix) with ESMTPS id 9DB4F81162;
        Mon, 10 Jan 2022 21:08:58 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:29 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.26 via Frontend Transport; Mon, 10 Jan 2022 21:08:28
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 91F88A1; Mon, 10 Jan 2022 21:08:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-arm-kernel@lists.infradead.org>, <rppt@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <ardb@kernel.org>,
        <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <geert+renesas@glider.be>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 2/3] of: fdt: use memblock usable range interface
Date:   Mon, 10 Jan 2022 21:08:08 +0000
Message-ID: <20220110210809.3528-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220110210809.3528-1-fllinden@amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Use the memblock usable range interface to set and enforce the
usable memory range (if any).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 drivers/of/fdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4546572af24b..b3c2a4124518 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1279,7 +1279,8 @@ void __init early_init_dt_scan_nodes(void)
 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
 
 	/* Handle linux,usable-memory-range property */
-	memblock_cap_memory_range(cap_mem_addr, cap_mem_size);
+	memblock_set_usable_range(cap_mem_addr, cap_mem_size);
+	memblock_enforce_usable_range();
 }
 
 bool __init early_init_dt_scan(void *params)
-- 
2.32.0

