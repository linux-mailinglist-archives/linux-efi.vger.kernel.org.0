Return-Path: <linux-efi+bounces-4086-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04140AF594E
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BDE16834F
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 13:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5182853F6;
	Wed,  2 Jul 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f4+l0rfv"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA32727E2;
	Wed,  2 Jul 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462893; cv=none; b=eI0DQ2xJO96Li3sm91ji9xoXaamW/IiwGCJT6Plh1pGEyAbw1YMNuvIjc1kB3VbeUj/Eay2acQGxOTpcNvHPY10PhOcGBV2IZu/FtUX+N+XjhS9ewr0Ry8zjQjFwgUgJlXc5/86kiE1tH6bCyYyhgeb3YI9hyLutv0tosmA3siw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462893; c=relaxed/simple;
	bh=bPtWi2+/IrDUn+HheU/a56H/VJ+K3+rY5j0OYCr0awQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdoNcEUZO44nI9vvi0SMYN0RKJ6e/V90QX94/zARoeZMPRiH7/rQV7h0vwx/2AfBx/p1YnvQNGLjB21Ki9v+sjs2MhSp/glks82NklCi9OlMme9TYi9A7RBdw7zEIN4z6HhOoKin4SPfBuG/ehNZIloFoW33dnrchJ5tW3/Gr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f4+l0rfv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751462892; x=1782998892;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bPtWi2+/IrDUn+HheU/a56H/VJ+K3+rY5j0OYCr0awQ=;
  b=f4+l0rfvQ+JlO9BBMZPuBofIXKO6q720+leQN/UJ+pSb9lVW1zCvAb1c
   oUzzlnJoMtbsPpMcY+6/uInA64g4ALUSBc5k7FHGPfD49Rb79QTM94LKi
   8tStYiAMNrKAdUxQjtHE65XlphYNYjLggENuij+ZNAshZHMYchxRCt2d+
   SJ4nFFoa08q98KhxYO+cK/LoW+s1xSuYcppD2Ymlg5lNYnTaVimFDahZs
   cdt3CSYEUihw/RVJzP7t5i+5P1oTn7MxJi5E+FB2u6u232faLsb7P0CKZ
   D98OdKBFbHialmNwTNeHz3YK6gETogzafaxFT/u2eIDyADqv7Bf5Ft2Yx
   A==;
X-CSE-ConnectionGUID: wiRE/g8hS8u6YDJaMRWj1A==
X-CSE-MsgGUID: DTP+Ge8sTc66+UJ9yY2WBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53898825"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53898825"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 06:28:11 -0700
X-CSE-ConnectionGUID: ZOBRGeyiRYmGwYNxtTi/IQ==
X-CSE-MsgGUID: qgnJ4L6UQQqKVMLd5kpaVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="191244914"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2025 06:27:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9A4071E0; Wed, 02 Jul 2025 16:27:55 +0300 (EEST)
Date: Wed, 2 Jul 2025 16:27:55 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@kernel.org>, 
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
Message-ID: <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>

On Tue, Jul 01, 2025 at 06:35:40PM -0700, Sohil Mehta wrote:
> On 7/1/2025 2:58 AM, Kirill A. Shutemov wrote:
> > LASS throws a #GP for any violations except for stack register accesses,
> > in which case it throws a #SS instead. Handle this similarly to how other
> > LASS violations are handled.
> > 
> 
> Maybe I've misunderstood something:
> 
> Is the underlying assumption here that #SS were previously only
> generated by userspace, but now they can also be generated by the
> kernel? And we want the kernel generated #SS to behave the same as the #GP?

It can be generated by both kernel and userspace if RSP gets corrupted.

So far, do_error_trap() did the trick, handling what has to be handled.
LASS requires a bit more, though.

> 
> > In case of FRED, before handling #SS as LASS violation, kernel has to
> > check if there's a fixup for the exception. It can address #SS due to
> > invalid user context on ERETU. See 5105e7687ad3 ("x86/fred: Fixup
> > fault on ERETU by jumping to fred_entrypoint_user") for more details.
> > 
> > Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index ceb091f17a5b..f9ca5b911141 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
> >  		      SIGBUS, 0, NULL);
> >  }
> >  
> > -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> > -{
> > -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> > -		      0, NULL);
> > -}
> > -
> >  DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
> >  {
> >  	char *str = "alignment check";
> > @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> >  	cond_local_irq_disable(regs);
> >  }
> >  
> > +#define SSFSTR "stack segment fault"
> > +
> > +DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> > +{
> > +	if (user_mode(regs))
> > +		goto error_trap;
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_FRED) &&
> > +	    fixup_exception(regs, X86_TRAP_SS, error_code, 0))
> > +		return;
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> > +		enum kernel_exc_hint hint;
> > +		unsigned long exc_addr;
> > +
> > +		hint = get_kernel_exc_address(regs, &exc_addr);
> > +		if (hint != EXC_NO_HINT) {
> 
> The brackets are not needed for singular statements. Also the max line
> length is longer now. You can fit this all in a single line.

I think line split if justified. It is 120 characters long otherwise.
And with multi-line statement, brackets help readability.

I don't see a reason to change it.

> > +			printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint],
> > +			       exc_addr);
> > +		}
> > +
> 
> > +		if (hint != EXC_NON_CANONICAL)
> > +			exc_addr = 0;
> > +
> > +		die_addr(SSFSTR, regs, error_code, exc_addr);
> 
> The variable names in die_addr() should be generalized as well. They
> seem to assume the caller to be a #GP handler.

Okay, will fold into "x86/traps: Generalize #GP address decode and hint
code".

> > +		return;
> > +	}
> > +
> > +error_trap:
> > +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> > +		      0, NULL);
> > +}
> > +
> >  static bool do_int3(struct pt_regs *regs)
> >  {
> >  	int res;
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

