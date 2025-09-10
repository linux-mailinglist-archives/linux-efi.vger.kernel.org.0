Return-Path: <linux-efi+bounces-4723-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36ECB51318
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 11:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8393AF453
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D41314A6A;
	Wed, 10 Sep 2025 09:46:48 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740272C0272;
	Wed, 10 Sep 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497608; cv=none; b=eSCALAFp/TuWimDt2RmmEWRoQ8wq5LifuaXfhKd/ZLYRZjjwg1QhCREVQnZmRpg0thSZ5B+KKcP+xCZ7EwVjtvye0rul5FBP3feJQ/izH7HyRACttctUvQ2/iYDmwZOHh7bxC90DRoU2zd8DhinCMq+Acnv7Jp9s1pwfDSYgadM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497608; c=relaxed/simple;
	bh=ogZAHzDejeGowGzC8WuXgZtgM9HJGsCDsh+LyWS9kYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSXS8U+P3yesVNvYH5G8VXi2KJEltUWu7xp1pwfbQcGjVh8yDI50dDYeExQOgx9YjV352zN2kkfTtHiVdw9B+OZL6KDRETVMxyDsX1oriep0y/ghpMRQbZR8CLcizJY4IYPA0hoToGgADzDBTnYE0JS/AmeaZqyxVWJBO4jDJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B44516F8;
	Wed, 10 Sep 2025 02:46:37 -0700 (PDT)
Received: from a076716.blr.arm.com (a076716.blr.arm.com [10.164.21.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 660793F63F;
	Wed, 10 Sep 2025 02:46:41 -0700 (PDT)
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
Subject: [PATCH 2/3] arm64/ptdump: Enable console output in pt_dump_seq_[printf|puts]()
Date: Wed, 10 Sep 2025 15:16:22 +0530
Message-Id: <20250910094623.2356282-3-anshuman.khandual@arm.com>
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

Enable console output in pt_dump_seq_[printf|puts]() in order to dump early
kernel page tables when required. CONFIG_DEBUG_WX enabled ptdump_check_wx()
already sets seq file as NULL to avoid all output. Hence let's introduce a
special sentinel named CONSOLE as ((struct seq_file *)-1) which can be used
to identify kernel console output request for early kernel page table dump.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/ptdump.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 7c42be62898b..c78e6b496dea 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -25,17 +25,26 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptdump.h>
 
-
-#define pt_dump_seq_printf(m, fmt, args...)	\
-({						\
-	if (m)					\
-		seq_printf(m, fmt, ##args);	\
+#define CONSOLE ((struct seq_file *)-1)
+
+#define pt_dump_seq_printf(m, fmt, args...)		\
+({							\
+	if (m) {					\
+		if (m == CONSOLE)			\
+			pr_cont(fmt, ##args);		\
+		else					\
+			seq_printf(m, fmt, ##args);	\
+	}						\
 })
 
-#define pt_dump_seq_puts(m, fmt)	\
-({					\
-	if (m)				\
-		seq_printf(m, fmt);	\
+#define pt_dump_seq_puts(m, fmt)		\
+({						\
+	if (m)	{				\
+		if (m == CONSOLE)		\
+			pr_cont(fmt);		\
+		else				\
+			seq_printf(m, fmt);	\
+	}					\
 })
 
 static const struct ptdump_prot_bits pte_bits[] = {
-- 
2.25.1


