Return-Path: <linux-efi+bounces-5883-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD6CC213A
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 12:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2115302EB19
	for <lists+linux-efi@lfdr.de>; Tue, 16 Dec 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038E33D6D2;
	Tue, 16 Dec 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TuhEal39"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046A31E106
	for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 11:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883325; cv=none; b=X6o5k/1/faIE69RHAp2gD+cZCxXkZi9XF6mcF8XJlxVy+X4KQ6WruKgqvP5WlJsY7aOILHVv9lpDcdlW+2W8xOwaz+15LPPCxLOS3arMp0/x+rivQ6xuUYT/vJwSDqMEnD3I7mc192uJz6fb5Rp9bgCHbxXO9NYHztzZGM57WoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883325; c=relaxed/simple;
	bh=7eCpaO8h0XuRWUlnnZDRQQvxiOwboz4wCDo5+3haAtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKTwJFTa7vBq8NQpve8jMMcDJvQ/A4o9gv7kk0foJU0AKBD/fVovUOErBqv5VQ16Pa1pX8TE/y38/x4vggkMNDk+3ojzJajM5w7U4f4/TVJT2UkaIWgwTyujkUN2cqmnvuiEwHp35+74TXymKlKpginauGPtFcsLWWaE7UTYvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TuhEal39; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477aa218f20so29543985e9.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Dec 2025 03:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765883321; x=1766488121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzbZNSoR9XV7c/fw2WEyAJLfwBQw/kZL/Ydt6MIWYlk=;
        b=TuhEal39hD7OzJsRaLhLQRzrJWrmiGxmtcdjrQQEW3h4ZHalghwmMgBq5J88Pvef9/
         1AyxW7vmjGodV8qgsJmC3Dy2PBUX8p80aXi1G2HA0Q/38H1Vz0fvkmnUHJz8oR2nN5nX
         lzluP0XFgEIOQmzX5WCwDHqg9J+STt5D/CvEH5OlmpJa4VBcMX20w6Axb3xxbbFuOjYf
         31xqFcD1UKZguaYIOdSgvBeQRZuFNraMApNS3a1DDHOxFJR/xqGB+OkPq9p1lC/qS+QX
         4siVEiXEDqiCFDLE26nWnEFiiMNdVlDtsnk4gY2ytH0eU23DNANtfygwZ+Fc6a2uvfzK
         eiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765883321; x=1766488121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzbZNSoR9XV7c/fw2WEyAJLfwBQw/kZL/Ydt6MIWYlk=;
        b=KlU78WdtHLR/0LsoDZSdengmhdNthGsiCdtFQU/+s9lmHF0pQDRG/Wj12DdAGaV9Gc
         5pJW4tZEmw0SA3LnbFIS4nqd0QQ63AO3QV1zZN0Ispa+gzsPnGdvWTgVQAkxWJqg368q
         XyDFNPbMJgBclF7pIhMR3Gnq7bCA80SU7xgSgGhBg5Vj2ZxL9ZdeJicHpQx0w+QNnxqb
         R8sLv/GK4omZDllgtwJnFDlETiFCOA0DeXWD0GMBUsBYhjxUECIFJkCUz+D6LvJOyr93
         oRHDWljBzPOacpoxmO1GiOARzEvztEo2kCHW8Ns60AFvPFLciz6mrKJA79W7RXxRtxWP
         0heQ==
X-Forwarded-Encrypted: i=1; AJvYcCWea5/3uFvwIYVJ4OqKf+WfZkwtqiUMPi9KuB/WejbMSfyIR5ofg3yat/Ogzf5hYWq6BnNUBolVl3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfY7zqOutF9JBZbDL/lmio0uqYaCcLLIl4KBegGpzCruVX48ao
	0MuAQ9sruaM+BxUlU4tfql8CSE+el0zsN1kaXskUW+gSbl37itlcIfSqobaPBWgKkS8=
X-Gm-Gg: AY/fxX6nub+rE+bFLS6+DIW1ciNUhgdAEuprOWtry/+XiuwURoHRjwv8fyAyzbsIr7g
	gb6+8c4QwNLgO90yEMEoiah94+zDvserH9RLCJd01FBQ9bVDNu8JUYjrJSbQoh9jGM7VOA9Rvm3
	XRuEl+sKoh76W68TtjeAzNh+t7MEiBg2z9d2Ab99nQbaXTYH2uKePJH2Wng+U2HACuR4fUq+4Hb
	IsIg6uYV5IT0qjfQrZisP8oLSK5WP6Oj4uJf4CdVITA0GFNV705IUiw8JB5VWhSy5ORBYaZO7qC
	4pxO6rvh6vZCAnwGD8enuejP0URvt7C+HekB7mRqtjlN9fq8T2dHQ7HZaZgajrR6XqVycjUFcBt
	9zgSES4SLWyq39VXCf9GHNuSkzXNbiKv0BqpMvrVbzYxfjAXuqb3me/l/5rw0At3dLz1NDlqMsr
	5pzvAchVO+Pafn2IBURceE9AZqdq+DRcQAXp78QQkv8kvuMQFrimgtqjJQes/igm1OB6P/4TVMw
	3w=
X-Google-Smtp-Source: AGHT+IFp5IncMGvMC+pwiacOOoEIbditx6SKu86limMmxyrWyAZX1pq9RrgklnX8yEKbt8tmwVfkyQ==
X-Received: by 2002:a05:600c:8288:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-47a8f8c0caamr134941025e9.13.1765883320955;
        Tue, 16 Dec 2025 03:08:40 -0800 (PST)
Received: from localhost (p200300f65f00660852dfbbf029d2e03c.dip0.t-ipconnect.de. [2003:f6:5f00:6608:52df:bbf0:29d2:e03c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47a8f4ace61sm233401395e9.7.2025.12.16.03.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:08:40 -0800 (PST)
Date: Tue, 16 Dec 2025 12:08:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, netdev@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver
 callbacks
Message-ID: <ayebinxqpcnl7hpa35ytrudiy7j75u5bdk3enlirkp5pevppeg@6mx6a5fwymwf>
References: <cover.1765472125.git.u.kleine-koenig@baylibre.com>
 <aT--ox375kg2Mzh-@sumit-X1>
 <dhunzydod4d7vj73llpuqemxb5er2ja4emxusr66irwf77jhhb@es4yd2axzl25>
 <CAGptzHOOqLhBnAXDURAzkgckUvRr__UuF1S_7MLV0u-ZxYEdyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="judjbtjlccebrcda"
Content-Disposition: inline
In-Reply-To: <CAGptzHOOqLhBnAXDURAzkgckUvRr__UuF1S_7MLV0u-ZxYEdyA@mail.gmail.com>


--judjbtjlccebrcda
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 00/17] tee: Use bus callbacks instead of driver
 callbacks
MIME-Version: 1.0

Hello,

On Tue, Dec 16, 2025 at 01:08:38PM +0530, Sumit Garg wrote:
> On Mon, Dec 15, 2025 at 3:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> > On Mon, Dec 15, 2025 at 04:54:11PM +0900, Sumit Garg wrote:
> > > Feel free to make the tee_bus_type private as the last patch in the s=
eries
> > > such that any followup driver follows this clean approach.
> >
> > There is a bit more to do for that than I'm willing to invest. With my
> > patch series applied `tee_bus_type` is still used in
> > drivers/tee/optee/device.c and drivers/tee/tee_core.c.
>=20
> Oh I see, I guess we need to come with some helpers around device
> register/unregister from TEE subsystem as well. Let's plan that for a
> followup patch-set, I don't want this patch-set to be bloated more.

Don't consider me in for that. But it sounds like a nice addition.

> > Maybe it's
> > sensible to merge these two files into a single one.
>=20
> It's not possible as the design for TEE bus is to have TEE
> implementation drivers like OP-TEE, AMD-TEE, TS-TEE, QTEE and so on to
> register devices on the bus.

So only OP-TEE uses the bus for devices and the other *-TEE don't. Also
sounds like something worth to be fixed.

> > The things I wonder about additionally are:
> >
> >  - if CONFIG_OPTEE=3Dn and CONFIG_TEE=3Dy|m the tee bus is only used for
> >    drivers but not devices.
>=20
> Yeah since the devices are rather added by the TEE implementation driver.
>=20
> >
> >  - optee_register_device() calls device_create_file() on
> >    &optee_device->dev after device_register(&optee_device->dev).
> >    (Attention half-knowledge!) I think device_create_file() should not
> >    be called on an already registered device (or you have to send a
> >    uevent afterwards). This should probably use type attribute groups.
> >    (Or the need_supplicant attribute should be dropped as it isn't very
> >    useful. This would maybe be considered an ABI change however.)
>=20
> The reasoning for this attribute should be explained by commit:
> 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration").
> In summary it's due to a weird dependency for devices we have with the
> user-space daemon: tee-supplicant.

=46rom reading that once I don't understand it. (But no need to explain
:-)

Still the file should better be added before device_add() is called.

> >  - Why does optee_probe() in drivers/tee/optee/smc_abi.c unregister all
> >    optee devices in its error path (optee_unregister_devices())?
>=20
> This is mostly to take care of if any device got registered before the
> failure occured. Let me know if you have a better way to address that.

Without understanding the tee stuff, I'd say: Don't bother and only undo
the things that probe did before the failure.

Best regards
Uwe

--judjbtjlccebrcda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlBPbMACgkQj4D7WH0S
/k50zggAsVQDsAnPdX//uyplsEvssm5818ssVGID4+9TjkXIhLGs1HOk+Aj1Obfh
3kp723jXSfcxla/GVnutv+SGgjCbWQLat1zF3XNhzFZBDegNnPHffiYotY4NYV+x
z+cBC6Mgx1s9c5xNg134fGOJ+TxBlfUxarnCrkXKqWF+dVSwTe5Cv3f0SXlVU/7L
l/3T0OflRgILL2Y6wod6E9ydmYfiSapc79eKAzVY5jnUx1sGt7oLNYrjpHmJklBF
J4I7ToK96aPowluUQqNPzlS13OTb/sx00zg5CnrrGchqVR6i1kK71xhoszfQPcx5
IOs/eRzJsAmcF/JiN04ZsRRMrAvppA==
=QAXr
-----END PGP SIGNATURE-----

--judjbtjlccebrcda--

