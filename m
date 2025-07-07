Return-Path: <linux-efi+bounces-4149-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E90AFAE01
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0585179474
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3AB28AB1A;
	Mon,  7 Jul 2025 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R/gCxRjL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9F194098;
	Mon,  7 Jul 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875415; cv=none; b=LflI8pXxjZDlk6fQaO9XB2pS1ag1nDkFSqiBgAgVwtIloDmh7VWPn+gh+lcE42kM+39MWENoy2bKGtt+FjtHU/Xngo3ZUZ1TCj7TxYSZNCQZ7OPDSSFL7OKeYXMIrwJC4EiXPnBeFX3YLxMHdEisBiGYnsZa5LLmBcLOvjO0WgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875415; c=relaxed/simple;
	bh=J5WwLctxhVnscj924ezQg1UGG/n1vvqksbWY0HLqHYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFzTraUgdpyexphE8wUZiXEIUN4FKq3DODUp3xLP3UF4OoPJ4jtcO5PNxhJm5RvAvQMbbuqNspuUOi2kaidey+Rg9GcVhJclxogC0d3XocbITjjCTW7MAOrF3w0qsD1SydM3DjMc8xywwyzXRFNWEQEkVcR9D+s24Yo7fbWv+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R/gCxRjL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875414; x=1783411414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J5WwLctxhVnscj924ezQg1UGG/n1vvqksbWY0HLqHYc=;
  b=R/gCxRjLKhacgTbRLQXax9LX/w+rMqikYvJPDwoUvXvb2kpC2rj1IOSn
   hv/Scrgj/1FTuHdIsdPl/UI+Vayv/GbMpBgM3I2RVY26Ct7rCAPT3WE4S
   89GFRjkneZeX3wi1CU5LzAJkaMO27ggJF9Jbhkm62o5IDT0n8TOGxObpn
   evXb5h2onLjazNeDooxrNl9lJK5upCLoZ4FxA90qQ8yFtFddbwE0L/doR
   fVAHcME3c0OpV14mwbYRVcRa3tRo9TcZSGKU59mnNWAOlh/ioBdGmzjR2
   2SUO/xu9aE2yFdFaxptCv2fBitkwKyizMTnqRLP57uPixfzs/GONIrLrV
   Q==;
X-CSE-ConnectionGUID: XqtkD405ScCjYDRUeAPc+w==
X-CSE-MsgGUID: O7Vc/f9uSVSVDyWsTVCecg==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65151816"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65151816"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:03:32 -0700
X-CSE-ConnectionGUID: Fl3qj04tTyayfhZ22ecZJA==
X-CSE-MsgGUID: S+5BXXZmQzm/AV838UcAjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154573873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 07 Jul 2025 01:03:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B188E2E7; Mon, 07 Jul 2025 11:03:17 +0300 (EEST)
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
Subject: [PATCHv9 03/16] x86/cpu: Set LASS CR4 bit as pinning sensitive
Date: Mon,  7 Jul 2025 11:03:03 +0300
Message-ID: <20250707080317.3791624-4-kirill.shutemov@linux.intel.com>
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

From: Yian Chen <yian.chen@intel.com>

Security features such as LASS are not expected to be disabled once
initialized. Add LASS to the CR4 pinned mask.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 325f892ee42d..ec62e2f9ea16 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -403,7 +403,8 @@ static __always_inline void setup_umip(struct cpuinfo_x86 *c)
 
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask = X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP |
-					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
+					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED |
+					     X86_CR4_LASS;
 static DEFINE_STATIC_KEY_FALSE_RO(cr_pinning);
 static unsigned long cr4_pinned_bits __ro_after_init;
 
-- 
2.47.2


