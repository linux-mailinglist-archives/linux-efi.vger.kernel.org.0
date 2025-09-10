Return-Path: <linux-efi+bounces-4724-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB5FB5131C
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 11:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF291C82A6D
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 09:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A919314B81;
	Wed, 10 Sep 2025 09:46:54 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA0031D37D;
	Wed, 10 Sep 2025 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497614; cv=none; b=P+2WBWkep+5iOEN2RFeO8ElXnGp8BOF7SCDq9yIPy0ySYGdiNO5rhE1JBomNIRZcdDRH8sORLI6gTan9ZmmU1T0M8cIheEu1hyqw2q0k0feMPiz1PDrtSC0qFmhF5PsCggOLXlj3tug+I2dAZsIMNqSjxhobj/C5PukHoRpwcbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497614; c=relaxed/simple;
	bh=IS5IwAzX7TFHjXEEXmEPIusDZxypsR4BPH7MgERJxek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pCGiYkIRRYuHT9+9w5XhswuE69Eg5ir8IkXyI9vGNXXOHaq+q5kwlpQ0YTKIhDCT+W/yF9no7gJZ7t8bAR12FYu81qDckvFM1XOMH1GyE/RGe+jsllWXNVBNNRrGczECBjtWN7Efs8b7O6zxOSyV9mzP9+LrUJ4Z2WMQbl+akSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B328D16F8;
	Wed, 10 Sep 2025 02:46:43 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8AE313F63F;
	Wed, 10 Sep 2025 02:46:46 -0700 (PDT)
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
	linux-efi@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH 3/3] arm64/ptdump: Add 'early_ptdump' kernel command line option
Date: Wed, 10 Sep 2025 15:16:23 +0530
Message-Id: <20250910094623.2356282-4-anshuman.khandual@arm.com>
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

Enable kernel pgtable dump during boot via a new kernel command line option
'early_ptdump'. This calls ptdump_walk() during boot right after ptdump has
been initialized with ptdump_init().

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 arch/arm64/include/asm/ptdump.h                 |  2 ++
 arch/arm64/kernel/setup.c                       |  1 +
 arch/arm64/mm/ptdump.c                          | 16 ++++++++++++++++
 4 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..f8e916750e2e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1295,6 +1295,10 @@
 			Enable debug messages in early_ioremap support. This
 			is useful for tracking down temporary early mappings
 			which are not unmapped.
+	early_ptdump[=on]
+			Enable kernel page table dump during boot in current
+			ptdump format. This helps analyze early boot mapping
+			kernel regions.
 
 	earlycon=	[KNL,EARLY] Output early console device and options.
 
diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 27e774134e7f..ed30d25ca9de 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -74,8 +74,10 @@ void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
 static inline void ptdump_debugfs_register(struct ptdump_info *info,
 					   const char *name) { }
 #endif /* CONFIG_PTDUMP_DEBUGFS */
+void __init arm64_kernel_pgtable_dump(void);
 #else
 static inline void __init ptdump_init(void) { }
+static inline void __init arm64_kernel_pgtable_dump(void) { }
 static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
 			     int level, pteval_t val) { }
 static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 0a3812c8e177..86bf7607d304 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -361,6 +361,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	init_bootcpu_ops();
 	smp_init_cpus();
 	smp_build_mpidr_hash();
+	arm64_kernel_pgtable_dump();
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
 	/*
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index c78e6b496dea..1624be5160e4 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -407,6 +407,22 @@ void __init ptdump_init(void)
 	ptdump_initialize();
 }
 
+static bool early_ptdump __initdata;
+
+static int __init parse_early_ptdump(char *arg)
+{
+	if (strcmp(arg, "on") == 0)
+		early_ptdump = true;
+	return 0;
+}
+early_param("early_ptdump", parse_early_ptdump);
+
+void __init arm64_kernel_pgtable_dump(void)
+{
+	if (early_ptdump)
+		ptdump_walk(CONSOLE, &kernel_ptdump_info);
+}
+
 static int __init ptdump_debugfs_init(void)
 {
 	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
-- 
2.25.1


