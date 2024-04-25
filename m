Return-Path: <linux-efi+bounces-977-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB78B22F9
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFDD1C2147A
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FE1149DF1;
	Thu, 25 Apr 2024 13:40:08 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3084FC9;
	Thu, 25 Apr 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714052408; cv=none; b=J8B9nvdWp43L+hDWVQLTz7/WS359VdQrwts49b323fm5v3T+wdVtM9kTSatvujEedTcvgb7DnG5e8uSSh9MARAgfJQHyEM3hceTfQv7Wwz+a/Bg0Sdb9NpY0R12UEPQ3eyVrOKJX+fC2eoxxZ8jXZWQbNzGE/gObJGldK9IHUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714052408; c=relaxed/simple;
	bh=6OjdQUER9XqbuZoiy6XBVKaC/+ezP3m6B3AQ4bYYUas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTts7WTYzz1LGVcvV9zLZB6w5G6mhddJ8kXlOcNKJ23YGMq9u3rcq3757lrDn18oviOoP5hlUzsK5dERLQco44Gd2K4JhJNjqkCDvAyhCBFa9WBUcoKrksfWsajr2Z5AWYbemd1/emjHNSOlQKDoVgZ4dYktRLVPYrDi2KsNZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 3FE88E80EF4;
	Thu, 25 Apr 2024 15:40:02 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 845C2160029; Thu, 25 Apr 2024 15:40:00 +0200 (CEST)
Date: Thu, 25 Apr 2024 15:40:00 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <ZipdML5KN6IPenX5@gardel-login>
References: <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login>
 <f6259f0a28b80db78d28475105ae7f37655a58ee.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6259f0a28b80db78d28475105ae7f37655a58ee.camel@HansenPartnership.com>

On Do, 25.04.24 09:24, James Bottomley (James.Bottomley@HansenPartnership.com) wrote:

> On Thu, 2024-04-25 at 11:58 +0200, Lennart Poettering wrote:
> [...]
> > General purpose distros typically don't build all TPM drivers into
> > the kernel, but ship some in the initrd instead. Then, udev is
> > responsible for iterating all buses/devices and auto-loading the
> > necessary drivers. Each loaded bus driver might make more devices
> > available for which more drivers then need to be loaded, and so on.
> > Some of the busses are "slow" in the sense that we don't really know
> > a precise time when we know that all devices have now shown up, there
> > might always be slow devices that haven't popped up yet. Iterating
> > through the entire tree of devices in sysfs is often quite slow in
> > itself too, it's one of the most time consuming parts of the boot in
> > fact. This all is done asynchronously hence: we
> > enumerate/trigger/kmod all devices as quickly as we can, but we
> > continue doing other stuff at the same time.
>
> So let me make a suggestion that you can use now.  Since all you
> currently care about is the EFI/ACPI device, there is always a single
> sysfs entry that corresponds to that (so you shouldn't need the log
> entry as an indicator):
>
> /sys/bus/acpi/devices/MSFT0101\:00
>
> That link (or a kobject uevent if you prefer to look for that) will
> always appear regardless of whether a driver has attached or not.  When
> the driver actually attaches, a driver/ directory will appear where the
> link points.
>
> The device link is added when the acpi scan is initiated as a
> subsys_initcall, which is before all the filesystem initcalls, so it
> should run before the initrd is mounted.
>
> Is this enough for now and we can think about a more generic indicator
> that all drivers have been probed later?

That would only work on ACPI though, but on ACPI we already have a
check that works?

Or to say this differently: how is that different/better from the
check that already exists in systemd, which looks for
/sys/firmware/acpi/tables/TPM2?

Lennart

--
Lennart Poettering, Berlin

