Return-Path: <linux-efi+bounces-1017-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA68BCA92
	for <lists+linux-efi@lfdr.de>; Mon,  6 May 2024 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875E028313B
	for <lists+linux-efi@lfdr.de>; Mon,  6 May 2024 09:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F421422C8;
	Mon,  6 May 2024 09:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1l0FJV5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7201422D7;
	Mon,  6 May 2024 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987461; cv=none; b=dCTa7QQ/RcLGzlavc5/O22svXdy+cxgg39Qb5/8v+/cNp4Sps3/OfkVgQvQ72/F+MdBiAewxU9aTEvNjkzdVOS6Uq3XGxAu5JL/rEnFwVBaLl/s4uNPWW8TkMy+d8EfJxOttbNVZ1suaNPesah88ZNAFaoTMRG8kWYUkek1v/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987461; c=relaxed/simple;
	bh=W75tdMXqLdLDOYxN5rk10VxUR61cpul1+D0Vd1zRba4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIJu2b1rg+ii73zI1blA4tQgmhfwTWbJqXNogKe1B/M0PKMmPM47AY1oSO07Tx8oLOFYVyBEN/U6n1g74v+e6KqF6KkaOzo8wKtZPjAo4+jc+T3LS9SRgYuzGnKgmRx0aN792I4dRo4LexrQqW07WjRQGKhQkjFYPSNXGypanq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1l0FJV5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714987460; x=1746523460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W75tdMXqLdLDOYxN5rk10VxUR61cpul1+D0Vd1zRba4=;
  b=B1l0FJV50Gce66bHfUyW6tla8C7fNo38V31qPc25T4xkwCwaPUTipMPN
   Fk/eKnhQwadPO5kJmUCmrBmxBGGscxcHfSy2Q+SSqeXlJMJhBuHJoBf5h
   ujFPKIMllAnxAz1tT2LcpiMY+RCEMxdV0SSBrXIiHaxOsIaAaZFaiyOBL
   Fad3+NNOjppfvApTPsSvAw/s3HgTuQaADIPlZZeLZYKNmJLhTxSxpmHqx
   iWGKQcdRv+9EDtXJAQo2M83QDeaI59+K/YSCtC9wo4Tmr6Ni0SenWVrZm
   daH3Z16IR906Aash3ikuGhMvNSwJSEDOsXlNCvOs6FNAkBD+XePMTJRWP
   w==;
X-CSE-ConnectionGUID: 3HMqANx/RRy/BuNPpAzUmQ==
X-CSE-MsgGUID: cFru59hkRH2xyEeHyi1jEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10574309"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10574309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:24:19 -0700
X-CSE-ConnectionGUID: XVzTJ5INTh241H/gmOZ7oQ==
X-CSE-MsgGUID: DgpX4oMoRciEiKfNDLL2Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59299625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 06 May 2024 02:24:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9CA54109; Mon, 06 May 2024 12:24:15 +0300 (EEST)
Date: Mon, 6 May 2024 12:24:15 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, 
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Subject: Re: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
Message-ID: <rlz5mxs2jdp7hyyg2ixbnthk4b3gghgos7tx4flmbnrulv2iap@n73ub3oxrslf>
References: <20240411004907.649394-1-yu.c.chen@intel.com>
 <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
 <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
 <CAMj1kXHLGMXtD-Ad_1TKPmkrvppeNNtKUn-G5q4jr8ZKOab18Q@mail.gmail.com>
 <53exjhamp57x7brn2b5jxdpbzc3amv5i646gmgitnvwjgdwfrd@5v5qifom5tez>
 <ZjT8Agb5vUNUxuVo@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjT8Agb5vUNUxuVo@chenyu5-mobl2>

On Fri, May 03, 2024 at 11:00:18PM +0800, Chen Yu wrote:
> On 2024-05-03 at 16:47:49 +0300, Kirill A. Shutemov wrote:
> > On Fri, May 03, 2024 at 12:31:12PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 24 Apr 2024 at 19:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Mon, 22 Apr 2024 at 16:40, Chen Yu <yu.c.chen@intel.com> wrote:
> > > > >
> > > > > On 2024-04-11 at 08:49:07 +0800, Chen Yu wrote:
> > > > > > Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> > > > > > by parallel memory acceptance") has released the spinlock so
> > > > > > other CPUs can do memory acceptance in parallel and not
> > > > > > triggers softlockup on other CPUs.
> > > > > >
> > > > > > However the softlock up was intermittent shown up if the memory
> > > > > > of the TD guest is large, and the timeout of softlockup is set
> > > > > > to 1 second.
> > > > > >
> > > > > > The symptom is:
> > > > > > When the local irq is enabled at the end of accept_memory(),
> > > > > > the softlockup detects that the watchdog on single CPU has
> > > > > > not been fed for a while. That is to say, even other CPUs
> > > > > > will not be blocked by spinlock, the current CPU might be
> > > > > > stunk with local irq disabled for a while, which hurts not
> > > > > > only nmi watchdog but also softlockup.
> > > > > >
> > > > > > Chao Gao pointed out that the memory accept could be time
> > > > > > costly and there was similar report before. Thus to avoid
> > > > > > any softlocup detection during this stage, give the
> > > > > > softlockup a flag to skip the timeout check at the end of
> > > > > > accept_memory(), by invoking touch_softlockup_watchdog().
> > > > > >
> > > > > > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > > > > > Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> > > > > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > > > ---
> > > > > > v1 -> v2:
> > > > > >        Refine the commit log and add fixes tag/reviewed-by tag from Kirill.
> > > > >
> > > > > Gently pinging about this patch.
> > > > >
> > > >
> > > > Queued up in efi/urgent now, thanks.
> > > 
> > > OK, I was about to send this patch to Linus (and I am still going to).
> > > 
> > > However, I do wonder if sprinkling touch_softlockup_watchdog() left
> > > and right is really the right solution here.
> > > 
> > > Looking at the backtrace, this is a page fault originating in user
> > > space. So why do we end up calling into the hypervisor to accept a
> > > chunk of memory large enough to trigger the softlockup watchdog? Or is
> > > the hypercall simply taking a disproportionate amount of time?
> > 
> > Note that softlockup timeout was set to 1 second to trigger this. So this
> > is exaggerated case.
> > 
> > > And AIUI, touch_softlockup_watchdog() hides the fact that we are
> > > hogging the CPU for way too long - is there any way we can at least
> > > yield the CPU on this condition?
> > 
> > Not really. There's no magic entity that handles accept. It is done by
> > CPU.
> > 
> > There's a feature in pipeline that makes page accept interruptable in TDX
> > guest. It can help some cases. But if ended up in this codepath from
> > non-preemptable context, it won't help.
> >
> 
> Is it possible to enable the local irq for a little while after
> each arch_accept_memory(phys_start, phys_end),
> and even split the [phys_start,phys_end] to smaller regions?
> so the watchdog can be fed on time/tick is normal. But currently
> the softlock fed at the end seems to be more easier to implement.

That's what I did initially. But Vlastimil correctly pointed that it will
lead to deadlock.

https://lore.kernel.org/all/088593ea-e001-fa87-909f-a196b1373ca4@suse.cz/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

