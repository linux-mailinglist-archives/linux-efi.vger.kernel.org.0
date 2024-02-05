Return-Path: <linux-efi+bounces-471-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49560849246
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 03:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD2D2B22371
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6217F;
	Mon,  5 Feb 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWZcksxu"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB0479CD;
	Mon,  5 Feb 2024 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707098769; cv=none; b=PDJ94uc/yUaoGBsHJDRL3FieHtE0D6angHFrtikBGOH54UTZ+YRAnenVkIaER5zIqN7lWehVtWYZg8DGbHtyft0S0NIn3HrHEwwA5ipgxWkz5m1KEfQQ4Gwy2H0l8d5dEWWyA802Yd3eXURJfNcregDFL2UyhRu8J9AAMfZAMGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707098769; c=relaxed/simple;
	bh=72Mp5Km391G5I9c0xcHLEHQKsivJywlaXaDcYG9JVnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxn8X4YT+BAKbShhlQM6JPQ2xq8WTDZQg+m7uG9P4fRXqEGdo99/IQmSkIdRYajteP4R/kjUGpEc1jzvQ5xXdM+f/9gUk0E1XBdz3GuxBV6gN/F5w0I3vTr2TBPcX3i5v5NSHVog6PBId1+Us2PdmlnRxbX9vDOgFY9jilLZf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWZcksxu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so34450165ad.3;
        Sun, 04 Feb 2024 18:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707098767; x=1707703567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwBy5xwYDXg+JhcdUGchx202mCPMDEZkLQoSR/Z/AEQ=;
        b=lWZcksxuZhobs24fFp48WAVBJeBVi0cUokjVrHKrcOp3/oWYizLZARdMN1mtxDG51a
         OZ27l2/kKYBD+qzJ6+KxQ3HR7yvxjmC7qXUMXyT/wGO830LGWeowdA9B5JdO4yYezMDw
         ZT2m5X02ysPzNrv8yY7bOIyL5QFgxprHWoVjJzuNW3flxCm9A23HW0ct3T3P6tZxBRcE
         Hytw/bKXlom9HfelN+29RXtst0/VbTsFrFrxKlfyvLPJffowcKb423mw3nQSlJ16Qao1
         hfhjskHyTHvaWg/dQmJuViAcUkw2SrEVJg87bkQhu9TPJWMcmmeN+jWcTaoYmgmTk1I4
         TV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707098767; x=1707703567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwBy5xwYDXg+JhcdUGchx202mCPMDEZkLQoSR/Z/AEQ=;
        b=S0FMBpoBupyc48zJY0IWVm6YfsN+O+j9ucxZ42NtmIwAJSMnf84hI0GQzfdJyhBzRi
         ZUKs34W/yeyVrDWKhz2GlkIVs3hq8GM5v6vDiPGvG/tueMC4iAi4a1CHE4FT6E79GMad
         BymJWwREC5nEma+In5zBYjzKkW/CBYsIy0gS3EZ+QvBKr6vhbxazwdt3soZu83THQ/By
         54F0+zsz8gGeLoEeRsPTR6cjTo562Lk+KKJ8l1fYhKuWW0hLEkQ469ixhMsuvLAZ76aq
         e/uRW9Nmk4MaGgDGL2vDSErh2dAnsJB2S/SkWCShhITPXOKaReLYT2p0Kt2L8ddVYGy5
         XbTw==
X-Gm-Message-State: AOJu0Ywr16E9PlSFvWH3z2bAcyLLDm0u2IqC/tCm+UaZwtr2iScAitr6
	DJi5Wx4iZN7cZdjgwOmcm5GXa01MWmFd2013VKalolMKxvYtplKv
X-Google-Smtp-Source: AGHT+IET1mJI83C9OIp7iAuyP68jh/Ii0202M6Di6DAzLb7rGa7+7lMqVdfgGukYWvaRAVCvnPs2tA==
X-Received: by 2002:a17:902:76c7:b0:1d9:5596:ffe8 with SMTP id j7-20020a17090276c700b001d95596ffe8mr9490543plt.66.1707098767248;
        Sun, 04 Feb 2024 18:06:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVTFzBviBlJ1jR9YRA8eQ2WMWA1/ZW8jPHvFMnu7Q4Sv9AbkjrarTTNzoSd12uu9dtPhAaop+d7DCne7U03yAO9bS7TCj+CfVmHDrCci3qnI8C/lBK/HU+9/CoQcwqa42m10vmF+DbDLc1JwIXTPDY15IkIaIHyAL6UOJ6Gsm/BHzkjYoSNyCbG7+mFtAUggHtzE8kv1YRohZdtU7RiJgvp
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902e2c500b001d974ffa1fcsm4674292plc.173.2024.02.04.18.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:06:06 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id E4702180EC46F; Mon,  5 Feb 2024 09:06:02 +0700 (WIB)
Date: Mon, 5 Feb 2024 09:06:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Mike Beaton <mjsbeaton@gmail.com>,
	Linux EFI <linux-efi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ivan Hu <ivan.hu@canonical.com>,
	Jeremy Kerr <jk@ozlabs.org>, Peter Jones <pjones@redhat.com>
Subject: Re: Broken section alignment in 6.7 and 6.8rc EFI stub
Message-ID: <ZcBCiqOroolz1hoh@archie.me>
References: <CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7o0GjoQloJffUDX7"
Content-Disposition: inline
In-Reply-To: <CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com>


--7o0GjoQloJffUDX7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 12:08:00AM +0000, Mike Beaton wrote:
> Good evening.
>=20
> Linux kernels from 6.7 upwards (including 6.8rc) appear to have broken
> PE section alignment in their EFI stub.
>=20
> Up to 6.6, we see monotonically increasing and contiguous VMA and LMA,
> as  expected for a well-formed PE/COFF file.
>=20
> In 6.7 and 6.8 these addresses basically jump around all over the place.
>=20
> At least one loader which is believed to be enforcing strong but
> reasonable rules on PE section layout refuses to load these:
> https://github.com/acidanthera/bugtracker/issues/2371#issuecomment-192580=
1292
>=20
> objdumps of some example kernels (two good, three bad) follow:
>=20
> $ objdump -h vmlinuz-5.15.0-92-generic
>=20
> vmlinuz-5.15.0-92-generic:     file format pei-x86-64
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>   0 .setup        00003bc0  0000000001000200  0000000001000200  00000200 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   1 .reloc        00000020  0000000001003dc0  0000000001003dc0  00003dc0 =
 2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .compat       00000020  0000000001003de0  0000000001003de0  00003de0 =
 2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   3 .text         00b0f4c0  0000000001003e00  0000000001003e00  00003e00 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> $ objdump -h vmlinuz-6.6.11-zabbly+
>=20
> vmlinuz-6.6.11-zabbly+:     file format pei-x86-64
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>   0 .setup        00003dc0  0000000001000200  0000000001000200  00000200 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   1 .reloc        00000020  0000000001003fc0  0000000001003fc0  00003fc0 =
 2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .compat       00000020  0000000001003fe0  0000000001003fe0  00003fe0 =
 2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   3 .text         00d6e400  0000000001004000  0000000001004000  00004000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
> $ objdump -h vmlinuz-6.7.3-3-liquorix-amd64
>=20
> vmlinuz-6.7.3-3-liquorix-amd64:     file format pei-x86-64
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>   0 .setup        00003000  0000000000001000  0000000000001000  00001000 =
 2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   1 .compat       00000008  0000000000c0e000  0000000000c0e000  00004000 =
 2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .text         00baa000  0000000000005000  0000000000005000  00005000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   3 .data         00001200  0000000000baf000  0000000000baf000  00baf000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, DATA
> $ objdump -h vmlinuz-6.7.3-zabbly+
>=20
> vmlinuz-6.7.3-zabbly+:     file format pei-x86-64
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>   0 .setup        00003000  0000000000001000  0000000000001000  00001000 =
 2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   1 .compat       00000008  0000000000df0000  0000000000df0000  00004000 =
 2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .text         00d84000  0000000000005000  0000000000005000  00005000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   3 .data         00001200  0000000000d89000  0000000000d89000  00d89000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, DATA
> $ objdump -h vmlinuz-6.8.0-0.rc3.225.vanilla.fc39.x86_64
>=20
> vmlinuz-6.8.0-0.rc3.225.vanilla.fc39.x86_64:     file format pei-x86-64
>=20
> Sections:
> Idx Name          Size      VMA               LMA               File off =
 Algn
>   0 .setup        00003000  0000000000001000  0000000000001000  00001000 =
 2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   1 .compat       00000008  0000000000e8b000  0000000000e8b000  00004000 =
 2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   2 .text         00e1f000  0000000000005000  0000000000005000  00005000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, READONLY, CODE
>   3 .data         00001200  0000000000e24000  0000000000e24000  00e24000 =
 2**4
>                   CONTENTS, ALLOC, LOAD, DATA
> $

So v6.7 onwards misses .reloc section, right?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--7o0GjoQloJffUDX7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZcBChQAKCRD2uYlJVVFO
o4w9AP9xMY/O9TuiKf2JgeY2804jn2jrCJ8Zi5GLokzRyglekAD+NqQv8VgcxviL
1ge5j+G6WydDvUJmVd5j6g3BLLebvg8=
=Sv10
-----END PGP SIGNATURE-----

--7o0GjoQloJffUDX7--

