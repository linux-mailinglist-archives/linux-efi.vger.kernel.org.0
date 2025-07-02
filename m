Return-Path: <linux-efi+bounces-4083-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC22AF1126
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 12:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700B3484613
	for <lists+linux-efi@lfdr.de>; Wed,  2 Jul 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E6255F26;
	Wed,  2 Jul 2025 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aGTeaalE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6325485F;
	Wed,  2 Jul 2025 10:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450739; cv=none; b=B+UOOX1O+Uf9v1fbIAgvPXzmb2OYnL0YHCLYpSqRfQVD0xtvKzJqRXfgnpxIl4Ds4823CLzF87LmXMOun2KeJCuoGv9jxqqpDeKchnuKA7VSG3ZUUXLTUPFIvCuSHTCrM6FrDGevOQrN4wLdPR0HGQuF+z2/zXtPQJvZMrFrEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450739; c=relaxed/simple;
	bh=Bw4Y/IgagKvBTqG1QoK2vY6ZG8eSZpTmBIYDJdyKhEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC18cO1CSMIVonyzKJ+d7ocx+BS6TjejfKzRghhdo/LvP4IbvUKkLzFAYWbYxcVugZ2KFlZbIbdMcro/byOm2Rg0H9nRiszx5HLLkboNZ3dxQ1yj4cjgScVx73pYFnOcIk8bkLCS8nCtGi3Muo5L6KOupFZfpEEvaiVvN/chtfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aGTeaalE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751450738; x=1782986738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bw4Y/IgagKvBTqG1QoK2vY6ZG8eSZpTmBIYDJdyKhEo=;
  b=aGTeaalEm21+fEB4v9Qq8y/o5jUNBjzRJiaafiKjjpIx9nxC1KYVKbEm
   5QbZ7wZPCCyUpYzvfhg+DzT29IKMzdYGxxsdeaSAtWhJBL+moR2INjplp
   HR0myeejTyxHqSDUVbHFFFHFSQF8vJ5KdB0ZXAdWmGPgwP3qUUW7lHbso
   Kmjpsy9fQbSA5LzEIOf61vdCCFxhT8+XRNdLhH0hncswU5oY0TchXn1o2
   DLi/thN+aOj92wL0Zt9OeYKeO+IyPeZyUjIHD1Dxzdx0Bsn8gO5Puxy/t
   x+qdQSj9I37/WHXHyS7gto91UFjBsYU1RbuUSWTQuyv/2Z0n3x8muDsW1
   A==;
X-CSE-ConnectionGUID: 3d9RAxt3RmaF5x5jUpO1Vg==
X-CSE-MsgGUID: kC5B5/5uQtm2tf0ZTvZE0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53605736"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53605736"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 03:05:36 -0700
X-CSE-ConnectionGUID: 5CGaxxggTDqWWnHrDvXjCQ==
X-CSE-MsgGUID: e6lTZ57AR666aCfvszHJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154516220"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 02 Jul 2025 03:05:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 689101E0; Wed, 02 Jul 2025 13:05:23 +0300 (EEST)
Date: Wed, 2 Jul 2025 13:05:23 +0300
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
Subject: Re: [PATCHv8 04/17] x86/cpu: Defer CR pinning setup until after EFI
 initialization
Message-ID: <2n2knq4wkzyfr35udpxawgnc4ykk7s77yavu3crnzf77wjaj4c@njyscphln4gl>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-5-kirill.shutemov@linux.intel.com>
 <841a200e-bcf0-4488-acbd-c00396a9ccd2@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841a200e-bcf0-4488-acbd-c00396a9ccd2@intel.com>

On Tue, Jul 01, 2025 at 04:10:19PM -0700, Dave Hansen wrote:
> On 7/1/25 02:58, Kirill A. Shutemov wrote:
> > Move CR pinning setup behind the EFI initialization.
> 
> I kinda grumble about these one-off solutions. Could we just do this
> once and for all and defer CR pinning as long as possible? For instance,
> could we do it in a late_initcall()?
> 
> Do we need pinning before userspace comes up?

Hm. I operated from an assumption that we want to pin control registers as
early as possible to get most benefit from it.

I guess we can defer it until later. But I am not sure late_initcall() is
the right place. Do we want random driver to twiddle control registers?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

