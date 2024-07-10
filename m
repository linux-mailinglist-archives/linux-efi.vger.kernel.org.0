Return-Path: <linux-efi+bounces-1408-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3179D92DBF6
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 00:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DF81C23B7D
	for <lists+linux-efi@lfdr.de>; Wed, 10 Jul 2024 22:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625283CD7;
	Wed, 10 Jul 2024 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9zNEi31"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E913C685;
	Wed, 10 Jul 2024 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720650817; cv=none; b=RtBlj6Z3OhusV2J8Y/0qvZxjWRDqncjJvdLtUBPJCs8pH+xBRcE/8VnlVcl82IcOQ4S8/20YhoOrSVM/ZFRgIPE/V6cieCYtjlfFU9Dal786xdL9t+YHGskYPlO4C06GkTwVjvcfvUE8myboQWZZ2qf+DiRLkRjcGOPNoQcjAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720650817; c=relaxed/simple;
	bh=7xsnAqLc4rT1FvFy/8gthJ9Rs0Qx2xqN6hIj1IsWJNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfmSY811XHfVt6l65vF0HtsklzlYaRtuLqTK+7adDLDAvlj+qaEtJNNKAevFiyYZ1ysAH9r/6Bz5QjNa3mlWFaTR0B252fdz018ecL/KLkL1oogEu0x0qQyN8ARu895Cl0rLOlBfe/pnpQ6oJFPpKDrr4U6d4AwsEpTbiySIk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9zNEi31; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720650816; x=1752186816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7xsnAqLc4rT1FvFy/8gthJ9Rs0Qx2xqN6hIj1IsWJNo=;
  b=I9zNEi31EOIIrFePRKwLwNpteqy13vSQ+d7hgBuRVHc7aV74qxN2ibFO
   87AXrb6jK9FkxlyNRL+D1+BdZ5JZR/SkXPudxUlUAqsbnUpc1+oq3o5Io
   G1d2CXq1xYjHAWisVYn4GR2aSCEETGOCwTpiSzDq+aKaXwUaF/SiX/WTL
   j/o5i2NX12oezLRc7n3udLw5jcif0qlDEudW5j6U6JmBcde2+suIw82WN
   R/rJw9CjXQvNk+e+Qz6cQI7AneH/VRUvCSPlAEt3qodkPHRHzhdGnQwyr
   bR/2nw/hhPG5Q6UMtVTdKlFgp4Ri0KKjbkHEN6eSp0vXHhkHQ3t5Zgj9T
   g==;
X-CSE-ConnectionGUID: Tb+0NgX9Q6+9rpzIlzRJYg==
X-CSE-MsgGUID: SMr6LeEyRSmU0PnRTpvMgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="17822630"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="17822630"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 15:33:35 -0700
X-CSE-ConnectionGUID: OPGhT1HVT0+ytRpZQYdHYg==
X-CSE-MsgGUID: I+fF4Wv9SkKH6ucqKAiA1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48448372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 15:33:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 94A4829E; Thu, 11 Jul 2024 01:33:23 +0300 (EEST)
Date: Thu, 11 Jul 2024 01:33:23 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Xiongwei Song <xiongwei.song@windriver.com>, 
	Xin Li <xin3.li@intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Tony Luck <tony.luck@intel.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sohil Mehta <sohil.mehta@intel.com>, 
	Ingo Molnar <mingo@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Breno Leitao <leitao@debian.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Yian Chen <yian.chen@intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, Hou Tao <houtao1@huawei.com>, Juergen Gross <jgross@suse.com>, 
	Vegard Nossum <vegard.nossum@oracle.com>, Kees Cook <kees@kernel.org>, Eric Biggers <ebiggers@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Yuntao Wang <ytcoode@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Tejun Heo <tj@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Huang Shijie <shijie@os.amperecomputing.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 03/16] x86/alternatives: Disable LASS when patching
 kernel alternatives
Message-ID: <cqacx3crogegwyslm25kwcdcezgg2n44lhy3mg5qkka3vgn4xa@lhqsoseyduus>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-4-alexander.shishkin@linux.intel.com>
 <20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710171836.GGZo7CbFJeZwLCZUAt@fat_crate.local>

On Wed, Jul 10, 2024 at 07:18:36PM +0200, Borislav Petkov wrote:
> On Wed, Jul 10, 2024 at 07:06:39PM +0300, Alexander Shishkin wrote:
> >  static void text_poke_memcpy(void *dst, const void *src, size_t len)
> >  {
> > -	memcpy(dst, src, len);
> > +	stac();
> > +	__inline_memcpy(dst, src, len);
> > +	clac();
> 
> I think you need LASS-specific stac()/clac() or an alternative_2 or so. You
> can't cause that perf penalty on !LASS machines.

Hm. Do we have text_poke() in hot path?

Even if we do, I doubt flipping AC flag would make any performance
difference in context of all locking and TLB flushing we do in this
codepath.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

