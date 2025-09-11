Return-Path: <linux-efi+bounces-4732-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA87B53166
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 13:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303D5165EF5
	for <lists+linux-efi@lfdr.de>; Thu, 11 Sep 2025 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F32E8DF3;
	Thu, 11 Sep 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcqFlboC"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016782C159A;
	Thu, 11 Sep 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757591438; cv=none; b=QiPTjlCoylBOneQRDvCit1XDIxE95rmvtsTjBGz2sR5KuceSDx79zqglnGgxNx3IwB+UgtMOLvA6OsohG/hJVLLnsR2FwD+GFhjRopBXNUbrfXYFUJhVc8p0DvuW6ArsybPn9FBec5RPthg68JXyDGQEWwqiElLxnbmKbTBm50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757591438; c=relaxed/simple;
	bh=EpZa+svNV4qrmtWACPZ9BCc39P+d1Ph7ttNi7LFJYKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIoR4k4dBS6DOdCKLivKYkcgPCX5gTgDe7bzy2IUC0Kqm1UGUOytgQh39uRZQBaVajHLzI/6HAA0WHK1NSayIIgMW1Z+3ZHT/rJ63NVbMmNO24eEg0eG7TwaR6VjTuAdULBVeYTHUre7ivjbXkap+aSVWR3LHXfpMDHcU01ZyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcqFlboC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4f7053cc38so413424a12.2;
        Thu, 11 Sep 2025 04:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757591436; x=1758196236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpZa+svNV4qrmtWACPZ9BCc39P+d1Ph7ttNi7LFJYKE=;
        b=DcqFlboCSXc8FK6N2JbviAfevXiMuPerBYOjk4XngNqJxA7AMmis+aj7ALuLi8ArGg
         gPEGqdi05t412M8seyTFeczKCPzFHu9eOkmgxpzWnJK33/ipBnNtM7TF5HO2DNmli1Nm
         hHSVN1JXyocuCkllsQyDaMCarHAoaZNhCF0ecHdxb4Cpoxm5XBe/zmXyt3o9HLl+Hd+0
         9A+zHiRZajr6ncYv6C/TEWrcIg4Ts0zoYhuzB16BCxwSm9bBcGtJJlIHQ8TMhGjbwX/C
         yvJdmOIoEqwAsqhYNbQWSTIQk3yR3VjEA3JmDXd3hRG8xvnZghTYE+pCM89iZopcyFJf
         h0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757591436; x=1758196236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpZa+svNV4qrmtWACPZ9BCc39P+d1Ph7ttNi7LFJYKE=;
        b=nwO/zbReNkxec6YamWjt1hbO3NvPlgoq0cx1qFc1u2G2llGKSrL6Ol/WQBR4HiezYK
         1wdKNNVgh7dHb5U5eGf0WTvakK9ojtVSPRhal2EThnxFTemjcsxyiVWdl5WX+tsUpxmB
         IZJmjDIRCC/KPzwFt+QZ8i9IbM5GsG54jmLd/OLXlOAYoqqpBLF6VKb5rP6QbDcwuVVS
         4KQu9yELlOiH+Ze86+/J/w8o7tiX+A4Y9/HC8saIj+Vq2EJ2VcydANm9ZoxBLMXtBkEq
         0WISpzPJxXL8ehnCXuaG3WmY6KmbPNY6Rs18IvNSIUvTEY1IxnoOAPo2xxsCMZYqlWR8
         pUJg==
X-Forwarded-Encrypted: i=1; AJvYcCVJn59hSWOVygVSBCXEL9q28i+zk5lbLEgrPeDa0Kd5QNSmM09UZvedjoeSDVq6Kq8PGe0Y/eDo2+k=@vger.kernel.org, AJvYcCWJohQAnZGzcnGOK5SL+ZYbu5960h45YhgHqJNfPIR4m0UC+cSDRwcI2SRYJV5rBqz3zZTxU8kqvG3p@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLWxj6to5b2EUls4Tk+W0Uuv/I98r1igYJ9yk7vP70UUuke/A
	7wYY7BwOrQBdZL16BogCYdKgjkwdq+eLmdaopTKYOZGpPmazDt5mnr1o8OIQLobg
X-Gm-Gg: ASbGncv0m9Rfqtu2Nr30d1xvLa8PuoLUqaAR+YfMo8DVFthQbzfiCEq79WZNBYxAHoJ
	V5Pfrb6A+/7dPZRP4XJRMqw6lLXRpcp4YtnQjr0w4jCMZVdOe31EPrCLQ1jfj0s720X5HQ1fage
	7v0wNlAzKvEZtiO3jmmw8d0jy16W6tJqpTcw8yfklky0RQPDlGixCECig38YrGijMpxjfX4e4Zs
	6kYMhZJCdEu5FLLFUfYm7pinYoWDXIK1zWGsUH0YbxJajfx55rbPt+RQiYJlQLYHvHVaYmoR4qS
	YepXiL1QVOX3bVeqGAJA/Y9R6WGNR84BPKX98L5d6xxbUVJYI4fL/SeEJJusksmcn8UotB6CeEq
	GSTkHA+AWNrvD3T3ednjRcsZt3Q==
X-Google-Smtp-Source: AGHT+IGo4cNTzv8D/C3O5jzdK4t4nju+tLQ5RjuQxdw+dRvSukvm1eBI227YW3OZNuKSPWPl/Uwu1A==
X-Received: by 2002:a17:902:f644:b0:25c:8aa4:db9b with SMTP id d9443c01a7336-25c8aa4de8amr11417045ad.55.1757591435081;
        Thu, 11 Sep 2025 04:50:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a486sm17194565ad.65.2025.09.11.04.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:50:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3852F41FA3A1; Thu, 11 Sep 2025 18:50:32 +0700 (WIB)
Date: Thu, 11 Sep 2025 18:50:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/Documentation: explain LINUX_EFI_INITRD_MEDIA_GUID
Message-ID: <aMK3h1zvHc0sK-F3@archie.me>
References: <20250910015738.14848-2-bagasdotme@gmail.com>
 <CAMj1kXHCi1pr3XNzwe7b7EFBkPGjkppeNWNSvy4wU1VBHj9kfA@mail.gmail.com>
 <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQMjPvYcKYXv/Znk"
Content-Disposition: inline
In-Reply-To: <c30fb598-2878-4bdd-ab84-4f4d07d0db5d@app.fastmail.com>


--pQMjPvYcKYXv/Znk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 01:22:54PM +0200, Hugo Osvaldo Barrera wrote:
> On Thu, 11 Sep 2025, at 08:46, Ard Biesheuvel wrote:
> > On Wed, 10 Sept 2025 at 03:58, Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
> >> +.. _pe-coff-entry-point:
> >> +
> >> +PE/COFF entry point
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +When compiled with ``CONFIG_EFI_STUB=3Dy``, the kernel can be execute=
d as a
> >> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> >> +implementation details.
> >> +
>=20
> This should be a link rather than a path to the source file.

I think you miss the point of Jon's comment on your original submission [1].
Long story short, in Sphinx, one would cross-reference to other documentati=
on
files (so-called internal linking) either with :doc: or :ref: directives. In
case of kernel docs, there is third and preferred way: simply mentioning the
full docs path. The latter is preferred as it is simpler and also allows
building only portion of docs (with make SPHINXDIRS=3D<dir>) without trigge=
ring
any reference warnings. Hence why I did addressing his comment.
For more information, see Documentation/doc-guide/sphinx.rst.

Thanks.

[1]: https://lore.kernel.org/all/87ecx1x4su.fsf@trenco.lwn.net/

--=20
An old man doll... just what I always wanted! - Clara

--pQMjPvYcKYXv/Znk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMK3hwAKCRD2uYlJVVFO
o36/AQDD19K0EP/+/owVXzhNUdOG9EOWEnIpWj2tCVMdZuD1PwEA3NarBLej0ESv
RU3OAch14DpFEiIzH8kMbTYmc9sG+gk=
=nlH3
-----END PGP SIGNATURE-----

--pQMjPvYcKYXv/Znk--

