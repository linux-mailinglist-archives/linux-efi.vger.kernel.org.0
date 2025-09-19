Return-Path: <linux-efi+bounces-4878-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF4B89BD8
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF094E5B00
	for <lists+linux-efi@lfdr.de>; Fri, 19 Sep 2025 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8290312801;
	Fri, 19 Sep 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1S2hu/s"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F73126CF;
	Fri, 19 Sep 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290105; cv=none; b=ZQIX61eOjwaWI6+9zh1HubzYH/7AsVt/CzjroJESdPfcTCLQcaPgUS68p5gt2qFVH4OJmzlnU1M5lW7rlRTR390LYtbWBdViqx8pUgdV8fusAY2DzfPrCOzMq+qe3xppQeu9DmA3xHEcYRLwJDSu4lCkyNvKiHbLlhVMhqymVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290105; c=relaxed/simple;
	bh=XVzTh4eHn4N/ZmlR3lObvuzKNEutxl5poX823+fHFB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3o11P7lN0XPOJgQRWhube9RVGoaKNYMTNayX6xgO5sSnOsNhKa9rM2UUEYCVVaDJZapzQKt1xnwEYwobEYVB36nyf3ZHc8WnMcp/+qI9F/epibCI2YK7pnDpK4U7W4sZFQMYBOsgd2Bw8HbwympFbIX+T0Q6XcyFWwN4r0kDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1S2hu/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312CEC4CEF0;
	Fri, 19 Sep 2025 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758290105;
	bh=XVzTh4eHn4N/ZmlR3lObvuzKNEutxl5poX823+fHFB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1S2hu/sBbuYfL5WeMi1H2qeTqk+hHxic2QzEs4J8ouGVegrgWvMQ6at2y2WAhuBr
	 fdRhBucjff9iC6fQMtxcVqsSWbu+0GGnRjVXCGngvqnUJug8xoNh5fYGix0z6jgAN/
	 b/kkxsakBRspu0tTk7C5ZT6pFf7JXURtNW5R6hm7b2ELCDFELfj+0ucEZIIrjEQHL/
	 XWXw3IZqoqBhzIagQkU7c+lOLImvXc1T06T90aDrKXNNFi9odXwV5x8x/ssygy2mwI
	 dYiVfw/h7nfRlSMJnmHJJum4OvnQwNDKX5AOBTB6z6hTq70gEjRXMuSvVn0P6E2HiA
	 Mp4mgt4mLZlPQ==
Date: Fri, 19 Sep 2025 14:54:59 +0100
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 6/8] arm64/efi: Use a mutex to protect the EFI stack
 and FP/SIMD state
Message-ID: <aM1gs9rhKbrB2Val@willie-the-truck>
References: <20250918103010.2973462-10-ardb+git@google.com>
 <20250918103010.2973462-16-ardb+git@google.com>
 <aM0_96QvR-hlYMJJ@willie-the-truck>
 <CAMj1kXHDtTNMzih7OoTYU0vN4M3mOmFL3YOfaPUKReyJQA6uAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHDtTNMzih7OoTYU0vN4M3mOmFL3YOfaPUKReyJQA6uAQ@mail.gmail.com>

On Fri, Sep 19, 2025 at 03:42:12PM +0200, Ard Biesheuvel wrote:
> On Fri, 19 Sept 2025 at 13:35, Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Sep 18, 2025 at 12:30:17PM +0200, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Replace the spinlock in the arm64 glue code with a mutex, so that
> > > the CPU can preempted while running the EFI runtime service.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/arm64/kernel/efi.c | 13 ++++++++++---
> > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > > index 0d52414415f3..4372fafde8e9 100644
> > > --- a/arch/arm64/kernel/efi.c
> > > +++ b/arch/arm64/kernel/efi.c
> > > @@ -166,15 +166,22 @@ asmlinkage efi_status_t efi_handle_corrupted_x18(efi_status_t s, const char *f)
> > >       return s;
> > >  }
> > >
> > > -static DEFINE_RAW_SPINLOCK(efi_rt_lock);
> > > +static DEFINE_MUTEX(efi_rt_lock);
> > >
> > >  bool arch_efi_call_virt_setup(void)
> > >  {
> > >       if (!may_use_simd())
> > >               return false;
> > >
> > > +     /*
> > > +      * This might be called from a non-sleepable context so try to take the
> > > +      * lock but don't block on it. This should never fail in practice, as
> > > +      * all EFI runtime calls are serialized under the efi_runtime_lock.
> > > +      */
> > > +     if (WARN_ON(!mutex_trylock(&efi_rt_lock)))
> > > +             return false;
> >
> > If it will never fail in practice, why do we need the lock at all? Can we
> > just assert that the efi_runtime_lock is held instead and rely on that?
> >
> 
> Excellent point.
> 
> Do you mean a lockdep assert? efi_runtime_lock is a semaphore, so
> there is no is_locked() API that we can BUG() on here.

Yes, I was thinking of lockdep. Even though lockdep doesn't tend to be
enabled in production, just having it in the code is useful documentation
imo.

Will

