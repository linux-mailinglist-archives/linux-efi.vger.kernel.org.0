Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCB81B1CE8
	for <lists+linux-efi@lfdr.de>; Tue, 21 Apr 2020 05:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgDUDen (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Apr 2020 23:34:43 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10948 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbgDUDem (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Apr 2020 23:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587440081; x=1618976081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/GiEGyOV5rt1rc9GnsBz8XcyhOtNk7wcIG4+FIGGnk=;
  b=ANTDqZHIep8ENkqimV9JG8r9JYSIS2WrvHlqTEJIr89TZFk5cjVlRjTY
   GPCp6vxM0egVRLQHZKh0Cej83xaoKu9I1pxRp8NNttBgrCKvPzmyQK6qh
   WP0ylB2lme41GO156qWjYOGMP7Djnjn3Jr5RSsYYnd+YWhPJz6lDGbR6g
   xBh5xtpw5mujn7B0yBBgdQ04W1Tlp0q77TH89MlgYpmVlqtNRKxgXXe12
   PA7I40kLdBDtC/VOYLaCvkEiNgfO90AFTUjnOOg0bqDatcxwA9H60m5YL
   l85putZfWulNQtKXrXhNvDSTtR0Nffz2tGbPbL60weKxB39pgub6BBuLd
   A==;
IronPort-SDR: WdfQiiGGq26lib/5jMFV9ncCfTlOCzhgiyhWYVovDwSSIkIjNlbiNTFTJP5WRab8PxvkbOvrz8
 ejGHka2DQpHvcXJqwqliZvbEPA7qkARS444NylE9frGf/tHRx7javCM+4G/PnxH+C2KNl04Pjx
 xjIuTXYlWRoocIUS7XZL0Y2PuefHUKzSlLwfrUFdp6Abh3+H9wiGRUPhSbTvcane0WeG3sTXoj
 rO5/ulTfpDx5XYjG+7f2SBPdXbBuC3S95YChOBtBRrWv2Tqn8z4Ov7uaueaVvtpLN+g6W+TMxl
 vWo=
X-IronPort-AV: E=Sophos;i="5.72,408,1580745600"; 
   d="scan'208";a="135760536"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2020 11:34:40 +0800
IronPort-SDR: zDbW7EHOsbKTSrk/XuhehLrCarbGPV3SOsxc8JgZJUARcTwX5bZDdIowE0XYeaZ6EA/IJ6Glom
 ve62QMVL+vevXsz4x+cVph0Q70GzA7nsM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 20:25:33 -0700
IronPort-SDR: JHXhkEYX0dItTAnPSBCVKUVOxNJyRjpf94xhTOczzjC6ML719tFFoZzHv1IQxaqLAidjFJO2SL
 S55lxNyUI0SA==
WDCIronportException: Internal
Received: from hqe220030.ad.shared (HELO jedi-01.hgst.com) ([10.86.56.34])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Apr 2020 20:34:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [v4 PATCH 1/3] RISC-V: Define fixmap bindings for generic early ioremap support
Date:   Mon, 20 Apr 2020 20:33:34 -0700
Message-Id: <20200421033336.9663-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200421033336.9663-1-atish.patra@wdc.com>
References: <20200421033336.9663-1-atish.patra@wdc.com>
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
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/Kbuild   |  1 +
 arch/riscv/include/asm/fixmap.h | 18 ++++++++++++++++++
 arch/riscv/include/asm/io.h     |  1 +
 4 files changed, 21 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a197258595ef..f39e326a7a42 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select GENERIC_EARLY_IOREMAP
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 3d9410bb4de0..59dd7be55005 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += kvm_para.h
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 2368d49eb4ef..ba5096d65fb0 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -30,6 +30,24 @@ enum fixed_addresses {
 	FIX_TEXT_POKE1,
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
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

