Return-Path: <linux-efi+bounces-5949-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CE5CFD1B8
	for <lists+linux-efi@lfdr.de>; Wed, 07 Jan 2026 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323C1302D2BF
	for <lists+linux-efi@lfdr.de>; Wed,  7 Jan 2026 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2465B30FF36;
	Wed,  7 Jan 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsB5UQYB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4530DD01
	for <linux-efi@vger.kernel.org>; Wed,  7 Jan 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778716; cv=none; b=meD9Z7F6ZAdb9XDMVZwEDfGxm97JnexpzX9+XNdwFDzkGzvufq1tQ7+0nZYII1nRLUPOD23hln3x8X8RDYnmVW5j3EZKxXFXAqeKhGAwJKr+IcEdsfef67zt0Xy3jCFKorxC/LzhZhNqOUWVE1InmaUeeeGwk3VuUstSACy/EuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778716; c=relaxed/simple;
	bh=eHItNXSuFuiIX4AdsQWnDjqU/WQZ3vk3O/CYr5Z0/cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OloewGM3I2ij0KQdmw659A0svNnp6bGe0tK3Mlc7vu4QwsQLy1/3haMkTSbRElMDItpK5g7dfUt7oIjMwwclxvcX0U7JuD3WcP9OLy3GF48sPE7aLXdpieWIY+wNMOLicu2H+imxCobA6aT4mHB3PcJx7QVJDM4K/zTxFRRTNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PsB5UQYB; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-659848c994bso930927eaf.3
        for <linux-efi@vger.kernel.org>; Wed, 07 Jan 2026 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767778710; x=1768383510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzcLdE5lW6KjrMioL4MVcYHG8ltNGC1zHqzO2YGzVIs=;
        b=PsB5UQYBAZoi7z0hWcL+39f21zYQ6lVLIsVZh77ruPXbOslr7D9WUJ/9vNWIrXg43d
         Lq1EKfflcFKl+wiiJ6WxKEfmAQVRmJuXVP9I3tht1b47lQnOJRJagdFBnzAcxA/bd0k0
         ad9/Nqt53Hk5crV2ZW08Cq9hylzWf93Vdo7CtTKI55fG78WhNPJXB8qhVem5nztZ1KEZ
         KMR1N0TDldtdHdnpKu64je8P/kcOwl+bMag3AGPdcrG8iBtRsvhM+p4Pxm5HN19quSvK
         yl/GY0LO/wJ8F4uuILMzNPZS0AvVQ1MHFgw+a8+Bsb+fucCdHOIbDc+ApTBPL4j9ovCJ
         LaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778710; x=1768383510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzcLdE5lW6KjrMioL4MVcYHG8ltNGC1zHqzO2YGzVIs=;
        b=t57fiOFhAtRiMhQ58WFTO+iSC+A6FGstKfH+/NVTGNMVzF/QdFbbBlRfMQJsvo1iCs
         PyPLepGOjmfTU94wOA61vVgvIMlwcVxLq8otQduVrBltEPlriuw2kgAV2nJsegJq9g4+
         BnYY+Z77rWOzIXc7Z6J9ZjXeV9abKl9UwSB8KhVx3QwLi8roKP2lnamKwbf43aIJb4fN
         bL9Mt4SXmpwenG4QiFoiZfkaWMfRG9CKSwYm7IgITAjpx9gu3wOXeMu7iuFreG2px4ik
         3W0Kcicxb6FLCGlEFAcLS3+kQFykONCkqEluLFsxitK8NG5TJVCLUmZBTfgqfaME9PVl
         qFig==
X-Forwarded-Encrypted: i=1; AJvYcCVTOYSijAR3cPxNeQfvl+aO9K0aD/jCPobjRcN8QnLbQbQZnq4WQfVaJuGIEXgp+znz3pwqkNb3zWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGiyV/tQZWY8wcYuAVoJpIWAjg63zUSfh/4SvpcdpQPWaDPPh
	Mj07+WLHlOnSRbND3MW5Pcu4hm6PjVYSj9VBkh2Abm5eRcn73znJ2V4G7WWHanSV9m40YKmkAKj
	OPB+VVj+xIS48fmLZIL6G3I0n0Q2nbouAS6UUq3238Q==
X-Gm-Gg: AY/fxX7iy3aOtV8/5h5f3+gLermL5JnZHm+mTSIv3b8l+0CDzlSO5gdpSbROhujr/FU
	s73Y/WUg4fhAzQ2vnPpzAD8yxzLTVDboeOSPqvwmaVpJHEiXPLNtJzPBK5AUznWtCRgDZC9QdTA
	A32cN73b5760hC4RulkCFC8mo7+jNlPbacVGO61wHjcqIqe5uwg7sGEcBXYi8rgxxtFGM4Ddlxt
	C0JbpFq1Hd//daN2J+RXw/LnXJBK7UT4vzihuu/z9BIFMOZKu0abq9y02SEJ4tenld08Ue9JGw6
	Zo5I40Yu5JYW935M0h0+976bUA==
X-Google-Smtp-Source: AGHT+IHSj3fyWcR8PeI71mFrFGfZpz1gtYlT37IzGcQAYuwipaKr7ifaf9acDpnsMoegGnuUM/krqm4/4tHZyu+YBdY=
X-Received: by 2002:a05:6820:f02e:b0:659:9a49:8ff0 with SMTP id
 006d021491bc7-65f54ef5252mr794898eaf.29.1767778710402; Wed, 07 Jan 2026
 01:38:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
 <20251218135332f323fa91@mail.local> <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
 <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com> <aV0Qx5BOso5co3tm@bogus>
In-Reply-To: <aV0Qx5BOso5co3tm@bogus>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 7 Jan 2026 10:38:19 +0100
X-Gm-Features: AQt7F2rcNsjXN7djR70fxjzIrnv1VtdzPp10juTq1vFrm5vuVSwDuqGbqR3kJLk
Message-ID: <CAHUa44FhRO0AO3nDXSoZ7O_9T3EFB47D34zRooCTd6fhXFzxXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, 
	linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 2:40=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Mon, Jan 05, 2026 at 10:16:09AM +0100, Jens Wiklander wrote:
> > Hi,
> >
> > On Thu, Dec 18, 2025 at 5:29=E2=80=AFPM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 2:53=E2=80=AFPM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > On 18/12/2025 08:21:27+0100, Jens Wiklander wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, Dec 15, 2025 at 3:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > the objective of this series is to make tee driver stop using c=
allbacks
> > > > > > in struct device_driver. These were superseded by bus methods i=
n 2006
> > > > > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shut=
down
> > > > > > methods.")) but nobody cared to convert all subsystems accordin=
gly.
> > > > > >
> > > > > > Here the tee drivers are converted. The first commit is somewha=
t
> > > > > > unrelated, but simplifies the conversion (and the drivers). It
> > > > > > introduces driver registration helpers that care about setting =
the bus
> > > > > > and owner. (The latter is missing in all drivers, so by using t=
hese
> > > > > > helpers the drivers become more correct.)
> > > > > >
> > > > > > v1 of this series is available at
> > > > > > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koeni=
g@baylibre.com
> > > > > >
> > > > > > Changes since v1:
> > > > > >
> > > > > >  - rebase to v6.19-rc1 (no conflicts)
> > > > > >  - add tags received so far
> > > > > >  - fix whitespace issues pointed out by Sumit Garg
> > > > > >  - fix shutdown callback to shutdown and not remove
> > > > > >
> > > > > > As already noted in v1's cover letter, this series should go in=
 during a
> > > > > > single merge window as there are runtime warnings when the seri=
es is
> > > > > > only applied partially. Sumit Garg suggested to apply the whole=
 series
> > > > > > via Jens Wiklander's tree.
> > > > > > If this is done the dependencies in this series are honored, in=
 case the
> > > > > > plan changes: Patches #4 - #17 depend on the first two.
> > > > > >
> > > > > > Note this series is only build tested.
> > > > > >
> > > > > > Uwe Kleine-K=C3=B6nig (17):
> > > > > >   tee: Add some helpers to reduce boilerplate for tee client dr=
ivers
> > > > > >   tee: Add probe, remove and shutdown bus callbacks to tee_clie=
nt_driver
> > > > > >   tee: Adapt documentation to cover recent additions
> > > > > >   hwrng: optee - Make use of module_tee_client_driver()
> > > > > >   hwrng: optee - Make use of tee bus methods
> > > > > >   rtc: optee: Migrate to use tee specific driver registration f=
unction
> > > > > >   rtc: optee: Make use of tee bus methods
> > > > > >   efi: stmm: Make use of module_tee_client_driver()
> > > > > >   efi: stmm: Make use of tee bus methods
> > > > > >   firmware: arm_scmi: optee: Make use of module_tee_client_driv=
er()
> > > > > >   firmware: arm_scmi: Make use of tee bus methods
> > > > > >   firmware: tee_bnxt: Make use of module_tee_client_driver()
> > > > > >   firmware: tee_bnxt: Make use of tee bus methods
> > > > > >   KEYS: trusted: Migrate to use tee specific driver registratio=
n
> > > > > >     function
> > > > > >   KEYS: trusted: Make use of tee bus methods
> > > > > >   tpm/tpm_ftpm_tee: Make use of tee specific driver registratio=
n
> > > > > >   tpm/tpm_ftpm_tee: Make use of tee bus methods
> > > > > >
> > > > > >  Documentation/driver-api/tee.rst             | 18 +----
> > > > > >  drivers/char/hw_random/optee-rng.c           | 26 ++----
> > > > > >  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
> > > > > >  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
> > > > > >  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
> > > > > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
> > > > > >  drivers/rtc/rtc-optee.c                      | 27 ++-----
> > > > > >  drivers/tee/tee_core.c                       | 84 ++++++++++++=
++++++++
> > > > > >  include/linux/tee_drv.h                      | 12 +++
> > > > > >  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
> > > > > >  10 files changed, 164 insertions(+), 138 deletions(-)
> > > > > >
> > > > > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > > > > --
> > > > > > 2.47.3
> > > > > >
> > > > >
> > > > > Thank you for the nice cleanup, Uwe.
> > > > >
> > > > > I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in=
 my
> > > > > tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/li=
nux-tee.git/
> > > > >
> > > > > The branch is based on v6.19-rc1, and I'll try to keep it stable =
for
> > > > > others to depend on, if needed. Let's see if we can agree on taki=
ng
> > > > > the remaining patches via that branch.
> > > >
> > > > 6 and 7 can go through your branch.
> > >
> > > Good, I've added them to my branch now.
> >
> > This entire patch set should go in during a single merge window. I
> > will not send any pull request until I'm sure all patches will be
> > merged.
> >
> > So far (if I'm not mistaken), only the patches I've already added to
> > next have appeared next. I can take the rest of the patches, too, but
> > I need OK for the following:
> >
>
> [...]
>
> >
> > Sudeep, you seem happy with the following patches
> > - firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> > - firmware: arm_scmi: Make use of tee bus methods
> > OK if I take them via my tree, or would you rather take them yourself?
> >
>
> I am happy if you want to take all of them in one go. I think I have
> already acked it. Please shout if you need anything else from me, happy t=
o
> help in anyway to make it easier to handle this change set.

Thanks, I've applied all the patches in the series now, since it
otherwise causes warnings during boot.

/Jens

