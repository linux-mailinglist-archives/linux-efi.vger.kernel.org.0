Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE41A6E45
	for <lists+linux-efi@lfdr.de>; Mon, 13 Apr 2020 23:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389054AbgDMV3y (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Apr 2020 17:29:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20794 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbgDMV3c (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Apr 2020 17:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586813372; x=1618349372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/GiEGyOV5rt1rc9GnsBz8XcyhOtNk7wcIG4+FIGGnk=;
  b=hoe+XuaOniPfASCqCow7b4qAaNvDCF+QWKHmJ8NwWbnpfVkKE4XCXWY8
   IJdL/pkUHLteksSEkGY5eLZH8sOIEZkrmaYca8uNitQPZZaNb+t6n0v5a
   e7B83Oo8daMBoWO27pfLYPHhmAWlb9vhSlDMmTJxYgbNCA98gzTEf7f56
   /TgQbGdW9hsgKzGdAsmEtCq9IbMqZk+Sqc1jBu6RqUmteJ5/rKSno3LGF
   d5Wqt+016zVw7Rf8fIlruxxN5cKvXQrHx8frT/rN185BZmvDw59VGUVLf
   cKvXI5gbS2b6UhKVqy7MEDO1+M/ZZOG0xawrR+JmLTs6WtDfyOqUgMb/G
   w==;
IronPort-SDR: +BTq6wYWkwg5Wlh9/ABlL5ZfqAu0vLBTlAtl7JrEbevAuVbNTiKz64iYRn7tpOOm/SK1PdaJ7J
 M1uyAiHcFWTZdEEO9TvPhOLV4UdRROyscFcW4wiF6vf4F16lvY0owNS0bcPuO3tlUCPOLOQgrz
 cMgH0OtDQyOFUWtFEyL6Q6QY/5FjS+9fA+snWYKcYc972vcozfW9xuSpFZSv+X7acbc/dlf1q3
 dudFx7GIEcYemPywlQnuT5N+FAlD0YdBSCM6fkvTawZL7rjdt7afhbsvOUhAQgxxRz5JS12Red
 WYE=
X-IronPort-AV: E=Sophos;i="5.72,380,1580745600"; 
   d="scan'208";a="139583357"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 05:29:31 +0800
IronPort-SDR: WuOSxf+mMsoIIr18x/7he6AjDktMMNrqB1THYNHtaugqVOlKbH+jOTjzAxSoWHXmOXC4BfHfZ9
 t01C7YmXkfmpSJNlSQ3/S7rrdrQ6DgknN8aYa25ZfqcdjzFis4VkIZ1VAqy+Vj9Wd/qDfb8n13
 9LLQV6SwZtt4OMHY2+zW9lFcs29VuC3H/8DxKp7uirRlw8GKfVUdUCc1ZFUlh152yYCJG5WjjK
 8vN0W9NyfOMZ/A20pAVU3UDt2z9K4pih0Q41aYnAt981J9Q5Ohkma6cx1qsMQd4gTSVxbUyocO
 fCKgTbIF8cXNjR1pSXwfKcg1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 14:20:35 -0700
IronPort-SDR: BseMmEGbdr0tCYWbKQphuB1iCB2ANCvg+j86bIbB8nd/xBtv73df2iAf1kOIAk5mlOsLuUo43g
 SeaVOSRUDO6VTRZAjJ/kv7HT+qXUBbJAIkDUCSAEDyyGXFztvYsUvXRcA4n0vm2AJiwtpNVdEq
 +9reJHs+lT5r40PSoQustcMlul/5Wq9D+KyjZYOboxtWIaqc8NrJQFapg28YEtFYjCqlxTgeHS
 +zVA+KcUN0I+volZI6cqbVJfG+23HjpXQvxKOw57rKVH6lwAAKj8Oe/OXnFJYWc8vM8TXNYNCP
 zvA=
WDCIronportException: Internal
Received: from 9dg4l72.ad.shared (HELO jedi-01.hgst.com) ([10.86.55.26])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2020 14:29:31 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>
Subject: [v2 PATCH 3/5] RISC-V: Define fixmap bindings for generic early ioremap support
Date:   Mon, 13 Apr 2020 14:29:05 -0700
Message-Id: <20200413212907.29244-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200413212907.29244-1-atish.patra@wdc.com>
References: <20200413212907.29244-1-atish.patra@wdc.com>
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

