Return-Path: <linux-efi+bounces-4708-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95608B493AE
	for <lists+linux-efi@lfdr.de>; Mon,  8 Sep 2025 17:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20201BC01D7
	for <lists+linux-efi@lfdr.de>; Mon,  8 Sep 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E2C1E130F;
	Mon,  8 Sep 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zz4yu4XE"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE910E0;
	Mon,  8 Sep 2025 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345847; cv=none; b=px7RSBpCKATyORD2ggcCKMNl2bE9GBjle/Ih6iDiMQn6Vsnq/eH8/j/5gYSWDsJl9eSAxiUq2JlJ5qGzrcky0CQ7EwEIdDNRyJFVS1KKBO2rciA0mBu2DvnU4ENbdwEBl09ucXPEhhecce3lpyQLE+ldb/zm62J0VuP83DTyIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345847; c=relaxed/simple;
	bh=pXRG2x8//5ZH4WF4ZfZNFNbYkuG57hnVymI0ifzHDds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWdQVmwJANbTJY1wXpobRi3xWcwgKQwZWdJGJ82gub74rbEQilZ/NtCM3YubU7I2FmCo9mR8AppkmZ7FkfeLBPIDW/y/DjFyLuulGQ6ttUNFUCKcs9pR1mBPAMpAEd7pyr9LGZg6y5tZXD/zjJHapiYpFuOupEwbZEzAmFk0XMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zz4yu4XE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YQRY9Or8sg/fb5DJ7638erwZoUg0oZEnawjGh0xLpBY=; b=Zz4yu4XEP9xU7puhAVA41dsaCf
	N4fj6wnOi3T9rIih+Vvnyfi37YZa8oq7qxbM4cjIUZ6hhIz4+6a2ws9dn2I1w8lUikeP6g+06gfLr
	nivqroXMdazYKeLGVrtYlYzfrx2xJi2V8Rx+vRI/tCIL7OVi9yOaA3xPDUKNVMz3kdzwRGNdDL5OU
	/U8s3BW43XE2KHFbAQ6MMs53vYHTnIPg8MNBmbbpVmSRZ8n5Kf7tpyvqe/x85OFxEZu6bVi2+bkab
	eO6EQiyqhxSUoD+e0aGX2cE3D3ysz/4Com0yXSaMRQs7BuV4WYPKXP+fIROHlyrXELv3KYRGvUrWC
	+ukROBIw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvdvm-00000008xgT-23SJ;
	Mon, 08 Sep 2025 15:37:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B6AF5300230; Mon, 08 Sep 2025 17:37:20 +0200 (CEST)
Date: Mon, 8 Sep 2025 17:37:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 5/7] arm64/efi: Use a semaphore to protect the EFI
 stack and FP/SIMD state
Message-ID: <20250908153720.GF4067720@noisy.programming.kicks-ass.net>
References: <20250905133035.275517-9-ardb+git@google.com>
 <20250905133035.275517-14-ardb+git@google.com>
 <20250905134409.GD4067720@noisy.programming.kicks-ass.net>
 <CAMj1kXE49HFQHYJ=bgz2hPoa7ZocqbeL+pWGtpxxBU2g6_7+SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE49HFQHYJ=bgz2hPoa7ZocqbeL+pWGtpxxBU2g6_7+SA@mail.gmail.com>

On Fri, Sep 05, 2025 at 03:54:55PM +0200, Ard Biesheuvel wrote:
> On Fri, 5 Sept 2025 at 15:44, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Sep 05, 2025 at 03:30:41PM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Replace the spinlock in the arm64 glue code with a semaphore, so that
> > > the CPU can preempted while running the EFI runtime service.
> >
> > Gotta ask, why a semaphore and not a mutex?
> 
> Because mutex_trylock() is not permitted in interrupt context.

Ah, true. Might make for a good comment near there.

