Return-Path: <linux-efi+bounces-2034-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E19B360D
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58ADF1F2310A
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303741DF73C;
	Mon, 28 Oct 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VF/1Am18"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320591DE2DC;
	Mon, 28 Oct 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131909; cv=none; b=gwpYfIiQ5tH1eH+/7xgqXydk3dtH/AQb9d9SfUPpHgsSjuFcFpAHB08ZvTzaGIjJgzwWzNUOLu93uvtk/mJVTRs94y22lO+6Q3EW51kdtbbS1uWCXF45+kJ6SVk5rUXIGVXSb0GfUUxNPO01FgwxwTrL67w1w3+oPYSv/gpWiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131909; c=relaxed/simple;
	bh=oxno7cC+3IH61CN0hexYdRPH6yC3p84/tRYHn+BYINQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAHN/loWzvg5A6z7osrPbjmNEXiR4fi37CpndrpLFZD+6uDdVkHCsc+3jmDfD76hHwkHE+VpOXudp19M3VAswG/o0BXhT8h4bbLSPcZQejzyaN9d05UyRd7zsEL00aOSSSqox2OxZTJVA3dInOJ98vAUX2F8IkZSexv8RPOb2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VF/1Am18; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131907; x=1761667907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oxno7cC+3IH61CN0hexYdRPH6yC3p84/tRYHn+BYINQ=;
  b=VF/1Am18VnyQgRsWMk5IIGxa76li/fhAYDyGzgoyHs97f+Ktl3ul8r30
   TfcBMtIieiVhTUTrBKZ7bo+zuDWNzoHWx86ZkvCyG6srjSCFDLTOBYR5w
   FLl1PLEFjNz4LNO0IOwnmkkNML45R17N/gYRliM2ixh7PVDSmhx6GG9ll
   +YKiAm20hUnve/vyyagMx7MSqN7zWTcbNgLSsRsjSPgKYy0v71zW7hfth
   fGRi8IVS7eYCb/4oqdPyX025fSYhd4pS/e8Y8KbSm8d7x1CrgrhSPThgc
   zgcVi8EumqygDbRqRTFXR6p7v8tGwhwOxJ2kWM/1NPUOZhlCuzJwTxoKU
   Q==;
X-CSE-ConnectionGUID: SjltdH7mQZyPT27H9AcUIg==
X-CSE-MsgGUID: N1AhmG98QOWjGIuxgNBlJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32594145"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32594145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:11:47 -0700
X-CSE-ConnectionGUID: eYgwVBsqTOG+07m1BPnE+Q==
X-CSE-MsgGUID: YrHgG6DCTbKBtF+seM84hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478510"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:11:35 -0700
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
Subject: [PATCH v5 11/16] x86/vsyscall: Document the fact that vsyscall=emulate disables LASS
Date: Mon, 28 Oct 2024 18:07:59 +0200
Message-ID: <20241028160917.1380714-12-alexander.shishkin@linux.intel.com>
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

Since EMULATE mode of vsyscall disables LASS, because fixing the LASS
violations during the EMULATE mode would need complex instruction
decoding, document this fact in kernel-parameters.txt.

Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..4091dc48670a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7391,7 +7391,9 @@
 
 			emulate     Vsyscalls turn into traps and are emulated
 			            reasonably safely.  The vsyscall page is
-				    readable.
+				    readable.  This also disables the LASS
+				    feature to allow userspace to poke around
+				    the vsyscall page.
 
 			xonly       [default] Vsyscalls turn into traps and are
 			            emulated reasonably safely.  The vsyscall
-- 
2.45.2


