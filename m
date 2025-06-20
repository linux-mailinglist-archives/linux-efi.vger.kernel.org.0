Return-Path: <linux-efi+bounces-3876-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76FAE20F4
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCB71897D3A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jun 2025 17:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E56E20CCD3;
	Fri, 20 Jun 2025 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFpWuaIJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F51F03C7;
	Fri, 20 Jun 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750440690; cv=none; b=rw66UTOsN1Jq4b0E/R2we4C5pdeEXwPni+uugu9s1ezaUUlzIEGH8EJqeeMdTfi66Q/az/nkay68XWHyLYeTv55Vsjpdh53rZbD6sMEPcRC7g4rYYbbaIfo0w86hu6Qto9fq77oJwSTSmq0jrrRTrc/eDHu/fJmnK3oJ4ga4w8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750440690; c=relaxed/simple;
	bh=MCJBmCnyJELdwnimYECzk7tUYaiPn0GwNjQCQ+gCzYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iULZEg9N+ZFG62u5On85eC1LJYdTt3195wPZcMNlgrnq6wHN9rlPqdNW2lr92BoMCcKlBgY4i99PsXK1cpICru0mmp+kDO+XCVg2gNxxvherJgJemjMDTQxCMNNnWIgdpHwfuUCxisqs1+GeQCzj9fZDOkpAffmqzuS1dbIUG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFpWuaIJ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750440690; x=1781976690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MCJBmCnyJELdwnimYECzk7tUYaiPn0GwNjQCQ+gCzYI=;
  b=SFpWuaIJxl7LuDi7zD3CMnO7i/ZYKsKtB1waLV//JrELfQLsyn0PCJDi
   SJlcNnoywBrLIdc+fVx3aM63gcTZ0Lh8J+MoNGaxV+UMgYvSP05Z8bH4y
   jX/16Vh2RtkQ3gf0Yf5G/zHOotw3u0qQA8pUfAHmYrdAhpxfyWpwFEBO6
   HWGqKOZgm4AZUH7lWpIUmvRQkrgBuhhNNeLYeLZxEmJs7TyIoTqL5GCkS
   KWm+ghiV3u8xM2FvfmskkVXCmcO0/ZhmKo9a2L4UNJFIqa/wJ5yXiZ/A9
   uE4vYe1D7C1V3lebqFkDh7RGHIc9QMBVB1RqsHiSioaFRWkNIYJC83L8B
   Q==;
X-CSE-ConnectionGUID: BpBpmkrSTAOiWwn4XwHSAA==
X-CSE-MsgGUID: azF0R2lKRum+aXzUOD2csw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52642485"
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="52642485"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2025 10:31:28 -0700
X-CSE-ConnectionGUID: 0nCgDcPRRmS29HR0Ox+sFw==
X-CSE-MsgGUID: /U721Y/eRLC9+caxN/kv0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,252,1744095600"; 
   d="scan'208";a="151511068"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 20 Jun 2025 10:31:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 59B1A109; Fri, 20 Jun 2025 20:31:14 +0300 (EEST)
Date: Fri, 20 Jun 2025 20:31:14 +0300
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
	linux-mm@kvack.org, Yian Chen <yian.chen@intel.com>
Subject: Re: [PATCHv6 01/16] x86/cpu: Enumerate the LASS feature bits
Message-ID: <tfpekzid4hu4xguq3fetosyltg3owjy2cactqklohfohalhbza@hx7qdrpcymrn>
References: <20250620135325.3300848-1-kirill.shutemov@linux.intel.com>
 <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3055288-c640-4df3-978e-abb97b1610e7@zytor.com>

On Fri, Jun 20, 2025 at 08:36:30AM -0700, Xin Li wrote:
> On 6/20/2025 6:53 AM, Kirill A. Shutemov wrote:
> > diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
> > index 250c10627ab3..9574c198fc08 100644
> > --- a/arch/x86/Kconfig.cpufeatures
> > +++ b/arch/x86/Kconfig.cpufeatures
> > @@ -124,6 +124,10 @@ config X86_DISABLED_FEATURE_PCID
> >   	def_bool y
> >   	depends on !X86_64
> > +config X86_DISABLED_FEATURE_LASS
> > +	def_bool y
> > +	depends on !X86_64
> > +
> >   config X86_DISABLED_FEATURE_PKU
> >   	def_bool y
> >   	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
> 
> You don't need to add X86_DISABLED_FEATURE_LASS, because the LASS code
> is NOT optional at build time, i.e., you now don't have CONFIG_X86_LASS.

Hmm. But it is optional. It depends on CONFIG_X86_64. I don't think we
want it to be advertised on 32-bit kernels.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

