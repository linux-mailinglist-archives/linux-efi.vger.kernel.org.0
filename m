Return-Path: <linux-efi+bounces-3983-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B6AE834D
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C431170EB4
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D2C268690;
	Wed, 25 Jun 2025 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1u2EZA3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E2266B41;
	Wed, 25 Jun 2025 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855894; cv=none; b=lk0ysmDkDuhioazXpQbXYHSvKEKGwwyYZNwMFW3IPZYj3P/wEcP5NRgyW4yMO2B7pguSnCaA6tfPnCLHIfkSHpJYFb6qie77zysEGCH9Q0pX1e+963NfqjHzLbKw7UU+IqBVFCzmXX3QlK4ubK9l9ZoY4Yt8G/b5z8ph53sEdbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855894; c=relaxed/simple;
	bh=gRYbIS7Dgh1noZwFu/j8FTMijwGvmqKuvAcfA8tsGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6nNufHJJ+XawYN5w43yj6fKWJZE1WbKmX+DHyAw6Ek/4PbDIS7O9HJJvwM4LEis1WL9UMpR5mlp4SsbYmyrJtJHP4fo0lvO50bDsgZGlPMQX7GY5bBuldLbuqOgs6UC0g5clF9LvCYalxiwdQzEddgy4PUQzygfh4UddLQyU3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1u2EZA3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855893; x=1782391893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRYbIS7Dgh1noZwFu/j8FTMijwGvmqKuvAcfA8tsGH0=;
  b=B1u2EZA3xoNqIS96dyHLJH/kZlrrIL4DfsfmtWu65bF9OZ8PxPUj4X8X
   s3GLlFcC+w2y/WpXdtOZ1Rkqq7prWqDTtxf6bUdJQL977cHwvRpfYuvtM
   6LzupqDnHiA3CMeMjHZ9MzZan3IRTGl5Fg0wAjx9HEO91UyFl0MmJgDKO
   3s0fkDcqF2xfObSzFja/Vu0bntDXmVK7ARdCnO+JlOJY2TKJzA1KS3k1+
   WLGR6cClnESFla08PB95geBweDWuJ0B9Qq83iOkbHLWDwPv7WR1wyhRcY
   vBzbGYcajJrCJVz3vIqTIIGOGOHFnBfhPi0+fN+8m/8IQX/qplu3H/oFE
   Q==;
X-CSE-ConnectionGUID: ir4YO1xxQveKfL7AMhWInw==
X-CSE-MsgGUID: nMI+TFDMRFqTFmZawkW8Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="53189609"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="53189609"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:32 -0700
X-CSE-ConnectionGUID: JDdH85PdT5GN4tnJmDIMAw==
X-CSE-MsgGUID: BSccn12xSoyfdl+piAUuhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="151830976"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jun 2025 05:51:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F2FD26DB; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
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
Subject: [PATCHv7 10/16] x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
Date: Wed, 25 Jun 2025 15:51:03 +0300
Message-ID: <20250625125112.3943745-12-kirill.shutemov@linux.intel.com>
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
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 arch/x86/entry/vsyscall/vsyscall_64.c           | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..796c987372df 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7926,7 +7926,9 @@
 
 			emulate     Vsyscalls turn into traps and are emulated
 			            reasonably safely.  The vsyscall page is
-				    readable.
+				    readable.  This disables the Linear
+				    Address Space Separation (LASS) security
+				    feature and makes the system less secure.
 
 			xonly       [default] Vsyscalls turn into traps and are
 			            emulated reasonably safely.  The vsyscall
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index be77385b311e..d37df40bfb26 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -63,6 +63,13 @@ static int __init vsyscall_setup(char *str)
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
2.47.2


