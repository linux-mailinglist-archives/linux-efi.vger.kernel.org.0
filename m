Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C1232833
	for <lists+linux-efi@lfdr.de>; Thu, 30 Jul 2020 01:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgG2XhF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 19:37:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22305 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgG2XhC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 19:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596065822; x=1627601822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+GUmN6ZNbnCfom5PIzX3LeRfgAzIkaN7Tqfa0vPyyjQ=;
  b=r754yuF9ScsKCYz+YkrlG9ZDeGdIYaK2HlB55aglDMVZhnD2rvKF/yZs
   JTLDcmRurxfpoBOTl0Pe7q7lGeo+iM0ZVa3BTJxYFU3BXMZHBsdUqij+X
   +L7AOzCrMwO2g+VRV+9B/0ePtu7sFRCbEE0rvBCItVeI24Iz1QklIYS8h
   TJnNz+5qYV7T87gXIKfpeANKtikxvTi5QweCaRQbmu2IDz8pdPo7cesP0
   jf1QLGtk9o3X6ETG7iAGXdhSNhOVPHFBHi0qsyCHcqHeH31+IS9x0dR49
   w6MowSebeVUdl6cc7+peA+lMWXYfY6BUXlM7vYGnLssdQRM7aUWHT8cWQ
   g==;
IronPort-SDR: 8z6VTxWjqqgN5Yd21RVf52uqPmvZozrmLBAesRcx2lgdWie3ZUTeVUqht6cJJU1kHyqj3c+T4L
 t8q2i+N8SVOYSULSzrYIVE2F2W8yZLwmeu7R//BOTKxtbFfrAbu8r3V4Uvf58HC/9w9uj3tx8r
 GhHVNeRD2mNloLbpzl7JS76bU+0f7qrNijmZSq3i9PQO278/gjU3mknUEg57IY3OXOuK7VxIut
 8qv63RT1CxAPuBE4xGCRCOf3EiJwAX2b3etqnTlStvodWtZ4ZdLVvRyoR7Ano1VVgTCc3h4KpK
 ISM=
X-IronPort-AV: E=Sophos;i="5.75,412,1589212800"; 
   d="scan'208";a="144951834"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 07:36:59 +0800
IronPort-SDR: Yj/asdOe52xdBSgIH54O+p8qld/7wPOX4hRhKZk19dAeG4pDlfRO7u156rDpqIjhlKaszYciBk
 8Y/wHT/TGg4ThAIdUUaV2cbweV72uJhfg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 16:25:06 -0700
IronPort-SDR: oRu3jhyRAp3Dj6mouWcVjsE0ucflLYfALvrIxFoA6rnYtVsNahoUfJ32FT80J3fm4iHiwUDjKn
 Hiz/xaSry70Q==
WDCIronportException: Internal
Received: from jpf009043.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.210])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jul 2020 16:36:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>, Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yash Shah <yash.shah@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: [RFT PATCH v4 9/9] RISC-V: Add page table dump support for uefi
Date:   Wed, 29 Jul 2020 16:36:35 -0700
Message-Id: <20200729233635.14406-10-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200729233635.14406-1-atish.patra@wdc.com>
References: <20200729233635.14406-1-atish.patra@wdc.com>
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

