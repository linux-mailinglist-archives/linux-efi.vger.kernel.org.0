Return-Path: <linux-efi+bounces-4158-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9598AFAE22
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4AE1AA2256
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AB292B5C;
	Mon,  7 Jul 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXryNsmH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F5290DAC;
	Mon,  7 Jul 2025 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875424; cv=none; b=UECtdJK83R5c6BYfxvfE5uO3rCjFmhxbgqNlQwwmRorXs+nNlHd7V3slcsjjcJ0gsV/5rsWQcRzGpfEW5trbysDiMg5Be31x4OOSGAa+4I+TaalwHMPt7hmpor1pqOsk5tMlj8QS6MHtENjVnw2cr4e8zcQ75j1GyCpSh4MWekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875424; c=relaxed/simple;
	bh=9zPszbQZQjES0k+d8nALovvZoQtbhWaMKlfuK3ZvgbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XofgkgZQ0NNs+ZtBkMSH95LLNDqg2TLzS8uZdaZcALXIisLhJuAcKcgrPMLNRRboyWUwF0V1b5hBjjsXlFV+xtcSnxPPFR4YxHwy8ziDcmWum69Or2ex9135SYc0YTts0yU1K0cSHRYm9a5aKIZVUbKd7JWDfFEUwzuki5yLRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXryNsmH; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875423; x=1783411423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9zPszbQZQjES0k+d8nALovvZoQtbhWaMKlfuK3ZvgbI=;
  b=HXryNsmHMREvhV+LkrBHsfXq+FbD185FEBonJ1UOvdGsBxqpEomXYtGo
   7ux8qwgNGNJiRhvRIqCkJ4tkO9dymOiMd12q6hN6maClbvfSrmAzclo9G
   97TqUm9N9r3GGsCK14OlGbRI2vRfAyKJUD5x//2W+jtTzOFk4wiBgFWwS
   bgwt8eqEVyXTX2zLZfLTXgfoAEGQOAwtTbTpOq5lcgHfAxcXYF7QBCl/I
   aoB19D9MH8xXlS4ZoZ85c6g1Lr9c1/7jFJMA6SKZGn03f1vjaipk3Iweq
   CvAATcI2cLmjULOtAwJqajdaXsslPq5SDHvHGsL7rpQNhNbEmH0pPI/Y5
   Q==;
X-CSE-ConnectionGUID: /nwpYCtqT6Gh0Yr3H0ffMw==
X-CSE-MsgGUID: wy5rUS3YQH66xcUDyXGCoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="57891149"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="57891149"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:42 -0700
X-CSE-ConnectionGUID: o7N4f0s0Rp+nVzY0KP0MFQ==
X-CSE-MsgGUID: MHWoadKIQDayJn45LK1r9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="186171987"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 07 Jul 2025 01:03:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5F857AA7; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 15/16] x86/cpu: Make LAM depend on LASS
Date: Mon,  7 Jul 2025 11:03:15 +0300
Message-ID: <20250707080317.3791624-16-kirill.shutemov@linux.intel.com>
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

To prevent exploits for Spectre based on LAM as demonstrated by the
whitepaper [1], make LAM depend on LASS, which avoids this type of
vulnerability.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
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


