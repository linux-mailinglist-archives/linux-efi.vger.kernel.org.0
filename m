Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A548A180
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jan 2022 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343834AbiAJVJN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Jan 2022 16:09:13 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:51403 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343832AbiAJVJE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Jan 2022 16:09:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1641848943; x=1673384943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YIWq81r60zfkEYgTyv+1nuUbOltX8pQmAlK88kahj7U=;
  b=LHO7P3IoxEdgs725qfi/x6LDvcfDDc8qkxj96nOdhYlM73sJSKBjkxUH
   PgdD0jsaU+cv/8CwqItycOA8QGQ2fa5dm8nrNgYRhoaZYdyDoQfiQKc7l
   pWqeK1E3lfXW1UoPEViz1sq2gTNroz+jkeZgj4z34dH9g3LCxYOEYTUu1
   Q=;
X-IronPort-AV: E=Sophos;i="5.88,278,1635206400"; 
   d="scan'208";a="983755819"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 10 Jan 2022 21:09:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-10222bbc.us-east-1.amazon.com (Postfix) with ESMTPS id 478641A0040;
        Mon, 10 Jan 2022 21:08:59 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.26; Mon, 10 Jan 2022 21:08:30 +0000
Received: from dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com
 (172.19.206.175) by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP
 Server id 15.0.1497.26 via Frontend Transport; Mon, 10 Jan 2022 21:08:29
 +0000
Received: by dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 92312B5F; Mon, 10 Jan 2022 21:08:29 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-arm-kernel@lists.infradead.org>, <rppt@kernel.org>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>, <ardb@kernel.org>,
        <linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <geert+renesas@glider.be>,
        Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 3/3] efi: enforce usable memory range after reserving regions
Date:   Mon, 10 Jan 2022 21:08:09 +0000
Message-ID: <20220110210809.3528-4-fllinden@amazon.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220110210809.3528-1-fllinden@amazon.com>
References: <20220110210809.3528-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The usable memory range may be restricted through parameters that
did not come from EFI, like the FDT "linux,usable-memory-range"
property.

Enforce this range after the EFI memory map regions have been
processed.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 drivers/firmware/efi/efi-init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index b19ce1a83f91..280e9178c7df 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -204,6 +204,13 @@ static __init void reserve_regions(void)
 				memblock_reserve(paddr, size);
 		}
 	}
+
+	/*
+	 * Done, filter !nomap memory we just added so that the
+	 * usable range is enforced. This is normally only set
+	 * for crash kernels on some architectures.
+	 */
+	memblock_enforce_usable_range();
 }
 
 void __init efi_init(void)
-- 
2.32.0

