Return-Path: <linux-efi+bounces-972-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADD8B2003
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 13:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5D21C2192D
	for <lists+linux-efi@lfdr.de>; Thu, 25 Apr 2024 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3901885C46;
	Thu, 25 Apr 2024 11:13:18 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F5B200BF;
	Thu, 25 Apr 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043598; cv=none; b=GqKDqswDGCIoh9H4NayEBV/vP03lm2Q9KzwyJjD89rpy6b5eChxYdUN2cSM1LpDf8KgJWKgjwWt/lefn4AUaVmAA0OTa9bwOmWBfMExBWc7+xzmx2f+MrzgfTazeH16tRUMAkQdbLquI01v8MymagmjzsSgzyNKzLXvzTBuit7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043598; c=relaxed/simple;
	bh=qLuQmqXTg5JpCiFHAVm2b1XWjFdgkQJM5cyksxqz0pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3s9a2alqVdYlqPO53447TzjOFuTztJQTlEOWYwu7QsxTXikgjOuT+HNfoVyRfnlFEWV9kdleSjo2ApIZQvvZn7EUoB/y5ssAYGytwU/Vnv24M2+bNkQyfIVuY6l2ggOucdwAevMmdQ1HpWVbpQpTiMbkMgqLV+lXKIFHfOtrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [85.214.157.71])
	by gardel.0pointer.net (Postfix) with ESMTP id BE710E80EF2;
	Thu, 25 Apr 2024 13:13:11 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 271D9160029; Thu, 25 Apr 2024 13:13:10 +0200 (CEST)
Date: Thu, 25 Apr 2024 13:13:09 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] efi: expose TPM event log to userspace via sysfs
Message-ID: <Zio6xeRbld_tzH0B@gardel-login>
References: <6e751959b9056884c1b9d3ba23e303d1737d8763.camel@HansenPartnership.com>
 <ZiZhSfgeAdrbnaVL@nuoska>
 <CAC_iWjKA-xRH=3FK+=woXsB8AW4+_mVhJhUQnL8iFKxGzOwKiA@mail.gmail.com>
 <e3038141413e25350f0e53496f7a7af1bf8419cf.camel@HansenPartnership.com>
 <CAC_iWj+zbs2tq_nMASDX6pgCAP23+PpctJFiu9=mgOVDz8Trzw@mail.gmail.com>
 <e1da76ca4c7fe9319aaac5f8ff6eb46db433ec60.camel@HansenPartnership.com>
 <CAC_iWjLH=SDoTw_Pgr2hOKHkjEp_dKqwpUe9j6a=_WNW9UcxKw@mail.gmail.com>
 <CAMj1kXGHT2wULF2zwNM_QxD29dRW_dtFX2sOvsLahPiRVB61qg@mail.gmail.com>
 <ZiopXE6-AucAB9NM@gardel-login>
 <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMj1kXETZ3L2QEZjD8=zr9FY11FGkf5KktXoSixjpGxWS4h8sA@mail.gmail.com>

On Do, 25.04.24 12:36, Ard Biesheuvel (ardb@kernel.org) wrote:

> > systemd these days makes use of the TPM — if available — for various
> > purposes, such as disk encryption, measuring boot phases and system
> > identity and various other things. Now, for the purpose of disk
> > encryption, we need to wait for two things: the hard drive, and the
> > TPM to be probed/driver loaded/accessible. /etc/fstab tells us pretty
> > explicitly what bloock device to wait for, hence it's easy. But
> > waiting for a TPM is harder: we might need it for disk encryption, but
> > we don't know right-away if there actually *is* a TPM device to show
> > up, and hence don't know whether to wait for it or not.
> >
>
> I take it this means that the LUKS metadata lacks a 'this key is
> sealed into the TPM' bit?

Well, it does carry that info. But this is of no relevance
really. typically luks has multiple keys enrolled, and which slot(s) to
use is really up to the moment of invocation, depending on what is available.

moreover, i used disk encryption as one example, but we have more
users of TPM. for example we measure early in the initrd that we are
now in the initd, and when we leave the initrd we measure that we are
now gone. we also have a tool that sets up the TPM SRK. All that stuff
is supposed to be run if a TPM is available, but delayed just enough
until the TPM actually shows up, but no more. So for all of that stuff
we must have a way to delay tings correctly.

> So exposing the physical address of the TPM event log is probably not
> what we want here.
>
> Note that the TPM event log table is a Linux/efistub construct,
> whereas the TPM final log table actually comes from the firmware
> directly. So the former only exists if the EFI stub executed first,
> and managed to invoke the TCG protocol etc. OTOH, the TPM final log is
> TPM2 only, so it doesn't exist on TPM 1.2

(side note: in systemd we do not care about tpm 1.2 anymore, we only
support tpm2, and treat systems with just tpm 1.2 like systems that
have no tpm).

> Another thing we need to consider is TDX, which exposes a pseudo-TPM
> which does not support sealing, along with a CC protocol similar to
> the TCG2 protocol. This code will use the event log infrastructure as
> well: there are discussions going on at the moment whether we can
> improve the way these protocols are combined.

The way the delay for a tpm device is actually implemented in systemd
is somewhat generic: there's a target unit called
"tpm2.target". Typically we just delay its activation until a
/dev/tpmrm0 device shows up, if the firmware check suggested that. But
you could also stuff all kinds of other stuff before that. For exampe,
we could also delay it until some userspace service is running that
turns the local security tech into a "fake" tpm device or similar. So
from our side it's entirely pluggable already, and supports other ways
to synchronize properly on a TPM being available, people can plug in
whatever they need there for the synchronization.

However, our primary focus is to cover nicely the typical/generic
systems that have a discrete TPM or ftpm that just needs some generic
driver probing/loading to be available.

Or in other words: i am fully aware that a tpm-like device can be
provided by various means. For now, with this firmware flag file thing
we primarily care about the simple case where it's just driver loading
that we need to do.

> So we should define a scope here:
> - do we need TPM1.2 support?

For our systemd usecase, that's a clear no.

> - do we need non-EFI boot support?

My own focus is EFI. systemd supports non-EFI of course. If people
care about non-EFI I am sure they'd be thankful if we could provide a
similar automatism

> - do we need to do anything in particular for FDE on TDX, which has a
> TPM event log but no TPM is likely to appear.

I'd ignore that for now. And if they provide a software tpm-like device
eventually they just have to plug in the service that provides it
before tpm2.target and be done with it. I think we have an acceptable
approach for that already.

> I am fine with adding a sysfs node under /sys/firmware/efi that
> exposes some of this information, e.g.,
> linux_efi_tpm_eventlog::version, but not the physical address of the
> table.

Yeah, the physical address is of no interest to us. We just need to
know the existance, and that independently of any actualy tpm device
having shown up. i.e. existance of
/sys/kernel/security/tpm0/binary_bios_measurements would be good
enough for is if it was available without "tpm0" actually being
around...

Lennart

--
Lennart Poettering, Berlin

