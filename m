Return-Path: <linux-efi+bounces-837-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422B885C23
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 16:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EAD281EBE
	for <lists+linux-efi@lfdr.de>; Thu, 21 Mar 2024 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F238624C;
	Thu, 21 Mar 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FErP5GvX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9886637;
	Thu, 21 Mar 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035251; cv=none; b=WTpu59QZ1ZcklJXGtMRJhTieS46FUEMQTKMG/+B2ysYvmzcYKiQBOK/rFTlIk50o7JCARvbUZ43A9RA01BxdppJ+zzbRtJtGknLACSVIN8TTmCiTG9nhj5bF1Rh1PpLz6yx2x4BzL8qJsnESf04kgE//Xb9qXB12neRsYKQ7eTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035251; c=relaxed/simple;
	bh=F0K+WHKw2TuHQuHxwMJxlaheNAbUvP3X1s0Ten7rJvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClIewRjYm8Pckkcws6eWIB12z1lkOnZDZS9xz42H7fB/StZ07DOHF3jn/D2z+mqFqQ/WfKXOPd8yac7qbhaBZazTpp979D9YQyZ1haKu6VBIXFI/FZi29T+tBoWDNVKSOqGgC/ispERXwvIhg+uqHzAy5NHPxoJ8lAX1+QtZfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FErP5GvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928BBC43390;
	Thu, 21 Mar 2024 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711035251;
	bh=F0K+WHKw2TuHQuHxwMJxlaheNAbUvP3X1s0Ten7rJvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FErP5GvX7NQD74UYljWejmMYJKjbLoV4qQCXerVStSIkEi/vJqCFXXO0rvLr43WKq
	 Mh3nqbW8I8zt6jkHL8YlsKMdyVuAe9uN3ARiyIhYIFWBA+Pq5jsAgfBcyUddqc0uN2
	 Nt6OvKrmhZe9br+y0wVXhglbZy01CoPUBc0SNUFI=
Date: Thu, 21 Mar 2024 16:34:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ted Brandston <tbrandston@google.com>, linux-efi@vger.kernel.org,
	stable@vger.kernel.org, Jiao Zhou <jiaozhou@google.com>,
	Nicholas Bishop <nicholasbishop@google.com>
Subject: Re: efivarfs fixes without the commit being fixed in 6.1 and 6.6
 (resending without html)
Message-ID: <2024032151-tweet-attractor-3b6f@gregkh>
References: <CA+eDQTFQ45nWGmctp-CkK=xXXQQHc_DTkM1iN4m-0o5fCjt8VA@mail.gmail.com>
 <CA+eDQTEiRyddZYwmyX3q+1bBgFRQydC++i4DDbiQ+zC-j72FVQ@mail.gmail.com>
 <2024032132-fax-unsmooth-f92b@gregkh>
 <CAMj1kXEKfAKJM0o-X5vY9cMpkurvpZ418GpyS5fWqiZO-0H9wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEKfAKJM0o-X5vY9cMpkurvpZ418GpyS5fWqiZO-0H9wg@mail.gmail.com>

On Thu, Mar 21, 2024 at 04:28:56PM +0100, Ard Biesheuvel wrote:
> On Thu, 21 Mar 2024 at 15:59, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Mar 21, 2024 at 10:43:05AM -0400, Ted Brandston wrote:
> > > Hi, this is my first time posting to a kernel list (third try, finally
> > > figured out the html-free -- sorry for the noise).
> > >
> > > I noticed that in the 6.6 kernel there's a fix commit from Ard [1] but
> > > not the commit it's fixing ("efivarfs: Add uid/gid mount options").
> > > Same thing in 6.1 [2]. The commit being fixed doesn't appear until 6.7
> > > [3].
> > >
> > > I'm not familiar with this code so it's unclear to me if this might
> > > cause problems, but I figured I should point it out.
> > >
> > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/efivarfs/super.c?h=linux-6.6.y&id=48be1364dd387e375e1274b76af986cb8747be2c
> > > [2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.1.y
> > > [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/log/fs/efivarfs/super.c?h=linux-6.7.y
> >
> > Good catch.
> 
> Indeed. Thanks for reporting this.
> 
> >  Ard, should this be reverted?
> >
> 
> With this fix applied, we'll end up kfree()'ing a pointer that is
> guaranteed to be NULL, on a code path that typically executes once per
> boot, if at all.
> 
> So in practical terms, there is really no difference, and this is the
> only thing I personally care about.
> 
> So I wouldn't mind if we just left them, unless there are other
> concerns wrt to maintenance, tidiness etc.
> 

Ok, let's leave it, as long as there's no bad side affects.

greg k-h

