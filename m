Return-Path: <linux-efi+bounces-5503-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52FC5A642
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74C4E4E8C90
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21A9329383;
	Thu, 13 Nov 2025 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdOleITJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A5732826F;
	Thu, 13 Nov 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073924; cv=none; b=aE0HhRori/B6RJn1tZ5delHa0t9PENJ4EjH/zZX16RVpL6sMFBx4fiyaVZdKVtGsNUYLPBhDCk75IIFXgLk76FKn5FIoNUdn0vwoUeCFZPoTdBb87a7nZetejqqnEYZU97VInttljnVDDBXZ/yoVq0AEuv14fPQiWomL1Y9Kxyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073924; c=relaxed/simple;
	bh=Of1UkDgA+A8BDxzkeo8tPZu02XdKsJjP//uVe66ASjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItVrn4E7ETc9P3G9AuNMRBmX79vYZqHx6KdeLpHrN1gEvzBAn39A+EUpst3wkWlYzV2iznboYNEJT9g62hGKPqVS5VfiKnrWlgiU4qmE9OFJs4O0pMIo5foXXtj1AryRTu3JHEtxWGa4+xz/MkPaQF0Oym2mbNvAzPlXkLcETYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdOleITJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073923; x=1794609923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Of1UkDgA+A8BDxzkeo8tPZu02XdKsJjP//uVe66ASjQ=;
  b=FdOleITJIndbYKMCpO11kKi0fhmkG7vF9nEou8MZJO/ty7tH5xBryqLQ
   X/BfW0FLlCPsGZ8OE4HupyPIUtUpU3Oe6MyZxrwDibuAzfsFEflqTjrSM
   ZtHXjFdQecylro/x+/pQDzpcWYkG4P90P5ly8BM50tlcASf686Wc05zrV
   j5iPVqsEOoB7oDvT06Wx/cIXlAzM2uussjiv407KU44tHst8syLIVhveL
   T4V+ffjpxQpId584AOgpvoW/duGSa9T2jif9LPXmcNWSmSuOZejJ24MTQ
   uiFmEIRBxFwrfWNGko80zlV/3a5yZ0owsrH5WfdfWPKXU3Tioi0bfsrME
   A==;
X-CSE-ConnectionGUID: 0SMk1iW4TdCGTSJDd7ac9A==
X-CSE-MsgGUID: FBQAl6mOTt+BtxY2bgGESA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051981"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051981"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:19 -0800
X-CSE-ConnectionGUID: VHbPE4F8T+mG96PnYUqm6A==
X-CSE-MsgGUID: s0Es68gKQpKnvRfIz/cSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611105"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:18 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v12 7/8] selftests/x86: Update the negative vsyscall tests to expect a #GP
Date: Thu, 13 Nov 2025 14:42:03 -0800
Message-ID: <20251113224204.50391-8-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113224204.50391-1-sohil.mehta@intel.com>
References: <20251113224204.50391-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the vsyscall selftests expect a #PF when vsyscalls are disabled.
However, with LASS enabled, an invalid access results in a SIGSEGV due
to a #GP instead of a #PF. One such negative test fails because it is
expecting X86_PF_INSTR to be set.

Update the failing test to expect either a #GP or a #PF. Also, update
the printed messages to show the trap number (denoting the type of
fault) instead of assuming a #PF.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v12:
 - Pick up review tag.

v11:
 - New patch (Fixes a vsyscall selftest failure)
---
 tools/testing/selftests/x86/test_vsyscall.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 05e1e6774fba..918eaec8bfbe 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -308,12 +308,13 @@ static void test_getcpu(int cpu)
 #ifdef __x86_64__
 
 static jmp_buf jmpbuf;
-static volatile unsigned long segv_err;
+static volatile unsigned long segv_err, segv_trapno;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
 	ucontext_t *ctx = (ucontext_t *)ctx_void;
 
+	segv_trapno = ctx->uc_mcontext.gregs[REG_TRAPNO];
 	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
 	siglongjmp(jmpbuf, 1);
 }
@@ -336,7 +337,8 @@ static void test_vsys_r(void)
 	else if (can_read)
 		ksft_test_result_pass("We have read access\n");
 	else
-		ksft_test_result_pass("We do not have read access: #PF(0x%lx)\n", segv_err);
+		ksft_test_result_pass("We do not have read access (trap=%ld, error=0x%lx)\n",
+				      segv_trapno, segv_err);
 }
 
 static void test_vsys_x(void)
@@ -347,7 +349,7 @@ static void test_vsys_x(void)
 		return;
 	}
 
-	ksft_print_msg("Make sure that vsyscalls really page fault\n");
+	ksft_print_msg("Make sure that vsyscalls really cause a fault\n");
 
 	bool can_exec;
 	if (sigsetjmp(jmpbuf, 1) == 0) {
@@ -358,13 +360,14 @@ static void test_vsys_x(void)
 	}
 
 	if (can_exec)
-		ksft_test_result_fail("Executing the vsyscall did not page fault\n");
-	else if (segv_err & (1 << 4)) /* INSTR */
-		ksft_test_result_pass("Executing the vsyscall page failed: #PF(0x%lx)\n",
-				      segv_err);
+		ksft_test_result_fail("Executing the vsyscall did not fault\n");
+	/* #GP or #PF (with X86_PF_INSTR) */
+	else if ((segv_trapno == 13) || ((segv_trapno == 14) && (segv_err & (1 << 4))))
+		ksft_test_result_pass("Executing the vsyscall page failed (trap=%ld, error=0x%lx)\n",
+				      segv_trapno, segv_err);
 	else
-		ksft_test_result_fail("Execution failed with the wrong error: #PF(0x%lx)\n",
-				      segv_err);
+		ksft_test_result_fail("Execution failed with the wrong error (trap=%ld, error=0x%lx)\n",
+				      segv_trapno, segv_err);
 }
 
 /*
-- 
2.43.0


