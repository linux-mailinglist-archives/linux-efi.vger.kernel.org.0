Return-Path: <linux-efi+bounces-3981-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33B4AE8346
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAD5169A07
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F32673BB;
	Wed, 25 Jun 2025 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muPW10nY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B906E265292;
	Wed, 25 Jun 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855893; cv=none; b=GFDhBs/jxiIhWuy/i4yt0odnFQsJB4PKplmF28UZyhXPP8XHDz6y/iHMR8uTUO7qsr+wiUw/3q8rThm5oVoBlMiR0IShueCQkghQ5i+ONbaq99bLWFzFW5i0E3V3ccgdYKOexpH2CycPI6V+ccTU4pVE2UKJQTBLmDjqxZjErME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855893; c=relaxed/simple;
	bh=GkZc9oX0bGyfhB00ib+Vypspe5Y0XCe0GUwAqpAwtwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ddmmxtbwx2IpDODab35XtFbakLi81sMPbyY/f/jMLvs2+Zim+/NUVdLBMVOlxkWO5VTKa3EwynfCUdhJ1C77eGfH971UfGuIR8h/at82xmEetQIrY3sEBFhg7D+aO9xZisYr0rTR0OQes8S5XlDXfEnMfbcSHnHMvKLjbT0GRag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muPW10nY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855892; x=1782391892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkZc9oX0bGyfhB00ib+Vypspe5Y0XCe0GUwAqpAwtwU=;
  b=muPW10nYNHXUfnqxx1g7Rnws7t09peTLfSEISkOD3BxHsGS/lZdt/bng
   ZznHAWy9bHvvhPVfD2gz4XW+FUq5rIJ9yPSpqWSWghv+SRtkxl+oSj3aX
   bG0z9slQ/3rSg77IVqMF5QuTyM0/3fZ5KrfwJzTbCMarldVMh8Wtmyc1V
   6bu/9NmsAeMIjLjLuACvLCYpJ3xXJqTth3py8t/Kbv5wPqU1TKt2rXW4d
   5KQQdTQBDkkTzDgHEwQxOX6Jy8rjlLtekB9mDo24T5uvIPRIyiKJLeg2/
   lf6h15JKuco5uYDhIgQdJy/jynXGEDR5isThN7wo43G1fXjXilOFXO6ur
   A==;
X-CSE-ConnectionGUID: Ci3hK6ESQuqcVwAxZMJVTA==
X-CSE-MsgGUID: Q0JhiCYyTZ6wlY0jdPlWHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53189567"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53189567"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:31 -0700
X-CSE-ConnectionGUID: MC7cDlfzQIKKuFefVebO6w==
X-CSE-MsgGUID: ycgt7at0QQSOCLeRsvfyZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151830971"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 05:51:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DA729648; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
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
Subject: [PATCHv7 08/16] x86/traps: Consolidate user fixups in exc_general_protection()
Date: Wed, 25 Jun 2025 15:51:01 +0300
Message-ID: <20250625125112.3943745-10-kirill.shutemov@linux.intel.com>
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
index c5c897a86418..10856e0ac46c 100644
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


