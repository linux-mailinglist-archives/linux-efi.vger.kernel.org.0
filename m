Return-Path: <linux-efi+bounces-3489-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925DAA1156
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FC81B624C2
	for <lists+linux-efi@lfdr.de>; Tue, 29 Apr 2025 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704323CEF9;
	Tue, 29 Apr 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aDgbckmz"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF5D2405ED;
	Tue, 29 Apr 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745943083; cv=none; b=feuefqWsInKFj2Sz2ddDDVdlg0QYVOeuE6VNgUOMtyeG7IB/qBLBuHJssaqwTzhaSQCMl41Zy7W4lZzLhrK7PcbGAO1hqWxGPWTHXSOtgIsrSuhK2jolA0jSkJ6rCi+O13BrpwhDRf4FDtS4eHmUQP90iIQ0jLIVjOqadIaATA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745943083; c=relaxed/simple;
	bh=oR1w33SSQ6omVDl7olGy+HBmxCOZTlnjOnPfmHUvvLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbHhSlVm+Yc59B18m12W5hEdz46clwf6HTRneLZfBhoGbs+qdY2UzVBaA2BJdymcd17IAHLJfck03AjKJdN7J8RWHb7qg07Y6JOina5vIfcsIulAbUjQAOXfjWzhtnMJ0x0mUv8YuAhXRE3aI34a21K+szFsPIuBc/CzD9+FeyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aDgbckmz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gVKWWLH02zdPYf4ECkjnNjHF9iWECDI8Hr/g+xNsShY=; b=aDgbckmz/hgFalTkpvZDMWcsBn
	YzFXREbm/DQ9QUqNtuTaly+sbBzrBF4egTvE4lmhqPWOqywwksQsg0gG0sfhOAJWuF+UCtwb7GU9c
	/zj3brJ4hBGh6N+nxOp9PCsC6xFx2Uc+zDPzvloD+BmVEIvo5rsJnT/mJHPjAqzy7sMB5afNqvssu
	J3BP5CkhZ5d67di99bxoEMUTCq4D6RvjBE1GCSJ9wcv6PKRli+HR9+xJhWRupkDi59UFQXH3p9HQH
	3SrIdHb5pqDJXmBU7e8UP0HOMgaySi0usOyQpKh9Sdig47dLKPW+tGol9hP/cgrWRqtZCXPr4jK2o
	Qwf4y8hg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9nXB-00000000v20-34ww;
	Tue, 29 Apr 2025 16:10:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B550F30057C; Tue, 29 Apr 2025 18:10:02 +0200 (CEST)
Date: Tue, 29 Apr 2025 18:10:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, pawan.kumar.gupta@linux.intel.com, seanjc@google.com,
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-efi@vger.kernel.org,
	samitolvanen@google.com, ojeda@kernel.org
Subject: Re: [PATCH 6/6] objtool: Validate kCFI calls
Message-ID: <20250429161002.GB4439@noisy.programming.kicks-ass.net>
References: <20250414111140.586315004@infradead.org>
 <20250414113754.540779611@infradead.org>
 <jsbau7iaqetgf6sa7pooebbbhkhnnidi24f2g7nieozeu63qes@flunkdj5eykb>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jsbau7iaqetgf6sa7pooebbbhkhnnidi24f2g7nieozeu63qes@flunkdj5eykb>

On Mon, Apr 14, 2025 at 04:43:26PM -0700, Josh Poimboeuf wrote:

> > +	 * Verify all indirect calls are kCFI adorned by checking for the
> > +	 * UD2. Notably, doing __nocfi calls to regular (cfi) functions is
> > +	 * broken.
> 
> This "__nocfi calls" is confusing me.  IIUC, there are two completely
> different meanings for "nocfi":
> 
>   - __nocfi: disable the kcfi function entry stuff

Ah, no. __nocfi is a bit of a mess, this is both the function entry
thing, but also very much the caller verification stuff for indirect
calls done inside this function.

This leads to lovely stuff like:

void (*foo)(void);

static __always_inline __nocfi void nocfi_caller(void)
{
	foo();
}

void bar(void)
{
	nocfi_caller();
	foo();
}

This actually compiles and has bar() have two distinctly different
indirect calls to foo, while bar itself has a __cfi preamble.


Anyway, let me have a poke at the annotation.

