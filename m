Return-Path: <linux-efi+bounces-3979-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A987AE8340
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 929F27AA724
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A7C2652AC;
	Wed, 25 Jun 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUqzN/ov"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001A2641CC;
	Wed, 25 Jun 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855891; cv=none; b=Oby9DNXNURnT4C/rhemDNv0Q9i9y0gOs4yMEHBkH8cozBhkEn55WosvuSDyBpZYs4ueBVG0j0JEydnwCrxTCzMVncHy0f3klxnG+ua9RoHojIuyJtd4sEKKcgq+OPsKnB+tl0PvkUe64kJXmLz8wLMe+74VID7X+9ZotIS3lxIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855891; c=relaxed/simple;
	bh=TQ5RCfOQ/5tuZqESL8hi2WCyzYpg/ALQ/w3Eenbo4Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0ygqzR3yHjvQ2q2IVUyCqA1N6nXqnNRHDdQ3uyetNq3NEc+YT7EN38+h30QUbwyn2cRcwryY1SkJQBFf6LU0UYth0csch12t6SxDoSt1glHepYXgBcCMw0Wf29C4tA6Ni4wB+sJv1qFl82Oh1pRW+pO6pcwgUYWlDLPW5Tghzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUqzN/ov; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855890; x=1782391890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQ5RCfOQ/5tuZqESL8hi2WCyzYpg/ALQ/w3Eenbo4Ow=;
  b=BUqzN/ov+MIAi+jUqRuffj81qrn0hP9MZdxBWdNLhik+850nUOcAT4yW
   ngER3URvQmMpuWk6LAGqCm7NNSg1qd3a5TauiDYfwMTFTbysPQ/1b4VT/
   fB7c2Id0dwQPJh1Z6l738UDe6pTWUvurVnY9OKpV8NB9H08mKScoyu8Ci
   SmoO3lhrPVpsDuYQFX7jtVEv9igxNcVy8P9XFIDl6/9mfnKusWvL36ph3
   1TCrObyWfS7mNs1Oj7IFtxqKeCP4OdQA/YX3hM8/6Qcq3F9JLbcmsQflm
   Q5KkkfJAzHTIp147w46tuXo7oDiKEFbX/VWe0FTgEfkgGXIFanfzyT0QN
   w==;
X-CSE-ConnectionGUID: dfGE9jEvSPW+F9+vDE7ypQ==
X-CSE-MsgGUID: eps+vFMtTs+eTrzRZXlPSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56908319"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="56908319"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:29 -0700
X-CSE-ConnectionGUID: zHGruUlaTpuSShyTG2JVlw==
X-CSE-MsgGUID: rT6unHdoRUGtZbk9Fc4xfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152919793"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 05:51:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id BFBB74E1; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
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
Subject: [PATCHv7 06/16] x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall
Date: Wed, 25 Jun 2025 15:50:59 +0300
Message-ID: <20250625125112.3943745-8-kirill.shutemov@linux.intel.com>
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

emulate_vsyscall() expects to see X86_PF_INSTR in PFEC on a vsyscall
page fault, but the CPU does not report X86_PF_INSTR if neither
X86_FEATURE_NX nor X86_FEATURE_SMEP are enabled.

X86_FEATURE_NX should be enabled on nearly all 64-bit CPUs, except for
early P4 processors that did not support this feature.

Instead of explicitly checking for X86_PF_INSTR, compare the fault
address against RIP.

On machines with X86_FEATURE_NX enabled, issue a warning if RIP is equal
to fault address but X86_PF_INSTR is absent.

Originally-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/all/bd81a98b-f8d4-4304-ac55-d4151a1a77ab@intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index c9103a6fa06e..0b0e0283994f 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -124,7 +124,8 @@ bool emulate_vsyscall(unsigned long error_code,
 	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
 		return false;
 
-	if (!(error_code & X86_PF_INSTR)) {
+	/* Avoid emulation unless userspace was executing from vsyscall page: */
+	if (address != regs->ip) {
 		/* Failed vsyscall read */
 		if (vsyscall_mode == EMULATE)
 			return false;
@@ -136,13 +137,16 @@ bool emulate_vsyscall(unsigned long error_code,
 		return false;
 	}
 
+
+	/* X86_PF_INSTR is only set when NX is supported: */
+	if (cpu_feature_enabled(X86_FEATURE_NX))
+		WARN_ON_ONCE(!(error_code & X86_PF_INSTR));
+
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
 	 */
 
-	WARN_ON_ONCE(address != regs->ip);
-
 	if (vsyscall_mode == NONE) {
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall attempted with vsyscall=none");
-- 
2.47.2


