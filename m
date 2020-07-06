Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D09D215D15
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgGFR0j (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:26:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41526 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgGFR0h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056422; x=1625592422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e1f5tFToh6jF2Fr3c6Bri7MNiVrYpT85jVmyBw2a1o8=;
  b=M6/F2C8ZqWAg5r5MCcl68EcORmJ8sQ74mMlWkPhCBbx9ja/Vvvoi8UN1
   ciBwnB3it0BZzPU/cn/28MWCoANb6MHn4gOLXVVofsb5Y9A9+0K18fsw8
   Ig61ne3ZG5Yiva6+1qhpDXBoCwOWSaFRhRrdNVhjqdMbixUcryZogZr4h
   33HxRdSwkM154g3DdX/xv8tZnP0bVVzXok16IMxoBJOx25T+iOwq77dkG
   J1sbZH2YjKVPKa/WHFsBHTV+I4pXiDhhuqIbO+prZp8UkZaLW09wjfVsd
   puahU7R3l85Bj6sahUatl2JBAcuXh+mVKxIKkjX8XzcIjeaZPkM/MI7/H
   Q==;
IronPort-SDR: sfJ26p8s6AkQv0NEBfOlN/kgtZYkQjkgE5xqv6U2lScvIw5KG73eCbBZqLUAVp7WOn/Ch7BPLK
 ZrbT4MA+80QljzQIcX5DJLMyC+SSGx52DEa1qOTwqqH1vM1IxoXkCsP3ggAoF79cvqNehq4cm3
 vMVHVTNuQbm6kFGrojo7dC4e2uGX0o1FS/bUFpbBABgaM8qf2ZJBGP3ZW3Ej7S8gvfknQAZoNs
 rbgQACVomhrLN9buEN6Tsk8PPibv7RkqtT1S4H9xUDQBoO7+OrpVDkIFq9E9NXUk2UIu1UcZnJ
 RuA=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770182"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:53 +0800
IronPort-SDR: 05h9p5rfefIqdeGBqqE2bBTS5ye63Pph+oVeF5xq/JCysm3Gx7okmW8E2qK16aRwe9jmIOwYue
 r6OXxD91z80f3bwMi8SokLS4vBBxCim1w=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:39 -0700
IronPort-SDR: CHjz5i2GjUVTmaMZrAcRniyPnGuPcM9Gy5cG1qRK1yg2uNoB0XlDvdxeo/vNoIt0F32gPm//zW
 EI3N8t8F03OQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:31 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 05/11] RISC-V: Set maximum number of mapped pages correctly
Date:   Mon,  6 Jul 2020 10:26:03 -0700
Message-Id: <20200706172609.25965-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
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

