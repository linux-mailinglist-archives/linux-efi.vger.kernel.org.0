Return-Path: <linux-efi+bounces-4055-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1843DAEF40C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580B2178DD7
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5E26FDBF;
	Tue,  1 Jul 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qd1AipEd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B7B26E71A;
	Tue,  1 Jul 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363947; cv=none; b=OoY8ttTBE9XT5LNA4ZdSNzTIQ6I1zxdjPrT/clW4eaw7O7/mzwGgMA4+slH5IHzswg5n2XoG0rfq70OC0Vp/OtyvU1KtpBHKjfhoC9l7hPY4OLc/7v90PPcFguf9Til2Q21QckL68g3Q3xF/f0utjw3ETnK/W+rlPs5Ap/nbdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363947; c=relaxed/simple;
	bh=KVi1SbCxLhPwipXkfMiClroXvuKW+0f0MpKQ0MUg/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmY6Qni2dP750sXLVM7YEklZh9sWHC3CvYn8odvHA/KluI4IW3lFM0D4M2Gp7uuYd1TSAdhjICT9eqfyvKTP2gyxwzIBXgyQcIJzRVDNOoEwpf0Fh8+V7+sQkIiD/Z9K1xc3eWtwUxUvOYVfbQ6ONeeh4DBbwP+0v04SyuXa1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qd1AipEd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363946; x=1782899946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVi1SbCxLhPwipXkfMiClroXvuKW+0f0MpKQ0MUg/MY=;
  b=Qd1AipEd3Xi0LD0w8LvZC9Sm57jwEsg3vQjDgG53PUy1nBqDejMpgs5b
   5v+OXWwNN1KzQG+KNso1/n+s0ki9A4Xe27/zAYlbtPbp/nqQ+kAxynxbr
   Yl2/zBL4BejIPV4fsT44D37LCKxPi/x3b72OcB9nmZPKG11CfZA7wYd2l
   4JgDlyGQUk3EOIgtVO3mvVfMQh2FYOsw1PT9mMNjnpzb2wCNta4lju1dn
   +IZ6DuawAlKKlA5MpUJlTVIZsmvxqzLm4hwmNiwAIben5F+55OVTH6Ru1
   Ur5Tr/VpSS5y8HSGrWVx7xJWMoYgzgN5S2jmsUWERwErLnFqHWg927Q4f
   Q==;
X-CSE-ConnectionGUID: R9KsAzu1SDKgaTDELFnl5g==
X-CSE-MsgGUID: KNw+4+q0S9+1SedtSTcHKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57428008"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57428008"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:05 -0700
X-CSE-ConnectionGUID: t/+qn6kkRnqxouZqA5qu+g==
X-CSE-MsgGUID: nXMyxAdjQnWehTndjUuilA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190896400"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 02:58:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5690B3F5; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 04/17] x86/cpu: Defer CR pinning setup until after EFI initialization
Date: Tue,  1 Jul 2025 12:58:33 +0300
Message-ID: <20250701095849.2360685-5-kirill.shutemov@linux.intel.com>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

In order to map the EFI runtime services, set_virtual_address_map()
needs to be called, which resides in the lower half of the address
space. This means that LASS needs to be temporarily disabled around
this call. This can only be done before the CR pinning is set up.

Move CR pinning setup behind the EFI initialization.

Wrapping efi_enter_virtual_mode() into lass_disable/enable_enforcement()
is not enough because AC flag gates data accesses, but not instruction
fetch. Clearing the CR4 bit is required.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4f430be285de..9918121e0adc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2081,7 +2081,6 @@ static __init void identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
-	setup_cr_pinning();
 
 	tsx_init();
 	tdx_init();
@@ -2532,10 +2531,14 @@ void __init arch_cpu_finalize_init(void)
 
 	/*
 	 * This needs to follow the FPU initializtion, since EFI depends on it.
+	 *
+	 * EFI twiddles CR4.LASS. Do it before CR pinning.
 	 */
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
 		efi_enter_virtual_mode();
 
+	setup_cr_pinning();
+
 	/*
 	 * Ensure that access to the per CPU representation has the initial
 	 * boot CPU configuration.
-- 
2.47.2


