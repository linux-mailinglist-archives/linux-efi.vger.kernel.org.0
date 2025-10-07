Return-Path: <linux-efi+bounces-4961-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E032BC0662
	for <lists+linux-efi@lfdr.de>; Tue, 07 Oct 2025 08:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8BDA34CC28
	for <lists+linux-efi@lfdr.de>; Tue,  7 Oct 2025 06:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0922B8AB;
	Tue,  7 Oct 2025 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OY5BKxwt"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9F02264A7;
	Tue,  7 Oct 2025 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820039; cv=none; b=OvB1HnZAzZLID+vLJae5ju5mR5vdHU38OubFhNbIRTlpuZ4cblPY8zp5lqP32t21PBqpGe7krpmjFzsgaOAvUQRjdedGcInNtwjWce0Hl5OimQlU22n9FRhVevW1UvVYqXj3Ob80WgPQaIOj+N/191CaXRG2sFlZZbxHikH5nLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820039; c=relaxed/simple;
	bh=sTuEIszWf1hpGyfoffKw9He+rRHF8efyzJJwSZqEKho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIG7kjd8UScVSFV2Ih47/4pIBva+W07iXpiUm8ITdSar6w/4qvmZZE3bYLVJqb2Ry+haLk2V7cmVE9xFFmt9oDlyzNmc/MrMKYJCy4GbD3tpoR3pnPrRa5KkcgAfljPcFZ2wI5yre3rVvYKn/shPtBF7P9xs3X7OtdUFYAkIX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OY5BKxwt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759820036; x=1791356036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sTuEIszWf1hpGyfoffKw9He+rRHF8efyzJJwSZqEKho=;
  b=OY5BKxwtc/dzpR12IXWaXLk9jZ3fQ8guoeSwV2SksDtq6HbyaxoCOuZ1
   /RniI0BZTPspwEdZe56sOVa6a5455nYV8Wprj9FHIP1ymwPtHyVxwSepD
   lwfAIrLbkSwodv8Rll3vqtxAriKq9NvrsBbbry05A7ANm+9Jo2BuxsFLK
   TfVx31dnvaPEbMYCss2Ywg71ZZKewFvapVP0QBErfe0BCAUEKVcATJNZc
   vW2i6zu2+bsNvqXq+KBUwbd1zfmVH743HsSj7IJNSQWAQAnO5UpE26gTE
   peXn+lhLvEnJgOKdUe98uCYlFuyjqDsU3PQFV/I+QwciSqUgRLBNCbQ8W
   w==;
X-CSE-ConnectionGUID: 5bgibybKTeSvFZvdNsocOQ==
X-CSE-MsgGUID: e7SOklfCRqqc552f2UKqVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="72254371"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="72254371"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 23:53:55 -0700
X-CSE-ConnectionGUID: LEqFsFcfShWaWb+MH/3Qrw==
X-CSE-MsgGUID: BdQ+Id4lQk2UAG6g1DUMQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="184354450"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 06 Oct 2025 23:53:55 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A . Shutemov" <kas@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Xin Li <xin@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sean Christopherson <seanjc@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Laight <david.laight.linux@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v10 00/15] x86: Enable Linear Address Space Separation support
Date: Mon,  6 Oct 2025 23:51:04 -0700
Message-ID: <20251007065119.148605-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linear Address Space Separation (LASS) is a security feature [1] that
works pre-paging to prevent a class of side-channel attacks that rely on
speculative access across the user/kernel boundary.

Change of personnel
-------------------
I am picking up this series from Kiryl. The patches have switched hands
multiple times over the last couple of years. I have refreshed the
commit tags since most of the patches have gone around a full circle.

Many thanks to Kiryl and Alex for taking these patches forward. Would
highly appreciate your reviews tags on the updated series.

Changes in v10
--------------
- Use the simplified versions of inline memcpy/memset (patch 2)
- New patch to fix an issue during Kexec relocate kernel (patch 7)
- Dropped the LAM re-enabling patch (will post separately)
- Reworded some of the commit messages
- Minor updates to code formatting and code comments

v9: https://lore.kernel.org/lkml/20250707080317.3791624-1-kirill.shutemov@linux.intel.com/

Patch structure
---------------
Patch     1: Enumerate LASS
Patch   2-3: Update text poking
Patch   4-5: CR pinning changes
Patch   6-7: Update EFI and kexec flows
Patch  8-11: Vsyscall impact
Patch 12-14: LASS hints during #GP and #SS
Patch    15: Enable LASS

The series is maturing, as reflected by the limited incremental changes.
Please consider providing review tags/acks for patches that seem ready.

Background
----------
Privilege mode based access protection already exists today with paging
and features such as SMEP and SMAP. However, to enforce these
protections, the processor must traverse the paging structures in
memory.  An attacker can use timing information resulting from this
traversal to determine details about the paging structures, and to
determine the layout of the kernel memory.

The LASS mechanism provides the same mode-based protections as paging,
but without traversing the paging structures. Because the protections
enforced by LASS are applied before paging, an attacker will not be able
to derive timing information from the various caching structures such as
the TLBs, mid-level caches, page walkers, data caches, etc. LASS can
prevent probing using double page faults, TLB flush and reload, and
software prefetch instructions. See [2], [3], and [4] for research
on the related attack vectors.

Though LASS was developed in response to Meltdown, in hindsight, it
alone could have mitigated Meltdown had it been available. In addition,
LASS prevents an attack vector targeting Linear Address Masking (LAM)
described in the Spectre LAM (SLAM) whitepaper [5].

LASS enforcement relies on the typical kernel implementation dividing
the 64-bit virtual address space into two halves:
  Addr[63]=0 -> User address space
  Addr[63]=1 -> Kernel address space
Any data access or code execution across address spaces typically
results in a #GP, with an #SS generated in some rare cases.

Kernel accesses
---------------
When there are valid reasons for the kernel to access memory in the user
half, it can temporarily suspend LASS enforcement by toggling the
RFLAGS.AC bit. Most of these cases are already covered today through the
stac()/clac() pairs, which avoid SMAP violations. However, there are
kernel usages, such as text poking, that access mappings (!_PAGE_USER)
in the lower half of the address space. LASS-specific AC bit toggling is
added for these cases.

There are a couple of cases where instruction fetches are done from a
lower address. Toggling the AC bit is not sufficient here because it
only manages data accesses. Therefore, CR4.LASS is modified in the case
of EFI set_virtual_address_map() and kexec relocate_kernel() to avoid
LASS violations. To let EFI modify CR4 during boot, CR pinning
enforcement is deferred until late_initcall().

Exception handling
------------------
With LASS enabled, NULL pointer dereferences generate a #GP instead of a
#PF. Due to the limited error information available during #GP, some of
the helpful hints would no longer be printed. The patches enchance the
#GP address decoding logic to identify LASS violations and NULL pointer
exceptions.

For example, two invalid userspace accesses would generate:
#PF (without LASS):
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  BUG: unable to handle page fault for address: 0000000000100000

#GP (with LASS):
  Oops: general protection fault, kernel NULL pointer dereference 0x0: 0000
  Oops: general protection fault, probably LASS violation for address 0x100000: 0000

Similar debug hints are added for the #SS handling as well.

Userspace accesses
------------------
Userspace attempts to access any kernel address generate a #GP when LASS
is enabled. Unfortunately, legacy vsyscall functions are located in the
address range 0xffffffffff600000 - 0xffffffffff601000. Prior to LASS,
default access (XONLY) to the vsyscall page would generate a page fault
and the access would be emulated in the kernel. To avoid breaking user
applications when LASS is enabled, the patches extend vsyscall emulation
in XONLY mode to the #GP handler.

In contrast, the vsyscall EMULATE mode is deprecated and not expected to
be used by anyone. Supporting EMULATE mode with LASS would require
complex instruction decoding in the #GP fault handler, which is probably
not worth the effort. For now, LASS is disabled in the rare case when
someone absolutely needs to enable vsyscall=emulate via the command
line.

Links
-----
[1]: "Linear-Address Pre-Processing", Intel SDM (June 2025), Vol 3, Chapter 4.
[2]: "Practical Timing Side Channel Attacks against Kernel Space ASLR", https://www.ieee-security.org/TC/SP2013/papers/4977a191.pdf
[3]: "Prefetch Side-Channel Attacks: Bypassing SMAP and Kernel ASLR", http://doi.acm.org/10.1145/2976749.2978356
[4]: "Harmful prefetch on Intel", https://ioactive.com/harmful-prefetch-on-intel/ (H/T Anders)
[5]: "Spectre LAM", https://download.vusec.net/papers/slam_sp24.pdf


Alexander Shishkin (2):
  x86/efi: Disable LASS while mapping the EFI runtime services
  x86/traps: Communicate a LASS violation in #GP message

Kirill A. Shutemov (2):
  x86/traps: Generalize #GP address decode and hint code
  x86/traps: Provide additional hints for a kernel stack segment fault

Peter Zijlstra (Intel) (1):
  x86/asm: Introduce inline memcpy and memset

Sohil Mehta (9):
  x86/cpu: Enumerate the LASS feature bits
  x86/alternatives: Disable LASS when patching kernel alternatives
  x86/cpu: Defer CR pinning enforcement until late_initcall()
  x86/kexec: Disable LASS during relocate kernel
  x86/vsyscall: Reorganize the page fault emulation code
  x86/traps: Consolidate user fixups in exc_general_protection()
  x86/vsyscall: Add vsyscall emulation for #GP
  x86/vsyscall: Disable LASS if vsyscall mode is set to EMULATE
  x86/cpu: Enable LASS by default during CPU initialization

Yian Chen (1):
  x86/cpu: Set LASS CR4 bit as pinning sensitive

 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/Kconfig.cpufeatures                  |   4 +
 arch/x86/entry/vsyscall/vsyscall_64.c         |  83 +++++++-----
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/smap.h                   |  35 ++++-
 arch/x86/include/asm/string.h                 |  26 ++++
 arch/x86/include/asm/vsyscall.h               |  13 +-
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/kernel/alternative.c                 |  18 ++-
 arch/x86/kernel/cpu/common.c                  |  30 ++--
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/dumpstack.c                   |   6 +-
 arch/x86/kernel/relocate_kernel_64.S          |   7 +-
 arch/x86/kernel/traps.c                       | 128 +++++++++++++-----
 arch/x86/kernel/umip.c                        |   3 +
 arch/x86/mm/fault.c                           |   2 +-
 arch/x86/platform/efi/efi.c                   |  14 +-
 17 files changed, 284 insertions(+), 93 deletions(-)


base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
-- 
2.43.0


