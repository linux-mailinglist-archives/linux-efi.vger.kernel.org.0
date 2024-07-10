Return-Path: <linux-efi+bounces-1395-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C0B92D5D5
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041B61C23E44
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121A194C6F;
	Wed, 10 Jul 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LvArj8vm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6DA194AFC;
	Wed, 10 Jul 2024 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627782; cv=none; b=DQQALVKzK6TwUpIk24Zu8JYMln7+0ge3d3vwFzX7u5lC2+Bv0z6m3bfF57gRS3Exa0qlJWQQIw8LodQ74TWVo6yLwSC+lIR198HOMxwtnicxId0JDzMDQVlGwGw4ugvp6KqQfO/k4SLrGa1h4B2vhGx/0BSDj8diIe75C+9MfMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627782; c=relaxed/simple;
	bh=V9px3JV2Wl/ar/jIBNnaNIJiRCsSG4GK1x15nw8iC7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzUcmasKoGuCA/mTlB7U2KOqO9ezoZbb6Gry4tg0jDQz6VZTgqaiPDjVU9JZ+KMQqVi8tfLZ4bX13Nh8RSQ+hgN0xBK7RleGuajfCFYVWO3oyXbX6WVagRmnIt6LxPriPG2VERo9vNiAnSbc6jlziNLq+ti5PIFjR+6njc8ur5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LvArj8vm; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627781; x=1752163781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9px3JV2Wl/ar/jIBNnaNIJiRCsSG4GK1x15nw8iC7A=;
  b=LvArj8vmp1FSzyjz0lVzZ3Rl5pUkLsqLQTY8q+tQ2iHdr+qAJpq0juna
   o/Pf96t7QWzL2RscIuy0CovhgiqeQeocoE5kmfP9NyYOmZcxyEZzFUeBj
   ljfhIajT5AU6pqOoxl6yZkSlwDhaKpgfFpvMpjlI1VHss+n6v8NOMwvf/
   9WLjOLO5OeG7Rt4d4OMbJXfAjYlxTyHf/ezDVnZZSOuZXe1Xe8ttGULnJ
   RCKqvtaRtk2FtpVPrncqWrTu0f3TlAKibvR9WhZOEa1YnjGHLnSVcmAYe
   +F6ZldI3ePnAC5ORERIRrtvDMWXa/o/SiM0e8q4lvhyJ4EqnukSnl6EsW
   w==;
X-CSE-ConnectionGUID: mRo/3/hKSHCLfkAARkz30w==
X-CSE-MsgGUID: YhXbDnMXR96759uJJrveAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18103074"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18103074"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:09:40 -0700
X-CSE-ConnectionGUID: S7w7cXdtTPGVrNV0zBopdA==
X-CSE-MsgGUID: vhTxzJONQAybATYZIRD++A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53084797"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:09:28 -0700
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
Subject: [PATCH v4 06/16] init/main.c: Move EFI runtime service initialization to x86/cpu
Date: Wed, 10 Jul 2024 19:06:42 +0300
Message-ID: <20240710160655.3402786-7-alexander.shishkin@linux.intel.com>
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

The EFI call in start_kernel() is guarded by #ifdef CONFIG_X86. Move
the thing to the arch_cpu_finalize_init() path on x86 and get rid of
the #ifdef in start_kernel().

No functional change intended.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 7 +++++++
 init/main.c                  | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 33a76256a6f5..8aa621dc7d30 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -26,6 +26,7 @@
 #include <linux/pgtable.h>
 #include <linux/stackprotector.h>
 #include <linux/utsname.h>
+#include <linux/efi.h>
 
 #include <asm/alternative.h>
 #include <asm/cmdline.h>
@@ -2364,6 +2365,12 @@ void __init arch_cpu_finalize_init(void)
 	fpu__init_system();
 	fpu__init_cpu();
 
+	/*
+	 * This needs to follow the FPU initializtion, since EFI depends on it.
+	 */
+	if (efi_enabled(EFI_RUNTIME_SERVICES))
+		efi_enter_virtual_mode();
+
 	/*
 	 * Ensure that access to the per CPU representation has the initial
 	 * boot CPU configuration.
diff --git a/init/main.c b/init/main.c
index 206acdde51f5..cce4ceaf7c9c 100644
--- a/init/main.c
+++ b/init/main.c
@@ -51,7 +51,6 @@
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/cgroup.h>
-#include <linux/efi.h>
 #include <linux/tick.h>
 #include <linux/sched/isolation.h>
 #include <linux/interrupt.h>
@@ -1070,10 +1069,6 @@ void start_kernel(void)
 
 	pid_idr_init();
 	anon_vma_init();
-#ifdef CONFIG_X86
-	if (efi_enabled(EFI_RUNTIME_SERVICES))
-		efi_enter_virtual_mode();
-#endif
 	thread_stack_cache_init();
 	cred_init();
 	fork_init();
-- 
2.43.0


