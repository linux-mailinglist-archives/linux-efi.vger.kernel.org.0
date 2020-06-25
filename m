Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27D20A963
	for <lists+linux-efi@lfdr.de>; Fri, 26 Jun 2020 01:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgFYXp3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Jun 2020 19:45:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:4091 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgFYXp2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Jun 2020 19:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593128727; x=1624664727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e1f5tFToh6jF2Fr3c6Bri7MNiVrYpT85jVmyBw2a1o8=;
  b=m2g3X/X97ZnejNVH+0H0YGOdYfRxqSmWdb3qcY0yvPouNFrwA6bJo1wu
   LLj44Or+jFf6+NPHt+WA67oVfvBeJ5APxAvyzyTgLLoNgkKls4HqJLpZQ
   wbhurwGLi5VMAzLD9y9PJXdlI+PHWYmks+iQg7MtahKqWWR7GiX9k/4NX
   OEhcrF0zQSAnLR014mL8I84hSQoWioyyAQV6ZQrFtUcCOPYtQn7dVim3L
   Fc5mx8GaAy3OYWLYX76swNp3RhHrgz+5p+2udiLMgKc7xVazVKQDhkMHq
   8mSU2qewvPu2CVIXtdGDTXqxGD6Enyhd1punU8czCUJBv396Nq614l43T
   Q==;
IronPort-SDR: qX1qg5jeylABftySsqZzHFj07feV4/u2Ek6lzIUrcOBXCcLf2izTsDK7Lg9MpM13iv4GndSiFH
 WHUOCTDjTl7sFzHY/ThYQguAiBv7La+UbzlaSM63byekIzXbmW2X/V92Ta0UAD1ZORoO1QZlR5
 5RRnncmrWkDQiKI9i/nxBTWGTjYdi8o0YlkFm868heSaefHtdHDwKiFZGAzwWorh/4aHGMKbLM
 hgTFyioa6u37YIIEPhCD6VZmZxq0BMgzrwsmJJnWkXkIM2ZZmdd9BM2+AXsSQx6OwVCF6eqcCQ
 uRE=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; 
   d="scan'208";a="140953458"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 07:45:26 +0800
IronPort-SDR: HXJziFOxcWoQuCNpJ4F0qvmPIyk/65NHqTXHkTS6UtZPT+hLX1Q7bKSl0oQL/AeTuC/HugEVNt
 pegJFmyErxe83AiZf5xKh3R6qyXy5a9Vw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 16:34:26 -0700
IronPort-SDR: x27YsbO1KVXuwcO1coWKuCCOUz0CEkeOSTXMxHLCyjOMlyEdoh9s5hWmoxbaG9WTGee2GcC+DR
 DbQR7vLieVwg==
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
Subject: [RFC PATCH 05/11] RISC-V: Set maximum number of mapped pages correctly
Date:   Thu, 25 Jun 2020 16:45:10 -0700
Message-Id: <20200625234516.31406-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200625234516.31406-1-atish.patra@wdc.com>
References: <20200625234516.31406-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Currently, maximum number of mapper pages are set to the pfn calculated
from the memblock size of the memblock containing kernel. This will work
until that memblock spans the entire memory. However, it will be set to
a wrong value if there are multiple memblocks defined in kernel
(e.g. with efi runtime services).

Set the the maximum value to the pfn calculated from dram size.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bad60686d080..4021706aef81 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -147,9 +147,9 @@ void __init setup_bootmem(void)
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	set_max_mapnr(PFN_DOWN(mem_size));
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = max_pfn;
+	set_max_mapnr(max_low_pfn);
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	setup_initrd();
-- 
2.24.0

