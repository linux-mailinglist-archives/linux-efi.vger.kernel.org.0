Return-Path: <linux-efi+bounces-4150-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57198AFAE05
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44131889E13
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C1128B7CC;
	Mon,  7 Jul 2025 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5T5nC/8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7E2797AB;
	Mon,  7 Jul 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875415; cv=none; b=GBQA3fOZImvJJAyDRMMoqx+CLguh/tZeqHoAP1GGz2O0Gut0x1MN0BvhPdUYjXV/PRot4Y2+YvvBak2R36uJayHnX3gEz2WOMrN6UzxsBAUZDOdFuSYqBDtrKE/NW2xjRQbO5QxcsbOV/pFKQ2Gba3ALYGN3DQ4Mdj5ASISGLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875415; c=relaxed/simple;
	bh=nBTcvBCFvfLYdQ6wA9b5vvQrMmyAcbLEQoeRNyDewSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs3oCC00kqbj4rvAD5gBEc43bDx/nsSM5OBszn6RQXgHvW7ZRPqbHqEB1/Q+F/2qmywlKTv4tAsuOtsq59kXIrW433EtCAS0RCXcI9Ye8qpVkbYGNw+OMDt1PpJEZypELjGnxgH4GQE5x0NiOPUR8kHYkJcGLghb+T/4F8zuW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5T5nC/8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875414; x=1783411414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nBTcvBCFvfLYdQ6wA9b5vvQrMmyAcbLEQoeRNyDewSs=;
  b=k5T5nC/8/l6Cqk3ER9LgzZGQTTMXuUtThaiAssOUqTKr4DV3I9WS6TXH
   1Jt910A3UWomdNVwisCsKivjG6m3aSViOcDg6c8Xfp6RtmLZEkNwlOyqk
   ySKXwb25lvXtfu3sKmMb8ipf9gHlD/hQFr+hV2xHi30JSvoPF7MpDFMHj
   NNHrwbjfUO/T8ZB6qFFvgCCVhRN+jBFghDdId81F6/fiLrBPMa56EfSP0
   9XEsiHbp/q+VKvIRXWFP1amnRabxGKPsLdZtZd6FQm8a99cZD2TK3UnBJ
   8RpkpSwHitbUhXKzaYdlBEpiwOIGKzMt1tCOTGSf/XjfdqOzqMMgR/fP0
   Q==;
X-CSE-ConnectionGUID: sUALiPbJSWOjrJ+1oL3oHQ==
X-CSE-MsgGUID: E9cznNqIRLS66kEk2DJHkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="53807232"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="53807232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:32 -0700
X-CSE-ConnectionGUID: rQ8sF5jRQ0Ooa7q2UfsTuw==
X-CSE-MsgGUID: wfmB6psJQri+O/QKt2floA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="160804328"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 07 Jul 2025 01:03:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C3C91386; Mon, 07 Jul 2025 11:03:17 +0300 (EEST)
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
Subject: [PATCHv9 04/16] x86/cpu: Defer CR pinning setup until core initcall
Date: Mon,  7 Jul 2025 11:03:04 +0300
Message-ID: <20250707080317.3791624-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

In order to map the EFI runtime services, set_virtual_address_map()
needs to be called, which resides in the lower half of the address
space. This means that LASS needs to be temporarily disabled around
this call. This can only be done before the CR pinning is set up.

Instead of moving setup_cr_pinning() below efi_enter_virtual_mode() in
arch_cpu_finalize_init(), defer it until core initcall.

Wrapping efi_enter_virtual_mode() into lass_stac()/clac() is not enough
because AC flag gates data accesses, but not instruction fetch. Clearing
the CR4 bit is required.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ec62e2f9ea16..f10f9f618805 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -490,11 +490,14 @@ void cr4_init(void)
  * parsed), record any of the sensitive CR bits that are set, and
  * enable CR pinning.
  */
-static void __init setup_cr_pinning(void)
+static int __init setup_cr_pinning(void)
 {
 	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & cr4_pinned_mask;
 	static_key_enable(&cr_pinning.key);
+
+	return 0;
 }
+core_initcall(setup_cr_pinning);
 
 static __init int x86_nofsgsbase_setup(char *arg)
 {
@@ -2082,7 +2085,6 @@ static __init void identify_boot_cpu(void)
 	enable_sep_cpu();
 #endif
 	cpu_detect_tlb(&boot_cpu_data);
-	setup_cr_pinning();
 
 	tsx_init();
 	tdx_init();
-- 
2.47.2


