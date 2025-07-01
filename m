Return-Path: <linux-efi+bounces-4058-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DEAEF419
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 11:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 242CB7AAFD7
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F9271445;
	Tue,  1 Jul 2025 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g9i26QlW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF326FDA5;
	Tue,  1 Jul 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751363949; cv=none; b=MP7CJuudvSUIF6lbLP+UQrhKt74Zbx7vWxN0pNdTXS28W6P/TeHoy8YZRBt4x9YM7EDZPGbp/MuYAK1+dpogOcf0O4yPleBe4su6fnyMS3ACgIeYgMey8Stv5HnrebFkFdskosLO9Igmsl0i5Ds57holQRpVJwGWSEEic8z2Lg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751363949; c=relaxed/simple;
	bh=ekzcPZ17l6tiTDUnLptg8QAgCN1RW/rzkNjm2MQYqV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwRcEB792Q4JpJs1xlM9qKbEzKU64SNkNAi9J4JmL0WXUVV3DqwBpUJ5U2L6hu4Q5Bi/WeNh4WBP4dlrchqnyKEJN8ZUBcaWR/PvZAmyZcdtsAGsqY8WyIGU9Lrwo8fiOjcPdylhwoKUo7HVfknZ4FP9UC2gg0TiTM5dQsKyHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g9i26QlW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751363948; x=1782899948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ekzcPZ17l6tiTDUnLptg8QAgCN1RW/rzkNjm2MQYqV0=;
  b=g9i26QlWnsAaTdBcOe45agu+ovkCnSug/mRAouhVHP+wERmbddsLoOVc
   xo7J/wyXJN8CMny1a56/5WeGZ47bD9gd8RvJTXWBu1ZqpipQfPpp0X7du
   YkCRqlVAkSpWLSnjUqLQuKti8hRg06rkI81O8NxRpxJzKjzipiJFOEqMt
   +PtdV7W1JZswbzD/3a8CXjzP/MzjUsbb35Cud99gf8wc8jjarvj3zDU6O
   EdErFzw7/jmm52caRW9ei09OGiBHYjvTeDx6TuhJ+LLw0/y4N/1cWu4HD
   O1Dj9tAlT8JrqyPADVn8sQEyVnkZfvS88PjXryYvELPdNeakp98Bfwtz4
   Q==;
X-CSE-ConnectionGUID: 8KIVpDO5S9uOCL2bRVl7eA==
X-CSE-MsgGUID: JZ4MImNJRjqZI4jvxa3WNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71048611"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71048611"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 02:59:03 -0700
X-CSE-ConnectionGUID: PralPGiSRGO+LtGVHx4YYw==
X-CSE-MsgGUID: D+u9WzxhRAm8KSQOS0qS6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177390795"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 01 Jul 2025 02:58:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 11EE915B; Tue, 01 Jul 2025 12:58:49 +0300 (EEST)
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
	linux-mm@kvack.org
Subject: [PATCHv8 00/17] x86: Enable Linear Address Space Separation support
Date: Tue,  1 Jul 2025 12:58:29 +0300
Message-ID: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Had it been available, LASS alone would have mitigated Meltdown. (Hindsight is
20/20 :)

In addition, LASS prevents an attack vector described in a Spectre LAM (SLAM)
whitepaper [7].

LASS enforcement relies on the typical kernel implementation to divide the
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
instruction decoding in the #GP fault handler and is probably not worth the
hassle. Disable LASS in this rare case when someone absolutely needs and
enables vsyscall=emulate via the command line.

Changes from v7[11]:
- Fix __inline_memset();
- Rename lass_disable/enable_enforcement() back to to lass_clac/stac()
- Generalize #GP address decode and hint code. Rename stuff to be
  non-GP-centric;
- Update commit messages and comments;

Changes from v6[10]:
- Rewrok #SS handler to work properly on FRED;
- Do not require X86_PF_INSTR to emulate vsyscall;
- Move lass_clac()/stac() definition to the patch where they are used;
- Rename lass_clac/stac() to lass_disable/enable_enforcement();
- Fix several build issues around inline memcpy and memset;
- Fix sparse warning;
- Adjust comments and commit messages;
- Drop "x86/efi: Move runtime service initialization to arch/x86" patch
  as it got applied;

Changes from v5[9]:
- Report LASS violation as NULL pointer dereference if the address is in the
  first page frame;
- Provide helpful error message on #SS due to LASS violation;
- Fold patch for vsyscall=emulate documentation into patch
  that disables LASS with vsyscall=emulate;
- Rewrite __inline_memeset() and __inline_memcpy();
- Adjust comments and commit messages;

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


[1] https://lore.kernel.org/lkml/20230110055204.3227669-1-yian.chen@intel.com/
[2] “Practical Timing Side Channel Attacks against Kernel Space ASLR”,
https://www.ieee-security.org/TC/SP2013/papers/4977a191.pdf
[3] “Prefetch Side-Channel Attacks: Bypassing SMAP and Kernel ASLR”, http://doi.acm.org/10.1145/2976749.2978356
[4] “Harmful prefetch on Intel”, https://ioactive.com/harmful-prefetch-on-intel/ (H/T Anders)
[5] https://lore.kernel.org/all/20230530114247.21821-1-alexander.shishkin@linux.intel.com/
[6] https://lore.kernel.org/all/20230609183632.48706-1-alexander.shishkin@linux.intel.com/
[7] https://download.vusec.net/papers/slam_sp24.pdf
[8] https://lore.kernel.org/all/20240710160655.3402786-1-alexander.shishkin@linux.intel.com/
[9] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com
[10] https://lore.kernel.org/all/20250620135325.3300848-1-kirill.shutemov@linux.intel.com/
[11] https://lore.kernel.org/all/20250625125112.3943745-1-kirill.shutemov@linux.intel.com/


Alexander Shishkin (4):
  x86/cpu: Defer CR pinning setup until after EFI initialization
  efi: Disable LASS around set_virtual_address_map() EFI call
  x86/traps: Communicate a LASS violation in #GP message
  x86/cpu: Make LAM depend on LASS

Kirill A. Shutemov (5):
  x86/asm: Introduce inline memcpy and memset
  x86/vsyscall: Do not require X86_PF_INSTR to emulate vsyscall
  x86/traps: Generalize #GP address decode and hint code
  x86/traps: Handle LASS thrown #SS
  x86: Re-enable Linear Address Masking

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

 .../admin-guide/kernel-parameters.txt         |   4 +-
 arch/x86/Kconfig                              |   1 -
 arch/x86/Kconfig.cpufeatures                  |   4 +
 arch/x86/entry/vsyscall/vsyscall_64.c         |  69 +++++++----
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/smap.h                   |  33 ++++-
 arch/x86/include/asm/string.h                 |  46 +++++++
 arch/x86/include/asm/uaccess_64.h             |  38 ++----
 arch/x86/include/asm/vsyscall.h               |  14 ++-
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/kernel/alternative.c                 |  14 ++-
 arch/x86/kernel/cpu/common.c                  |  21 ++--
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/traps.c                       | 113 ++++++++++++------
 arch/x86/kernel/umip.c                        |   3 +
 arch/x86/lib/clear_page_64.S                  |  13 +-
 arch/x86/mm/fault.c                           |   2 +-
 arch/x86/platform/efi/efi.c                   |  15 +++
 tools/arch/x86/include/asm/cpufeatures.h      |   1 +
 19 files changed, 292 insertions(+), 104 deletions(-)

-- 
2.47.2


