Return-Path: <linux-efi+bounces-5893-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F753CC6B88
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 10:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5389313161E
	for <lists+linux-efi@lfdr.de>; Wed, 17 Dec 2025 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484B339862;
	Wed, 17 Dec 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvAWqDTY"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C80327790;
	Wed, 17 Dec 2025 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765962140; cv=none; b=jjjN4fWc0lHP6MvxJvcOvjFdQjCvzVKohMSxSZKTjPZ+z4J5wcZOfQ7Vp6Cky9LNeGaL3jNS4Lb9tlcSReCbnBxzc4YUpKLYW2Zt717sgJLFew49fg7C/p+PQAnrMZExRAOJTUwY4bmGnRfSei0+7cCHBUJis6t+kQone5hKNms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765962140; c=relaxed/simple;
	bh=TqhCN05lIjCwKdoNH7O27Ib5W/fzrsm853qYAbg7qEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjhQnJ8eVabyu1/cxfl34XHrVRjyhqmoO5eucRgV3MDJaEzESp5uYYIa51XRMlkW1iQ5tgM4pGIK4kEdwuWAl1NGBtyTwzE5fYiQcGvltb1+IvuhaR3q4jEbLlP0ZIsPMpl2T/QAtYjnWPGkQNkSPsxdvtDLLDp2K1ZWlDKvxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvAWqDTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8E2C19421;
	Wed, 17 Dec 2025 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765962140;
	bh=TqhCN05lIjCwKdoNH7O27Ib5W/fzrsm853qYAbg7qEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvAWqDTYEQLPIjasUrs0D/Ze97eatlfyL0mi6O0MGmE1SvVn8YHYiQ1hDIZZ4oE8K
	 aFHFHT2tvqpmtTdxeiwwsKJeoEVwVelMoe4qdWjAQvcLtXTPchbIZ+ReSJGYbTCzr1
	 qqsGRlLlswi0jMZNei2mTasXnvX0lpJbqMF7UmTpaAoqX1N9T1UOPYMMpKw8Gfqhqh
	 UjNPCvimUrrUtTiIKv9N5Ccmev+XKHhu1cfOPYdPmfSUBm4ahYUsPiFyqCCGB8H6UA
	 JpzEUlNfSO+k+Tl5V8osBsBwXeYIjSzePF5a/zlMumvvZfIBKHX3GrTd0HYyuz9UeN
	 OzpkhIbfzPmTw==
Date: Wed, 17 Dec 2025 14:32:02 +0530
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
Message-ID: <aUJxiioKnDVSC34H@sumit-xelite>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aT--ox375kg2Mzh-@sumit-X1>
 <dhunzydod4d7vj73llpuqemxb5er2ja4emxusr66irwf77jhhb@es4yd2axzl25>
 <CAGptzHOOqLhBnAXDURAzkgckUvRr__UuF1S_7MLV0u-ZxYEdyA@mail.gmail.com>
 <ayebinxqpcnl7hpa35ytrudiy7j75u5bdk3enlirkp5pevppeg@6mx6a5fwymwf>
 <aUJh--HGVeJWIilS@sumit-xelite>
 <max5wxkcjjvnftwfwgymybwbnvf5s3ytwpy4oo5i74kfvnav4m@m2wasqyxsf4h>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <max5wxkcjjvnftwfwgymybwbnvf5s3ytwpy4oo5i74kfvnav4m@m2wasqyxsf4h>

On Wed, Dec 17, 2025 at 09:21:41AM +0100, Uwe Kleine-König wrote:
> Hello Sumit,
> 
> On Wed, Dec 17, 2025 at 01:25:39PM +0530, Sumit Garg wrote:
> > On Tue, Dec 16, 2025 at 12:08:38PM +0100, Uwe Kleine-König wrote:
> > > On Tue, Dec 16, 2025 at 01:08:38PM +0530, Sumit Garg wrote:
> > > > On Mon, Dec 15, 2025 at 3:02 PM Uwe Kleine-König
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > >  - Why does optee_probe() in drivers/tee/optee/smc_abi.c unregister all
> > > > >    optee devices in its error path (optee_unregister_devices())?
> > > > 
> > > > This is mostly to take care of if any device got registered before the
> > > > failure occured. Let me know if you have a better way to address that.
> > > 
> > > Without understanding the tee stuff, I'd say: Don't bother and only undo
> > > the things that probe did before the failure.
> > 
> > True, but this is special case where if there is any leftover device
> > registered from the TEE implementation then it is likely going to cause
> > the corresponding kernel client driver crash.
> 
> You are aware that this is racy? So if a driver crashes e.g. after
> teedev_close_context() it might happen that it is registered just after
> optee_unregister_devices() returns.
> 

I see your point about the unavoidable race. Maybe it's better to not
try anything and let the kernel client driver fail.

-Sumit

