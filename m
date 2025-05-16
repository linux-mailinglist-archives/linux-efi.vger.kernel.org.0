Return-Path: <linux-efi+bounces-3732-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC6AB9C29
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B36A237D4
	for <lists+linux-efi@lfdr.de>; Fri, 16 May 2025 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2402417FA;
	Fri, 16 May 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEKJSMbN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471CD23FC6B;
	Fri, 16 May 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747398811; cv=none; b=Nkn8I1gC1JD9eO0kVoO+QU9dTy2a7JPaBg7uygmbnOeJsgyPlUNEBaOn6VEpzd9NLapx/J4inqarHB8KUDOCgxyPo0U4vxR8vqMsO1rdrogKkAUjyvmZ1IL7ioOO1H/+ZXfstK0hVtGkmPCEItY/74H5zHMjhDpo8/aoBV1HFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747398811; c=relaxed/simple;
	bh=z7mciB3EF4/YY8p+PvVxvlajVGaVilyqU6N4SceaPKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ocjwzfsceM9w3GIuat8DH7LH+lTf7cApRxv2ordqWyQSeG4yltBCvFLhmgGSgwEY8bkJFpd3x5tNBXkVMMQeVaqxqEC1KvbpAQxrMNkph8uMUDU0fJvwxgwb5NVVwBVSR8UX0J6APKV7vB/CfnV12spu4NrcANIfEZ6U1sEqprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEKJSMbN; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747398810; x=1778934810;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z7mciB3EF4/YY8p+PvVxvlajVGaVilyqU6N4SceaPKQ=;
  b=kEKJSMbNdN4TF/aB6dA2qdHT89CzEj1PK94bHuQnIlpYBt1DyJWt1S0I
   84LJ7jdnC+QbkfkqCmhLfHQKWlyZfOhixS/Q79qBejFdmvKE8nKeUWDVS
   zjEyEeT4Iv0bswBhaQ9tmSLWuQKchpQE0e2URwED9QcQAr2LsKYNXSE0y
   PELFoRt/DRB3NcarG7U7NUNhcWrxXgTNAOM1CBWDi3CfO1xurEkF7eQgy
   uJq0kzrQ42a5Cb0z++DGdrTmUU4H5iMh/Ui+lYqLDOsytbfV3pmZIu9Le
   KClLITcEDKVW2EIiNe1gI6Je0XJbGv1HnBB9ef/PUf5XLDyYRuqx1QiO4
   Q==;
X-CSE-ConnectionGUID: jjIzoUE5QtSYbVOmVBfmvg==
X-CSE-MsgGUID: wvQaFcRgTW2aR3aB6LTb3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="53041539"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="53041539"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 05:33:26 -0700
X-CSE-ConnectionGUID: brqNGhR2RtSWuEOc4lsrSg==
X-CSE-MsgGUID: oIo3gmgJSGy240Ar1rhG5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139216326"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 16 May 2025 05:33:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 50BE61BC; Fri, 16 May 2025 15:33:19 +0300 (EEST)
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
Subject: [PATCHv3 0/4] x86: Make 5-level paging support unconditional for x86-64
Date: Fri, 16 May 2025 15:33:02 +0300
Message-ID: <20250516123306.3812286-1-kirill.shutemov@linux.intel.com>
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

v3:
 - Drop few "#if CONFIG_PGTABLE_LEVELS >= 5";
 - Make PARAVIRT_XXL 64-bit explicitly and drop ifdefs
   to support PGTABLE_LEVELS < 5;
 - Add Reviewed-by tags from Ard;
v2:
 - Fix 32-bit build by wrapping p4d_set_huge() and p4d_clear_huge() in
   #if CONFIG_PGTABLE_LEVELS > 4;
 - Rebased onto current tip/master;

Kirill A. Shutemov (4):
  x86/64/mm: Always use dynamic memory layout
  x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
  x86/64/mm: Make 5-level paging support unconditional
  x86/paravirt: Restrict PARAVIRT_XXL to 64-bit only

 Documentation/arch/x86/cpuinfo.rst            |  8 ++---
 .../arch/x86/x86_64/5level-paging.rst         |  9 -----
 arch/x86/Kconfig                              | 33 ++-----------------
 arch/x86/Kconfig.cpufeatures                  |  4 ---
 arch/x86/boot/compressed/pgtable_64.c         | 11 ++-----
 arch/x86/boot/header.S                        |  4 ---
 arch/x86/boot/startup/map_kernel.c            |  5 +--
 arch/x86/entry/vsyscall/vsyscall_64.c         |  2 --
 arch/x86/include/asm/page_64.h                |  2 --
 arch/x86/include/asm/page_64_types.h          | 11 -------
 arch/x86/include/asm/paravirt.h               |  4 ---
 arch/x86/include/asm/paravirt_types.h         |  2 --
 arch/x86/include/asm/pgtable_64.h             |  2 --
 arch/x86/include/asm/pgtable_64_types.h       | 24 --------------
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/head64.c                      |  4 ---
 arch/x86/kernel/head_64.S                     |  2 --
 arch/x86/kernel/paravirt.c                    |  2 --
 arch/x86/mm/init.c                            |  4 ---
 arch/x86/mm/init_64.c                         |  9 +----
 arch/x86/mm/pgtable.c                         |  2 +-
 arch/x86/xen/mmu_pv.c                         |  4 ---
 drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
 scripts/gdb/linux/pgtable.py                  |  4 +--
 24 files changed, 14 insertions(+), 142 deletions(-)

-- 
2.47.2


