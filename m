Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BA24317C
	for <lists+linux-efi@lfdr.de>; Thu, 13 Aug 2020 01:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHLXsl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Aug 2020 19:48:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52585 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgHLXsk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Aug 2020 19:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597276121; x=1628812121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+GUmN6ZNbnCfom5PIzX3LeRfgAzIkaN7Tqfa0vPyyjQ=;
  b=CoXxKJfsZJRacKje4kb1yDwcSI10/69AmroIPEfDMwCxtNiIxrI907O7
   aBhiHbav5eEIYhIARj/zg64TPUiBwSwZA+bIevBDsLgA6h2PdhhVAetXI
   jAleGnI0W0IjqywCG3KVUe4lPmseVC0WRR6htGlAabzMfQ+0OsD0wvlh1
   +mSJRrBt9Vtf+1RMs1Lj4OvGB+3yprvNYA5MiUu5eakB04/Zfi+HR56xX
   BH3gzUgJKL6d4/qpCaZcb1Xk+IoqniRMMNNlGAbeKJrUFONCxJbe0JS2V
   qhQTmbzKVkmPeoPTFH7gHBeJO2oNWednWHYadhkLxU7ywTitiGvgTn0JL
   A==;
IronPort-SDR: aP/zTxAVhcg2dnSOj0ebiL5Vu1TLm8HRcoMb2F6nbar+3O6TrYzBQi1s/P+jQ/vkxR6aeS07+Q
 ksfVA7JsBLja8bAOtYF21jy8tStgR2Usj1ZfxBq1unZtvbeToYsinGIaCMnWXNJx1Ym0495v+G
 KtRYusBsKkSCApSNeHZc4PAnzbWcsovqOP4Qtb5X2LE/5B4AKeuMDIzEyp7VrQGprN48QfRgaO
 +HzfkYMk5Kf58x6ZAsopPD2HBDOgEmldxU2u/00nYpVzKVkyM5h3hul8oxhjLALZIK6Uoj6djF
 QaA=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; 
   d="scan'208";a="149145685"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 07:48:41 +0800
IronPort-SDR: x7u/WshrZBpEkb8L6IGM9xGMFfrg5Nzwaq9N82lMgt7L2H/WcP3sz2IwUsOELlp1Qs76XP6v7B
 mnclK2el9Epw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 16:35:48 -0700
IronPort-SDR: +dohAHaMuF1o8j5s1cDIdOlHT73r5kwjnOFq7A391KyQ4LoM78TkSFfhC92PLeyjGeeBrg5iZf
 ti8uYKCVytVQ==
WDCIronportException: Internal
Received: from usa002576.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.59])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 16:48:37 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, fwts-devel@lists.ubuntu.com,
        Mao Han <han_mao@c-sky.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v5 9/9] RISC-V: Add page table dump support for uefi
Date:   Wed, 12 Aug 2020 16:47:58 -0700
Message-Id: <20200812234758.3563-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200812234758.3563-1-atish.patra@wdc.com>
References: <20200812234758.3563-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Extend the current page table dump support in RISC-V to include efi
pages as well.

Here is the output of efi runtime page table mappings.

---[ UEFI runtime start ]---
0x0000000020002000-0x0000000020003000 0x00000000be732000 4K PTE D A . . . W R V
0x0000000020018000-0x0000000020019000 0x00000000be738000 4K PTE D A . . . W R V
0x000000002002c000-0x000000002002d000 0x00000000be73c000 4K PTE D A . . . W R V
0x0000000020031000-0x0000000020032000 0x00000000bff61000 4K PTE D A . . X W R V
---[ UEFI runtime end ]---

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/ptdump.c | 48 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 0831c2e61a8f..ace74dec7492 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2019 SiFive
  */
 
+#include <linux/efi.h>
 #include <linux/init.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -49,6 +50,14 @@ struct addr_marker {
 	const char *name;
 };
 
+/* Private information for debugfs */
+struct ptd_mm_info {
+	struct mm_struct		*mm;
+	const struct addr_marker	*markers;
+	unsigned long base_addr;
+	unsigned long end;
+};
+
 static struct addr_marker address_markers[] = {
 #ifdef CONFIG_KASAN
 	{KASAN_SHADOW_START,	"Kasan shadow start"},
@@ -68,6 +77,28 @@ static struct addr_marker address_markers[] = {
 	{-1, NULL},
 };
 
+static struct ptd_mm_info kernel_ptd_info = {
+	.mm		= &init_mm,
+	.markers	= address_markers,
+	.base_addr	= KERN_VIRT_START,
+	.end		= ULONG_MAX,
+};
+
+#ifdef CONFIG_EFI
+static struct addr_marker efi_addr_markers[] = {
+		{ 0,		"UEFI runtime start" },
+		{ SZ_1G,	"UEFI runtime end" },
+		{ -1,		NULL }
+};
+
+static struct ptd_mm_info efi_ptd_info = {
+	.mm		= &efi_mm,
+	.markers	= efi_addr_markers,
+	.base_addr	= 0,
+	.end		= SZ_2G,
+};
+#endif
+
 /* Page Table Entry */
 struct prot_bits {
 	u64 mask;
@@ -245,22 +276,22 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr,
 	}
 }
 
-static void ptdump_walk(struct seq_file *s)
+static void ptdump_walk(struct seq_file *s, struct ptd_mm_info *pinfo)
 {
 	struct pg_state st = {
 		.seq = s,
-		.marker = address_markers,
+		.marker = pinfo->markers,
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
 			.range = (struct ptdump_range[]) {
-				{KERN_VIRT_START, ULONG_MAX},
+				{pinfo->base_addr, pinfo->end},
 				{0, 0}
 			}
 		}
 	};
 
-	ptdump_walk_pgd(&st.ptdump, &init_mm, NULL);
+	ptdump_walk_pgd(&st.ptdump, pinfo->mm, NULL);
 }
 
 void ptdump_check_wx(void)
@@ -293,7 +324,7 @@ void ptdump_check_wx(void)
 
 static int ptdump_show(struct seq_file *m, void *v)
 {
-	ptdump_walk(m);
+	ptdump_walk(m, m->private);
 
 	return 0;
 }
@@ -308,8 +339,13 @@ static int ptdump_init(void)
 		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
 			pg_level[i].mask |= pte_bits[j].mask;
 
-	debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
+	debugfs_create_file("kernel_page_tables", 0400, NULL, &kernel_ptd_info,
 			    &ptdump_fops);
+#ifdef CONFIG_EFI
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		debugfs_create_file("efi_page_tables", 0400, NULL, &efi_ptd_info,
+				    &ptdump_fops);
+#endif
 
 	return 0;
 }
-- 
2.24.0

