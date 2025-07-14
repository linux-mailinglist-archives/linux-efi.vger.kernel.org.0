Return-Path: <linux-efi+bounces-4334-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F2B03CAC
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1931A4A208B
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 10:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BED8221268;
	Mon, 14 Jul 2025 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N4D6me88"
X-Original-To: linux-efi@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE644239570;
	Mon, 14 Jul 2025 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490527; cv=none; b=YTVK5IDXzWvZhOvR3RtPddYfRP/qDjlXf3ux7uoYJGD4iFu4UZk/h/2wlpkpo/5hEyK513KDN25WD5W8Ggikv++3j+VhNUpCOENYytU3I+BkYfRyFShhTtCJfjMhy4PPIfDN1fo5vMnNqotAAQihZw4F5PcWyEMaBP9Q+qxNQPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490527; c=relaxed/simple;
	bh=dYNW+G9IkWXMB5UjzS7cVgR6jqNbPLgCYskPD++uc54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df+2tzMG3/nkiNIworvTYmzeefhO4KjafkM7TRoQLxpHrHE+ZAqJcMcwtTbwW0fTLqprwylZrK2uGXBgZ+DYS+pLIm5BiNaS/OkCK5sVRALtZEYHyQ/J7UgLxEWnWptIkgjM+fMmM9EguTriVz5HyIQKDF43aMKHLsBGT7nWsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N4D6me88; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=io1tVKXnDmOOI4XAw6Cl9XPcaBmlolImRCBWLa00h8I=; b=N4D6me884F1hBjIu5NxRO7FgvY
	iXLtliNvdrcSD8/DIyEzvNJYZBZABGiXogm2TnPRf7I5Y8QOT0/jzkf3/DIh+ST6w7305iOxhodEd
	mgJxBWZRB25kusp+aKjCUeyCmjROcjZG0LCGqPdCUB8+AzV1WkgyqgKUhTKjh1JXjF15Iom/z3g0L
	+9kNFg38iKHO3n4FUXUhs73cKTob67z5QgqWf3YnsUlL12FvR3DTPKzed82xsBEP4mS7POZKUYCUe
	R0T6pylJ8olwL3CKTaoviWWTUhiCMiCgd5yZm45AYEtrcJqWaoWvMRHXZ/6wPnQWdq0YGhZTxADi3
	+CGUYysA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubGq9-00000006w5j-0q8W;
	Mon, 14 Jul 2025 10:55:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE084300186; Mon, 14 Jul 2025 12:55:20 +0200 (CEST)
Date: Mon, 14 Jul 2025 12:55:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 7/7] arm64/efi: Call EFI runtime services without
 disabling preemption
Message-ID: <20250714105520.GS905792@noisy.programming.kicks-ass.net>
References: <20250514174339.1834871-9-ardb+git@google.com>
 <20250514174339.1834871-16-ardb+git@google.com>
 <20250711134833.GI905792@noisy.programming.kicks-ass.net>
 <CAMj1kXGEHWMhMgY8ZMiRxKPTeD+oZBReozKwA4udJsrp-j_P_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGEHWMhMgY8ZMiRxKPTeD+oZBReozKwA4udJsrp-j_P_A@mail.gmail.com>

On Mon, Jul 14, 2025 at 12:20:30PM +1000, Ard Biesheuvel wrote:
> On Fri, 11 Jul 2025 at 23:48, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 14, 2025 at 07:43:47PM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The only remaining reason why EFI runtime services are invoked with
> > > preemption disabled is the fact that the mm is swapped out behind the
> > > back of the context switching code.
> > >
> > > The kernel no longer disables preemption in kernel_neon_begin().
> > > Furthermore, the EFI spec is being clarified to explicitly state that
> > > only baseline FP/SIMD is permitted in EFI runtime service
> > > implementations, and so the existing kernel mode NEON context switching
> > > code is sufficient to preserve and restore the execution context of an
> > > in-progress EFI runtime service call.
> > >
> > > Most EFI calls are made from the efi_rts_wq, which is serviced by a
> > > kthread. As kthreads never return to user space, they usually don't have
> > > an mm, and so we can use the existing infrastructure to swap in the
> > > efi_mm while the EFI call is in progress. This is visible to the
> > > scheduler, which will therefore reactivate the selected mm when
> > > switching out the kthread and back in again.
> > >
> > > Given that the EFI spec explicitly permits runtime services to be called
> > > with interrupts enabled, firmware code is already required to tolerate
> > > interruptions. So rather than disable preemption, disable only migration
> > > so that EFI runtime services are less likely to cause scheduling delays.
> > >
> > > Note, though, that the firmware executes at the same privilege level as
> > > the kernel, and is therefore able to disable interrupts altogether.
> >
> > Is the migrate_disable() strictly required, or just paranoia?
> >
> 
> Runtime services might be polling the secure firmware for an async
> completion when they are interrupted, and so I don't think it is
> generally safe to assume that an interrupted EFI runtime service can
> be resumed on another CPU.

Can we please get a comment with that migrate_disable() explaining this?

Thanks!

