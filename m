Return-Path: <linux-efi+bounces-62-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC17F1D74
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 20:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184901F25ABF
	for <lists+linux-efi@lfdr.de>; Mon, 20 Nov 2023 19:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739912032E;
	Mon, 20 Nov 2023 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4666FAA;
	Mon, 20 Nov 2023 11:43:22 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c875207626so29253871fa.1;
        Mon, 20 Nov 2023 11:43:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509400; x=1701114200;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoDQY8tzkpHkEpiRQUrc2MUWOLDGwsPrZjscsfAC4Bc=;
        b=CKHLB+rrRCzojZxK4AcIAcau8Paa9nu+nEb0zXnC6qjIp56sKh8Rp2sHcGE+wn25mN
         BTJMyfzx2bWiDUweOEX2/By00autxZHw1jFN9p06cXMKrvyq184XWHxor5QIclEbQfzt
         8cSV1VBL3ebMbeKUN1WfdkzfGoOHYJGkgYLyMNhch0E/XbXhJF9pqQK8yhmyO938oF7E
         sfIAwCqcBgcSgvn3PFEoIxEDTKXNKIISvC6EMnsyQsIKYlAxkv2y6lqbZokKQZwiSyek
         /lOpQUUYbh3jJotY6Q3m9M3oEiraZKLIvZyX4snSM4YS7fgc3LO8c/pCdBZuqusWc17G
         ZaRw==
X-Gm-Message-State: AOJu0YxeNMj+THOLWAeuRjGg/aGXMe9KV/D+1S0m0Ocvr4Mj4uRWSYZ3
	WsZsF8y26WKDyoVTkbs+ga8=
X-Google-Smtp-Source: AGHT+IFgP9xwbAn+TkemJm6kqzasJzlvxUci/1NJbwtda3ur0jxfbWqOdV5Xw2lCvTNCnJ7Bf2qfkA==
X-Received: by 2002:a2e:9015:0:b0:2c8:3613:d071 with SMTP id h21-20020a2e9015000000b002c83613d071mr5751720ljg.36.1700509400076;
        Mon, 20 Nov 2023 11:43:20 -0800 (PST)
Received: from localhost ([137.220.119.58])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b0040772934b12sm19201399wms.7.2023.11.20.11.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:43:19 -0800 (PST)
Message-ID: <ea1a678bdbfe5c492aa494d93476bb18e6dfec5e.camel@debian.org>
Subject: Re: [RFC PATCH 1/2] Modules: Introduce boot-time module signature
 flexibility
From: Luca Boccassi <bluca@debian.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Alessandro Carminati
	 <alessandro.carminati@gmail.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org,  jan.setjeeilers@oracle.com,
 linux-efi@vger.kernel.org, ardb@kernel.org
Date: Mon, 20 Nov 2023 19:43:17 +0000
In-Reply-To: <ZVeyDDLe9B+Aij2O@bombadil.infradead.org>
References: <20230914112739.112729-1-alessandro.carminati@gmail.com>
	 <20230914112739.112729-2-alessandro.carminati@gmail.com>
	 <ZVZS4hw5dGB4aPz3@bombadil.infradead.org>
	 <CAPp5cGTcRGp3z=xbA1svxLYz1LC74_AQrTPSXNmACPRYrpporg@mail.gmail.com>
	 <ZVeyDDLe9B+Aij2O@bombadil.infradead.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WhGM6ktWMElK5x6aVvyJ"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-WhGM6ktWMElK5x6aVvyJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-11-17 at 10:33 -0800, Luis Chamberlain wrote:
> On Fri, Nov 17, 2023 at 02:56:53PM +0100, Alessandro Carminati wrote:
> > Il giorno gio 16 nov 2023 alle ore 18:35 Luis Chamberlain
> > <mcgrof@kernel.org> ha scritto:
> > >=20
> > > I see the code which skips module signature verification and the knob=
s
> > > but I don't see the code which complete the promise to do the actual
> > > signature verification post initrd / initramfs state. What gives?
> >=20
> > My initial intention wasn't centered around providing an automated solu=
tion.
>=20
> It is not even an automated solution, it's *any* solution. So to be
> clear your patch simply disables module verification, it has no
> solution.
>=20
> > Instead, I envisioned a design where users could manually restore modul=
e
> > verification during a specific point in their init scripts.
> >=20
> > It might be plausible to restore module verification when the rootfs is
> > remounted. However, this seems limiting rather than advantageous.
>=20
> The patch as-is describes a lofty world and does nothing other than
> disables module verification. If a patch disables module verification
> it should just do that and describe that. Nothing else. The subject
> of the patch tends to suggest some flexibility it provided but does
> nothing of being flexible, it outright disables module signature
> verification. The commit log and the patch subject description are
> describing something completely different than what the code actually
> does, and it gives me to the concern, to the point that if you didn't
> have a few commit logs in the kernel I would have thought your intent
> was test kernel developers with some AI type of code that does something
> stupid and very carefully crafted commit log.
>=20
> Nacked-by: Luis Chamberlain <mcgrof@kernel.org>
>=20
>   Luis

Hi,

On top of that, this change would go counter to the security posture
that is established by the Lockdown LSM, especially when UEFI Secure
Boot is used. While it would be great if initrds were only ever read-
only, signed, and verified, the reality is that on all general purpose
distributions in use today the initrd is writable by root, and the
kernel command line is also writable by root.

E.g.: on Debian, one just has to edit /etc/default/grub, run a command
and at the next reboot arbitrary kernel command line parameters will be
applied, including this one, and combined with adding an arbitrary
kernel module to the appropriate path this becomes, de-facto, a uid0-
to-ring0 privilege escalation avenue, which is something the secure
boot + shim + lockdown workflow tries very hard to avoid.

While there might be room for such features (e.g.:
https://docs.kernel.org/admin-guide/LSM/LoadPin.html ) in very specific
and defined environment or use cases, at the very least there needs to
be:

- the mechanism to lock it down again very early at boot as indicated
in the cover letter, which is missing as pointed out by Luis
- a kconfig governing the availability of the new kernel cmdline
option, disabled by default
- ideally a check or hook into the Lockdown LSM, so that it can stop
the new kernel command line option, if enabled at build time and if
specified, from actually working when secure boot is enabled, or at the
very, very minimum taint it

Then users wanting to use such a performance optimization will be able
to do so in their own special purpose builds, without negatively
affecting the security story of generalist distributions.

--=20
Kind regards,
Luca Boccassi

--=-WhGM6ktWMElK5x6aVvyJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCSqx93EIPGOymuRKGv37813JB4FAmVbttUACgkQKGv37813
JB5Zyw//Z6kmw2oyyN3baObMYxcX7XlurZnC+rfom0nnnEsICtoxiQb/6o7AOhOh
5yvG7/I31HacifkXgGRsVc6dowjawZqz5KI92pRrix4tO0O4zmJ43CaKWMvdO0mU
5i38sc7vrzMKjlKmyqbKNSxmlfpgnbrGi8lMbm/Jh4QIFvUSv94RuNgvdiDW/OP+
bIrdf55UlS3TdUznrbA8BEAePravcDY8f0KYUIpL2ESau0MWig+n9PUhe5nvsD0E
j857IH6u9UfEsO6ZbbQnoHnzHxGMJJB3fH5ALOyu5NvDnab5wHtLarSwQneLasUw
I3bxlUihdwuQIEKTDwNlRFcMwigCh0rww4MeEHUdaleLkHnyxdLWop748L/oBAhI
60cEb5eUjRomA8K4Eewd0YNgk2ipToHiTiaDW/3coxhCdiLhEOFOAMAGT4Z0wEi1
Icc/rGOG9lnRDRbjkjBHxFXCZG8rKnfQydnCW1bPQ+ieZ5EnG39DwWbY6cZoUST4
ggCy063nKyhFu7RYSbXMAbllLkNhOK/LIPOjA08PuZknAQFDryYJh4SyPMK9uVBp
4431vs3sANoXi9u2rSzwEWJqcBC8CpO8B/94+Gg2bzXFKB0YkOLLqwKWKs377rYT
FjK8cCylT7OHwAVjMTaMszJViUfABVXg2sPLYaUnQGesRE7U/Yc=
=50E8
-----END PGP SIGNATURE-----

--=-WhGM6ktWMElK5x6aVvyJ--

