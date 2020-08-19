Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF724A95B
	for <lists+linux-efi@lfdr.de>; Thu, 20 Aug 2020 00:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHSWZK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 19 Aug 2020 18:25:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16020 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgHSWY4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 19 Aug 2020 18:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597875897; x=1629411897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zACmpNxMVkpKW6XFtwU9imKwJIzxQN1bq0wJXy/9ILY=;
  b=bx9vDkpGtdAsg3+ohp97Q8jISRVw2uLybAtvkymfGPnfE4v19sjFg1xm
   7b73HxFXz18jvVOZLAQCmnE0txuzBdH2Cd++lI74YbA2dYRLxVcst9CzI
   lx0B95tX9JRJjRhOPnYU8mHbJnKuHVnaI7Ow6XCc27FmY8u1F7ixXHNni
   d4G1BcMQiIg2HJKAVSqQxIlxXNs737nECjb9xgOr5Ar39YxyIi3n3sTFn
   v6xtM06vUavghxsBpcX9DzjsWRDO5sndXYWkwbecLHD1rPzxgqG/4T+Jm
   eYPSly3cU2qDjEpYEZKlx1a4RpuBjPWPORum98Z0PV5C1ZFb5ky7sZhW0
   Q==;
IronPort-SDR: K3uO0ualYksNaWtA1KmtuhsqubSRckleeOewSbOw7CoaDjNDouc0dx4haf7LiILtlV5EUhr+TL
 lMPY5+Dg8CmI5nBpsCFtSG3bvAx90P/XCj8Sgh8RVsu3PdnXyb7DIRFmSaypL/5XsDOtqkSf7U
 CggtDsr43KHvE3fte/oCj3+BKwlyEnSFsKEXhqL0pOcr/qHaTAm2/x/OJZ1t17QPNkBsizZxiB
 RG2YWAQgL6AZrb4JuR+skoeWYVF+yHR+nUnJtrzr/iOzOEQFNHUYy+QNcanuICDbfEdSssDwwN
 KXs=
X-IronPort-AV: E=Sophos;i="5.76,332,1592841600"; 
   d="scan'208";a="145373624"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2020 06:24:40 +0800
IronPort-SDR: I8Tv5nn5SXRQoc3rN34BXtYeB68jjtcZV7KCDVjvFeKpdnDpGcTXXV4QE/td3r5296OTWDeI2U
 HyrfkTCbYAAw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 15:12:22 -0700
IronPort-SDR: qeASOcpsC5tETXVvFIaf3jgrXLlmjsFJeBHh+JrZXvJm4MzlaZ4rUzKfhLKqp83wnyK6axFW5O
 pBEe93zZ0aVQ==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 19 Aug 2020 15:24:39 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Steven Price <steven.price@arm.com>,
        Waiman Long <longman@redhat.com>, Zong Li <zong.li@sifive.com>,
        Daniel Schaefer <daniel.schaefer@hpe.com>,
        "abner.chang@hpe.com" <abner.chang@hpe.com>
Subject: [PATCH v6 9/9] RISC-V: Add page table dump support for uefi
Date:   Wed, 19 Aug 2020 15:24:25 -0700
Message-Id: <20200819222425.30721-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200819222425.30721-1-atish.patra@wdc.com>
References: <20200819222425.30721-1-atish.patra@wdc.com>
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
Reviewed-by: Anup Patel <anup@brainfault.org>
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

