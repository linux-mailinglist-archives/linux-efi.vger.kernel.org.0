Return-Path: <linux-efi+bounces-3853-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6971AE1CCF
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27879188AD1C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DC29ACC2;
	Fri, 20 Jun 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOFxkk6f"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336D628EA5A;
	Fri, 20 Jun 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427630; cv=none; b=IV7jzYhHqqnU4M8NF08dUegCSD3TpbJFfgv9rDL4+JJkojGefhzUBGPmmJ3DGmCLXrt3CRmzTcC9wIyCKvHDHEDH7ZcrK/aCWmj8ryjbSPBrkvzID1Nc3yUyitNl5vZoahGxmeUzLyT4/lUL5bZklgEqZt/6MAtNGZ4uosmdlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427630; c=relaxed/simple;
	bh=4PFZxKTpNpzNJDCl49djdZirWvVdQr6nAlUlQcGtCn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbaCrtT3Y3T77B8EZ5Y8w+e5UkafJeBWYShsmNV+horNBYsfCvTpdxpMeaMa07MBISL6VPTwfdDPo7BvDdpvQ6SGYXHyZgVzZxc3MB//jjZk4RWlFMGItvsEmcsAxWSAJYkPAlWtNPvPNfra+e8E/wfl7NrYvuzDqw94L69GLN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOFxkk6f; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427629; x=1781963629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4PFZxKTpNpzNJDCl49djdZirWvVdQr6nAlUlQcGtCn0=;
  b=BOFxkk6fXC6ymWb9DbrZ7HG76Et7rvoeOu4w+7HZMdwP8ZlQ+HMpNhw7
   5X0NF8bpuByXQ3lk+FnWXLgjB8bZdacSlDu00W6zPh7u8lAndGdjPaiWl
   fWJNH1BUEkftr3DeEedRjvaRSn9W3nhdauPVdgoSBe5hnbXFzikexxT4z
   sF/4E7e+TXspKQNs3d3vcBZXQgL3DKg3Z9O/27q9gNujnvagl0YeSgP65
   zpEKfx8H0MgtcJF+UMZUhqVVXcB2D4tPeUXdl9iHQrMgDiJRH22WWcN0m
   728/9weIDxNE5zs5d19ijjGHPbh9Hg+Lu/L1ZxBuCuOcdrxy5gza4mJdD
   w==;
X-CSE-ConnectionGUID: LEoLt5yARaq3jaSOecgQ4w==
X-CSE-MsgGUID: My8KiDGFQ0yJOsJw3FkX9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="55326116"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="55326116"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:48 -0700
X-CSE-ConnectionGUID: cyvBDv2VTXqUIQ2U+oyT2w==
X-CSE-MsgGUID: 0sM6kXFaREetfj8ba4f3Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151227085"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2025 06:53:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F0AAC70C; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
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
	Yian Chen <yian.chen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 11/16] x86/cpu: Set LASS CR4 bit as pinning sensitive
Date: Fri, 20 Jun 2025 16:53:19 +0300
Message-ID: <20250620135325.3300848-12-kirill.shutemov@linux.intel.com>
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

From: Yian Chen <yian.chen@intel.com>

Security features such as LASS are not expected to be disabled once
initialized. Add LASS to the CR4 pinned mask.

Signed-off-by: Yian Chen <yian.chen@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1a779e302872..d12ce36a76f5 100644
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


