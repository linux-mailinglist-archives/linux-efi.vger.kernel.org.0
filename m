Return-Path: <linux-efi+bounces-4065-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D81AEF438
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24DA3A705F
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0412741C9;
	Tue,  1 Jul 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejfPYMLg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD31273D94;
	Tue,  1 Jul 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363956; cv=none; b=SjpneiIyTSiYIH7nxzTxaKtV8XuVe94W2QyBPovAh9v7ZE1vUT1X61YtCg5Y8Rd5mzJkD3HyQXIr9XhfeR9tu0835cQDk5oBPdZG0cLfBtdq5IGbfHonwOAvaL9BSsFqIT5DWhdikK+X/EF3tBjkQKb6acIt9cY7QQKXXWStV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363956; c=relaxed/simple;
	bh=UXQro1nhuXHnLN9WvBTrdf+zqqavYnpmltBFM1Abf3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO2QzOnHEx39XvSNTXJhC317ym8JCgOeiGnzQQEp995FkbQ2e57iwhjePOxemrTuDf5HmOMP/D1QOsGJKRm8fxKI8c19ZTPCuOribsdcyv5E8VETpUVLpDM9SheLrzACs1Y9X5nVk2FbyWYG/lni94Pe2brhxn0B7vEBiuzPBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejfPYMLg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363955; x=1782899955;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXQro1nhuXHnLN9WvBTrdf+zqqavYnpmltBFM1Abf3w=;
  b=ejfPYMLgrwFcX95hulEJYO1dBdCj7KFTKjxDc7AGqQzsCUUsaNBVgjHE
   xYpWCfJ9PecjQaYeNnMafanPBw7vphf+Zlf5jg8nTl2ZkGB5kgvZdRN7r
   TxUR/KSOjTRo1dKuH+EH56XhWfXZXp921LLdZkzitB5UsiAja5z3EiHxS
   U+WNv2CGbgPXMUgUgE+YdsTswHCjfZ1JwCN+Oj4YsbqnpYDOlVaZtP39u
   9D1lBABuGojAMCkahypsKBIEo+qJXw1PAU9RVOEjRskbmhQ3g9bDTduXb
   iM6txixxAtHzNECuRyOZ+Y2beOzAWxLBvzTng6U0t3dntY0GWbZs2crFi
   Q==;
X-CSE-ConnectionGUID: j0lR17VMRZ6ISkkdrlJQ/Q==
X-CSE-MsgGUID: KgZ9nYxySSyLsdbpwKZkIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57428151"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57428151"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:14 -0700
X-CSE-ConnectionGUID: 2JOVmV3pT+qr+n/Ir31q3A==
X-CSE-MsgGUID: xXwqX3z+S2eyf6yOYGz41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190896444"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 02:59:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E9CF28E9; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 15/17] x86/cpu: Make LAM depend on LASS
Date: Tue,  1 Jul 2025 12:58:44 +0300
Message-ID: <20250701095849.2360685-16-kirill.shutemov@linux.intel.com>
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

To prevent exploits for Spectre based on LAM as demonstrated by the
whitepaper [1], make LAM depend on LASS, which avoids this type of
vulnerability.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 98d0cdd82574..11bb9ed40140 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -90,6 +90,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_SPEC_CTRL_SSBD,		X86_FEATURE_SPEC_CTRL },
 	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
+	{ X86_FEATURE_LAM,			X86_FEATURE_LASS      },
 	{}
 };
 
-- 
2.47.2


