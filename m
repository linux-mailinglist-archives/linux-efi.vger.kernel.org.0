Return-Path: <linux-efi+bounces-5496-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036AC5A627
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 23:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B24E36D1
	for <lists+linux-efi@lfdr.de>; Thu, 13 Nov 2025 22:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C3132695B;
	Thu, 13 Nov 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CebujJTe"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8632694A;
	Thu, 13 Nov 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073919; cv=none; b=aLnI4Qe3MYze+zqy5KKUA33mPb4L8NCAhQMaLiopwweSX5yFI8w+DFXL+m8JJWmLYXGavlemgVqsBeVs2X4dOGl+vm3w1gJ7zW6MOHWx0ajaobspkEFqY4I6BKJbVCM99ORc9YQ1zCq5btVulw7vA9TNl4BNr2/J6KB1OUz3Kek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073919; c=relaxed/simple;
	bh=cNXoD6AoP2S5NSSJzga2JA0E1MplOk2vvAaQvSyenY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTMZajtbWk+TyeGQKaHQS+qENCrOd36+OgZVOG7UxKK0QxhvaS3Rf97ZPt3cZgSigsQr/87iGGnIkvMJ0k9t0aC2LRXKO2N+FJ1OcBkxXeieuMKOJ6VChxJREsukh+UKXlz+ppuDJtJNTSymis7KUGHsEh5ecwUALEblW4X8Py8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CebujJTe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763073917; x=1794609917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cNXoD6AoP2S5NSSJzga2JA0E1MplOk2vvAaQvSyenY0=;
  b=CebujJTePBuk7cZtZYzfm6vkqv8zSddnc4/321nNlOont/maGzqAKPOs
   3gFHdZJPMzTWhBKfLsbP3epdtXcoRgNPwkRyz9WuI7OqOhkgtwGohegGd
   9PxXx5wyeusaXxV7EWuNrK6p41lpwFhM+XlVmqSRS7iolke8KMEA85e92
   w3HJdIUozAQ4uDjq03Qq5tPjsNDVHUOg6/5eoWFSTD6mInle5gA5Y54Vw
   x/X6ek91pGCcpfjOhUdf+DH3MTRvoGKM1OIFd9ZBocoiMggyFzUxY6C5n
   sF08auWxoG0f7ws5kyfIxSw7ljzhKdtb9fSfR+dbIFwMx9+MnzLUhOuO8
   w==;
X-CSE-ConnectionGUID: dGNuY1kHT72WGknda6spKA==
X-CSE-MsgGUID: 7pPou/BkSdWaorYnzsoHcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65051887"
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="65051887"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 14:45:16 -0800
X-CSE-ConnectionGUID: 2tbCkxHMQk63eocW1h3DcA==
X-CSE-MsgGUID: +6jxSAM7T9K0w1vk+D4qkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,303,1754982000"; 
   d="scan'208";a="194611076"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa004.fm.intel.com with ESMTP; 13 Nov 2025 14:45:15 -0800
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
Subject: [PATCH v12 0/8] x86: Enable base Linear Address Space Separation support
Date: Thu, 13 Nov 2025 14:41:56 -0800
Message-ID: <20251113224204.50391-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the simplified trimmed-down approach from v11.
Overall, I think the patches are ready for merging.

Changes in v12
--------------
 - Dropped the EFI toggle during SetVirtualAddressMap().
 - Disable LASS if the EFI support is needed.              (patch 8)
 - Use lass_stac()/lass_clac() naming for AC bit toggling. (patch 4)

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
 arch/x86/include/asm/smap.h                 | 41 ++++++++++++++++++-
 arch/x86/include/asm/string.h               | 26 ++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h |  2 +
 arch/x86/kernel/alternative.c               | 18 ++++++++-
 arch/x86/kernel/cpu/common.c                | 24 ++++++++++-
 arch/x86/kernel/cpu/cpuid-deps.c            |  1 +
 arch/x86/kernel/relocate_kernel_64.S        |  7 +++-
 arch/x86/kernel/traps.c                     | 45 +++++++++++++++------
 tools/testing/selftests/x86/test_vsyscall.c | 21 +++++-----
 11 files changed, 162 insertions(+), 28 deletions(-)


base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
-- 
2.43.0


