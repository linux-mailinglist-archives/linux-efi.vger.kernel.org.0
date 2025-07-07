Return-Path: <linux-efi+bounces-4160-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BEAAFAE1F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D101B17FD55
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC7293C74;
	Mon,  7 Jul 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lPy17BuD"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EF1292B51;
	Mon,  7 Jul 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875427; cv=none; b=G6SLsfN45QB5SDrR/lrXg5tFTLrzy+oTNNpEPJQMOmo/mBL5wWBEQ23AdoCf19wj7wKMrr6zMy3X8tq3DJuibRBNfJuEBq7y/hLF8a+FmqxpuURkaup6GmmR/j1bf/Wxe5v3ghRqNJk0i1nUjq/LbZfxR27tfobDP/6fR1ZCWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875427; c=relaxed/simple;
	bh=XX7DkX4IOR/Ch8/UgwLSCmQRtWcxwxGhsp1B41b3R5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8cAdjpCru2IsKvXqZ87oEkOml5XQsfuIEqgEH263s8hjCPsp014fM0SuS3+TI3cpVr1TSpKtKtTl+eiWwhDyr9O4aj3nKF2kz2yHXMJbI3XhH4OnL+RCz1UyFUYCI2Sir9+w4hqnSCfD+DMerkRUlg+IG/IYHiPGySA6TZ3+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lPy17BuD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875425; x=1783411425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XX7DkX4IOR/Ch8/UgwLSCmQRtWcxwxGhsp1B41b3R5A=;
  b=lPy17BuDnMSojFcfkW9SNZHKax2fAGdGNPtwmFFfohyreVCSjz0iZ/mP
   jeE0VTVTvyJpXL7sprnDxY/CJjLkk2fwXaEWIr+iI0RWdSBEHn/uMrL5e
   jZPhsaaKCKGYJNZ1iDn0eCUGtk+VNqM+eOb3rth6MyQ24S3CH8Pw6hLy2
   dPdQZ3470d+gKhZjkVHkkLxI1Hg8sWBEFZOu2pCDWLbLmucB3g8HcSTu0
   gqIinxXkow1/F9OLXaDty33WFBEeEflWQxCNd0MfbrvPiHCB35pWAIc9c
   gcEIbzVCi20eCMMrlqIuzKMudp/7Uvo2FlJ5VVjALjPmukyEo9R6AJv6E
   g==;
X-CSE-ConnectionGUID: 4LyXtJR9RP6vjp34uTp4DA==
X-CSE-MsgGUID: NBMJFFoXQ3mM/p1esHqZkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151952"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151952"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:41 -0700
X-CSE-ConnectionGUID: e22tqOlpTjqG/NAdDICv5w==
X-CSE-MsgGUID: UF0/80YaSOG6gdZ8LnMjbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154573898"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2025 01:03:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 46ECD991; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 13/16] x86/traps: Handle LASS thrown #SS
Date: Mon,  7 Jul 2025 11:03:13 +0300
Message-ID: <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
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

LASS throws a #GP for any violations except for stack register accesses,
in which case it throws a #SS instead. Handle this similarly to how other
LASS violations are handled.

In case of FRED, before handling #SS as LASS violation, kernel has to
check if there's a fixup for the exception. It can address #SS due to
invalid user context on ERETU. See 5105e7687ad3 ("x86/fred: Fixup
fault on ERETU by jumping to fred_entrypoint_user") for more details.

Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index f75d6a8dcf20..0f6f187b1a9e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
 		      SIGBUS, 0, NULL);
 }
 
-DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
-{
-	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
-		      0, NULL);
-}
-
 DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
 	char *str = "alignment check";
@@ -869,6 +863,41 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#define SSFSTR "stack segment"
+
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	enum kernel_exc_hint hint;
+	unsigned long exc_addr;
+
+	if (user_mode(regs))
+		goto error_trap;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
+		return;
+
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		goto error_trap;
+
+	if (notify_die(DIE_TRAP, SSFSTR, regs, error_code,
+		       X86_TRAP_SS, SIGBUS) == NOTIFY_STOP)
+		return;
+
+	hint = get_kernel_exc_address(regs, &exc_addr);
+	if (hint != EXC_NO_HINT)
+		printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint], exc_addr);
+
+	if (hint != EXC_NON_CANONICAL)
+		exc_addr = 0;
+
+	die_addr(SSFSTR, regs, error_code, exc_addr);
+	return;
+
+error_trap:
+	do_error_trap(regs, error_code, SSFSTR, X86_TRAP_SS, SIGBUS, 0, NULL);
+}
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
-- 
2.47.2


