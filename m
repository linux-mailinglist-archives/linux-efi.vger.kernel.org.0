Return-Path: <linux-efi+bounces-2023-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13C9B35E3
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CFC0280A6D
	for <lists+linux-efi@lfdr.de>; Mon, 28 Oct 2024 16:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283A1DED42;
	Mon, 28 Oct 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjTWId5+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3A1DE2DC;
	Mon, 28 Oct 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131782; cv=none; b=CnumfPN9WFPBaT5vPUtzS+BPg+84jdu+j67Xu/bIh1E5TbXu0xnfc1NBZ6WWvTakMTBt4V7B9dRh6eEjLkAv79bXuUvEwVUoHU9Xu9wyE2vyZQdSuCl2B8a6StOvv0e/A8Rn0Yksw479NCrcD3YLsno2LQ1yR/5TUO3ecAkK438=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131782; c=relaxed/simple;
	bh=dcFLL4QwTmrZ0uKBYIZhLnWwXzO1Tq8hrHdknTOCQOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3V77HeNPWUV/tXhNjeGeacyzcYsulR0NYj9bkCIW7KPJ525pDOyjogYeQM6oop7K8Olw4PEPEV7Kh4CQWkXUL+s1yRAuam/w8uZC0D5TmGimcsWymenPR8LOG6+MtdDIYPACELekoD4BuMh2l5iajzhoJTjI4VP7hdB+0+eXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjTWId5+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730131781; x=1761667781;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dcFLL4QwTmrZ0uKBYIZhLnWwXzO1Tq8hrHdknTOCQOI=;
  b=gjTWId5+zU7JmAebe7vaQxg5kjmbvLffitM75wXZGydb0KOB4Ti7mzwX
   czuDbv58EjkOh+FvEja35uSwJff632otvEJF7+Al2ah1fPtAeUBIuk3ge
   dj7UzDRScCicaQJ014VNZupsWgy3+HEgT3zk5fRmdsjNWe0S3DERePbPE
   1Fa3G2e1H8j3p5a6vykOyc2AFfvoHBF/wy8K0mHubLB0bgKaQYgIKmCn3
   aHJ7zgTRkXimewpFMzfyKsjHt2TlJJLgezR3boev57zu/KhV9Kb8faBkS
   Rf8/g/o7Ho1L7hJGOGiD04dOljuhBz2TUe+S0cjbghU3Vz786x5GvsUPD
   g==;
X-CSE-ConnectionGUID: 56fpARMYRLKtQ9HZo+OAbg==
X-CSE-MsgGUID: rKB6lK4QSzaVm8a/OUwrJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="32593608"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="32593608"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:09:39 -0700
X-CSE-ConnectionGUID: oV3M4JvfQa+X6TutDCjcTg==
X-CSE-MsgGUID: 6IKjQ0cmSN6l5KLyecZFeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="112477587"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 28 Oct 2024 09:09:28 -0700
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
Subject: [PATCH v5 00/16] Enable Linear Address Space Separation support
Date: Mon, 28 Oct 2024 18:07:48 +0200
Message-ID: <20241028160917.1380714-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes from v4[8]:
- Added PeterZ's Originally-by and SoB to 2/16
- Added lass_clac()/lass_stac() to differentiate from SMAP necessitated
  clac()/stac() and to be NOPs on CPUs that don't support LASS
- Moved LASS enabling patch to the end to avoid rendering machines
  unbootable between until the patch that disables LASS around EFI
  initialization
- Reverted Pawan's LAM disabling commit

Changes from v3[6]:
- Made LAM dependent on LASS
- Moved EFI runtime initialization to x86 side of things
- Suspended LASS validation around EFI set_virtual_address_map call
- Added a message for the case of kernel side LASS violation
- Moved inline memset/memcpy versions to the common string.h

Changes from v2[5]:
- Added myself to the SoB chain

Changes from v1[1]:
- Emulate vsyscall violations in execute mode in the #GP fault handler
- Use inline memcpy and memset while patching alternatives
- Remove CONFIG_X86_LASS
- Make LASS depend on SMAP
- Dropped the minimal KVM enabling patch

Linear Address Space Separation (LASS) is a security feature that intends to
prevent malicious virtual address space accesses across user/kernel mode.

Such mode based access protection already exists today with paging and features
such as SMEP and SMAP. However, to enforce these protections, the processor
must traverse the paging structures in memory.  Malicious software can use
timing information resulting from this traversal to determine details about the
paging structures, and these details may also be used to determine the layout
of the kernel memory.

The LASS mechanism provides the same mode-based protections as paging but
without traversing the paging structures. Because the protections enforced by
LASS are applied before paging, software will not be able to derive
paging-based timing information from the various caching structures such as the
TLBs, mid-level caches, page walker, data caches, etc. LASS can avoid probing
using double page faults, TLB flush and reload, and SW prefetch instructions.
See [2], [3] and [4] for some research on the related attack vectors.

In addition, LASS prevents an attack vector described in a Spectre LAM (SLAM)
whitepaper [7].

LASS enforcement relies on the typical kernel implemetation to divide the
64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space
Any data access or code execution across address spaces typically results in a
#GP fault.

Kernel accesses usually only happen to the kernel address space. However, there
are valid reasons for kernel to access memory in the user half. For these cases
(such as text poking and EFI runtime accesses), the kernel can temporarily
suspend the enforcement of LASS by toggling SMAP (Supervisor Mode Access
Prevention) using the stac()/clac() instructions and in one instance a downright
disabling LASS for an EFI runtime call.

User space cannot access any kernel address while LASS is enabled.
Unfortunately, legacy vsyscall functions are located in the address range
0xffffffffff600000 - 0xffffffffff601000 and emulated in kernel.  To avoid
breaking user applications when LASS is enabled, extend the vsyscall emulation
in execute (XONLY) mode to the #GP fault handler.

In contrast, the vsyscall EMULATE mode is deprecated and not expected to be
used by anyone.  Supporting EMULATE mode with LASS would need complex
intruction decoding in the #GP fault handler and is probably not worth the
hassle. Disable LASS in this rare case when someone absolutely needs and
enables vsyscall=emulate via the command line.

[1] https://lore.kernel.org/lkml/20230110055204.3227669-1-yian.chen@intel.com/
[2] “Practical Timing Side Channel Attacks against Kernel Space ASLR”,
https://www.ieee-security.org/TC/SP2013/papers/4977a191.pdf
[3] “Prefetch Side-Channel Attacks: Bypassing SMAP and Kernel ASLR”, http://doi.acm.org/10.1145/2976749.2978356
[4] “Harmful prefetch on Intel”, https://ioactive.com/harmful-prefetch-on-intel/ (H/T Anders)
[5] https://lore.kernel.org/all/20230530114247.21821-1-alexander.shishkin@linux.intel.com/
[6] https://lore.kernel.org/all/20230609183632.48706-1-alexander.shishkin@linux.intel.com/
[7] https://download.vusec.net/papers/slam_sp24.pdf
[8] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/

Alexander Shishkin (7):
  init/main.c: Move EFI runtime service initialization to x86/cpu
  x86/cpu: Defer CR pinning setup until after EFI initialization
  efi: Disable LASS around set_virtual_address_map call
  x86/vsyscall: Document the fact that vsyscall=emulate disables LASS
  x86/traps: Communicate a LASS violation in #GP message
  x86/cpu: Make LAM depend on LASS
  Revert "x86/lam: Disable ADDRESS_MASKING in most cases"

Peter Zijlstra (1):
  x86/asm: Introduce inline memcpy and memset

Sohil Mehta (7):
  x86/cpu: Enumerate the LASS feature bits
  x86/alternatives: Disable LASS when patching kernel alternatives
  x86/vsyscall: Reorganize the #PF emulation code
  x86/traps: Consolidate user fixups in exc_general_protection()
  x86/vsyscall: Add vsyscall emulation for #GP
  x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
  x86/cpu: Enable LASS during CPU initialization

Yian Chen (1):
  x86/cpu: Set LASS CR4 bit as pinning sensitive

 .../admin-guide/kernel-parameters.txt         |  4 +-
 arch/x86/Kconfig                              |  1 -
 arch/x86/entry/vsyscall/vsyscall_64.c         | 61 +++++++++++++------
 arch/x86/include/asm/cpufeatures.h            |  1 +
 arch/x86/include/asm/disabled-features.h      |  4 +-
 arch/x86/include/asm/smap.h                   | 18 ++++++
 arch/x86/include/asm/string.h                 | 26 ++++++++
 arch/x86/include/asm/vsyscall.h               | 14 +++--
 arch/x86/include/uapi/asm/processor-flags.h   |  2 +
 arch/x86/kernel/alternative.c                 | 12 +++-
 arch/x86/kernel/cpu/common.c                  | 25 +++++++-
 arch/x86/kernel/cpu/cpuid-deps.c              |  2 +
 arch/x86/kernel/traps.c                       | 26 +++++---
 arch/x86/mm/fault.c                           |  2 +-
 arch/x86/platform/efi/efi.c                   | 13 ++++
 init/main.c                                   |  5 --
 tools/arch/x86/include/asm/cpufeatures.h      |  1 +
 17 files changed, 171 insertions(+), 46 deletions(-)

-- 
2.45.2


