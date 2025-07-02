Return-Path: <linux-efi+bounces-4085-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0679AF1171
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 12:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DAC3B0FD4
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404782522A4;
	Wed,  2 Jul 2025 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eLA8VYQu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660478F5D;
	Wed,  2 Jul 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451445; cv=none; b=Xuo9cCNfiRujCiIWipGR7P+TK+spnO7Rd/HgHESUqkFPVZAatZ1m8OABsqWxQhyHy0yoI8FIibOe3QJ4nALXiIIu12QDj038py3MFYoOzOq4+FOQrxYxnI+aJKMHIOzuzo/GWZrERsjSisHcLoBkcWShMZhbv3l/8u5FieUOZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451445; c=relaxed/simple;
	bh=0vykiB83G9vcIlf4hVyInQxt2iop2prV08IcMSSFKbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmfvSPrBedoimbAI3a2bPQAIY5lt4K2+Jld8RKmXSiJt8jmFYExR9pU7aBsegF+qaVW5qAC5rDSwqdp8nZniovfb9uljDqUV780dqXMY3RQlMg8gZL4WCxyP+yIxHY1isHj2ZLtB4kmHR3vEZ1RfpvO50nVb1Ci8u23LCGbwriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eLA8VYQu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751451443; x=1782987443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vykiB83G9vcIlf4hVyInQxt2iop2prV08IcMSSFKbA=;
  b=eLA8VYQukU9Jdh6lAWURn/6PevgvYymidlVkAcHe72kafPYeXZMSp02F
   e86T/ydwSKUGRXFdK1uMggO7PrvpVrLxfnyY58R7LAhZfVJxmKyjTBfAU
   xLesN8E165BGnMr/ha2tJ4qXdCZrVQ5qC7RZoa5EUP/odPTg/d0hzf1MR
   aGW7OuFQC38TwhTEkCXxxSsmffHLAZLf543gjiz/pJARm5bi7FqF/vUE/
   erOm0gAq1paiL6m8vtKF5AyV+j6q6tH6ffDfSYJ8osaTuRJuOuQZASykA
   CKqF11cc6Yr5MYwxMCO7hjvG0+7HLyF21314LPSAvaoVZvG/1a2J/KEsP
   A==;
X-CSE-ConnectionGUID: 1WKmC+AoR6+7YaDlYwDYKA==
X-CSE-MsgGUID: Iyd4lCF3Ri+Dq3S/FyYiWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71166790"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="71166790"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 03:17:22 -0700
X-CSE-ConnectionGUID: H0AE6E4lRXKuG3TgVZexbw==
X-CSE-MsgGUID: +FtBcl7SSGuSI820sqPDbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153491981"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 02 Jul 2025 03:17:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 1298D1E0; Wed, 02 Jul 2025 13:17:10 +0300 (EEST)
Date: Wed, 2 Jul 2025 13:17:10 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, 
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Breno Leitao <leitao@debian.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
Message-ID: <5q2zbkzyjknusd3feqolycqialetqfe52yfyzasnr6zp24pmej@4cg2r2hi4pf2>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DE45AFD-C1E0-4FB8-BE01-44A72C5C6E1E@zytor.com>

On Tue, Jul 01, 2025 at 07:06:10PM -0700, H. Peter Anvin wrote:
> On July 1, 2025 6:35:40 PM PDT, Sohil Mehta <sohil.mehta@intel.com> wrote:
> >On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> >> LASS throws a #GP for any violations except for stack register accesses,
> >> in which case it throws a #SS instead. Handle this similarly to how other
> >> LASS violations are handled.
> >> 
> >
> >Maybe I've misunderstood something:
> >
> >Is the underlying assumption here that #SS were previously only
> >generated by userspace, but now they can also be generated by the
> >kernel? And we want the kernel generated #SS to behave the same as the #GP?
> >
> >> In case of FRED, before handling #SS as LASS violation, kernel has to
> >> check if there's a fixup for the exception. It can address #SS due to
> >> invalid user context on ERETU. See 5105e7687ad3 ("x86/fred: Fixup
> >> fault on ERETU by jumping to fred_entrypoint_user") for more details.
> >> 
> >> Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >> ---
> >>  arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
> >>  1 file changed, 33 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> >> index ceb091f17a5b..f9ca5b911141 100644
> >> --- a/arch/x86/kernel/traps.c
> >> +++ b/arch/x86/kernel/traps.c
> >> @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
> >>  		      SIGBUS, 0, NULL);
> >>  }
> >>  
> >> -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> >> -{
> >> -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> >> -		      0, NULL);
> >> -}
> >> -
> >>  DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
> >>  {
> >>  	char *str = "alignment check";
> >> @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> >>  	cond_local_irq_disable(regs);
> >>  }
> >>  
> >> +#define SSFSTR "stack segment fault"
> >> +
> >> +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> >> +{
> >> +	if (user_mode(regs))
> >> +		goto error_trap;
> >> +
> >> +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> >> +	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
> >> +		return;
> >> +
> >> +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> >> +		enum kernel_exc_hint hint;
> >> +		unsigned long exc_addr;
> >> +
> >> +		hint = get_kernel_exc_address(regs, &exc_addr);
> >> +		if (hint != EXC_NO_HINT) {
> >
> >The brackets are not needed for singular statements. Also the max line
> >length is longer now. You can fit this all in a single line.
> >
> >> +			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
> >> +			       exc_addr);
> >> +		}
> >> +
> >
> >> +		if (hint != EXC_NON_CANONICAL)
> >> +			exc_addr = 0;
> >> +
> >> +		die_addr(SSFSTR, regs, error_code, exc_addr);
> >
> >The variable names in die_addr() should be generalized as well. They
> >seem to assume the caller to be a #GP handler.
> >
> >> +		return;
> >> +	}
> >> +
> >> +error_trap:
> >> +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> >> +		      0, NULL);
> >> +}
> >> +
> >>  static bool do_int3(struct pt_regs *regs)
> >>  {
> >>  	int res;
> >
> 
> Note: for a FRED system, ERETU can generate #SS for a non-canonical user space RSP even in the absence of LASS, so if that is not currently handled that is an active bug.

It is handled by fixup code inside do_error_trap(). We need to add
explicit fixup before LASS handling to avoid treating bad userspace RSP as
kernel LASS violation.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

