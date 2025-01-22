Return-Path: <linux-efi+bounces-2708-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E9A19107
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1E616597D
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jan 2025 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E6212B00;
	Wed, 22 Jan 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkF906jy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB4211A31;
	Wed, 22 Jan 2025 11:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547031; cv=none; b=eGWG8yv/lQWcSdU4HS+svBySLtF8GW6HZrLpowoTm8+7cJLog2cHHMRPa1itweplqjonOxNuFOU0WBdSFvhh71CqWRcA8GjxnSQ4EZ6sccsXDKMTtNKb9Kk0SFH6gy1X+NRt4SgcczE4JOQ5UIG5wET62GHdjRAoWVZrQli9kSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547031; c=relaxed/simple;
	bh=PUOHKYXNTprV5K3O4d1NRcv92tlFqPEk0mLydDcYnwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7Cf2C7SyCThVCuxhhXRunV7dDwron7WaIR2BuEsN5Lfq3WsHOL8fcqpLY4PGuFxZGKzw6/AYXYxrLxTrEHALStN21/kzuPf3eFPo/4VpZD6BW+fhBM09kvKHlr+ZBWbexEiKuyGUYBeWk3CLULbddjRytZTVsb6xYowuQII9vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkF906jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619F5C4CEE0;
	Wed, 22 Jan 2025 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737547030;
	bh=PUOHKYXNTprV5K3O4d1NRcv92tlFqPEk0mLydDcYnwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GkF906jyYfOXpD9j6p+HUd26ImtsQ+rxLOppaJbdERuYzyIbqsXmCA5PpZX+FUunZ
	 6IJ0NPLrtFBga/+wCC8oatC93yXQ4/WFGnsX4/7RsAnPv59ER5h0fVnZtfdhmIbS7W
	 QjAv8xCCADSLeDhawwev5TyHMc0ba+7aJkA1EjgMDhM5zGkaARM+lqG1rc8yIA6Xav
	 enkWIG+2ztk9r7GAyCUrDhC5gxLHAtNYwTR0p+0aN1PH+Klhgiyg4B/nliqe1DuUT0
	 /7w7Rm1xSAa9ExHKD8uy+ZGB5vvA12wfC+SeQghguy4G64p9WHtXksw8ZRtHmAqkRy
	 uFJ/HUkZKO+aQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30225b2586cso8528231fa.0;
        Wed, 22 Jan 2025 03:57:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUAMh9RoRypRjeAwAGIDFJ5A3aNi1cTAPW/NgkVax9YftK7an7jdw2LEPVBbjMntBuhJBN54jCiQc5PKCh9@vger.kernel.org, AJvYcCVj5rXYgmpVU24vyStcG4AlJ6s3VT/jqRZ2djB3BTGv4llms4eHk7tAsf8jtBeNiOuG5GUC9HYx3NU=@vger.kernel.org, AJvYcCWZYsvvipdA6xa8EMZQXkt+sfcYLaABipdmNgkAqVY6vNM1G5vWSgP8HOOGEHWihKoSZsPaPslM@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIvSnPT5o9tsgwULKrNe6AhABqocE7nPdI4M5fcsNwbSOLk3X
	0QFR9ph+GOaLDPhLpZtMqx5bc6qUgT0qzwECzWM7Egcax+u5AviCy2QPpzZ/FdyhNn3jEirO1EZ
	rB/QfpChGHSVUt22uG8Sg+SOls5M=
X-Google-Smtp-Source: AGHT+IGxKEzgWHBoUgDhY+zvIyUzWh4NwOtqxN+H2vdYG0wl8WXtSes8rz/E8wAr+GYIRGf0Sv9r+V9q6agbL76E/AU=
X-Received: by 2002:a2e:be9f:0:b0:302:2cb3:bb1d with SMTP id
 38308e7fff4ca-3072d136284mr70866101fa.12.1737547028707; Wed, 22 Jan 2025
 03:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121-x86-use-std-consistently-gcc-15-v1-0-8ab0acf645cb@kernel.org>
 <20250121-x86-use-std-consistently-gcc-15-v1-2-8ab0acf645cb@kernel.org>
In-Reply-To: <20250121-x86-use-std-consistently-gcc-15-v1-2-8ab0acf645cb@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 22 Jan 2025 12:56:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEQs67X_uqvrJQu0jSegFSBzHiteau+riX_VUZi6AMKmg@mail.gmail.com>
X-Gm-Features: AbW1kvZ1nPsEqaF-DaP9Xszp1LWqGQB92wes1CkV8hR_AUrIRutD_VBT9moL4AE
Message-ID: <CAMj1kXEQs67X_uqvrJQu0jSegFSBzHiteau+riX_VUZi6AMKmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi: libstub: Use '-std=gnu11' to fix build with GCC 15
To: Nathan Chancellor <nathan@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Kees Cook <kees@kernel.org>, 
	Sam James <sam@gentoo.org>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, 
	stable@vger.kernel.org, 
	Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, Jakub Jelinek <jakub@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Jan 2025 at 02:12, Nathan Chancellor <nathan@kernel.org> wrote:
>
> GCC 15 changed the default C standard version to C23, which should not
> have impacted the kernel because it requests the gnu11 standard via
> '-std=3D' in the main Makefile. However, the EFI libstub Makefile uses it=
s
> own set of KBUILD_CFLAGS for x86 without a '-std=3D' value (i.e., using
> the default), resulting in errors from the kernel's definitions of bool,
> true, and false in stddef.h, which are reserved keywords under C23.
>
>   ./include/linux/stddef.h:11:9: error: expected identifier before =E2=80=
=98false=E2=80=99
>      11 |         false   =3D 0,
>   ./include/linux/types.h:35:33: error: two or more data types in declara=
tion specifiers
>      35 | typedef _Bool                   bool;
>
> Set '-std=3Dgnu11' in the x86 cflags to resolve the error and consistentl=
y
> use the same C standard version for the entire kernel. All other
> architectures reuse KBUILD_CFLAGS from the rest of the kernel, so this
> issue is not visible for them.
>
> Cc: stable@vger.kernel.org
> Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
> Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGw=
tVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=3D@proto=
nmail.com/
> Reported-by: Jakub Jelinek <jakub@redhat.com>
> Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/firmware/efi/libstub/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi=
/libstub/Makefile
> index ed4e8ddbe76a..1141cd06011f 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -11,7 +11,7 @@ cflags-y                      :=3D $(KBUILD_CFLAGS)
>
>  cflags-$(CONFIG_X86_32)                :=3D -march=3Di386
>  cflags-$(CONFIG_X86_64)                :=3D -mcmodel=3Dsmall
> -cflags-$(CONFIG_X86)           +=3D -m$(BITS) -D__KERNEL__ \
> +cflags-$(CONFIG_X86)           +=3D -m$(BITS) -D__KERNEL__ -std=3Dgnu11 =
\
>                                    -fPIC -fno-strict-aliasing -mno-red-zo=
ne \
>                                    -mno-mmx -mno-sse -fshort-wchar \
>                                    -Wno-pointer-sign \
>


Thanks - I'll add this one to the EFI pile.

