Return-Path: <linux-efi+bounces-4145-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE319AFADEE
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 10:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF47A977F
	for <lists+linux-efi@lfdr.de>; Mon,  7 Jul 2025 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5A3275867;
	Mon,  7 Jul 2025 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2dBAFzd"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC35800;
	Mon,  7 Jul 2025 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875343; cv=none; b=i0wQH9UPaZm5R/v9SHkqfcrQ9sfg7knojD8aejwm9qaTf3pQ5RmhwM7OYxlUiN0gcsdd/+mhC2XtrCamg07SfS2UvTWL6eJ08xcI5patqUUfGTKrtcqRkZuxzSAZGXd2agLi1R/IWye5N92WS2WpCN5jD8tbMYUy4R1RgtYmUi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875343; c=relaxed/simple;
	bh=N7TeHc8uA+dRWRGg8sis7a69LSQxgrglsAuwm+wt4Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXsNl2PuIEtl0yywpBQ9uKrqcbT7xo6B5zCd0z3XXDvtCvFbLkNQTFE6jhPRvARuFVap9lAPGBOvNFRgzPyobLbgmuKhAPp4oWXVMU1e41F8UpevN/QPbVh5BUiTD3YTn943tYbTvNBYDrqTy7N+OmSnLnmF3QLsXqw4QTVX8bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2dBAFzd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751875342; x=1783411342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N7TeHc8uA+dRWRGg8sis7a69LSQxgrglsAuwm+wt4Co=;
  b=h2dBAFzdP+kHxLVQp+unNgq7+D3QAN2iM9LHf4IuSV9qNAwotP3ngKfN
   dnVBw+OO4LYD1KmREHARwnV9w1MozMXeOuxARev/OfUS6zKc5CF7wUMvP
   QNdN6Nw4yfSO+/t/7Ol3jl/MP6vh6LjG/uAErdIpMfx4ytyFXvc5tDZxN
   6Dnh+2V6h9qLXM8bhTi7v98XdBysIaX+gfNV5/+i+IVt1HQZJrHOnba9I
   +6e1HURkeT5IqiFVrobqq1XvAvJJiN/okFhvt6YpQZn8ucfgJOH1F/PlI
   N+mFc6DqvWticLjhkds+9tJ6LxXWxtJvZoAX0SXwVlJYRsg9FeYakTYFJ
   w==;
X-CSE-ConnectionGUID: K0UdxFVbQhmxICk1YI54yQ==
X-CSE-MsgGUID: zcbVEhLyScmp8ulTSWSS4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11486"; a="65541986"
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="65541986"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 01:02:20 -0700
X-CSE-ConnectionGUID: VSf3HB/2Qi+d4IAoxJBfJg==
X-CSE-MsgGUID: rAXXNYSFSwmLSxUNL/u5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,293,1744095600"; 
   d="scan'208";a="154565268"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 07 Jul 2025 01:02:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5DB11182; Mon, 07 Jul 2025 11:02:06 +0300 (EEST)
Date: Mon, 7 Jul 2025 11:02:06 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, 
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
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Message-ID: <eq5h4a5dvlkncthg3lic3go22op2docbhdaolpfwrq2ieai3qo@j3b26mmhf52q>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
 <49f7c370-1e28-494b-96a9-f45e06ed4631@intel.com>
 <20250706101342.069b5068@pumpkin>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706101342.069b5068@pumpkin>

On Sun, Jul 06, 2025 at 10:13:42AM +0100, David Laight wrote:
> On Thu, 3 Jul 2025 10:13:44 -0700
> Dave Hansen <dave.hansen@intel.com> wrote:
> 
> > On 7/1/25 02:58, Kirill A. Shutemov wrote:
> > > Extract memcpy and memset functions from copy_user_generic() and
> > > __clear_user().
> > > 
> > > They can be used as inline memcpy and memset instead of the GCC builtins
> > > whenever necessary. LASS requires them to handle text_poke.  
> > 
> > Why are we messing with the normal user copy functions? Code reuse is
> > great, but as you're discovering, the user copy code is highly
> > specialized and not that easy to reuse for other things.
> > 
> > Don't we just need a dirt simple chunk of code that does (logically):
> > 
> > 	stac();
> > 	asm("rep stosq...");
> > 	clac();
> > 
> > Performance doesn't matter for text poking, right? It could be stosq or
> > anything else that you can inline. It could be a for() loop for all I
> > care as long as the compiler doesn't transform it into some out-of-line
> > memset. Right?
> > 
> 
> It doesn't even really matter if there is an out-of-line memset.
> All you need to do is 'teach' objtool it isn't a problem.

PeterZ was not fan of the idead;

https://lore.kernel.org/all/20241029113611.GS14555@noisy.programming.kicks-ass.net/

> Is this for the boot-time asm-alternatives?

Not only boot-time. static_branches are switchable at runtime.

> In that case I wonder why a 'low' address is being used?
> With LASS enabled using a low address on a life kernel would make it
> harder for another cpu to leverage the writable code page, but
> that isn't a requirement of LASS.

Because kernel side of address space is shared across all CPU and we don't
want kernel code to be writable to all CPUs

> If it is being used for later instruction patching you need the
> very careful instruction sequences and cpu synchronisation.
> In that case I suspect you need to add conditional stac/clac
> to the existing patching code (and teach objtool it is all ok).

STAC/CLAC is conditional in text poke on LASS presence on the machine.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

