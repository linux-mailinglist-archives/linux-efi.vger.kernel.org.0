Return-Path: <linux-efi+bounces-2039-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C7D9B3624
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A2CB24776
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCB31DF270;
	Mon, 28 Oct 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cm9K52mq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21CA1DFDA5;
	Mon, 28 Oct 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131967; cv=none; b=PLcnT7FnhI8qyVyK1jpESEZklqa1IxxLjoiWOdvVr9uH8S/ejVGE9xgSuNF1i2B+YI5TFFdDbstEZQC1rUYLyX50JRKvWWPWYFw9PgSb3EG4MKPBglRuzTgo9UGOTnpt1Gs5+ywyVB9QxMz7oV15jZcvRICg2MLOje/ZdPty7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131967; c=relaxed/simple;
	bh=dl3XZyhTS8Djp7/powdEYQthWqXNlLd0T3UVJapIuyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfaWLs0jEn1Eew7Tc1tcTF1VsJiezE0MFP/qrE3DkCruTUR+fWonoohZ5jUNWcZmJNCMiXXtYoF8IN7kmlUm4EYkNB7A306ucjc/FgZQJctMGPHbOvjigQVazxmoO+beTjPpOgJHjEnQiVCrOpNjZRcUaZdlg3/UK/e1sRtRvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cm9K52mq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131966; x=1761667966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dl3XZyhTS8Djp7/powdEYQthWqXNlLd0T3UVJapIuyQ=;
  b=Cm9K52mqV6xBskDt85V+2IphJGVJYfgnqRb1pYeAVpv9yXsvutFqad6Z
   wigjwIG8RQQ6KmgIE8yB8sfhvrzI60YvecEEyouOh/CxnRY4SoN3t6clp
   6Nha/KVC4996DLTjUwj5jBA+ur5KYVGfDFb9kPFkBA/PITLJ+frGGkEG2
   VSuck4bOE4MImOmgYDWhbUa6gPpnHQKRc9429tG27FV4g+IMnn/hK+Cd0
   tdPe5hfoSsXQj2svwsZ6p9YQy4HYXWlkh4Q4NnVVt52293tv73wPm8ORq
   14CfvtcIM4BulNukhBIBJrVF40jAiHWoHTmy+jLlQWFNfh+EbF3tdpezG
   w==;
X-CSE-ConnectionGUID: QjFofTcvREWsrGle7pwC6Q==
X-CSE-MsgGUID: 0k+WfTdHTEmbXw1aZ1uRuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32594417"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32594417"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:12:45 -0700
X-CSE-ConnectionGUID: Gy1JfNpnSbKOqqaDJjmWRA==
X-CSE-MsgGUID: /7wgu1DMQkCap2RejVcAAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112479044"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:12:33 -0700
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
Subject: [PATCH v5 16/16] Revert "x86/lam: Disable ADDRESS_MASKING in most cases"
Date: Mon, 28 Oct 2024 18:08:04 +0200
Message-ID: <20241028160917.1380714-17-alexander.shishkin@linux.intel.com>
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

This reverts commit 3267cb6d3a174ff83d6287dcd5b0047bbd912452.

LASS mitigates the Spectre based on LAM (SLAM) [1] and an earlier
commit made LAM depend on LASS, so we no longer need to disable LAM at
compile time, so revert the commit that disables LAM.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0bdb7a394f59..192d5145f54e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2257,7 +2257,6 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
 config ADDRESS_MASKING
 	bool "Linear Address Masking support"
 	depends on X86_64
-	depends on COMPILE_TEST || !CPU_MITIGATIONS # wait for LASS
 	help
 	  Linear Address Masking (LAM) modifies the checking that is applied
 	  to 64-bit linear addresses, allowing software to use of the
-- 
2.45.2


