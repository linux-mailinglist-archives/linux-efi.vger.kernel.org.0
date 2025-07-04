Return-Path: <linux-efi+bounces-4118-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BA0AF926E
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 14:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9154F1CA6EA0
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jul 2025 12:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F712D63FB;
	Fri,  4 Jul 2025 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwQWxOaO"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5B298CA4;
	Fri,  4 Jul 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631818; cv=none; b=kh4cqUjuzNEMmvORV4ZsQBACoeLqI6VsIwGw01yZaDfbLEJBv3GaxWtKJa6fZKDk8JK9sagrvSMZ4tGoR0D6VjvHzZCepnTB5rxhm7q4cnHAebGCwJ6M1JJdlG+IM7QloVHUub0fTgF5UJUA6roZdsgeCAn874JkgE9Q40R7ogM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631818; c=relaxed/simple;
	bh=oweq7sEis8OSPxaym3zvDjZpLebm0v2LQsMDtWM7+Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojnZRJeWw1NqgLgZOdhrDd4aGPpGMAwm8Pqw0VXEN3+E6Oj1Zxt28xpUDbtopNkP7yZtkJrnWtQlaca4R3lcaoIKYHCJJNGlVvFxAAEXZrW+O/50R/ZZ2VGouzdJxrrRppYbQWftvjmDllYAKqpAO6CCQCkmf3b7RkjgK3TFCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwQWxOaO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751631818; x=1783167818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oweq7sEis8OSPxaym3zvDjZpLebm0v2LQsMDtWM7+Zs=;
  b=VwQWxOaOdNyUqxeIBZ6kSdVOEggSJg4A7YI06FR4qh1yCBagoWY4RF9n
   f8KynJSF/DB6mrsKP9NRE3H4brHfzN6CFoHuD91mPEDfnzEfo6k+tUULc
   6JogCdZhIPdy/uZrbwbV8qh8eyW5dfddxa8whHsnHLtQSqVgx+pQMj/lC
   7dtnwet+wx15LclipUEwGdMU0pTCod1CRS4GxpfxRbEhPESFLqhrABLQt
   0p+Xg5SeZRTku4VhI6RBgVS256bdBeQxC8AANO2yZG0QnrzLmwUXfe+Rp
   59PdfQe+9qXnHFPRIP+tMOLd+frADYR6/W7LemfQKrjxtUF8oqvQnI28B
   w==;
X-CSE-ConnectionGUID: kN5vIsK4StGPnljbxusiDw==
X-CSE-MsgGUID: oeOBsxWEQZK3kWd2IPUGuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54085571"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="54085571"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 05:23:36 -0700
X-CSE-ConnectionGUID: h0pPry01S5+0sgbByQeXGQ==
X-CSE-MsgGUID: zHTjG05tTGup2BFBFLyhMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; 
   d="scan'208";a="155395215"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2025 05:23:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4B75815D; Fri, 04 Jul 2025 15:23:23 +0300 (EEST)
Date: Fri, 4 Jul 2025 15:23:23 +0300
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
Message-ID: <ysoozflaqr3rnb2kjqca5ifeuc7clutiaypqraqs7r4sdumxmi@uc2bp7l5th75>
References: <20250701095849.2360685-1-kirill.shutemov@linux.intel.com>
 <20250701095849.2360685-5-kirill.shutemov@linux.intel.com>
 <841a200e-bcf0-4488-acbd-c00396a9ccd2@intel.com>
 <2n2knq4wkzyfr35udpxawgnc4ykk7s77yavu3crnzf77wjaj4c@njyscphln4gl>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2n2knq4wkzyfr35udpxawgnc4ykk7s77yavu3crnzf77wjaj4c@njyscphln4gl>

On Wed, Jul 02, 2025 at 01:05:23PM +0300, Kirill A. Shutemov wrote:
> On Tue, Jul 01, 2025 at 04:10:19PM -0700, Dave Hansen wrote:
> > On 7/1/25 02:58, Kirill A. Shutemov wrote:
> > > Move CR pinning setup behind the EFI initialization.
> > 
> > I kinda grumble about these one-off solutions. Could we just do this
> > once and for all and defer CR pinning as long as possible? For instance,
> > could we do it in a late_initcall()?
> > 
> > Do we need pinning before userspace comes up?
> 
> Hm. I operated from an assumption that we want to pin control registers as
> early as possible to get most benefit from it.
> 
> I guess we can defer it until later. But I am not sure late_initcall() is
> the right place. Do we want random driver to twiddle control registers?

I will do it in core_initcall().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

