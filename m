Return-Path: <linux-efi+bounces-4057-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909CAEF424
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 12:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD711BC6A81
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2929E270ED4;
	Tue,  1 Jul 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T47dJNTG"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6616726FDAC;
	Tue,  1 Jul 2025 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363949; cv=none; b=Qd4oJIvPKvDJcCMwhlcNVDM9QNc6I8+KArewxCkA3nUmL1YtsXuk6ewkB/EJxdF202OYu6wm/Aal2moXgkRF3JDzopHxKtUjb59pyYnF0tyjptAIwgfYGXheHu5hOZZ3ZR/6jQwk//iRuDVulLz03jTeE9W5k/42loPh3OJ13AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363949; c=relaxed/simple;
	bh=G+eP9Bw73xI4j+67SYkgeX9LiSQjfbtHwX1bukiOpM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq+oxj/4DdFVEE2LXgsD/x+58rNLJoAehcKsJSVn/Ax06sIhFOYklhRTVn9eHPkoN1P53P0W5vr0zFiW9Il407/tL9dLulW1aCTxoBROXCp6KfRWNCuVtyvtcyF32jC23BZ/VXGcUYdVUo0v0RwmWQESdctd1VLwSqS059S2MTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T47dJNTG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363948; x=1782899948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+eP9Bw73xI4j+67SYkgeX9LiSQjfbtHwX1bukiOpM0=;
  b=T47dJNTGqyLtldhrhszu5ZTemlhhgi4EA0pymKiOS4XTSv1396RTdwj8
   VH5ZR84ez+parwzeKwCPe7N0hdHdhy4z6eZ2btCAgwdloL2XlJnfR49Mp
   5J6St1h0atQydOocS+5uSYOjsKdTlKt/zXeBLTpQuB1+q152r7K1ZhENa
   VOaoVdVRc83ggqwT2VfTMnHUdZQ1aKd3Jb2Gio8FgcWo1JC2UoFCt0z+6
   aUBg0Ihugn2c0H2ovLSHpmsFvZY5DvCJp24p0eiQ3MsExAL2Y++5z8Kxx
   4wcdSdIS8yxkZC6RNu6WOCTNK0mHurPsCuYy7NaNZE5Zj4MwbiFV+8NSp
   Q==;
X-CSE-ConnectionGUID: UmqLEIhvTDCKmtt0e6mUuQ==
X-CSE-MsgGUID: 57h9T2ckSJuMIGzs5Esuqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="57428029"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="57428029"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:07 -0700
X-CSE-ConnectionGUID: qbhrAEsuT3OS1w2+RDuY5g==
X-CSE-MsgGUID: WBcnX9YsScuHLqGF0AKp1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="190896404"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 01 Jul 2025 02:58:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 67888417; Tue, 01 Jul 2025 12:58:50 +0300 (EEST)
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
Subject: [PATCHv8 05/17] efi: Disable LASS around set_virtual_address_map() EFI call
Date: Tue,  1 Jul 2025 12:58:34 +0300
Message-ID: <20250701095849.2360685-6-kirill.shutemov@linux.intel.com>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Of all the EFI runtime services, set_virtual_address_map() is the only
one that is called at its lower mapping, which LASS prohibits regardless
of EFLAGS.AC setting. The only way to allow this to happen is to disable
LASS in the CR4 register.

Disable LASS around this low address EFI call.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/platform/efi/efi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..5b23c0daedef 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -787,6 +787,7 @@ static void __init __efi_enter_virtual_mode(void)
 	int count = 0, pg_shift = 0;
 	void *new_memmap = NULL;
 	efi_status_t status;
+	unsigned long lass;
 	unsigned long pa;
 
 	if (efi_alloc_page_tables()) {
@@ -825,11 +826,25 @@ static void __init __efi_enter_virtual_mode(void)
 
 	efi_sync_low_kernel_mappings();
 
+	/*
+	 * set_virtual_address_map() is the only service located at lower
+	 * addresses, so LASS has to be disabled around it.
+	 *
+	 * Note that flipping RFLAGS.AC is not sufficient for this, as it only
+	 * permits data accesses and not instruction fetch. The entire LASS
+	 * needs to be disabled.
+	 */
+	lass = cr4_read_shadow() & X86_CR4_LASS;
+	cr4_clear_bits(lass);
+
 	status = efi_set_virtual_address_map(efi.memmap.desc_size * count,
 					     efi.memmap.desc_size,
 					     efi.memmap.desc_version,
 					     (efi_memory_desc_t *)pa,
 					     efi_systab_phys);
+
+	cr4_set_bits(lass);
+
 	if (status != EFI_SUCCESS) {
 		pr_err("Unable to switch EFI into virtual mode (status=%lx)!\n",
 		       status);
-- 
2.47.2


