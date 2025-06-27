Return-Path: <linux-efi+bounces-4035-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF5AEB4FC
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A236167272
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31C296168;
	Fri, 27 Jun 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBn6+XQ0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7229898C;
	Fri, 27 Jun 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020319; cv=none; b=DYngL48tXCRkYxZemVyrkNgkSfVop4UyspkWamz5qE5ZBDa9VV8qHzrsLA8OlCAQjiZf9JFL4WBg4GGyfD1JIDaVOFKWBvkphbFs8Uga+61kC6w9dqafm/dfEI97n8C2zMSY4RnLIppb37UfJAemXRbcdb0+01Bz4Te+vutuyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020319; c=relaxed/simple;
	bh=W2Bg30qV1ZfFbZr7Wq/g5PCtFv368PERSSRJrjS6UTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJOVQyNPMyA3tCzTlmOelOkrqEIGEiPX//6o8o+cjr60U5P3syfaZXv9sAnV7LrlDuKY59JMvHA97VD0kI4POy4uNVatE5n2yeWTmrKcLkEfg13Ok3BbVfjh2DEVqvXgDxHgZxITs0pIb5Pycda7i6DuHuoY8zG/OlGeg7ZFbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBn6+XQ0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751020318; x=1782556318;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W2Bg30qV1ZfFbZr7Wq/g5PCtFv368PERSSRJrjS6UTk=;
  b=XBn6+XQ0we69PWQLYggoBPGIO1Ag0H3WPj0ge3oMoSb0lzJxI1iHgrvj
   4K4Xt7dkENbAanSJNIwIFJolGqk3u6J7SDchxy51+G62l0S6YYveigFO5
   itOXZGlpJz5jYAg1QaQBdEKWNeZ5tj+Pgsp3Z/RTKwpa0/CNThAHLnJEG
   OuboCkRArHZkeX1NlCxP2weoVmV2dCZPnMKDSUfnxZ685U+EgB3IrQ7x4
   5GDn6ZlLf25LynS40IjRX+J2eVHwDR1i8PVNza6vsj/w0EM47gAJWu4lo
   fFIZjpLSvqHjxBk73wr/tKTd0cMYxMFYJOIVkCXHEO+zUi5muvGAo32eN
   A==;
X-CSE-ConnectionGUID: 7pX/i8XGRnqSTNQKMf5a3Q==
X-CSE-MsgGUID: 0/hFG1OnT7yo2QCEgERjxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53273433"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53273433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:31:57 -0700
X-CSE-ConnectionGUID: mSOf9phKQ8mXRoDpmTh3ng==
X-CSE-MsgGUID: j0xk4bnTShW880YXbbD4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="156817812"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2025 03:31:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A0FEA6A; Fri, 27 Jun 2025 13:31:44 +0300 (EEST)
Date: Fri, 27 Jun 2025 13:31:44 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Xin Li <xin@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Xiongwei Song <xiongwei.song@windriver.com>, Xin Li <xin3.li@intel.com>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Tony Luck <tony.luck@intel.com>, 
	Alexey Kardashevskiy <aik@amd.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCHv7 13/16] x86/traps: Handle LASS thrown #SS
Message-ID: <lvutnc4et6r4a5eayoweb5butpspvop2m2pjioiudjwa3mkpo7@drcsdchj66w5>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-15-kirill.shutemov@linux.intel.com>
 <c704ea9a-8c73-46c2-80d1-f7b93a221908@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c704ea9a-8c73-46c2-80d1-f7b93a221908@zytor.com>

On Thu, Jun 26, 2025 at 10:57:47AM -0700, Xin Li wrote:
> On 6/25/2025 5:51 AM, Kirill A. Shutemov wrote:
> > LASS throws a #GP for any violations except for stack register accesses,
> > in which case it throws a #SS instead. Handle this similarly to how other
> > LASS violations are handled.
> > 
> > In case of FRED, before handling #SS as LASS violation, kernel has to
> > check if there's a fixup for the exception. It can address #SS due to
> > invalid user context on ERETU[1]. See 5105e7687ad3 ("x86/fred: Fixup
> 
> Forgot to put the link to [1]?  Maybe just remove "[1]"?

I will add the link. It is important context.

> > fault on ERETU by jumping to fred_entrypoint_user") for more details.
> > 
> > Co-developed-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >   arch/x86/kernel/traps.c | 39 +++++++++++++++++++++++++++++++++------
> >   1 file changed, 33 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index e2ad760b17ea..f1f92e1ba524 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -418,12 +418,6 @@ DEFINE_IDTENTRY_ERRORCODE(exc_segment_not_present)
> >   		      SIGBUS, 0, NULL);
> >   }
> > -DEFINE_IDTENTRY_ERRORCODE(exc_stack_segment)
> > -{
> > -	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> > -		      0, NULL);
> > -}
> > -
> >   DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
> >   {
> >   	char *str = "alignment check";
> > @@ -866,6 +860,39 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> >   	cond_local_irq_disable(regs);
> >   }
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
> 
> Thanks for making the change for FRED.
> 
> > +	if (cpu_feature_enabled(X86_FEATURE_LASS)) {
> > +		enum kernel_gp_hint hint;
> > +		unsigned long gp_addr;
> > +
> > +		hint = get_kernel_gp_address(regs, &gp_addr);
> > +		if (hint != GP_NO_HINT) {
> > +			printk(SSFSTR ", %s 0x%lx", kernel_gp_hint_help[hint],
> > +			       gp_addr);
> > +		}
> > +
> > +		if (hint != GP_NON_CANONICAL)
> > +			gp_addr = 0;
> 
> Nit: GP/gp don't seem fit here, maybe we need a more generic name?
> 
> Sorry I don't have a recommendation.

Naming is hard.

Maybe get_kernel_exc_address()/kernel_exc_hint_help/EXC_NO_HINT/... ?

> > +
> > +		die_addr(SSFSTR, regs, error_code, gp_addr);
> > +		return;
> > +	}
> > +
> > +error_trap:
> > +	do_error_trap(regs, error_code, "stack segment", X86_TRAP_SS, SIGBUS,
> > +		0, NULL);
> 
> The indentation has changed; I believe the original formatting is
> preferable.
> 
> > +}
> > +
> >   static bool do_int3(struct pt_regs *regs)
> >   {
> >   	int res;
> 
> Just minor comments, so
> 
> Reviewed-by: Xin Li (Intel) <xin@zytor.com>

Thanks.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

