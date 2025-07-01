Return-Path: <linux-efi+bounces-4056-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABEFAEF412
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E8917A66E
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 09:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D8270548;
	Tue,  1 Jul 2025 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhJDZRRT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BA26FA59;
	Tue,  1 Jul 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363948; cv=none; b=a863aFmyy5bG+s6joJqfmJ4PewOf+OPHV3YHmROY8zzLxNRJ7hjqQZJzmRhV79IFGb5/FFBZt+Ypms9uNe8L+HlHp8cd3E5Fj/vA/4pqgQSDuZBVz27YILW93Cvhvn/venlg4paxpnkL7CT+g+wU7djY2gtoG5SxZgdB6QAXn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363948; c=relaxed/simple;
	bh=TQ5RCfOQ/5tuZqESL8hi2WCyzYpg/ALQ/w3Eenbo4Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUJuMGn7HEeBj8ecycG2FtSCBAtAdGCSbZsIaCHg5d2q3gAgozF+tMukD9ahYkgh+kjxG07hAGBSs/0tgbVa8zT1eFrcPIvW7F6/BWh2ECRLH4ld/15ndHG9X7xMDqYwKXuc0mVThaVYuY1hS98pN0DbWOwJ4Ug+dR9d1pF5SgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhJDZRRT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363947; x=1782899947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQ5RCfOQ/5tuZqESL8hi2WCyzYpg/ALQ/w3Eenbo4Ow=;
  b=WhJDZRRTqqAbzW/GY3lIx0eFqekyRkc7f/JOlzhxuEKS/pBWqqUY2MUM
   V0pwiJNxmgTd1bXYjVvzhJo2K3xLZAspm0TikqfEfUpFuuuk0WeT4eYfH
   P5qsGjN8svtRHitVcStkccIH/MZDg7aAA3CqKya6Aa2FT0PixbAWfJuj7
   q4Qcop9rbpsJvf2THrXALhC8FigX/5eNLtCGaz5Dir7E05Ju631gttaRY
   5k1VYUvq6ftM6rdPiZPm6wn58ZQ6gyeShJZL94hS3HGULfLdSw+2b6Hkl
   iD65z8WvuCDjxWb4+8XFoKqVUEKm5rLmMtrhICaLV3CHyiGG2c4VRHMSM
   A==;
X-CSE-ConnectionGUID: So6E2Nw/TnyAQQ+27VsnEA==
X-CSE-MsgGUID: HeZ5O2Q4StasPOcy0F+trA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71048649"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71048649"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:07 -0700
X-CSE-ConnectionGUID: ulSrwC4NR46aDPQOLhrZ5Q==
X-CSE-MsgGUID: kv43OEAgSp+0GwwuAzuZkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177390811"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 02:58:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 744944B1; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 06/17] x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall
Date: Tue,  1 Jul 2025 12:58:35 +0300
Message-ID: <20250701095849.2360685-7-kirill.shutemov@linux.intel.com>
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


