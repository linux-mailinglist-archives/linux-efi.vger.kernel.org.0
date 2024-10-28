Return-Path: <linux-efi+bounces-2036-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC99B3613
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2D91C23B74
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F51D79A6;
	Mon, 28 Oct 2024 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/1prSLy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A061DED6B;
	Mon, 28 Oct 2024 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131933; cv=none; b=mMP5zJT3PPDJHJhlmbqeXNLm6CukP/ej2CbgO0NPmh8b14bGgfGb5oQ1QVsUpy3VWwhOaRukR9+55MSqbGn2JaOBN/YWDW1D4X2blGJa/7nqv8cmS5E2YdJIvP6YOPpmxz6Jiz/rd/dUO6+xt9Q9VS9S7R1poGDPtgBxjlI9o+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131933; c=relaxed/simple;
	bh=93VnYKIFxvP/5UMU/Ce687kY9FqRNs9gkUoibkzkDyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NejWv2s7KXcSpXtdQ9kLFrnsS1OqRdIUzJU0YmJT9oiP7smTPZl6EhRxdfnwq/VCymIBNd/YMPhsO3KZF2rRtBpwfCn3i5NiAUdz4+n5cZBWiPIsYpYfX8YxcRuHV998I370AtxVZ/hu4PxxCB/4ENFjzHvIEIn1YGGAlmVa46Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/1prSLy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131931; x=1761667931;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93VnYKIFxvP/5UMU/Ce687kY9FqRNs9gkUoibkzkDyU=;
  b=U/1prSLyI9C/zuZfTJzcyWyffnwyuxMZPLgKn4jtqEGc8W651x0KYc5m
   eGuSRDPGsRK9b5mIVlMqon1LZDlv1rk9EiBMGV+0kzkim8/HRi04tbTzE
   /n02mDPLBxrwM7q28hE3PgINpNiKsixKgew6tl+HEAMhdV4jbV4Gp0M6d
   Fba/WHmvqEOVZ5VeI4hYrXFfCmRomX7PqFusPY5/p4eWntSz2rWVavipb
   4eDwmtJEm3w5i1hkgSXd+oVBh1G9Wn6eI2OYGJ+SSj8Pu1Hftitcaw+qm
   vgGSJJmGs2E1JKI2OpKsajfveBlBN6wcCtL5XjOJ26fwTF0ovgrpmgoaY
   w==;
X-CSE-ConnectionGUID: fwQqsWwJSNeBTSJwJMSPIQ==
X-CSE-MsgGUID: Wy2v1xv9RMCPCUW172GsMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32594259"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32594259"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:12:11 -0700
X-CSE-ConnectionGUID: KTVTLQ8eSnS72cz6fo1PsA==
X-CSE-MsgGUID: AEy7ZPIVTkGNCkEvhm3plQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478747"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:11:59 -0700
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
Subject: [PATCH v5 13/16] x86/traps: Communicate a LASS violation in #GP message
Date: Mon, 28 Oct 2024 18:08:01 +0200
Message-ID: <20241028160917.1380714-14-alexander.shishkin@linux.intel.com>
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

Provide a more helpful message on #GP when a kernel side LASS violation
is detected.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/traps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bae635cc6971..89e35ab8dbd9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -537,7 +537,8 @@ DEFINE_IDTENTRY(exc_bounds)
 enum kernel_gp_hint {
 	GP_NO_HINT,
 	GP_NON_CANONICAL,
-	GP_CANONICAL
+	GP_CANONICAL,
+	GP_LASS_VIOLATION
 };
 
 /*
@@ -573,6 +574,8 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 	if (*addr < ~__VIRTUAL_MASK &&
 	    *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK)
 		return GP_NON_CANONICAL;
+	else if (*addr < ~__VIRTUAL_MASK && cpu_feature_enabled(X86_FEATURE_LASS))
+		return GP_LASS_VIOLATION;
 #endif
 
 	return GP_CANONICAL;
@@ -696,6 +699,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
 	enum kernel_gp_hint hint = GP_NO_HINT;
 	unsigned long gp_addr;
+	static char *help[] = {
+		[GP_NON_CANONICAL]	= "probably for non-canonical address",
+		[GP_CANONICAL]		= "maybe for address",
+		[GP_LASS_VIOLATION]	= "LASS prevented access to address"
+	};
 
 	if (user_mode(regs) && try_fixup_enqcmd_gp())
 		return;
@@ -735,9 +743,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		hint = get_kernel_gp_address(regs, &gp_addr);
 
 	if (hint != GP_NO_HINT)
-		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx",
-			 (hint == GP_NON_CANONICAL) ? "probably for non-canonical address"
-						    : "maybe for address",
+		snprintf(desc, sizeof(desc), GPFSTR ", %s 0x%lx", help[hint],
 			 gp_addr);
 
 	/*
-- 
2.45.2


