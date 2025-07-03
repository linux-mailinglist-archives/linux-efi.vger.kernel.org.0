Return-Path: <linux-efi+bounces-4101-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EF0AF724C
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 13:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A237B528316
	for <lists+linux-efi@lfdr.de>; Thu,  3 Jul 2025 11:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7711FBCAE;
	Thu,  3 Jul 2025 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="icvujwCm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A612512FF;
	Thu,  3 Jul 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751542308; cv=none; b=TD+46wQXnVTbPRkKP1j6okUYVlZMKg1jsaNbZc6qVx1DUuURbplyc8KyBBRdaOp1FhAteD5/jLEne7LRouR8y5vmkNf9x82sqMb+skEOdhZ1CZ4x4z3iJU1e+75K1es/1WFcIayWFcryN5Nczd3QsPw53Y4AbO55iuPZyukTRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751542308; c=relaxed/simple;
	bh=mz2HO5e+m0EVO4Bso9dOWmH5VXn5tebaRN4tyuLfYyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X37oaOxna4v5L9ixmINOMr1+2RZLClrzlJUjsdpCPqz8W4/EEDkISczhKKBGO+NP/x6DlHFUmorjs+Npq8Km1Rp8VTDoSa6S7VvnFVQLa5dLuNhgQ5UkCzxdryMiGeQpoL5IlaC5Q1eykE6OpGJrA7U5IPnszzBFGPj+WOOdUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=icvujwCm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751542307; x=1783078307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mz2HO5e+m0EVO4Bso9dOWmH5VXn5tebaRN4tyuLfYyQ=;
  b=icvujwCmzoZiEcBfrizQDS2rg7NbkGkB10DL01IzPoFPIjf1224AdHAg
   lWP1u9Ygy4G8zV9W5Io0Ce4Kk63AEH+TlCzfV+DsP553xACOJHOnA64A5
   o2fDl+JBU36nfLKnVhCyx9n7H2p66JBhXVQiBlUcs1UtiYsMNZF/rwC1N
   Woe7QvFlovKZAEoESJLS+NIqgTGZdMPBWBr8j4zvdtVf0sXzmQ80B4+Qz
   7/Ljalq5URRFqlGoJT2kU8AdB5cN/fkQFYsOxjBebE4AiWUZNWdmoRL4R
   iBTSjxcXRts+dEA3PwaoG4h1hgJ1zyhBmYnIob4X3mLtrePjj3av3uboi
   g==;
X-CSE-ConnectionGUID: QP5H9CcJTnmSLNqzIZAmuA==
X-CSE-MsgGUID: brfc9Hq7TG+XDIp7ajPx3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53731270"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="53731270"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 04:31:46 -0700
X-CSE-ConnectionGUID: Hol9m/2jRjWHXEvh17EZ8g==
X-CSE-MsgGUID: ey2HETopSV6Moa5CZajchA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="154920492"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 04:31:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4EA371E0; Thu, 03 Jul 2025 14:31:33 +0300 (EEST)
Date: Thu, 3 Jul 2025 14:31:33 +0300
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
Subject: Re: [PATCHv8 14/17] x86/traps: Handle LASS thrown #SS
Message-ID: <h7pjqco4nngern4ucj2krt4uuau5v522ni6w5vjup3qlkvn2yb@oskfps5mlzbc>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-15-kirill.shutemov@linux.intel.com>
 <95dc18fd-73b0-4019-92d2-c0e6aaf22c96@intel.com>
 <mgo3qfjekobe6qflwkpey3p7tzsp3b2mrirama4w2rxyckce7g@3gce3fn5emvu>
 <bbe9dfb6-88c7-4724-bafd-0524599c9369@intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe9dfb6-88c7-4724-bafd-0524599c9369@intel.com>

On Wed, Jul 02, 2025 at 01:05:17PM -0700, Sohil Mehta wrote:
> On 7/2/2025 6:27 AM, Kirill A. Shutemov wrote:
> 
> >>
> >> Maybe I've misunderstood something:
> >>
> >> Is the underlying assumption here that #SS were previously only
> >> generated by userspace, but now they can also be generated by the
> >> kernel? And we want the kernel generated #SS to behave the same as the #GP?
> > 
> > It can be generated by both kernel and userspace if RSP gets corrupted.
> > 
> > So far, do_error_trap() did the trick, handling what has to be handled.
> > LASS requires a bit more, though.
> > 
> Thank you for the information! The discussion in the other thread helped
> clarify my confusion about the new FRED specific fixup outside the LASS
> check.
> 
> IIUC, for kernel generated #SS, the prior code in do_error_trap()
> would've done a few things such as notify_die() and
> cond_local_irq_enable() before calling die().

cond_local_irq_enable() need to happen if we want to do something
sleepable during exception handling. It is not the case here.

notify_die() will be called die_addr()->__die_body()->notify_die().

> The new code now directly calls die_addr(). Are we changing the behavior
> for legacy kernel #SS? Also, why don't we need those calls for the new
> LASS #SS?

do_error_trap() provides catch-all handling for unallowed-thing-happened
exception handling in either kernel or userspace.

We can take simpler path for fatal in-kernel exception. Following #GP
logic matches what we need.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

