Return-Path: <linux-efi+bounces-4116-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 410C3AF8EF8
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 11:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FA97B0A82
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAED2F5332;
	Fri,  4 Jul 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HDAXGuoL"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B782F5314;
	Fri,  4 Jul 2025 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619880; cv=none; b=mSrbZ2UK6fFppLdmad1JqQZgl7/BfCFAb841tLEY4eQjpTZJHdGiSmue9oE6SW/W+yKMG/+zn2vMAtUCIhym1OcpLgtxOEqA8U60fWq1E7zXWEP0IQJIOFXc+71GBA/qECwBpa1HcqAKY5C1CWZMkTF45NSweU1pE7KHhFMFxoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619880; c=relaxed/simple;
	bh=b0XOHjTaiA2dtm2Vi8CMqXmXSSVJ5m5uh5A07ReI5Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QImBf7bGMiUoYx/uKuZnMYejM72TJw3fM6K8dOiMZBTxFwbA8sHJAB8KQ2d/HYn4DN6lNa6o7j81JJi6qbwzBfyliY0IpDY2oS2LqF2DGBEwpQIquy/UpsiQ5HhuqglBDA2wHfr5peHJT1V04b0OHvMTBPkfoJFlBlAtlF+r3F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HDAXGuoL; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751619879; x=1783155879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0XOHjTaiA2dtm2Vi8CMqXmXSSVJ5m5uh5A07ReI5Oo=;
  b=HDAXGuoLkUKKtIdXE3Dx5ulD/pj6pzLxlGS1l1hy8t7dLvpLpFyFvqCG
   5psLhnzN3pzmdFumYT4AgqwSGCVDPZrIVKUK5rSjv4MwYYofj9wsA5ScH
   68rpfaOZz37SyuiHS1+UwLogynAyu04tYIuFVf2KQuP6YVDE6Fde9pl+F
   5b69iQMzz/eIOI4pnHCPB2zUu6kyGCGp5k4LSs99QRHzSt5rM4aYbDSk3
   YV4I1Mx8HfjSmEMB9jbhUw92uaes2XB+sAldyIREYJ9FJcEehbTS4BK4g
   IJcOfaE5dJP9YE0W7or+mckN3l8Qwyt2CodHT21SqO0RYc81JYK6NMfrL
   w==;
X-CSE-ConnectionGUID: UL00myQPS4yp222p+IWf2w==
X-CSE-MsgGUID: gJdBLx+GQ86uKVqZcVdMhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65303536"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="65303536"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 02:04:38 -0700
X-CSE-ConnectionGUID: vht6bwzzRjSkxR+/fOABPA==
X-CSE-MsgGUID: Kh8fGGBpRLih/m3GU7b5pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="185553991"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jul 2025 02:04:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 70B4015D; Fri, 04 Jul 2025 12:04:25 +0300 (EEST)
Date: Fri, 4 Jul 2025 12:04:25 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
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
Subject: Re: [PATCHv8 02/17] x86/asm: Introduce inline memcpy and memset
Message-ID: <otaa7t5kq4wtj5zk3vis7ldqw56i7bwzga7yg7pskgeps7zthg@fthlgikkmlhh>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-3-kirill.shutemov@linux.intel.com>
 <49f7c370-1e28-494b-96a9-f45e06ed4631@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49f7c370-1e28-494b-96a9-f45e06ed4631@intel.com>

On Thu, Jul 03, 2025 at 10:13:44AM -0700, Dave Hansen wrote:
> On 7/1/25 02:58, Kirill A. Shutemov wrote:
> > Extract memcpy and memset functions from copy_user_generic() and
> > __clear_user().
> > 
> > They can be used as inline memcpy and memset instead of the GCC builtins
> > whenever necessary. LASS requires them to handle text_poke.
> 
> Why are we messing with the normal user copy functions? Code reuse is
> great, but as you're discovering, the user copy code is highly
> specialized and not that easy to reuse for other things.
> 
> Don't we just need a dirt simple chunk of code that does (logically):
> 
> 	stac();
> 	asm("rep stosq...");
> 	clac();
> 
> Performance doesn't matter for text poking, right? It could be stosq or
> anything else that you can inline. It could be a for() loop for all I
> care as long as the compiler doesn't transform it into some out-of-line
> memset. Right?

Yeah, performance doesn't matter for text poking. And this approach
simplifies the code quite a bit. I will use direct asm() for text poke.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

