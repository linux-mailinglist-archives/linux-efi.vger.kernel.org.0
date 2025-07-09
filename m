Return-Path: <linux-efi+bounces-4242-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 566DBAFE5F2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 12:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452137AA659
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6509728D8C2;
	Wed,  9 Jul 2025 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OOP8+wbi"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D2749F1;
	Wed,  9 Jul 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057545; cv=none; b=HHP2sJdFPaQ3WpZ9VjkaI5Z9wXyifizQBEzSAjknpQnGX3SiO8G2ghvzaACPVfGzh4S9X9UZ+omCgSUoIQ8G079l3SmnA5zibUw4Chdox1k5dJz3ImTYUntyAisN3Owjl8AZGjPjAM/QwU0yw5zSaCgOZDW04vFSUlLGravByoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057545; c=relaxed/simple;
	bh=paNdGmMvXYKesKr9lHKdIn0w6u/c7Qg2bSBDUVpg9kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+xOaPELu1ZyxIDpc6o3zm2Yo861zXGCooiuv5tGWbrsUQV/hFWS0JdmP0noVdz36G5ovnHzX59xHabw1ZBTifxt0EzYv3Ptj0OVyERKoNCWzfzVRK9FqRQ5Ee/yugDCTWacRSsVy06d+WJvhzFHE611v7UX+6z1zS6QESLswMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OOP8+wbi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752057544; x=1783593544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=paNdGmMvXYKesKr9lHKdIn0w6u/c7Qg2bSBDUVpg9kc=;
  b=OOP8+wbidhXynzV57CiNYToKK6d4edfaqjoviBH7G58BY3i+Cpwv8ff3
   ypzS8z3yCjt0x+7GiMU3OhJ5Ovx2OWIwbYXX2oJCeVldL+rVIuAzJdXmO
   U8CAhWuriSNSo2/n9kDJrUtYyaRCz+1J173fvuEE8cEYqbeLNcavBxtBW
   gLGGMBgbHt+X4uZJGpwcETe2TFNaguxf9GkniPVPy0cGi4Ig6XmtAsgCD
   nT2qFvD4hq5Bt88X20wKCq/dXACw3s8qI5RA9Nmtcn2/KR1FMWZX8CzlV
   ads/50lIdPzKgRu0mYM8HkmfajWjv201hLpphE/k29pwx1fLlVBAsvmes
   A==;
X-CSE-ConnectionGUID: UG8RRdClSaeweqTrD6Wnqg==
X-CSE-MsgGUID: 1o4Qsv0tQI2da9QsiLs3UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="71898553"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="71898553"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 03:39:03 -0700
X-CSE-ConnectionGUID: DKLMS5x4S+qHUf1zKmtxkQ==
X-CSE-MsgGUID: GI4OZrhPQGG8QCZqg4GF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155869422"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 09 Jul 2025 03:38:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 231611B7; Wed, 09 Jul 2025 13:38:49 +0300 (EEST)
Date: Wed, 9 Jul 2025 13:38:49 +0300
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
Subject: Re: [PATCHv9 13/16] x86/traps: Handle LASS thrown #SS
Message-ID: <j76lggwdlxv3lbs7iaqny42ay3m4qqwjnf6vqgesaykpozciaj@a2azdryhmaig>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-14-kirill.shutemov@linux.intel.com>
 <1a2f6b4a-114b-4c27-83f9-1aac46f2e7c0@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2f6b4a-114b-4c27-83f9-1aac46f2e7c0@intel.com>

On Tue, Jul 08, 2025 at 10:12:28PM -0700, Sohil Mehta wrote:
> On 7/7/2025 1:03 AM, Kirill A. Shutemov wrote:
> 
> > +	hint = get_kernel_exc_address(regs, &exc_addr);
> > +	if (hint != EXC_NO_HINT)
> > +		printk(SSFSTR ", %s 0x%lx", kernel_exc_hint_help[hint], exc_addr);
> > +
> > +	if (hint != EXC_NON_CANONICAL)
> > +		exc_addr = 0;
> > +
> > +	die_addr(SSFSTR, regs, error_code, exc_addr);
> 
> I see a slight difference between the #GP handling and the #SS handling
> here. For the #GP case, we seem to pass the hint string to die_addr().
> 
> However, for the #SS, the hint is printed above and only SSFSTR gets
> passed onto die_addr(). I am curious about the reasoning.

I hate how 'desc' size is defined in #GP handler:

	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;

Too much voodoo to my liking. And it will overflow if any hint string is
going to be longer than 50.

I don't want to repeat this magic for #SS.

I would argue we need to print directly in #GP handler as I do in #SS.
But, IMO, it is outside of the scope of this patchset.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

