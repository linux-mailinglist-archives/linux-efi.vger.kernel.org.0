Return-Path: <linux-efi+bounces-2031-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CC59B3601
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751011C22BE1
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127F1DEFDC;
	Mon, 28 Oct 2024 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZBE37yV3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369E1DED79;
	Mon, 28 Oct 2024 16:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131873; cv=none; b=AciDn1kNTCx8FPtiRd1rI/fzxlzdIu/5a9fRTCKphEm/mlkabh4NxiseHQAdvJVBsc7v2UW2vBBud25H5sITOb4uxucYf14RlIMXsotluprUd6EBX2oxeu8stZU13gOeQgom6NnQt0WFWM/Af6Oh1eFFgBVtVGpRZ8sWhuXiMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131873; c=relaxed/simple;
	bh=/e9CEUnpJeeIZTRwKdpP8Oe+65UK9FKHB4gY3LCDsGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnJUIE4RvEPhm46IxmlFZmFgBl7dssPAyHaqk/z/AcLj2EXKzHIcjH7IblsKdQ7j07K3DWmb+G7R8yTco6J56w2u6tGD52b0NV76/EMNEqoxa7Io0Ck0npDwY8ix6JABqZQrmISxgF2xPd21M7AsC2+lQM26eF494pnnucnV3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZBE37yV3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131872; x=1761667872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/e9CEUnpJeeIZTRwKdpP8Oe+65UK9FKHB4gY3LCDsGY=;
  b=ZBE37yV3+AVJuo5BCHOe+KlAsNUkXLqIdyJDjYQ/WqqLEm4bG+z3hR4i
   BijGs6i4vIcv2aHHfx1LZm7KT6u/gKwcoh6ym+GRNT4jx6tyhpOLicimh
   m2kATtyG/LIOkYLerEci8i2Bz80kmA2s4UiF7K37/7qOgw+RL5S3JmiIh
   XjlG0YLNqjSKp4FcKV+FfBm5YTv6hetiVjQGZXnfk6tysh/LM2Q5io+m4
   wKq3ZuFoU57KZSpzyQQHEBKKDnmy630Ie1uxOEoJ+eudUbdfbXZ66Asli
   qUIVay0WY4W9dO3iOJ3bY+7ORPLyBu8CaakQ6xhAUiejBq1SdvGFguRpz
   Q==;
X-CSE-ConnectionGUID: X+RkWZMDSIirCBJ3iROTBA==
X-CSE-MsgGUID: oIwtpLb5RaCZB0048p5Njg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32594005"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32594005"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:11:11 -0700
X-CSE-ConnectionGUID: FiJ+Ex3eQta2n1/ohVCARw==
X-CSE-MsgGUID: RZAkx7/JSuuBXDDAQ+E7aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478270"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:11:00 -0700
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
	linux-efi@vger.kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v5 08/16] x86/traps: Consolidate user fixups in exc_general_protection()
Date: Mon, 28 Oct 2024 18:07:56 +0200
Message-ID: <20241028160917.1380714-9-alexander.shishkin@linux.intel.com>
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

Move the UMIP exception fixup along with the other user mode fixups,
that is, under the common "if (user_mode(regs))" condition where the
rest of the fixups reside.

No functional change intended.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/traps.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index d05392db5d0f..b26a7aba0b2d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -701,11 +701,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 
 	cond_local_irq_enable(regs);
 
-	if (static_cpu_has(X86_FEATURE_UMIP)) {
-		if (user_mode(regs) && fixup_umip_exception(regs))
-			goto exit;
-	}
-
 	if (v8086_mode(regs)) {
 		local_irq_enable();
 		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
@@ -720,6 +715,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
 		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
 			goto exit;
 
+		if (cpu_feature_enabled(X86_FEATURE_UMIP) && fixup_umip_exception(regs))
+			goto exit;
+
 		gp_user_force_sig_segv(regs, X86_TRAP_GP, error_code, desc);
 		goto exit;
 	}
-- 
2.45.2


