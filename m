Return-Path: <linux-efi+bounces-1273-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537B0912BA3
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 18:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846401C266F0
	for <lists+linux-efi@lfdr.de>; Fri, 21 Jun 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EC515FA9E;
	Fri, 21 Jun 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oat0bwOA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99E115F41E;
	Fri, 21 Jun 2024 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718988266; cv=none; b=sJuAuqI+EJYJqpQOYmMbh2gvu2SSFIViUmzqO4kVua5zhKwAn08jJEwjbLa8epOEKAV+1IniUSBCwSzmDMa6bYC8cWbHEswhxUPcHLMgGAsuFRW5qarvlzQmcFItorD0C0mUlx6rEiN7xI8oOe8HxfqOCe3RmpAeCFR4PVy2JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718988266; c=relaxed/simple;
	bh=qyosJ/5otVrdGg2+4iUwkP9aGxGyOq607RT1qnKAyHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJAVdwbOGJ26kOShgF8Lb5uP+NoBAy/upHSFKtzI4s+7mJ+49143Q9aHwXAP4TfJNmwWvBQas1Kdy5w7AN+yKPqme2Rc4PQ/hCKv1PMAEoK4M8NN9/zWcbdHETZKvmKYrScKglYgL8Qch0D/S9yg06bQJkfTFVsP1YeVUPUkfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oat0bwOA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718988265; x=1750524265;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qyosJ/5otVrdGg2+4iUwkP9aGxGyOq607RT1qnKAyHc=;
  b=Oat0bwOA5XKr4zChTlEBn0JYBcbdpklcZBcBYbkTHDw5srNKZu332v1J
   eZcL6Ndt5DT1k8mqKlgLy2tpQtTfWRrQItq2a+NHDJsswE0hu51ECg831
   bw5njp6KfVqqBBnPmVhgYFygPp4b1Et1YbAIIDSfnjcKKGbLf3wZDICk6
   pBwtyMNqMeKhDPa/WmloJI010Gmjz67OjA11fCA12o/5NQiu/HPxlZNSg
   3RYLF0ZFwGFewYAn+qGmEsfultIhZdTdnY255sCKE5o4T4g1sIrSe2ecR
   0aEZY4RWvBafX/XWWvxI1WcxHgD9R5/6yKoirA8NuWJ3EIixscg/AeoDi
   g==;
X-CSE-ConnectionGUID: BhMOMM1KSi+xhDPn92uFGA==
X-CSE-MsgGUID: Arw2Nl6zQTKEGSk79frykg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15727172"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15727172"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:44:23 -0700
X-CSE-ConnectionGUID: GKjragTJQwKr5hb7jqpr0Q==
X-CSE-MsgGUID: 8BcQnyQgSsCpp5aYmkY7lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42745629"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Jun 2024 09:44:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 2B5CA12A; Fri, 21 Jun 2024 19:44:17 +0300 (EEST)
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
Subject: [PATCH 0/3] x86: Make 5-level paging support unconditional for x86-64
Date: Fri, 21 Jun 2024 19:44:03 +0300
Message-ID: <20240621164406.256314-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

Kirill A. Shutemov (3):
  x86/64/mm: Always use dynamic memory layout
  x86/64/mm: Make SPARSEMEM_VMEMMAP the only memory model
  x86/64/mm: Make 5-level paging support unconditional

 Documentation/arch/x86/cpuinfo.rst            |  8 ++---
 .../arch/x86/x86_64/5level-paging.rst         |  9 ------
 arch/x86/Kconfig                              | 32 ++-----------------
 arch/x86/boot/compressed/pgtable_64.c         | 11 ++-----
 arch/x86/boot/header.S                        |  4 ---
 arch/x86/include/asm/disabled-features.h      |  9 +-----
 arch/x86/include/asm/page_64.h                |  2 --
 arch/x86/include/asm/page_64_types.h          | 11 -------
 arch/x86/include/asm/pgtable_64_types.h       | 24 --------------
 arch/x86/kernel/alternative.c                 |  2 +-
 arch/x86/kernel/head64.c                      |  7 ----
 arch/x86/kernel/head_64.S                     |  2 --
 arch/x86/mm/init.c                            |  4 ---
 arch/x86/mm/init_64.c                         |  9 +-----
 arch/x86/mm/pgtable.c                         |  2 --
 drivers/firmware/efi/libstub/x86-5lvl.c       |  2 +-
 scripts/gdb/linux/pgtable.py                  |  4 +--
 .../arch/x86/include/asm/disabled-features.h  |  9 +-----
 18 files changed, 13 insertions(+), 138 deletions(-)

-- 
2.43.0


