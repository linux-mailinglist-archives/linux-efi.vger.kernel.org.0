Return-Path: <linux-efi+bounces-1014-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307BB8BAE02
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 15:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FFF1C2263D
	for <lists+linux-efi@lfdr.de>; Fri,  3 May 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBF153BD4;
	Fri,  3 May 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="moxrLXde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZ9LVyuZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A448153BD1;
	Fri,  3 May 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744080; cv=none; b=Xd5QHpPNr1Rd+TZ7qzCFcIpnBlK07nEMxgfKNtma6nGDLDHrWaThU2tCQmfI0rUfuHOawGGJ28B3cwOhdhN1D5sdNd943wSpeozmP1Ca90ZTGOnezl8/oJMg6fS8TzmWaJIzqCHF4I4UEooDsX8dCT+sN08IEy78jvTQjyD9/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744080; c=relaxed/simple;
	bh=qJnuwtkeDuO1dEGZ+XpbtLgDbxS73SvTU0QT3E/p+rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt1/w6yzPTLY2rpQc8avF+c/kGZlcYCGvlQE5mHXoAH8zy6ll8KAeRYsN36lNabT11iOFEMl/kKvu3IM/jqYdE56/DYH+I/5XqzI39tDeY5ZgDqTEb6eqyV9g/jiPXj73hLo5Hac5OZID7lNP7dvOdLryDbcXKOwC/9xkERS+Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=moxrLXde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZ9LVyuZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 69076138030D;
	Fri,  3 May 2024 09:47:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 03 May 2024 09:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1714744077; x=
	1714830477; bh=SLlrQkd2iXanI/kW9JruqRjjOcTmn5fEnvoJmg8IxSo=; b=m
	oxrLXde+RKZOxlvRz5sgWr7U5Xz/Ad5b8nMisWLAYXrFsuZZV0WUE4+Zt+pLrT7W
	CdnJ3DaQeIAU3OVN+0UdV8y0CtiYT+QjcfkcNbBpbBiRKso8aaGssrvDEKZ12mwB
	/NGjzhEZjW04+4MhCmXkXhmDL7bdrbYvKbsIDI9BSfCCVPi3fPELlIhuwTK8uhUS
	hVxhKADGsZIgwKZrs0jWAURPsG1+7adr9zHNdJGC2vXedx7dClKDostUM0QI+Vhf
	crrerf8p97cVjp306Ytj9c4RoBpUZ+rYls/KLYFxa9gkOqexbtdu8ihVbvlJYwDz
	uSt2awGcs2z+cZ0Q2XUlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714744077; x=1714830477; bh=SLlrQkd2iXanI/kW9JruqRjjOcTm
	n5fEnvoJmg8IxSo=; b=LZ9LVyuZy3LNrPSCtehVDg0g4ltr0vsaceDJ/Zrf2VOP
	CBpySNhT7JNkZMM5jhnmy44rM1HReoQF05f1vOq/GshzwrA7pSYmVwuacyUAngka
	PAI113fYJTZrjiL/B5gGMT5wlSAWzzEmAMqCRo5dHMIOLPkAHnW2M+l48XSzAMqo
	b3v50aTIclbQjA2B4d9qBKQ2hVQ7tGf9YPmJRY+b92Rf4vhZSPbVlXVbTATzN3oL
	7r5jT5mHRw2U/GdBtoqg2iP3tP2dMaNjMHdsUvrex5ExjywzdBGgQ2sSFZ8rm0un
	rs/SMEa7y9+paTsAuYRzejiHXswOqAvxNQNLPXV4uw==
X-ME-Sender: <xms:DOs0ZrJTD76rpk3SF6C0wqVDoZAq0Kea4xniv3j2mvgX7DqQwKBs-w>
    <xme:DOs0ZvKqxn2TC58Y09bwhwkWWlNmJXrstDe-y7piVX2Fqp7FRjHsTn42TyugTWy70
    0yGeBpYVFN7boLRQYc>
X-ME-Received: <xmr:DOs0ZjuNpHWImZtnuzW_mgkaX_Fus56JPNUBENkK-r1mOG5NL4pPPWlEO87aOV37CIBBXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfffveelhfetfeevveekleev
    jeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:Des0ZkaQOo8W2IRL2Zk2dAuTyg_mhi7p6ixxjGFMFVEIfRGXepVv1Q>
    <xmx:Des0ZiYWWoqb8Fj9HZeJbwQW8ydWajhBVVbpdZaQZcLICM4q-xPNmg>
    <xmx:Des0ZoAuMLiDlPebpjEJ5lpEYgYUm6kLssP7PZjuPCJ6CsNi52MFtg>
    <xmx:Des0ZgZe6AbRvmnclxA-3vKNMZ2mtyUHuXfn9gKDCQ49ZuobK4wmuw>
    <xmx:Des0ZolOzI8aCBC_vqmsyTZ7TIPSHxtrkCpHZ0QAZ-GWA0MGDkcJZuid>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 09:47:53 -0400 (EDT)
Date: Fri, 3 May 2024 16:47:49 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-efi@vger.kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Nikolay Borisov <nik.borisov@suse.com>, Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, 
	"Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
Subject: Re: [PATCH v2] efi/unaccepted: touch soft lockup during memory accept
Message-ID: <53exjhamp57x7brn2b5jxdpbzc3amv5i646gmgitnvwjgdwfrd@5v5qifom5tez>
References: <20240411004907.649394-1-yu.c.chen@intel.com>
 <ZiZ2yUI09QIrYr/4@chenyu5-mobl2>
 <CAMj1kXGdRkiLh+3DePZuejaqEphyP=gN6bnK6v08ueP3MP40EA@mail.gmail.com>
 <CAMj1kXHLGMXtD-Ad_1TKPmkrvppeNNtKUn-G5q4jr8ZKOab18Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHLGMXtD-Ad_1TKPmkrvppeNNtKUn-G5q4jr8ZKOab18Q@mail.gmail.com>

On Fri, May 03, 2024 at 12:31:12PM +0200, Ard Biesheuvel wrote:
> On Wed, 24 Apr 2024 at 19:12, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 22 Apr 2024 at 16:40, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > On 2024-04-11 at 08:49:07 +0800, Chen Yu wrote:
> > > > Commit 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused
> > > > by parallel memory acceptance") has released the spinlock so
> > > > other CPUs can do memory acceptance in parallel and not
> > > > triggers softlockup on other CPUs.
> > > >
> > > > However the softlock up was intermittent shown up if the memory
> > > > of the TD guest is large, and the timeout of softlockup is set
> > > > to 1 second.
> > > >
> > > > The symptom is:
> > > > When the local irq is enabled at the end of accept_memory(),
> > > > the softlockup detects that the watchdog on single CPU has
> > > > not been fed for a while. That is to say, even other CPUs
> > > > will not be blocked by spinlock, the current CPU might be
> > > > stunk with local irq disabled for a while, which hurts not
> > > > only nmi watchdog but also softlockup.
> > > >
> > > > Chao Gao pointed out that the memory accept could be time
> > > > costly and there was similar report before. Thus to avoid
> > > > any softlocup detection during this stage, give the
> > > > softlockup a flag to skip the timeout check at the end of
> > > > accept_memory(), by invoking touch_softlockup_watchdog().
> > > >
> > > > Fixes: 50e782a86c98 ("efi/unaccepted: Fix soft lockups caused by parallel memory acceptance")
> > > > Reported-by: "Hossain, Md Iqbal" <md.iqbal.hossain@intel.com>
> > > > Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > > ---
> > > > v1 -> v2:
> > > >        Refine the commit log and add fixes tag/reviewed-by tag from Kirill.
> > >
> > > Gently pinging about this patch.
> > >
> >
> > Queued up in efi/urgent now, thanks.
> 
> OK, I was about to send this patch to Linus (and I am still going to).
> 
> However, I do wonder if sprinkling touch_softlockup_watchdog() left
> and right is really the right solution here.
> 
> Looking at the backtrace, this is a page fault originating in user
> space. So why do we end up calling into the hypervisor to accept a
> chunk of memory large enough to trigger the softlockup watchdog? Or is
> the hypercall simply taking a disproportionate amount of time?

Note that softlockup timeout was set to 1 second to trigger this. So this
is exaggerated case.

> And AIUI, touch_softlockup_watchdog() hides the fact that we are
> hogging the CPU for way too long - is there any way we can at least
> yield the CPU on this condition?

Not really. There's no magic entity that handles accept. It is done by
CPU.

There's a feature in pipeline that makes page accept interruptable in TDX
guest. It can help some cases. But if ended up in this codepath from
non-preemptable context, it won't help.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

