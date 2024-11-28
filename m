Return-Path: <linux-efi+bounces-2233-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 248549DBB63
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 17:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02EB164243
	for <lists+linux-efi@lfdr.de>; Thu, 28 Nov 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B31BD9D3;
	Thu, 28 Nov 2024 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB6Oydwn"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41F3232;
	Thu, 28 Nov 2024 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812136; cv=none; b=TlLKwtAvmPO9jaogOuuamNkd0D7rtc0EjRDys7UkZ2JGNiiLfAkNtfwmoFMn2iGBr8LTTwIrmglyFrnVdrNpb2r1kbV/xjW29YMXISwXYtItaWt/45CUvBrCKtGNs8hk0Bp1TR12zqmcYBUScg1J7xh/D2ev0iyINMWF1tzBqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812136; c=relaxed/simple;
	bh=reIHRCSYgXX7krbHbZuB1P5p2+PBEeLWCfrM4sq9TJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYfsYxC4fJhkcRJBS/wxH+5zesQe77uYso1W+nwiLysFrZ0sH4IqRPF/gM69eKkcmQ6Q1KC5hdIwT+bWmb0YChJHSJWQk6TvvdcjVRog9irdYsQ8JvlKqAhsIOokeLWl+76sip6FdpLCyphFbGcKJzlMhGWlcu2savG80YFo+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB6Oydwn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376B4C4CECE;
	Thu, 28 Nov 2024 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732812136;
	bh=reIHRCSYgXX7krbHbZuB1P5p2+PBEeLWCfrM4sq9TJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sB6OydwnQ05EJysfnXpEyDki/aft5Fhy2S8zT3N9qcBj+0GrhEzXv+45T1Z7Eys6t
	 CRM5FMX2KcXn3S6qJaxS/fUqj2ipJFtG0nfaszdivOzZl5iNIYlb5VjdnpRcYar/6w
	 qzkF+pRQM1F+OzIEg6csk4mM6ujMysj7DKFY/v4UCfhuOMpVtrjQabjLve2pt8RrHK
	 5Y8YrYyedtxsZxUhiYADTN27O/L+LiE6BZ2Of3WCcNb3mMjoW96q6ZoYIWEqMbYHjn
	 JPfUMzizNXIQFHLkghjYqAJifXkzphnSknMLSoEVwd+CXAgnWcRMv7jz4rgS65xBXs
	 mCJYKj/KF8kqA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tGhai-0000000071O-2bJ5;
	Thu, 28 Nov 2024 17:42:09 +0100
Date: Thu, 28 Nov 2024 17:42:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Ricardo Salveti <ricardo@foundries.io>,
	Marc Zyngier <maz@kernel.org>, linux-efi@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: UEFI EBS() failures on Lenovo T14s
Message-ID: <Z0idYMTrsKXOA6a1@hovoldconsulting.com>
References: <Z0gn1N3IsP8r3gTA@hovoldconsulting.com>
 <CAMj1kXGjiA1HydMaY82MQsYvkchpN7v7CMOB5i3NEdqcYGn19Q@mail.gmail.com>
 <Z0g_HL01eqXu4cwQ@hovoldconsulting.com>
 <CAMj1kXFtr7ejEjjSRj9dcRa7YbO0SR5OR3pm+K6OvbX2=RfhAQ@mail.gmail.com>
 <CAMj1kXHS_TY=jfBT=dqUQSXf2pBXbt12uaLsMw-FLX3uU_X6uA@mail.gmail.com>
 <Z0iCNJVWNzBzdq0C@hovoldconsulting.com>
 <CAMj1kXF0Mmr5CyyeKXO6-Ot+5cfSV6t2jPmn+TGVyjUsoYwGtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF0Mmr5CyyeKXO6-Ot+5cfSV6t2jPmn+TGVyjUsoYwGtw@mail.gmail.com>

On Thu, Nov 28, 2024 at 04:21:09PM +0100, Ard Biesheuvel wrote:
> On Thu, 28 Nov 2024 at 15:46, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Nov 28, 2024 at 12:05:09PM +0100, Ard Biesheuvel wrote:
> >
> > > If you're happy to experiment more, you could try and register a
> > > notification for EFI_EVENT_GROUP_BEFORE_EXIT_BOOT_SERVICES using
> > > CreateEventEx(), and see if it gets called when ExitBootServices() is
> > > called. That would at least help narrow it down.
> >
> > Thanks for the suggestion.
> >
> > I see the notify function being called when I signal it as well as on
> > each ExitBootServices().
> 
> Interesting. That means the EDK2 fork is fairly recent.
> 
> FYI https://github.com/tianocore/edk2/pull/6481

Nice find.

> > With an efi_printk() in the callback ExitBootServices() fails as
> > expected, but with an empty function the kernel seems to start every
> > time.
> >
> > Interestingly, ExitBootServices() now succeeds also if I add back the
> > CloseEvent() call. In fact, it works also if I never signal the event
> > (i.e. if I just create and close the event).
> 
> Is it still invoked by the firmware if you closed the event before EBS()?

No, I just reconfirmed that then it is only called when I signal it
before closing (or never if don't signal the event).

Johan

