Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85C816F4BB
	for <lists+linux-efi@lfdr.de>; Wed, 26 Feb 2020 02:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgBZBKv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 25 Feb 2020 20:10:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:57156 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgBZBKv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 25 Feb 2020 20:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582679451; x=1614215451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jG6X4JnNilU/eW30gWfXMqqgjMVBZILEbLLORFCd6Bs=;
  b=BT+YfqKggJt90DAC2k6UY7bxbKyONlexRzVMN3oArNN69ETSZ5me55uH
   7uxIaHRtw2/vWvOpkrNNeEOdsp3Aq8iW+IVU6litIEnW+qc6R8Zt1IiE2
   38OK2K6RwqbGryiNAZ5pSszWNkyvsmV+T56bIc21vYA+Lni76VcAwDDf5
   Yw/Tl6pDZ1q1NtzD4rc2CD0OzMxwq5/8I7T0IV2gy47iZmFmDpEaCS7YO
   bwrtzRAC4hhaULlUOQs5p1ZLm5dB2qbFjRrQu/eouZZ86DpxYxxedfSJ+
   E7g1R0up5i7N/pCNWvyA5wpAOWsgXwRk/+yphXc3gZy+CtjC7pfemSIu9
   Q==;
IronPort-SDR: mLQNKErLCiKr4SKBFc17m1CoQEjj32K2YNZtzFUKaXehCh0yOd4obyaUQBSSDG6pAYZE4JkiD9
 FrBuTBWWLUp1DGrV4n4ygPj/GYYW6S5IWVLmYKBi4ehzY/t94t3GrbfFgEnEcX5SiN4wqSum1M
 YmxHOaAHGeOYQbL+oRqWFV11NFopWJSO+0RHtb4T7aF3DkSaeNRSfTULlKcao0BQ2i/UObxQCW
 MkO/bvKDZVORPN2Jle7/xhduPB+drEquPuC/gVKMs9XT8B5F698PeOt6iqTxz3CGDtfK3Q59Zn
 bgQ=
X-IronPort-AV: E=Sophos;i="5.70,486,1574092800"; 
   d="scan'208";a="131266509"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2020 09:10:50 +0800
IronPort-SDR: iEBOSU0o2v5CrwC7hDW62w+O1KcCUh1zcuhUWC93u4IahX0DEWqgqeifklV7JwHtqYyrmK1L/Y
 1MCSQgPYqsmIONdZVDqwaO0HahaBP3DbII+FjxHCrPrmQvdFT2ZMPH72UYkoxBanRbGLZHGnh8
 jI8AmLcLeD99NgRMWT9yi9OHSPfRH+M3MHWNE8T4L5ctwhWefhaGx9ibFKkxFlN/iE5qjAwjDU
 sKP5GWhMFsrjez2FTNqlRv3cX+OjH0Ply440q73+ifHZIgRib/PRW6B3NZGxLfc4+u3EBGNB+o
 ZvvtPMdHJBcCPo/TBu4mtLNt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:03:16 -0800
IronPort-SDR: uYo8/yrdVKwUzqReGdMdTrQ3dSJmyKvsNgCAiPHd8mBJG5pa8Xkamt42xv+OK0H1Ikp3xGDQsF
 ftEMYmliGZhro6eqMNQ0uZ1bBq+V5Q3ZnweFEcLHkJYZcjBTj0ZQVSQjLVwhjT/+Cwt7EUky2o
 SagAFlELftAlMUBYjHpNT5CLhV3eejODZHig/Qt7cIcL4hGTTxcbxzekGU22nJPWuWNIZgzKB2
 qhpSaRB6WDIZmTAI0d1zashabLhrnFRJvbfJdAHIQPvWJHVSyPwsz+lpBxLknNeXurWJDtbWfF
 OZY=
WDCIronportException: Internal
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Feb 2020 17:10:48 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mao Han <han_mao@c-sky.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Alexander Graf <agraf@csgraf.de>,
        "leif@nuviainc.com" <leif@nuviainc.com>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        daniel.schaefer@hpe.com
Subject: [RFC PATCH 3/5] RISC-V: Define fixmap bindings for generic early ioremap support
Date:   Tue, 25 Feb 2020 17:10:35 -0800
Message-Id: <20200226011037.7179-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200226011037.7179-1-atish.patra@wdc.com>
References: <20200226011037.7179-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

UEFI uses early IO or memory mappings for runtime services before
normal ioremap() is usable. This patch only adds minimum necessary
fixmap bindings and headers for generic ioremap support to work.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/fixmap.h | 21 ++++++++++++++++++++-
 arch/riscv/include/asm/io.h     |  1 +
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 27bfc7947e44..42c122170cfd 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -65,6 +65,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select GENERIC_EARLY_IOREMAP
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index ec0ca8c6ab64..517394390106 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += checksum.h
 generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
+generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += dma.h
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 42d2c42f3cc9..7a4beb7e29a3 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -25,9 +25,28 @@ enum fixed_addresses {
 #define FIX_FDT_SIZE	SZ_1M
 	FIX_FDT_END,
 	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
+	FIX_EARLYCON_MEM_BASE,
+
 	FIX_PTE,
 	FIX_PMD,
-	FIX_EARLYCON_MEM_BASE,
+	/*
+	 * Make sure that it is 2MB aligned.
+	 */
+#define NR_FIX_SZ_2M	(SZ_2M / PAGE_SIZE)
+	FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
+
+	__end_of_permanent_fixed_addresses,
+	/*
+	 * Temporary boot-time mappings, used by early_ioremap(),
+	 * before ioremap() is functional.
+	 */
+#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#define FIX_BTMAPS_SLOTS	7
+#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
+
+	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
+
 	__end_of_fixed_addresses
 };
 
diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 0f477206a4ed..047f414b6948 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <asm/mmiowb.h>
 #include <asm/pgtable.h>
+#include <asm/early_ioremap.h>
 
 /*
  * MMIO access functions are separated out to break dependency cycles
-- 
2.24.0

