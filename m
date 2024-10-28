Return-Path: <linux-efi+bounces-2029-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BCD9B35FB
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7551F230F3
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656721DED5A;
	Mon, 28 Oct 2024 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6DdHih1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556521DED67;
	Mon, 28 Oct 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131851; cv=none; b=DefSn8Xr6TanBb5SqJ5PB3QFyxL9dG1rPGW5ECpqxoSPCHWoSnb+EdzDiAIXxc3MEQFHfrB9dcOWJ3RcdjvBFWGujaZw2EcwZR1v5pPhRD3kMGHaVGZN2o313N5hsM2aTjmllVOj3mm7aFw2ZERm4FtY0D35gpVBQncxXrHsHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131851; c=relaxed/simple;
	bh=Y9PMFm8PdEy5dKAPuPEC0T6fFR338eDHBLUlCswd6VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOrURkxRVGkp0YJceb6U73xqEwBsajFu5bvsUKP37wRt3GvTCVfxvVstaoUtlG8jsRj4zG7MSnUdU6/uaNHftkCP9Gn65+LXJT+e5EKLsDT2jIvB9h253H54cdQVF6fj5bFrBYL6V8lQqbv7IR6Mbvpz7CxVAYXG+5J/3Tbgx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6DdHih1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131850; x=1761667850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9PMFm8PdEy5dKAPuPEC0T6fFR338eDHBLUlCswd6VM=;
  b=C6DdHih14tIan2iOR4pN1UfUvIjj05Z+Fb4qCCcZTyfH35PhAI1qZX2M
   7Ini9u+crc97Vzk8VWOipuuwfLH1h4FaIpGUD2FsN/rnf1uSe18wV16kZ
   SNI8+LY/q29TeOCvY/QMZoPTxdKEui4z3oeA0E5WIh41rOZfV9k11jTDN
   B03bkP1l88V7kwL7vn6IaNvfLwWsQU8ACkBDcO2Ggd9C7hzkH0quf24nL
   /lPHW20Nw65448xzF+BoVt7HL4c3zPjDsE6CzcnCN8diKEjyBQ95y/aTn
   UnZktDkXsCGXIjcqSuf0uCPWNptlfKfz7O+IMAsG3ZKDpJesxcRPAPCHe
   Q==;
X-CSE-ConnectionGUID: L/8nnXJNS3urQy+It2h0dw==
X-CSE-MsgGUID: qcoHaKn0S8yXledLCdkeWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32593922"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32593922"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:10:48 -0700
X-CSE-ConnectionGUID: ZLYI7IxeSXmu3myrLA8PIg==
X-CSE-MsgGUID: 3PQ4HvZuRFePA+6bph51Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112478112"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:10:37 -0700
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
Subject: [PATCH v5 06/16] efi: Disable LASS around set_virtual_address_map call
Date: Mon, 28 Oct 2024 18:07:54 +0200
Message-ID: <20241028160917.1380714-7-alexander.shishkin@linux.intel.com>
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

Of all the EFI runtime services, set_virtual_address_map is the only one
that is called at its lower mapping, which LASS prohibits regardless of
EFLAGS.AC setting. The only way to allow this to happen is to disable
LASS in the CR4 register.

Disable LASS around this low address EFI call.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 arch/x86/platform/efi/efi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 88a96816de9a..4a7033f6de1f 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -846,11 +846,24 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
+	/*
+	 * set_virtual_address_map is the only service located at lower
+	 * addresses, so we have to temporarily disable LASS around it.
+	 * Note that clearing EFLAGS.AC is not enough for this, the whole
+	 * LASS needs to be disabled.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		cr4_clear_bits(X86_CR4_LASS);
+
 	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
 					     efi.memmap.desc_size,
 					     efi.memmap.desc_version,
 					     (efi_memory_desc_t *)pa,
 					     efi_systab_phys);
+
+	if (cpu_feature_enabled(X86_FEATURE_LASS))
+		cr4_set_bits(X86_CR4_LASS);
+
 	if (status != EFI_SUCCESS) {
 		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
 		       status);
-- 
2.45.2


