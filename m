Return-Path: <linux-efi+bounces-3858-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CCAAE1CD1
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22294A486D
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372372BD59A;
	Fri, 20 Jun 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuvfEWTs"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF829CB54;
	Fri, 20 Jun 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427635; cv=none; b=TyS6uTAkl5B8/PsLQV00oFDwrkOjbBSCec1OGltJwekKI/+9Wv4AWPvosxnfgCnh0S2XIjMzi0WwC/SIu86RiWa/VK1aveRbefHxpkz27gmgLKXFQp+h4dnrmp5o4B/s+hkimbbALhIv/sUX0QTg/yRdD39NDyJ+Xtt/lxwyfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427635; c=relaxed/simple;
	bh=Wf5LnwgPh51NONUMTDjIXfOczEpk4ohRwoXhQNal+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ogmt69FwIVJcDYcvAFeyWbENZPfx/mS8kMMh6DKFyTbO/ai9/5CquD9+1fuypqq6cQqRp1dqiNLAVZWsNhYVpA9CR/spdS4nQQnoEoAosTiBiuG7MdKUJh85FyPyRX8KFhHJhjsrZn4JG7MxY27g/RcO+UMqF2pPii5E95bdD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuvfEWTs; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427633; x=1781963633;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wf5LnwgPh51NONUMTDjIXfOczEpk4ohRwoXhQNal+5U=;
  b=GuvfEWTsRYXLm4eOAK1k2PTBEFRkG2wWPmVMAhQTgSDAm5gtPBm0DMrS
   PGqONoGZeMO1wx6QTJa9vFIKxd3xpjSzA6KO9q/RH/ujTdyAJ2aCXcIue
   x7V4eNnVDfD/8bh0K2wA+iLsHM4H+8Rz/B0AlF+BKhwg/0OnVnU74wpnE
   18+6l1qBZngiNdUk6VNjyLIQhGu+Xezv9Q+Tk6WZBJ5sBRDG0Zt3TtySj
   YaBvqg2t6FFihVRkZR0EPesJO1ZKfcA8HCygsgr8laeSF6ZIOnrnzuyGf
   HIondmPm8Hv8sR0/PkU/wg8iTqI63iHuvGzd79YG4ZGgt9Wx5AxAPPDYA
   A==;
X-CSE-ConnectionGUID: KpmdLmVZQWybs94jsVlvLw==
X-CSE-MsgGUID: m7SrUC3QSVuj6nPB0zmwGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="55326138"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="55326138"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:53 -0700
X-CSE-ConnectionGUID: 0EPZ5y38TeaWglgkQY+3qA==
X-CSE-MsgGUID: 3Jv13A/vTum7/8l551nJUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151227096"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2025 06:53:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4404BA65; Fri, 20 Jun 2025 16:53:29 +0300 (EEST)
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
Subject: [PATCHv6 16/16] x86: Re-enable Linear Address Masking
Date: Fri, 20 Jun 2025 16:53:24 +0300
Message-ID: <20250620135325.3300848-17-kirill.shutemov@linux.intel.com>
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

This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.

LASS mitigates the Spectre based on LAM (SLAM) [1] and the previous
commit made LAM depend on LASS, so we no longer need to disable LAM at
compile time, so revert the commit that disables LAM.

Adjust USER_PTR_MAX if LAM enabled, allowing tag bits to be set for
userspace pointers. The value for the constant is defined in a way to
avoid overflow compiler warning on 32-bit config.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/Kconfig             | 1 -
 arch/x86/kernel/cpu/common.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 71019b3b54ea..2b48e916b754 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2181,7 +2181,6 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
-	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index edb342214328..0adf1b4722b8 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2565,11 +2565,8 @@ void __init arch_cpu_finalize_init(void)
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
 
-		/*
-		 * Enable this when LAM is gated on LASS support
 		if (cpu_feature_enabled(X86_FEATURE_LAM))
-			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
-		 */
+			USER_PTR_MAX = (-1UL >> 1) & PAGE_MASK;
 		runtime_const_init(ptr, USER_PTR_MAX);
 
 		/*
-- 
2.47.2


