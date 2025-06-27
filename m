Return-Path: <linux-efi+bounces-4034-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE510AEB4BA
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DCC5633CE
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66F2C031B;
	Fri, 27 Jun 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKZLbTCJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B732BF009;
	Fri, 27 Jun 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020075; cv=none; b=LSZ/6aUyFdLhnn/LtWGncBJ0DPLiNP2hEyaQjGb+LIWOMcJx1s6vKDjqHbc72QJtdE36SeMA6yOMNmjr/3Pqly/O20qbu103qRCYpYOoK3xqBtVsGgTASFgvQjCKxJQxjr0eGkzJGjb3HIHjEluyca0igELjVbv2eMv+9V/QxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020075; c=relaxed/simple;
	bh=kERVEwZGohcYrv9h5JZQFR9MdOFRWgsOAV17tKHDXTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ+ks3+9qqv/L6A2WiraqQc8dCsysDJ3fogAo9nqcxhnZqsBaNw57bqTTo1E+hjGV13JB2PBxXDwf0TpvoOAioRwhiHdRDuK/65eP0tSwUpBr1lw0bo9rivd1r2ST/ZPI5aKw1Aue4ZphkgTDgnYt1cfpHT9kvOLFMkdYNSKjH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKZLbTCJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751020075; x=1782556075;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kERVEwZGohcYrv9h5JZQFR9MdOFRWgsOAV17tKHDXTA=;
  b=FKZLbTCJqf8aagNQDJQhVvPnr6ePdCcfK5BG7ydy9swMiVhph5XlJTSs
   qE7fFMzED5fv0e86u5YTO9XYhJ7bPsbhdOBI1Hqpy9C2LoL/WLgBFBTie
   WjE0rSL+NEVUawHPvNfDdHjpoCR2Qx38FkKEiCFQarneBeCgJPVWYK8t6
   uF4/XpCvgw6kzj7ViRT/YgH9leGzFE17H6vj6bsIBHI9bQQ5sFeCDG/b0
   34omhCfO0W0tg0V6dWBCrJdI9N5W9rJvIZ46pKNUhkqTwBR473sQIAyHN
   jRpJj1wRnI78En7HfyUk8ZD5t9CPSluwnBDRh0M/mvf4Ce8cpBAn4bj+y
   g==;
X-CSE-ConnectionGUID: Pq+DgCH4TceoqWThQtK1Cg==
X-CSE-MsgGUID: 8NJYeU5gR3Ofyp5u3/1wvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57114610"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="57114610"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:27:54 -0700
X-CSE-ConnectionGUID: 45S+G8gQRbyYlPm+P/YH0w==
X-CSE-MsgGUID: hDSUJ8eMQpeCgLp4Qi/CVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="156817225"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2025 03:27:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 237C56A; Fri, 27 Jun 2025 13:27:41 +0300 (EEST)
Date: Fri, 27 Jun 2025 13:27:41 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, 
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>, 
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
Subject: Re: [PATCHv7 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <oufhbjxqhdma2oe7g3j7xfbqtkazm5d2fzi7im3xqfwysnr5mo@rzfvqa6bdfmk>
References: <20250625125112.3943745-1-kirill.shutemov@linux.intel.com>
 <20250625125112.3943745-5-kirill.shutemov@linux.intel.com>
 <20250626134921.GK1613200@noisy.programming.kicks-ass.net>
 <170dbb93-e9d9-4bd4-b56c-502841c21cd3@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170dbb93-e9d9-4bd4-b56c-502841c21cd3@intel.com>

On Thu, Jun 26, 2025 at 07:18:59AM -0700, Dave Hansen wrote:
> On 6/26/25 06:49, Peter Zijlstra wrote:
> >> +static __always_inline void lass_enable_enforcement(void)
> >> +{
> >> +	alternative("", "clac", X86_FEATURE_LASS);
> >> +}
> >> +
> >> +static __always_inline void lass_disable_enforcement(void)
> >> +{
> >> +	alternative("", "stac", X86_FEATURE_LASS);
> >> +}
> > Much hate for this naming. WTH was wrong with lass_{clac,stac}()?
> > 
> > We're not calling those other functions smap_{en,dis}able_enforcement()
> > either (and please don't take that as a suggestion, its terrible
> > naming).
> 
> It was a response to a comment from Sohil about the delta between
> lass_{cl,st}ac() and plain {cl,st}ac() being subtle. They are subtle,
> but I don't think it's fixable with naming.
> 
> There are lots of crazy gymnastics we could do. But there are so few
> sites where AC is twiddled for LASS that I don't think it's worth it.
> 
> Let's just use the lass_{cl,st}ac() and comment both variants. First,
> the existing stac()/clac():
> 
> /*
>  * Use these when accessing userspace (_PAGE_USER)
>  * mappings, regardless of location.
>  */
> 
> and the new ones:
> 
> /*
>  * Use these when accessing kernel mappings (!_PAGE_USER)
>  * in the lower half of the address space.
>  */
> 
> Any objections to doing that?

Looks good. Will update the patch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

