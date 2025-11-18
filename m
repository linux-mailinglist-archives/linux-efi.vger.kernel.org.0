Return-Path: <linux-efi+bounces-5598-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB018C6B39D
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 9DA5228E68
	for <lists+linux-efi@lfdr.de>; Tue, 18 Nov 2025 18:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F385C2D94A8;
	Tue, 18 Nov 2025 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6gbW1vh"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84F92D595D;
	Tue, 18 Nov 2025 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490876; cv=none; b=pqKjPU3ByMOkMBbtQFq7Ll+V3seNeNzMTQZmEvR/4YIHEFqc49VbBrrHUBnmfOdotLO7LCAGGK9gRzXMn7O3djOOkHtHpvF1UCGoAqxUYHj8F4Havz01EAehiuGCjt8L7qKlvuBypck2BiYpAmYUYl+jclAm7CxEAPXIa6+A+Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490876; c=relaxed/simple;
	bh=P9becUI1J1c5fBdmNViCGb5p31reB9ynSA9EPLcqf58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq5OSdQGw/c1xDJvUrd7+II67JfZTVdYk0k2lXs/MWitTiVFXxU+gasyt4fxPUiboKBx7zqBb9yKNbh4bZ2yBSTPXsIVV0Y8dnsp6zRH62QxtisFREzWDgj9lY8iokVQhYq0ilPqte3XVbwuSSh1K4P+fv6Wx5q3ggz5pDhE6TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6gbW1vh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490874; x=1795026874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P9becUI1J1c5fBdmNViCGb5p31reB9ynSA9EPLcqf58=;
  b=i6gbW1vh2Bjw5P02AFPTEUFOnDtKHQO2oS9iU23HdJ9AG06BPlDzrE3b
   h9kxsILboPUVW8I3sEQX88kXHVekYeW16p9gflkOAypcUayOqV2n324T2
   tZrvZNbNIG2lTmiyJlHm3mCn7UlFcNu5XXxI5K+3Rj3kaTtK636uqYn+d
   AuudmcxKNMeWAZiJG32FqJ9gPRt/OcPAjGFa68EiIHqcxOS6WzqR8dszC
   cRY5gV+k2kbqgHSEZ7QEpG96kEkSIfgVVi0Ndzxo09Fo/+ESLqNl2T6lQ
   MoLhHKblmWnML63YZTU1MX4C18DHW5fN2fQ1mnziU8H0luDtlx1wkXDyH
   Q==;
X-CSE-ConnectionGUID: ODK72OvPTm2LYPm90Sjs0w==
X-CSE-MsgGUID: jCxsfipoQdiloUzki50SKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76979720"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76979720"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:31:52 -0800
X-CSE-ConnectionGUID: mTwIwbOZQOCYvBoVjKdhcw==
X-CSE-MsgGUID: VGgCBirKTuWWbUQs3vKJQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190088908"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa006.jf.intel.com with ESMTP; 18 Nov 2025 10:31:52 -0800
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
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v13 0/8] x86: Enable base Linear Address Space Separation support
Date: Tue, 18 Nov 2025 10:29:02 -0800
Message-ID: <20251118182911.2983253-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v13
---
As suggested by Dave, posting a new revision to ease merging the patches
in this cycle. The only change is a NULL hint comment update. (patch 6)

Changes in v12
--------------
 - Dropped the EFI toggle during SetVirtualAddressMap().
 - Disable LASS if the EFI support is needed.              (patch 8)
 - Use lass_stac()/lass_clac() naming for AC bit toggling. (patch 4)

v12: https://lore.kernel.org/lkml/20251113224204.50391-1-sohil.mehta@intel.com/

Unsupported features (for now)
------------------------------
 - EFI support: EFI needs slightly more work because some boot services
   memory could be accessed even after ExitBootServices(). Similarly,
   some runtime services might cling to using physical addresses even
   after SetVirtualAddressMap().

   In future, we need to defer LASS enabling until EFI has completely
   finished entering virtual mode (including efi_free_boot_services()).
   Also, LASS would need to be temporarily disabled while switching to
   efi_mm to avoid potential faults on runtime accesses to the 1:1
   mapped regions.

Bits that were dropped earlier (v11):
 - Vsyscall emulation: Legacy vsyscalls aren't required in newer
   environments. For now, LASS is only enabled when vsyscall emulation
   support is absent. In future, we would reuse the existing emulation
   mechanism for #PF in the #GP handler with the vsyscall XONLY mode.

 - CR pinning: Pinning CR4.LASS isn't strictly necessary because it
   only mitigates speculative attacks beyond SMAP. The only benefit
   would be to get a warning if LASS is accidentally disabled.

 - #SS LASS hints: Kernel stack segment faults are very rare. Also, in
   most cases, the faulting instruction is unlikely to have a memory
   operand. There isn't any compelling reason to add LASS hints for
   these right now.

Dropping the non-essential pieces reduces the patch count and code
changes by ~50%. Though this limits the initial LASS deployment, it
makes merging and reviews considerably easier. We have a path forward
for vsyscalls and EFI [6]. I plan to pursue that immediately after the
base series has merged.

See the sections below or the discussions in v11 for more information.
https://lore.kernel.org/lkml/20251029210310.1155449-1-sohil.mehta@intel.com/

Patch structure
---------------
Patch   1-2: Enumerate LASS and its dependency on SMAP
Patch   3-4: Update text poking
Patch     5: Update kexec flow
Patch   6-7: Expecting a #GP instead of #PF
Patch     8: Enable LASS (without EFI and vsyscall)

Please consider applying the series or providing acks if you have been
tracking the patches.

Testing
-------
The LKDTM suite tests a variety of kernel exception paths (such as NULL
dereference or invalid user access). They can be triggered directly via
debugfs as well. The same tests can be used for generating LASS
exceptions.

Also, the vsyscall tests have been updated and cover generating user
SIGSEGVs due to LASS.

Background
----------
Linear Address Space Separation (LASS) is a security feature [1] that
works prior to page-walks to prevent a class of side-channel attacks
that rely on speculative access across the user/kernel boundary.

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
half, it can temporarily suspend LASS data access enforcement by
toggling the RFLAGS.AC bit. Most of these cases are already covered
today through the stac()/clac() pairs, which avoid SMAP violations.
However, there are kernel usages, such as text poking, that access
mappings (!_PAGE_USER) in the lower half of the address space.
LASS-specific AC bit toggling is added for these cases.

In cases where instruction fetches are done from a lower address,
toggling the AC bit is not sufficient as it only manages kernel data
accesses. So, CR4.LASS is modified during kexec relocate_kernel() to
avoid LASS violations.

Some EFI runtime and boot services may rely on 1:1 mappings in the lower
half during early boot and even after SetVirtualAddressMap(). For
example, efi_check_for_embedded_firmwares() accesses boot time data
after SVAM. For now, LASS is disabled if EFI support is compiled in.

In future, to avoid tripping LASS, the initial CR4 programming would
need to be delayed. Ideally we would delay LASS enabling until userspace
comes up. Also, we would likely toggle CR4.LASS every time while
switching to efi_mm to avoid potential faults on stray runtime accesses.
Userspace isn't mapped in efi_mm so the impact of this should be
limited. Even though the runtime accesses might be to data objects, we
can't rely on EFI to preserve the AC bit.

Exception handling
------------------
With LASS enabled, NULL pointer dereferences generate a #GP instead of a
#PF. Due to the limited error information available during #GP, some of
the helpful hints would no longer be printed. The patches enhance the
#GP address decoding logic to identify LASS violations and NULL pointer
exceptions.

For example, two invalid userspace accesses would now generate:
#PF (without LASS):
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  BUG: unable to handle page fault for address: 0000000000100000

#GP (with LASS):
  Oops: general protection fault, kernel NULL pointer dereference 0x0: 0000
  Oops: general protection fault, probably LASS violation for address 0x100000: 0000

Similar debug hints can be added for the #SS handling as well. But
running into a #SS is very rare and the complexity isn't worth it.

Userspace accesses
------------------
When LASS is enabled, userspace attempts to access any kernel address
generate a #GP instead of a #PF. A SIGSEGV is delivered to userspace in
both cases. However, the exception address present in the siginfo
structure for a #PF is absent for a #GP. This is a minor and expectedly
inconsequential change for userspace.

Legacy vsyscalls
----------------
Legacy vsyscall functions are located in the address range
0xffffffffff600000 - 0xffffffffff601000. Prior to LASS, accesses to the
vsyscall page would generate a #PF, and they would be emulated in the
#PF handler. Extending the emulation support to the #GP handler needs
complex instruction decoding and some refactoring.

Modern environments do not require legacy vsyscalls. To avoid breaking
user applications, LASS is disabled if vsyscall emulation support is
compiled in.

In case of XONLY (execute only) mode, the faulting address is readily
available in the RIP which should make it easier to reuse the #PF
emulation logic. OTOH, supporting the vsyscall full EMULATION mode
should likely be avoided because it is deprecated and would need complex
instruction decoding.

Links
-----
[1]: "Linear-Address Pre-Processing", Intel SDM (June 2025), Vol 3, Chapter 4.
[2]: "Practical Timing Side Channel Attacks against Kernel Space ASLR", https://www.ieee-security.org/TC/SP2013/papers/4977a191.pdf
[3]: "Prefetch Side-Channel Attacks: Bypassing SMAP and Kernel ASLR", http://doi.acm.org/10.1145/2976749.2978356
[4]: "Harmful prefetch on Intel", https://ioactive.com/harmful-prefetch-on-intel/ (H/T Anders)
[5]: "Spectre LAM", https://download.vusec.net/papers/slam_sp24.pdf
[6]: https://lore.kernel.org/lkml/bbb68600-eea9-45d8-90d1-bc4619186a4d@intel.com/

Alexander Shishkin (1):
  x86/traps: Communicate a LASS violation in #GP message

Peter Zijlstra (Intel) (1):
  x86/asm: Introduce inline memcpy and memset

Sohil Mehta (6):
  x86/cpufeatures: Enumerate the LASS feature bits
  x86/cpu: Add an LASS dependency on SMAP
  x86/alternatives: Disable LASS when patching kernel code
  x86/kexec: Disable LASS during relocate kernel
  selftests/x86: Update the negative vsyscall tests to expect a #GP
  x86/cpu: Enable LASS during CPU initialization

 arch/x86/Kconfig.cpufeatures                |  4 ++
 arch/x86/include/asm/cpufeatures.h          |  1 +
 arch/x86/include/asm/smap.h                 | 41 +++++++++++++++++-
 arch/x86/include/asm/string.h               | 26 ++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h |  2 +
 arch/x86/kernel/alternative.c               | 18 +++++++-
 arch/x86/kernel/cpu/common.c                | 24 ++++++++++-
 arch/x86/kernel/cpu/cpuid-deps.c            |  1 +
 arch/x86/kernel/relocate_kernel_64.S        |  7 +++-
 arch/x86/kernel/traps.c                     | 46 +++++++++++++++------
 tools/testing/selftests/x86/test_vsyscall.c | 21 ++++++----
 11 files changed, 163 insertions(+), 28 deletions(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.43.0


