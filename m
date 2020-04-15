Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23911AB229
	for <lists+linux-efi@lfdr.de>; Wed, 15 Apr 2020 21:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634625AbgDOTzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Apr 2020 15:55:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22134 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406346AbgDOTyn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Apr 2020 15:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586980483; x=1618516483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/GiEGyOV5rt1rc9GnsBz8XcyhOtNk7wcIG4+FIGGnk=;
  b=Cd8OcSsZnz08tqmK/myPEmA8FoeeRloxs1cbx1OtuGGykpbVspnjdHav
   wLApJioSAfHG+68FhH7+0LObPZy6fr04YBibFYy2ChrzXfCFSTtVkgwhw
   kjW+uaMxEkAxxAmURbUN+6DYxazW++xKQqxxuZv7+n+LLsxElHvLsRa0v
   U0ge6WsBkKybvnkr7JXRWOyUBTaiXIXSQnfo11sKocqz+hn0+SOiHRbkF
   DZ8VGf7Qcuvkme8rY2/ii8b/A3SE4FO1348BkDoYZHPRdNaRFGsBsgtd1
   R5XQPgikIZ5hv544C0PZzs0qeADZbcDKWtVrBKQB2B34xsqrfa5WREK1x
   g==;
IronPort-SDR: RoI2rMKPdtlwIxwA7CILMhaEw/gtOpmApFbuIUZ0lVHcsrV+hLzUF+FDAntiIIZC6yOeCmURRw
 P6cXYi3W76YDO6tunahY16r7J2pZEnEu7+oSaOhMPGCVbCM/Ei2wyz+DQok+qQtKSgde6ol1X+
 YNdKK/qGcwS5SZi4p0pehiwHG5EHLq/2+9miUDbDhQiKG2zGIs9GU+Uf6LOSgrDU7JcJyXDZup
 iQz4cEHw4LB7TYrmN79XukA6h88nYLBJ9UozF4T0mVWRKchvNpjpbEUO8ALRVVnT8Fy4V9gPYO
 aUU=
X-IronPort-AV: E=Sophos;i="5.72,388,1580745600"; 
   d="scan'208";a="244077018"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2020 03:54:41 +0800
IronPort-SDR: VgPKtlCN6Snir5MwPcs/qf33hBVgbbE0/P/QATy/BY7uVq4496H2B2/o6V6CxudKEuRxs3qNYX
 eCBVnvUHupuXvLZBZ1kqyGaDxMpk3n9yZkXSvarT+07Snc61gUPBySo6fpo5Sii3Y052jW3R4K
 VjXV6G7omyF9OqtaYqmx1MOxvhZ7QicTEVKintcz3fKJBk4WGxJnAh6AJca3JDhq0SaBHvLOM1
 zpXZ9g7RnDQhwiR7JIsnaCxRXQllolkUziMNBwz+3/fHXBGYcsyxraYNuJbm9L9vdEz7XoUNBs
 5PJ7kmcYiztV/Z540HnY+v6H
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 12:45:10 -0700
IronPort-SDR: Pjy567yOzeM1bdT0GQqoGVowVxs6q7IBZl9SQHXkO3QkXpd+chuWhK+yjTisbi+VNX91SjvBnV
 GxEwlGV52czlYA1QiMCes6giLsRZptIWqNwQLGaUVCzbNyJ5USgkfDMSo0A+CPiD8/839jEeC8
 rq12xRqTN3Mqu23X8EQ2bUPV5lpeA7+X4zFGWV3eU7jKjr1zayWZf5qVNdguKVu94FgPKEHTvD
 hdndP2UkRg/AN/9Hol45h4K3BSkE3BArGEmTR+MtRy637lcQqgIwxWzbT5MJsz0GuUvuaC0fbt
 VQk=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.244])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2020 12:54:41 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v3 PATCH 3/5] RISC-V: Define fixmap bindings for generic early ioremap support
Date:   Wed, 15 Apr 2020 12:54:20 -0700
Message-Id: <20200415195422.19866-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200415195422.19866-1-atish.patra@wdc.com>
References: <20200415195422.19866-1-atish.patra@wdc.com>
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

