Return-Path: <linux-efi+bounces-4232-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D449AAFE41B
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 11:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD363AD1D2
	for <lists+linux-efi@lfdr.de>; Wed,  9 Jul 2025 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB2286420;
	Wed,  9 Jul 2025 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzVfOJBC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920952853E9;
	Wed,  9 Jul 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053481; cv=none; b=A5k6wehpdHc0Ql70Nvg8J5CMVOKfQ9kfbvXyiQIPn4SNiGv75PlySwjdPb4uusMAOfIrc6V988VWgeigFfnjvkivHpOJf9A2+X6/3nkSPDRcL4W/GLIHzHD1F/ZrD9hnZ8q0H//1/V7FCGb+opdnb+9dn2rBcHLJwzYUgAHd+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053481; c=relaxed/simple;
	bh=7doOlnxD9JaiUSo7LiM2on6/rPenpaNcpZ5d8eKOqco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtDsN8MiOAuRMBDnZs+6YbC59BE7mkAhS3IigmIu6J4sXV+K4B4O8ID5h2SbTt4EbIP4y9XOnpcLGjEa/+zv5WGqAjbG4VGUA5rvUgfb4MATLMSAaukW3f/U9X1rmSOFlHub+7n/yzCDllegk4UGDEc6rhQcfe6Yx4GCKcQFKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzVfOJBC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752053479; x=1783589479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7doOlnxD9JaiUSo7LiM2on6/rPenpaNcpZ5d8eKOqco=;
  b=YzVfOJBCyj4Bp3TOIZUQZZWuNsOciY4RjOMGeMngSjxDFJlL5lLSWaHq
   l3pNmEFX/YRlJYwuU2XCa46Z9e7OAy9QL5TECeuVpYJ5nhhYEzy2v5bm+
   Ay8vntr8hjaLkRfZg/byJ9iYlDMyP0oWf4OPXqGyLaIaWa3sfO4z3B6PN
   MN3ze0SpaUsEbZO0ccFeH/2JrOfwN9jZ/1LcKldcCFIG8GsRE98AL5c1/
   4Z2UmeUlvQoolIqyXGg2elRgONPuVWn/oVaTQMdetCzkR3mTmrR7VMarB
   35jfiod3PEMAW2gXVmCbHsdm4DchucCXqG81gtC85uJXXcWv0axyZNSnb
   w==;
X-CSE-ConnectionGUID: UkZWRQVvRSSxTrsy0fGOLg==
X-CSE-MsgGUID: GmviEqzoRhuhE5xvlK3LaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64890332"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64890332"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 02:31:18 -0700
X-CSE-ConnectionGUID: dGiTkdOURO+ZzuWOXq9ziA==
X-CSE-MsgGUID: hTsbpswkSJ2/o6uOxAgJ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155139190"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2025 02:31:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 7F9331B7; Wed, 09 Jul 2025 12:31:04 +0300 (EEST)
Date: Wed, 9 Jul 2025 12:31:04 +0300
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
Subject: Re: [PATCHv9 11/16] x86/traps: Communicate a LASS violation in #GP
 message
Message-ID: <xy2ocwstdf44diw5p5hisjwvx467fyhm7bljz5xg72cmnhdfok@7pe3vmht6vcq>
References: <20250707080317.3791624-1-kirill.shutemov@linux.intel.com>
 <20250707080317.3791624-12-kirill.shutemov@linux.intel.com>
 <a14155b7-65ff-4686-b6ba-a6900549864c@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a14155b7-65ff-4686-b6ba-a6900549864c@intel.com>

On Tue, Jul 08, 2025 at 07:40:35PM -0700, Sohil Mehta wrote:
> > @@ -664,14 +673,23 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
> >  		return GP_NO_HINT;
> >  
> >  #ifdef CONFIG_X86_64
> 
> Might as well get rid of the #ifdef in C code, if possible.
> 
> if (!IS_ENABLED(CONFIG_X86_64)
> 	return GP_CANONICAL;
> 
> or combine it with the next check.

I tried this before. It triggers compiler error on 32-bit:

arch/x86/kernel/traps.c:673:16: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
  673 |         if (*addr >= ~__VIRTUAL_MASK)
      |                       ^~~~~~~~~~~~~~

__VIRTUAL_MASK is not usable on 32-bit configs.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

