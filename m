Return-Path: <linux-efi+bounces-5246-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6ACC1D5E6
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709581899E62
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB07A3563E2;
	Wed, 29 Oct 2025 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAVU0klQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F431D75B;
	Wed, 29 Oct 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771978; cv=none; b=ckv98/fW+mBJkqZNrzx/Wap2AWQS0rf2bzghnZO3bO8+2ckLw8jYDfmEp90yFU96FhAM5cOmxuU+C+FfXOniWemIrPHhOLtCiLKLTr8ra2okw4tjTK1jH2EDH7WHLMAK0kEXs1Z6VKJgLxt6CbtlQ0UHD2Epfh5U7xieUJKPris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771978; c=relaxed/simple;
	bh=NOtUdL/MzSIfq6q2T/+8rdhJ1gOmHn5dV1jlrqdAtvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYskneE3rOTQnbWjwFcjjQpemhuKdi9cbXn+HRiJi4dwPGgWLPbWFxEk30ssVQlCNfvI3FZCHCLrtaXmoIORvx4IrReLSMQHdQdMbwVVoNqzNXnao3jaYN8MGswsk98XxTlJ9gmlZuGGd+YyhFcRcB+d3DQgiTFussWnEJ+1mao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAVU0klQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771977; x=1793307977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NOtUdL/MzSIfq6q2T/+8rdhJ1gOmHn5dV1jlrqdAtvw=;
  b=aAVU0klQM8lUZM75VUVqX4mM0VDxPBPT0hNue0xyfYkmBs5YoIrX3j63
   MhPcUppIF6sQXLtGuB0tFjNubCuW0jiyTy7j7egl0uYuGqMFeMcmFZfRG
   u6Kic3SRPMgWlxsGWgWKZX6OfLPxRXoL8aTiFQHRuoGYNVSgCjdBewUn7
   zSqBbw9C7EdTcnq/LDe/cKGC//pLl9JZv31umm/MpD4I+7OSlhghDm/W2
   miG2Cp0hPBAB0lc4En1ClZFDQn3mOvaDJ3OmZgXo9hG4kk+yIGYYy1Qlo
   zrsUkwuYodbM1K+gVhK6vBh/aAMDRamnLYajKGgCvc3dMkdkJeboLXZ7O
   Q==;
X-CSE-ConnectionGUID: NLYZbWQbRG6+wFRe2SZfrw==
X-CSE-MsgGUID: 8LIFBWmiTJeqWDjXsS94Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002744"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002744"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:16 -0700
X-CSE-ConnectionGUID: fPirA7vTQR2p3uUwT5jJZA==
X-CSE-MsgGUID: z1Pc2AcHSr6XGhQ5i8EtKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216432014"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:15 -0700
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
Subject: [PATCH v11 8/9] selftests/x86: Update the negative vsyscall tests to expect a #GP
Date: Wed, 29 Oct 2025 14:03:09 -0700
Message-ID: <20251029210310.1155449-9-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029210310.1155449-1-sohil.mehta@intel.com>
References: <20251029210310.1155449-1-sohil.mehta@intel.com>
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
---
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


