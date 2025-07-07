Return-Path: <linux-efi+bounces-4151-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF6AFAE04
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3BE27A5714
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54E28BAA5;
	Mon,  7 Jul 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMHGlhxc"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8228A719;
	Mon,  7 Jul 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875416; cv=none; b=WV1wg4+bsHMxA3UFuVq5qfiS9qKHb3sHy5lD55QXOuvDvPqfV6MShH/AWpq5eOUTVJleaWrdcmJrLCGcDq46k2hVTlS3rJytTrGVSVh8QPWRL6a2lf+xgNGy4C42A+qXgAWzy8t2F74Lzge1gdzju7FHZnWD4Tk+CwaVQnWj4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875416; c=relaxed/simple;
	bh=G+eP9Bw73xI4j+67SYkgeX9LiSQjfbtHwX1bukiOpM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifcBZfuQiklDKEwEcXcLeSHaJoWcrqJz1wry85CwPm+sBcSL48IxVOdzhn3LKF9RWsJaFgIC80ljkz0GA31OHlP7tqYExoo2+vq4UfHMAvXTFNTXHOc9YF0Y8fUkdB9sSzMpwumIn2Z8YZiJRA94p4Prs6VQs9gMdHo0fAV91d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMHGlhxc; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875415; x=1783411415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+eP9Bw73xI4j+67SYkgeX9LiSQjfbtHwX1bukiOpM0=;
  b=eMHGlhxcAwWWwxvPsqrDXCR9/yK+W7ZXAjBPFtl5grrW1qLJWBm7MqWl
   YuY2xl3X+khKmqfm+Vx34y/fGQbMX4co7KQzNfKlhYLb7U9sqlW9vi2nz
   NMkr8vUpkCGhH4QZRalJ3ZmCt3P9zv3ZqrLs5hfR8cvI1bXukA3Zxq/hi
   cg9JBHNMfh90LtkYytWXhNyuoBlV4VM1fRyQOpsagMwUIgS++yLMEx2f0
   E0rF3EhsZs4jHIgWcLse8Wrn8Hxw3AEH+LIVlneOTWDl81MrnPdYZxnl2
   w16481lX9ADIrfdmpbaM7Pvc7c4zOrh9cZKgWEulp07AGf9yZbMb/kfZy
   Q==;
X-CSE-ConnectionGUID: KzEC1U1aTZOOu572vadoqA==
X-CSE-MsgGUID: gGCwKlDiRiuiKJgrIsm9bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53807253"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="53807253"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:33 -0700
X-CSE-ConnectionGUID: l5LBmWXXRBig4FBVoq1GFg==
X-CSE-MsgGUID: PXuB/gMDQn6i5/7M8condQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="160804330"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 07 Jul 2025 01:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D1BE1458; Mon, 07 Jul 2025 11:03:17 +0300 (EEST)
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
Subject: [PATCHv9 05/16] efi: Disable LASS around set_virtual_address_map() EFI call
Date: Mon,  7 Jul 2025 11:03:05 +0300
Message-ID: <20250707080317.3791624-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Of all the EFI runtime services, set_virtual_address_map() is the only
one that is called at its lower mapping, which LASS prohibits regardless
of EFLAGS.AC setting. The only way to allow this to happen is to disable
LASS in the CR4 register.

Disable LASS around this low address EFI call.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/platform/efi/efi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..5b23c0daedef 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -787,6 +787,7 @@ static void __init __efi_enter_virtual_mode(void)
 	int count = 0, pg_shift = 0;
 	void *new_memmap = NULL;
 	efi_status_t status;
+	unsigned long lass;
 	unsigned long pa;
 
 	if (efi_alloc_page_tables()) {
@@ -825,11 +826,25 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
+	/*
+	 * set_virtual_address_map() is the only service located at lower
+	 * addresses, so LASS has to be disabled around it.
+	 *
+	 * Note that flipping RFLAGS.AC is not sufficient for this, as it only
+	 * permits data accesses and not instruction fetch. The entire LASS
+	 * needs to be disabled.
+	 */
+	lass = cr4_read_shadow() & X86_CR4_LASS;
+	cr4_clear_bits(lass);
+
 	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
 					     efi.memmap.desc_size,
 					     efi.memmap.desc_version,
 					     (efi_memory_desc_t *)pa,
 					     efi_systab_phys);
+
+	cr4_set_bits(lass);
+
 	if (status != EFI_SUCCESS) {
 		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
 		       status);
-- 
2.47.2


