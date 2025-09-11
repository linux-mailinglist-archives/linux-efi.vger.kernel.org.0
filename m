Return-Path: <linux-efi+bounces-4731-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91413B530DD
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F0D5619A9
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 11:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E832039A;
	Thu, 11 Sep 2025 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ6NWQJl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE231C56F
	for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590610; cv=none; b=rp1is0Qz9kCWz/frggBiZ69S2t01C3MPaQWRABJka06JiQY0U1wZC9ER32foHyea848+MwHsPA7mxpv47zSSiY9k4jfWAM9RndqydJ/0T6sGKqiiQS0Ft5a5zuhDWOVD0m6q8FUXKGL4chscw3kkfaymnfH+VSLX0WGbUwwqjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590610; c=relaxed/simple;
	bh=/rVSsz4zURSRH6cQYurBS9NzYyNvGJ8R8I2UkETrSDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ats6HVOrtYro0zjf+3iqckjsDHz7gmESIhOSLmiwo9jvWyQBl7Axuq8LB6oe2CK5/ot9+mXhCDmFEqBYUXYs9E776F9krSgKSK6U+T3zoAPHN++xqYxX4Tuvh1c7cj69RbUyd09RLYUL3nUTAOvFOyo2eNPR+GlYHr1468DWcvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ6NWQJl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77251d7cca6so579755b3a.3
        for <linux-efi@vger.kernel.org>; Thu, 11 Sep 2025 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757590608; x=1758195408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rVSsz4zURSRH6cQYurBS9NzYyNvGJ8R8I2UkETrSDI=;
        b=VZ6NWQJlM3lS7Fk6lrtVcS6dLeXoqkS9dpJCcH3EKL4AEvDcfsT0XTFIrAWk9a1XGd
         50mYu4L+9pPOGo0ORYIIB5eQuGFd7gu+fkMpHT49fBbTJm4pL5V0fLrQBrQt84vDp5+n
         gJh2Pn2CqvBoavZ9M6gDWGJpEXz932x18yBOjiNUP7Ep2TOoWR518IG95NEHDIv0dqVH
         IRukqx0f3nMgQz/rMVw1fVMTnThIhMsENtAMvinQj6pgCitKqcrxdexQW89BfMY+sncW
         QfBzO6vG0dD3zMfmjDsWXNlohQvDccLu2YqqTdJgkfLCbW4McjuOBdy+UHMhM2uDJjOc
         khSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590608; x=1758195408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rVSsz4zURSRH6cQYurBS9NzYyNvGJ8R8I2UkETrSDI=;
        b=pPp49BzKgHcHM/ZBMjMwv2p0Hr+JdjFAz3cI8vGqyy0m+u0S9eQahfIJgPPCs+3jlk
         IkF3MRKhZDQ0MpaRAdzM3Bs/a/yrx4B3J74w1o4Z9XwFCMX7mWd/7eWo+45E9Zly5Yt9
         EKTh27QDHQR+d/ufYyOMm19PUwA6EdJyy9/NrKccgYUBdS/RprmXQZ589BEECvkPw3IO
         +WHa1fpeAWKJWxcRg1Z3x8pr9NWJyhJTISqdBunxx3Ts4z3zqUDaFXLxQecuUGM++PkB
         kWjYscaK4amCJojhSMkfqnHrvLE3MT6j4wuWkhehxLDYCmiQ7krha2vdMaPd9URiGQ6M
         Ds6g==
X-Forwarded-Encrypted: i=1; AJvYcCWTrwa81ACnEGOu4zDNF68/RedoY9YG9AYHwOFOmLgjfScyx7G0HJSgbAcmPOB8cMIPkxmb5oc6Plo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQk7N0ru6ETPtKVi59LYFfuMYFQ3C3oAA6f0c44nA5QMXV+aZr
	4kAwFPLsNpf3Fmx9XVosQoIAGQOvUJZ4cAzv97brLsHEUKkYSvGsYWDT
X-Gm-Gg: ASbGncvDnudzI62iShXMx4G9eSNKQmxtAl1yoGn/lI9BbDmyfZ1lK5c9RgBF/oOkJa6
	tnqb/vwoamuoM0AKDoUsiRi1hHQnLCsV13KX+vOglGyFWcQi1vLqKwAQc9mJ2XSKZsI2qY/QM3l
	dzPH5yVUvOHnqEj0btE77jIKXSeC2lO3Ddq86Ztwjl1AA65LUjMXpgW2/JSXbV89FgmbDXkmPIS
	SYVDtG6mHOfh9TBcll7HmnBF9Ebmu0Zhxs1AD9xjy3j2AaM5v7vGzfFqcgsAbn9J2eVlrg/CMsG
	07F8iGMpjP7Ho+jDGHqHk3E6yQZ5tIcrIXyRFfjxt4uOm7tWGoqnNbWHrzdDK027K+qw/LUAZXB
	gcg8QKYCULw2jvl44bSZXThf+Ag==
X-Google-Smtp-Source: AGHT+IGODxcwXdfHAsRfp0VXOV718vy1zFbFo7MXwhCxvdkM6aonShv8X7Ss+ZzUqwEpBGF+WUBA0Q==
X-Received: by 2002:a17:902:db01:b0:24d:e8f5:13b1 with SMTP id d9443c01a7336-25171bc0549mr238763465ad.40.1757590607913;
        Thu, 11 Sep 2025 04:36:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc53adsm17096545ad.25.2025.09.11.04.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:36:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2100341FA3A1; Thu, 11 Sep 2025 18:36:43 +0700 (WIB)
Date: Thu, 11 Sep 2025 18:36:42 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Message-ID: <aMK0SnY9NMby4X_F@archie.me>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/CycQuWEbUcN6Xks"
Content-Disposition: inline
In-Reply-To: <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>


--/CycQuWEbUcN6Xks
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 08:46:50AM +0200, Ard Biesheuvel wrote:
> On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > +PE/COFF entry point
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +When compiled with ``CONFIG_EFI_STUB=3Dy``, the kernel can be executed=
 as a
> > +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> > +implementation details.
> > +
> > +The stub loader can request the initrd via a UEFI protocol. For this t=
o work,
> > +the firmware or bootloader needs to register a handle which implements=
 the
>=20
> ... which carries implementations of the ``EFI_LOAD_FILE2`` protocol
> and the device path protocol exposing the
> ``LINUX_EFI_INITRD_MEDIA_GUID`` vendor media device path.
>=20
> > +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` d=
evice
> > +path. In this case, a kernel booting via the EFI stub will use the ``L=
oadFile``
> > +function on the registered handle to obtain a reference to the initrd.
> > +
>=20
> ... will invoke LoadFile2::LoadFile() method on the registered
> protocol to instruct the firmware to load the initrd into a memory
> location chosen by the kernel/EFI stub.

Thanks for the wording suggestions!

--=20
An old man doll... just what I always wanted! - Clara

--/CycQuWEbUcN6Xks
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMK0RgAKCRD2uYlJVVFO
ozStAP9mQA9cCfHsaQldql/hMVFcwMOShKbDfTeC6DADNy+HuQEA8+ArAu2x9zYZ
ON+dh6RUyGHdAxdwM2QwtIT8cv91UQI=
=SYxy
-----END PGP SIGNATURE-----

--/CycQuWEbUcN6Xks--

