Return-Path: <linux-efi+bounces-4722-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC12B5131E
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 11:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFB54E6826
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A630103D;
	Wed, 10 Sep 2025 09:46:43 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71290245005;
	Wed, 10 Sep 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497603; cv=none; b=Nho85TPYDyaqJoqa6G8GqXMgDgzyvimQXUnDSCkGOdi0LanZOS1AdVRz3fsF/sdxdgKM27SPGME7hNGSNIlpmS4I83CXhNN8iENNhIooJ+B2SGr8XSz9D68La+zv7Xhx+bi7p/FBlt/PqHHOOFeH0NKk8xDtBM43KSxtHpBtvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497603; c=relaxed/simple;
	bh=zKcHjDfjBiEI9vc1dnbqF+VbIa8mY2JWaa4I9KS6lbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pechU0IZHl6VmJHzdER9cDbBYaCgo0j7IbkSsZBchDxCObzFdKfUokkP5GPdGBl8TWgLu0hJEmgmIwQjPpWMOTpPVtvVyue2Qm3uMaFLs764mrt68zGekNBWVLtbheE+bP/d8n2ktld/UAs7Xwo5WBP+0SZ/cNqpDcGoOUwPFE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A1C916F8;
	Wed, 10 Sep 2025 02:46:32 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5687D3F63F;
	Wed, 10 Sep 2025 02:46:36 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 1/3] arm64/ptdump: Re-organize ptdump_init()
Date: Wed, 10 Sep 2025 15:16:21 +0530
Message-Id: <20250910094623.2356282-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250910094623.2356282-1-anshuman.khandual@arm.com>
References: <20250910094623.2356282-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split ptdump_debugfs_register() from ptdump_init() which there after can be
called early on during the boot and also enable dump kernel page table when
required. While here rename ptdump_init() as ptdump_debugfs_init() to avoid
name space collision.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/ptdump.h    | 2 ++
 arch/arm64/kernel/setup.c          | 2 ++
 arch/arm64/mm/ptdump.c             | 8 ++++++--
 drivers/firmware/efi/arm-runtime.c | 4 ++--
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index fded5358641f..27e774134e7f 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -57,6 +57,7 @@ struct ptdump_pg_state {
 	unsigned long uxn_pages;
 };
 
+void __init ptdump_init(void);
 void ptdump_walk(struct seq_file *s, struct ptdump_info *info);
 void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	       pteval_t val);
@@ -74,6 +75,7 @@ static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
 #endif /* CONFIG_PTDUMP_DEBUGFS */
 #else
+static inline void __init ptdump_init(void) { }
 static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
 			     int level, pteval_t val) { }
 static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c7926a4df6..0a3812c8e177 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -43,6 +43,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/kasan.h>
 #include <asm/numa.h>
+#include <asm/ptdump.h>
 #include <asm/rsi.h>
 #include <asm/scs.h>
 #include <asm/sections.h>
@@ -332,6 +333,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
+	ptdump_init();
 
 	acpi_table_upgrade();
 
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 421a5de806c6..7c42be62898b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -367,7 +367,7 @@ bool ptdump_check_wx(void)
 	}
 }
 
-static int __init ptdump_init(void)
+void __init ptdump_init(void)
 {
 	u64 page_offset = _PAGE_OFFSET(vabits_actual);
 	u64 vmemmap_start = (u64)virt_to_page((void *)page_offset);
@@ -396,7 +396,11 @@ static int __init ptdump_init(void)
 	kernel_ptdump_info.base_addr = page_offset;
 
 	ptdump_initialize();
+}
+
+static int __init ptdump_debugfs_init(void)
+{
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
 	return 0;
 }
-device_initcall(ptdump_init);
+device_initcall(ptdump_debugfs_init);
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83092d93f36a..3c84e84dc6ea 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -38,14 +38,14 @@ static struct ptdump_info efi_ptdump_info = {
 	.base_addr	= 0,
 };
 
-static int __init ptdump_init(void)
+static int __init ptdump_debugfs_init(void)
 {
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
 		ptdump_debugfs_register(&efi_ptdump_info, "efi_page_tables");
 
 	return 0;
 }
-device_initcall(ptdump_init);
+device_initcall(ptdump_debugfs_init);
 
 #endif
 
-- 
2.25.1


