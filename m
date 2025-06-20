Return-Path: <linux-efi+bounces-3857-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4705AE1CDF
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA9C1C2186D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06FE2BD030;
	Fri, 20 Jun 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OxSYJdL2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9929C355;
	Fri, 20 Jun 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427634; cv=none; b=by43QezNyehFcuWbUW1paQhgzoQJcFT1AXkUS9nY/MofTQlXSGEYWGB47uEaBnUgqRxdLTQLWguk6PbKwX+daQ//ivzSdiYPJ9ahPdfgV35jWz8WBRQn9NDY1LZL+Ns7oDYipJWduADqmpYS/KOZd0vchTnS2dhk/ZrAo3bqRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427634; c=relaxed/simple;
	bh=I7i22QprD2S6ZvpY/RhEAEk5UwJ5gH0iWa60cJAUZjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFgnL9lL22IqBakiorD1JqoqYkQLE1ydt+cCDEHbUZz+kLO2LfFPaZ7cuRle1FcYv+y1qPZWBBFLl3tEcFCU5gGURNVHUZArZ8hEicKcwAjZWGJ6tgwzfmLmEMXIckPO2iq8VOBgpZP+HMXIcXVswvE3evwpi3y6P3J9N/P4i+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OxSYJdL2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427633; x=1781963633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I7i22QprD2S6ZvpY/RhEAEk5UwJ5gH0iWa60cJAUZjY=;
  b=OxSYJdL2jQh2+2NIPlris3TcpbzB0u7/UB7CCrsarHJZC2f0Tnek1TgV
   bXH3fCo55q3/bhAxhOJ5bMW8uFXPqW8H409Ixhc7vnJ5eGor5VhrdcaY5
   FW3knX5oL2tCgg4MTfL/TJlUpEGC/AQVLxSW/V79kEJJBn3nR4t4l4O+G
   mGLwoFQ0jkAeJHltcIbxNnexKHucVKdIaHwl7u9fpOtjaLLS6kA6t8RFu
   5KUshTU9b8k0WhwdYOgYw9yWpfIUC20HXuhOvHUBvLskQWnh3KHPOXwIv
   rZHpJHA+qtoeCA3BLNjrByvx9F1dEDMDwqVISMvnaO156IqwKhCUI+uKC
   w==;
X-CSE-ConnectionGUID: Q/QHHfLzTUqPuSZTJohP8w==
X-CSE-MsgGUID: 4xH/UVI8TBS/kLGiowFEgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51919407"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="51919407"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:52 -0700
X-CSE-ConnectionGUID: IAg8+FfHRNy5reypztF2eg==
X-CSE-MsgGUID: zpMboRTARBqsEL98AB0TsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="155292156"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 20 Jun 2025 06:53:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 09CC974E; Fri, 20 Jun 2025 16:53:29 +0300 (EEST)
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
Subject: [PATCHv6 12/16] x86/traps: Communicate a LASS violation in #GP message
Date: Fri, 20 Jun 2025 16:53:20 +0300
Message-ID: <20250620135325.3300848-13-kirill.shutemov@linux.intel.com>
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
index 333c45df80fc..0f558d3369a3 100644
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


