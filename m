Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92165215D1F
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jul 2020 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgGFR0y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Jul 2020 13:26:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41526 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgGFR0i (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Jul 2020 13:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056424; x=1625592424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YBy5J4GUHkZ0slWQ+5rpmDzLOi4g2OFkey3S0ni3vEo=;
  b=PFGewPP7ayoTZyE4jgdS85bAEMPqajiUUT5aqmngXuqhP73K7Lo+dX74
   KEDIL+jT0p51kjR0TAacBnO4S5+4HnQai70Nxsr+EFX+pjNeucHDB/HsT
   TAvnVaT4pJgj4iV30/IjOmpL2zxRID2rHTHDOxGijgsc/6e4Ow0oBs3it
   jt0/FNsAA+rJS3fpsNZIp25OF6Q4qQaM2AixCZU4SCfX/BRwr0LPKJnq0
   RXsaEilvUgsFFhf2fvynABe/ln7fPga7njSduK7XGHC51hWkfOsOTQGmM
   H2F7Vr/57qWiYyxkpesT9V/zq/FK5wvhmYRbkOdtJ1eHlNCutnEQ0lFc0
   g==;
IronPort-SDR: BJa7zV3zaBNC/5tE1BxfVhQBAQOPVYz52vGWH1VBP1Fczb+ydz+bnIhioklrvyz3pez2T58Pn4
 Ip/7UPOOanVF5EK+GZ77/oJ8p9CZ4ElyMfZ2V4Tx9QBc3Zmrkb/st1cwlc7IY/D21Oasch6G1c
 6QZSdywM7JjEzi/lPmwzc5Dhmi3S51Y89WncKaXMGmBFsN8SDsCMBZOsntupnTF2mZuJ8pINm0
 0qWXWZsSrgmu4li7EMEE4A7fB5s8m8YSudca4+EYvcQkaGXz+pD0k0n6IxK2WzIPyQz7TEgsIQ
 G9g=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770185"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:54 +0800
IronPort-SDR: 3dWBVWhmKn9GXS7z1KhDUQVzrJ9RDwMH6Yt0WKbEHyx4NSKPLShyCDXJECj23AmqyEZaOkb+d6
 q/xEJsc+Sle5rcSVuSZ9WHSGsRqdnEMeE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:40 -0700
IronPort-SDR: VTlm1Z5/SAZEFPfrVJo8CE7qDDYpBSCOWNrJGIMyzYAvnvv9cofETJc83FHruK4hWLEkD67X8x
 qpNsYOLyOR6A==
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
Subject: [RFC PATCH v2 06/11] riscv: Parse all memory blocks to remove unusable memory
Date:   Mon,  6 Jul 2020 10:26:04 -0700
Message-Id: <20200706172609.25965-7-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
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

