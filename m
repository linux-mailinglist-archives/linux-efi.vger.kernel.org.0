Return-Path: <linux-efi+bounces-4067-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FEAEF445
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D461C016A5
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2040D274659;
	Tue,  1 Jul 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WmaMpHVG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F226FD8F;
	Tue,  1 Jul 2025 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363966; cv=none; b=YXpgNyTcSq3V7khxph5nxKPlJe52wq70azp2deTZOwKZVCXis7in5pKfUbQh5vTbK1jyoBasKIXz5Hsswido3V18r2L7F+F8FFga2jEnzbJFjSKp4NoLkdm25qiiS70MRju+E1kWj04nh6err9rEmHYxlSybRJRtnEmkoInlKn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363966; c=relaxed/simple;
	bh=qO+8BSDMXd1kOh4db6N91L5SEjVjt9oi3Mr4Xl+KkEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lwxD3QuzyRn1TG745MShYJ7qm30JsrUeuYrWGcX1GLiqBBXYK43mk9CBfUEX2Ahn9iLsXPIZ5d1bEAEl6rLPq3NqH3Kz8IIjpKZK8SsvXisD3D/BggeWaSgTBsc4j4wITfBTPMuVi/PBJYJGdHeqVI+yPf/PJkBCu63p1mSz9uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WmaMpHVG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363965; x=1782899965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qO+8BSDMXd1kOh4db6N91L5SEjVjt9oi3Mr4Xl+KkEE=;
  b=WmaMpHVGop6nEsng66U5j/rGLfp6s+xASHTJvTDP0HKupiRdPkOuBcco
   x7v/AioGDfewyMmkm0oEzddI72nJx6jh/TCTKyDTWhepuUCVdMmPJL42G
   52SvoLlU4ughO6r2uH21n+YPfGPI+KTCy3d831Xze+sgdwsTtvm7Be2cv
   tN6gF89CaZu4Ndg3hiexe8q6G8Nqiw8HT7AX3IMzcRLDD3WsHbNFqDrsY
   i+UWX2mz+BF0MtvhFmrZQTfGLnZWQhpCBwkf6T0KlUjfzkMHTXQZTBRXg
   IOVlZSmGcsNcMrx7ENhJYl5fG44jwyow/3aJ2DJdxyoYbltfI5FKphYAI
   w==;
X-CSE-ConnectionGUID: INofQOkhR8uKwSMrC/jCHA==
X-CSE-MsgGUID: B+hk4MSjQXmi70Z6aharZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71048766"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71048766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:23 -0700
X-CSE-ConnectionGUID: aOqy9tIvQbafvLKOgawDGg==
X-CSE-MsgGUID: auP5LPesQ/m7qenBhDetrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177390854"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 02:59:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DDBB9893; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
Date: Tue,  1 Jul 2025 12:58:43 +0300
Message-ID: <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
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
 arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ceb091f17a5b..f9ca5b911141 100644
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
@@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#define SSFSTR "stack segment fault"
+
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	if (user_mode(regs))
+		goto error_trap;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
+		enum kernel_exc_hint hint;
+		unsigned long exc_addr;
+
+		hint = get_kernel_exc_address(regs, &exc_addr);
+		if (hint != EXC_NO_HINT) {
+			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
+			       exc_addr);
+		}
+
+		if (hint != EXC_NON_CANONICAL)
+			exc_addr = 0;
+
+		die_addr(SSFSTR, regs, error_code, exc_addr);
+		return;
+	}
+
+error_trap:
+	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
+		      0, NULL);
+}
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
-- 
2.47.2


