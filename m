Return-Path: <linux-efi+bounces-1405-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F1892D601
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD081F27648
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9F197A8B;
	Wed, 10 Jul 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJeYUvcH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0E195381;
	Wed, 10 Jul 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627913; cv=none; b=h66QqLSWsOQZnL3fwizuGAE9pyhJvfG6uTEwjtjuyMqMjle5xHmCWPHclcbLAkIn+nmnAgtSszNGDVBQi8X1Vrum6CxzjPwjWf50NZ5XXQtXBQlJ/EbFDZ2riIppMBLSk2I4CBKmP0XthcHgjTxDKuS8Pza8BTKrORHSI/3UT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627913; c=relaxed/simple;
	bh=iHli+zVp4z1gD0VVuhpl7g65NvHAppcAAPWbrqVKI+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4CTIfmTdKUvY9oab3Yk+tp+o4qcVUbiD8l1bbflmwbnHghtMYd3srLGlhvkIbVJhEFz9zYpjowE9D4GH3KiB1m/nUI7UPYj6nxEi/MTGaAIk1RjCwhdRvaFXNIOYZ5+JrWJOwoc08WWzSKzm2WU//Znl4/ZhNAr74Bm04c8U4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJeYUvcH; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720627911; x=1752163911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iHli+zVp4z1gD0VVuhpl7g65NvHAppcAAPWbrqVKI+Q=;
  b=AJeYUvcHPSKBf3dHXdv7UzTUDcnIxjCWnvMHJgPmwKPDjz7VWsrisnxR
   OsqnTemnjaEkRfYyX+spPyBP7eBPt1vcCtahJraP1LGVed5dYxjNBf2Gr
   rW1qGBz3qDfEn8v8lO7UU5wMxCOxBUFA+q0s7N78JEOT2gn9uuWpAJFf3
   B3ljGvQoKThRUF7gbIM4SFnp5mGY7g6MkZKJyU29eI0BkuOwMr0j5Hb3x
   szO0FXtVtQle7APW5+M74yvf7mdY2zPwliyQdHtusTYBWiPrsWc0Pcm8k
   aNV+E5o2OmK0UiJX0w1Jy3lw8009TwSIlv2K4YPDoXNRop4UdXasYdSu0
   Q==;
X-CSE-ConnectionGUID: Grxx5/FfQ0yQJwE6iYBJHg==
X-CSE-MsgGUID: igSXQCtkRZi+eJc8jMx5XQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18103566"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18103566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 09:11:51 -0700
X-CSE-ConnectionGUID: 1tNSTHVFQC6ZT2aH1yMOoA==
X-CSE-MsgGUID: 8ej7wP1lSfeb+YrFgUAZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53085808"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 Jul 2024 09:11:38 -0700
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
Subject: [PATCH v4 16/16] x86/cpu: Make LAM depend on LASS
Date: Wed, 10 Jul 2024 19:06:52 +0300
Message-ID: <20240710160655.3402786-17-alexander.shishkin@linux.intel.com>
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

To prevent exploits for Spectre based on LAM as demonstrated by the
whitepaper [1], make LAM depend on LASS, which avoids this type of
vulnerability.

[1] https://download.vusec.net/papers/slam_sp24.pdf

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 22612e01ec2e..8986e990beb0 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -85,6 +85,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
 	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
+	{ X86_FEATURE_LAM,			X86_FEATURE_LASS      },
 	{}
 };
 
-- 
2.43.0


