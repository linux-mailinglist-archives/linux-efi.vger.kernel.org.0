Return-Path: <linux-efi+bounces-3877-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1461BAE2104
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 19:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ACC34A735F
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8032E6135;
	Fri, 20 Jun 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHtXkU6y"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070432D3A6E;
	Fri, 20 Jun 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440830; cv=none; b=eZHZePKkz9OLdZkEZZR2qELQAKjoqb7NB55TomJT3845O05u1umtsxo9hZgfT5lvLEGg2yjNAfpbEect19YCmut2hoBA69BRF3GklekfGFWRhoue57TuVKnU6ERdtqE0qmaqN0utZgSzpfI2zPM9MpAUBeupfKBmyi1Wps2QkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440830; c=relaxed/simple;
	bh=C0KIP4y2EaLB9MdRBxwuIaS4kc8jFZZqZaGNo2xtJ/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QG4zEPzURAP/h+vFtyjDN3LBqWKRaQ8V5QndQiWFvNYqlP/s65I873oT+dwlSLuoFit9GoKq8kTpj3bWOj6sKejYyXMKas5SRjApdCbYhV2fqrfslzaoRZbx+whV71IRTzp15BnDE6PykzPmhzPbW/AXsx1WxuuwNi5B3V1Szgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHtXkU6y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750440829; x=1781976829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0KIP4y2EaLB9MdRBxwuIaS4kc8jFZZqZaGNo2xtJ/k=;
  b=IHtXkU6yXnvCpzaChjzLh2kAmz9kL82Fn85J2lMzo1SOcIkQVuMsF026
   ZHz86Fo9zG9y7ozBxtOblEQj4I93jkpSEFByErbsT55ul4h5razzyUMSl
   nvwOQtqbnMrHIEF62FirtFo4kza1mSKMbwQmJVmvnA7DLWwgcFtRG8JPL
   3XnRXdrSuRw95nUv56PAE+YeOOjTpFB2i1COGvysMwsIK0j+lOsA06Eh/
   glSPl2qKOJrDKB4xS5joDeGnsTm7cGmZpcAIZOcG/GOmwhrrE7eyvI2xB
   lIcwjyWEmTcUw2CGx/dgSsAjO5/V9b8KXhfnuhl8BGm9TQ8V687LXaszm
   A==;
X-CSE-ConnectionGUID: VsHAKXjeSGa9yYIQreGd2Q==
X-CSE-MsgGUID: 2Go1r15nQTma9Nuq+5ssDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="51943391"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="51943391"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:33:48 -0700
X-CSE-ConnectionGUID: 5ylaNGQKRJKduxA7PJ9a/g==
X-CSE-MsgGUID: VgHyEtvcR26bzU3URzErIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="155272453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 20 Jun 2025 10:33:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3A5B1109; Fri, 20 Jun 2025 20:33:36 +0300 (EEST)
Date: Fri, 20 Jun 2025 20:33:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
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
	linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>

On Fri, Jun 20, 2025 at 06:35:04PM +0200, Borislav Petkov wrote:
> On Fri, Jun 20, 2025 at 04:53:09PM +0300, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index ee176236c2be..4473a6f7800b 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -313,6 +313,7 @@
> >  #define X86_FEATURE_SM4			(12*32+ 2) /* SM4 instructions */
> >  #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
> >  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
> > +#define X86_FEATURE_LASS		(12*32+ 6) /* "lass" Linear Address Space Separation */
> 
> This needs to be in /proc/cpuinfo because...?

What is current policy around it ?

I think it is useful to advertise security features in cpuinfo. LASS fits
next to SMAP/SMEP/UMIP.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

