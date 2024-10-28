Return-Path: <linux-efi+bounces-2030-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E34F9B35FE
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81182B234E2
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBF31DE8B4;
	Mon, 28 Oct 2024 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1rgeEDw"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8461DE896;
	Mon, 28 Oct 2024 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131870; cv=none; b=HDD2IFSDan9VRotqZmSMc641hTMB94H1FGC0Sf/NBZWs2sGncTWNtgpn7wGU25IgHa1W579WdJvHA4AxQn6ytwNwKgNB2FAmoJYBCiFuB+kXnE3eLfFlUHLY9UvimQuZn0lpY0SQXoSHHVDg34vLqHA0kTLuZ/3X/cEXyqJfX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131870; c=relaxed/simple;
	bh=vMZ2PXwv3yr3F7Qopdh6FeZmIokinGHzoFAAJ/FYb+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2K6OSCe3cFqXElYDi3waDFJ4iPoz6VHt9wUq4z2CnRWd/0Y92j3U99xj5+9U1K3h3Mi8G/IBBULzgK/EHBQgq96qTvNcqnJ6Vvs/JNYq4PCbnEpcrEHvu9TCkWlQE2GskdppOZB3VVBnc5Vqxl6k5wchN0N958CrsT+J7o8794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1rgeEDw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131869; x=1761667869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vMZ2PXwv3yr3F7Qopdh6FeZmIokinGHzoFAAJ/FYb+Y=;
  b=C1rgeEDwoG5U1PmE5UZnk385lLi447xpgOwJ+sw4rrPovJO21O/G4+P5
   1JbGLbj6nCWMOeURe1k/9OQR9HPaQcjiiTXv1OTxThFhzThD9C9Mh25aL
   R210QQAQw/egXCeUcq7llxsBGR2JhA2JXHFVLxAdH+hXgYr/j00ijt0b6
   QTLaRCG8p9k48KIP5kWLV340FGYHan1MlV20OMNbP5RtTXLuI5VixkR6Y
   WpsQa2OQhuNevHpjgUojqXzfPz5yHERRSa9aCMSYHM0Pnu6Nc07ds0c5m
   rOXdFuLWkPGSOR7sYOv0hk1oomd7qMqi4Kz7KJE1Fn880axil5zMQvpJA
   Q==;
X-CSE-ConnectionGUID: 74Zb6SMvTJm2Ur5fVZTLSw==
X-CSE-MsgGUID: aQLsLMtlTdKoudGTB00zLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32593967"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32593967"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:11:01 -0700
X-CSE-ConnectionGUID: qvBwCQAeQoC4UPA5PEmPfQ==
X-CSE-MsgGUID: OCNmduO6SLabtfp+/O+97Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478154"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:10:49 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
	linux-efi@vger.kernel.org
Subject: [PATCH v5 07/16] x86/vsyscall: Reorganize the #PF emulation code
Date: Mon, 28 Oct 2024 18:07:55 +0200
Message-ID: <20241028160917.1380714-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
References: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

Separate out the actual vsyscall emulation from the page fault specific
handling in preparation for the upcoming #GP fault emulation.

No functional change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 42 +++++++++++++++------------
 arch/x86/include/asm/vsyscall.h       |  8 ++---
 arch/x86/mm/fault.c                   |  2 +-
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 2fb7d53cf333..e89d7d83a594 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -112,30 +112,13 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	}
 }
 
-bool emulate_vsyscall(unsigned long error_code,
-		      struct pt_regs *regs, unsigned long address)
+static bool __emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 {
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
 	long ret;
 	unsigned long orig_dx;
 
-	/* Write faults or kernel-privilege faults never get fixed up. */
-	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
-		return false;
-
-	if (!(error_code & X86_PF_INSTR)) {
-		/* Failed vsyscall read */
-		if (vsyscall_mode == EMULATE)
-			return false;
-
-		/*
-		 * User code tried and failed to read the vsyscall page.
-		 */
-		warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
-		return false;
-	}
-
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
@@ -270,6 +253,29 @@ bool emulate_vsyscall(unsigned long error_code,
 	return true;
 }
 
+bool emulate_vsyscall_pf(unsigned long error_code, struct pt_regs *regs,
+			 unsigned long address)
+{
+	/* Write faults or kernel-privilege faults never get fixed up. */
+	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
+		return false;
+
+	if (!(error_code & X86_PF_INSTR)) {
+		/* Failed vsyscall read */
+		if (vsyscall_mode == EMULATE)
+			return false;
+
+		/*
+		 * User code tried and failed to read the vsyscall page.
+		 */
+		warn_bad_vsyscall(KERN_INFO, regs,
+				  "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
+		return false;
+	}
+
+	return __emulate_vsyscall(regs, address);
+}
+
 /*
  * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
  * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index 472f0263dbc6..214977f4fa11 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -14,12 +14,12 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  * Called on instruction fetch fault in vsyscall page.
  * Returns true if handled.
  */
-extern bool emulate_vsyscall(unsigned long error_code,
-			     struct pt_regs *regs, unsigned long address);
+extern bool emulate_vsyscall_pf(unsigned long error_code,
+				struct pt_regs *regs, unsigned long address);
 #else
 static inline void map_vsyscall(void) {}
-static inline bool emulate_vsyscall(unsigned long error_code,
-				    struct pt_regs *regs, unsigned long address)
+static inline bool emulate_vsyscall_pf(unsigned long error_code,
+				       struct pt_regs *regs, unsigned long address)
 {
 	return false;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..44e2d1ef4128 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1318,7 +1318,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 * to consider the PF_PK bit.
 	 */
 	if (is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(error_code, regs, address))
+		if (emulate_vsyscall_pf(error_code, regs, address))
 			return;
 	}
 #endif
-- 
2.45.2


