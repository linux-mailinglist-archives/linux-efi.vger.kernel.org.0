Return-Path: <linux-efi+bounces-4162-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F394EAFAE23
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0294D7AFBBC
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4C42951D5;
	Mon,  7 Jul 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUaC3QJ+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC85293C75;
	Mon,  7 Jul 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875428; cv=none; b=gwXtkQXfONaNLBr+ZIcrHg5zFT69EpzsVEFGvta2Nt7B3d3n4qIknZqmPCKnEYhJsCG7StqPXSQuxYfdJYsRzyhvHCrxF5V8VI/iFM+JlAX6c9ggz2oSFqv5LVrO8m1dc3316mbe3s62/pLu6qBzwwu3XnB047lsnRfAt85hHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875428; c=relaxed/simple;
	bh=NHjNJyeyoaHBgyvq1fO7NjPZypX9iUv0DN8fJhLnDZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0z7sa2bAP8+KJe7tQ12h9asGFKZCLOxqtwAw4IuklsPJqveQ4DzAWFxWEJllBDDp857z8gRr7EAHJEwxGMH5+dr11W1t3Ga/bGd4lLBV4M7R7nkwzx3W99/vEX2MtBMpKCE2gaA8fp1HygHMqY5kTgEo2KxBt7EAPuXp8q4EMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUaC3QJ+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875427; x=1783411427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NHjNJyeyoaHBgyvq1fO7NjPZypX9iUv0DN8fJhLnDZg=;
  b=mUaC3QJ+4MgGQldZdsEirfwPEuqPdr5UEGG6sx112kUoPVZjr0wUnNnT
   83xyF4XtrLiTxCEImyw3w4wIdXCmj1RGMX/TjID2oZb1r2Jgc2y4ilTNa
   QSjqg8mAVJBk+lZ+PXP6TJekzqr59Mg8BC7CMZASOvMM7+PdzvWJWI1W6
   mO8jF7c3qBjMIWK8vqAMJh2tmgrIW76NuG3Wfd/3CmcSDd+14A/CNgQwF
   JDLcmRKBGcQ7AJv2DznR5sgAaLzw6wfalwpdwstv9Dg0VE5mSCcWhCeXF
   A6sVDv8OLbTaSsfoQYGvAEx+9Wpz/rI4+VQ5yixbFoAgRnYzpASE0+OYd
   w==;
X-CSE-ConnectionGUID: NCq42qcLSOOPjPSO3aovQA==
X-CSE-MsgGUID: eWddtOK7RDWKkS9NBjXJfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151974"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151974"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:42 -0700
X-CSE-ConnectionGUID: QbZyERTwQveB+rAHFYbJYQ==
X-CSE-MsgGUID: 4cfO9IaSQTuu9vH6M/pBbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154573904"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2025 01:03:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 55183A84; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 14/16] x86/cpu: Enable LASS during CPU initialization
Date: Mon,  7 Jul 2025 11:03:14 +0300
Message-ID: <20250707080317.3791624-15-kirill.shutemov@linux.intel.com>
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
index f10f9f618805..382b687ce7e2 100644
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
@@ -1978,10 +1984,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
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


