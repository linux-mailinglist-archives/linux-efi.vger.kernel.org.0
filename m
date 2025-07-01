Return-Path: <linux-efi+bounces-4063-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343AAEF42F
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266AB7AC3F8
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C97273D60;
	Tue,  1 Jul 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpANrVFW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF80272E7E;
	Tue,  1 Jul 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363954; cv=none; b=kCjxh9vWy1ufRonnpcuzpabt1FJkpRQ9ICvl8DHVpx0al982EvtV3HHSfKiSlrxWkR2C5Ymp/HEhNDPomXrUtsR2Ejl83TZqH36VGYjXHMiLip+Y9j71II8vILXDi3iGOAD7GLbLbV4OURJ2MWzYH9nT6d9PTK/GLnaf+oB0H5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363954; c=relaxed/simple;
	bh=PwAnS8GCFl9R0ZnXkmWVweujaDST7jWhau/vhrZXQZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYcY2IzKbFrASIxCDjkRKTJPOAhoQ33LnrguLRO0qaqcC88ZD5wAYG176YsTvKVZ/5kXBJ0lVWuW3u4HLp6vz/AF2OUHjpKhni0WKrgPPV/ZOPTkE33hbr4g8Nx1xw4j55UVdun/eARIc3luBmDjLvTTPg3nP/qeRRU9GYERJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpANrVFW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363953; x=1782899953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PwAnS8GCFl9R0ZnXkmWVweujaDST7jWhau/vhrZXQZY=;
  b=PpANrVFWnFQzS82pSI2u6KBOWervEQGW+XRgHh+uCVfiH+zXzgiTZ3lQ
   NM/WrGDaRSGov5R20VVecFm5uRpmBC61OtPGB9wezMH7QoUf7RvuvCvRr
   G24EDe0Uu/TF5ycb3kcQLBvXlQCc6Ezl7ie4TWoWgMFLZtVAJqE/jfF+U
   8aWlOJPbRhnTi0iVRVxrjSKEVDpkhglIjhIXhbOMzmFyKcEmmxAz73hZc
   IxNCfxevjmoU7bi7j1aIRIb4E+DgHgKsOTv4QSJntfdkah8C7lcqnW/Ry
   PiNe/FvaK9FKcWbYLOnctjNDr+6AV5KTv01jrscmuxq9X0cPSsy2QqgP4
   Q==;
X-CSE-ConnectionGUID: ujCE2VTPQLeHs0IuVgZV/A==
X-CSE-MsgGUID: rk6M+QOSSXewlvCnZougyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57428114"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57428114"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:12 -0700
X-CSE-ConnectionGUID: FEfNDtZ7Sau6zPbETLZ06Q==
X-CSE-MsgGUID: wH3R9HGFQ0yeIauuf+vyYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190896431"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 02:59:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C5534862; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 12/17] x86/traps: Communicate a LASS violation in #GP message
Date: Tue,  1 Jul 2025 12:58:41 +0300
Message-ID: <20250701095849.2360685-13-kirill.shutemov@linux.intel.com>
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
index 40e34bb66d7c..5206eb0ab01a 100644
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


