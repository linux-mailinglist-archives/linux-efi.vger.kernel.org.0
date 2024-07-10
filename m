Return-Path: <linux-efi+bounces-1400-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C9892D5EC
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 18:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC6B9B251E8
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3770195B18;
	Wed, 10 Jul 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DAx1C/94"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F7195390;
	Wed, 10 Jul 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627848; cv=none; b=KhI0tvhCOZwpbLyxiyDIXV5CLwuw9/1FaE5NwP//kbCxX7sfSnyboBnQK4j3GkjrGsKn3nd4xqcJoFIKvRXON06S8gXf4F0OgoWCnYI34f3vzW/vAzH5oDoFlI2nNJpwfiKaZW2yQ6V2jJHZFucqEJkqiDAYJbdVoIKGfhtgGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627848; c=relaxed/simple;
	bh=C6MFhZXeK/t1+ET0yvxa+dCt6aFMcL8iI+b6zXefigE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgDlwKyreLUZ+5vPrU+0PkeLBSkQX9WwIsxqSJ2QurzDjjPng6PWNAh2EOu44k6gRDaBvQQTpGDkf9Hk3wghGwyPJ9YKA9Umw7ZSZNxvvJcd2yBgzokS4XfUq9tI9FDajXhuuhUikef+fcFTnK84BFONqAQnYa0QIFMjfxqPGaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DAx1C/94; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627847; x=1752163847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C6MFhZXeK/t1+ET0yvxa+dCt6aFMcL8iI+b6zXefigE=;
  b=DAx1C/94Hc/FkXszPlCBPaJw/gU3w/4dBu2KzzfPpZBl4EVCfCcDywyR
   rgm3ELFDXcvVEkA1wprb5IVthvONkHL0GdP5UbDNRsOXd2bownhPT5jNt
   us0sgDsIg8oMFBSE1W/qebQwMUL5zbzXfECFVU1TQk1bLGS5e3XA8QG/M
   L5M2w7fLF3xZe5oBixv1iardyKn53PjjvuMhQe7c1Jp710l7GFBFzqRYM
   e8qSLOAwNt6RMt8kSBV4m0cgQYePSn1dVo8phXn2wqyy98sBvUF7nGm5r
   8ylSmACx9vVdeaXnLZdkm8rrl/BmcwGisAEfy19k2GIeV6kki+6dgBvdG
   w==;
X-CSE-ConnectionGUID: zh7ihOc7Sh6QcPVm+gnxLA==
X-CSE-MsgGUID: e8Kc0fY6QvCN2gTjIg7mVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18103352"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18103352"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:10:46 -0700
X-CSE-ConnectionGUID: v5X2TLgRSNWA649daTdhnw==
X-CSE-MsgGUID: 5Ro2g62hR2Sg/FQoxkLaOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53085454"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:10:34 -0700
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
Subject: [PATCH v4 11/16] x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
Date: Wed, 10 Jul 2024 19:06:47 +0300
Message-ID: <20240710160655.3402786-12-alexander.shishkin@linux.intel.com>
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

The EMULATE mode of vsyscall maps the vsyscall page into user address
space which can be read directly by the user application. This mode has
been deprecated recently and can only be enabled from a special command
line parameter vsyscall=emulate. See commit bf00745e7791 ("x86/vsyscall:
Remove CONFIG_LEGACY_VSYSCALL_EMULATE")

Fixing the LASS violations during the EMULATE mode would need complex
instruction decoding since the resulting #GP fault does not include any
useful error information and the vsyscall address is not readily
available in the RIP.

At this point, no one is expected to be using the insecure and
deprecated EMULATE mode. The rare usages that need support probably
don't care much about security anyway. Disable LASS when EMULATE mode is
requested during command line parsing to avoid breaking user software.
LASS will be supported if vsyscall mode is set to XONLY or NONE.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 97608883b4b4..7c845c1db3b4 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -36,6 +36,7 @@
 #include <asm/vsyscall.h>
 #include <asm/unistd.h>
 #include <asm/fixmap.h>
+#include <asm/tlbflush.h>
 #include <asm/traps.h>
 #include <asm/paravirt.h>
 
@@ -63,6 +64,13 @@ static int __init vsyscall_setup(char *str)
 		else
 			return -EINVAL;
 
+		if (cpu_feature_enabled(X86_FEATURE_LASS) &&
+		    vsyscall_mode == EMULATE) {
+			cr4_clear_bits(X86_CR4_LASS);
+			setup_clear_cpu_cap(X86_FEATURE_LASS);
+			pr_warn_once("x86/cpu: Disabling LASS support due to vsyscall=emulate\n");
+		}
+
 		return 0;
 	}
 
-- 
2.43.0


