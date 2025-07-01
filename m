Return-Path: <linux-efi+bounces-4064-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1457CAEF431
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA7E443E89
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2337D273D66;
	Tue,  1 Jul 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYdQjS3m"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70127281A;
	Tue,  1 Jul 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363954; cv=none; b=RnubQ9xS4LMMElQdNSj9hJMeth+MPhYLun60Eiuekdk28Vntw1+RN+ckiwAqFkNy/Dsa26wk/EGg+5r9vduuW7F4Ma2864SgPoRjRAD+ZcudOQnrEwtL/MgoKo/J7L7GK6jbyDiZW+02nvTRaoHbl0fR8mP4Y0uct2rkhBSdHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363954; c=relaxed/simple;
	bh=gRYbIS7Dgh1noZwFu/j8FTMijwGvmqKuvAcfA8tsGH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LTpPaxN7iTtdgKSv6InBzQ5oJN3uJStibDwnBFHikpL/jcKnLQvzN4N53yjLC6Zigp64dSSbBhHk6RfXwhUYaSXZ1CAIPIhGsbnkPkhnUaPZaFf4l8DpUlAuMXNx725qlplAniz7Lcz9XHuMQBVGHF9ZAvo1xpFqVLuF6ia3qpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYdQjS3m; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363952; x=1782899952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRYbIS7Dgh1noZwFu/j8FTMijwGvmqKuvAcfA8tsGH0=;
  b=FYdQjS3mLgRtT0eD4mwRyp182zpCCWW0JZfLzSaYdCVXBwGyhO3lvhLU
   EXmLyy5QXfhjw+AhvhX8RnRpSW5yM3vDsnGhvm88akw4ZqbRjdbw5UXMz
   XCkKtfRGGHlflucOewrDRF8bFUImwfdHCeVJ7xeqjUZY1SUTPXAr9v4NU
   CQ/lL7Ng40v7yRsGR3p8ZAPrtj5O/G2AEZ9MuXt7iRr7OEF0S0gAJhGEk
   lcbNZmN0K/fr+R0O2Att6lQEAi4+l2ZBU00nW617Ip0v09QMOyzYNpVJM
   jCvoQz7+y2lFWZFpH2rEAMR3PWj6kq2jv3GzZxsWXs/N84KB2g5lLsYiQ
   g==;
X-CSE-ConnectionGUID: bFWgVS+UQH6AJmUEf8XdMA==
X-CSE-MsgGUID: DccjpOVBRQqFeCvsRT2z8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71048691"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71048691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:10 -0700
X-CSE-ConnectionGUID: zWH4JyydQyiqU6Pd+Unzqw==
X-CSE-MsgGUID: aYY1iB0TQ/KOPkw2mkRjpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177390831"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 02:58:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AC55F679; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 10/17] x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
Date: Tue,  1 Jul 2025 12:58:39 +0300
Message-ID: <20250701095849.2360685-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
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


