Return-Path: <linux-efi+bounces-3729-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD2AB9C1F
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 14:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8F81B67B5D
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C323E226;
	Fri, 16 May 2025 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m9y+kmP7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CF01E871;
	Fri, 16 May 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398808; cv=none; b=L3FJpdamsrsGoI0kpRsrdiycfhGBHurwWleVNS/94KNrB+jh2EimrKtlQwuiKDIXF3ggzoFZopXNp43ra1IuUPM9AItW5y2brNhGRhbuYjsE0FSlZVuTmvivlZPTFTFBXXYei8H8DvX47vPvH3Vbbq7KMELGdWDQSITSsYHsO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398808; c=relaxed/simple;
	bh=ralu6RICTpQnyjwnYm0KblIg9bXK3LZesJ0Nb9yI6wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fte1/LMhXgIvyYnbmUPW/cLUPEm0H5d197CFMzCh+Cvl+WNMKyheGcY40A2P0oWD4Yk1AeNdaWTSuA18BqiUBMcOk5C/ftMLAdgDlPVcW8rkXH8HYyOYpmL4vIVU6aHhjLqAc8GhamIK1lgSQw9smZ03HbL2rI3s1F+OY098NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m9y+kmP7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398807; x=1778934807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ralu6RICTpQnyjwnYm0KblIg9bXK3LZesJ0Nb9yI6wI=;
  b=m9y+kmP73V3KdCNuJLFdAGD7rYfFU+SnW4uzbRPs5Kl0i38PSKUEJdCs
   reR/xg1cnINnwTMQd6ILpTMMD4V8eOBNOeZXkUWOM47x/ovssTbbzQbL5
   mXj7xD6spgF79k0UOsAcW9IUAmfAJ8LbfU+V2f/dOBFu2DVbi7lk6Gq64
   +CQvj7uK0UJ7utYXZinfynUQsU0GzT3+CCV7sWKtlZN3Rg/zsLPkVITh3
   MhOggtxCbO4ixEdogoeNmIlXw+XboCyT3MPjMiqOCkfYC/f3UUIs94EHF
   7fjEAzuF932wJ+JOladbCJucgt0Mk9a+aXxfqflVscrLGBoWDk6jST7l+
   g==;
X-CSE-ConnectionGUID: St1/buTmQcmm5sDJvwYb5Q==
X-CSE-MsgGUID: Xl2UV874S56ETGD7cUldYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53041500"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53041500"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:33:25 -0700
X-CSE-ConnectionGUID: ufwtGiO9Sx+Nj2lVwjM4gg==
X-CSE-MsgGUID: S0Enck1iT7ioNUavPLVvaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139216320"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2025 05:33:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 84F571E0; Fri, 16 May 2025 15:33:19 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCHv3 4/4] x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only
Date: Fri, 16 May 2025 15:33:06 +0300
Message-ID: <20250516123306.3812286-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
References: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PARAVIRT_XXL is exclusively utilized by XEN_PV, which is only compatible
with 64-bit machines.

Clearly designate PARAVIRT_XXL as 64-bit only and remove ifdefs to
support CONFIG_PGTABLE_LEVELS < 5.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                      | 1 +
 arch/x86/include/asm/paravirt.h       | 4 ----
 arch/x86/include/asm/paravirt_types.h | 2 --
 arch/x86/kernel/paravirt.c            | 2 --
 4 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7aed3fa0e780..a9d4c715b9fc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -799,6 +799,7 @@ config PARAVIRT
 
 config PARAVIRT_XXL
 	bool
+	depends on X86_64
 
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 03f680d1057a..b5e59a7ba0d0 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -463,8 +463,6 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 	PVOP_VCALL2(mmu.set_p4d, p4dp, val);
 }
 
-#if CONFIG_PGTABLE_LEVELS >= 5
-
 static inline p4d_t __p4d(p4dval_t val)
 {
 	p4dval_t ret = PVOP_ALT_CALLEE1(p4dval_t, mmu.make_p4d, val,
@@ -496,8 +494,6 @@ static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 		set_pgd(pgdp, native_make_pgd(0));			\
 } while (0)
 
-#endif  /* CONFIG_PGTABLE_LEVELS == 5 */
-
 static inline void p4d_clear(p4d_t *p4dp)
 {
 	set_p4d(p4dp, native_make_p4d(0));
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b08b9d3122d6..37a8627d8277 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -189,12 +189,10 @@ struct pv_mmu_ops {
 
 	void (*set_p4d)(p4d_t *p4dp, p4d_t p4dval);
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 	struct paravirt_callee_save p4d_val;
 	struct paravirt_callee_save make_p4d;
 
 	void (*set_pgd)(pgd_t *pgdp, pgd_t pgdval);
-#endif	/* CONFIG_PGTABLE_LEVELS >= 5 */
 
 	struct pv_lazy_ops lazy_mode;
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 015bf298434f..ab3e172dcc69 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -211,12 +211,10 @@ struct paravirt_patch_template pv_ops = {
 
 	.mmu.set_p4d		= native_set_p4d,
 
-#if CONFIG_PGTABLE_LEVELS >= 5
 	.mmu.p4d_val		= PTE_IDENT,
 	.mmu.make_p4d		= PTE_IDENT,
 
 	.mmu.set_pgd		= native_set_pgd,
-#endif /* CONFIG_PGTABLE_LEVELS >= 5 */
 
 	.mmu.pte_val		= PTE_IDENT,
 	.mmu.pgd_val		= PTE_IDENT,
-- 
2.47.2


