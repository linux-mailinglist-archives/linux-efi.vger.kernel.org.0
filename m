Return-Path: <linux-efi+bounces-3719-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02FAB987E
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF943A4BC1
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605CE23183F;
	Fri, 16 May 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hWDXcWLW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3323099C;
	Fri, 16 May 2025 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386949; cv=none; b=cLglY+Rlp/KE7HACtzvnN2WZKfoS6PW0Ko1rl1QGz2pmjp4eTm/AsMHgPwhEfYhh1loPna4ARjQ7UVvPpnoPojaVvjFpZyoFfgNg4CfpJ8HoyF826fnuo+dHHuTyfmf7v9BAXX4taY5UyErLkakXx3NO0LEtYZWvhsiqMI6TduA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386949; c=relaxed/simple;
	bh=baRw7JMB+ps4ldkOrQMd13D6FILgrtV/HmvGTU74iDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=opf63DDBNGXgavUsgtenmEZAxONedVJ5JL9PGsRAo+ax3S7+HwYCxoj2zhnxYT54GfPXY+JIIhba1Uqy5qgkjbiEHQeveGat/Ve9K1IykWLfTB3YLJcHVJeQ3CIZwR5971VRtV7YjLLgmF5KffyvoJzcHL5+Y13gG5iT7VKp5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hWDXcWLW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747386946; x=1778922946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=baRw7JMB+ps4ldkOrQMd13D6FILgrtV/HmvGTU74iDM=;
  b=hWDXcWLWU1wuCJpcTi6D9DD61rgTW27W584IZkuFi0TeTCo7SYvSdMoI
   No+EtNrqLftQeZEcLZmRMa3RyhK3c92zUxJHrK2WFoFtkQ9zHn7YLPICC
   6zLfemuYZZunarVKU9nleDuWr9DpIggSeejLg6MGM8mclglZDoFQRSdxn
   XZLdFnTGNC7HI36nnvuwa+snnkksisKeFg1yDHF+K9lkcXNRoRymBvtnr
   YqoAS4Zo4Nzpv2ccYycDi0jhg/ezvJWKC2Dh9TtQo11XWxVyAqah1eEIG
   dQQief6dFLEZJHfp9SMONTqSIeq1lQ8KELDkmTwqjlByZXUqkIF1FVuPF
   Q==;
X-CSE-ConnectionGUID: RFUw8OwHQP6HA/gOsLEgPA==
X-CSE-MsgGUID: BlsfhOm1TcCjkPZFsyuV1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48605823"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="48605823"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:15:43 -0700
X-CSE-ConnectionGUID: 9DnlLs7XRy+UDSOK1+TvAg==
X-CSE-MsgGUID: gjBI41SdT1iQEbDI2NmiXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="143749862"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 16 May 2025 02:15:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E78CD38D; Fri, 16 May 2025 12:15:36 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCHv2 0/3] x86: Make 5-level paging support unconditional for x86-64
Date: Fri, 16 May 2025 12:15:30 +0300
Message-ID: <20250516091534.3414310-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both Intel and AMD CPUs support 5-level paging, which is expected to
become more widely adopted in the future.

Remove CONFIG_X86_5LEVEL.

In preparation to that remove CONFIG_DYNAMIC_MEMORY_LAYOUT and make
SPARSEMEM_VMEMMAP the only memory model.

v2:
 - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
   #if CONFIG_PGTABLE_LEVELS > 4;
 - Rebased onto current tip/master;

Kirill A. Shutemov (3):
  x86/64/mm: Always use dynamic memory layout
  x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
  x86/64/mm: Make 5-level paging support unconditional

 Documentation/arch/x86/cpuinfo.rst            |  8 ++---
 .../arch/x86/x86_64/5level-paging.rst         |  9 ------
 arch/x86/Kconfig                              | 32 ++-----------------
 arch/x86/Kconfig.cpufeatures                  |  4 ---
 arch/x86/boot/compressed/pgtable_64.c         | 11 ++-----
 arch/x86/boot/header.S                        |  4 ---
 arch/x86/boot/startup/map_kernel.c            |  5 +--
 arch/x86/include/asm/page_64.h                |  2 --
 arch/x86/include/asm/page_64_types.h          | 11 -------
 arch/x86/include/asm/pgtable_64_types.h       | 24 --------------
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/head64.c                      |  4 ---
 arch/x86/kernel/head_64.S                     |  2 --
 arch/x86/mm/init.c                            |  4 ---
 arch/x86/mm/init_64.c                         |  9 +-----
 arch/x86/mm/pgtable.c                         |  2 +-
 drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
 scripts/gdb/linux/pgtable.py                  |  4 +--
 18 files changed, 13 insertions(+), 126 deletions(-)

-- 
2.47.2


