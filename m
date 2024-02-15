Return-Path: <linux-efi+bounces-562-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 081038561DC
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 12:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8559B34417
	for <lists+linux-efi@lfdr.de>; Thu, 15 Feb 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229CD12A158;
	Thu, 15 Feb 2024 11:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNY77AMO"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63B0129A98;
	Thu, 15 Feb 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996560; cv=none; b=LviZ7ZvVxZu3pwSKvCkzfd4VfoNAPwIsMdeqQ2w5VyEZUQmYaF4zluSkp9iuN7ualY0wxtulhG2rPBQuhSrQtftHp/gqgQffezg26USO2YZ6Z5TRI2SHob4GWsBu6I1M2vsBnU9Bd4AoEV/Nao+zph1BXlFpyqnZe0BNLcbHMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996560; c=relaxed/simple;
	bh=sNDWxbnzSt+7R8+whUSN7cS25FatrSXjzq0Hxz64Los=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q1MkzYm/Jxg4RsLRW7BTV8fVV6mO7xJFRfnh+/U6koWMORLzGzFPQB1ggtmkpcfIx+fwCBSJtypDuP/r4YrX9P63zOCgPImIliwdy6WAAHvVwR2tCiHz6F/dF1PhuJEpWF5XJK2kxRvY8x9fagLx2EDDWbzOcnfj3wK8wbRDowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNY77AMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEDDC433A6;
	Thu, 15 Feb 2024 11:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707996559;
	bh=sNDWxbnzSt+7R8+whUSN7cS25FatrSXjzq0Hxz64Los=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RNY77AMOUp8KEz3lXuNMXyWWovBnV24cgAD2AccX5EBB5eznaswul63wSkV0Vo1he
	 lAG4CBwXTrlYJ7hsr2wV8VIn73qCJHNUNWOlNaCJdLFEl+Idwerj0qQ/D0kDd2Siwk
	 YxrEEJnDC/mvbx8Wq2ocGnl/V+H3vc69hvyKsRFhVWHG/KqXZ7DWMKIiGXLkDEA1I/
	 xahlQnxvw0IQmwzom/rvwNZQkwkGfj+LOzfINbetOBxQoXqZjhacXuLklBk2AV+Kso
	 mFL8Ua+5HXrUJg/R93IjW+9lapXs6yVMBRzfEECFMVom9mDqY9JvJmVInfgxUE0JeM
	 odVH5F8dW7IWA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511acd26c2bso997663e87.2;
        Thu, 15 Feb 2024 03:29:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9CXIltqCH78vy49hR/nYSqO+aOj6GulEWzF5jtL5gSjOv3aSpPThPM6ZRT1gNAmmvHy7FFeECgshqoSjYvxMx6l/rhalZQcUZ
X-Gm-Message-State: AOJu0YzZ6qPKQYGhIHvpmPB+NAedtYxGWLnYMM6ExwsWgbS60807QRWo
	JJKRYshRWm1EwFEYTsAwym6Ildq3IwL1gtvMptpfHMLYddMx+5tLQwBU/c8aUFY3x7kUdQXLrD7
	GdA1Z0BGp3HBjFC0nfuAY1n/RnD0=
X-Google-Smtp-Source: AGHT+IHDKSOzcv4CBxRcrEnBBg+SB9zlUN5zBFt30/bN3pbQhcgygMVhFKxL+syEPSfYVI3HcYf8TjIcD/xfnlkHDvQ=
X-Received: by 2002:a19:9156:0:b0:511:4e8c:7d02 with SMTP id
 y22-20020a199156000000b005114e8c7d02mr1261918lfj.48.1707996557861; Thu, 15
 Feb 2024 03:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXEGzHW07X963Q3q4VPEqUtKC==y152JyfuK_t=cZ0CKYA@mail.gmail.com>
 <2024021552-bats-tabby-a00b@gregkh> <CAMj1kXHVMDq670JhAwsYeGjYVVfgCxFC7YUChUF1GSerCUB1ow@mail.gmail.com>
 <2024021545-coconut-stylishly-26ed@gregkh>
In-Reply-To: <2024021545-coconut-stylishly-26ed@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 12:29:06 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG4HpAHYKwz27_Qy9_Wx+O_QJDmA4CBXcMrvVcrOXhBxw@mail.gmail.com>
Message-ID: <CAMj1kXG4HpAHYKwz27_Qy9_Wx+O_QJDmA4CBXcMrvVcrOXhBxw@mail.gmail.com>
Subject: Re: x86 efistub stable backports for v6.6
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, linux-efi <linux-efi@vger.kernel.org>, 
	jan.setjeeilers@oracle.com, Peter Jones <pjones@redhat.com>, 
	Steve McIntyre <steve@einval.com>, Julian Andres Klode <julian.klode@canonical.com>, 
	Luca Boccassi <bluca@debian.org>, James Bottomley <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 12:12, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Feb 15, 2024 at 10:41:57AM +0100, Ard Biesheuvel wrote:
> > On Thu, 15 Feb 2024 at 10:27, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Feb 15, 2024 at 10:17:20AM +0100, Ard Biesheuvel wrote:
> > > > (cc stakeholders from various distros - apologies if I missed anyone)
> > > >
> > > > Please consider the patches below for backporting to the linux-6.6.y
> > > > stable tree.
> > > >
> > > > These are prerequisites for building a signed x86 efistub kernel image
> > > > that complies with the tightened UEFI boot requirements imposed by
> > > > MicroSoft, and this is the condition under which it is willing to sign
> > > > future Linux secure boot shim builds with its 3rd party CA
> > > > certificate. (Such builds must enforce a strict separation between
> > > > executable and writable code, among other things)
> > > >
...
> > > And is this not an issue for 6.1.y as well?
> > >
> >
> > It is, but there are many more changes that would need to go into v6.1:
> >
> >  Documentation/x86/boot.rst                     |   2 +-
> >  arch/x86/Kconfig                               |  17 +
> >  arch/x86/boot/Makefile                         |   2 +-
> >  arch/x86/boot/compressed/Makefile              |  13 +-
> >  arch/x86/boot/compressed/efi_mixed.S           | 328 ++++++++++++++
> >  arch/x86/boot/compressed/efi_thunk_64.S        | 195 --------
> >  arch/x86/boot/compressed/head_32.S             |  38 +-
> >  arch/x86/boot/compressed/head_64.S             | 593 +++++--------------------
> >  arch/x86/boot/compressed/mem_encrypt.S         | 152 ++++++-
> >  arch/x86/boot/compressed/misc.c                |  61 ++-
> >  arch/x86/boot/compressed/misc.h                |   2 -
> >  arch/x86/boot/compressed/pgtable.h             |  10 +-
> >  arch/x86/boot/compressed/pgtable_64.c          |  87 ++--
> >  arch/x86/boot/compressed/sev.c                 | 112 +++--
> >  arch/x86/boot/compressed/vmlinux.lds.S         |   6 +-
> >  arch/x86/boot/header.S                         | 215 ++++-----
> >  arch/x86/boot/setup.ld                         |  14 +-
> >  arch/x86/boot/tools/build.c                    | 271 +----------
> >  arch/x86/include/asm/boot.h                    |   8 +
> >  arch/x86/include/asm/efi.h                     |  14 +-
> >  arch/x86/include/asm/sev.h                     |   7 +
> >  drivers/firmware/efi/libstub/Makefile          |   8 +-
> >  drivers/firmware/efi/libstub/alignedmem.c      |   5 +-
> >  drivers/firmware/efi/libstub/arm64-stub.c      |   6 +-
> >  drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
> >  drivers/firmware/efi/libstub/efistub.h         |  28 +-
> >  drivers/firmware/efi/libstub/mem.c             |   3 +-
> >  drivers/firmware/efi/libstub/randomalloc.c     |  13 +-
> >  drivers/firmware/efi/libstub/x86-5lvl.c        |  95 ++++
> >  drivers/firmware/efi/libstub/x86-stub.c        | 327 +++++++-------
> >  drivers/firmware/efi/libstub/x86-stub.h        |  17 +
> >  include/linux/efi.h                            |   1 +
> >  32 files changed, 1204 insertions(+), 1448 deletions(-)
> >
...
> > If you're happy to take these too, I can give you the proper list, but
> > perhaps we should deal with v6.6 first?
>
> Yeah, let's deal with 6.6 first :)
>
> What distros are going to need/want this for 6.1.y?  Will normal users
> care as this is only for a new requirement by Microsoft, not for older
> releases, right?
>

I will let the distro folks on cc answer this one.

