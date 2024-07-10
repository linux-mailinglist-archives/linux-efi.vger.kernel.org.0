Return-Path: <linux-efi+bounces-1403-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E892D5F5
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 18:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C645C1F26B12
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 16:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599AF194C8C;
	Wed, 10 Jul 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pce73Kgt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3D194AC4;
	Wed, 10 Jul 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627887; cv=none; b=ej/ss6izGaHmS8UQnPGL/FWw5Uqw+tVKR+RNPyFpKy4Z29fUPVjoCwE2+XT+0LyYqhy3s0pUBZCzTYD00ug/yL1N51gnYRAelwzxWr5KIplTQUOIEdlVKt+zdAEEoKTSAxFssefqRz3VNdzK/mWAdeT9d1E+jFJIur1RGiGXzqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627887; c=relaxed/simple;
	bh=XMtBh7oo1bF8NIbpCrCLnqzYZF6Hphn7iDTKPoNjiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byKGDyl+q1b2Emf9mPYAq+dW6o2sVGfHQ3bf83LNWo68250UzC+k4WrKSokAuekhyJDnDLUXHjP+sMLQxDxSuXGi64DC6olDP2420QT0237pSy4yu/ERV2Wt26kD50POQPLhNPpPOGmM4p3qrllF7X3rpTei0EhKbFo6hKEFLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pce73Kgt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627886; x=1752163886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XMtBh7oo1bF8NIbpCrCLnqzYZF6Hphn7iDTKPoNjiOo=;
  b=Pce73KgtyXmwSLtTHypYHgqZcrXlM4IVZjpbKGBqwAs2TLeCTME/EFqF
   VBE/j7tv5IRAfg+fFGosvaaE83lYBa4B8xeNbHGF5kDkX1WMIoNb7vXuz
   am88HkpBS5CkjqoS4b/VqfCq/PBU2sqCP/rWN6jTS9T0dmjmQM4HXNepe
   MwIcGsEOz5e5Lycfm2IrGaBsR5yGc84mfEuIVzV/f56CGYGBy6LSSJSeq
   /FvXULEMtI3ViXjxBrytHDtAcPABN8KJgNVmn9HOtupfVOkkFcHN/tHb7
   8dIjgTUu0ZjZOwlcOmB99N3WslNZ89mT2u2qQcaaKqslVNr6cLxPgYu7e
   g==;
X-CSE-ConnectionGUID: TDff9cYPQ4uCj0njgAzq3A==
X-CSE-MsgGUID: 8yLhNe3iQzSACRL1YNAUqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18103517"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18103517"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:11:25 -0700
X-CSE-ConnectionGUID: SFsDpgJlTU+quMknE7O2AQ==
X-CSE-MsgGUID: KhawRVzaSrSwiStGfsUbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53085670"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:11:13 -0700
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
	Yian Chen <yian.chen@intel.com>,
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
Subject: [PATCH v4 14/16] x86/traps: Communicate a LASS violation in #GP message
Date: Wed, 10 Jul 2024 19:06:50 +0300
Message-ID: <20240710160655.3402786-15-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide a more helpful message on #GP when a kernel side LASS violation
is detected.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/traps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c70d75769b1a..42c032106024 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -488,7 +488,8 @@ DEFINE_IDTENTRY(exc_bounds)
 enum kernel_gp_hint {
 	GP_NO_HINT,
 	GP_NON_CANONICAL,
-	GP_CANONICAL
+	GP_CANONICAL,
+	GP_LASS_VIOLATION
 };
 
 /*
@@ -524,6 +525,8 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	if (*addr < ~__VIRTUAL_MASK &&
 	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
 		return GP_NON_CANONICAL;
+	else if (*addr < ~__VIRTUAL_MASK && cpu_feature_enabled(X86_FEATURE_LASS))
+		return GP_LASS_VIOLATION;
 #endif
 
 	return GP_CANONICAL;
@@ -647,6 +650,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
 	unsigned long gp_addr;
+	static char *help[] = {
+		[GP_NON_CANONICAL]	= "probably for non-canonical address",
+		[GP_CANONICAL]		= "maybe for address",
+		[GP_LASS_VIOLATION]	= "LASS prevented access to address"
+	};
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
 		return;
@@ -686,9 +694,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		hint = get_kernel_gp_address(regs, &gp_addr);
 
 	if (hint != GP_NO_HINT)
-		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 (hint == GP_NON_CANONICAL) ? "probably for non-canonical address"
-						    : "maybe for address",
+		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx", help[hint],
 			 gp_addr);
 
 	/*
-- 
2.43.0


