Return-Path: <linux-efi+bounces-5964-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC60D0415C
	for <lists+linux-efi@lfdr.de>; Thu, 08 Jan 2026 16:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1A6030DF8D0
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jan 2026 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BC033A9C2;
	Thu,  8 Jan 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcQ03nkU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4C4F7988;
	Thu,  8 Jan 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875932; cv=none; b=VvMYeM9ABgj949+HlkSkQZhrkaQhCBYgUVMIv1uAKOe7iTf8lOwfpdA2fph8XVKwzBYwQH0iZJgUFu3caC2aKlYotgr1NgqaTL+dqmTp388vxn4n2F5F58gc1GTW1yF0PyvZY/PdJOvaVGmHNqyNTIsA7daqpBjtiwpv1Ws8zAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875932; c=relaxed/simple;
	bh=rRFi3QZQyDSaI7EXHpS+Y+kBFm4kORrlVSy4ytIs2fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDNag115vHsWlTOqDYnsdU68esDDb1FEKxqwn7kspNPKlo4Cymr/EzNgart3tLYJ1ZwbnQdWHcoNQa+OVK9iZSqq34mlgQ1vekoV/xqiwe4WKy6i5GlJv/Lq/V28LZiKmoOeGYwoByZRo/g9AZbnv8f3MA1QkyeAi+CO2uh5L+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcQ03nkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6B5C19421;
	Thu,  8 Jan 2026 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767875932;
	bh=rRFi3QZQyDSaI7EXHpS+Y+kBFm4kORrlVSy4ytIs2fw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcQ03nkULZY4K2hMjKQzQb8YD9w6WhEP3klYpCG+pWcCHsTOBSZ90PqbgcJKXJovv
	 u8OD+4y7+CncU5AcgUfx1htEWuUa0cIq7hb4dxyjOtdlPB1eulPhveHYa5j73fdcl6
	 sH9lG5DXnX4gp9r69jltDWJkQje7FeNkCYdX9/GtKapJHSqB6kBBfoFa+BgmM24s52
	 brKBSleGLrtxHlIUi8E1D76cIKGJvhYJLQ8eD0ELJt3SKAdBthw3NijmMKitI/gaQw
	 vqbpoJIClRizqweRds5+lj/l1xCPIcjQG6a36w/jNXfn5OuZFhSuCGHvoDrFqM4VMH
	 UC/ME8YN46EpQ==
Date: Thu, 8 Jan 2026 14:38:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Garg <sumit.garg@kernel.org>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org,
	netdev@vger.kernel.org, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <aV-lV5l-rwyceWqr@kernel.org>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
 <20251218135332f323fa91@mail.local>
 <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
 <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com>

On Mon, Jan 05, 2026 at 10:16:09AM +0100, Jens Wiklander wrote:
> Hi,
> 
> On Thu, Dec 18, 2025 at 5:29 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Thu, Dec 18, 2025 at 2:53 PM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > On 18/12/2025 08:21:27+0100, Jens Wiklander wrote:
> > > > Hi,
> > > >
> > > > On Mon, Dec 15, 2025 at 3:17 PM Uwe Kleine-König
> > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > the objective of this series is to make tee driver stop using callbacks
> > > > > in struct device_driver. These were superseded by bus methods in 2006
> > > > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > > > > methods.")) but nobody cared to convert all subsystems accordingly.
> > > > >
> > > > > Here the tee drivers are converted. The first commit is somewhat
> > > > > unrelated, but simplifies the conversion (and the drivers). It
> > > > > introduces driver registration helpers that care about setting the bus
> > > > > and owner. (The latter is missing in all drivers, so by using these
> > > > > helpers the drivers become more correct.)
> > > > >
> > > > > v1 of this series is available at
> > > > > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@baylibre.com
> > > > >
> > > > > Changes since v1:
> > > > >
> > > > >  - rebase to v6.19-rc1 (no conflicts)
> > > > >  - add tags received so far
> > > > >  - fix whitespace issues pointed out by Sumit Garg
> > > > >  - fix shutdown callback to shutdown and not remove
> > > > >
> > > > > As already noted in v1's cover letter, this series should go in during a
> > > > > single merge window as there are runtime warnings when the series is
> > > > > only applied partially. Sumit Garg suggested to apply the whole series
> > > > > via Jens Wiklander's tree.
> > > > > If this is done the dependencies in this series are honored, in case the
> > > > > plan changes: Patches #4 - #17 depend on the first two.
> > > > >
> > > > > Note this series is only build tested.
> > > > >
> > > > > Uwe Kleine-König (17):
> > > > >   tee: Add some helpers to reduce boilerplate for tee client drivers
> > > > >   tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
> > > > >   tee: Adapt documentation to cover recent additions
> > > > >   hwrng: optee - Make use of module_tee_client_driver()
> > > > >   hwrng: optee - Make use of tee bus methods
> > > > >   rtc: optee: Migrate to use tee specific driver registration function
> > > > >   rtc: optee: Make use of tee bus methods
> > > > >   efi: stmm: Make use of module_tee_client_driver()
> > > > >   efi: stmm: Make use of tee bus methods
> > > > >   firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> > > > >   firmware: arm_scmi: Make use of tee bus methods
> > > > >   firmware: tee_bnxt: Make use of module_tee_client_driver()
> > > > >   firmware: tee_bnxt: Make use of tee bus methods
> > > > >   KEYS: trusted: Migrate to use tee specific driver registration
> > > > >     function
> > > > >   KEYS: trusted: Make use of tee bus methods
> > > > >   tpm/tpm_ftpm_tee: Make use of tee specific driver registration
> > > > >   tpm/tpm_ftpm_tee: Make use of tee bus methods
> > > > >
> > > > >  Documentation/driver-api/tee.rst             | 18 +----
> > > > >  drivers/char/hw_random/optee-rng.c           | 26 ++----
> > > > >  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
> > > > >  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
> > > > >  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
> > > > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
> > > > >  drivers/rtc/rtc-optee.c                      | 27 ++-----
> > > > >  drivers/tee/tee_core.c                       | 84 ++++++++++++++++++++
> > > > >  include/linux/tee_drv.h                      | 12 +++
> > > > >  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
> > > > >  10 files changed, 164 insertions(+), 138 deletions(-)
> > > > >
> > > > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > > > --
> > > > > 2.47.3
> > > > >
> > > >
> > > > Thank you for the nice cleanup, Uwe.
> > > >
> > > > I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in my
> > > > tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git/
> > > >
> > > > The branch is based on v6.19-rc1, and I'll try to keep it stable for
> > > > others to depend on, if needed. Let's see if we can agree on taking
> > > > the remaining patches via that branch.
> > >
> > > 6 and 7 can go through your branch.
> >
> > Good, I've added them to my branch now.
> 
> This entire patch set should go in during a single merge window. I
> will not send any pull request until I'm sure all patches will be
> merged.
> 
> So far (if I'm not mistaken), only the patches I've already added to
> next have appeared next. I can take the rest of the patches, too, but
> I need OK for the following:
> 
> Jarkko, you seem happy with the following patches
> - KEYS: trusted: Migrate to use tee specific driver registration function
> - KEYS: trusted: Make use of tee bus methods
> - tpm/tpm_ftpm_tee: Make use of tee specific driver registration
> - tpm/tpm_ftpm_tee: Make use of tee bus methods
> OK if I take them via my tree, or would you rather take them yourself?

I don't mind.

> 
> Herbert, you seem happy with the following patches
> - hwrng: optee - Make use of module_tee_client_driver()
> - hwrng: optee - Make use of tee bus methods
> OK if I take them via my tree, or would you rather take them yourself?
> 
> Sudeep, you seem happy with the following patches
> - firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> - firmware: arm_scmi: Make use of tee bus methods
> OK if I take them via my tree, or would you rather take them yourself?
> 
> Michael, Pavan, are you OK with the following patches
> - firmware: tee_bnxt: Make use of module_tee_client_driver()
> - firmware: tee_bnxt: Make use of tee bus methods
> OK if I take them via my tree, or would you rather take them yourself?
> 
> Thanks,
> Jens

BR, Jarkko

