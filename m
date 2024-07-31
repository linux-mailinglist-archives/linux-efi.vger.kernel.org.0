Return-Path: <linux-efi+bounces-1524-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBE0942CF9
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0E428164E
	for <lists+linux-efi@lfdr.de>; Wed, 31 Jul 2024 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089A81A8C15;
	Wed, 31 Jul 2024 11:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ntC32VFl"
X-Original-To: linux-efi@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABA1DFE3;
	Wed, 31 Jul 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424330; cv=none; b=DjqEXSc6XqL6IACqpunU/4QjsBZgLzz32lJ6oNoK9hytGxlXIYQS7Hx9APHy61FD1+oLr9dcQKCaHAO4N3Qd9K86AS+FabtyND96F0c3qEYYyM9NLKMIZ89erbXdH9xNa2nQ7wZAzJC3lNb14zQlZ8fDZSOQoXqjsUSdBL52Xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424330; c=relaxed/simple;
	bh=HyRuHvGFlZdEWXrRsDoDyBvSGWLpzvmNLvQjkRRB75M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hd8FvyGL84ecFkaHvOyCQtlULz9L31Ss/1Rsgy/+kq6bm7UK4yUHIqbU425oxsMi/akVyYTP0cDiBots6SP/Uc67Fbd+Zi4vl/LIuwzxcJdIEb9yZhrOhvsZMQL8UNQ3T0lnECrDZ/qWdRsf4UcUXpLryGbpOdIeb5m8wCu42PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ntC32VFl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GshqSbDA5e3tZOuh2iCRL2IJeQX7EVAaAO7NsoB021o=; b=ntC32VFlg57D/uSnLe8kr+vF8W
	a9Mt5NC8ELuPgBl4ci6U9czEZgx0pGOEYKqEaJt8RSp/+iMxorFUfa6lfPmSBzJh+SWn38Y6eYiZu
	htqkkPpLR56fCgx7Sa0HL+f12wmPVsAbFVgo4DRpar4T3wkibXEojTIVlPT2bVjD/5cu2xSQ6AGeX
	OaXg003Wzfq8mwQj2KSSsrMgZl6zeo+YhGPxbOHKhzCwp3tZuYZi3BPv5NWAV++yFlZgYdE4LMdII
	ZuoF/4ljzNpMU8w0OeKDk+tmiNeF3CPypEJ6Ag/tkxRzL1gTHndkLOXFQQNxD9I+7Eb6yYaY2PpU6
	2+9tZYIQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ7FD-00000005Cm6-2pw8;
	Wed, 31 Jul 2024 11:11:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4D900300820; Wed, 31 Jul 2024 13:11:47 +0200 (CEST)
Date: Wed, 31 Jul 2024 13:11:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: 20240621164406.256314-1-kirill.shutemov@linux.intel.com,
	kirill.shutemov@linux.intel.com, ardb@kernel.org, bp@alien8.de,
	brijesh.singh@amd.com, corbet@lwn.net, dave.hansen@linux.intel.com,
	hpa@zytor.com, jan.kiszka@siemens.com, jgross@suse.com,
	kbingham@kernel.org, linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luto@kernel.org, michael.roth@amd.com,
	mingo@redhat.com, rick.p.edgecombe@intel.com, sandipan.das@amd.com,
	thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH 0/3] x86: Make 5-level paging support unconditional for
 x86-64
Message-ID: <20240731111147.GA33588@noisy.programming.kicks-ass.net>
References: <80734605-1926-4ac7-9c63-006fe3ea6b6a@amd.com>
 <87wml16hye.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wml16hye.ffs@tglx>

On Wed, Jul 31, 2024 at 11:15:05AM +0200, Thomas Gleixner wrote:
> On Wed, Jul 31 2024 at 14:27, Shivank Garg wrote:
> > lmbench:lat_pagefault: Metric- page-fault time (us) - Lower is better
> >                 4-Level PT              5-Level PT		% Change
> > THP-never       Mean:0.4068             Mean:0.4294		5.56
> >                 95% CI:0.4057-0.4078    95% CI:0.4287-0.4302
> >
> > THP-Always      Mean: 0.4061            Mean: 0.4288		% Change
> >                 95% CI: 0.4051-0.4071   95% CI: 0.4281-0.4295	5.59
> >
> > Inference:
> > 5-level page table shows increase in page-fault latency but it does
> > not significantly impact other benchmarks.
> 
> 5% regression on lmbench is a NONO.
> 
> 5-level page tables add a cost in every hardware page table walk. That's
> a matter of fact and there is absolutely no reason to inflict this cost
> on everyone.
> 
> The solution to this to make the 5-level mechanics smarter by evaluating
> whether the machine has enough memory to require 5-level tables and
> select the depth at boot time.

I gotta mention (again) that its a pain we can't mix and match like
s390. They default run their userspace on 4 level, even if the kernel
runs 5. Only silly daft userspace that needs more than insane amounts of
memory get 5 level.

