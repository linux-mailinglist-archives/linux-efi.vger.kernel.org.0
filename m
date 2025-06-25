Return-Path: <linux-efi+bounces-3986-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A376AE8358
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C7C167B23
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892AF26B75A;
	Wed, 25 Jun 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGf3flOo"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAB2690D9;
	Wed, 25 Jun 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855897; cv=none; b=FlK8S5EPf7X7iEH8MO3Mzya7wyez21mZxpGIQyMR4HSs0llANdxix7fT1VJYZVDuC1fJriRTAEAZmiq0ljhvjwL+xNBlv5ZkyIb/bUEVjp8j8sgK/7GNAKZUOi6DPQXxWSTK6VfV/MlCRbE/8WnMWm0KiyFUlHzZuJsaQA+yDwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855897; c=relaxed/simple;
	bh=JBGJGaeeS2Xh+9NuK95zkFteMkIrn0EoxQT+TmlJxJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cONbAwR20mwaYe440PvVGBVg4/enyGIm4HohIYTdDW3ybquT4ZH02WfV65+ODrW+v/d1ZwPkUlJfqkmYgG0cQA4YKP50eIVpBThoHyl4QQZXYKi/3mthRgwk3djR+vW4L/K4InWNTv5BhTDwiktSUf5+xrCID5zPPOqfItt9c8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGf3flOo; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855895; x=1782391895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JBGJGaeeS2Xh+9NuK95zkFteMkIrn0EoxQT+TmlJxJw=;
  b=OGf3flOotByhWvHsaA8W7eaCA+31beF3DtQOXdxZKJqOTSj+qSHYX6rD
   PWTCY5IMRcIo+INV8wzrw32Gf+xxMIEzQroysKAT6LjoCmLvgIi9D/LSb
   IKpUw/u48pTApceYKj/p13ECL6eUrCRwqS1jQXWZ+3UKB5IVaFhw3oQN4
   wdVbX365cV9sWb/eFnikkvbZ2tRUVG5mBSxHoLPpObBbOZX8fXysiieHF
   /c0WAb1mDDjZ54t9WG8jeGmVmlMXuBlM+W2STY9IGx4Aqrd4Uh7SV5ots
   VihYJMtfCCWfZ/WiKaOGeuBBgsskoSKLxShnzbsJ+R1tHVM1cb/vIY9zX
   A==;
X-CSE-ConnectionGUID: oXDHpOEjTjqzuPqI1fHiNA==
X-CSE-MsgGUID: /KDpINrSTseSrU8KIHmcmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53189653"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53189653"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:34 -0700
X-CSE-ConnectionGUID: L1tUn7Q9TjGwT50+hm6f4g==
X-CSE-MsgGUID: 3EBtIhOgQVmo93lCwbOuXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151830982"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 05:51:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 26D4F79C; Wed, 25 Jun 2025 15:51:13 +0300 (EEST)
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
Subject: [PATCHv7 13/16] x86/traps: Handle LASS thrown #SS
Date: Wed, 25 Jun 2025 15:51:06 +0300
Message-ID: <20250625125112.3943745-15-kirill.shutemov@linux.intel.com>
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

LASS throws a #GP for any violations except for stack register accesses,
in which case it throws a #SS instead. Handle this similarly to how other
LASS violations are handled.

In case of FRED, before handling #SS as LASS violation, kernel has to
check if there's a fixup for the exception. It can address #SS due to
invalid user context on ERETU[1]. See 5105e7687ad3 ("x86/fred: Fixup
fault on ERETU by jumping to fred_entrypoint_user") for more details.

Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index e2ad760b17ea..f1f92e1ba524 100644
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
@@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 	cond_local_irq_disable(regs);
 }
 
+#define SSFSTR "stack segment fault"
+
+DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
+{
+	if (user_mode(regs))
+		goto error_trap;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
+	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
+		return;
+
+	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
+		enum kernel_gp_hint hint;
+		unsigned long gp_addr;
+
+		hint = get_kernel_gp_address(regs, &gp_addr);
+		if (hint != GP_NO_HINT) {
+			printk(SSFSTR ", %s 0x%lx", kernel_gp_hint_help[hint],
+			       gp_addr);
+		}
+
+		if (hint != GP_NON_CANONICAL)
+			gp_addr = 0;
+
+		die_addr(SSFSTR, regs, error_code, gp_addr);
+		return;
+	}
+
+error_trap:
+	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
+		0, NULL);
+}
+
 static bool do_int3(struct pt_regs *regs)
 {
 	int res;
-- 
2.47.2


