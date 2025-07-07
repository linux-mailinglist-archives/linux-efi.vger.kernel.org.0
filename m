Return-Path: <linux-efi+bounces-4161-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A36AFAE28
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693D21AA203A
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC6C2949F3;
	Mon,  7 Jul 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMXK1WFj"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06E293C4E;
	Mon,  7 Jul 2025 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875427; cv=none; b=fvFNJQZm9UG8mH1H26PopoZAe9TiwptL1JygcMf/2JA0RjC9Zw0H0MYFnLBbGrHgCwcOG08kyvY7QJfm/SUtqErJa8OluXw/WlhVM2vYMxjQuTRqlNmNejNdeV6pEH5K9mPQEGVH49wlC9QCvFNfVUASrFsNdYdvCG6w3sr4l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875427; c=relaxed/simple;
	bh=m+2FhdUaetES/9CojuoZFSartEN5xSLt9c4CTcF72II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXcGD1ltQVczZWWFjV6Ea/Dbr8sz+9+AJt+N//cGz8Esns8q6r32HpGN4uvX+Hj/StxkV115XW1aj/gPA1GzUkFPACup2thzUB6RBzMuk+YvsJfl+rDaFCWSp5KndEYKvRVYbAgX+HAMr4HDJH6zwur5Qh5EitiucMLmuZls8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMXK1WFj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875426; x=1783411426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m+2FhdUaetES/9CojuoZFSartEN5xSLt9c4CTcF72II=;
  b=FMXK1WFjmTJpzSE9lVI6Non7XZp65BBc7U9wp5QQNBWoNVSFiH1udX2h
   NQ95Ut/F5dznUQUOqWwxM8Xlv0wJwL8UHbeQp++qU1e5iTItsJqZCp29g
   +W1rHWBE3WquN62NmEwm35uhFoSvcb5sVEIoTiQVBoafkVHuYsDlvRWM2
   v7PEor+wimAM5VaJuJtLCL5ob20fPl38/HD2W0udlG0OICkmhMdd7HRZ5
   NpkJLsOGbV4fBF9S5A98N7+FLbFO8Te4BeRh/XNWgrJiyo1FHjBrmSAQQ
   k5uNNsE4siE7++m0JjZrBwOkosEtRAC8AsLuXTEGN53UFFaKVmSaKXbIP
   Q==;
X-CSE-ConnectionGUID: KQrwkobySrGg8jL2Nr6auw==
X-CSE-MsgGUID: LyzwfI+hTZOCr+zLb745eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151948"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151948"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:40 -0700
X-CSE-ConnectionGUID: wQbsEHE6SuWCV2Nk2ryjDg==
X-CSE-MsgGUID: /W4eV94GTXa7sKygn/q5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154573896"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2025 01:03:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2BFB4928; Mon, 07 Jul 2025 11:03:18 +0300 (EEST)
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
Subject: [PATCHv9 11/16] x86/traps: Communicate a LASS violation in #GP message
Date: Mon,  7 Jul 2025 11:03:11 +0300
Message-ID: <20250707080317.3791624-12-kirill.shutemov@linux.intel.com>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Provide a more helpful message on #GP when a kernel side LASS violation
is detected.

A NULL pointer dereference is reported if a LASS violation occurs due to
accessing the first page frame.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 59bfbdf0a1a0..4a4194e1d119 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -636,7 +636,16 @@ DEFINE_IDTENTRY(exc_bounds)
 enum kernel_gp_hint {
 	GP_NO_HINT,
 	GP_NON_CANONICAL,
-	GP_CANONICAL
+	GP_CANONICAL,
+	GP_LASS_VIOLATION,
+	GP_NULL_POINTER,
+};
+
+static const char * const kernel_gp_hint_help[] = {
+	[GP_NON_CANONICAL]	= "probably for non-canonical address",
+	[GP_CANONICAL]		= "maybe for address",
+	[GP_LASS_VIOLATION]	= "LASS prevented access to address",
+	[GP_NULL_POINTER]	= "kernel NULL pointer dereference",
 };
 
 /*
@@ -664,14 +673,23 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 		return GP_NO_HINT;
 
 #ifdef CONFIG_X86_64
-	/*
-	 * Check that:
-	 *  - the operand is not in the kernel half
-	 *  - the last byte of the operand is not in the user canonical half
-	 */
-	if (*addr < ~__VIRTUAL_MASK &&
-	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
+	/* Operand is in the kernel half */
+	if (*addr >= ~__VIRTUAL_MASK)
+		return GP_CANONICAL;
+
+	/* The last byte of the operand is not in the user canonical half */
+	if (*addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
 		return GP_NON_CANONICAL;
+
+	/*
+	 * If LASS is enabled, NULL pointer dereference generates
+	 * #GP instead of #PF.
+	 */
+	if (*addr < PAGE_SIZE)
+		return GP_NULL_POINTER;
+
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		return GP_LASS_VIOLATION;
 #endif
 
 	return GP_CANONICAL;
@@ -833,11 +851,10 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	else
 		hint = get_kernel_gp_address(regs, &gp_addr);
 
-	if (hint != GP_NO_HINT)
+	if (hint != GP_NO_HINT) {
 		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 (hint == GP_NON_CANONICAL) ? "probably for non-canonical address"
-						    : "maybe for address",
-			 gp_addr);
+			 kernel_gp_hint_help[hint], gp_addr);
+	}
 
 	/*
 	 * KASAN is interested only in the non-canonical case, clear it
-- 
2.47.2


