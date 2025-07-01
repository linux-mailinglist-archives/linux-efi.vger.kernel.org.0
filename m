Return-Path: <linux-efi+bounces-4068-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49B7AEF440
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2517AFD5D
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745BF27466C;
	Tue,  1 Jul 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="co2VDTSD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E498E2701BD;
	Tue,  1 Jul 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363975; cv=none; b=uQGIV15CB6VpCxn2//Jrow22uDmx3ic+uexL7SPT9W9m092bHx212j9bVgkUmxdEl4H2DqNnMiI1NJa8x6KBQL3JPnw1gdCpGTVz8fvOJUUs6iIr8jOgRt2L4haMnrR1VxmvRIOXuC7rLGKI8Wen4GQZxvo0EknZ9WTFxj0iXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363975; c=relaxed/simple;
	bh=gDZAIaId/LE+Cg3g34PHSl3JoHL8xvSE+GTgwe6XlKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvSxmLZA+rLDTZ9LK+vmiJsY3Va0T+S7w0i37iH2KKhF34qJTxifneJLyqyKhBWNqZ2sqEbKCj6jY0umrJsEawoMVcv5Vt1qEOyLrLTcsIqwsor6RV1GecP4rkSycVzoxuH0wzWOWDokOCBLSQwQea2Q1DClYu+tSvoQeBsjAmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=co2VDTSD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363974; x=1782899974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gDZAIaId/LE+Cg3g34PHSl3JoHL8xvSE+GTgwe6XlKg=;
  b=co2VDTSD0PYrflX1PuFRQgcJTNlr5UgfEObQLTlhJ/tYPA9aMC5R6t7g
   bJTZeOU7VTMmVojLB5zSRGeG2mWQAQgLZkpmHvnW8YQ3PB4uY3nOJSPBN
   /unXuSbju3vCtlmzMX1EJwP9rySnq8XrkperkEPVFDkR5nnGb2GJiVwYz
   EeDtsi1AlFU0qTZ7qWx7D+xJSoXNIBY+/8QZ01RRlVte4NJhR3PcaatPw
   m1GJXhWN7yqcp+qui77ztvjQDAWItm9ChUlMOhMiZUH7lWlB28q3u2MQZ
   MR34Ik5zaBx7IoFrxJLJp2sAh6DBUlWSJqxCq0eK54H4kbRQrFk6LqhRI
   Q==;
X-CSE-ConnectionGUID: QFfVSuAORNWfDPa0BYSQyQ==
X-CSE-MsgGUID: sDMBNmCbR/2Z9f3nD7z88Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57428180"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57428180"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:15 -0700
X-CSE-ConnectionGUID: VVUtxzUdTiK9KNiZjO9P5g==
X-CSE-MsgGUID: VdrXhZFsR1OJpKY88wtqxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154216194"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Jul 2025 02:59:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 103AF983; Tue, 01 Jul 2025 12:58:51 +0300 (EEST)
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
Subject: [PATCHv8 17/17] x86: Re-enable Linear Address Masking
Date: Tue,  1 Jul 2025 12:58:46 +0300
Message-ID: <20250701095849.2360685-18-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
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


