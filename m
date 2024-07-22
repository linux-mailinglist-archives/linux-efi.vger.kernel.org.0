Return-Path: <linux-efi+bounces-1476-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEB939655
	for <lists+linux-efi@lfdr.de>; Tue, 23 Jul 2024 00:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376001F20CCA
	for <lists+linux-efi@lfdr.de>; Mon, 22 Jul 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F8049641;
	Mon, 22 Jul 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2m+7L3g"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47EB4963D;
	Mon, 22 Jul 2024 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686482; cv=none; b=ARmkj4tc8Rvm2AwlMU8YAlDAzbQT8dgL4NF1XYleEh8agRNzf4S8CYda87AJ5Z25rf9J2Xcqzg1keR/SlSvaSwp5aYd58EU83UwCLqi2ZFBd9BM5oBsWMZG2yussKsiA2zUJ3GI+pj7XdSJvaJTNrNluRmg/CZrnh4l8Ug7yF+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686482; c=relaxed/simple;
	bh=Jgmyw4r1hTvfrHmVFdlwtVqOx4dBD6X3d4dEdsO2pXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5Ty59SCRwuz0FLsWyVFSYVGBxR1syjO2+mwkEiZ/M358nz2ktmsSrVuEUg1T9Jm3Nmb0FFeBklI3HJtDbNv0hcr1u4kHBQkgdu3fzJb2klu+5mOuQn6Vivv1CsWytsnZiu18/dZUS0jQgeH/25svVm+G9tCHutqDHafMOiR53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2m+7L3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46859C4AF10;
	Mon, 22 Jul 2024 22:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721686482;
	bh=Jgmyw4r1hTvfrHmVFdlwtVqOx4dBD6X3d4dEdsO2pXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u2m+7L3g7fIokE3qxZL2ebzvJO7F3sAbzQojsyTUotcxb12wN1LnXEfW2HfuD4tVT
	 O8qf5xqC3wnQtRsA7lBav39Z7FwZsSanzTaExmSZquKrN3QCIE6iIRh9Z7sQPNo9ii
	 eUQCpEVDPZDFcQkr6jVU9j/hH2Ow3eIA71uHFlT+qePe+AvSvdBMOKIMLlhBE8gpl6
	 2HHTTmr/f4G1mMPJBIPhAiOaGxvv9nnv3+z46M+h39DqV7ScwikX1POgiJJgwY0ch4
	 62ytocgp7Hd2XpPS7dA9fK54gpECIpmbByLj+M+zyf/ZO+oM8EieysKi5GsxF2cw8D
	 bXg8KGc843lMQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so2267140e87.2;
        Mon, 22 Jul 2024 15:14:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc+NZ1z0JPwj6reNGC/KikYWa9NEiR+tUfpq9V/tteWJvKY2i1C3SgaaLgUemR4o7v5RBimjSRxkdFx/vA7IwyWaWiFSx4Dunam8W9
X-Gm-Message-State: AOJu0YzgFWtYBZmyRojyposTE6yNJZvV0CaKbwDMx1cm35yUxJFUA2ru
	IPBV1KUY0cPxZfanogB7AK+K6TTOyjYt/UmY9GEwMYRA9Rsy1ibygSDYb32+4MhkcZu0bF9fF3D
	1cTEmuunJGGK/Ap3EwsETmuQno8A=
X-Google-Smtp-Source: AGHT+IHAn2/WwFGgmciXyJ+SkgPaePaYXDpeZImlbBDYaQjv4ZkkBCoW0NyGUjfUOPaJWKbmh+BmdrWrPMgTUtNcLng=
X-Received: by 2002:a05:6512:e88:b0:52c:881b:73c0 with SMTP id
 2adb3069b0e04-52fc4046a8fmr751322e87.17.1721686480596; Mon, 22 Jul 2024
 15:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DS7PR19MB570996A580C6F5D2C9CACCE48BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <DS7PR19MB5709B2A263E769B461091B0D8BA32@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHBSNxrzbQoaDea7HFcjN9HHk5==tXg1WLHDzW61aj4cg@mail.gmail.com>
 <DS7PR19MB5709B39C90153DAA27DA122D8BAE2@DS7PR19MB5709.namprd19.prod.outlook.com>
 <CAMj1kXHS0rr9DfKCeD-Zz7y1Bk-3ncn2cEgVmnWE0Jq1B=+Acg@mail.gmail.com> <DS7PR19MB570924EC5BB1BA3F321A65B98BA82@DS7PR19MB5709.namprd19.prod.outlook.com>
In-Reply-To: <DS7PR19MB570924EC5BB1BA3F321A65B98BA82@DS7PR19MB5709.namprd19.prod.outlook.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 23 Jul 2024 00:14:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFjWBpOij5V3=-9etqTW9p8guqPDCGU3DK0Yxq6zrBiBQ@mail.gmail.com>
Message-ID: <CAMj1kXFjWBpOij5V3=-9etqTW9p8guqPDCGU3DK0Yxq6zrBiBQ@mail.gmail.com>
Subject: Re: [Patch] Do not clear BSS region in x86 stub
To: "Shao, Marshall" <Marshall.Shao@dell.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"Mishra, Ashish" <Ashish.Mishra4@dell.com>, "Chia, Jia Yuan" <JiaYuan.Chia@dell.com>, 
	"Dion, Christopher" <Christopher.Dion@dell.com>, "Caisse, Joe" <Joe.Caisse@dell.com>, 
	"Mukundan, Govind" <Govind.Mukundan@dell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jul 2024 at 13:48, Shao, Marshall <Marshall.Shao@dell.com> wrote=
:
>
> Hi Ard,
>
> > Given that GRUB now supports the native EFI entrypoint properly,
> > the handover protocol is essentially deprecated.
>
> In my case, the systemd-boot jumped into the EFI stub code via
> handover protocol, this may not be an orthodox way to boot the kernel
> but it performs well on the others, I have tested on at least
> 6 firmware.
>

systemd-boot does not implement the EFI handover protocol.
systemd-stub does implement it (for UKIs) but only for kernel versions
v5.8 or older.

The EFI handover protocol is known to be problematic as the loaders
often fail to allocate memory for the entire image, and only allocate
enough pages to load the bzImage itself.

This means that clearing BSS will wipe unrelated memory if the region
after the image happens to be used already. It also means that not
clearing BSS is just a crutch, and the correct fix is to ensure that
systemd-stub allocates the correct number of pages, and clears the
ones that are not covered by the bzImage payload.

> I understand that the handover protocol is going to be deprecated.
> However, as of now, I can't guarantee which EFI loader will be
> used to load my bzImage. Although it=E2=80=99s not very common, booting
> from the handover protocol with uncleaned BSS memory is possible.
>

systemd-boot does not use the EFI handover protocol. Please try to
determine where this confusion comes from: are you using a UKI image
perhaps?

> >> memset(_bss+0x10000, 0, _ebss - _bss - 0x10000)
>
> > So now you are applying the memset only to part of BSS, right? How
> > does this help?
>
> This part doesn't work without increasing the BOOT_STACK_SIZE.
>

... because the 0x10000 value would be incorrect otherwise?

I am trying to understand *why* this particular change works around
the issue. Please elaborate.

My preliminary conclusion here is that your implementation of the EFI
handover protocol (which I fail to understand where it comes from) is
not allocating enough memory. This should be fixed on the bootloader
side, as not clearing the BSS does not prevent this memory from being
corrupted.

