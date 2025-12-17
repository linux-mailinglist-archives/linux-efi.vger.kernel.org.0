Return-Path: <linux-efi+bounces-5891-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49330CC6714
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 08:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F35C30167B0
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA21314A89;
	Wed, 17 Dec 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELlSPoe4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86537313264;
	Wed, 17 Dec 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958157; cv=none; b=Wr7408CjKwmcJb9V3lDsIgh+isc/oxglNPgVFZEHgE5iSK2NlJ4QdEALWQUtXD3ISyfP3ofnAN2bVgYQAW7rXwrML1+64ybWzbLGQjnFuwmV/GBbXZW4l7FKzhM5Tt6OSM7yEAbYKWRVfFVKS214s+keNPq7ksuQbkhGp97Ybmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958157; c=relaxed/simple;
	bh=Xo9c1qEYiQMSvCEooBFQkEOr2bYPsShQNIttr2X1DG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPfMXK5DTKOSa1/ubqkw3Ft5S8CalKuzCjpDHdalvaDGTOPIiY2p/khF+VfurDoyQ7uaIYNz03ILYAZNU/WUiSKP3FVbMwyx63BtozfF6gmMOeWQjLrIFHSdHZ23qCFOOOZr+ZPAa+9yaJthxSa0sH+7akvrRkIRAiE2dSwhdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELlSPoe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B78C4CEF5;
	Wed, 17 Dec 2025 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765958157;
	bh=Xo9c1qEYiQMSvCEooBFQkEOr2bYPsShQNIttr2X1DG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELlSPoe46Vp/wKpVK3LLNZx61ZRTeN9a8aiwZ+dBOq6JSgu8lT1rxJ3wY80rxeXhw
	 OZrPCLpEBFk6TLKFBA5pONUweIEe6/iPED+L08U/dXepE25vl89hRZiQ/FCns7UqdC
	 coya/6tg0ImJ/cGQDCryPzjE8vQi9Nqu3aUuHEAmYgRVp1m3qEkelGkvr/TPOrnFV9
	 yhPHmKfYuEbW8BihXNYfIx3rYzf4yaVAhlcte6H35pz0VG5SbKINKXAIGTAmOGvHIK
	 XqbbXlo5Mxru1Gcnu0BaAUfhCIDC3t50dTRFkXYmmP/w7QngJootP/5QLOgvwTke2k
	 Z91VDTNTIflIw==
Date: Wed, 17 Dec 2025 13:25:39 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, netdev@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <aUJh--HGVeJWIilS@sumit-xelite>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aT--ox375kg2Mzh-@sumit-X1>
 <dhunzydod4d7vj73llpuqemxb5er2ja4emxusr66irwf77jhhb@es4yd2axzl25>
 <CAGptzHOOqLhBnAXDURAzkgckUvRr__UuF1S_7MLV0u-ZxYEdyA@mail.gmail.com>
 <ayebinxqpcnl7hpa35ytrudiy7j75u5bdk3enlirkp5pevppeg@6mx6a5fwymwf>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ayebinxqpcnl7hpa35ytrudiy7j75u5bdk3enlirkp5pevppeg@6mx6a5fwymwf>

On Tue, Dec 16, 2025 at 12:08:38PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Dec 16, 2025 at 01:08:38PM +0530, Sumit Garg wrote:
> > On Mon, Dec 15, 2025 at 3:02 PM Uwe Kleine-König
> > <u.kleine-koenig@baylibre.com> wrote:
> > > On Mon, Dec 15, 2025 at 04:54:11PM +0900, Sumit Garg wrote:
> > > > Feel free to make the tee_bus_type private as the last patch in the series
> > > > such that any followup driver follows this clean approach.
> > >
> > > There is a bit more to do for that than I'm willing to invest. With my
> > > patch series applied `tee_bus_type` is still used in
> > > drivers/tee/optee/device.c and drivers/tee/tee_core.c.
> > 
> > Oh I see, I guess we need to come with some helpers around device
> > register/unregister from TEE subsystem as well. Let's plan that for a
> > followup patch-set, I don't want this patch-set to be bloated more.
> 
> Don't consider me in for that. But it sounds like a nice addition.
>

No worries, the current cleanup is fine for now.

> > > Maybe it's
> > > sensible to merge these two files into a single one.
> > 
> > It's not possible as the design for TEE bus is to have TEE
> > implementation drivers like OP-TEE, AMD-TEE, TS-TEE, QTEE and so on to
> > register devices on the bus.
> 
> So only OP-TEE uses the bus for devices and the other *-TEE don't. Also
> sounds like something worth to be fixed.

The TEE bus is common for all the TEE implementation drivers which need
to support kernel TEE client drivers. I am aware there will be QTEE and
TS-TEE from past discussion that they will be exposing devices on the
TEE bus.

> 
> > > The things I wonder about additionally are:
> > >
> > >  - if CONFIG_OPTEE=n and CONFIG_TEE=y|m the tee bus is only used for
> > >    drivers but not devices.
> > 
> > Yeah since the devices are rather added by the TEE implementation driver.
> > 
> > >
> > >  - optee_register_device() calls device_create_file() on
> > >    &optee_device->dev after device_register(&optee_device->dev).
> > >    (Attention half-knowledge!) I think device_create_file() should not
> > >    be called on an already registered device (or you have to send a
> > >    uevent afterwards). This should probably use type attribute groups.
> > >    (Or the need_supplicant attribute should be dropped as it isn't very
> > >    useful. This would maybe be considered an ABI change however.)
> > 
> > The reasoning for this attribute should be explained by commit:
> > 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration").
> > In summary it's due to a weird dependency for devices we have with the
> > user-space daemon: tee-supplicant.
> 
> From reading that once I don't understand it. (But no need to explain
> :-)
> 
> Still the file should better be added before device_add() is called.

Noted, let me see if I can get to fix this until someone jumps in before
me.

> 
> > >  - Why does optee_probe() in drivers/tee/optee/smc_abi.c unregister all
> > >    optee devices in its error path (optee_unregister_devices())?
> > 
> > This is mostly to take care of if any device got registered before the
> > failure occured. Let me know if you have a better way to address that.
> 
> Without understanding the tee stuff, I'd say: Don't bother and only undo
> the things that probe did before the failure.
> 

True, but this is special case where if there is any leftover device
registered from the TEE implementation then it is likely going to cause
the corresponding kernel client driver crash.

-Sumit

