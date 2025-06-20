Return-Path: <linux-efi+bounces-3859-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39036AE1CDE
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC203BF724
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370FE2BD591;
	Fri, 20 Jun 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aP70DChs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940A29DB79;
	Fri, 20 Jun 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427635; cv=none; b=ZNdacZa9cjF+8kkbZBt6ONbjCBarcJcPxqGWIrG/JxFBOnJ/gzGz7DiQLb1srPgc2iupDalZGM3LJB3Fz0J339rYrqFOossMfDc/cWDMF29msmNh+tJ/cs1XEtKSimqFnPwRyJ7Vkye4ZPIiY+ikaXSe4bFKCWEXmXbumPaXsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427635; c=relaxed/simple;
	bh=y/CedaaKlFdbrxkql8ztvuaZ9CW/pvTqK0EU0vlRN80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHkGEFp9h5JKvqlDNP9pkrPDR2NogjDrJmElKXrUDtB78V8O7bIhwjuHek+7JNUJzyHwWJng2qOxph16MABnhsvQdXfq0AAC0auTFLAxQaHfFrtV29cnyXb5a8Odk9Z3rdzNeBYkv9JvSbHkWTqxIoQvBUqHQlrMz0720Uqz5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aP70DChs; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427633; x=1781963633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y/CedaaKlFdbrxkql8ztvuaZ9CW/pvTqK0EU0vlRN80=;
  b=aP70DChseWzeO3JOair9unG9XIH4WFwupv+a3qNwYJv0ieuL8sQb2RgV
   RLfmTxKf6GSH+VkIfaVDRnu6jJMLmkz3gH/k3l2npie4dZFl6nAre03ST
   snnkQ9djI/BMRwgDal9zXcqTnDnC/FJvMoKX1Tk6B0UO7lcazPuFBJPO/
   vbF2ryEESAirgdEUGmL2Zuo0I5Db2UUAhacdrwxWnv2rZyprGPqdkurnX
   onKO4j6++TfqTFc+lkEVksFFLRUGY000B0uOZe4ziAakbggIlmrKP+SPW
   fhKW9MFx1u49AO6ZPiKPiEmraM3kpIoE4tariJldmLV6fIfuQBG5tz3hb
   Q==;
X-CSE-ConnectionGUID: t1ruuPZLQtytOc0m6+DtyA==
X-CSE-MsgGUID: XiikWXU3T3WZXZXW7lSlKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51919436"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="51919436"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:52 -0700
X-CSE-ConnectionGUID: dVzB+ju+T0SgPREksYDMcg==
X-CSE-MsgGUID: EXKdu1V+RAiqUbBS+1zHgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="155292158"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 20 Jun 2025 06:53:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 181AC7DA; Fri, 20 Jun 2025 16:53:29 +0300 (EEST)
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
Subject: [PATCHv6 13/16] x86/traps: Handle LASS thrown #SS
Date: Fri, 20 Jun 2025 16:53:21 +0300
Message-ID: <20250620135325.3300848-14-kirill.shutemov@linux.intel.com>
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

LASS throws a #GP for any violations except for stack register accesses,
in which case it throws a #SS instead. Handle this similarly to how other
LASS violations are handled.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 0f558d3369a3..bd8f7e72b238 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
 		      SIGBUS, 0, NULL);
 }
 
-DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
-{
-	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
-		      0, NULL);
-}
-
 DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 {
 	char *str = "alignment check";
@@ -866,6 +860,34 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
+		enum kernel_gp_hint hint = GP_NO_HINT;
+		unsigned long gp_addr;
+
+		if (user_mode(regs)) {
+			gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, GPFSTR);
+			return;
+		}
+
+		hint = get_kernel_gp_address(regs, &gp_addr);
+		if (hint != GP_NO_HINT) {
+			printk(GPFSTR ", %s 0x%lx", kernel_gp_hint_help[hint],
+			       gp_addr);
+		}
+
+		if (hint != GP_NON_CANONICAL)
+			gp_addr = 0;
+
+		die_addr(GPFSTR, regs, error_code, gp_addr);
+		return;
+	}
+
+	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
+		0, NULL);
+}
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
-- 
2.47.2


