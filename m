Return-Path: <linux-efi+bounces-3854-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B29AE1CD4
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CDD1C2213D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E39029B218;
	Fri, 20 Jun 2025 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ6+G6Vg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67A291861;
	Fri, 20 Jun 2025 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427631; cv=none; b=UKLYsz0Q3SXqeL9s5z6+GBHp7F4L6FHtncckeAJAd5FKdIyB/sjs5DGCLFl6PVfL9H6AarLHzM6YenFz8noozU59vo6MPin+km/PJCP47wyLI+KXJR7ycrcu+nkrojhDyOhzX0w4p1jL+oZBcPu4E/Gq9/5kcAvCYxSt0tyAnqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427631; c=relaxed/simple;
	bh=HbPmwi8AshufdSIx8XTVcQlvNsvbbzDCxbhzFZVS0Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7avFc0hoyibA5lzaTRVEMFW/FilPyeteIgWCAjGaONSGAp9Nj5fESQKaza3do95MCgtL1Rq+o1NBym1hjl8S1Gi7sqsWcdoEvfhMViNtttQHpkK93FX+RnvDwcxrHBzxF6UTVSz3ZGSj6R3o9mQD9NnosWVAHVjCGKkWxYBdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ6+G6Vg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427630; x=1781963630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HbPmwi8AshufdSIx8XTVcQlvNsvbbzDCxbhzFZVS0Ew=;
  b=RJ6+G6VgXzkWAwpOGPAZNzitzMxP/DO8/tXAwpYJwCKSfjbRFqbt7+1M
   ivrZbNk0w36dmy5yA7fIpqZseH4orbu/+OfZuDvzoQFBH5QBuFiG32zCb
   UfezpqzDdrSCpdmiwbYIz5ZqN7PsyH615yBHC1hLWgCawWm2ZTC7eBPPV
   5JPpe98Dy6hS4aMOwt0lw41u5nJ1WM3imzoTbOiwDGArdxwBV27dCsREM
   qwFpzGcnBSb1NSgMtYLPJNO2tYWmlDI3sfQSRBm/f0xFqKp6cEJNuW2K2
   8Ov3qtamt6bGi9XDWkZAnOPd+5WLD37E8usSlOxKCxkzsDawfnXThdKGB
   g==;
X-CSE-ConnectionGUID: ZRekWSnGQ7uzhcNxUMA4xw==
X-CSE-MsgGUID: VttFcapAThiWOp23Ec+0Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51919340"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="51919340"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:48 -0700
X-CSE-ConnectionGUID: lmSPR2CqQAG/m/9rn5rcXQ==
X-CSE-MsgGUID: +uQSGnp/TxW1FZ48fNmRlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="155292142"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 20 Jun 2025 06:53:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C1DF141C; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
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
	Dave Hansen <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 08/16] x86/traps: Consolidate user fixups in exc_general_protection()
Date: Fri, 20 Jun 2025 16:53:16 +0300
Message-ID: <20250620135325.3300848-9-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
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
---
 arch/x86/kernel/traps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c5c897a86418..3eb2ef46f733 100644
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
 
+		if (cpu_feature_enabled(X86_FEATURE_UMIP) && fixup_umip_exception(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.47.2


