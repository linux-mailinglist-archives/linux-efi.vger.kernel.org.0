Return-Path: <linux-efi+bounces-3860-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B5AE1CD5
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109FB7AE04A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C77A2BD5B2;
	Fri, 20 Jun 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQQqAWNn"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A929DB7F;
	Fri, 20 Jun 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427635; cv=none; b=PI3VTc96IasavLbCcPQkFmiYGkRP8LrsJysikX+5fbMReraGre2+tyN0HggJguGmSn9NKrGfKqyZ975ao+leT35KmI2/fz9jN1gTYi1LLvMCpTd4L6hL315RJV27hQfGZ/Zyav15VGHpAbck7PwiqheQ480l5Xq4eVsVGZsRP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427635; c=relaxed/simple;
	bh=UXQro1nhuXHnLN9WvBTrdf+zqqavYnpmltBFM1Abf3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7oobbqrbnPphy2885WL/6pKdRpcOyM4BieNISh0CCkt+YdoQceKUkL06/Ggoc3vt9Z0O15PA5QGui7P2PGe6EUxhBaCsNkRrnPIOq4V6XQPTkE+edLHtfPyxnZvEaZcL1a7N/OZH3L4GJlerkwqRPYdUmB/a1qlnrysT1EQpcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQQqAWNn; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427634; x=1781963634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UXQro1nhuXHnLN9WvBTrdf+zqqavYnpmltBFM1Abf3w=;
  b=cQQqAWNnPIrTd7jgAAJW1A3k3QCAQTcGyeQpXIwRCvgjs1zEE+lDHx3p
   2xPipKPnoWZ0B1e/tl2H6viWxgC8MuYelSSPBHFHiLWvdGy+gJJlegry4
   OVwtD5rdmHtdiDwKl1bnD+uOl+3ZYJg/KyRnB9EwHaG8hYnlo3NHqkJe8
   U1eVZzEvTehG3YjcA0q9HnTFQEDOop5Vgm3TlIaRMhBmXM6v9eHettmcW
   TLDmH/Q++ylzlpPL1AtU+fWsL1h5VEvEZbY5g9WZW3+rPaOMWbwI8n6ZY
   b7fvvooPbM7b21GUhZX2VCGW7XG8wsMfWVhEfnClEGDQ7pcUbl/9dEGpZ
   A==;
X-CSE-ConnectionGUID: ogjtmG97TE+iRBdKyVkelQ==
X-CSE-MsgGUID: /gEKRepgSm65w4WinwKS3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63298032"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="63298032"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:53 -0700
X-CSE-ConnectionGUID: 3cdRhCzmQ6y4eQ96FN8e8A==
X-CSE-MsgGUID: 0eoyFOJ+S1GWBUwCf2kviQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="155470819"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 20 Jun 2025 06:53:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 268609FF; Fri, 20 Jun 2025 16:53:29 +0300 (EEST)
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
Subject: [PATCHv6 14/16] x86/cpu: Make LAM depend on LASS
Date: Fri, 20 Jun 2025 16:53:22 +0300
Message-ID: <20250620135325.3300848-15-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
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


