Return-Path: <linux-efi+bounces-3851-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687B8AE1CC0
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ADA5A758A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A0296156;
	Fri, 20 Jun 2025 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nQBoSisR"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCF128DF46;
	Fri, 20 Jun 2025 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427628; cv=none; b=jUEKNs5aKlnKbu/sohR6e7CyHnxUhtVUm0pyfbI3XKSHXwga8e/HvRDaM/2ne2AuWE2ykr5lmg2yh0W/U/ISO5/pBJfmgY7j7fXK60MUAjclEWJKX+BA9+DMWb1+YK1kmKK5wIcjpGiEsTKpujo3q7NagetBzMhEht3wxpWwP9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427628; c=relaxed/simple;
	bh=o4pNOg445phRLRAlBt8hD5707MRKC8ZIJw9ZQNgFdCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMrYEvVQ/fjUUcxr2mwglr+atR54VhVHg988Pw9MzU1HkrSuTR0NmbmQXb52R3zI9daKj3NHwSf2qjc48FwIGEXPIlCF5cHVv2QANxtUdh01gZiY6UaXHWAnrm+BNUHbAik9EZEg6FA5NUIOVKx9XZBRL42WEfBe8xZrEwpZEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nQBoSisR; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750427625; x=1781963625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4pNOg445phRLRAlBt8hD5707MRKC8ZIJw9ZQNgFdCE=;
  b=nQBoSisRlbRRE+QGyspjHQ7P4Av9M9O6AaJkrOKsOSskvgMK/Wvv+J4b
   3ulQdR57a8DfL7+g2cNcD1+PkF6E4dj81PVLWTuI82MB/YH1ra3AmtVS5
   cGDsFuy6m2SgpuCIUZRYMrsLQ7TpZZPqCxMI3eRIbTqddTHiq0cJY5L1E
   QZUs3nzQz6B7t1fza2czUviqEC5+YczwTyNU3oRvykAz49228AymUg2PW
   M7v6zBu4XSwqohLK0ZEC2ijC7i1FAbdOSEJ2zGJy0M3kTv4mN5eps/edo
   LKCLGBEqi87piUcUYpNPBrCIMiv6fnCQ/FGmkqbNZOIg84clZxbqpDeO1
   w==;
X-CSE-ConnectionGUID: UOrLsrWJQrmAr8r1xYeMTA==
X-CSE-MsgGUID: AFJDIpv4QO+PSqVHN18obw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="55326081"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="55326081"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 06:53:44 -0700
X-CSE-ConnectionGUID: Qwz5O6jkTSqBuQAcr+OBNQ==
X-CSE-MsgGUID: 2hvOVwlbRyiX6wTlWKjvNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; 
   d="scan'208";a="151227076"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 20 Jun 2025 06:53:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9F9B934A; Fri, 20 Jun 2025 16:53:28 +0300 (EEST)
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
Subject: [PATCHv6 06/16] efi: Disable LASS around set_virtual_address_map() EFI call
Date: Fri, 20 Jun 2025 16:53:14 +0300
Message-ID: <20250620135325.3300848-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
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
 arch/x86/platform/efi/efi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 463b784499a8..94c335229697 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -825,11 +825,24 @@ static void __init __efi_enter_virtual_mode(void)
 
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
2.47.2


