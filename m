Return-Path: <linux-efi+bounces-3987-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16371AE835A
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F061C2302B
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE72701D8;
	Wed, 25 Jun 2025 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4ZYli/o"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680A26A0F2;
	Wed, 25 Jun 2025 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855898; cv=none; b=krnxnNdMli3vL/+c9ywz3UVg0a95ZRiMPeVcpoeSBlje2yu06z8OFHb54tXsjPPuVpmhjtINBV7527UjzSG6xFOnCKAmL/y0QZreFP71kViyWd7v/htu2+zFqXP3jkbWXB5IEoLEXEEdPVxySVzhFEAZpxNzxZoKfmyOQjZ5Md8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855898; c=relaxed/simple;
	bh=gDZAIaId/LE+Cg3g34PHSl3JoHL8xvSE+GTgwe6XlKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gACQ1j288OR1y8FC2Dc+jUbzthJEm+Ujma2fvcNM2963spynHnKOshbLvQ4IV8cbVU4VHgw7+n2ldJTrOLeQ7VqqzC1vnIMwWXXgBnjIwU29Xza2NP1z1jl8yCCCG4b/EZM2CZHnLozUz9N6YQJivBPiLHnTKSn8GDGKdXs7Eyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4ZYli/o; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855896; x=1782391896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gDZAIaId/LE+Cg3g34PHSl3JoHL8xvSE+GTgwe6XlKg=;
  b=Z4ZYli/oIFvsVqCOdrR6LaG3tkrApxKCdKBvpImOfokXnGhDwmm7wDV8
   RGiyrCdKqY0MLilR7FY+uchVsVBMcLfWJWgW+HEg+S2voZ1NXq8t89vxT
   rHT3d3vY9YAXcvp24WWuGwD5jcGui91GP3g4SKeJByXglJqfWAohvP6xd
   hWvz4KWEhfQtQSS7VWy6B5NiO7NlbggBpSTEkiay2gtS54RFZcfU2ODDn
   xMkIwCSSrf/M3WBf0GKAoCNE2VSsmdwzgvJmbNGNjxYP0qSIvsVWGFGfa
   EOjaONH+MAeu+GGC8jQYXv2DkavKBmVrlohBECl4Ut5RKnpysyWsiGgja
   w==;
X-CSE-ConnectionGUID: WbdQy+/VRI6Wnosw+WwtHQ==
X-CSE-MsgGUID: 4Xp0zkwLQBuCPLcVfk9zLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56908374"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="56908374"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:36 -0700
X-CSE-ConnectionGUID: PuC99ST/SMezEVXWAKvk2g==
X-CSE-MsgGUID: vtZJnGSOR+mfXpIQU3xILw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152919817"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 05:51:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 518C6862; Wed, 25 Jun 2025 15:51:13 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Xiongwei Song <xiongwei.song@windriver.com>,
	Xin Li <xin3.li@intel.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tony Luck <tony.luck@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Breno Leitao <leitao@debian.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Juergen Gross <jgross@suse.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Tejun Heo <tj@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Huang Shijie <shijie@os.amperecomputing.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv7 16/16] x86: Re-enable Linear Address Masking
Date: Wed, 25 Jun 2025 15:51:09 +0300
Message-ID: <20250625125112.3943745-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.

LASS mitigates the Spectre based on LAM (SLAM) [1] and the previous
commit made LAM depend on LASS, so we no longer need to disable LAM at
compile time, so revert the commit that disables LAM.

Adjust USER_PTR_MAX if LAM enabled, allowing tag bits to be set for
userspace pointers. The value for the constant is defined in a way to
avoid overflow compiler warning on 32-bit config.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/Kconfig             | 1 -
 arch/x86/kernel/cpu/common.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..2b48e916b754 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2181,7 +2181,6 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
-	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 97a228f917a9..6f2ae9e702bc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2558,11 +2558,8 @@ void __init arch_cpu_finalize_init(void)
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
 
-		/*
-		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
-			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
-		 */
+			USER_PTR_MAX = (-1UL >> 1) & PAGE_MASK;
 		runtime_const_init(ptr, USER_PTR_MAX);
 
 		/*
-- 
2.47.2


