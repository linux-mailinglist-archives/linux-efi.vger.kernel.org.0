Return-Path: <linux-efi+bounces-3977-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26181AE8337
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7414B1C23894
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AA0264611;
	Wed, 25 Jun 2025 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bUVnJDzF"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5971262FF8;
	Wed, 25 Jun 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855890; cv=none; b=DvP02n2JZMFn6IIAGRVtK8/1qE4rBbviFykOBmhE+lhTysrG96lVIgIYX5UPLKvDEbHCw1i1jwMoRasrZPvEqFfOCY3UJtDkjRB3y6OK834ts2s+PopAvMwq6u1ZWoOb7cuvI2L7jZ1A0lAmLAg62PpUtkXI7DBjwU1XLW4MxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855890; c=relaxed/simple;
	bh=KVi1SbCxLhPwipXkfMiClroXvuKW+0f0MpKQ0MUg/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o53iGuIGNn8FzeqYD+GBCf8si9tT59CRDzuJR6eBJ9iipdiHOnysrBxUW5khbLTzDPEcgYNjdGN0lHeKvmHkI3sfAlWWIXEnBSJ5SAn/+/6J2fpHJn/UkiCYPP0GcC/yz9XibSTuVegjSQ2qkHTQYcFtiMr3NcOpC321j/EGsrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bUVnJDzF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855888; x=1782391888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KVi1SbCxLhPwipXkfMiClroXvuKW+0f0MpKQ0MUg/MY=;
  b=bUVnJDzFf4MYDEiCKjnGvCm/hn7MwWM+6csKFFHai2RfoKrJz4x9DRXS
   f1DjmvLebPkAaWGn+lvi4V2D2xOxOrVOpnHxbwtwg7y2OG+ZEJe+3Fmbf
   IdXlOuMRiiToiarQyv72DrOLxTyZSpyTRIBtGumw+aF+X8PDetNYDhq3F
   T3+DDjarru73PFujlkS0D1qrP1s6cnAaEYFCczKtej7uBwOOwkxeXszBC
   L0xZeBq95YnNo4xUn+qIeRKIv0TXuXLDf8uYXhMHuxCoXzZTfEuRBdM3l
   fActcYrWJejZjcDZQhRfJyee01P1OkU9/5S5zp5r0bPsIC2p51uOZ/Gcq
   w==;
X-CSE-ConnectionGUID: OrYN/U7LTL+gpwH76T36vw==
X-CSE-MsgGUID: +SYsD78VSrO33ZJRqo5uDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53189522"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53189522"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:28 -0700
X-CSE-ConnectionGUID: GF2unmvcT8uUvY7B1febpw==
X-CSE-MsgGUID: 7pcmBo8tTpCXMijl0qyhnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151830943"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 05:51:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9A9AD4A1; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
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
Subject: [PATCHv7 04/16] x86/cpu: Defer CR pinning setup until after EFI initialization
Date: Wed, 25 Jun 2025 15:50:57 +0300
Message-ID: <20250625125112.3943745-6-kirill.shutemov@linux.intel.com>
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


