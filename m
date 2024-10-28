Return-Path: <linux-efi+bounces-2033-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9E9B360A
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C011C23313
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686021DEFF5;
	Mon, 28 Oct 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RergVGlQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B61DF274;
	Mon, 28 Oct 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131898; cv=none; b=tsJYIhvXGlmvIM6SWJ0MX7naw6f+U4+9Bra7JXcM32Z3JciuACCM9vftTL54Do3etM0hM+9e9Qwta6eImIaOs/e+JpED8eJG6upw+sVBG5ehjo9zy3n3Re1fWqAkwWNOffmIR4aMbVHrtGmsqeTHiP/qjhn51H/5IMLMy2f4EC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131898; c=relaxed/simple;
	bh=p6UJ4UqeqaTwwIWbcQUazQxmnv70hIjs2k+J1k8n78M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zr0f5vp/c9nMDPSyFJ1F+jZN7+0HyM6EaUslRA6no7VvxCuubxAfTxFCxccJ/ZMK9wA/YFnP35GxVxi5t8m288PFCgUkueeqnvq6NYVHtcePOx4tBHINrymJP78CgA+tovN0Kiq/GN6zQbkwnjTz8BxxAI+h/33948c5TjZZDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RergVGlQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131897; x=1761667897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6UJ4UqeqaTwwIWbcQUazQxmnv70hIjs2k+J1k8n78M=;
  b=RergVGlQpHEsRwX9mJllFKzmsF/VMwpQGxt4+cq8wuKgqqzLvwudEBrw
   YrKk3CoYFuLUQuUiPOIiu1zUlKTE8umXUZfA/d/m0zhDA0CMwiHjZO7fb
   R98dPSUqNWf3lCOa/AkTynlUsf3xkjicjXUM9nKF0aAS5g+Rwpsv7NFR/
   EIXTfq40y3eXLkUm29hpXX7bGSTgeknrK6EJw/at3cjURmcLZLxHW1b0O
   M6kb183ebSN5L+e2Ksn1WCCEDeqWkoxbAXPQ+SfDhqDlrMQ0g9Ys+HRyD
   YwFhiwhd0jvhegCzy9P5SrdoNwrMism/DXqZy5PvWbsPncWuE0+igeqGm
   w==;
X-CSE-ConnectionGUID: O6fHeqa2Rp6GUxL01/yb6A==
X-CSE-MsgGUID: CDfrT2pJQY2jRIQ/5cJ1SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32594104"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32594104"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:11:35 -0700
X-CSE-ConnectionGUID: ySMFOMCLQoafDBj15lM3Zw==
X-CSE-MsgGUID: ikFRhMSaQoWUSzti22uo7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478423"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:11:23 -0700
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
	linux-efi@vger.kernel.org
Subject: [PATCH v5 10/16] x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
Date: Mon, 28 Oct 2024 18:07:58 +0200
Message-ID: <20241028160917.1380714-11-alexander.shishkin@linux.intel.com>
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
2.45.2


