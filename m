Return-Path: <linux-efi+bounces-5238-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E516C1D5AD
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 22:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A72B934D28C
	for <lists+linux-efi@lfdr.de>; Wed, 29 Oct 2025 21:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9653164C8;
	Wed, 29 Oct 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTvBuLCJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B134314B87;
	Wed, 29 Oct 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771973; cv=none; b=kfBH07ZlcNe6goK7xqEl4yx2aIKwxK1yCXawBfV5E7+LFN2qE/u4IJ35QzTDsx0ifVtDaVxBTkKCppGh5w/1C3QaEVHmjdMuQgBTZTNVhLgb1+X+gQO3JG6eaIw2hny0biXM+SqCnbI4nLfo1IdvKTS6KBfUAbtXYH0X5ZvGw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771973; c=relaxed/simple;
	bh=qQNKKvTJj54d08BnHKyPDp2BtpxkJ+XhSao+23l/MrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fU3YowdCu02wHmZY978mwmCgLPiFdRsUIL9o6rzQpLmRRyNSroP6gQyVU5u+Lie0wwTgGKvjjr+VtlBpbP2+w8DFXUyhDICPb7YlXxmacvbiHsj7Vh4jxuCqZSlbYr1D0OrVf2WuU1/qgwoN0sjz4H8DjQr++NIZb05pPqLu86M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTvBuLCJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761771972; x=1793307972;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qQNKKvTJj54d08BnHKyPDp2BtpxkJ+XhSao+23l/MrQ=;
  b=QTvBuLCJ/iVVdR5blkb1xtcRnPFKnPxnQ25VnnsOmD5z42CrzTS4lBtI
   qmH2s+9SoJta02EJ/LGCWaUYNH1M8oKl6Ld/Oyo1XfNN4sH/gudwBhfy9
   7JyKTLAW9/jBiCjWfSP5pggr+gk17tA3xUd5efZkZlrzWvwhky/VmFrb2
   GEWrDsuILfYYYscB/1CDRaL3HgCacnQgmqrub6z1rfJ5puaQfb4jrkn9h
   2hfAP+BfrXC16scOnZEybQFhQssg4rOcd+nADWlOjRfAQTvEO9hGgergn
   WH7pH40Rgei//2EhVbAm6yqG72bkyM7zLwqF2b90bHiZE5eviusfKlLbP
   Q==;
X-CSE-ConnectionGUID: S1blfGW/TRSJZ0ptt7P9nw==
X-CSE-MsgGUID: Jd5oUUUOSD+aAvtiwDUXmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="64002733"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="64002733"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 14:06:11 -0700
X-CSE-ConnectionGUID: leUg9xxIS223DJDVpb5Ikg==
X-CSE-MsgGUID: Vb8EM9x9RZKhujg73lyq8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216431966"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa002.jf.intel.com with ESMTP; 29 Oct 2025 14:06:10 -0700
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
Subject: [PATCH v11 0/9] x86: Enable Linear Address Space Separation support
Date: Wed, 29 Oct 2025 14:03:01 -0700
Message-ID: <20251029210310.1155449-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v11
--------------
Based on internal suggestions, I significantly trimmed down the series
to make reviewing and merging easier. It still has all the essential
changes to enable the base LASS support.

Improvements:
 - Separate out a patch to explain LASS dependency on SMAP (patch 2)
 - Use lass_disable/enable() instead of lass_stac()/clac() (patch 4)
 - New patch to fix a vsyscall selftest that expects a #PF (patch 8)
 - Solidify commit logs and code comments

Removals:
 - Vsyscall emulation: Legacy vsyscalls aren't required in newer
   environments. For now, LASS is only enabled when vsyscall emulation
   support is absent.

 - CR pinning: Pinning CR4.LASS isn't strictly necessary because it
   only mitigates speculative attacks beyond SMAP. The only benefit
   would be to get a warning if LASS is accidently disabled.

 - #SS LASS hints: Kernel stack segment faults are very rare. Also, in
   most cases, the faulting instruction is unlikely to have a memory
   operand. There isn't any compelling reason to add LASS hints for
   these right now.

Dropping the non-essential patches reduces the patch count and code
changes by ~50%. I am planning to pursue these later after the base
series has merged.

Important changes in v10
------------------------
 - Use the simplified versions of inline memcpy/memset    (patch 3)
 - New patch to fix an issue during Kexec relocate kernel (patch 6)

v10: https://lore.kernel.org/lkml/20251007065119.148605-1-sohil.mehta@intel.com/

Patch structure
---------------
Patch   1-2: Enumerate LASS and its dependency on SMAP
Patch   3-4: Update text poking
Patch   5-6: Update EFI and kexec flows
Patch   7-8: Expecting a #GP instead of #PF
Patch     9: Enable LASS (without Vsyscall)

Please consider providing review tags/acks for patches that seem ready.

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
LASS violations.

Exception handling
------------------
With LASS enabled, NULL pointer dereferences generate a #GP instead of a
#PF. Due to the limited error information available during #GP, some of
the helpful hints would no longer be printed. The patches enchance the
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
compiled in. Though this limits the initial LASS deployment, it makes
the merge considerably easier.

In future, the restriction can be relaxed by extending the emulation in
XONLY mode to the #GP handler.

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

Peter Zijlstra (Intel) (1):
  x86/asm: Introduce inline memcpy and memset

Sohil Mehta (6):
  x86/cpufeatures: Enumerate the LASS feature bits
  x86/cpu: Add an LASS dependency on SMAP
  x86/alternatives: Disable LASS when patching kernel code
  x86/kexec: Disable LASS during relocate kernel
  selftests/x86: Update the negative vsyscall tests to expect a #GP
  x86/cpu: Enable LASS by default during CPU initialization

 arch/x86/Kconfig.cpufeatures                |  4 ++
 arch/x86/include/asm/cpufeatures.h          |  1 +
 arch/x86/include/asm/smap.h                 | 41 ++++++++++++++++++-
 arch/x86/include/asm/string.h               | 26 ++++++++++++
 arch/x86/include/uapi/asm/processor-flags.h |  2 +
 arch/x86/kernel/alternative.c               | 18 ++++++++-
 arch/x86/kernel/cpu/common.c                | 21 +++++++++-
 arch/x86/kernel/cpu/cpuid-deps.c            |  1 +
 arch/x86/kernel/relocate_kernel_64.S        |  7 +++-
 arch/x86/kernel/traps.c                     | 45 +++++++++++++++------
 arch/x86/platform/efi/efi.c                 | 14 ++++++-
 tools/testing/selftests/x86/test_vsyscall.c | 21 +++++-----
 12 files changed, 172 insertions(+), 29 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.43.0


