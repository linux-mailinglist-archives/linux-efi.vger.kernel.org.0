Return-Path: <linux-efi+bounces-2028-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524959B35F8
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6429B2313B
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56101DED5B;
	Mon, 28 Oct 2024 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oHYEM2kJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9821DE88D;
	Mon, 28 Oct 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131839; cv=none; b=nfKPpusFzsK6Y5A49qmOChRk8SBIgJ08+sMQgGl4gCv9SvWWQE+hT3QH7W640e9Vf7AKoMW/z/8pUEMPark0I2HFHGoSuEuI4M5KSZFxXrQsyMAHq3goTpsUS/3tzBrNc2ATKamqP+VSQVVjhLUSNDSHk9wEjt/Z8HtVAvYbtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131839; c=relaxed/simple;
	bh=dIp/wj6YZYefOa08wFUaFvuDpIEOByeQWZvphyXBK5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/YAEoQ4toUaFIliOsPGwefiMRXOV8de7iGtt1tI9hegSjIwBtNR/zLw7QiYlUCDqSQ40EQ1VYMjg5u5WaMUFeg+8VLdnuW2Rrff7k8VgwrneiMX4d4URCBEunrFReKSP90HmHZNCpElnEFjhTZyId8AQLM+HHzM/X+/dGlm5ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oHYEM2kJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131838; x=1761667838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIp/wj6YZYefOa08wFUaFvuDpIEOByeQWZvphyXBK5g=;
  b=oHYEM2kJVfcgqMcWfaqTf4zE8s5U0AdJpon+POkj06qDycvTQvaitGKG
   H/ZVVp6qbN1MUBOJ++E3KCVpGAOW4HAdOdRX9z3MVmlyT4FhSa+bPnEKN
   igDXBXdbQVluLtC6eYQCQuiOR+lwE1DEipp4IGhv6gXmBlhNyveVTXdoO
   iB7bbpqPeNwoFpyIhtuBpzMneon6Ln1u5P8r2IDk+EiMPre/T4G4YzMWu
   QEbp63UAcMuo7q2SBewMRHZDrf7fTcg6WzmcUyey2Ekch/VsohABlCKVh
   cX+7ashc/WD+Q7gCi32Pf7iiya6wMA9f7HabEjMWiPiILCUtbmm7c9ohd
   g==;
X-CSE-ConnectionGUID: /yvpvkIXRfaHE42J2hdljQ==
X-CSE-MsgGUID: z8uYN9N4R5+Tyx+jegcO6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32593868"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32593868"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:10:37 -0700
X-CSE-ConnectionGUID: HVJrAmVbSk+8Rwa408FxTg==
X-CSE-MsgGUID: Bnbh2LWZTASaTBk7pQCRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478049"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:10:26 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
	linux-efi@vger.kernel.org
Subject: [PATCH v5 05/16] x86/cpu: Defer CR pinning setup until after EFI initialization
Date: Mon, 28 Oct 2024 18:07:53 +0200
Message-ID: <20241028160917.1380714-6-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to map the EFI runtime services, set_virtual_address_map
needs to be called, which resides in the lower half of the address
space. This means that LASS needs to be temporarily disabled around
this call. This can only be done before the CR pinning is set up.

Move CR pinning setup behind the EFI initialization.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b24ad418536e..c249fd0aa3fb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1953,7 +1953,6 @@ static __init void identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
-	setup_cr_pinning();
 
 	tsx_init();
 	tdx_init();
@@ -2385,10 +2384,16 @@ void __init arch_cpu_finalize_init(void)
 
 	/*
 	 * This needs to follow the FPU initializtion, since EFI depends on it.
+	 * It also needs to precede the CR pinning setup, because we need to be
+	 * able to temporarily clear the CR4.LASS bit in order to execute the
+	 * set_virtual_address_map call, which resides in lower addresses and
+	 * would trip LASS if enabled.
 	 */
 	if (efi_enabled(EFI_RUNTIME_SERVICES))
 		efi_enter_virtual_mode();
 
+	setup_cr_pinning();
+
 	/*
 	 * Ensure that access to the per CPU representation has the initial
 	 * boot CPU configuration.
-- 
2.45.2


