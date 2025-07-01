Return-Path: <linux-efi+bounces-4069-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC34AEF441
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793454A3FBC
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345FF2749F4;
	Tue,  1 Jul 2025 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YP/DMTij"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA22701D9;
	Tue,  1 Jul 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363977; cv=none; b=mD4t+gKbcuttmoR1MpLiE4Pk3lYyROLYdoR+WkLIQsZOrXE00DdWQ6jyhQuME6p6WQ2PD9Fwq037ccIwq9g80eLlWxQhiXcHMbNDSWnpUREUF1AONndebAAes82JLUuPX8uMYnZ1nMx3goLV2g9ii929/Git3jchFplR/PMyTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363977; c=relaxed/simple;
	bh=OjJNhJk2T736RflVUZxtae35YdvRzXSJjxBWWJGThLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSqAXxI8r0lRVnFYW38S07T6OcU10h7fSbabwg4j1+FCnfSe7dWe3lio7gBIRhtbUxvxE6y+Kah9NrSwl82+jd8GWLcQ/WkO99r1j08n1uwKX/N4IyYJuU13IYMXk9vA5tCvrlJwzUhb5R9drP1cxskmH4KyQTspvqcGGki13eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YP/DMTij; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363976; x=1782899976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjJNhJk2T736RflVUZxtae35YdvRzXSJjxBWWJGThLU=;
  b=YP/DMTijQqpMtGIMzsPTvzIDrMnKZGHi02km6MRFFDk64YfrpWHJIyYv
   x0GGEdjlcvWiWVODmyDkT3AGH5voTsMTK5joT1tawgVlJwmnIvNmIa45t
   gw4aPgObBjgfJUKrALzpc0ZW95SW2vALY7vq1YSLTDKCYB8Et1YvPjK4I
   TBnY+8sV3hgbeWWMrglYmjQkm4lBsbtbr9YVD30xgNNjJBh7ZYnfe/8NK
   +12ecyr0vLBc1p0V2WdyVUE/25wMEWK6CcuzlTZ2rOuQ+OnSCsdZNtRvZ
   f40irAaT07Vzp0IKNAPSKH39auRPWv9texeWUK5De7NqygA5dNtB0VGVY
   g==;
X-CSE-ConnectionGUID: OaEi3tHTT7CmW2iPncda9Q==
X-CSE-MsgGUID: eG0Y97r4TbCA9smnaRNWHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57428212"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57428212"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:15 -0700
X-CSE-ConnectionGUID: wkESWtlpRQ+HNh/NQSpitw==
X-CSE-MsgGUID: ldjqWFxdSzaadhor3s4cTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154216196"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 01 Jul 2025 02:59:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 03531928; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 16/17] x86/cpu: Enable LASS during CPU initialization
Date: Tue,  1 Jul 2025 12:58:45 +0300
Message-ID: <20250701095849.2360685-17-kirill.shutemov@linux.intel.com>
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

From: Sohil Mehta <sohil.mehta@intel.com>

Being a security feature, enable LASS by default if the platform
supports it.

While at it, get rid of the comment above the SMAP/SMEP/UMIP/LASS setup
instead of updating it to mention LASS as well, as the whole sequence is
quite self-explanatory.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1552c7510380..97a228f917a9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -401,6 +401,12 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 	cr4_clear_bits(X86_CR4_UMIP);
 }
 
+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
+{
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		cr4_set_bits(X86_CR4_LASS);
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED |
@@ -1975,10 +1981,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
 
-	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_lass(c);
 
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
-- 
2.47.2


