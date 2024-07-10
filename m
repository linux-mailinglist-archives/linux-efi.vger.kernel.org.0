Return-Path: <linux-efi+bounces-1392-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8B92D5CB
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 18:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC37285F7C
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46349195F1A;
	Wed, 10 Jul 2024 16:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+CGn5d4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB53195B18;
	Wed, 10 Jul 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627748; cv=none; b=DYtG9wp/mTePAVHpGg2rEiRujbge8oBHOADTfHGJpO/8ucsb1rGQ1UmWAQcvE53qGTmclS9X+WsOJq9rJJDkO3mqcbSG2wlZH2Hu2fWBkgV61tKaX3Kt2nt1+Q7TDstBJVJvqN8/TOCTDT2riuWkG1ytnrFjuvHPhlUpkCGlT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627748; c=relaxed/simple;
	bh=aWgpOz6JryUebtzYDLZUHvgchja1msIbJ5P07l3d2PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhv5WaiHbwrwM3MUg60yIg0IBhktz/wkMIAI79QHl6myVjwUNmVEIWW2ef4PegZ2fBjDui30tAxvDCnsErm+wCdQhIueqtFL/tPGYeMOC5OG+QBO+H4ognXiK3y38NUlD0mkX8QFQEw29RUu2jPiPtGLq6krB4zSbKjuzllTeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+CGn5d4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627747; x=1752163747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWgpOz6JryUebtzYDLZUHvgchja1msIbJ5P07l3d2PU=;
  b=Z+CGn5d4205Ro9FqdNhfZ4UMgkC2BH2APCqTZ37MeR+wAKZXLfomOb6L
   cUdHQcaUQEnxdF9Yq9va0/wsmtXEta//MuqmOIWSK3LUt+/x1/NAp/bkw
   IUuH1nnSXuQ0tGaVtu4HcJ9WIRLetY4iI0EYvRU5zARfX479CDxlO3zwM
   6MF8mBWNXOkP90OqUiEfGEWwkRHqvF5tONNtO4bq+Pjry3OjbI6L8tsZh
   h28vtGcowB0F9ADndcF6f/tirQ33BX5s1JAhtbmsQKWAFU9k8ysNXcHeA
   tzMXalDlv69MhoIN02TUmhYZsoJFLJf/uLFRgGQnsgmPX4u9EBmJmMCI+
   w==;
X-CSE-ConnectionGUID: tEQTcdv6Q6e7IpyjvbXkCw==
X-CSE-MsgGUID: vZzE0EuXQYyMeZpdZPldPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29364779"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29364779"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:09:02 -0700
X-CSE-ConnectionGUID: Xn1rC+BvS4qc51PNoF70fA==
X-CSE-MsgGUID: HauCIK9vQNm44v0ASF0M4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53084620"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:08:49 -0700
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
	Yian Chen <yian.chen@intel.com>,
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
Subject: [PATCH v4 03/16] x86/alternatives: Disable LASS when patching kernel alternatives
Date: Wed, 10 Jul 2024 19:06:39 +0300
Message-ID: <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sohil Mehta <sohil.mehta@intel.com>

For patching, the kernel initializes a temporary mm area in the lower
half of the address range. See commit 4fc19708b165 ("x86/alternatives:
Initialize temporary mm for patching").

Disable LASS enforcement during patching using the stac()/clac()
instructions to avoid triggering a #GP fault.

The objtool warns due to a call to a non-allowed function that exists
outside of the stac/clac guard, or references to any function with a
dynamic function pointer inside the guard. See the Objtool warnings
section #9 in the document tools/objtool/Documentation/objtool.txt.

Considering that patching is usually small, replace the memcpy and
memset functions in the text poking functions with their inline versions
respectively.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 89de61243272..c6e1b17d1da1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1825,16 +1825,24 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
+/*
+ * poking_init() initializes the text poking address from the lower half of the
+ * address space. Relax LASS enforcement when accessing the poking address.
+ */
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
-	memcpy(dst, src, len);
+	stac();
+	__inline_memcpy(dst, src, len);
+	clac();
 }
 
 static void text_poke_memset(void *dst, const void *src, size_t len)
 {
 	int c = *(const int *)src;
 
-	memset(dst, c, len);
+	stac();
+	__inline_memset(dst, c, len);
+	clac();
 }
 
 typedef void text_poke_f(void *dst, const void *src, size_t len);
-- 
2.43.0


