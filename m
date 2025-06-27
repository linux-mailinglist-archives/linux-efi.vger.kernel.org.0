Return-Path: <linux-efi+bounces-4033-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E53AEB4B6
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 12:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630585618A6
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jun 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493D4298989;
	Fri, 27 Jun 2025 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SD5zDaXY"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48E2206A6;
	Fri, 27 Jun 2025 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751019927; cv=none; b=X3i7hHn+sXGrUiEeLxk4qm005lytVRmu/yxwHaWUHTKksPtk2zR+Fu0Yd0EtBflrisQszeDc2hBUG2L9F7RzMTiB80xqFJHCRpHedCqmZM5idu9SwyeZTy2OuQMT1k/Vf4MhSc+zeo3yCF0NWnR5BRRRdxmwuWXuymWRf/joP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751019927; c=relaxed/simple;
	bh=ia6n5UXAj5uKiKTZr/E2V2AjNnYEG4HQ2T/pwQJGYEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HlgM4dkpHAtH70UaLfZeFuaLaiy5MV/LAF1/OXEdULrqbGfSl4ptob+VBTs8vAF7oNM46cy8hZMb/Jw59JqHZWfDgaM4VljV5UPWOvEzVUkx0EyTE3zlnelQmZC84wfBSPu/a8fvLMbuxOlOHoI8Z1hc9MhwUg+hQXHqzp7uJdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SD5zDaXY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751019925; x=1782555925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ia6n5UXAj5uKiKTZr/E2V2AjNnYEG4HQ2T/pwQJGYEo=;
  b=SD5zDaXYCDeltaRq901L7qOgd9rv5QxSh63nanHPWiJMwTyg4e5tD+aQ
   TFFPsbS5S0vorIvy6hcem5vMTK8u381Dl06G9NKl3T8oeTH0XjSN+Y/3U
   wDscF/X2JkS9ekPPq9h+pZLD9BBy6h6rwLHUhvtU2F5LfbHaqNXTJauCz
   2EaJNzj6Ucc2wMLVGd2twoM+9A3f4SoJxMjTbHZZ/dOm1IL6XsLRH/5q7
   i0EVLdShT8h5EZtui0HF12R2HyF19NR8plMnsDW7sNyyKlgcFUhLTlpzo
   phmfqxqc04ZcLSsuJrudhYpG3x1nRFuiiLkzLAjAVsK5BqPzOlghUDvxh
   w==;
X-CSE-ConnectionGUID: f+XGZkaqT5mcq2wq6GZ0vg==
X-CSE-MsgGUID: jkjcPHP7Tfi5L4MUZPq0wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="64769546"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="64769546"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:25:25 -0700
X-CSE-ConnectionGUID: mXCvdDVURbaMvopFv8zAUg==
X-CSE-MsgGUID: 3qOmJE47RxSQg2u5J9xsPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="153071076"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 27 Jun 2025 03:25:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A5BAD6A; Fri, 27 Jun 2025 13:25:12 +0300 (EEST)
Date: Fri, 27 Jun 2025 13:25:12 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, 
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
Message-ID: <h47uwzno7oqer72sjwyc4spxaduggqi4meccjvai6v42iwnqnh@uhloooww25mo>
References: <20250620135325.3300848-2-kirill.shutemov@linux.intel.com>
 <20250620163504.GCaFWNuI-8QFqAM0yI@fat_crate.local>
 <6y2iqv6c2idn7yebaec7tyhzl5zcsrwqq4lcsokumlqeophzaf@ljnmxorblgcj>
 <20250620182943.GDaFWolxhwogB2tTxb@fat_crate.local>
 <tmd5llufitosphzhiik2tlemjuwyi7xkcjlhbqhibrgjjhsqcj@b3xtgub42p45>
 <20250623102105.GCaFkqkatFSbyl1YeN@fat_crate.local>
 <ztkgdk72p2z3q6z4hslfg4gj6pejirh7cnssxhd7u72mo4enn4@viqrwrycderf>
 <20250626151837.GFaF1kzfLtesXLqaAQ@fat_crate.local>
 <20250626160707.GGaF1wK5tW37P6xt0O@fat_crate.local>
 <2768baad-1b1f-40c2-9cd9-9f4489e14f4d@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2768baad-1b1f-40c2-9cd9-9f4489e14f4d@intel.com>

On Thu, Jun 26, 2025 at 10:21:23AM -0700, Dave Hansen wrote:
> On 6/26/25 09:07, Borislav Petkov wrote:
> >> Makes more sense?
> > I meant this crap, ofc:
> > 
> >         switch (bug) {
> >         case X86_BUG_CPU_MELTDOWN:
> >                 if (boot_cpu_has(X86_FEATURE_PTI))
> >                         return sysfs_emit(buf, "Mitigation: PTI\n");
> > 
> > This should say "Mitigation: LASS" if LASS is enabled...
> > 
> > Which begs the question: how do LASS and PTI interact now?
> 
> Maybe my babbling about LASS mitigation Meltdown was ill considered. It
> seems that I've just muddied the waters.
> 
> All the real LASS-capable hardware also has RDCL_NO=1 which is the
> _actual_ x86 Meltdown mitigation. Those systems are not vulnerable to
> Meltdown in the first place.
> 
> They should say: "Not affected" for Meltdown, both before and after LASS.

Right. To best of my knowledge, SLAM is the only known vulnerability LASS
fixes directly so far.

So, we want an entry for SLAM?

I don't think it is very useful as we don't allow LAM if LASS is missing.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

