Return-Path: <linux-efi+bounces-4152-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D4AFAE0D
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695231AA1768
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA328CF6C;
	Mon,  7 Jul 2025 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbE/1mdw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3728A415;
	Mon,  7 Jul 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875418; cv=none; b=MtfnpZMgNO0OzNhHOFGYAMTwWSjezPF0Bl9Ovv5gXL0Lsy2JcPuOs8ZY9D0gBox12J/snq6tGEa2FesaSLtGF9BHqQTF7S5Im3j7K7uk7lV4ybfaEkYozN/gJHfIcnLh26s+bYhNtUZePfUrlTOqg7kuzwvtkfR5BoMoE29OO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875418; c=relaxed/simple;
	bh=TQ5RCfOQ/5tuZqESL8hi2WCyzYpg/ALQ/w3Eenbo4Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WppiLaacuUiQ7do+LAFDNFf/wvTWlkx8nw0O23kvKCFHf7J+o7/JjQbb6WR6XA7UhRe5rHumo6CAAoK8feCmLZ4ePSidPOIBHKGj7Mws1Kood0kT09aWGpJeieMRiI8u4gWZTeZ1JomGAVxINIng+v790y9Wim40dDSammUgziU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbE/1mdw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875417; x=1783411417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQ5RCfOQ/5tuZqESL8hi2WCyzYpg/ALQ/w3Eenbo4Ow=;
  b=ZbE/1mdwoGp2LLyeWuKyA2Q5b/ifBnCveThzVC1bR9bW5vbEw8+4Zuvj
   ShibzyOeC1hBo1wAeG2cyDUDQSoVJ3PdSA0b+x5hVQFhyXXaUMrXcoLIQ
   WiFGOtjX5vK+rugqBTobB04DrEVwUTIfCQdaG/4pqFly8FEkQiyWnl7jB
   UQwLYNud2ikhGrN3wQKv0hbyNfutjbyageTbohLN1zbKQSSVibckhvQI2
   7o3PHAzO7v+R1iTs3//e8D65rspJixzFkAgXTgd1eOUTIcBugsrwlzSif
   w9yYdBooFHQn3zr0zuQcVxU9rfN0WSCKmvhHeiSAhyrEYDWJO51iTuhLJ
   A==;
X-CSE-ConnectionGUID: xMuOhLJNSbKbwrNYt1wPcw==
X-CSE-MsgGUID: FwD1DF2VToqslLxoleexdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151840"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151840"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:35 -0700
X-CSE-ConnectionGUID: 8f9o8uP7SKO9SEAW6KuirQ==
X-CSE-MsgGUID: xrArNHKXTgiu/mLv9rI62g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154573882"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2025 01:03:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E39A7493; Mon, 07 Jul 2025 11:03:17 +0300 (EEST)
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
Subject: [PATCHv9 06/16] x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall
Date: Mon,  7 Jul 2025 11:03:06 +0300
Message-ID: <20250707080317.3791624-7-kirill.shutemov@linux.intel.com>
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


