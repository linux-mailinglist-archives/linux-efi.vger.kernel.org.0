Return-Path: <linux-efi+bounces-1427-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2426792E4E5
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93AE1F22AAF
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A63155A59;
	Thu, 11 Jul 2024 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTxGISw4"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77782D94;
	Thu, 11 Jul 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720694235; cv=none; b=cngtYjPP4jxkBhDTZFwnmr7GxdBqLX07SpSHF2uPKJ5OfFi7l4Obda7raFk9mWdo/Oe44v5v7z/yTg8gjfGLSR0xDip8MDmNDy9xNeff1vzepFO+1D1vG1NZgddNgchQISV4gQ3D5ZJEbCs5xzedlZS7Ksvf5g0Bp05+x8t2WIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720694235; c=relaxed/simple;
	bh=DFEfePK8cAElLfJIiPmawLyu7JjbXJrgS7m+m6Pnd5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NonNTTUFgG1viNBhs2uII1f0rVqO5sVEfjM9DMwibMd8HdMbVcsK6DvM+DdiinAyOCE1RUl+99vPprXMqdxcC5QQGqVWaPnzv63VJhRTKEE2nK8lsfN73PS+NYHRIt0keto51XYzr0dm+JKfB7HvqVmDSdrqObV4faEhVIe0w2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTxGISw4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720694234; x=1752230234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DFEfePK8cAElLfJIiPmawLyu7JjbXJrgS7m+m6Pnd5Q=;
  b=DTxGISw4HxEBg4N6eo2Y/r5Q5hTCl9vse9VjYw7Q9RkHup80RX6z8VPO
   4wG2HK1RIbRGAZPEry/PnxcALaMrNLpilyaGWkphvaq+J1zISSeiL/BQf
   JP6ZXP1+piRcqDX14LM7m15OSl6Q5guUaqfHJ8wlzC4bfkT+gXzKz/U4G
   Y7Pfy/2U19ZZU47JsWkaCWbQOO/XNK/lWq4HhEnUNe96IwjiGrKKGDbLT
   zpRDyl7/pqRoNLc7tlrdeyQTd6lWtXXsHg9wL/MhZuLPT0NDtwcjbdNAF
   HqpwUr9SIfjIUDkbRa9N9C49H2JPs5q24FwrPDCoo9Cadk5n3o5YqScg6
   g==;
X-CSE-ConnectionGUID: cE3gteqFT1+i/6VXoueBlQ==
X-CSE-MsgGUID: KMNCtYJhSp+jJ6vZI2b7Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="29468679"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="29468679"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 03:37:13 -0700
X-CSE-ConnectionGUID: RTya0ugrQZuBYIYVmuGQgw==
X-CSE-MsgGUID: KADa2dLDQ/mTpNQID6JOXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="49272803"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 11 Jul 2024 03:37:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0BAD329E; Thu, 11 Jul 2024 13:37:00 +0300 (EEST)
Date: Thu, 11 Jul 2024 13:37:00 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
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
Subject: Re: [PATCH v4 07/16] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Message-ID: <3dbaf7fm65xl6kou5fj4tzty7emsdecs3juu4rm7266pgzcfk3@z3mehcszkw7j>
References: <20240710160655.3402786-1-alexander.shishkin@linux.intel.com>
 <20240710160655.3402786-8-alexander.shishkin@linux.intel.com>
 <20240711081153.GC4587@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711081153.GC4587@noisy.programming.kicks-ass.net>

On Thu, Jul 11, 2024 at 10:11:53AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 10, 2024 at 07:06:43PM +0300, Alexander Shishkin wrote:
> > In order to map the EFI runtime services, set_virtual_address_map
> > needs to be called, which resides in the lower half of the address
> > space. This means that LASS needs to be temporarily disabled around
> > this call. This can only be done before the CR pinning is set up.
> > 
> > Move CR pinning setup behind the EFI initialization.
> > 
> > Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> So the previous patch makes us not boot, and this fixes it up? Perhaps
> order things differently?

Maybe just move LASS enabling (patch 04/16) to the very end of the
patchset?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

