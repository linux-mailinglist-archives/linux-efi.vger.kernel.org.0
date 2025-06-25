Return-Path: <linux-efi+bounces-3985-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F0AE8357
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B22F6A1E2B
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9F26A1A4;
	Wed, 25 Jun 2025 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsS5Gcil"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A452690D5;
	Wed, 25 Jun 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855896; cv=none; b=U8mBjaEALyDxjZmD52Y3ahWzC1TX7WJ858ylmvt/dlAz5WV8eeh3RVuOMOEbiqiSgLEYO61TSNzRudslegW+2GMZSfX7vBROxIJGnV9L3AJ0Hw1WEUfIMsgqaE2ktdFrVULLJPIIGPffDsaeevFllbL66ZXeXvm5JUieyoM65Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855896; c=relaxed/simple;
	bh=7foUi90kAx/WEJRwF/WT7nYOqwMH5sjvGQWVUc7hDJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiSrNRRwPcAxr8uqAs0VfOdSCx6Yf1dNXelBHq4k1H2pJmwfN4xEct0SMfBNB9p2GBoJjSY7L7giSu182RxuycnheIkqFP45IeWhHVkoXzshpyOh4LbZqNhdYkHSTf4PnCSfIYRswtROSYEk/5ZxtdbUDL34GV+y7qgF45z8AIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsS5Gcil; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855895; x=1782391895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7foUi90kAx/WEJRwF/WT7nYOqwMH5sjvGQWVUc7hDJU=;
  b=GsS5GcilBy/mCT0gyYN4iNDpZvvSK6/OhMZn/h5aCYqsHmiq4VipAzlA
   6UvrTvgFshUdMv1Y98sWPYnEOEoOgpYz5sv2s0GqHS5z2cEsc3C43bJBn
   gN3/AMHR1uW8/szoK9ayp9hkkQ1e9P7pGMnCfjsHzSTD4cSat/AYMqTbJ
   p8+J6v1QMCs7kNhisXPsIfsYPKmY8gQiwPJdgZCmGEKOPBop5F11CzkMM
   RdZhOZvrExwuup7PM5p0QYriJ63/DrJ4+lJ9NNO5Gw9ukHWcpWTrWi1ui
   ZUw0TC0ornOrV4+q0540zUGBBD+JyfKH90YTS2OfHOhqnvrosw7im/avk
   Q==;
X-CSE-ConnectionGUID: enyVq8XZRays0DZ1+UENwQ==
X-CSE-MsgGUID: R8bETpfwTXqo+Vm4HMHdiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56908347"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="56908347"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:34 -0700
X-CSE-ConnectionGUID: fXXgAvxmRB2H2v15sARs1w==
X-CSE-MsgGUID: BMzC/J5HTw+85PN7O7+iKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152919809"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 05:51:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1B13173B; Wed, 25 Jun 2025 15:51:13 +0300 (EEST)
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
Subject: [PATCHv7 12/16] x86/traps: Communicate a LASS violation in #GP message
Date: Wed, 25 Jun 2025 15:51:05 +0300
Message-ID: <20250625125112.3943745-14-kirill.shutemov@linux.intel.com>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Provide a more helpful message on #GP when a kernel side LASS violation
is detected.

A NULL pointer dereference is reported if a LASS violation occurs due to
accessing the first page frame.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 40e34bb66d7c..e2ad760b17ea 100644
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
+static const char *kernel_gp_hint_help[] = {
+	[GP_NON_CANONICAL]	= "probably for non-canonical address",
+	[GP_CANONICAL]		= "maybe for address",
+	[GP_LASS_VIOLATION]	= "LASS prevented access to address",
+	[GP_NULL_POINTER]	= "kernel NULL pointer dereference",
 };
 
 /*
@@ -672,6 +681,12 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	if (*addr < ~__VIRTUAL_MASK &&
 	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
 		return GP_NON_CANONICAL;
+	else if (*addr < ~__VIRTUAL_MASK &&
+		 cpu_feature_enabled(X86_FEATURE_LASS)) {
+		if (*addr < PAGE_SIZE)
+			return GP_NULL_POINTER;
+		return GP_LASS_VIOLATION;
+	}
 #endif
 
 	return GP_CANONICAL;
@@ -833,11 +848,10 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
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


