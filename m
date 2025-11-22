Return-Path: <linux-efi+bounces-5651-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E7C7CCBE
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 11:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B063A8709
	for <lists+linux-efi@lfdr.de>; Sat, 22 Nov 2025 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AB228DB71;
	Sat, 22 Nov 2025 10:42:15 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1A32853F7;
	Sat, 22 Nov 2025 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763808135; cv=none; b=Swjq2s4CUgkDikXK9qJHyWm0Y28HvCngH114uE2oAeInM3aOgbHcs0RKjU7ElTXxm3MTFUwB/ssFyvWeH0PgWZuepM+h3CofLKx47aSHxBFJMDPo2yEifR0qBciYq3Jh2Ea6hfttNZ452rgdWkbtnkEnwIPa7hE1TF8ypxH3/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763808135; c=relaxed/simple;
	bh=i94tbIzPUa2GHwB/6k+eol4xx55abLaPoZ9B2sujiqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbodCmsKbR/GvjRPrfFlTML1T0OBDkIDGMwdnSVYQo/D96aZjWK3cFOj+5VVJRgLIsa3ElbmR/ZzqkEuA8HJEEnWekb9cmGko11nmABWp+gbemT5aV/5xWewEspFTK6WhS4dLRN1NV728TjEBaD4L2YKztdORPpvKwgjeyr3A9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 48C992C075A7;
	Sat, 22 Nov 2025 11:42:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 3F87A1BF8E; Sat, 22 Nov 2025 11:42:10 +0100 (CET)
Date: Sat, 22 Nov 2025 11:42:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Michael Guntsche <michael.guntsche@it-loops.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: Oops when returning from hibernation with changed thunderbolt
 status
Message-ID: <aSGTghJyX-u-leL6@wunner.de>
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120055748.GM2912318@black.igk.intel.com>

[cc += linux-efi]

On Thu, Nov 20, 2025 at 06:57:48AM +0100, Mika Westerberg wrote:
> On Wed, Nov 19, 2025 at 06:43:16PM +0100, Michael Guntsche wrote:
> > I started seeing this issue with kernel v6.15, it worked fine up to 6.14.
> > If my notebook went into hibernation with the docking station plugged
> > in and I then started it up again with the docking station unplugged
> > it would panic. Some times but not always it would also panic if the
> > dock was still connected.
> 
> Did you try to disable RTC_DRV_EFI? At least from the backtrace that's
> where it crashes.

The backtrace in the photo doesn't seem to betray what kind of call
was queued up on efi_rts_wq.  It doesn't have to be a set/get time
request.  efi_queue_work() is also called for set/get variable requests
among other things.  I recommend instrumenting __efi_queue_work()
with a call to dump_stack() to see where this is coming from.
Maybe add an msleep(5000) afterwards to allow time to take a picture.

Also the photo shows a UBSAN splat in drm/display/drm_mst_topology.c
220 msec before the oops, maybe it's related?

Thanks,

Lukas

