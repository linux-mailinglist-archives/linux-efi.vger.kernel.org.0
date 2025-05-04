Return-Path: <linux-efi+bounces-3575-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073DFAA8698
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 15:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1417A86A7
	for <lists+linux-efi@lfdr.de>; Sun,  4 May 2025 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC71A2389;
	Sun,  4 May 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWM6Sp2s"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6A10E9;
	Sun,  4 May 2025 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746366663; cv=none; b=q64Eca1JNZ50Aj6tspFymaNwcKqkbFhiQaplbLblLLrl6cmcYoIcZkMXShsRJB3ldLb0afrmT421XRGg7UVTZiwFLd3oAkVkFLZCb8yflZCzXbjHclT5TwjBo7R5GGJd7HlombtzJX30G8orPHKU/ORfOE9uQsEF3UG/CpJSWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746366663; c=relaxed/simple;
	bh=Am8R653w6DFmXINiQmvUHC3B7/bLaoTrUH1Ub6/uprQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acnjS60K6fhdG6sT2nOs3B2r0wEcs6vTQ5LW/Vd11PsHVYYu35qk+eyamUtAlYjL8y5ohMmj/K5LbtgBOOW6PPiHEwtAAmSmZURSjcgIVniTtbh6pdxlJOwVtGTAILYI/v4JJlX/VyWUxZ7gXNsMVgCGi7+YGLkAzGIrTCdKxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWM6Sp2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71FCC4CEE7;
	Sun,  4 May 2025 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746366662;
	bh=Am8R653w6DFmXINiQmvUHC3B7/bLaoTrUH1Ub6/uprQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWM6Sp2sKubNQ44E5wVp1LjLSAtKt/eE5xUiz01P+OeI5DBNku8Bf/a3TmuZqjxm4
	 4CK4hanLqM7ISKRo1/rE6RdCULE0VcADfzjz7XLxE0++NKJ/yZ/ND54DzGlWsFZurE
	 LFItX+2yj/vt/33GH9z/USA+S4jP17gxMoXOMmaExmwJiScZYw1lRqXazTaXJLzsDj
	 at//zfctQb0qXOakjRoByKwD3CwAMOpc8JCxEENqmD327nLl7hjqJXDQsQ4ISaiVr+
	 brADojzqBck/vCUyIhS1/SHwpV2VnmzWjycdOdcEKnUTAg0VPQIdEhWzytgXFTSucW
	 2rG/3chJh2x9Q==
Date: Sun, 4 May 2025 15:50:57 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dionna Amalie Glaze <dionnaglaze@google.com>,
	Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFT PATCH v2 03/23] x86/boot: Drop global variables keeping
 track of LA57 state
Message-ID: <aBdwwR52hI37bW9a@gmail.com>
References: <20250504095230.2932860-25-ardb+git@google.com>
 <20250504095230.2932860-28-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250504095230.2932860-28-ardb+git@google.com>


* Ard Biesheuvel <ardb+git@google.com> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
> 
> On x86_64, the core kernel is entered in long mode, which implies that
> paging is enabled. This means that the CR4.LA57 control bit is
> guaranteed to be in sync with the number of paging levels used by the
> kernel, and there is no need to store this in a variable.
> 
> There is also no need to use variables for storing the calculations of
> pgdir_shift and ptrs_per_p4d, as they are easily determined on the fly.
> 
> This removes the need for two different sources of truth (i.e., early
> and late) for determining whether 5-level paging is in use: CR4.LA57
> always reflects the actual state, and never changes from the point of
> view of the 64-bit core kernel. It also removes the need for exposing
> the associated variables to the startup code. The only potential concern
> is the cost of CR4 accesses, which can be mitigated using alternatives
> patching based on feature detection.
> 
> Note that even the decompressor does not manipulate any page tables
> before updating CR4.LA57, so it can also avoid the associated global
> variables entirely. However, as it does not implement alternatives
> patching, the associated ELF sections need to be discarded.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/boot/compressed/misc.h         |  4 --
>  arch/x86/boot/compressed/pgtable_64.c   | 12 ------
>  arch/x86/boot/compressed/vmlinux.lds.S  |  1 +
>  arch/x86/boot/startup/map_kernel.c      | 12 +-----
>  arch/x86/boot/startup/sme.c             |  9 ----
>  arch/x86/include/asm/pgtable_64_types.h | 43 ++++++++++----------
>  arch/x86/kernel/cpu/common.c            |  2 -
>  arch/x86/kernel/head64.c                | 11 -----
>  arch/x86/mm/kasan_init_64.c             |  3 --
>  9 files changed, 24 insertions(+), 73 deletions(-)

So this patch breaks the build & creates header dependency hell on 
x86-64 allnoconfig:

 starship:~/tip> m kernel/pid.o 
   DESCEND objtool
   CC      arch/x86/kernel/asm-offsets.s
   INSTALL libsubcmd_headers
 In file included from ./arch/x86/include/asm/pgtable_64_types.h:5,
                 from ./arch/x86/include/asm/pgtable_types.h:283,
                 from ./arch/x86/include/asm/processor.h:21,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:59,
                 from ./include/linux/thread_info.h:60,
                 from ./include/linux/spinlock.h:60,
                 from ./include/linux/swait.h:7,
                 from ./include/linux/completion.h:12,
                 from ./include/linux/crypto.h:15,
                 from arch/x86/kernel/asm-offsets.c:9:
 ./arch/x86/include/asm/sparsemem.h:29:34: warning: "pgtable_l5_enabled" is not defined, evaluates to 0 [-Wundef]
    29 | # define MAX_PHYSMEM_BITS       (pgtable_l5_enabled() ? 52 : 46)
       |                                  ^~~~~~~~~~~~~~~~~~
 ./include/linux/page-flags-layout.h:31:26: note: in expansion of macro ‘MAX_PHYSMEM_BITS’
    31 | #define SECTIONS_SHIFT  (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)

Plus I'm not sure I'm happy about this kind of complexity getting 
embedded deep within low level MM primitives:

  static __always_inline __pure bool pgtable_l5_enabled(void)
  {
	unsigned long r;
	bool ret;

	if (!IS_ENABLED(CONFIG_X86_5LEVEL))
		return false;

	asm(ALTERNATIVE_TERNARY(
		 "movq %%cr4, %[reg] \n\t btl %[la57], %k[reg]" CC_SET(c),
		 %P[feat], "stc", "clc")
		 : [reg] "=&r" (r), CC_OUT(c) (ret)
		 : [feat] "i"  (X86_FEATURE_LA57),
		   [la57] "i"  (X86_CR4_LA57_BIT)
		 : "cc");

	return ret;
  }

it's basically everywhere:

	arch/x86/include/asm/page_64_types.h:#define __VIRTUAL_MASK_SHIFT	(pgtable_l5_enabled() ? 56 : 47)
	arch/x86/include/asm/paravirt.h:	if (pgtable_l5_enabled())						\
	arch/x86/include/asm/paravirt.h:	if (pgtable_l5_enabled())					\
	arch/x86/include/asm/pgalloc.h:	if (!pgtable_l5_enabled())
	arch/x86/include/asm/pgalloc.h:	if (!pgtable_l5_enabled())
	arch/x86/include/asm/pgalloc.h:	if (pgtable_l5_enabled())
	arch/x86/include/asm/pgtable.h:#define pgd_clear(pgd)			(pgtable_l5_enabled() ? native_pgd_clear(pgd) : 0)
	arch/x86/include/asm/pgtable.h:	if (!pgtable_l5_enabled())
	arch/x86/include/asm/pgtable.h:	if (!pgtable_l5_enabled())
	arch/x86/include/asm/pgtable.h:	if (!pgtable_l5_enabled())
	arch/x86/include/asm/pgtable.h:	if (!pgtable_l5_enabled())
	arch/x86/include/asm/pgtable_32_types.h:#define pgtable_l5_enabled() 0
	arch/x86/include/asm/pgtable_64.h:	return !pgtable_l5_enabled();
	arch/x86/include/asm/pgtable_64.h:	if (pgtable_l5_enabled() ||
	arch/x86/include/asm/pgtable_64_types.h:static __always_inline __pure bool pgtable_l5_enabled(void)
	arch/x86/include/asm/pgtable_64_types.h:#define PGDIR_SHIFT	(pgtable_l5_enabled() ? 48 : 39)
	arch/x86/include/asm/pgtable_64_types.h:#define PTRS_PER_P4D		(pgtable_l5_enabled() ? 512 : 1)
	arch/x86/include/asm/pgtable_64_types.h:# define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
	arch/x86/include/asm/sparsemem.h:# define MAX_PHYSMEM_BITS	(pgtable_l5_enabled() ? 52 : 46)

Inlined approximately a gazillion times. (449 times on x86 defconfig. 
Yes, I just counted it.)

And it's not even worth it, as it generates horrendous code:

   154:   0f 20 e0                mov    %cr4,%rax
   157:   0f ba e0 0c             bt     $0xc,%eax

... while CR4 access might be faster these days, it's certainly not as 
fast as simple percpu access. Plus it clobbers a register (RAX in the 
example above), which is unnecessary for a flag test.

Cannot pgtable_l5_enabled() be a single, simple percpu flag or so?

And yes, this creates another layer for these values - but thus 
decouples low level MM from detection & implementation complexities, 
which is a plus ...

Thanks,

	Ingo

