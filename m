Return-Path: <linux-efi+bounces-3978-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 162F5AE833C
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6787C1C23BD5
	for <lists+linux-efi@lfdr.de>; Wed, 25 Jun 2025 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC1264A86;
	Wed, 25 Jun 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3fpEf7l"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C7263C8C;
	Wed, 25 Jun 2025 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855891; cv=none; b=STCt2d77t7CKhbb1RCy88oxrfkRwUSdTnVXP1ZuPz7l1e57LwVjst8Ik1my2T+sd46vK2nohFr0efRjeMKsxmM6Oi7GUwFMsH1oNU92LittRrlz200Ag4ABd+u3eMqcVR2lGzn+u2YccBooUVHm6bOPGvAbOk6Cj6+T+O7EJq5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855891; c=relaxed/simple;
	bh=G+eP9Bw73xI4j+67SYkgeX9LiSQjfbtHwX1bukiOpM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv0wv8US9fGPu96lhHFrFsMcTPK4lrCQ0Yz4ZNgD5tSVAZQlahdBLHM1+JgOFYPJfqiYw8LwIUN+/UCJYiJZKvHwT7TNDZCSfJS5BdBxQcsexXvV8qpuDupieO22xoXkPlTpbpfkau1uGX6kIaHEoMAS4t3hLa/DUnAhLDObxQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3fpEf7l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750855889; x=1782391889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G+eP9Bw73xI4j+67SYkgeX9LiSQjfbtHwX1bukiOpM0=;
  b=J3fpEf7lh/Pla6vTIIPHgsMNQvEpyXNZJKpSMLRtx/My1uJk2zgg7mcP
   8TGFshfFAU29iMijdoE0XeyhbTmhH03yTIoZqXMvDJYKftabKQPoDSZNd
   W5+JfYPhlrB5Fns8jEuufXYXJi9HYevPWxzrCbwyaCbu9cT7/GZlO5V2v
   LL3Eurb2VsvfuJy+Ormv6uFijmJiABYy2XqNWRRAJr+rWMcHjTUZCZ3AV
   QdYrm88Kye1tCDsMGB3dEcfM6KUrEXB3tvGj/MZLsnluHtwuz85AuH1DB
   Mz7+F3KMjBLAJBuhrlovLtYveXr/h2ikFzJieOsfqcfDxg2gss/aFrvT8
   A==;
X-CSE-ConnectionGUID: /LlMTBKmSWOVVfht/TYubg==
X-CSE-MsgGUID: km1NWNP7Ra2dicswD0IGjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="56908296"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="56908296"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 05:51:28 -0700
X-CSE-ConnectionGUID: DA2/ZC1WRhibPVOcMpNYFA==
X-CSE-MsgGUID: mRcpJriOSh2UDDMbWt64tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; 
   d="scan'208";a="152919787"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 25 Jun 2025 05:51:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AE0C54D5; Wed, 25 Jun 2025 15:51:12 +0300 (EEST)
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
Subject: [PATCHv7 05/16] efi: Disable LASS around set_virtual_address_map() EFI call
Date: Wed, 25 Jun 2025 15:50:58 +0300
Message-ID: <20250625125112.3943745-7-kirill.shutemov@linux.intel.com>
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


