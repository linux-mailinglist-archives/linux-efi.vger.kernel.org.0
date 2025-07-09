Return-Path: <linux-efi+bounces-4236-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C77DAFE491
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6445D188A7E5
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6582877C4;
	Wed,  9 Jul 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3usV7+0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44023CE;
	Wed,  9 Jul 2025 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054723; cv=none; b=AHY0hF9ZXw4Z1HVfFi3bJe1HyFmAMmVKXN6SbCQMrn1MFYAe30f4XXPuSE1wLdOXMbkgYxDEz3NXk/nnYmVjEXWbvdXQ1fjh/aVQFbuk2KsOHBfY0opNwnTae3/+BLa6Qt9j/fINtD6jHh0TGYZZnTDDhyOT8Ns/cG32PG5tPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054723; c=relaxed/simple;
	bh=VBcLNsfeXZegl7COkVWcleDsuUcTK+n6RSJLnd/zTo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIE5d8++SvqxFAxotulzET0V+cDtTVcjhcRD7ZF4TELvFEUi2ksuMylW9uWJwu8jxq4f5eMPuc3hxjznoJBoZtAp3IGQqBUFaT7hEw28D0WyR/jvBjDxKOxy0Y1jWYZAo3hzbmSYDejuDeFIhL8HVNrAzkrMFXfoqxZpjSu26ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3usV7+0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752054721; x=1783590721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBcLNsfeXZegl7COkVWcleDsuUcTK+n6RSJLnd/zTo8=;
  b=H3usV7+0kyS64ieFckWiVYGF7Cs/conVj3vaGKi0uGzUSvdE3WG6/hJh
   Blgs+uD4B05Diic+rtPRJ6VVe8cjjQcpIi/Er0RcoU8W0TM9wqFzXSSmn
   /MctuIN+PHPKkmdkd7cNR3ys6YfIuZEiHietjQXlgTTPytvMMDOpzOKXr
   GwyVedqaCbPJh4lDH5Bzq51wOIvcV0TDxHapC/BRDpv50t25GVjQBPjRW
   IfU9eM/IeGC7zy1sJQPO1h4qmGinzJLmbH0Vc1NLzW4PQbAaMDk7oDxdj
   bhpJsM4yAHR+f2d68hv4HmAvRologA4jhWuPSOiEJ0NrUbPY/IEfs1Mz1
   A==;
X-CSE-ConnectionGUID: phrD3qKvRlWTsLBXQJ7apg==
X-CSE-MsgGUID: 5yMJfAOjS0Sb+Nvf0/7pTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76856416"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76856416"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:52:00 -0700
X-CSE-ConnectionGUID: 3utUuKnLRke5/wsgphZJPA==
X-CSE-MsgGUID: lU1aHZW8SnK6zQVMF9uggw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156061509"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 09 Jul 2025 02:51:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 75AB71B7; Wed, 09 Jul 2025 12:51:48 +0300 (EEST)
Date: Wed, 9 Jul 2025 12:51:48 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>, 
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
Subject: Re: [PATCHv9 11/16] x86/traps: Communicate a LASS violation in #GP
 message
Message-ID: <iauggare2iigoy5t4n73p2adtyk4htv4w7zp4lpgwgwxpamaud@zoi2cxzxywpf>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-12-kirill.shutemov@linux.intel.com>
 <a14155b7-65ff-4686-b6ba-a6900549864c@intel.com>
 <xy2ocwstdf44diw5p5hisjwvx467fyhm7bljz5xg72cmnhdfok@7pe3vmht6vcq>
 <CAMuHMdXpW0re633tW9MsN-+A521Xytoicd-T0L7r7PAwJ-B0+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXpW0re633tW9MsN-+A521Xytoicd-T0L7r7PAwJ-B0+Q@mail.gmail.com>

On Wed, Jul 09, 2025 at 11:36:27AM +0200, Geert Uytterhoeven wrote:
> Hi Kirill,
> 
> On Wed, 9 Jul 2025 at 11:31, Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> > On Tue, Jul 08, 2025 at 07:40:35PM -0700, Sohil Mehta wrote:
> > > > @@ -664,14 +673,23 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> > > >             return GP_NO_HINT;
> > > >
> > > >  #ifdef CONFIG_X86_64
> > >
> > > Might as well get rid of the #ifdef in C code, if possible.
> > >
> > > if (!IS_ENABLED(CONFIG_X86_64)
> > >       return GP_CANONICAL;
> > >
> > > or combine it with the next check.
> >
> > I tried this before. It triggers compiler error on 32-bit:
> >
> > arch/x86/kernel/traps.c:673:16: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
> >   673 |         if (*addr >= ~__VIRTUAL_MASK)
> >       |                       ^~~~~~~~~~~~~~
> >
> > __VIRTUAL_MASK is not usable on 32-bit configs.
> 
> arch/x86/include/asm/page_32_types.h:#define __VIRTUAL_MASK_SHIFT       32
> arch/x86/include/asm/page_32_types.h:#define __VIRTUAL_MASK_SHIFT       32
> arch/x86/include/asm/page_64_types.h:#define __VIRTUAL_MASK_SHIFT
>  (pgtable_l5_enabled() ? 56 : 47)
> arch/x86/include/asm/page_types.h:#define __VIRTUAL_MASK
>  ((1UL << __VIRTUAL_MASK_SHIFT) - 1)
> 
> Given __VIRTUAL_MASK_SHIFT is 32 on 32-bit platforms, perhaps
> __VIRTUAL_MASK should just be changed to shift 1ULL instead?
> Or better, use GENMASK(__VIRTUAL_MASK_SHIFT - 1, 0), so the
> resulting type is still unsigned long.

Making __VIRTUAL_MASK unsigned long long is no-go. Virtual address are
unsigned long. I guess GENMASK() would work.

I think re-defining __VIRTUAL_MASK is out-of-scope for the patchset. Feel
free to prepare a separate patch to do it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

