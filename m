Return-Path: <linux-efi+bounces-4154-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A0AFAE14
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4F91AA171F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD728E5F8;
	Mon,  7 Jul 2025 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lte502Uf"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2EC28CF6F;
	Mon,  7 Jul 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875420; cv=none; b=sbmy45gM5sshpcADhid5Kcn56HT77/Wo89SqnA6l55aU9U97KdLtjm4pIRkqk8DyOsLQLShaY19amr2X7Juhv7+M2vrFgZTQAFSWyZ1cWWk1HaybqYCQTVpw1ZykYWhJC7ZS1qwg8XMhDHR8SJmEloegvGxTEVoT/q0HOf3YyrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875420; c=relaxed/simple;
	bh=t8X0/YOtocOVv/4f2BHHVZROW1ElynXumE/TE+oeSvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8f2VFkCHE16+j/vAXra+A3IdC0RJvLqBI0XLW45sMlugUJQIGgro92WrRZ/iQ4x0wJdOsuEb51iAVZ9C6GhnQ6xZjhUCJI8nbpB/IH7KL3fDVP3pPs0jXLaiJzSbJumEKz0DBEC8dypDgFF+DoJAOIE9Kk8HdaMyHcQ1Ex+JhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lte502Uf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875419; x=1783411419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t8X0/YOtocOVv/4f2BHHVZROW1ElynXumE/TE+oeSvs=;
  b=Lte502UfUBkkUrb1VJUauxMj1px1dmnXQBLAZaW1wDF5cB2iLF1wH1fr
   sCIxFgSsZSCQHKCM0Rwpo6gAVzzMSnw4miVl5d8ValtccHvzZodoNszDt
   4t1xf4FM/Ia1t9/rNTkKA0/Bd/uyPe9Yr7wYhmtmjkT+J72QF25uxjG+1
   +srX1xpYbqdCOOwT0fxPpbsmCHXsG6lLZsW7Glij6Qodq5FzocI332GtP
   HXKHDO4wLMYz/f4yZnqwdv1pBGY1nK8d5kFGbzwBsxOQoJE23fVsEhY04
   1AceagcZSo1zskl68hf3gp0Y1SNxcTHDtPVIgbmwL1Opu46jj/lnoQlBV
   Q==;
X-CSE-ConnectionGUID: DadANlmER1iQD6ABOino2A==
X-CSE-MsgGUID: sfTOQO5xTQuV+W16DKVMtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151900"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151900"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:36 -0700
X-CSE-ConnectionGUID: tFC751MYSGKD/hm/hEajww==
X-CSE-MsgGUID: pIunraUpQP2J/DBggpj3GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154573889"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2025 01:03:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0A573893; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 08/16] x86/traps: Consolidate user fixups in exc_general_protection()
Date: Mon,  7 Jul 2025 11:03:08 +0300
Message-ID: <20250707080317.3791624-9-kirill.shutemov@linux.intel.com>
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

Move the UMIP exception fixup along with the other user mode fixups,
that is, under the common "if (user_mode(regs))" condition where the
rest of the fixups reside.

No functional change intended.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/kernel/traps.c | 8 +++-----
 arch/x86/kernel/umip.c  | 3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 36354b470590..25b45193eb19 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -800,11 +800,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
-	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
-			goto exit;
-	}
-
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
@@ -819,6 +814,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
+		if (fixup_umip_exception(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 5a4b21389b1d..80f2ad26363c 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -343,6 +343,9 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	void __user *uaddr;
 	struct insn insn;
 
+	if (!cpu_feature_enabled(X86_FEATURE_UMIP))
+		return false;
+
 	if (!regs)
 		return false;
 
-- 
2.47.2


