Return-Path: <linux-efi+bounces-4720-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B0B50DA2
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 08:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BE81894EAE
	for <lists+linux-efi@lfdr.de>; Wed, 10 Sep 2025 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F607302162;
	Wed, 10 Sep 2025 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzJU2rH5"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE385C133;
	Wed, 10 Sep 2025 06:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484120; cv=none; b=QI/pmEp2/sEorIZLw4lC/huMwzFe/GqczexAy4JQ5vZOdlIH7NyMAo6hBD0HMgR7VDNycOVwBzg/yo0KzEvwPvAxz9HDtkfaTskLO9hDFbl62vi2hc8RmzpqbbfAGLJzJCRLovTRcZgOyuDfRFdLsB2xixnzpRs98TKZQw0jUL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484120; c=relaxed/simple;
	bh=BQupjcom55woG6Sh53IRhAcdsd3+WTxEdJSNaUOX+v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBqvv3dMitmOmskK1YvSQTmIBAMfsn/RMyZJaxqtoM/YkLfyQjJvKnt/du0OXLOpttB+ycsj6VqJn9tTn6+AWCJHTb13E63s+sA76KxUAHuUm/720pBWnqzStXQsEtnYN5uSPkCbtov309WRupWAEn1UWFQAehrTZdmuDCpX+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzJU2rH5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7724df82cabso7299789b3a.2;
        Tue, 09 Sep 2025 23:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757484118; x=1758088918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQupjcom55woG6Sh53IRhAcdsd3+WTxEdJSNaUOX+v0=;
        b=kzJU2rH55JAGRDZA8ynYoUmdWj3rAwLJ2JBgIuWc0yaPizuharEpfJo6EIeh2ouOOm
         SHJiPaXYyS1Sia/V5R7xHFsclxdFqhAH6XtPkvYiil0YW2ec+Mh0WteDSaLpK3UV28kV
         f4dSAM5N/imCBl/TTNvHlIQmvr5siGNedryW5tVnEbBY7up/hj11uFThboVNv2kVuTdj
         rzB9Ssbyl9S9iATvbv/dxxKMBUGg7fTGyT+lCk36J/2n4Gizsds4fcyLxbkwoNj04yWo
         v+KAPg+WcvAupINpleFDhFgNfGwwS/JyiVQbCx6ut1soWOKfRWXPq8i/sYYL5g1keVcc
         TXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757484118; x=1758088918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQupjcom55woG6Sh53IRhAcdsd3+WTxEdJSNaUOX+v0=;
        b=SmHvHgai3sf4aUs/Tx3VhFfDDIFF/H6KHH7/OIAmckUaoDwDz6qtWOBuciCgA4t0+v
         JjovRWd3hcdSSDrhSdpiMhSmBTlbrXj8X/LUoQOxP5cPUj99ihpKllxEfBlevuk8i+UI
         fWx7NdpSmQIpALl+aBNAc+6/J2pocN/mRHD7DNbl9SlRd387dx2UB7UQ1xGvSnJ+EjHt
         pj1PqEUBGmEPYg5hGMxoTzfVke6Y+DBKQoSGaBYcaZaHX7flZ1oH2lkEgEavlfoaBYYu
         ZBCSEEZ6vJsCIDtJ3ONxkWoWvz+si6TPSxUR7epo2dMYkCLnOg/VVxB7cXCxsqCWeDGT
         rJOg==
X-Forwarded-Encrypted: i=1; AJvYcCU915tryPATv+qwG2rzTE6mmdAKA/zai8x57I3kffZ39nFgr8h4hpH7QTmzXJ8MkJb4FZhjfwNmqiv9@vger.kernel.org, AJvYcCV/R2ndfOR99dbwM8mPcjR6ncUN/lbeSqoEsAhND9lLZwOKC6p4cKc+xIgirZUsoH/p2G3jSOxOxkdwFrJ1@vger.kernel.org, AJvYcCWxp6nLjY7Tpwy4wGO+UBbSAl9ZlBBURDcdI6wcTnbYN39D1nEkO5VnZrnFbXY0I+fxvoALp6+B5fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxbGlOlfczaPhFIVufXWR5z7qgouErIINwbuhd7P4mp54119Tt
	EZhPBxS8kSIaKzi0ff75h3yhs0k+3h8XRBmTtGuwKl1ZSdUzIQ26XW9u
X-Gm-Gg: ASbGnct18/ZRDZxqCRSuG9sPxLiZWGWUQpQfGgrjVJqHQOwhrv3KQMP5rdmdYovGaQS
	F8FVFEKIcKKPsiDPdyCHhULui1Qn4d8+15nTjc6lBsO8JqPyqXlEnhXfh3nxZAG3khyNWDVWsGB
	EipMtx11dspJFsdPiG8PvUjBu/IFwDqymyWbeBLdSmku/FIPkCYVdxWX3sqHag3tovxZSYAayry
	9HFcMOBFXgKaY/mPy+s/BgBGMDTvfJRXO8vzRTm6Y0PDx8NWjIMTTELkWRMty3YW9Ld64W0o8Bv
	a5clEB/zmfVWs+zb3tjRwcOVfLrq5EMghx7WU5GwteqPiRyA6IDcG9ZPI/74gr97j8dAcvcv+S6
	wU7bvEWhFvwHfzRYdMsEi93VKW1Gs5RL4D6Z8
X-Google-Smtp-Source: AGHT+IE9Bb+/1OygTfKNn8Kmbyq0XcTuRLE4Du0nhd8YG3MZpglD4NTL1R+HA16kMOY0LjL2LkiDWA==
X-Received: by 2002:a05:6a00:3e0f:b0:772:505d:abda with SMTP id d2e1a72fcca58-7742df0cf95mr19067552b3a.31.1757484117955;
        Tue, 09 Sep 2025 23:01:57 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662f9cfdsm3867023b3a.101.2025.09.09.23.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 23:01:56 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 12FC641FA3A1; Wed, 10 Sep 2025 13:01:55 +0700 (WIB)
Date: Wed, 10 Sep 2025 13:01:54 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Message-ID: <aMEUUkVQv2tqpO2L@archie.me>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <0b61b6f3-f11a-494c-9d4e-94ca19fd1eb6@infradead.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wX9bT4DJmcCyioR/"
Content-Disposition: inline
In-Reply-To: <0b61b6f3-f11a-494c-9d4e-94ca19fd1eb6@infradead.org>


--wX9bT4DJmcCyioR/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2025 at 08:25:34PM -0700, Randy Dunlap wrote:
> On 9/9/25 6:57 PM, Bagas Sanjaya wrote:
> > +.. _pe-coff-entry-point:
> > +
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
> > +``EFI_LOAD_FILE2`` protocol with the ``LINUX_EFI_INITRD_MEDIA_GUID`` d=
evice
> > +path. In this case, a kernel booting via the EFI stub will use the ``L=
oadFile``
> > +function on the registered handle to obtain a reference to the initrd.
>=20
> drivers/firmware/efi/libstub/efi-stub-helper.c (line 509) says LoadFile2
> protocol. Is that the same as the LoadFile function?
>=20
> https://github.com/u-boot/u-boot/commit/ec80b4735a593961fe701cc3a5d717d47=
39b0fd0
> (the link below) also says LoadFile2() 4 times (and LoadFile 0 times).

=46rom UEFI spec [1], both LoadFile and LoadFile2 protocol versions of Load=
File()
function has same prototype but somewhat different in behavior. To answer
your question, however, I think so.

EFI folks, what are your opinions?

Thanks.

[1]: https://uefi.org/specs/UEFI/2.10/13_Protocols_Media_Access.html

--=20
An old man doll... just what I always wanted! - Clara

--wX9bT4DJmcCyioR/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMEUTgAKCRD2uYlJVVFO
o5mQAP9ZTGLecYvygYu5qw9wk0bzOGd+dBF08ZBGDPNzsDaKSwD+Pd6CTNLpWuet
SidxBU1eQylKAqmw7Rj0FLux+E4SiQo=
=OII+
-----END PGP SIGNATURE-----

--wX9bT4DJmcCyioR/--

