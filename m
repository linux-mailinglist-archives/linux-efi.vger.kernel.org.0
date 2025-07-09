Return-Path: <linux-efi+bounces-4234-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3F4AFE465
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D52A1C421F8
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748062874E0;
	Wed,  9 Jul 2025 09:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOC7Xf5x"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D53286D55;
	Wed,  9 Jul 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053934; cv=none; b=RC01uiIKrs4KL+jfYHy4WWomEYQ0pMycAWrkQZfHXv3bkdzeWyzwxt7LA+MnpziHQc35z2ddxr5gzXloaRu68UbAARWSyhwzNFw0ihymvCuwQAXHRCQJ1m9E0p4rzeNB7jaM3AENJ4fcKOD/dP9Z1p1ga1YD53ZtFYPu9ErOmL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053934; c=relaxed/simple;
	bh=xYZjRqgkPOL2LqzqY+U3wd+rmN7x/AzvRlTH/XIY5I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOfmkCbBfrTNJH/CEaFL44If5hTrSqb8fv1lgCmtPc1lik16Dx/6to6RtmKkUVPeOaS1W9HQINzikO0H40H9eCh+TN/9CN8btAnqu7lmOW6NZIUiqW0BssOlAaSnd+CBctgCFA3H4hbRBjuA4lyZ06DUy21ymnw+RKJbS/TmrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOC7Xf5x; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752053932; x=1783589932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYZjRqgkPOL2LqzqY+U3wd+rmN7x/AzvRlTH/XIY5I8=;
  b=IOC7Xf5xyeeefm9zHEl2YQCtWFXiAHrhsZAXyMzPu2ACTziIh5RAx8UT
   +FN2m93yv0YJT0Em3N7M22V2b6cOw3NfeuE2ZCl/5WhpjDPTFm8wn4XVc
   UoZ/ELYfdz4ygoGCByF6J5iRfr565KJfmZkhHmtcf9j125fBGaBD7a85V
   YzQV2w56Weqtmbc3xekATzcPC4SnUCMPBFUjnBM8XZBvpBLHmn3VClbp8
   HOCrX58qJRSzuVYKgRbrCYBvl2iD3jB7AVsoydhPH5qgrSqe84c21EBb7
   fC9p8AMn2tUq8g6YI/1/1hQTak+ANrgFvm01hy5Fh1+aTh3Mjr+lDeFgT
   A==;
X-CSE-ConnectionGUID: EiNw8QaYSU6sihzdUCi+PQ==
X-CSE-MsgGUID: 1PUAINd3Q3Oc9ZftSDQEfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54452029"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54452029"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:38:52 -0700
X-CSE-ConnectionGUID: gXEO+CXSSgqC5YZ2O8fG+g==
X-CSE-MsgGUID: 8CthuCcFTnOtmJIMMxE+9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155366162"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 09 Jul 2025 02:38:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D42A01B7; Wed, 09 Jul 2025 12:38:39 +0300 (EEST)
Date: Wed, 9 Jul 2025 12:38:39 +0300
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
Subject: Re: [PATCHv9 04/16] x86/cpu: Defer CR pinning setup until core
 initcall
Message-ID: <aa4sycdhtxlerad6a7xucf6icjyioydu7oefvsdvwnoozqd2kh@lhtkexpqjebn>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-5-kirill.shutemov@linux.intel.com>
 <9340dc9e-bd4d-450e-aa9b-b6b6829eab32@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9340dc9e-bd4d-450e-aa9b-b6b6829eab32@intel.com>

On Tue, Jul 08, 2025 at 06:19:03PM -0700, Sohil Mehta wrote:
> On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> > From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > 
> > In order to map the EFI runtime services, set_virtual_address_map()
> > needs to be called, which resides in the lower half of the address
> > space. This means that LASS needs to be temporarily disabled around
> > this call. This can only be done before the CR pinning is set up.
> > 
> > Instead of moving setup_cr_pinning() below efi_enter_virtual_mode() in
> > arch_cpu_finalize_init(), defer it until core initcall.
> > 
> > Wrapping efi_enter_virtual_mode() into lass_stac()/clac() is not enough
> > because AC flag gates data accesses, but not instruction fetch. Clearing
> > the CR4 bit is required.
> > 
> 
> I think the wording might need to be reordered. How about?
> 
> In order to map the EFI runtime services, set_virtual_address_map()
> needs to be called, which resides in the lower half of the address
> space. This means that LASS needs to be temporarily disabled around
> this call.
> 
> Wrapping efi_enter_virtual_mode() into lass_stac()/clac() is not enough
> because AC flag gates data accesses, but not instruction fetch. Clearing
> the CR4 bit is required.
> 
> However, this must be done before the CR pinning is set up. Instead of
> arbitrarily moving setup_cr_pinning() after efi_enter_virtual_mode() in
> arch_cpu_finalize_init(), defer it until core initcall.
> 
> Other than that,
> Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Okay, looks good, thanks!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

